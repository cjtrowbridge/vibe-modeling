#!/usr/bin/env python3
"""Build and audit every declared part for an OpenSCAD design."""

import argparse
import datetime
import hashlib
import json
import re
import shutil
import subprocess
import sys
import uuid
from pathlib import Path
from typing import Iterable, List, NoReturn, Optional, Set, Tuple

import scad_build


REPO_ROOT = Path(__file__).resolve().parent.parent
REVISION_RE = re.compile(r"^rev_\d{4}$")
BUILD_MANIFEST_NAME = "build_manifest.json"


def info(message: str) -> None:
    print(f"[scad-all] {message}")


def fail(message: str) -> NoReturn:
    raise SystemExit(message)


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


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def sha256_tree(root: Path, suffixes: Tuple[str, ...]) -> str:
    digest = hashlib.sha256()
    paths = sorted(
        (
            path
            for path in root.rglob("*")
            if path.is_file() and path.suffix.lower() in suffixes
        ),
        key=lambda path: path.relative_to(root).as_posix(),
    )
    if not paths:
        fail(f"No source files found under: {root}")
    for path in paths:
        relative = path.relative_to(root).as_posix()
        digest.update(relative.encode("utf-8"))
        digest.update(b"\0")
        digest.update(path.read_bytes())
        digest.update(b"\0")
    return digest.hexdigest()


def repo_relative(path: Path) -> str:
    try:
        return path.resolve().relative_to(REPO_ROOT).as_posix()
    except ValueError:
        fail(f"Path must remain inside the repository: {path}")


def resolve_revision(config_path: Path, config: dict) -> str:
    configured = config.get("revision")
    revision = configured if isinstance(configured, str) else config_path.stem
    if not REVISION_RE.fullmatch(revision):
        fail(
            "Complete builds require a revision config named rev_000N.json "
            "or a matching 'revision' field."
        )
    return revision


def load_parts(path: Path) -> List[dict]:
    data = load_json(path, "Parts manifest")
    if data.get("schema_version") != 1:
        fail(f"Unsupported parts manifest schema in: {path}")
    raw_parts = data.get("parts")
    if not isinstance(raw_parts, list) or not raw_parts:
        fail(f"Parts manifest must contain a non-empty 'parts' list: {path}")

    parts: List[dict] = []
    seen_ids: Set[int] = set()
    seen_names: Set[str] = set()
    for index, raw_part in enumerate(raw_parts):
        if not isinstance(raw_part, dict):
            fail(f"Part entry {index} must be an object.")
        part_id = raw_part.get("part_id")
        name = raw_part.get("name")
        if not isinstance(part_id, int) or part_id < 0:
            fail(f"Part entry {index} has an invalid part_id.")
        if not isinstance(name, str) or not re.fullmatch(r"[a-z0-9_]+", name):
            fail(f"Part entry {index} has an invalid name: {name!r}")
        if part_id in seen_ids:
            fail(f"Duplicate part_id in manifest: {part_id}")
        if name in seen_names:
            fail(f"Duplicate part name in manifest: {name}")
        seen_ids.add(part_id)
        seen_names.add(name)
        parts.append({"part_id": part_id, "name": name})
    return parts


def expected_artifact_names(parts: Iterable[dict], revision: str) -> Set[str]:
    names: Set[str] = set()
    for part in parts:
        output_name = f"{part['name']}_{revision}"
        names.add(f"{output_name}.stl")
        names.add(f"{output_name}.png")
        for preset in scad_build.PNG_VIEW_PRESETS:
            names.add(f"{output_name}_{preset.suffix}.png")
    return names


def artifact_records(directory: Path, names: Iterable[str]) -> List[dict]:
    records: List[dict] = []
    for name in sorted(names):
        path = directory / name
        records.append(
            {
                "path": name,
                "bytes": path.stat().st_size,
                "sha256": sha256_file(path),
            }
        )
    return records


def validate_exact_artifacts(directory: Path, expected: Set[str]) -> None:
    actual_paths = [path for path in directory.rglob("*") if path.is_file()]
    scad_files = [path for path in actual_paths if path.suffix.lower() == ".scad"]
    if scad_files:
        fail(
            "SCAD source/probe files are prohibited in artifact directories:\n  "
            + "\n  ".join(str(path) for path in scad_files)
        )
    actual = {path.relative_to(directory).as_posix() for path in actual_paths}
    missing = sorted(expected - actual)
    unexpected = sorted(actual - expected)
    if missing or unexpected:
        details: List[str] = []
        if missing:
            details.append("Missing:\n  " + "\n  ".join(missing))
        if unexpected:
            details.append("Unexpected:\n  " + "\n  ".join(unexpected))
        fail("Artifact set does not match the parts manifest.\n" + "\n".join(details))


def git_provenance() -> dict:
    commit = "unavailable"
    dirty: Optional[bool] = None
    try:
        commit = subprocess.run(
            ["git", "rev-parse", "HEAD"],
            cwd=str(REPO_ROOT),
            check=True,
            capture_output=True,
            text=True,
        ).stdout.strip()
        status = subprocess.run(
            ["git", "status", "--porcelain", "--untracked-files=no"],
            cwd=str(REPO_ROOT),
            check=True,
            capture_output=True,
            text=True,
        ).stdout
        dirty = bool(status.strip())
    except (OSError, subprocess.CalledProcessError):
        pass
    return {"commit": commit, "dirty": dirty}


