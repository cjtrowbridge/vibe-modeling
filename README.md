# vibe-modeling

A reusable, agentic pipeline for iterating on OpenSCAD 3D models with parameterized configs, numbered revisions, and generated artifacts.

This repo is an extraction of the modeling workflow originally developed across many of my projects, especially [DIY-Weather-Satellite-Uplink](https://github.com/cjtrowbridge/DIY-Weather-Satellite-Uplink), and generalized so it can be used for any modeling domain.

## How To Use This Pipeline

1. Fork or clone this repository.
2. Open it in your preferred agentic framework (Aider, OpenClaw, QwenCode, etc.).
3. Tell the agent what you want to build.
   - Include dimensions, constraints, interfaces, materials, printer/process assumptions, and which artifacts you want (STL, multi-view PNG previews, etc.).
   - Depending on the model you use, you may also be able to include photos with caliper measurements, reference designs, or hand sketches.
4. Ask the agent to create or modify a design under `designs/`, update a config in `configs/rev_000N.json`, and use the build/revision scripts to iterate.
5. Review artifacts in `output/`, request changes, and repeat until the model is right.

If the agent follows the included playbooks, it should also document what it changed and preserve checkpoints in `revisions/`.

## What this gives you

- A standard OpenSCAD project layout (`designs/<design>/...`)
- JSON-driven parameter sets (`configs/rev_000N.json`)
- Cross-platform build helpers (Python)
- Linux convenience wrappers (bash)
- Numbered revision snapshots (`revisions/<design>/rev_000N/`)
- Agent playbooks for iterating, debugging, adding designs, and committing changes

---
## The rest of this is stuff that your agent should be able to read and understand, so it can use the pipeline effectively. You don't necessarily need to read or understand it yourself to use the pipeline, but it may help you guide the agent or debug issues.

## Repository layout

- `scripts/`
  - `scad_build.py` / `scad_build.sh`: build STL + the full required multi-view PNG set from a config
  - `scad_new_revision.py` / `scad_new_revision.sh`: create next numbered revision and build it
- `designs/<design>/`
  - `src/main.scad`: CLI entrypoint and part selection
  - `src/*_base.scad` / `src/*_roof.scad` / `src/*_drawer.scad` (optional): direct per-part print entrypoints
  - `src/lib/defaults.scad`: design defaults
  - `src/parts/*.scad`: geometry modules
  - `configs/rev_000N.json`: committed parameter sets
  - Included examples: `example_box`, `helical`, `yagi`, `yagi_card`, `dtv_yagi`, `winegard_gm6000_logic_backplane`, `gigachad_xavier_void`, `cottage_pi6_plus`, `old_rca_display_baseplate`, `opi_zero_2w_carrier`
- `output/`
  - scratch outputs (generated; ignored by default; a few example artifacts are committed)
- `revisions/`
  - revision snapshots and artifact checkpoints (generated; ignored)
- `playbooks/`
  - repeatable workflows for agents and humans

## Prerequisites

- Python 3.8+
- OpenSCAD installed locally
- Optional: `openscad` on your `PATH`
  - If not on `PATH`, pass `--openscad-path /path/to/openscad`

## Quick start

### 1. Dry-run the example design

Python:

```bash
python scripts/scad_build.py \
  --design example_box \
  --config designs/example_box/configs/rev_0001.json \
  --dry-run
```

Linux/macOS wrapper:

```bash
./scripts/scad_build.sh \
  --design example_box \
  --config designs/example_box/configs/rev_0001.json \
  --dry-run
```

### 2. Build artifacts (STL + multi-view PNGs)

```bash
python scripts/scad_build.py \
  --design example_box \
  --config designs/example_box/configs/rev_0001.json
```

Artifacts are written to `output/example_box/`.

### 3. Create a new numbered revision

```bash
python scripts/scad_new_revision.py \
  --design example_box \
  --base-config designs/example_box/configs/rev_0001.json \
  --dry-run
```

By default this creates:

- `designs/example_box/configs/rev_0002.json`
- `revisions/example_box/rev_0002/params.json`
- (when not dry-run) STL + multi-view PNG artifacts in the revision folder

Default PNG outputs include:

- `<part>.png` (legacy compatibility preview; iso front-right)
- `<part>_iso_front_right.png`
- `<part>_iso_front_left.png`
- `<part>_iso_back_right.png`
- `<part>_iso_back_left.png`
- `<part>_iso_bottom_front_right.png`
- `<part>_iso_bottom_front_left.png`
- `<part>_iso_bottom_back_right.png`
- `<part>_iso_bottom_back_left.png`
- `<part>_inspect_inside_bottom_iso.png` (debug framing into cavity from below)
- `<part>_inspect_inside_bottom_ortho.png` (debug orthographic from below focused on cavity)
- `<part>_ortho_front.png`
- `<part>_ortho_right.png`
- `<part>_ortho_back.png`
- `<part>_ortho_left.png`
- `<part>_ortho_top.png`
- `<part>_ortho_bottom.png`

The build pipeline always renders this full PNG set on every run (plus `<part>.png` legacy preview) and exits non-zero if any expected image is missing.

## Design conventions

- Prefer numeric `part_id` values in JSON configs.
  - Shell quoting for string defines varies across OS/shells.
- Keep `main.scad` as the script/CLI entrypoint.
  - Optional dedicated part entry files are fine for manual printing.
- Put geometry modules in `src/parts/`.
- Treat `configs/rev_000N.json` as part of the committed design history.

## Suggested workflow

1. Start from a design config (`rev_000N.json`).
2. Create a new revision checkpoint with `scad_new_revision.py`.
3. Edit SCAD or config parameters.
4. Rebuild to `output/<design>/` for fast iteration.
5. Review artifacts, adjust, and repeat.
6. Commit the source/config changes (not generated outputs).

See `playbooks/how_to_iterate_openscad_designs.md` for the full workflow.

## Included example designs

- `designs/example_box/`
  - Minimal generic starter design for pipeline verification
- `designs/helical/`, `designs/yagi/`, `designs/yagi_card/`, `designs/dtv_yagi/`
  - Real extracted designs from the original satellite-uplink project
- `designs/dtv_yagi/` includes measurement/reference photos used during iteration
- `designs/winegard_gm6000_logic_backplane/`
  - Parametric L-shaped replacement logic backplane prototype for a Winegard GM-6000 Carryout G2+ (4-hole pattern)
- `designs/gigachad_xavier_void/`
  - Parametric positive void/cutter model for subtracting a Jetson Xavier + carrier board cavity shape from a head mesh (simple back prism + top shaft prototype)
- `designs/cottage_pi6_plus/`
  - Parametric cottage-style Orange Pi 6 Plus enclosure concept with separate base + roof and a chimney exhaust path
  - Includes a separate sliding drawer part and tunables for drawer length, drawer end-wall headroom, and front-biased exhaust opening (`main_room_extra_x`, `drawer_end_wall_extra_h`, `divider_hole_front_extend_y`)
- `designs/old_rca_building/`
  - Simplified 30 Rockefeller Plaza inspired phone-cooling tower enclosure with first functional OpenSCAD draft (`rev_0001`)
  - Includes a top-load phone void, side rails, elevated bottom cable-bend cage, and rear 40mm fan plenum
- `designs/old_rca_display_baseplate/`
  - 4-tower row display baseplate sized for Kallax use (`325 x 210 mm`), with recessed locator outlines and split-left/split-right printable variants
- `designs/opi_zero_2w_carrier/`
  - Parametric Orange Pi Zero 2W mounting plate with a `2 mm` base, 4 mounting-hole-aligned studs, M3 through-holes, and underside head recesses for flush screw seating
- Matching sample artifacts for these examples are included under `output/` so users can inspect pipeline results without building first
