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
  - `scad_build_all.py`: stage, validate, install, and audit every part declared by a design
  - `scad_new_revision.py` / `scad_new_revision.sh`: create next numbered revision and build it
- `designs/<design>/`
  - `src/main.scad`: CLI entrypoint and part selection
  - `src/*_base.scad` / `src/*_roof.scad` / `src/*_drawer.scad` (optional): direct per-part print entrypoints
  - `src/lib/defaults.scad`: design defaults
  - `src/parts/*.scad`: geometry modules
  - `parts.json` (multi-part designs): authoritative complete-build part IDs and names
  - `configs/rev_000N.json`: committed parameter sets
  - Included designs: `example_box`, `helical`, `yagi`, `yagi_card`, `dtv_yagi`, `winegard_gm6000_logic_backplane`, `gigachad_xavier_void`, `cottage_pi6_plus`, `old_rca_display_baseplate`, `opi_zero_2w_carrier`, `cyberdeck`
- `output/`
  - current scratch outputs only (`output/<design>/`; generated and ignored)
- `revisions/`
  - revision snapshots and artifact checkpoints (generated; ignored)
- `.tmp/scad/`
  - managed staging, probes, sections, and partial/debug artifacts (generated and ignored)
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

### 3. Build and audit a complete multi-part design

Designs with `designs/<design>/parts.json` must use the complete-build command
when producing the authoritative current artifact set:

```bash
python scripts/scad_build_all.py \
  --design cyberdeck \
  --config designs/cyberdeck/configs/rev_0003.json
```

The command renders every part under `.tmp/scad/cyberdeck/`, verifies the exact
expected file set, records hashes and provenance in `build_manifest.json`, and
then replaces `output/cyberdeck/` as one unit.

Audit an installed build without rendering:

```bash
python scripts/scad_build_all.py \
  --design cyberdeck \
  --config designs/cyberdeck/configs/rev_0003.json \
  --audit-only
```

### 4. Create a new numbered revision

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
- Define each design's `minimum_wall_thickness` and `minimum_structural_overlap`.
- Require `minimum_structural_overlap >= minimum_wall_thickness` for every intended structural join.
- Build joins with deliberate positive-volume intersection. Shared faces, shared edges, tangent contact, visual proximity, and epsilon-sized intersections are not structural connections.
- Require every internal edge, rim, rail, flange, web, bridge, and material strip around or between voids to remain at least `minimum_wall_thickness` wide at its narrowest point.
- When multiple holes, recesses, or voids cut the same structural member, assert the shortest post-subtraction ligament for every pair that can approach; outer-edge checks alone are not sufficient.
- Guard structural dimensions with named parameters and `assert()` statements, then inspect section views and disconnected-shell results. A successful render or manifold STL alone is insufficient.
- Treat designs as structurally unverified until these checks are recorded for the exact revision/config. Build success does not by itself make a model fabrication-ready.
- Every post-change summary must report the structural-join review and minimum-edge review as `passed`, `failed`, `unverified`, or `not applicable`.
- Multi-part designs must declare their authoritative export set in `parts.json`.
- Use only `output/<design>/`, `revisions/<design>/rev_000N/`, and `.tmp/scad/<design>/` for generated artifacts.
- Do not create revision-named directories under `output/`.
- Do not place `.scad` probes or source files under `output/` or `revisions/`.
- A complete/current build requires a passing `build_manifest.json` audit.
- Revision directories are immutable. Create a new revision after geometry or config changes.
- Generated outputs are not committed.

See `playbooks/how_to_design_and_verify_structural_openscad_joins.md` for the mandatory structural geometry contract and verification procedure.

## Suggested workflow

1. Start from a design config (`rev_000N.json`).
2. Create a new revision checkpoint with `scad_new_revision.py`.
3. Edit SCAD or config parameters.
4. Rebuild a single part for focused inspection, or use `scad_build_all.py` to replace the authoritative complete output.
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
- `designs/lovelace/`
  - Concept-first workspace for a modular mechanical computer using composable 3D-printed logic cubes, synchronized motor-chain expansion, and magnetic cube-to-cube attachment
- `designs/cyberdeck/`
  - First-draft visual mockup workspace for a cassette-futurist cyberdeck with asymmetric eye module, wide touchscreen, folding keyboard, hardware toggles, and internal proxy volumes
- Generated artifacts remain local under `output/` and `revisions/`; source and configs are the committed record
