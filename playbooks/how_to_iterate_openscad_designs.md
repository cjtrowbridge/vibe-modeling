# Playbook: How to Iterate OpenSCAD Designs

*Status: Draft*

## Objective

Provide a repeatable local workflow to iterate OpenSCAD prototypes, generate multi-view preview images (including below-angle isometric presets) and STL exports, and snapshot numbered design revisions with parameter sets.

## Prerequisites

- Python 3.8+
- OpenSCAD installed locally
- Read and apply `playbooks/how_to_design_and_verify_structural_openscad_joins.md` for any structural geometry
- Read `playbooks/how_to_create_verify_and_publish_immutable_openscad_revisions.md`
- For manifest designs, read `playbooks/how_to_build_install_and_audit_manifest_driven_openscad_designs.md`
- For multipart designs, read the canonical-product-decomposition and multipart
  assembly-artifact playbooks and validate `assembly.json` before detailed work
- Either:
  - `openscad` available on `PATH`, or
  - provide `--openscad-path` to the build scripts
- Run commands from the repository root

## Step-by-Step Instructions

1. **Prepare a mutable candidate revision**
   - Identify the next unused revision number across committed configs and generated revisions.
   - Create the candidate config in `designs/<design>/configs/rev_000N.json`.
   - Do not create `revisions/<design>/rev_000N/` yet. A numbered revision is the final immutable publication, not a mutable starting checkpoint.
   - Record the baseline commit/config in the active host plan.

2. **Establish the structural contract**
   - Define `minimum_wall_thickness`.
   - Define `minimum_structural_overlap` and assert that it is at least `minimum_wall_thickness`.
   - Inventory every new or changed structural join, including walls, floors, roofs, rails, lips, rims, bosses, webs, mounting pads, and angled surfaces.
   - For each join, identify its named overlap parameter, full seam length, and minimum remaining throat.
   - Inventory every internal edge, rim, rail, flange, web, bridge, and material strip around or between voids.
   - For each internal edge, identify and assert its minimum remaining material width.
   - Treat fit clearances and numerical tolerances separately. They do not count toward structural overlap.

3. **Implement the requested design changes**
   - Edit `.scad` files under `designs/<design>/src/` and/or the staged candidate config.
   - Build each intended structural connection with deliberate positive-volume intersection.
   - Do not rely on coincident endpoints, coplanar faces, tangent edges, or epsilon-sized overlaps.

4. **Loop: build artifacts -> inspect -> revise**
   - Apply gates in dependency order: intent/decomposition, complete manifest
     build and installed-artifact audit/review, artifact-bound assembly review,
     interface conformance, then structural/fit/printability. A later passing
     gate cannot override an earlier fail.
   - Rebuild/audit current output and then regenerate the compact assembly set
     after every architecture-affecting change. Render the full set at blockout,
     detailed-geometry, and release milestones.
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

5. **Publish, document, and commit**
   - Follow `playbooks/how_to_create_verify_and_publish_immutable_openscad_revisions.md` only after the candidate passes all gates.
   - Use `scripts/scad_new_revision.py` at publication time with the approved staged config as `--base-config`.
   - Confirm the script selected the intended unused revision and copied the staged parameters exactly.
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
- Probes, sections, partial builds, and staging remain inside
  `output/<design>/`; successful governed commands leave a flat exact set.
- Do not invent artifact directories. In particular, `output/<design>_rev_000N/` is invalid.
- Completed outputs contain no `.scad` source, probe file, or staging directory.
- Only commit source (`.scad`) and config (`configs/*.json`) unless explicitly keeping generated examples.
- `scad_build.py` always renders the full PNG preset set (all named isometric + orthographic views, including below/inspection views) and fails the run if any expected PNG is missing.
- `scad_build_all.py` stages every manifest part inside the design output,
  validates exact artifact names/counts, writes hashes and provenance to
  `build_manifest.json`, promotes transactionally, and removes staging.
- Never overlay-copy a complete build. Use the governed transactional promotion
  and rollback path.
- Numbered revision directories are immutable. Create another revision instead of rebuilding changed geometry into an existing revision.
- Do not call `scad_new_revision.py` before candidate geometry/config verification; doing so would publish an immutable snapshot before the work it is meant to represent.
- OpenSCAD render success and STL manifoldness do not establish structural integrity. Structural parameter assertions, section inspection, and shell/connectivity inspection are separate required gates.

## Verification

- Run a scratch build (or `--dry-run`) and confirm the script resolves paths and prints STL + multi-view PNG OpenSCAD commands.
- Publish only after scratch verification, then confirm the next numbered config and revision folder were created exactly once.
- Confirm structural assertions pass.
- Confirm each intended join has the required positive-volume overlap for its full seam after all subtraction operations.
- Confirm every internal edge and remaining material strip is at least `minimum_wall_thickness` wide.
- Confirm no unexpected disconnected positive-volume shells remain.
- For manifest-driven builds, confirm `--audit-only` reports the expected part, STL, PNG, and total artifact counts with no unexpected files.
- Confirm config, parts-manifest, source-tree, and artifact hashes match `build_manifest.json`.
- For multipart designs, confirm the assembly-contract validator and
  `assembly_review_manifest.json` audit match the same config, source,
  `parts.json`, `assembly.json`, and Git state.
- Confirm no `.scad` files exist in `output/` or `revisions/`.

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification

If inside a git repo:

- Review `git status -sb` and diffs
- Suggest a commit message
- Commit after completion
