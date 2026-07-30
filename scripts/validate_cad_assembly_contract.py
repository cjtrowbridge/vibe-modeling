#!/usr/bin/env python3
"""Validate multipart CAD hierarchy, manifest coverage, views, and STL spans."""

import argparse
import json
import re
import struct
from pathlib import Path
from typing import Dict, Iterable, List, NoReturn, Optional, Set, Tuple


REPO_ROOT = Path(__file__).resolve().parent.parent
ID_RE = re.compile(r"^[a-z][a-z0-9_]*$")
SPLIT_POLICIES = {
    "continuous_across_seam",
    "left_owned",
    "right_owned",
    "separate_bridge",
    "intentionally_terminated",
}


def fail(message: str) -> NoReturn:
    raise SystemExit(f"[assembly-contract] ERROR: {message}")


def info(message: str) -> None:
    print(f"[assembly-contract] {message}")


def load_json(path: Path, label: str) -> dict:
    if not path.exists():
        fail(f"{label} not found: {path}")
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(f"Invalid {label.lower()} '{path}': {exc}")
    if not isinstance(data, dict):
        fail(f"{label} must be a JSON object: {path}")
    return data


def require_id(value, label: str) -> str:
    if not isinstance(value, str) or not ID_RE.fullmatch(value):
        fail(f"{label} must match {ID_RE.pattern}: {value!r}")
    return value


def require_vector(value, length: int, label: str) -> List[float]:
    if not isinstance(value, list) or len(value) != length:
        fail(f"{label} must be a {length}-element array.")
    result: List[float] = []
    for index, item in enumerate(value):
        if not isinstance(item, (int, float)):
            fail(f"{label}[{index}] must be numeric.")
        result.append(float(item))
    return result


def validate_transform(value, label: str) -> None:
    if not isinstance(value, dict):
        fail(f"{label} must be an object.")
    require_vector(value.get("translate"), 3, f"{label}.translate")
    require_vector(value.get("rotate"), 3, f"{label}.rotate")


def load_parts(path: Path) -> Tuple[Dict[int, str], Dict[str, int]]:
    data = load_json(path, "Parts manifest")
    if data.get("schema_version") != 1:
        fail(f"Unsupported parts manifest schema in: {path}")
    raw_parts = data.get("parts")
    if not isinstance(raw_parts, list) or not raw_parts:
        fail("Parts manifest requires a non-empty 'parts' array.")
    by_id: Dict[int, str] = {}
    by_name: Dict[str, int] = {}
    for index, part in enumerate(raw_parts):
        if not isinstance(part, dict):
            fail(f"parts[{index}] must be an object.")
        part_id = part.get("part_id")
        name = part.get("name")
        if not isinstance(part_id, int) or part_id < 0:
            fail(f"parts[{index}].part_id must be a non-negative integer.")
        require_id(name, f"parts[{index}].name")
        if part_id in by_id:
            fail(f"Duplicate printable part_id: {part_id}")
        if name in by_name:
            fail(f"Duplicate printable part name: {name}")
        by_id[part_id] = name
        by_name[name] = part_id
    return by_id, by_name


