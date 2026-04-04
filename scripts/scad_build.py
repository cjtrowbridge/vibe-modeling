#!/usr/bin/env python3
"""Build OpenSCAD artifacts (STL + multi-view PNG set) from a JSON config."""

import argparse
import json
import os
import shlex
import shutil
import subprocess
from pathlib import Path
from typing import Dict, List, NamedTuple, NoReturn, Optional, Tuple


class PngViewPreset(NamedTuple):
    suffix: str
    projection: str
    rotation: Tuple[float, float, float]
    target: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    distance: float = 1000.0
    autocenter: bool = True
    viewall: bool = True


PNG_VIEW_PRESETS: List[PngViewPreset] = [
    PngViewPreset("iso_front_right", "p", (55, 0, 25)),
    PngViewPreset("iso_front_left", "p", (55, 0, -25)),
    PngViewPreset("iso_back_right", "p", (55, 0, 155)),
    PngViewPreset("iso_back_left", "p", (55, 0, -155)),
    PngViewPreset("iso_bottom_front_right", "p", (125, 0, 25)),
    PngViewPreset("iso_bottom_front_left", "p", (125, 0, -25)),
    PngViewPreset("iso_bottom_back_right", "p", (125, 0, 155)),
    PngViewPreset("iso_bottom_back_left", "p", (125, 0, -155)),
    # Debug-friendly below views focused on tower interior.
    PngViewPreset("inspect_inside_bottom_iso", "p", (160, 0, 20), (0, 0, -80), 380.0, False, False),
    PngViewPreset("inspect_inside_bottom_ortho", "o", (180, 0, 0), (0, 0, -90), 400.0, False, False),
    PngViewPreset("ortho_front", "o", (90, 0, 0)),
    PngViewPreset("ortho_right", "o", (90, 0, 90)),
    PngViewPreset("ortho_back", "o", (90, 0, 180)),
    PngViewPreset("ortho_left", "o", (90, 0, 270)),
    PngViewPreset("ortho_top", "o", (0, 0, 0)),
    PngViewPreset("ortho_bottom", "o", (180, 0, 0)),
]

# Keep a legacy single-preview filename for compatibility while also
# generating the explicit named view files above.
LEGACY_PREVIEW_SUFFIX = "iso_front_right"


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


def build_camera_arg(
    rotation: Tuple[float, float, float],
    target: Tuple[float, float, float] = (0.0, 0.0, 0.0),
    distance: float = 1000.0,
) -> str:
    tx, ty, tz = target
    rx, ry, rz = rotation
    return f"{tx},{ty},{tz},{rx},{ry},{rz},{distance}"


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Build OpenSCAD STL and multi-view PNG artifacts from a JSON config."
    )
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
    legacy_png = out_dir / f"{part_name}.png"
    named_png_paths: Dict[str, Path] = {
        preset.suffix: out_dir / f"{part_name}_{preset.suffix}.png"
        for preset in PNG_VIEW_PRESETS
    }
    required_png_paths: List[Path] = [legacy_png, *named_png_paths.values()]

    info(f"Config: {config_path}")
    info(f"Design: {args.design}")
    info(f"PartName: {part_name}")
    info(f"OutDir: {out_dir}")
    info(f"PNGViews: {len(PNG_VIEW_PRESETS)} named + 1 legacy preview")

    stl_cmd = ["openscad", "-o", str(out_stl), str(main_scad), *defines]
    png_jobs: List[Tuple[str, Path, List[str]]] = []
    for preset in PNG_VIEW_PRESETS:
        suffix = preset.suffix
        projection = preset.projection
        camera = build_camera_arg(preset.rotation, preset.target, preset.distance)
        out_png = legacy_png if suffix == LEGACY_PREVIEW_SUFFIX else named_png_paths[suffix]
        cmd = [
            "openscad",
            "-o",
            str(out_png),
            str(main_scad),
            "--imgsize=1200,900",
        ]
        if preset.autocenter:
            cmd.append("--autocenter")
        if preset.viewall:
            cmd.append("--viewall")
        cmd.extend([
            f"--projection={projection}",
            f"--camera={camera}",
            *defines,
        ])
        png_jobs.append((suffix, out_png, cmd))

    if args.dry_run:
        info("DryRun enabled; not invoking OpenSCAD.")
        info(f"Would run: {format_cmd(stl_cmd)}")
        for suffix, _, cmd in png_jobs:
            info(f"Would run ({suffix}): {format_cmd(cmd)}")
        if LEGACY_PREVIEW_SUFFIX in named_png_paths:
            info(
                f"Would copy legacy preview to named view: "
                f"{legacy_png} -> {named_png_paths[LEGACY_PREVIEW_SUFFIX]}"
            )
        return 0

    openscad_exe = resolve_openscad_exe(args.openscad_path)
    stl_cmd[0] = openscad_exe
    info(f"OpenSCAD: {openscad_exe}")

    info(f"Exporting STL -> {out_stl}")
    subprocess.run(stl_cmd, check=True)

    for suffix, out_png, cmd in png_jobs:
        cmd[0] = openscad_exe
        info(f"Rendering PNG [{suffix}] -> {out_png}")
        subprocess.run(cmd, check=True)

    if LEGACY_PREVIEW_SUFFIX in named_png_paths:
        src = legacy_png
        dst = named_png_paths[LEGACY_PREVIEW_SUFFIX]
        shutil.copyfile(src, dst)
        info(f"Copied legacy preview -> named view: {dst}")

    missing_pngs = [path for path in required_png_paths if not path.exists()]
    if missing_pngs:
        fail(
            "Missing expected PNG outputs:\n  "
            + "\n  ".join(str(path) for path in missing_pngs)
        )

    info("Done.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        raise SystemExit(exc.returncode)
