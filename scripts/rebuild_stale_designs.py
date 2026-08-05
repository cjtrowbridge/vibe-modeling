"""Rebuild governed multipart CAD outputs whose design tree is newer than its build.

Designed for VS Code's preLaunchTask.  Only complete manifest builds are used.
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def newest_mtime(path: Path) -> float:
    return max((p.stat().st_mtime for p in path.rglob("*") if p.is_file()), default=0)


def configured_path(design: Path) -> Path | None:
    manifest = ROOT / "output" / design.name / "build_manifest.json"
    if manifest.is_file():
        try:
            value = json.loads(manifest.read_text(encoding="utf-8"))["config"]["path"]
            candidate = ROOT / value
            if candidate.is_file():
                return candidate
        except (KeyError, TypeError, json.JSONDecodeError):
            pass
    configs = sorted((design / "configs").glob("*.json")) if (design / "configs").is_dir() else []
    return configs[0] if len(configs) == 1 else None


def audit(design: str, config: Path) -> int:
    command = [sys.executable, "scripts/scad_build_all.py", "--design", design,
               "--config", str(config.relative_to(ROOT)), "--destination", "current"]
    result = subprocess.run(command, cwd=ROOT)
    if result.returncode:
        return result.returncode
    return subprocess.run([*command, "--audit-only"], cwd=ROOT).returncode


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--all", action="store_true", help="scan every multipart design")
    args = parser.parse_args()
    if not args.all:
        parser.error("--all is required by the VS Code hook")

    failures = 0
    for design in sorted((ROOT / "designs").iterdir()):
        if not design.is_dir() or not (design / "parts.json").is_file():
            continue
        config = configured_path(design)
        manifest = ROOT / "output" / design.name / "build_manifest.json"
        if config is None:
            print(f"ERROR {design.name}: no installed config and multiple/no configs; build once explicitly.")
            failures += 1
            continue
        stale = not manifest.is_file() or newest_mtime(design) > manifest.stat().st_mtime
        if stale:
            print(f"REBUILD {design.name}: design tree is newer than current build")
            failures += bool(audit(design.name, config))
        else:
            print(f"CURRENT {design.name}: {config.relative_to(ROOT)}")
    return int(bool(failures))


if __name__ == "__main__":
    raise SystemExit(main())
