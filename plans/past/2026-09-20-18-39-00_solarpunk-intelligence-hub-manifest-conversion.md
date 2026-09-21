---
plan_id: 2026-09-20-18-39-00_solarpunk-intelligence-hub-manifest-conversion
title: Convert solarpunk_intelligence_hub into a manifest-driven single-part design
summary: Convert the solarpunk_intelligence_hub reference mockup into a governed manifest-driven design (3 mm plate, all mounting holes M3 / Ø3.2) and produce its build artifacts (printable plate STL plus a non-printable block-diagram mockup STL and rendered images) and documentation.
status: past
created_at: 2026-09-20-18-39-00
---

# Convert solarpunk_intelligence_hub into a manifest-driven single-part design

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Objective

Convert the `solarpunk_intelligence_hub` reference mockup into a governed
manifest-driven OpenSCAD design so the standard pipeline produces its build
artifacts (an STL plus render images) in `output/solarpunk_intelligence_hub/`.
Approved parameters: 3 mm plate thickness; all 28 mounting holes at M3 (Ø3.2)
— 24 component holes + 4 hanging holes (the Ø6 hanging-hole proposal was a
working placeholder); final per-component hole spans from the user-provided
layout image (relay 34×55, screen 82×44, Pi 42×72, camera 12×12).

## Scope

In scope:

- New manifest-driven design files under
  `designs/solarpunk_intelligence_hub/`: `parts.json`,
  `configs/rev_0001.json`, `src/lib/defaults.scad`,
  `src/parts/solarpunk_intelligence_hub.scad`,
  `src/parts/backplane_blockout_mockup.scad`, `src/main.scad`.
  Part 1 is the printable plate; part 2 (user request) is a derived block
  diagram of the piece footprints + Ø3.2 holes, exported as a non-printable
  reference artifact so the pipeline produces its image/STL alongside the
  printable part.
- Complete manifest build of the design into
  `output/solarpunk_intelligence_hub/` (2 STL + 34 PNG +
  `build_manifest.json`) and a passing standalone `--audit-only` re-audit.
- Same-task documentation: `designs/solarpunk_intelligence_hub/README.md`
  (status, layout, holes, thickness, supersedes the Ø6 working proposal) and
  `docs/solarpunk_series.md` (inventory row + short design section).
- Journal checkpoint in `journal/2026-09-20.md`.

Out of scope:

- Editing the existing reference mockup
  `designs/solarpunk_intelligence_hub/src/mockups/backplane_blockout.scad`
  (retained as a frozen design reference; the new pipeline mockup part is a
  separate derived module that reads only the shared named layout parameters).
- Assembly governance (`assembly.json` / assembly-review pipeline): the result
  is a single printable part with no logical subassemblies, so the
  multipart-assembly playbook does not apply. Precedent: `ac_redirectors`
  passes its audit without `assembly.json`.
- `revisions/` snapshots (created only by the publish playbook on request).
- Git commit or push — stop at verified artifacts + docs and report back.
- Any other design, plan, script, or framework file.

## Current State

- `designs/solarpunk_intelligence_hub/` contains only `README.md` and
  `src/mockups/backplane_blockout.scad` (+ `preview.png`). No `parts.json`,
  no `configs/`, no `src/main.scad`.
- `output/solarpunk_intelligence_hub/` does not exist.
- The mockup is the converged blockout: 169 × 187 mm plate, uniform 3 mm
  margins, 5 components (3 relays 52×73, RPi 4 90×60 portrait, camera 25×25,
  LCD screen 100×62), 3 mm velcro hanging band with 4 holes, 4 M3 holes per
  component in an 8 mm inset pattern; top-level params
  `edge_margin=3, gap=3, velcro_gap=3, plate_t=2, comp_h=15, m3_d=3.2,
  velcro_d=6.0, velcro_n=4`.
- `docs/solarpunk_series.md` §3 inventory lists only `solarpunk_seed_tray`
  and `solarpunk_siphon_filter`; the series document records only the 2 mm
  plate working decision (to be updated to approved 3 mm, M3 everywhere).
- Precedents: `fan_guard` (single-part manifest design: 1 config +
  parts.json + src/lib/defaults + src/parts + main.scad dispatcher),
  `solarpunk_seed_tray` (series README + section layout).

## Information

Inputs:

- Blockout geometry (component sizes, hole patterns, placements, 169×187
  envelope, 3 mm margins, velcro band) from
  `src/mockups/backplane_blockout.scad` — frozen reference.
