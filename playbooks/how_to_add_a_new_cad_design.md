# Playbook: How to Add a New CAD Design

*Status: Draft*

## Objective

Add a new OpenSCAD design under `designs/<design>/` with its own source tree and configs while preserving the repository's shared folder conventions.

## Prerequisites

- Python 3.8+
- OpenSCAD installed locally (only required for full build verification)
- Run commands from the repository root

## Step-by-Step Instructions

1. **Choose a design name**
   - Use a short descriptive folder name (e.g., `enclosure_clip`, `panel_bracket`).

2. **Create the design folder layout**
   - Create:
     - `designs/<design>/src/main.scad`
     - `designs/<design>/src/lib/defaults.scad`
     - `designs/<design>/src/parts/<part>.scad`
     - `designs/<design>/configs/rev_0001.json`
   - Keep `main.scad` as the scripted export entrypoint that selects a part via numeric `part_id`.

3. **Classify exports and decide manifest ownership**
   - Inventory printable parts, assembly previews, cutters, and reference mockups using `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md`.
   - If the design has multiple authoritative printable/reference exports, create `parts.json` immediately.
   - Use unique stable numeric IDs and names, and keep `main.scad` dispatch synchronized with the manifest.

4. **Add at least one config**
   - Create `rev_0001.json` with:
     - `part_id` (numeric)
     - optional `part` string for output naming
     - any parameters used by the design

5. **Establish structural design constants**
   - Read `playbooks/how_to_design_and_verify_structural_openscad_joins.md`.
   - Define `minimum_wall_thickness`.
   - Define `minimum_structural_overlap`.
   - Assert `minimum_structural_overlap >= minimum_wall_thickness`.
   - Use named overlap parameters for every structural wall, floor, roof, rail, lip, rim, boss, web, or mounting feature.
   - Use named minimum-width parameters for internal edges and material strips around or between voids.

6. **Document the design**
   - Update `README.md` if repository layout, commands, or examples changed.
   - Document the design's minimum wall thickness, minimum structural overlap, and minimum internal edge width in its design README.
   - If the workflow changed, update `playbooks/how_to_iterate_openscad_designs.md`.
   - If playbooks were added/removed/renamed, update `AGENTS.md`.

7. **Verify**
   - Dry-run build:
     - `python scripts/scad_build.py --design <design> --config designs/<design>/configs/rev_0001.json --dry-run`
   - Confirm `main.scad` resolves and STL + multi-view PNG commands are printed.
   - For manifest designs, dry-run and then audit the complete set using `scripts/scad_build_all.py`.
   - Complete the structural section and connectivity checks from the structural-joins playbook.

8. **Finalize**
   - Follow `playbooks/how_to_create_verify_and_publish_immutable_openscad_revisions.md` for the first immutable publication.
   - Follow `playbooks/how_to_commit_and_push_changes.md`
   - Review status/diff, propose commit message, commit after approval

## Verification

- `scad_build.py --dry-run` succeeds for `rev_0001.json`
- Multi-part designs have a synchronized, passing `parts.json` complete build
- Structural assertions pass and all intended joins meet the minimum overlap contract
- Every internal edge and remaining material strip meets the minimum wall-thickness contract
- No unexpected disconnected positive-volume shells remain
- Repository docs remain consistent with the new design structure

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification

If inside a git repo:

- Review `git status` and diffs
- Suggest a commit message
- Commit after completion