def final_directory(design: str, revision: str, destination: str) -> Path:
    if destination == "current":
        return REPO_ROOT / "output" / design
    return REPO_ROOT / "revisions" / design / revision


def safe_remove_tree(path: Path, required_parent: Path) -> None:
    resolved_path = path.resolve()
    resolved_parent = required_parent.resolve()
    try:
        resolved_path.relative_to(resolved_parent)
    except ValueError:
        fail(f"Refusing to remove path outside managed directory: {resolved_path}")
    if resolved_path == resolved_parent:
        fail(f"Refusing to remove managed root: {resolved_path}")
    if resolved_path.exists():
        shutil.rmtree(resolved_path)


def install_artifacts(staged: Path, final: Path, destination: str, stage_root: Path) -> None:
    final.parent.mkdir(parents=True, exist_ok=True)
    if destination == "revision":
        if final.exists():
            fail(f"Revision outputs are immutable and already exist: {final}")
        staged.rename(final)
        return

    backup = stage_root / "previous_output"
    if backup.exists():
        safe_remove_tree(backup, stage_root)
    if final.exists():
        final.rename(backup)
    try:
        staged.rename(final)
    except Exception:
        if backup.exists() and not final.exists():
            backup.rename(final)
        raise
    if backup.exists():
        safe_remove_tree(backup, stage_root)


def create_build_manifest(
    design: str,
    revision: str,
    destination: str,
    config_path: Path,
    config_hash: str,
    parts_path: Path,
    parts_hash: str,
    source_root: Path,
    source_hash: str,
    main_scad: Path,
    openscad_path: str,
    parts: List[dict],
    artifacts: List[dict],
) -> dict:
    png_count = sum(1 for artifact in artifacts if artifact["path"].endswith(".png"))
    stl_count = sum(1 for artifact in artifacts if artifact["path"].endswith(".stl"))
    return {
        "schema_version": 1,
        "build_scope": "complete",
        "design": design,
        "revision": revision,
        "destination": destination,
        "generated_at_utc": datetime.datetime.now(datetime.timezone.utc).isoformat(),
        "config": {
            "path": repo_relative(config_path),
            "sha256": config_hash,
        },
        "parts_manifest": {
            "path": repo_relative(parts_path),
            "sha256": parts_hash,
        },
        "source": {
            "path": repo_relative(source_root),
            "sha256": source_hash,
            "main_scad": repo_relative(main_scad),
        },
        "git": git_provenance(),
        "openscad": openscad_path,
        "counts": {
            "parts": len(parts),
            "stl": stl_count,
            "png": png_count,
            "artifacts": len(artifacts),
        },
        "parts": [
            {
                "part_id": part["part_id"],
                "name": part["name"],
                "output_name": f"{part['name']}_{revision}",
            }
            for part in parts
        ],
        "artifacts": artifacts,
    }