def validate_contract(contract: dict, part_ids: Dict[int, str]) -> dict:
    if contract.get("schema_version") != 1:
        fail("assembly.json schema_version must be 1.")
    primary = require_id(contract.get("primary_assembly"), "primary_assembly")
    dispatch_id = contract.get("review_dispatch_id")
    if not isinstance(dispatch_id, int) or dispatch_id < 0:
        fail("review_dispatch_id must be a non-negative integer.")

    raw_assemblies = contract.get("assemblies")
    if not isinstance(raw_assemblies, list) or not raw_assemblies:
        fail("assembly.json requires a non-empty 'assemblies' array.")
    assemblies: Dict[str, dict] = {}
    part_owners: Dict[int, str] = {}
    assembly_parents: Dict[str, str] = {}
    for index, assembly in enumerate(raw_assemblies):
        if not isinstance(assembly, dict):
            fail(f"assemblies[{index}] must be an object.")
        assembly_id = require_id(
            assembly.get("assembly_id"), f"assemblies[{index}].assembly_id"
        )
        if assembly_id in assemblies:
            fail(f"Duplicate assembly_id: {assembly_id}")
        role = assembly.get("role")
        if not isinstance(role, str) or not role.strip():
            fail(f"Assembly '{assembly_id}' requires a non-empty role.")
        members = assembly.get("members")
        if not isinstance(members, list) or not members:
            fail(f"Assembly '{assembly_id}' requires non-empty members.")
        assemblies[assembly_id] = assembly

    if primary not in assemblies:
        fail(f"primary_assembly is not declared: {primary}")

    for assembly_id, assembly in assemblies.items():
        for member_index, member in enumerate(assembly["members"]):
            label = f"assembly '{assembly_id}' member {member_index}"
            if not isinstance(member, dict):
                fail(f"{label} must be an object.")
            has_part = "part_id" in member
            has_assembly = "assembly_id" in member
            if has_part == has_assembly:
                fail(f"{label} must declare exactly one of part_id or assembly_id.")
            validate_transform(member.get("transform"), f"{label}.transform")
            if has_part:
                part_id = member["part_id"]
                if part_id not in part_ids:
                    fail(f"{label} references unknown printable part_id {part_id}.")
                if part_id in part_owners:
                    fail(
                        f"Printable part_id {part_id} appears in both "
                        f"'{part_owners[part_id]}' and '{assembly_id}'."
                    )
                part_owners[part_id] = assembly_id
            else:
                child = require_id(member["assembly_id"], f"{label}.assembly_id")
                if child not in assemblies:
                    fail(f"{label} references unknown assembly '{child}'.")
                if child in assembly_parents:
                    fail(
                        f"Assembly '{child}' has multiple parents: "
                        f"'{assembly_parents[child]}' and '{assembly_id}'."
                    )
                assembly_parents[child] = assembly_id

    if primary in assembly_parents:
        fail(f"Primary assembly '{primary}' cannot have a parent.")
    orphaned = sorted(set(assemblies) - {primary} - set(assembly_parents))
    if orphaned:
        fail("Assemblies are unreachable from the primary assembly: " + ", ".join(orphaned))

    visiting: Set[str] = set()
    visited: Set[str] = set()

    def visit(assembly_id: str) -> None:
        if assembly_id in visiting:
            fail(f"Assembly hierarchy contains a cycle at '{assembly_id}'.")
        if assembly_id in visited:
            return
        visiting.add(assembly_id)
        for member in assemblies[assembly_id]["members"]:
            if "assembly_id" in member:
                visit(member["assembly_id"])
        visiting.remove(assembly_id)
        visited.add(assembly_id)

    visit(primary)
    missing_parts = sorted(set(part_ids) - set(part_owners))
    if missing_parts:
        fail(
            "Printable parts missing from the assembly hierarchy: "
            + ", ".join(f"{part_id}:{part_ids[part_id]}" for part_id in missing_parts)
        )

    raw_interfaces = contract.get("interfaces")
    if not isinstance(raw_interfaces, list) or not raw_interfaces:
        fail("assembly.json requires a non-empty 'interfaces' array.")
    interface_ids: Set[str] = set()
    for index, interface in enumerate(raw_interfaces):
        if not isinstance(interface, dict):
            fail(f"interfaces[{index}] must be an object.")
        interface_id = require_id(interface.get("interface_id"), f"interfaces[{index}].interface_id")
        if interface_id in interface_ids:
            fail(f"Duplicate interface_id: {interface_id}")
        interface_ids.add(interface_id)
        owner = require_id(interface.get("owner_assembly"), f"interface '{interface_id}'.owner_assembly")
        if owner not in assemblies:
            fail(f"Interface '{interface_id}' has unknown owner assembly '{owner}'.")
        interface_type = interface.get("type")
        if not isinstance(interface_type, str) or not interface_type.strip():
            fail(f"Interface '{interface_id}' requires a non-empty type.")
        policy = interface.get("split_policy")
        if policy not in SPLIT_POLICIES:
            fail(f"Interface '{interface_id}' has unsupported split_policy: {policy!r}")
        validate_transform(interface.get("local_frame"), f"interface '{interface_id}'.local_frame")
        engages = interface.get("engages_parts")
        if not isinstance(engages, list) or not engages:
            fail(f"Interface '{interface_id}' requires non-empty engages_parts.")
        unknown = [name for name in engages if name not in part_ids.values()]
        if unknown:
            fail(f"Interface '{interface_id}' engages unknown parts: {unknown}")
        if interface_type == "ten_inch_rack_module":
            if not isinstance(interface.get("height_u"), int) or interface["height_u"] <= 0:
                fail(f"Rack interface '{interface_id}' requires positive integer height_u.")
            if len(set(engages)) < 2:
                fail(f"Rack interface '{interface_id}' must engage at least two printable receiver parts.")
            if policy != "continuous_across_seam":
                fail(f"Rack interface '{interface_id}' must be continuous_across_seam.")

    raw_views = contract.get("views")
    if not isinstance(raw_views, list) or not raw_views:
        fail("assembly.json requires a non-empty 'views' array.")
    views: Set[str] = set()
    for index, view in enumerate(raw_views):
        if not isinstance(view, dict):
            fail(f"views[{index}] must be an object.")
        name = require_id(view.get("name"), f"views[{index}].name")
        if name in views:
            fail(f"Duplicate assembly review view: {name}")
        views.add(name)
        if view.get("projection") not in {"o", "p"}:
            fail(f"View '{name}' projection must be 'o' or 'p'.")
        require_vector(view.get("camera"), 7, f"view '{name}'.camera")
        if not isinstance(view.get("assembly_view"), str):
            fail(f"View '{name}' requires assembly_view.")
        if not isinstance(view.get("assembly_view_id"), int) or view["assembly_view_id"] < 0:
            fail(f"View '{name}' requires a non-negative integer assembly_view_id.")
        if not isinstance(view.get("show_proxies"), bool):
            fail(f"View '{name}' requires Boolean show_proxies.")

    view_sets = contract.get("view_sets")
    if not isinstance(view_sets, dict):
        fail("assembly.json requires view_sets.")
    for set_name in ("compact", "full"):
        selected = view_sets.get(set_name)
        if not isinstance(selected, list) or not selected:
            fail(f"view_sets.{set_name} must be a non-empty array.")
        missing = sorted(set(selected) - views)
        if missing:
            fail(f"view_sets.{set_name} references unknown views: {missing}")
    if not set(view_sets["compact"]).issubset(set(view_sets["full"])):
        fail("view_sets.full must include every compact view.")

    exports = contract.get("geometry_exports", [])
    if not isinstance(exports, list):
        fail("geometry_exports must be an array when present.")
    export_names: Set[str] = set()
    for index, export in enumerate(exports):
        if not isinstance(export, dict):
            fail(f"geometry_exports[{index}] must be an object.")
        name = require_id(export.get("name"), f"geometry_exports[{index}].name")
        if name in export_names:
            fail(f"Duplicate geometry export name: {name}")
        export_names.add(name)
        if not isinstance(export.get("dispatch_id"), int):
            fail(f"Geometry export '{name}' requires integer dispatch_id.")
        minimum_span = export.get("minimum_span")
        if not isinstance(minimum_span, list) or len(minimum_span) != 3:
            fail(f"Geometry export '{name}' minimum_span must have three elements.")
        for axis, value in zip("xyz", minimum_span):
            if value is not None and (not isinstance(value, (int, float)) or value < 0):
                fail(f"Geometry export '{name}' minimum_span {axis} is invalid.")

    return {
        "primary": primary,
        "assemblies": assemblies,
        "interfaces": raw_interfaces,
        "views": raw_views,
        "view_sets": view_sets,
        "geometry_exports": exports,
    }


