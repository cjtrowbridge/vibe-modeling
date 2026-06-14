# Playbook: How to Iterate OpenSCAD Designs

*Status: Draft*

## Objective

Provide a repeatable local workflow to iterate OpenSCAD prototypes, generate multi-view preview images (including below-angle isometric presets) and STL exports, and snapshot numbered design revisions with parameter sets.

## Prerequisites

- Python 3.8+
- OpenSCAD installed locally
- Read and apply `playbooks/how_to_design_and_verify_structural_openscad_joins.md` for any structural geometry
- Either:
  - `openscad` available on `PATH`, or
  - provide `--openscad-path` to the build scripts
- Run commands from the repository root

## Step-by-Step Instructions

1. **Create a new revision folder (checkpoint)**
   - Start each chunk of work by snapshotting a new revision folder so you have a stable baseline.
   - Example:
     - `python scripts/scad_new_revision.py --design example_box --base-config designs/example_box/configs/rev_0001.json`
   - Expected:
     - `revisions/example_box/rev_0002/`
     - `revisions/example_box/rev_0002/params.json`
     - `designs/example_box/configs/rev_0002.json`
     - (if OpenSCAD is available) STL + multi-view PNG artifacts in the revision folder

2. **Establish the structural contract**
   - Define `minimum_wall_thickness`.
   - Define `minimum_structural_overlap` and assert that it is at least `minimum_wall_thickness`.
   - Inventory every new or changed structural join, including walls, floors, roofs, rails, lips, rims, bosses, webs, mounting pads, and angled surfaces.
   - For each join, identify its named overlap parameter, full seam length, and minimum remaining throat.
   - Inventory every internal edge, rim, rail, flange, web, bridge, and material strip around or between voids.
   - For each internal edge, identify and assert its minimum remaining material width.
   - Treat fit clearances and numerical tolerances separately. They do not count toward structural overlap.

3. **Implement the requested design changes**
   - Edit `.scad` files under `designs/<design>/src/` and/or the selected config JSON.
   - Build each intended structural connection with deliberate positive-volume intersection.
   - Do not rely on coincident endpoints, coplanar faces, tangent edges, or epsilon-sized overlaps.

4. **Loop: build artifacts -> inspect -> revise**
   1. Build scratch outputs:
      - `python scripts/scad_build.py --design example_box --config designs/example_box/configs/rev_0002.json`
      - For a design with `parts.json`, build the authoritative complete set with:
        - `python scripts/scad_build_all.py --design <design> --config designs/<design>/configs/rev_000N.json`
   2. Inspect the generated outputs in `output/<design>/`.
   3. Inspect sectional views through the start, midpoint, and end of every changed structural seam.
   4. Confirm every terminating member engages the joined material by at least `minimum_structural_overlap`.
   5. Confirm the load path never narrows below `minimum_wall_thickness`.
   6. Confirm no internal edge or material strip is narrower than `minimum_wall_thickness`, including material around holes and between adjacent voids.
   7. Inspect the final post-`difference()` geometry; earlier valid overlap or edge width may have been cut away.
   8. Check for unexpected disconnected positive-volume shells.
   9. Apply revisions and repeat until satisfied.
   10. For a complete multi-part build, run the artifact audit:
       - `python scripts/scad_build_all.py --design <design> --config designs/<design>/configs/rev_000N.json --audit-only`

5. **Finalize and commit**
   - Record the structural verification result for the exact config/revision.
   - Include both the structural-join review and minimum-edge review in the final summary.
   - Do not describe the model as print-ready or fabrication-ready if any structural gate remains incomplete.
   - Follow `playbooks/how_to_commit_and_push_changes.md`
   - Review status/diff, propose commit message, and commit after approval

## Notes

- Parameter files live in `designs/<design>/configs/`.
- Prefer numeric `part_id` values in configs.
- Scratch outputs go in `output/<design>/` (ignored by git).
- Revision outputs go in `revisions/<design>/rev_000N/` (ignored by git).
- Probes, sections, partial builds, and staging go in `.tmp/scad/<design>/` (ignored by git).
- Do not invent artifact directories. In particular, `output/<design>_rev_000N/` is invalid.
- Do not put `.scad` source or probe files in `output/` or `revisions/`.
- Only commit source (`.scad`) and config (`configs/*.json`) unless explicitly keeping generated examples.
- `scad_build.py` always renders the full PNG preset set (all named isometric + orthographic views, including below/inspection views) and fails the run if any expected PNG is missing.
- `scad_build_all.py` stages every manifest part, validates exact artifact names/counts, writes hashes and provenance to `build_manifest.json`, and replaces the current output directory only after all parts succeed.
- Never copy a complete build over an existing output directory. Complete-build installation must replace the directory as one validated unit.
- Numbered revision directories are immutable. Create another revision instead of rebuilding changed geometry into an existing revision.
- OpenSCAD render success and STL manifoldness do not establish structural integrity. Structural parameter assertions, section inspection, and shell/connectivity inspection are separate required gates.

## Verification

- Run a scratch build (or `--dry-run`) and confirm the script resolves paths and prints STL + multi-view PNG OpenSCAD commands.
- Create a revision snapshot and confirm the next numbered config + revision folder are created.
- Confirm structural assertions pass.
- Confirm each intended join has the required positive-volume overlap for its full seam after all subtraction operations.
- Confirm every internal edge and remaining material strip is at least `minimum_wall_thickness` wide.
- Confirm no unexpected disconnected positive-volume shells remain.
- For manifest-driven builds, confirm `--audit-only` reports the expected part, STL, PNG, and total artifact counts with no unexpected files.
- Confirm config, parts-manifest, source-tree, and artifact hashes match `build_manifest.json`.
- Confirm no `.scad` files exist in `output/` or `revisions/`.

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification

If inside a git repo:

- Review `git status -sb` and diffs
- Suggest a commit message
- Commit after completion