def audit(
    design: str,
    revision: str,
    destination: str,
    config_path: Path,
    parts_path: Path,
    source_root: Path,
) -> None:
    directory = final_directory(design, revision, destination)
    manifest_path = directory / BUILD_MANIFEST_NAME
    manifest = load_json(manifest_path, "Build manifest")
    if manifest.get("build_scope") != "complete":
        fail(f"Build manifest is not a complete-design build: {manifest_path}")
    if manifest.get("design") != design or manifest.get("revision") != revision:
        fail(f"Build manifest design/revision does not match the requested audit: {manifest_path}")

    records = manifest.get("artifacts")
    if not isinstance(records, list):
        fail(f"Build manifest has no artifact records: {manifest_path}")
    expected = {BUILD_MANIFEST_NAME}
    for record in records:
        if not isinstance(record, dict) or not isinstance(record.get("path"), str):
            fail(f"Invalid artifact record in: {manifest_path}")
        expected.add(record["path"])
    if destination == "revision":
        params_path = directory / "params.json"
        if params_path.exists():
            expected.add("params.json")
            if sha256_file(params_path) != sha256_file(config_path):
                fail(f"Revision params do not match the committed config: {params_path}")

    validate_exact_artifacts(directory, expected)
    for record in records:
        artifact_path = directory / record["path"]
        if artifact_path.stat().st_size != record.get("bytes"):
            fail(f"Artifact size mismatch: {artifact_path}")
        if sha256_file(artifact_path) != record.get("sha256"):
            fail(f"Artifact hash mismatch: {artifact_path}")

    checks = [
        ("config", sha256_file(config_path)),
        ("parts_manifest", sha256_file(parts_path)),
    ]
    for key, current_hash in checks:
        saved = manifest.get(key)
        if not isinstance(saved, dict) or saved.get("sha256") != current_hash:
            fail(f"{key} has changed since the artifacts were built.")
    source = manifest.get("source")
    if not isinstance(source, dict) or source.get("sha256") != sha256_tree(source_root, (".scad",)):
        fail("OpenSCAD source has changed since the artifacts were built.")

    counts = manifest.get("counts", {})
    info(
        "Audit passed: "
        f"{counts.get('parts')} parts, {counts.get('stl')} STL, "
        f"{counts.get('png')} PNG, {counts.get('artifacts')} artifacts."
    )
    info(f"Directory: {directory}")


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Build every part in designs/<design>/parts.json into a validated artifact set."
    )
    parser.add_argument("--design", required=True, help="Design folder under designs/<design>.")
    parser.add_argument("--config", required=True, help="Revision config path (rev_000N.json).")
    parser.add_argument(
        "--destination",
        choices=("current", "revision"),
        default="current",
        help="Build output/<design> or immutable revisions/<design>/rev_000N.",
    )
    parser.add_argument("--parts-manifest", help="Override designs/<design>/parts.json.")
    parser.add_argument("--main-scad", help="Override designs/<design>/src/main.scad.")
    parser.add_argument("--openscad-path", help="Explicit path to openscad executable.")
    parser.add_argument("--dry-run", action="store_true", help="Print all part commands without installing artifacts.")
    parser.add_argument("--audit-only", action="store_true", help="Validate an installed complete build without rendering.")
    args = parser.parse_args()

    design_root = REPO_ROOT / "designs" / args.design
    config_path = Path(args.config).resolve()
    parts_path = (
        Path(args.parts_manifest).resolve()
        if args.parts_manifest
        else design_root / "parts.json"
    )
    main_scad = (
        Path(args.main_scad).resolve()
        if args.main_scad
        else design_root / "src" / "main.scad"
    )
    source_root = main_scad.parent

    repo_relative(config_path)
    repo_relative(parts_path)
    repo_relative(main_scad)
    if not main_scad.exists():
        fail(f"Main SCAD not found: {main_scad}")

    config = scad_build.load_config(config_path)
    revision = resolve_revision(config_path, config)
    parts = load_parts(parts_path)

    if args.audit_only:
        audit(
            args.design,
            revision,
            args.destination,
            config_path,
            parts_path,
            source_root,
        )
        return 0

    build_id = f"{revision}_{uuid.uuid4().hex[:12]}"
    managed_tmp_root = REPO_ROOT / ".tmp" / "scad" / args.design
    stage_root = managed_tmp_root / build_id
    artifacts_dir = stage_root / "artifacts"
    configs_dir = stage_root / "configs"
    artifacts_dir.mkdir(parents=True, exist_ok=False)
    configs_dir.mkdir(parents=True, exist_ok=False)

    expected = expected_artifact_names(parts, revision)
    openscad_path = (
        args.openscad_path
        if args.dry_run
        else scad_build.resolve_openscad_exe(args.openscad_path)
    )
    build_script = Path(__file__).with_name("scad_build.py")

    try:
        info(f"Design: {args.design}")
        info(f"Revision: {revision}")
        info(f"Parts: {len(parts)}")
        info(f"Stage: {stage_root}")
        for part in parts:
            output_name = f"{part['name']}_{revision}"
            part_config = dict(config)
            part_config["part_id"] = part["part_id"]
            part_config["part"] = output_name
            part_config_path = configs_dir / f"part_{part['part_id']:03d}.json"
            part_config_path.write_text(json.dumps(part_config, indent=2) + "\n", encoding="utf-8")

            command = [
                sys.executable,
                str(build_script),
                "--design",
                args.design,
                "--config",
                str(part_config_path),
                "--part-name",
                output_name,
                "--out-dir",
                str(artifacts_dir),
                "--main-scad",
                str(main_scad),
            ]
            if args.openscad_path:
                command.extend(["--openscad-path", args.openscad_path])
            if args.dry_run:
                command.append("--dry-run")
            info(f"Building part {part['part_id']}: {output_name}")
            subprocess.run(command, cwd=str(REPO_ROOT), check=True)

        if args.dry_run:
            info("Dry run complete; no artifact directory was installed.")
            return 0

        validate_exact_artifacts(artifacts_dir, expected)
        records = artifact_records(artifacts_dir, expected)
        build_manifest = create_build_manifest(
            args.design,
            revision,
            args.destination,
            config_path,
            sha256_file(config_path),
            parts_path,
            sha256_file(parts_path),
            source_root,
            sha256_tree(source_root, (".scad",)),
            main_scad,
            openscad_path,
            parts,
            records,
        )
        (artifacts_dir / BUILD_MANIFEST_NAME).write_text(
            json.dumps(build_manifest, indent=2) + "\n",
            encoding="utf-8",
        )
        validate_exact_artifacts(artifacts_dir, expected | {BUILD_MANIFEST_NAME})

        final = final_directory(args.design, revision, args.destination)
        install_artifacts(artifacts_dir, final, args.destination, stage_root)
        info(f"Installed complete build: {final}")
        audit(
            args.design,
            revision,
            args.destination,
            config_path,
            parts_path,
            source_root,
        )
        return 0
    finally:
        if stage_root.exists():
            safe_remove_tree(stage_root, managed_tmp_root)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        raise SystemExit(exc.returncode)
