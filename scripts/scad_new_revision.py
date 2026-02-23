#!/usr/bin/env python3
"""Create a numbered OpenSCAD revision snapshot and build artifacts."""

import argparse
import json
import os
import re
import shlex
import subprocess
import sys
from pathlib import Path
from typing import List, NoReturn


REV_RE = re.compile(r"^rev_(\d+)(?:\.json)?$")


def info(message: str) -> None:
    print(f"[rev] {message}")


def fail(message: str) -> NoReturn:
    raise SystemExit(message)


def format_cmd(cmd: List[str]) -> str:
    if os.name == "nt":
        return subprocess.list2cmdline(cmd)
    return " ".join(shlex.quote(part) for part in cmd)


def get_revision_number(name: str) -> int:
    match = REV_RE.match(name)
    return int(match.group(1)) if match else 0


def load_config(path: Path) -> dict:
    if not path.exists():
        fail(f"Base config not found: {path}")
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(f"Invalid JSON config '{path}': {exc}")
    if not isinstance(data, dict):
        fail(f"Base config must be a JSON object: {path}")
    return data


def next_revision_name(revisions_dir: Path, configs_dir: Path) -> str:
    max_num = 0
    if revisions_dir.exists():
        for child in revisions_dir.iterdir():
            if child.is_dir():
                max_num = max(max_num, get_revision_number(child.name))
    if configs_dir.exists():
        for child in configs_dir.glob("rev_*.json"):
            max_num = max(max_num, get_revision_number(child.name))
    return f"rev_{max_num + 1:04d}"


def main() -> int:
    parser = argparse.ArgumentParser(description="Create a new numbered config + revision snapshot for a design.")
    parser.add_argument("--design", default="example_box", help="Design folder under designs/<design>.")
    parser.add_argument("--base-config", required=True, help="Existing config JSON to copy as the next revision.")
    parser.add_argument("--part-name", help="Output base filename (defaults to config['part']).")
    parser.add_argument("--revisions-dir", help="Override revisions directory (default: revisions/<design>).")
    parser.add_argument("--configs-dir", help="Override configs directory (default: designs/<design>/configs).")
    parser.add_argument("--main-scad", help="Override main.scad path.")
    parser.add_argument("--openscad-path", help="Explicit path to openscad executable.")
    parser.add_argument("--dry-run", action="store_true", help="Skip OpenSCAD invocation (still writes revision/config files).")
    args = parser.parse_args()

    base_config = Path(args.base_config)
    config_data = load_config(base_config)

    revisions_dir = Path(args.revisions_dir) if args.revisions_dir else Path("revisions") / args.design
    configs_dir = Path(args.configs_dir) if args.configs_dir else Path("designs") / args.design / "configs"
    main_scad = (
        Path(args.main_scad)
        if args.main_scad
        else Path("designs") / args.design / "src" / "main.scad"
    )

    revisions_dir.mkdir(parents=True, exist_ok=True)
    configs_dir.mkdir(parents=True, exist_ok=True)

    rev_name = next_revision_name(revisions_dir, configs_dir)
    rev_dir = revisions_dir / rev_name
    config_path = configs_dir / f"{rev_name}.json"
    params_path = rev_dir / "params.json"

    if rev_dir.exists():
        fail(f"Revision directory already exists: {rev_dir}")
    if config_path.exists():
        fail(f"Revision config already exists: {config_path}")

    part_name = args.part_name or config_data.get("part")
    if not isinstance(part_name, str) or not part_name.strip():
        fail("No --part-name provided and base config is missing a non-empty 'part' field.")
    part_name = part_name.strip()

    info(f"Creating {rev_name}")
    info(f"Design: {args.design}")
    info(f"BaseConfig: {base_config}")
    if args.dry_run:
        info("DryRun enabled for OpenSCAD build only; revision files will still be written.")

    rev_dir.mkdir(parents=True, exist_ok=False)
    payload = json.dumps(config_data, indent=2) + "\n"
    config_path.write_text(payload, encoding="utf-8")
    params_path.write_text(payload, encoding="utf-8")

    build_script = Path(__file__).with_name("scad_build.py")
    build_cmd = [
        sys.executable,
        str(build_script),
        "--design",
        args.design,
        "--config",
        str(config_path),
        "--part-name",
        part_name,
        "--out-dir",
        str(rev_dir),
        "--main-scad",
        str(main_scad),
    ]
    if args.openscad_path:
        build_cmd.extend(["--openscad-path", args.openscad_path])
    if args.dry_run:
        build_cmd.append("--dry-run")

    info(f"Building artifacts into: {rev_dir}")
    info(f"Invoking: {format_cmd(build_cmd)}")
    subprocess.run(build_cmd, check=True)

    info(f"Revision ready: {rev_dir}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        raise SystemExit(exc.returncode)
