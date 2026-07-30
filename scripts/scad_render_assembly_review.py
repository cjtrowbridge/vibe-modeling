#!/usr/bin/env python3
"""Render and audit provenance-bound multipart OpenSCAD assembly evidence."""

import argparse
import datetime
import hashlib
import json
import shutil
import subprocess
import sys
import uuid
from pathlib import Path
from typing import Dict, Iterable, List, NoReturn, Set

import scad_build
import scad_build_all
import validate_cad_assembly_contract as assembly_contract


REPO_ROOT = Path(__file__).resolve().parent.parent
MANIFEST_NAME = "assembly_review_manifest.json"


def fail(message: str) -> NoReturn:
    raise SystemExit(f"[assembly-review] ERROR: {message}")


def info(message: str) -> None:
    print(f"[assembly-review] {message}")


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def artifact_records(directory: Path, names: Iterable[str]) -> List[dict]:
    return [
        {
            "path": name,
            "bytes": (directory / name).stat().st_size,
            "sha256": sha256_file(directory / name),
        }
        for name in sorted(names)
    ]


def expected_names(contract: dict, view_set: str) -> Set[str]:
    selected = set(contract["view_sets"][view_set])
    names = {f"{contract['primary']}_{name}.png" for name in selected}
    names.update(f"{item['name']}.stl" for item in contract["geometry_exports"])
    return names


def validate_exact_files(directory: Path, expected: Set[str]) -> None:
    actual = {
        path.relative_to(directory).as_posix()
        for path in directory.rglob("*")
        if path.is_file() and path.name != MANIFEST_NAME
    }
    missing = sorted(expected - actual)
    unexpected = sorted(actual - expected)
    if missing or unexpected:
        details: List[str] = []
        if missing:
            details.append("Missing:\n  " + "\n  ".join(missing))
        if unexpected:
            details.append("Unexpected:\n  " + "\n  ".join(unexpected))
        fail("Assembly-review artifact set mismatch.\n" + "\n".join(details))


def input_provenance(
    config_path: Path,
    parts_path: Path,
    assembly_path: Path,
    source_root: Path,
    printable_build: dict,
) -> dict:
    return {
        "config": {
            "path": scad_build_all.repo_relative(config_path),
            "sha256": sha256_file(config_path),
        },
        "parts_manifest": {
            "path": scad_build_all.repo_relative(parts_path),
            "sha256": sha256_file(parts_path),
        },
        "assembly_contract": {
            "path": scad_build_all.repo_relative(assembly_path),
            "sha256": sha256_file(assembly_path),
        },
        "source": {
            "path": scad_build_all.repo_relative(source_root),
            "sha256": scad_build_all.sha256_tree(source_root, (".scad",)),
            "main_scad": scad_build_all.repo_relative(source_root / "main.scad"),
        },
        "printable_build": printable_build,
        "git": scad_build_all.git_provenance(),
    }


def validate_manifest_inputs(manifest: dict, current: dict, view_set: str) -> None:
    if manifest.get("schema_version") != 1:
        fail("Unsupported assembly-review manifest schema.")
    if manifest.get("view_set") != view_set:
        fail(
            f"Review manifest view_set is {manifest.get('view_set')!r}, "
            f"expected {view_set!r}."
        )
    for key in ("config", "parts_manifest", "assembly_contract", "source", "printable_build"):
        recorded = manifest.get(key)
        if not isinstance(recorded, dict) or recorded.get("sha256") != current[key]["sha256"]:
            fail(f"Stale assembly review: {key} hash does not match current input.")


