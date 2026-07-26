# Project Overview & Agent Guidelines

This repository is a reusable OpenSCAD modeling pipeline. Agents should treat the playbooks as executable workflow policy.

## Framework Migration Status

The `./agents` submodule is an upstream framework reference under evaluation. Its
instructions are advisory and are not canonical for this repository yet. Until an
explicit migration checkpoint is approved, this root `AGENTS.md` and the host
`./playbooks/` remain the governing policy and workflows. Do not copy, merge, or
activate framework files from `./agents` without a user-approved migration plan.

## 1. Documentation Integrity

Any code or workflow change should be reflected in docs in the same task.

Review/update these files when relevant:

1. `README.md` (root): project overview, structure, usage, commands
2. `AGENTS.md`: operating rules / playbook index
3. `playbooks/*.md`: workflow instructions

## 2. Operational Protocol

1. Seek a relevant playbook in `playbooks/` first.
2. For any load-bearing, enclosure, mounting, rail, rim, lip, boss, or joined CAD geometry, follow `playbooks/how_to_design_and_verify_structural_openscad_joins.md`.
3. Before making substantial changes:
   - form an atomic plan
   - identify missing info
   - ask for approval when the repo workflow requires it
4. Execute the approved plan.
5. Verify results (commands/tests/builds) and report outcomes.
6. Update docs/playbooks when the workflow changes.
7. Every final task summary must include a structural review result:
   - structural joins: `passed`, `failed`, `unverified`, or `not applicable`
   - minimum internal edge/material width: `passed`, `failed`, `unverified`, or `not applicable`
   - identify the exact revision/config reviewed when CAD geometry changed
8. Every final task summary that builds CAD artifacts must also include:
   - build scope: single part or complete manifest
   - exact destination
   - expected and actual STL/PNG counts
   - artifact audit result
   - config and source provenance result

## 3. Self-Evolving Workflow

Required cycle:

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Docs/playbook update -> Verification

If working in git:

- Check `git status -sb`
- Review diffs
- Suggest a task-scoped commit message
- Commit after a completed change

## 4. Agent Playbooks (Required Index)

Current playbooks:

- `playbooks/how_to_create_a_new_playbook.md` - Create a new operational playbook for repeatable tasks.
- `playbooks/how_to_commit_and_push_changes.md` - Safely summarize, approve, commit, and push changes.
- `playbooks/debugging_changes_that_lead_to_errors.md` - Evidence-first debugging workflow.
- `playbooks/how_to_iterate_openscad_designs.md` - Cross-platform OpenSCAD iteration/build/revision workflow.
- `playbooks/how_to_add_a_new_cad_design.md` - Add a new OpenSCAD design using the shared folder conventions.
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md` - Mandatory structural-overlap and connectivity rules for CAD geometry.

## 5. Project Organization

Keep the repository layout documented in `README.md`.

The intended source-of-truth structure is:

- `scripts/` for automation
- `designs/` for committed OpenSCAD source and configs
- `output/` for scratch outputs (generated)
- `revisions/` for numbered snapshots (generated)
- `playbooks/` for repeatable workflows

Artifact directory names are fixed:

- `output/<design>/` is the only current/scratch destination.
- `revisions/<design>/rev_000N/` is the only numbered revision destination.
- `.tmp/scad/<design>/` is the only location for probes, sections, partial builds, and staging.
- Never create `output/<design>_rev_000N/` or another ad hoc artifact directory.
- Never place `.scad` source/probe files in `output/` or `revisions/`.
- Generated `output/` and `revisions/` files must not be committed.

For a multi-part design with `designs/<design>/parts.json`, use
`scripts/scad_build_all.py`. A directory is not a complete or current build
unless its `build_manifest.json` passes `--audit-only`.

## 6. Logging & Debugging Standards

- Favor scripts that print explicit command paths, inputs, and outputs.
- When adding new automation, include enough logging to diagnose path/config issues quickly.

## 7. Structural CAD Governance

These rules apply to every design unless a design documents a stricter requirement:

- Define `minimum_wall_thickness` explicitly.
- Define `minimum_structural_overlap` explicitly. It must be at least `minimum_wall_thickness`.
- Every intended structural join must have positive-volume intersection with at least `minimum_structural_overlap` of engagement.
- Coplanar faces, shared edges, tangent contact, visual proximity, and tiny numerical epsilon overlaps are not structural joins.
- Structural overlap must continue for the full intended seam and survive all later `difference()` operations.
- The remaining load path or throat at a join must not be thinner than `minimum_wall_thickness`.
- No internal edge, rim, rail, flange, web, bridge, land, or strip of material may be narrower than `minimum_wall_thickness` at any point.
- Material between a void and an exterior edge, or between two voids, must be at least `minimum_wall_thickness`, measured by the shortest path through solid material.
- Fastener holes, recesses, chamfers, and other subtractions must not leave an internal edge margin below `minimum_wall_thickness`.
- For every wall, rail, flange, or web containing multiple cuts, inventory every pair of cuts whose projected bounds can overlap or approach each other. Assert the shortest post-subtraction ligament for each applicable pair; checking each cut only against the outer boundary is insufficient.
- Use named dimensions and `assert()` statements to enforce the construction contract. Do not rely on coordinates that merely appear to meet.
- A successful OpenSCAD render or manifold STL does not prove adequate structural overlap. Perform the sectional and connectivity checks required by the structural-joins playbook.
- Intentionally separate parts and decorative disconnected geometry must be identified as such. Unexpected disconnected shells are failures.
- Do not call a design print-ready or fabrication-ready until the structural verification gates are documented for the exact revision/config being printed.
- Treat existing designs that predate these rules as structurally unverified until audited.

## 8. Artifact Governance

- A part manifest is authoritative for the complete set of exported parts and names.
- Complete builds must render into `.tmp/scad/<design>/` first.
- Validate the complete expected file set before replacing `output/<design>/`.
- Installing a current build must replace the previous directory as one unit. Do not copy new files over old files.
- Reject missing, unexpected, duplicate, stale, or hash-mismatched artifacts.
- Record config, parts-manifest, OpenSCAD source-tree, Git, and artifact hashes in `build_manifest.json`.
- Numbered revision directories are immutable. Geometry or config changes require a new revision.
- A revision number in a filename is not provenance. Provenance requires a passing build-manifest audit.
- Single-part builds are partial by definition and must not be represented as complete-design outputs.
