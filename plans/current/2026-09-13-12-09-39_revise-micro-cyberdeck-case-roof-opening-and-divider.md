---
plan_id: 2026-09-13-12-09-39_revise-micro-cyberdeck-case-roof-opening-and-divider
title: Raise Micro Cyberdeck Case, Reposition microSD Opening, and Add Battery Divider
summary: Create and verify a rev_0003 candidate with a 5 mm taller case, repositioned left-wall microSD opening, and an internally supported battery/SBC divider.
status: current
created_at: 2026-09-13-12-09-39
---

# Raise Micro Cyberdeck Case, Reposition microSD Opening, and Add Battery Divider

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Locked scope and assumptions

- Baseline: verified mutable `rev_0002` candidate at `designs/micro_cyberdeck_case/configs/rev_0002.json`.
- Proposed revision/config: new `configs/rev_0003.json`; preserve revisions 0001 and 0002 unchanged and independently rebuildable.
- Interior width and depth remain 67 x 37 mm; floor and wall thickness remain 3 mm.
- Increase the interior height from 37 mm to 42 mm. The outer envelope becomes 73 x 43 x 45 mm.
- Move the 15 x 10 mm left-wall opening 5 mm toward the open front: center `y = 21` to `y = 16`, represented by a back-outer-edge offset of 27 mm.
- Reposition the opening so its bottom edge is flush with the divider top surface: center `z = 23`, represented by 20 mm above the internal floor surface.
- Opening bounds become `y = 8.5..23.5` and `z = 18..28`; the bottom edge is coplanar with the divider top surface at `z = 18` (enforced by an assert); resulting material margins are 8.5 mm front, 19.5 mm back, 17 mm below the new 45 mm rim, and solid left-wall material from the floor up to `z = 18`.
- The exact 15 x 10 mm nominal opening, Boolean epsilon, open front/top, and physical-fit/slicer limitations remain unchanged.
- Add one 3 mm-thick internal divider between the battery compartment and the SBC compartment. Its underside is at `z = 15`, exactly 12 mm above the existing floor's inside top surface at `z = 3`; its upper surface is at `z = 18`.
- Divider footprint: the nominal internal 67 x 37 mm footprint from `x = 3..70`, `y = 3..40`, extended through the left/right side walls and back wall for 3 mm of full-seam structural overlap. It terminates at the open front datum `y = 3` and does not create a front wall.
- Divider support contract: the internal floor is supported continuously by both side walls and the back wall; its three structural overlap values are each 3 mm, satisfying the two-support requirement without a cantilever load case.
- Add a front-left divider-only cable pass-through notch. It leaves the left enclosure wall intact while removing the divider through its full 3 mm thickness over `x = 0..8`, `y = 3..13`, `z = 15..18`. This creates a 5 mm clear route from the left wall's inside face at `x = 3` to the divider at `x = 8`, across the front 10 mm of divider depth.
- The notch reduces the divider's left-wall support along `y = 3..13`; the repositioned microSD opening sits at `z = 18..28` and no longer intersects the divider (`z = 15..18`), so the post-cut left-wall engagement is `y = 13..43`, or 30 mm long. Right-wall and back-wall support seams remain continuous and unchanged. The notch is constructed into the divider before it is unioned with the enclosure, so it cannot cut the left enclosure wall.
- The front-left divider region has a 10 mm unsupported projection because of the cable notch. It is an explicit low-load cantilever from the continuously supported divider body; load capacity remains unverified until the battery/SBC stack mass, material, print orientation, and slicer paths are specified.
- The battery, SBC, wiring, and actual battery-to-divider air gap are not modeled. The 12 mm dimension is a nominal face-to-face compartment gap; battery thickness, thermal needs, electrical clearances, and service access remain unverified pending physical component data.
- Expected mutable output: one rev_0003 STL and 17 rev_0003 PNGs in `output/micro_cyberdeck_case/`, replacing the current output set.
- Publication gate: candidate only; no immutable revision snapshot, commit, or push without separate approval.

- [ ] 1. Add the revision 0003 configuration and structural divider.
  - [x] 1.1 Create `configs/rev_0003.json` with the raised interior height, revised opening center parameters (final: 20 mm above the internal floor), and divider dimensions.
  - [x] 1.2 Preserve revision 0001 and 0002 configs and confirm their distinct geometries remain available through their explicit config values.
  - [x] 1.3 Add named divider dimensions, side/back overlap assertions, supported-span assertions, and the opening-bottom-flush-with-divider-top assertion.
  - [x] 1.4 Construct the divider with continuous positive-volume engagement into both side walls and the back wall, without closing the front.
  - [x] 1.5 Add the 5 x 10 mm front-left divider-only cable pass-through notch and assert the remaining 30 mm post-cut left-wall support seam, uninterrupted right/back supports, intact left enclosure wall, and explicit 10 mm low-load cantilever limitation.
- [ ] 2. Update documentation.
  - [ ] 2.1 Record revision 0003 dimensions, opening bounds, cable pass-through notch, material margins, divider support/overlap, and unverified battery/SBC assumptions in the design README.
  - [ ] 2.2 Update the root README summary to the 73 x 43 x 45 mm outer envelope and 67 x 37 x 42 mm nominal interior.
- [ ] 3. Build and verify installed revision 0003 artifacts.
  - [ ] 3.1 Run the dry run and confirm the revision-specific inputs, expected artifact set, and output destination.
  - [x] 3.2 Replace the mutable output with a complete rev_0003 build.
  - [ ] 3.3 Confirm 73 x 43 x 45 mm STL bounds, 15 x 10 mm opening coordinates, open top/front, visible left-wall opening, and divider bounds at `z = 15..18`.
  - [ ] 3.4 Inspect divider sections through its remaining left support, uninterrupted right/rear supports, midpoint, open front termination, and cable pass-through notch; verify 3 mm positive overlap, 5 mm clear cable route, and intact left enclosure wall.
  - [ ] 3.5 Recheck opening post-cut margins, wall/floor and rear-corner structural sections, connectivity, and exact output set; retain battery, SBC, slicer, and physical-fit checks as unverified.
- [ ] 4. Close the governed checkpoint without committing or pushing automatically.
  - [ ] 4.1 Append the work and evidence to `journal/2026-09-13.md`.
  - [ ] 4.2 Review task-scoped changes, regenerate/check plan indexes, and archive the completed plan.
  - [ ] 4.3 Report results and propose a commit message; seek separate approval for commit/push.
