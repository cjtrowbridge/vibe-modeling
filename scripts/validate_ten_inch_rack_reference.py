#!/usr/bin/env python3
"""Validate the preserved ten-inch-rack reference package.

The Markdown specification is authoritative. This checker verifies package
integrity and the mechanically checkable synchronization promises made by its
JSON and OpenSCAD companions. It does not make the companions authoritative.
"""

import argparse
import hashlib
import json
import math
import re
import sys
from pathlib import Path
from typing import Any, Dict, Iterable, List, Mapping, Sequence, Tuple


DEFAULT_REFERENCE_ROOT = (
    Path(__file__).resolve().parents[1]
    / "references"
    / "engineering"
    / "ten_inch_rack"
    / "v2.0.0"
)

REQUIREMENT_FAMILIES = {
    "RACK-SCOPE": 7,
    "RACK-GEO": 10,
    "VOCAB": 6,
    "FAST-M3": 14,
    "DEPTH": 18,
    "CLR": 15,
    "STRUCT": 10,
}


class ValidationError(Exception):
    """Raised when a reference-package contract is not satisfied."""


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def load_json(path: Path) -> Dict[str, Any]:
    try:
        with path.open("r", encoding="utf-8") as source:
            value = json.load(source)
    except (OSError, json.JSONDecodeError) as exc:
        raise ValidationError("could not read valid JSON from {}: {}".format(path, exc))
    if not isinstance(value, dict):
        raise ValidationError("expected a JSON object in {}".format(path))
    return value


