---
plan_id: 2026-09-13-01-54-03_revise-micro-cyberdeck-case-width-and-microsd-opening
title: Revise Micro Cyberdeck Case Width and Add microSD Opening
summary: Create and verify a rev_0002 candidate with a 67 mm interior width and a positioned microSD access opening through the left wall.
status: past
created_at: 2026-09-13-01-54-03
---

# Revise Micro Cyberdeck Case Width and Add microSD Opening

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Locked scope and assumptions

- Baseline: mutable candidate `designs/micro_cyberdeck_case/configs/rev_0001.json` and its installed scratch artifacts.
- Proposed revision/config: new `designs/micro_cyberdeck_case/configs/rev_0002.json`; preserve `rev_0001.json` unchanged.
- Increase the nominal interior width from 65 mm to 67 mm.
- Retain the 37 mm interior depth, 37 mm interior height, open top, completely open front long face, intact floor apron, and 3 mm floor/walls.
- Derived exterior envelope: 73 x 43 x 40 mm.
- Add one rectangular through-opening in the left wall (`x = 0..3`). Its 15 mm width runs front-to-back, its 10 mm height runs vertically, and it cuts fully through the wall thickness with Boolean epsilon kept separate from functional dimensions.
- Opening center: 22 mm forward from the outer back edge (`y = 43`), giving `y = 21`; 12 mm above the inside floor surface (`z = 3`), giving `z = 15`.
- Opening bounds: `y = 13.5..28.5` and `z = 10..20`.
- Post-cut material margins: 13.5 mm to the outer front edge, 14.5 mm to the outer back edge, 7 mm above the internal floor, and 20 mm below the rim; all exceed the 3 mm minimum material width.
- Fit classification: exact nominal access opening, 15 x 10 mm, with no printer/process compensation or additional clearance. Physical microSD card-through fit is unverified.
- Publication gate: this iteration remains a mutable candidate and will not create an immutable `revisions/` snapshot.
- Expected installed artifacts: one STL and seventeen PNG files in `output/micro_cyberdeck_case/`, replacing the current mutable output set.
- Rollback response: if any assertion, render, dimension, section, connectivity, or exact-set check fails, preserve `rev_0001`, report the failure, and do not represent `rev_0002` as verified.

- [x] 1. Add the width and opening candidate without changing revision 0001.
  - [x] 1.1 Add `configs/rev_0002.json` with a 67 mm interior width and revision-specific export name.
  - [x] 1.2 Add named parameters and assertions for the microSD opening size, center offsets, cut-through depth, and post-cut edge margins.
  - [x] 1.3 Replace the revision-0001-only width assertion with parameter-safe derived-dimension assertions while preserving the structural contracts.
  - [x] 1.4 Subtract the microSD opening only from the left wall, keeping Boolean epsilon distinct from its 15 x 10 mm functional opening.
- [x] 2. Update documentation for revision 0002.
  - [x] 2.1 Add the revision 0002 dimensions, opening datum, fit limitations, and verification record to the design README while preserving revision 0001 provenance.
  - [x] 2.2 Update the root README design summary from 65/71 mm to 67/73 mm without disturbing unrelated working-tree changes.
- [x] 3. Build and verify the exact revision 0002 artifacts.
  - [x] 3.1 Run the dry run and confirm the 67 mm input, 73 mm derived width, destination, and expected one-STL/seventeen-PNG set.
  - [x] 3.2 Build the complete single-part scratch artifact set from `rev_0002.json` into `output/micro_cyberdeck_case/`.
  - [x] 3.3 Confirm exact STL bounds of 73 x 43 x 40 mm and visually inspect the installed open-top/open-front views and left-wall opening.
  - [x] 3.4 Measure or section the installed opening at its start, midpoint, end, and corners; verify 15 x 10 mm clear bounds and the named post-cut material margins.
  - [x] 3.5 Re-run structural sections, post-subtraction wall/floor and rear-corner checks, minimum-width checks, connectivity review, and exact output-set audit; keep printer, physical-fit, and slicer checks explicitly unverified.
- [x] 4. Close the governed checkpoint without committing or pushing automatically.
  - [x] 4.1 Append the completed change and evidence to `journal/2026-09-13.md`.
  - [x] 4.2 Review the task-scoped diff, regenerate/check plan indexes, and archive the plan when complete.
  - [x] 4.3 Report results and suggest an imperative commit message; require separate approval for any commit or push.