def printable_build_provenance(
    design: str,
    build_dir: Path,
    config_path: Path,
    parts_path: Path,
    source_root: Path,
) -> dict:
    manifest_path = build_dir / scad_build_all.BUILD_MANIFEST_NAME
    manifest = assembly_contract.load_json(manifest_path, "Complete build manifest")
    if manifest.get("schema_version") != 1 or manifest.get("build_scope") != "complete":
        fail(f"Printable build is not a complete manifest build: {manifest_path}")
    if manifest.get("design") != design:
        fail(f"Printable build design does not match {design}: {manifest_path}")

    current_hashes = {
        "config": sha256_file(config_path),
        "parts_manifest": sha256_file(parts_path),
        "source": scad_build_all.sha256_tree(source_root, (".scad",)),
    }
    for key, expected_hash in current_hashes.items():
        recorded = manifest.get(key)
        if not isinstance(recorded, dict) or recorded.get("sha256") != expected_hash:
            fail(f"Printable build is stale: {key} does not match current input.")

    records = manifest.get("artifacts")
    if not isinstance(records, list) or not records:
        fail(f"Printable build has no artifact records: {manifest_path}")
    by_path: Dict[str, dict] = {}
    expected = {scad_build_all.BUILD_MANIFEST_NAME}
    for record in records:
        if not isinstance(record, dict) or not isinstance(record.get("path"), str):
            fail(f"Printable build has an invalid artifact record: {manifest_path}")
        name = record["path"]
        if name in by_path:
            fail(f"Printable build has a duplicate artifact record: {name}")
        by_path[name] = record
        expected.add(name)
        path = build_dir / name
        if not path.exists():
            fail(f"Printable build artifact is missing: {path}")
        if path.stat().st_size != record.get("bytes") or sha256_file(path) != record.get("sha256"):
            fail(f"Printable build artifact hash or size mismatch: {path}")
    scad_build_all.validate_exact_artifacts(build_dir, expected)

    raw_parts = manifest.get("parts")
    if not isinstance(raw_parts, list) or not raw_parts:
        fail(f"Printable build has no part records: {manifest_path}")
    stl_records: List[dict] = []
    for part in raw_parts:
        if not isinstance(part, dict) or not isinstance(part.get("output_name"), str):
            fail(f"Printable build has an invalid part record: {manifest_path}")
        stl_name = f"{part['output_name']}.stl"
        record = by_path.get(stl_name)
        if record is None:
            fail(f"Printable build is missing the authoritative STL record: {stl_name}")
        stl_records.append(
            {
                "part_id": part.get("part_id"),
                "name": part.get("name"),
                "path": stl_name,
                "bytes": record.get("bytes"),
                "sha256": record.get("sha256"),
            }
        )

    return {
        "path": scad_build_all.repo_relative(manifest_path),
        "directory": scad_build_all.repo_relative(build_dir),
        "sha256": sha256_file(manifest_path),
        "counts": manifest.get("counts"),
        "stl_artifacts": stl_records,
    }


def run_command(command: List[str], dry_run: bool) -> None:
    info("Would run: " + scad_build.format_cmd(command) if dry_run else "Run: " + scad_build.format_cmd(command))
    if not dry_run:
        subprocess.run(command, check=True)


