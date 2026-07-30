---
plan_id: 2026-07-29-22-15-00_enclose-cyberdeck-2-screen-and-open-lower-roof
title: Enclose Cyberdeck-2 Screen Wedge and Open Its Lower Roof
summary: Add the angled screen section's roof and rear closure while cutting the lower roof below it only outside the rear seam screw-block zone.
status: future
created_at: 2026-07-29-22-15-00
---

# Enclose Cyberdeck-2 Screen Wedge and Open Its Lower Roof

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Direction and Boundary Contract

The existing integral wall at model `Y = 215 mm` remains the user-facing front.
The screen wedge is at model `Y = 0` (the back). Its 45-degree screen face still
points toward `+Y`. This change encloses only the screen section above the lower
chassis: a horizontal upper roof and a vertical back wall at `Y = 0` will join
the existing angled face rails and outer support walls. The face aperture remains
open for the future screen module.

The lower chassis's current 3 mm top plate will be removed directly beneath the
screen enclosure, from immediately after the rearward seam screw-block zone to
the screen wedge's forward footprint. The existing top seam socket/head/nut
structure occupies `Y = 0..24 mm`, centered on the rearward screw at `Y = 12`;
it is expressly preserved. The planned roof opening therefore begins at
`Y = 24 mm` (with no cut into that screw-block zone), ends at the named outer
screen-foot boundary, and leaves both 3 mm exterior side walls intact.

## 1. Define the New Enclosure and Roof-Opening Contracts

- [ ] 1.1 Add named parameters for the upper screen roof thickness, rear-wall
  thickness, lower-roof opening bounds, end rim/engagement, and all derived
  45-degree wedge vertices. Preserve the existing 50.8 mm normal rear envelope,
  254 mm outer width, 222.25 x 88.90 mm screen aperture, and 3 mm minima.
- [ ] 1.2 Assert the roof opening starts no closer than the completed rear seam
  block (`Y = seam_pad_depth`), does not cut any seam head, nut, socket, tongue,
  or screw passage, and keeps at least 3 mm material at every remaining roof
  edge and side-wall ligament.
- [ ] 1.3 Define the horizontal upper roof and `Y = 0` rear wall as the screen
  enclosure's only new closed surfaces. State that the screen face aperture,
  M3 rails, screen hardware, cable route, and future lid remain separately
  scoped.

## 2. Build the Continuous Two-Leaf Screen Enclosure

- [ ] 2.1 Add the horizontal roof from the face's upper edge to the rear wall;
  attach it to both outer angled support walls and the rear wall with at least
  3 mm positive-volume overlap. Keep it split solely at the existing `X = 0`
  printable-leaf division.
- [ ] 2.2 Add the full-width vertical rear screen wall at `Y = 0`, with a
  continuous 3 mm structural engagement to the upper roof and outer supports.
  Do not create a third printable leaf or obstruct the screen face aperture.
- [ ] 2.3 Subtract the bounded lower-roof opening below the screen enclosure:
  preserve the `Y = 0..24 mm` top screw-block zone, the outer side-wall strips,
  and a 3 mm forward rim. Confirm the opening is unobstructed from the lower
  chassis top through the screen enclosure interior.
- [ ] 2.4 Re-evaluate the lower receiver's 2U bay, its front/rear closure,
  device rails, all twelve rail bores, and all four seam stations after the
  roof cut. No existing required interface may be occluded or severed.

## 3. Verification Views and Structural Evidence

- [ ] 3.1 Add assertions for every screen roof/rear-wall/support intersection,
  roof-opening-to-seam margin, remaining roof rim/side material, face-normal
  depth, 45-degree geometry, print span, and lower receiver preservation.
- [ ] 3.2 Add governed sections through the rear screw-block boundary, the
  start/mid/end of the roof opening, the screen roof/rear-wall corner, and both
  ends of the upper roof. Review the complete assembled, screen-only, and
  exploded geometry with the screen aperture visible.
- [ ] 3.3 Re-check both print-oriented leaf spans against the reserved 215 mm
  axis, and record physical/slicer limitations for the new roof bridge and
  screen-enclosure joints.

## 4. Build, Review, and Checkpoint

- [ ] 4.1 Build the complete two-part manifest through `scad_build_all.py` into
  only `output/cyberdeck-2/`; then render and audit the full artifact-bound
  assembly review in that same directory.
- [ ] 4.2 Pass the rack reference validator, assembly contract, OpenSCAD
  assertions, exact printable/unified artifact audits, bounds and connectivity
  checks, and real-artifact visual review.
- [ ] 4.3 Update Cyberdeck-2 design, rack/depth, fastener/structure, validation,
  assembly-review, and journal records with exact geometry, output hashes, and
  remaining physical unknowns. Archive the plan, review the full diff, commit
  the approved checkpoint, and push only if requested.

## Planned Files

- `designs/cyberdeck-2/configs/rev_0001.json`
- `designs/cyberdeck-2/src/lib/defaults.scad`
- `designs/cyberdeck-2/src/parts/enclosure_blockout.scad`
- `designs/cyberdeck-2/assembly.json`
- `designs/cyberdeck-2/docs/*.md`
- `journal/2026-07-29.md`
- this plan and plan indexes

## Acceptance

The angled screen area is a coherent, two-leaf enclosure with a roof and rear
wall. The lower top plate is open below the screen only from `Y = 24 mm` to the
screen-foot boundary, leaving the rear `Y = 0..24 mm` screw blocks and every
seam screw/recess fully intact and usable. All retained and new load paths have
documented 3 mm structural overlap and internal material, and the lower 2U
receiver remains functional. The exact screen panel, its mount stack, cable
route, and physical print validation remain explicitly unverified until supplied
or tested.
