# vibe-modeling

A reusable, agentic pipeline for iterating on OpenSCAD 3D models with parameterized configs, numbered revisions, and generated artifacts.

This repo is an extraction of the modeling workflow originally developed across many of my projects, especially [DIY-Weather-Satellite-Uplink](https://github.com/cjtrowbridge/DIY-Weather-Satellite-Uplink), and generalized so it can be used for any modeling domain.

## Agent framework integration

The reusable [`cjtrowbridge/agentic-pipelines`](https://github.com/cjtrowbridge/agentic-pipelines)
framework is pinned as a Git submodule at `agentic-pipelines/`. The root `AGENTS.md` is a
hybrid host policy: it adopts selected upstream plan-governance conventions while
preserving this repository's CAD-specific structural and artifact rules. Host
policy and host-managed workflow files take precedence over upstream defaults.

This repository intentionally does not use the upstream kanban subsystem.

After cloning this repository, initialize the reference framework with:

```bash
git submodule update --init --recursive agentic-pipelines
```

Submodule updates require a three-way synthesis of the old upstream version, new
upstream version, and current host-managed files. Do not replace root policy or
host playbooks wholesale. See
`playbooks/how_to_update_submodule_and_synthesize_host_overrides.md`.

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

- `agentic-pipelines/`
  - Pinned upstream Agentic Pipelines baseline and fallback source. This host
    intentionally uses `./agentic-pipelines`, not upstream's `./pipelines` path.
- `plans/future/`, `plans/current/`, `plans/past/`
  - Host-owned task plans and generated lifecycle indexes
- `journal/`
  - Daily repository checkpoint records
- `downtime/reports/`
  - Optional report-only maintenance findings awaiting or completing review
- `templates/`
  - Host plan, journal, synthesis, and report templates
- `references/`
  - Host operational guidance plus domain packages under `references/engineering/`
- `scripts/`
  - `scad_build.py` / `scad_build.sh`: build STL + the full required multi-view PNG set from a config
  - `scad_build_all.py`: stage, validate, install, and audit every part declared by a design
  - `validate_cad_assembly_contract.py`: validate multipart hierarchy and printable-leaf coverage
  - `scad_render_assembly_review.py`: render and audit provenance-bound assembled-design evidence
  - `scad_new_revision.py` / `scad_new_revision.sh`: publish the next numbered config and immutable revision after candidate verification
  - `regenerate_plan_indexes.py`: validate plans and deterministically refresh lifecycle indexes
  - `validate_ten_inch_rack_reference.py`: verify the preserved rack bundle, requirement inventory, and companion synchronization
- `designs/<design>/`
  - `src/main.scad`: CLI entrypoint and part selection
  - `src/*_base.scad` / `src/*_roof.scad` / `src/*_drawer.scad` (optional): direct per-part print entrypoints
  - `src/lib/defaults.scad`: design defaults
  - `src/parts/*.scad`: geometry modules
  - `parts.json` (multi-part designs): authoritative complete-build part IDs and names
  - `assembly.json` (new or modified multi-part designs): authoritative product/subassembly hierarchy, transforms, interfaces, and review views
  - `configs/rev_000N.json`: committed parameter sets
  - Included designs: `example_box`, `helical`, `yagi`, `yagi_card`, `dtv_yagi`, `winegard_gm6000_logic_backplane`, `gigachad_xavier_void`, `cottage_pi6_plus`, `old_rca_display_baseplate`, `opi_zero_2w_carrier`, `comrade`, `cyberdeck`, `cyberdeck-2`, `ac_redirectors`
  - `cyberdeck-2`: two-leaf, maximum-depth 2U ten-inch-rack receiver with a closed rear, twelve front M3 insert positions, flush internalized seam joints, and continuous lower device rails
- `output/`
  - the single mutable destination for printable parts, combined assemblies,
    review views, probes, sections, manifests, and managed in-progress staging
    (`output/<design>/`; generated and ignored)
- `revisions/`
  - revision snapshots and artifact checkpoints (generated; ignored)
- `playbooks/`
  - repeatable workflows for agents and humans

## Plan-governed agent workflow

Substantial changes use an approved plan under `plans/current/`. Plans begin in
`plans/future/`, move to `plans/current/` immediately before execution, and move
to `plans/past/` when no follow-up remains. Refresh or validate the indexes from
the repository root with:

```bash
python scripts/regenerate_plan_indexes.py --repo-root .
python scripts/regenerate_plan_indexes.py --check --repo-root .
```

Repository-changing checkpoints are recorded in `journal/YYYY-MM-DD.md` before
commit. The complete policy, including approval boundaries and CAD verification
requirements, is in `AGENTS.md`.

## Engineering reference packages

Engineering material uses the unified `references/engineering/` hierarchy. The
current ten-inch-rack package is the immutable `v2.0.0` source bundle documented
in `references/engineering/ten_inch_rack/README.md`. Validate it with:

```bash
python scripts/validate_ten_inch_rack_reference.py
```

When applying it to a design, follow
`playbooks/working_with_ten_inch_racks.md`; host CAD, structural, provenance, and
artifact rules take precedence over conflicting standalone bundle guidance.

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

The command stages every part inside `output/cyberdeck/`, verifies the exact
expected file set, records hashes and provenance in `build_manifest.json`,
promotes the set, and removes staging before success.

Audit an installed build without rendering:

```bash
python scripts/scad_build_all.py \
  --design cyberdeck \
  --config designs/cyberdeck/configs/rev_0003.json \
  --audit-only
```

### VS Code stale-build hook

The `Rebuild stale CAD designs` launch configuration runs the hook directly, so
the VS Code play button works even when no editor is active. The hook compares each multipart
design tree with its installed `output/<design>/build_manifest.json`, rebuilds
only stale designs through `scad_build_all.py`, and audits each rebuilt output.
For a design with several configs and no installed manifest, run one explicit
complete build first so the hook can reuse its config.

### 4. Publish a verified numbered revision

Develop and verify the candidate config under `designs/<design>/configs/` first.
Run the revision command only when the candidate is ready to become immutable:

```bash
python scripts/scad_new_revision.py \
  --design example_box \
  --base-config designs/example_box/configs/rev_0002.json
```

By default this creates:

- `designs/example_box/configs/rev_0002.json`
- `revisions/example_box/rev_0002/params.json`
- (when not dry-run) STL + multi-view PNG artifacts in the revision folder

The example assumes `designs/example_box/configs/rev_0002.json` is the already verified
candidate and `rev_0002` is still unused. `--dry-run` skips OpenSCAD rendering
but still creates the config and revision files. It is not a read-only preview.
Never run this command against a revision number that has already been published.

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
- `<part>_inspect_inside_bottom_iso.png` (auto-framed angled inspection from below)
- `<part>_inspect_inside_bottom_ortho.png` (auto-framed orthographic inspection from below)
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
- New or geometry-modified multi-part designs must also declare their primary
  product assembly and nested logical subassemblies in `assembly.json`.
- Multipart iteration requires a provenance-matched primary assembly artifact
  reviewed with proxies hidden. Geometry, transform, interface, config, source,
  or manifest changes invalidate the prior review.
- Every multipart milestone starts with the normal complete build into
  `output/<design>/`. Audit and review those installed STL/PNG artifacts before
  rendering the supplementary assembly-review set; its manifest must bind the
  exact `build_manifest.json` and authoritative STL hashes. The assembly STL,
  review PNGs, and assembly manifest live in that same output directory.
- Product assemblies, logical subassemblies, and printable leaf artifacts are
  distinct. Printer constraints may split a subassembly into more leaves but may
  not silently absorb it into another component.
- Use only `output/<design>/` for mutable generated artifacts and
  `revisions/<design>/rev_000N/` for immutable generated artifacts.
- Do not create revision-named directories under `output/`.
- Completed outputs must be flat and contain no staging directory or `.scad` file.
- A complete/current build requires a passing `build_manifest.json` audit.
- Revision directories are immutable. Create a new revision after geometry or config changes.
- Generated outputs are not committed.

See `playbooks/how_to_design_and_verify_structural_openscad_joins.md` for the mandatory structural geometry contract and verification procedure.

## Suggested workflow

1. Select a committed baseline config and the next unused revision number.
2. Create the candidate config at `designs/<design>/configs/rev_000N.json`.
3. Edit source and staged parameters while building mutable current output.
4. Review targeted sections/coupons and run structural, fit, print-volume, and complete-manifest gates.
5. Publish the verified immutable config/revision with `scad_new_revision.py`.
6. Audit current and immutable artifacts, record provenance, and commit source/config/docs—not generated outputs.

See `playbooks/how_to_iterate_openscad_designs.md` for the full workflow.

## CAD playbook coverage

The playbook set now separates the major CAD responsibilities that were formerly
embedded in one-off design notes:

- revision publication, complete-manifest builds, manifest editing, and legacy migration;
- structural review, sections/probes, provenance records, and build-automation changes;
- reference measurement, tolerance stacks, coupons, and physical-print feedback;
- split printing, fasteners, moving assemblies, orientation, supports, and build volume;
- OpenSCAD troubleshooting, artifact recovery, reference geometry, and design-plan migration.

`AGENTS.md` contains the authoritative per-file playbook index.

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
- `designs/comrade/`
  - Initial modular robot core base: a `111 x 79 x 7 mm` plate with an `81 x 49 mm` underside-recessed M3 electronics-stack pattern and four top-recessed M3 corner mounts for later modules
- `designs/lovelace/`
  - Concept-first workspace for a modular mechanical computer using composable 3D-printed logic cubes, synchronized motor-chain expansion, and magnetic cube-to-cube attachment
- `designs/cyberdeck/`
  - First-draft visual mockup workspace for a cassette-futurist cyberdeck with asymmetric eye module, wide touchscreen, folding keyboard, hardware toggles, and internal proxy volumes
- `designs/ac_redirectors/`
  - Two independent rail-hung air-conditioner redirectors sharing an open 50 mm-radius quarter-turn foundation
  - Includes a straight vertical door-side guide and a bed-side guide with parametric 45-degree swept vanes
  - Includes a full-width reference mockup of the photographed AC vent, top ledge, and mounting rail
- Generated artifacts remain local under `output/` and `revisions/`; source and configs are the committed record