def stl_vertices(path: Path) -> Iterable[Tuple[float, float, float]]:
    data = path.read_bytes()
    if len(data) >= 84:
        count = struct.unpack_from("<I", data, 80)[0]
        if 84 + count * 50 == len(data):
            for triangle in range(count):
                offset = 84 + triangle * 50 + 12
                for vertex in range(3):
                    yield struct.unpack_from("<fff", data, offset + vertex * 12)
            return
    text = data.decode("utf-8", errors="ignore")
    pattern = re.compile(
        r"\bvertex\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)"
    )
    matches = pattern.findall(text)
    if not matches:
        fail(f"Could not read STL vertices: {path}")
    for match in matches:
        yield tuple(float(value) for value in match)  # type: ignore[return-value]


def stl_bounds(path: Path) -> Tuple[List[float], List[float]]:
    vertices = list(stl_vertices(path))
    if not vertices:
        fail(f"STL has no vertices: {path}")
    minimum = [min(vertex[axis] for vertex in vertices) for axis in range(3)]
    maximum = [max(vertex[axis] for vertex in vertices) for axis in range(3)]
    return minimum, maximum


def validate_geometry_exports(exports: List[dict], artifact_dir: Path) -> None:
    for export in exports:
        path = artifact_dir / f"{export['name']}.stl"
        if not path.exists():
            fail(f"Required independent geometry export is missing: {path}")
        minimum, maximum = stl_bounds(path)
        span = [maximum[index] - minimum[index] for index in range(3)]
        for index, required in enumerate(export["minimum_span"]):
            if required is not None and span[index] + 1e-6 < float(required):
                fail(
                    f"Geometry export '{export['name']}' {('x','y','z')[index]} span "
                    f"{span[index]:.3f} mm is below required {float(required):.3f} mm."
                )
        info(
            f"Geometry {export['name']}: bounds min={minimum}, max={maximum}, "
            f"span={[round(value, 3) for value in span]}"
        )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--design", required=True, help="Design directory name under designs/.")
    parser.add_argument("--assembly", help="Override designs/<design>/assembly.json.")
    parser.add_argument("--parts-manifest", help="Override designs/<design>/parts.json.")
    parser.add_argument("--config", help="Optional candidate config to validate as JSON.")
    parser.add_argument("--artifact-dir", help="Optional directory containing independent geometry-export STLs.")
    args = parser.parse_args()

    design_root = REPO_ROOT / "designs" / args.design
    assembly_path = Path(args.assembly) if args.assembly else design_root / "assembly.json"
    parts_path = Path(args.parts_manifest) if args.parts_manifest else design_root / "parts.json"
    part_ids, _ = load_parts(parts_path)
    contract = validate_contract(load_json(assembly_path, "Assembly contract"), part_ids)
    if args.config:
        load_json(Path(args.config), "Candidate config")
    if args.artifact_dir:
        validate_geometry_exports(contract["geometry_exports"], Path(args.artifact_dir))
    info(
        f"PASS design={args.design} primary={contract['primary']} "
        f"assemblies={len(contract['assemblies'])} parts={len(part_ids)} "
        f"interfaces={len(contract['interfaces'])} views={len(contract['views'])}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