def safe_replace(staged: Path, final: Path, managed_root: Path) -> None:
    staged_resolved = staged.resolve()
    final_resolved = final.resolve()
    root_resolved = managed_root.resolve()
    for path in (staged_resolved, final_resolved):
        try:
            path.relative_to(root_resolved)
        except ValueError:
            fail(f"Refusing to manage path outside {root_resolved}: {path}")
        if path == root_resolved:
            fail(f"Refusing to replace managed root: {path}")
    if final.exists():
        shutil.rmtree(final)
    staged.rename(final)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--design", required=True)
    parser.add_argument("--config", required=True)
    parser.add_argument("--set", choices=("compact", "full"), default="full", dest="view_set")
    parser.add_argument(
        "--build-dir",
        help="Complete audited printable artifact directory; defaults to output/<design>.",
    )
    parser.add_argument("--openscad-path")
    parser.add_argument("--audit-only", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    design_root = REPO_ROOT / "designs" / args.design
    source_root = design_root / "src"
    main_scad = source_root / "main.scad"
    parts_path = design_root / "parts.json"
    assembly_path = design_root / "assembly.json"
    config_path = Path(args.config)
    if not config_path.is_absolute():
        config_path = (REPO_ROOT / config_path).resolve()
    if not main_scad.exists():
        fail(f"OpenSCAD entrypoint not found: {main_scad}")
    build_dir = Path(args.build_dir) if args.build_dir else REPO_ROOT / "output" / args.design
    if not build_dir.is_absolute():
        build_dir = (REPO_ROOT / build_dir).resolve()

    part_ids, _ = assembly_contract.load_parts(parts_path)
    raw_contract = assembly_contract.load_json(assembly_path, "Assembly contract")
    contract = assembly_contract.validate_contract(raw_contract, part_ids)
    base_config = assembly_contract.load_json(config_path, "Candidate config")
    printable_build = printable_build_provenance(
        args.design, build_dir, config_path, parts_path, source_root
    )
    provenance = input_provenance(
        config_path, parts_path, assembly_path, source_root, printable_build
    )
    review_root = REPO_ROOT / ".tmp" / "scad" / args.design
    final = review_root / "assembly-review"
    expected = expected_names(contract, args.view_set)

    if args.audit_only:
        manifest_path = final / MANIFEST_NAME
        manifest = assembly_contract.load_json(manifest_path, "Assembly review manifest")
        validate_manifest_inputs(manifest, provenance, args.view_set)
        validate_exact_files(final, expected)
        records = artifact_records(final, expected)
        if records != manifest.get("artifacts"):
            fail("Assembly-review artifact hashes or byte sizes do not match the manifest.")
        assembly_contract.validate_geometry_exports(contract["geometry_exports"], final)
        info(
            f"PASS audit design={args.design} set={args.view_set} "
            f"png={sum(name.endswith('.png') for name in expected)} "
            f"stl={sum(name.endswith('.stl') for name in expected)}"
        )
        return 0

    executable = scad_build.resolve_openscad_exe(args.openscad_path)
    stage = review_root / f".assembly-review-stage-{uuid.uuid4().hex}"
    if stage.exists():
        fail(f"Unexpected existing staging directory: {stage}")
    stage.mkdir(parents=True, exist_ok=False)

    selected_views = set(contract["view_sets"][args.view_set])
    try:
        for view in contract["views"]:
            if view["name"] not in selected_views:
                continue
            config = dict(base_config)
            config.update(
                {
                    "part_id": raw_contract["review_dispatch_id"],
                    "assembly_view": view["assembly_view"],
                    "assembly_view_id": view["assembly_view_id"],
                    "show_proxies": view["show_proxies"],
                }
            )
            out_path = stage / f"{contract['primary']}_{view['name']}.png"
            command = [
                executable,
                "-o",
                str(out_path),
                str(main_scad),
                "--imgsize=1200,900",
                f"--projection={view['projection']}",
                "--camera=" + ",".join(str(value) for value in view["camera"]),
                "--autocenter",
                "--viewall",
                "--render=true",
                *scad_build.build_defines(config),
            ]
            run_command(command, args.dry_run)

        for export in contract["geometry_exports"]:
            config = dict(base_config)
            config["part_id"] = export["dispatch_id"]
            out_path = stage / f"{export['name']}.stl"
            command = [
                executable,
                "-o",
                str(out_path),
                str(main_scad),
                *scad_build.build_defines(config),
            ]
            run_command(command, args.dry_run)

        if args.dry_run:
            shutil.rmtree(stage)
            info(f"Dry-run PASS design={args.design} set={args.view_set}")
            return 0

        validate_exact_files(stage, expected)
        assembly_contract.validate_geometry_exports(contract["geometry_exports"], stage)
        manifest = {
            "schema_version": 1,
            "design": args.design,
            "primary_assembly": contract["primary"],
            "view_set": args.view_set,
            "generated_at_utc": datetime.datetime.now(datetime.timezone.utc).isoformat(),
            **provenance,
            "counts": {
                "png": sum(name.endswith(".png") for name in expected),
                "stl": sum(name.endswith(".stl") for name in expected),
                "artifacts": len(expected),
            },
            "artifacts": artifact_records(stage, expected),
        }
        (stage / MANIFEST_NAME).write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
        safe_replace(stage, final, review_root)
        info(f"PASS rendered design={args.design} set={args.view_set} destination={final}")
        return 0
    except Exception:
        if stage.exists():
            shutil.rmtree(stage)
        raise


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        raise SystemExit(exc.returncode)
