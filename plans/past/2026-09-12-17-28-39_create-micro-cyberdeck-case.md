---
plan_id: 2026-09-12-17-28-39_create-micro-cyberdeck-case
title: Create Micro Cyberdeck Open Case Blockout
summary: Add a single-piece open-top, open-front rectangular case with a 65 x 37 x 37 mm nominal interior and explicit 3 mm structural walls and floor.
status: past
created_at: 2026-09-12-17-28-39
---

# Create Micro Cyberdeck Open Case Blockout

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Locked scope and assumptions

- Design name: `micro_cyberdeck_case`.
- Printable export: one monolithic case body; no `parts.json` or assembly contract is needed.
- Geometry: sharp-cornered rectangular floor with the back and two short side walls; the top, interior, and front long face at `y = 0` remain completely open.
- Nominal equipment envelope: 65 mm wide (x), 37 mm deep (y), and 37 mm tall (z), retaining the original four-wall cavity datum between `y = 3` and the back wall's inside face at `y = 40`; the omitted front wall opens this envelope to the outer edge.
- Structural dimensions: 3 mm floor and 3 mm remaining walls, producing a 71 x 43 x 40 mm exterior envelope. The rectangular floor remains intact, including the 3 mm apron under the omitted front-wall zone.
- Proposed config: `designs/micro_cyberdeck_case/configs/rev_0001.json`; this is the first mutable candidate and will not be published to immutable `revisions/` in this initial blockout task.
- Print orientation: floor flat on the bed. Printer/process, slicer layer paths, and physical fit remain unverified unless the user supplies those constraints.
- Expected scratch artifacts: one STL and 17 PNG files in `output/micro_cyberdeck_case/`.
- Rollback response: if a structural, render, or dimensional gate fails, keep the candidate source/config and report the failure; do not publish or describe it as fabrication-ready.

- [x] 1. Add the governed single-part OpenSCAD design.
  - [x] 1.1 Create `src/main.scad`, `src/lib/defaults.scad`, and `src/parts/case_body.scad` with numeric `part_id` dispatch.
  - [x] 1.2 Define the 65 x 37 x 37 mm nominal interior, omitted front wall, 3 mm floor/remaining walls, derived occupied envelope, and parameter assertions.
  - [x] 1.3 Construct the body as one continuous solid with named, full-thickness remaining-wall-to-floor and corner engagement.
  - [x] 1.4 Add `configs/rev_0001.json` for the single printable case-body export.
- [x] 2. Document the design and verification scope.
  - [x] 2.1 Add `designs/micro_cyberdeck_case/README.md` with dimensions, export classification, build command, structural inventory, and explicit unverified physical/slicer checks.
  - [x] 2.2 Update the root `README.md` included-design inventory without disturbing unrelated working-tree changes.
- [x] 3. Build and inspect the exact candidate artifacts.
  - [x] 3.1 Run the single-part build dry run and confirm the resolved source, config, destination, and expected one-STL/seventeen-PNG set.
  - [x] 3.2 Run the full scratch build into `output/micro_cyberdeck_case/` and confirm exact artifact counts.
  - [x] 3.3 Inspect installed renders and STL bounds for the open top, completely open front long face, unobstructed 65 x 37 x 37 mm equipment envelope, intact front floor apron, and 71 x 43 x 40 mm exterior.
  - [x] 3.4 Verify parameter assertions, full remaining-wall-to-floor/corner structural continuity, 3 mm minimum material width, and absence of unexpected disconnected shells; record any slicer-only checks as unverified.
- [x] 4. Close the governed checkpoint without publishing or committing automatically.
  - [x] 4.1 Record the repository-state change in today's append-only journal work log.
  - [x] 4.2 Review the complete task-scoped diff, preserve unrelated changes, regenerate/check plan indexes, and archive this plan when no execution remains.
  - [x] 4.3 Report results and suggest an imperative commit message; request separate approval before any commit or push.
