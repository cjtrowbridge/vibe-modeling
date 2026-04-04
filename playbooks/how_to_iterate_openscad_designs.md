# Playbook: How to Iterate OpenSCAD Designs

*Status: Draft*

## Objective

Provide a repeatable local workflow to iterate OpenSCAD prototypes, generate multi-view preview images (including below-angle isometric presets) and STL exports, and snapshot numbered design revisions with parameter sets.

## Prerequisites

- Python 3.8+
- OpenSCAD installed locally
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

2. **Implement the requested design changes**
   - Edit `.scad` files under `designs/<design>/src/` and/or the selected config JSON.

3. **Loop: build artifacts -> inspect -> revise**
   1. Build scratch outputs:
      - `python scripts/scad_build.py --design example_box --config designs/example_box/configs/rev_0002.json`
   2. Inspect the generated outputs in `output/<design>/`.
   3. Apply revisions and repeat until satisfied.

4. **Finalize and commit**
   - Follow `playbooks/how_to_commit_and_push_changes.md`
   - Review status/diff, propose commit message, and commit after approval

## Notes

- Parameter files live in `designs/<design>/configs/`.
- Prefer numeric `part_id` values in configs.
- Scratch outputs go in `output/<design>/` (ignored by git).
- Revision outputs go in `revisions/<design>/rev_000N/` (ignored by git).
- Only commit source (`.scad`) and config (`configs/*.json`) unless explicitly keeping generated examples.
- `scad_build.py` always renders the full PNG preset set (all named isometric + orthographic views, including below/inspection views) and fails the run if any expected PNG is missing.

## Verification

- Run a scratch build (or `--dry-run`) and confirm the script resolves paths and prints STL + multi-view PNG OpenSCAD commands.
- Create a revision snapshot and confirm the next numbered config + revision folder are created.

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification

If inside a git repo:

- Review `git status -sb` and diffs
- Suggest a commit message
- Commit after completion