- Approved decisions: plate thickness 3 mm; all 28 holes M3 (Ø3.2)
  (24 component + 4 hanging); per-component hole spans relay 34×55, screen
  82×44, Pi 42×72 (9 mm inset in the 60×90 rotated footprint), camera 12×12
  (6.5 mm inset in the 25×25 body), from the user-provided layout image.
- Structural governance in `AGENTS.md` §10: declare
  `minimum_wall_thickness`, `minimum_structural_overlap` (>= wall), minimum
  internal edge/material width; named dimensions and `assert()`.

Outputs:

- 6 new files under `designs/solarpunk_intelligence_hub/`.
- 37 files in `output/solarpunk_intelligence_hub/` (2 STL, 34 PNG,
  `build_manifest.json`).
- Updated `designs/solarpunk_intelligence_hub/README.md`,
  `docs/solarpunk_series.md`, and `journal/2026-09-20.md`.

Constraints:

- 3 mm plate; the governing internal minimum is the tightest in-pattern
  ligament between adjacent holes of the smallest span (camera 12 mm):
  `pattern_ligament(span) = span + gap − m3_d` → declare
  `minimum_internal_edge_width = 11.8` (= 12 + 3 − 3.2) and
  `minimum_structural_overlap = 3.0` (>= thickness, satisfies §10); checked
  by `assert(tightest_ligament() >= minimum_internal_edge_width)`.
- All 28 holes Ø3.2: 24 component M3 (per-component insets 9 / 9 / 6.5 / 9 mm
  → spans 34×55, 42×72, 12×12, 82×44) + 4 hanging (Ø3.2 in the 9.2 mm top
  band, hole-center y = 179.6 mm on the 184.2 mm plate, 3 mm from the hole
  edge to the plate top edge, x at 3 + i·(163/3) → 3, 57.333, 111.667, 166).
- Single flat plate → no structural joins; the only open decision inherited
  from the mockup (meshtastic node dimensions/pattern) remains open and is
  not part of this revision.

Assumptions:

- Render preset counts follow the pipeline: 16 named view PNGs (1200×900,
  viewall) + 1 legacy `{part}.png` = 17 PNG per part.
- `scad_build_all.py` resolves the old-CLI OpenSCAD automatically and
  tolerates the benign `color('gray80')` / `$echo`-in-module warnings.
- No `--exact-fit` needed; the pipeline ignores bounding box.

Unknowns: none blocking.

## Expected Files

Create:

- `designs/solarpunk_intelligence_hub/parts.json` — schema_version 1, 2 parts:
  part_id 1 `solarpunk_intelligence_hub` (printable plate), part_id 2
  `backplane_blockout_mockup` (non-printable reference).
- `designs/solarpunk_intelligence_hub/configs/rev_0001.json` — `part` /
  `part_id` 1 + full parameter set (plate, margin, hole, and component
  layout).
- `designs/solarpunk_intelligence_hub/src/lib/defaults.scad` —
  `is_undef` defaults for every config param + structural minimums
  (`minimum_wall_thickness = 3.0`, `minimum_structural_overlap = 3.0`,
  `minimum_internal_edge_width = 11.8`) + `boolean_epsilon` + the shared
  layout math (envelope 169 × 184.2, per-component spans, ligament functions).
- `designs/solarpunk_intelligence_hub/src/parts/solarpunk_intelligence_hub.scad`
  — flat 3 mm plate, 28 Ø3.2 through-holes (24 component + 4 hanging),
  derived dims with `assert()` (governing ligament 11.8, hole-edge rim
  clearance, hanging-hole vertical centering, plate bounds vs. max print).
- `designs/solarpunk_intelligence_hub/src/parts/backplane_blockout_mockup.scad`
  — `backplane_blockout_mockup()` module: 20 mm colored footprint blocks at
  the layout positions + Ø3.2 holes in a faint plate, same named parameters,
  non-printable reference only (predecessor of
  `src/mockups/backplane_blockout.scad`).
- `designs/solarpunk_intelligence_hub/src/main.scad` — includes
  `lib/defaults.scad` then both part files; dispatch `part_id == 1` → part,
  `part_id == 2` → mockup, else `assert(false, ...)`.

Build (generated):

- `output/solarpunk_intelligence_hub/build_manifest.json`
- `output/solarpunk_intelligence_hub/solarpunk_intelligence_hub_rev_0001.stl`
  and 17 matching PNGs (printable plate)
- `output/solarpunk_intelligence_hub/backplane_blockout_mockup_rev_0001.stl`
  and 17 matching PNGs (non-printable reference, user-requested)

