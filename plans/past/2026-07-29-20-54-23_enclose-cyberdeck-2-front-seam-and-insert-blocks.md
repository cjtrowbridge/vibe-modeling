---
plan_id: 2026-07-29-20-54-23_enclose-cyberdeck-2-front-seam-and-insert-blocks
title: Enclose Cyberdeck-2 Front Seam and Insert Blocks
summary: Add top and bottom front fascia outside the exact 2U clearance and replace exposed seam tongues with structurally enclosed sliding sockets.
status: past
created_at: 2026-07-29-20-54-23
---

# Enclose Cyberdeck-2 Front Seam and Insert Blocks

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## 1. Lock the Interface Contract

- [x] 1.1 Preserve the exact `222.25 x 88.90 mm` front rack opening, the
  220 mm device envelope, twelve canonical rack-insert bores, 215 mm exterior
  depth, rear closure, support rails, and two-leaf decomposition.
- [x] 1.2 Treat the requested sliding margin as approximately `1.0 mm per
  non-insertion face` plus approximately `1.0 mm` tongue-tip clearance; keep
  this fit allowance separate from Boolean epsilon and structural overlap.
- [x] 1.3 Derive the service-zone height and block depth from the complete
  head/tongue/socket/nut stack. Allow the overall chassis height to increase if
  necessary so every cavity wall, fastener ligament, and receiver attachment
  remains at least 3 mm after subtraction.

## 2. Close and Reinforce the Front Face

- [x] 2.1 Add continuous front fascia strips above and below the governed 2U
  opening, spanning across the center seam and positively overlapping both
  outer front rails and their insert-bearing blocks by at least 3 mm.
- [x] 2.2 Keep fascia material entirely outside the rack insertion/removal
  envelope and preserve access, washer support, and tool clearance for all
  twelve front rack fasteners.
- [x] 2.3 Verify that each insert-bearing front rail is enclosed by structural
  material on every required side and has at least 3 mm attachment/load paths
  into the side wall, top/bottom structure, and new fascia after insert bores
  are cut.

## 3. Replace the Exposed Seam Lap with Captured Tongue-and-Socket Joints

- [x] 3.1 Model each center-seam tongue as a positive-volume extension of its
  owning leaf with at least 3 mm root engagement and material around its M3
  passage.
- [x] 3.2 Model a receiving socket on the mating leaf that is open only toward
  the center-seam insertion direction and enclosed on the exterior, bay-facing,
  front/rear, and closed-end faces with walls at least 3 mm thick.
- [x] 3.3 Apply the approximately 1 mm sliding clearance to the socket cavity,
  retain a closed end with tip clearance, and assert the tongue cannot collide
  during the full lengthwise assembly path.
- [x] 3.4 Keep the recessed head, centered through-passage, captive nut, and
  compression load path usable at all four stations without allowing shell or
  enclosure material to occlude any opening.

## 4. Add Decisive Structural and Fit Evidence

- [x] 4.1 Add governed front-face, isolated-leaf, socket-mouth, tongue, and
  longitudinal/normal section views that expose fascia connections and every
  face of the captured joint.
- [x] 4.2 Verify start/midpoint/end socket sections, tongue root overlap,
  cavity-wall thickness, post-fastener ligaments, insert-block attachments,
  and the complete assembly sweep with dimensional assertions and installed
  artifact review.
- [x] 4.3 Reject open-sided pockets, coplanar contacts, sub-3 mm walls or webs,
  obstructed hardware, rack-envelope intrusion, disconnected shells, and any
  recurrence of partial seam openings.

## 5. Rebuild, Document, and Checkpoint

- [x] 5.1 Rebuild the complete printable manifest and full artifact-bound
  assembly set through the normal pipeline into only `output/cyberdeck-2/`.
- [x] 5.2 Pass rack-reference and assembly-contract validators, OpenSCAD
  assertions, exact unified artifact audits, bounds/connectivity checks, and
  visual review of the real combined STL and governed PNGs.
- [x] 5.3 Update the Cyberdeck-2 README, fastener/structure report, validation
  log, assembly review, and journal with exact dimensions, results, hashes, and
  explicit physical/slicer/calibration limitations.
- [x] 5.4 Archive this plan, regenerate/check plan indexes, review the complete
  diff, and commit all approved changes. Do not push unless requested.

## Planned Files

- `designs/cyberdeck-2/configs/rev_0001.json`
- `designs/cyberdeck-2/src/lib/defaults.scad`
- `designs/cyberdeck-2/src/parts/enclosure_blockout.scad`
- `designs/cyberdeck-2/assembly.json`
- `designs/cyberdeck-2/README.md`
- `designs/cyberdeck-2/docs/fastener_and_structure_report.md`
- `designs/cyberdeck-2/docs/rev_0001_validation.md`
- `designs/cyberdeck-2/docs/rev_0001_assembly_review.md`
- `journal/2026-07-29.md`
- this plan and plan indexes

## Acceptance

The front face has continuous top and bottom fascia outside—but never inside—
the exact 2U clearance. The front rack insert blocks have multiple verified
3 mm load paths. Each seam tongue slides lengthwise into a closed-end socket
with approximately 1 mm clearance, and every non-mouth socket face remains a
continuous wall at least 3 mm thick after all fastener cuts. The installed
combined artifacts must make these conditions directly visible.
