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

3. **Add at least one config**
   - Create `rev_0001.json` with:
     - `part_id` (numeric)
     - optional `part` string for output naming
     - any parameters used by the design

4. **Document the design**
   - Update `README.md` if repository layout, commands, or examples changed.
   - If the workflow changed, update `playbooks/how_to_iterate_openscad_designs.md`.
   - If playbooks were added/removed/renamed, update `AGENTS.md`.

5. **Verify**
   - Dry-run build:
     - `python scripts/scad_build.py --design <design> --config designs/<design>/configs/rev_0001.json --dry-run`
   - Confirm `main.scad` resolves and STL + multi-view PNG commands are printed.

6. **Finalize**
   - Follow `playbooks/how_to_commit_and_push_changes.md`
   - Review status/diff, propose commit message, commit after approval

## Verification

- `scad_build.py --dry-run` succeeds for `rev_0001.json`
- Repository docs remain consistent with the new design structure

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification

If inside a git repo:

- Review `git status` and diffs
- Suggest a commit message
- Commit after completion