def read_utf8(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as exc:
        raise ValidationError("could not read UTF-8 text from {}: {}".format(path, exc))


def nested_value(data: Mapping[str, Any], keys: Sequence[str]) -> Any:
    value: Any = data
    for key in keys:
        if not isinstance(value, Mapping) or key not in value:
            raise ValidationError("missing JSON value: {}".format(".".join(keys)))
        value = value[key]
    return value


def front_matter_value(markdown: str, key: str) -> str:
    match = re.search(r"^{}:\s*(.+?)\s*$".format(re.escape(key)), markdown, re.MULTILINE)
    if not match:
        raise ValidationError("Markdown front matter is missing {!r}".format(key))
    return match.group(1).strip().strip('"\'')


def scad_numbers(scad: str) -> Dict[str, float]:
    values: Dict[str, float] = {}
    pattern = re.compile(
        r"^\s*([A-Z][A-Z0-9_]*)\s*=\s*([-+]?(?:\d+(?:\.\d*)?|\.\d+))\s*;",
        re.MULTILINE,
    )
    for name, raw_value in pattern.findall(scad):
        values[name] = float(raw_value)
    return values


def expected_requirement_ids() -> List[str]:
    return [
        "{}-{:03d}".format(family, number)
        for family, count in REQUIREMENT_FAMILIES.items()
        for number in range(1, count + 1)
    ]


def defined_requirement_ids(markdown: str) -> List[str]:
    family_expression = "|".join(re.escape(family) for family in REQUIREMENT_FAMILIES)
    pattern = re.compile(
        r"^\s*-\s+\*\*(?P<id>(?:{})-\d{{3}})(?:\s|:)".format(family_expression),
        re.MULTILINE,
    )
    return [match.group("id") for match in pattern.finditer(markdown)]


def require_equal(label: str, actual: Any, expected: Any) -> None:
    if actual != expected:
        raise ValidationError(
            "{} mismatch: expected {!r}, found {!r}".format(label, expected, actual)
        )


def require_close(label: str, actual: Any, expected: Any) -> None:
    if isinstance(actual, bool) or not isinstance(actual, (int, float)):
        raise ValidationError("{} is not numeric: {!r}".format(label, actual))
    if not math.isclose(float(actual), float(expected), rel_tol=0.0, abs_tol=1e-9):
        raise ValidationError(
            "{} mismatch: expected {!r}, found {!r}".format(label, expected, actual)
        )


def validate_hashes(root: Path, manifest: Mapping[str, Any]) -> None:
    files = nested_value(manifest, ("source_files",))
    if not isinstance(files, Mapping) or not files:
        raise ValidationError("manifest source_files must be a non-empty object")
    for filename, metadata in files.items():
        if not isinstance(filename, str) or not isinstance(metadata, Mapping):
            raise ValidationError("manifest source_files contains an invalid entry")
        expected_hash = metadata.get("sha256")
        path = root / filename
        if not path.is_file():
            raise ValidationError("manifest source file is missing: {}".format(path))
        actual_hash = sha256_file(path)
        require_equal("SHA-256 for {}".format(filename), actual_hash, expected_hash)
    print("[rack-ref] PASS source hashes ({})".format(len(files)))


def validate_identity(
    manifest: Mapping[str, Any], parameters: Mapping[str, Any], markdown: str
) -> None:
    document_id = nested_value(manifest, ("document_id",))
    document_version = nested_value(manifest, ("document_version",))
    require_equal("Markdown doc_id", front_matter_value(markdown, "doc_id"), document_id)
    require_equal(
        "Markdown version", front_matter_value(markdown, "version"), document_version
    )
    require_equal("JSON doc_id", nested_value(parameters, ("doc_id",)), document_id)
    print("[rack-ref] PASS document identity ({}, v{})".format(document_id, document_version))


def validate_requirements(markdown: str) -> None:
    expected = expected_requirement_ids()
    actual = defined_requirement_ids(markdown)
    duplicates = sorted({item for item in actual if actual.count(item) > 1})
    missing = sorted(set(expected) - set(actual))
    unexpected = sorted(set(actual) - set(expected))
    if duplicates or missing or unexpected or len(actual) != len(expected):
        raise ValidationError(
            "requirement inventory mismatch; duplicates={}, missing={}, unexpected={}, "
            "expected_count={}, actual_count={}".format(
                duplicates, missing, unexpected, len(expected), len(actual)
            )
        )
    print("[rack-ref] PASS requirement inventory ({} IDs)".format(len(actual)))


def validate_companion_values(parameters: Mapping[str, Any], scad: str) -> None:
    constants = scad_numbers(scad)
    comparisons: Iterable[Tuple[str, Sequence[str]]] = (
        ("U_PITCH", ("rack_geometry", "u_pitch", "value")),
        ("RACK_FRONT_WIDTH_NOMINAL", ("rack_geometry", "rack_front_width_nominal", "value")),
        ("RAIL_HOLE_SPACING_X", ("rack_geometry", "rail_hole_spacing_x", "value")),
        ("RACK_CLEAR_OPENING_NOMINAL", ("rack_geometry", "rack_clear_opening_nominal", "value")),
        ("EQUIPMENT_WIDTH_MAX_BASELINE", ("rack_geometry", "equipment_width_max_baseline", "value")),
        ("M3_CLEARANCE_CLOSE_D", ("fastener", "finished_holes", "close")),
        ("M3_CLEARANCE_DEFAULT_D", ("fastener", "finished_holes", "default")),
        ("M3_CLEARANCE_COARSE_D", ("fastener", "finished_holes", "stackup")),
        ("M3_TAP_DRILL_D", ("fastener", "finished_holes", "tap_drill")),
        ("M3_WASHER_ID", ("fastener", "washer", "id")),
        ("M3_WASHER_OD", ("fastener", "washer", "od")),
        ("M3_WASHER_T", ("fastener", "washer", "thickness")),
        ("M3_WASHER_SEAT_D", ("fastener", "washer_seat_diameter", "default")),
        ("MIN_STRUCTURAL_OVERLAP", ("structural_baseline", "minimum_structural_overlap")),
        ("MIN_REMAINING_LIGAMENT", ("structural_baseline", "minimum_remaining_ligament")),
        ("MIN_PRIMARY_HOLE_RADIAL_MATERIAL", ("structural_baseline", "minimum_primary_hole_radial_material")),
        ("BOOLEAN_EPSILON", ("structural_baseline", "boolean_epsilon")),
    )
    checked = 0
    for constant_name, json_path in comparisons:
        if constant_name not in constants:
            raise ValidationError("OpenSCAD constant is missing: {}".format(constant_name))
        require_close(
            "{} / {}".format(constant_name, ".".join(json_path)),
            constants[constant_name],
            nested_value(parameters, json_path),
        )
        checked += 1

    sequence = nested_value(parameters, ("rack_geometry", "u_hole_sequence", "value"))
    if not isinstance(sequence, list) or len(sequence) != 3:
        raise ValidationError("rack_geometry.u_hole_sequence.value must contain 3 values")
    for constant_name, sequence_value in zip(("U_HOLE_A", "U_HOLE_B", "U_HOLE_C"), sequence):
        if constant_name not in constants:
            raise ValidationError("OpenSCAD constant is missing: {}".format(constant_name))
        require_close(constant_name, constants[constant_name], sequence_value)
        checked += 1
    require_close("U-hole sequence sum", sum(sequence), nested_value(parameters, ("rack_geometry", "u_pitch", "value")))

    require_equal(
        "rack_internal_depth.value",
        nested_value(parameters, ("rack_geometry", "rack_internal_depth", "value")),
        None,
    )
    require_equal(
        "rack_internal_depth.required",
        nested_value(parameters, ("rack_geometry", "rack_internal_depth", "required")),
        True,
    )
    print("[rack-ref] PASS companion synchronization ({} constants)".format(checked))
    print("[rack-ref] PASS rack_internal_depth remains a required project input")


def validate(reference_root: Path) -> None:
    root = reference_root.resolve()
    manifest_path = root / "bundle_manifest.json"
    manifest = load_json(manifest_path)
    authority_filename = nested_value(manifest, ("authority_file",))
    if not isinstance(authority_filename, str):
        raise ValidationError("manifest authority_file must be a filename")
    markdown = read_utf8(root / authority_filename)
    parameters = load_json(root / "10-inch-rack-parameters.json")
    scad = read_utf8(root / "rack_constants_and_assertions.scad")

    print("[rack-ref] reference root: {}".format(root))
    validate_hashes(root, manifest)
    validate_identity(manifest, parameters, markdown)
    validate_requirements(markdown)
    validate_companion_values(parameters, scad)
    print("[rack-ref] PASS ten-inch-rack reference package")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Validate the versioned ten-inch-rack engineering reference package."
    )
    parser.add_argument(
        "--reference-root",
        type=Path,
        default=DEFAULT_REFERENCE_ROOT,
        help="version directory containing bundle_manifest.json (default: %(default)s)",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        validate(args.reference_root)
    except ValidationError as exc:
        print("[rack-ref] FAIL {}".format(exc), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
