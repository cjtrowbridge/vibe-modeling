#!/usr/bin/env python3
"""Build OpenSCAD artifacts (STL + PNG) from a JSON config."""

import argparse
import json
import os
import shlex
import shutil
import subprocess
from pathlib import Path
from typing import List, NoReturn, Optional


def info(message: str) -> None:
    print(f"[scad] {message}")


def fail(message: str) -> NoReturn:
    raise SystemExit(message)


def format_cmd(cmd: List[str]) -> str:
    if os.name == "nt":
        return subprocess.list2cmdline(cmd)
    return " ".join(shlex.quote(part) for part in cmd)


def resolve_openscad_exe(explicit_path: Optional[str]) -> str:
    if explicit_path:
        candidate = Path(explicit_path)
        if not candidate.exists():
            fail(f"OpenSCAD not found at --openscad-path: {explicit_path}")
        return str(candidate)

    which = shutil.which("openscad")
    if which:
        return which

    if os.name == "nt":
        known_paths = [
            r"C:\Program Files\OpenSCAD\openscad.exe",
            r"C:\Program Files (x86)\OpenSCAD\openscad.exe",
        ]
        for path in known_paths:
            if Path(path).exists():
                return path

        try:
            import winreg  # type: ignore

            keys = [
                (winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\openscad.exe"),
                (winreg.HKEY_CURRENT_USER, r"SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\openscad.exe"),
            ]
            for hive, subkey in keys:
                try:
                    with winreg.OpenKey(hive, subkey) as key:
                        value, _ = winreg.QueryValueEx(key, None)
                        if value and Path(value).exists():
                            return str(value)
                except OSError:
                    continue
        except Exception:
            pass

    fail("OpenSCAD CLI not found. Install OpenSCAD or pass --openscad-path.")


def convert_value(value):
    if value is None:
        return "undef"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        return format(value, ".15g")
    if isinstance(value, str):
        escaped = value.replace("\\", "\\\\").replace('"', '\\"')
        return f'"{escaped}"'
    if isinstance(value, list):
        return "[" + ", ".join(convert_value(item) for item in value) + "]"
    fail(f"Unsupported config value type: {type(value).__name__}")


def build_defines(config: dict) -> List[str]:
    defines: List[str] = []
    for key in sorted(config.keys()):
        if key == "part":
            # Human-readable output naming convenience; avoid Windows quoting issues.
            continue
        defines.extend(["-D", f"{key}={convert_value(config[key])}"])
    return defines


def load_config(path: Path) -> dict:
    if not path.exists():
        fail(f"Config not found: {path}")
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(f"Invalid JSON config '{path}': {exc}")
    if not isinstance(data, dict):
        fail(f"Config must be a JSON object: {path}")
    if "part_id" in data:
        try:
            data["part_id"] = int(data["part_id"])
        except (TypeError, ValueError):
            fail("Config field 'part_id' must be numeric.")
    return data


def resolve_part_name(config: dict, explicit_part_name: Optional[str]) -> str:
    if explicit_part_name:
        return explicit_part_name
    part = config.get("part")
    if isinstance(part, str) and part.strip():
        return part.strip()
    if "part_id" in config:
        return f"part_{config['part_id']}"
    fail("No --part-name provided and config is missing a non-empty 'part' field.")


def main() -> int:
    parser = argparse.ArgumentParser(description="Build OpenSCAD STL and PNG artifacts from a JSON config.")
    parser.add_argument("--design", default="example_box", help="Design folder under designs/<design>.")
    parser.add_argument("--config", required=True, help="Path to JSON config file.")
    parser.add_argument("--part-name", help="Output base filename (defaults to config['part']).")
    parser.add_argument("--out-dir", help="Output directory (default: output/<design>).")
    parser.add_argument("--main-scad", help="OpenSCAD entrypoint (default: designs/<design>/src/main.scad).")
    parser.add_argument("--openscad-path", help="Explicit path to openscad executable.")
    parser.add_argument("--dry-run", action="store_true", help="Print commands without invoking OpenSCAD.")
    args = parser.parse_args()

    config_path = Path(args.config)
    out_dir = Path(args.out_dir) if args.out_dir else Path("output") / args.design
    main_scad = (
        Path(args.main_scad)
        if args.main_scad
        else Path("designs") / args.design / "src" / "main.scad"
    )

    if not main_scad.exists():
        fail(f"Main SCAD not found: {main_scad}")

    config = load_config(config_path)
    part_name = resolve_part_name(config, args.part_name)
    defines = build_defines(config)

    out_dir.mkdir(parents=True, exist_ok=True)
    out_stl = out_dir / f"{part_name}.stl"
    out_png = out_dir / f"{part_name}.png"

    info(f"Config: {config_path}")
    info(f"Design: {args.design}")
    info(f"PartName: {part_name}")
    info(f"OutDir: {out_dir}")

    stl_cmd = ["openscad", "-o", str(out_stl), str(main_scad), *defines]
    png_cmd = [
        "openscad",
        "-o",
        str(out_png),
        str(main_scad),
        "--imgsize=1200,900",
        "--viewall",
        *defines,
    ]

    if args.dry_run:
        info("DryRun enabled; not invoking OpenSCAD.")
        info(f"Would run: {format_cmd(stl_cmd)}")
        info(f"Would run: {format_cmd(png_cmd)}")
        return 0

    openscad_exe = resolve_openscad_exe(args.openscad_path)
    stl_cmd[0] = openscad_exe
    png_cmd[0] = openscad_exe
    info(f"OpenSCAD: {openscad_exe}")

    info(f"Exporting STL -> {out_stl}")
    subprocess.run(stl_cmd, check=True)

    info(f"Rendering PNG -> {out_png}")
    subprocess.run(png_cmd, check=True)

    info("Done.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        raise SystemExit(exc.returncode)