Modify:

- `designs/solarpunk_intelligence_hub/README.md`
- `docs/solarpunk_series.md`
- `journal/2026-09-20.md`
- `plans/current/index.md` (regenerated by the indexer)
- This plan file (stale numbers corrected on completion: 28 total Ø3.2 holes,
  per-component spans/insets, hanging-hole y = 179.6 mm, envelope
  169 × 184.2 × 3 mm, `minimum_internal_edge_width = 11.8`, 2-part manifest)
  and the plan indexes after archiving to `plans/past/`.

Do not touch:

- `designs/solarpunk_intelligence_hub/src/mockups/backplane_blockout.scad`
  (frozen reference)
- `agentic-pipelines/**`
- any other design's files or outputs
- `revisions/**`
- `output/solarpunk_seed_tray/**` (pre-existing local changes from prior
  sessions remain uncommitted)

## Checklist

- [x] Create `designs/solarpunk_intelligence_hub/parts.json` (2 parts: printable plate + block-diagram mockup)
- [x] Create `designs/solarpunk_intelligence_hub/configs/rev_0001.json`
- [x] Create `designs/solarpunk_intelligence_hub/src/lib/defaults.scad`
- [x] Create `designs/solarpunk_intelligence_hub/src/parts/solarpunk_intelligence_hub.scad` (plate + 28 M3 holes + asserts)
- [x] Create `designs/solarpunk_intelligence_hub/src/parts/backplane_blockout_mockup.scad` (colored footprint blocks + holes, non-printable reference)
- [x] Create `designs/solarpunk_intelligence_hub/src/main.scad`
- [x] Run complete `designs/solarpunk_intelligence_hub` build to `output/solarpunk_intelligence_hub/`: 2 STL + 34 PNG + manifest, then `--audit-only` passes
- [x] Run the "Rebuild stale CAD designs" task and confirm the design is listed `CURRENT`
- [x] Update `designs/solarpunk_intelligence_hub/README.md` (status, Layout section, 3 mm + M3 decisions, supersedes Ø6 proposal, series link style)
- [x] Update `docs/solarpunk_series.md` (inventory row, short design section, close/resolve open decisions by editing in place)
- [x] Record the checkpoint in `journal/2026-09-20.md`
- [x] Complete and archive the plan (regenerate indexes, verify with `--check`)

## Verification

Build:

```bash
python scripts/scad_build_all.py --design solarpunk_intelligence_hub --config designs/solarpunk_intelligence_hub/configs/rev_0001.json --destination current
python scripts/scad_build_all.py --design solarpunk_intelligence_hub --config designs/solarpunk_intelligence_hub/configs/rev_0001.json --destination current --audit-only
```

Expected: 2 STL + 34 PNG + `build_manifest.json` installed flat in
`output/solarpunk_intelligence_hub/`; audit passes; source/config/provenance
recorded in the manifest; staging removed; part 2 artifacts labeled
non-printable reference in docs.

Pipeline:

- Task "Rebuild stale CAD designs" (`python scripts/rebuild_stale_designs.py
  --all`) exits 0 and lists `CURRENT solarpunk_intelligence_hub:
  designs/solarpunk_intelligence_hub/configs/rev_0001.json`.

Structure:

- `tree output/solarpunk_intelligence_hub` shows exactly the expected files,
  no directories, no `.scad` files.
- STL present and non-trivial size.

Docs:

- `designs/solarpunk_intelligence_hub/README.md` status/build section reflects
  the rev_0001 artifacts.
- `docs/solarpunk_series.md` §3 table includes the hub row; its section
  matches the build.
- Journal entry appended; plan fully checked and archived; plan indexes
  regenerated and `--check` clean.

Risks and fallbacks:

- A render warning aborts a part PNG → inspect the CLI output; old-CLI
  `color('gray80')` warnings are benign (same as other designs). If a part
  fails, the pipeline rolls back the staging and leaves
  `output/solarpunk_intelligence_hub/` untouched; fix source and retry.
- If `assert()` fires during build, the failing inequality is printed; adjust
  the parameter set (not the asserts) unless the assert encodes a wrong
  premise vs. the approved decisions.
- If the indexer `--check` fails, rerun the regenerate command; do not hand
  edit index files.

## Journal / Commit Policy

- Before any commit, append a work-log entry to
  `journal/2026-09-20.md` (agent-managed sections only).
- No commit and no push — I will stop at verified artifacts + docs and report
  back with the mandatory completion summary; commit only on your approval.