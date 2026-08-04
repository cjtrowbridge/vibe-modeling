---
plan_id: 2026-08-03-11-23-45_relocate-upper-seam-and-fastener-rail
title: Connect the High Screen Roof and Relocate the Upper Front Seam
summary: Add a clearance-neutral interlocking seam to the highest screen roof, move the closed-front upper seam into its inside wall, and reduce chamber height only if the full upper load path remains verified.
status: current
created_at: 2026-08-03-11-23-45
---

# Connect the High Screen Roof and Relocate the Upper Front Seam

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Intent and Constraints

The closed `Y = 215 mm` wall is the requested mounting face for the existing
closed-front upper seam station. Its M3 screw axis, head/washer seat,
captive-nut seat, and tool path must be contained in that wall's inside service
structure. This is a single wall-mounted station; two independent upper stations
cannot occupy the same center-seam coordinates in the wall.

The highest horizontal screen roof is split at `X = 0`. A registration-only
tongue/socket is insufficient. Replace the raw butt seam with one named,
complete M3 locking interface directly beneath the roof at the roof/back-wall
junction. Both left and right connector halves must remain below the continuous
exterior roof plane and positively overlap both the 3 mm roof and the 3 mm rear
wall. The roof returns to its original datum: raising it without also moving the
screen frame creates an unacceptable visible mismatch. The angled screen frame
must retain its exact 45-degree transform and `222.25 x 88.90 mm`
angled 2U aperture, the 50.8 mm behind-screen clearance, and the screen
insertion/removal path.

The narrow rail between the lower screen opening and the top port-plate opening
is not a required load path in this design and shall be removed. Merge the two
roof cutouts into one uninterrupted clearance opening while preserving the
screen frame, the port-plate support rails, and the named minimum margins to the
rear seam block. A dedicated M3 block there is deliberately de-scoped.

The first merged-opening implementation is structurally unverified and must not
be retained as-is: its 10 mm port-plate rails place a 3.6 mm mounting hole only
0.2 mm from the inner cut edge, its stepped rail transition has zero positive
overlap, and a legacy center-seam feature is visibly exposed as an unclassified
nub. These are correction items, not cosmetic refinements.

The current upper service zone is 17.8 mm. The target is the smallest safe upper
zone, but no numeric reduction is approved until the relocated front station and
the remaining screen-end upper load path provide two verified connections across
the full assembly. The lower 17.8 mm service zone and the exact 2U rack height
remain unchanged.

## Checklist

- [ ] 1. Establish the high screen-roof M3 locking seam.
  - [x] 1.1 Define named roof tongue, socket, 1 mm fit clearance, 3 mm positive
    overlap, full engagement length, and every remaining roof-edge ligament.
  - [-] 1.2 Registration-only roof interlock. Superseded: it has no M3 hardware,
    clamping force, captive receiver, or tool path.
  - [ ] 1.3 Define the complete M3 hardware stack directly below the high roof:
    vertical screw axis, flush head/washer seat, captive nut or insert,
    installation direction, driver envelope, and every post-cut ligament.
  - [ ] 1.4 Model strict left/right ownership of the below-roof tongue/socket
    station with at least 3 mm positive root/socket overlap. Neither connector
    half may project above the continuous exterior roof plane.
  - [ ] 1.5 Add assertions and section/probe views proving the complete locking
    stack, its tool access, and clearance from the roof underside, aperture,
    50.8 mm rear screen clearance, and screen insertion envelope.
  - [ ] 1.6 Relocate the lock to the rear roof/back-wall junction. Define and
    assert its roof overlap, rear-wall overlap, rear-wall root thickness,
    forward-edge clearance to the 45-degree screen envelope, and its complete
    fastening/load path; do not rely on a wall-touching block.
  - [ ] 1.7 Restore the original roof/rear-closure datum and retain the exact
    existing 45-degree screen transform. Remove the raised-roof transition,
    exterior tower, and any residual registration-only roof key so the roof
    exterior is continuous and the M3 station is the sole declared lock.

- [ ] 2. Model the wall-mounted closed-front upper seam interface.
  - [ ] 2.1 Define named front-wall M3 hole, head/washer, nut, driver, tongue,
    socket, closure-wall, and sliding-clearance dimensions; inventory every
    post-cut ligament to the exterior, 2U bay, screen interface, and nearby cuts.
  - [ ] 2.2 Replace only the closed-front top horizontal station with the
    front-wall station,
    preserving strict left/right ownership, positive 3 mm tongue/root/socket
    overlaps, and a documented insertion/tightening sequence.
  - [ ] 2.3 Inventory the remaining screen-end top load path after the high-roof
    interlock. If it lacks two verified cross-seam supports, design a separate
    clearance-neutral vertical screen-rear-wall station; do not substitute the
    thin inter-opening rail or an unsupported long seam.
  - [ ] 2.4 Reduce the upper service-zone height only to the value supported by
    the complete front-wall and screen-end interfaces; retain a 3 mm roof and
    update all dependent screen, plate, enclosure, and print-transform datums.

- [-] 3. Add a dedicated inter-opening rail M3 station.
  - [-] 3.1 Superseded by explicit removal of the non-structural rail in item 4;
    no M3 hardware will be added in this location.

- [ ] 4. Remove the non-structural inter-opening rail.
  - [x] 4.1 Replace the two adjacent roof-opening cuts and their retained 3 mm
    divider with one named continuous cutout, preserving the existing exterior
    side rails, the port-plate mounting rails, and at least 3 mm before the rear
    seam block.
  - [?] 4.2 Assert and section-check screen-frame clearance, port-plate support,
    and all post-cut material widths; do not introduce a new unsupported bridge.

- [ ] 5. Correct the merged-opening support geometry.
  - [ ] 5.1 Widen each port-plate side mounting rail from 10 mm to at least
    14 mm, retaining the M3 holes only where both inside-cut and exterior-edge
    ligaments are at least 3 mm after the 3.6 mm hole cut.
  - [ ] 5.2 Replace the erroneous hole-margin assertion with explicit named
    inside-cut, exterior-edge, and pairwise hole-to-hole ligament calculations.
  - [ ] 5.3 Build the stepped screen-to-port support transition with at least
    3 mm positive overlap along its full depth; do not join rail sections with
    coplanar faces, a shared edge, or a zero-length Boolean boundary.
  - [ ] 5.4 Inventory the exposed center-seam nub. Remove it if it has no
    declared load path, or integrate it into a named tongue/socket connection
    with at least 3 mm overlap and verified clearance from both openings.
  - [ ] 5.5 Add below-side, above-side, and cross-sections at the transition,
    every port-plate M3 hole, and the former nub location; review the exact
    installed artifacts before accepting the repair.
  - [ ] 5.6 Replace the two separately terminating rail ends with one named,
    continuous support transition. The screen-side and port-plate-side members
    must deliberately overlap by at least 3 mm across the transition; a shared
    face, shared edge, visual continuity, or an epsilon Boolean join fails.
  - [ ] 5.7 Delete the generic top/rear seam tongue root and socket geometry
    that remains visible as a vertical nub beside this transition. It is not a
    declared rail support or fastener station and must not survive as orphaned
    geometry after the rail transition is rebuilt.
  - [ ] 5.8 Verify the rebuilt transition after all hole cuts: at least 3 mm
    material from every M3 hole to both opening and exterior edges, at least
    3 mm between relevant cuts, a continuous load path across the transition,
    and no unexpected disconnected shell or visual mismatch in the assembled
    product.

- [ ] 6. Update the assembly contract and inspection evidence.
  - [ ] 6.1 Update interfaces and add dedicated installed-artifact views for
    the high-roof seam, the front-wall station, any necessary screen-rear-wall
    station, the shortened upper roof, and their tool/clearance sides.
  - [ ] 6.2 Update README, structure/fastener report, validation record, and
    today's append-only journal with dimensions, hardware, installation order,
    intentional separate parts, and unresolved physical-fit limits.
  - [x] 6.3 Correct the assembly-review staging path so transient render files
    remain under `.tmp/scad/cyberdeck-2/` and the flat exact-set audit of
    `output/cyberdeck-2/` can pass.

- [ ] 7. Validate the exact candidate.
  - [ ] 7.1 Run rack-reference validation, assembly-contract validation, and
    OpenSCAD assertions for every printable leaf and the assembled dispatch.
  - [x] 7.2 Complete the normal manifest build, audit installed output, review
    the real STL/PNG artifacts and all new sections, then always create and
    audit the full artifact-bound assembly review in `output/cyberdeck-2/`.
  - [ ] 7.3 Verify printable transformed bounds, unexpected-shell status,
    structural sections at each altered join, all post-cut ligaments, and exact
    artifact/provenance counts; archive the plan and commit the checkpoint.

## Rear Roof/Wall Lock Correction Plan

1. **Establish datums and keep the screen fixed.** Restore the high roof and
   rear closure to the pre-raise datum. Keep `angled_screen_frame_transform()`
   unchanged so the screen opening remains at 45 degrees; assert the roof and
   screen-frame top relation rather than using a displaced roof to create room.
2. **Put both connector halves below the rear roof.** Place the left receiver
   and right tongue in the triangular clearance volume immediately forward of
   the rear wall. Each root must penetrate the roof and rear wall by at least
   3 mm, while the exterior roof remains flat with no raised block.
3. **Use one complete M3 station.** Define the 3.6 mm passage, recessed or
   internal service-side driver path, head/washer seat, captive-nut entry from
   the centre seam, tongue, socket, closure walls, and explicit assembly order.
   Delete the old roof-only registration tongue/socket rather than retaining a
   competing seam feature.
4. **Prove fit and structure.** Add a section through the lock centreline and
   sections at the lock's rear and forward ends. Assert the 45-degree screen
   envelope clearance at the lock's forward-most point, 3 mm roof and rear-wall
   overlaps, every post-cut ligament, and the continuous two-sided support path.
5. **Build and inspect governed artifacts.** Run the complete four-part build,
   then the full artifact-bound assembly review. Inspect the installed
   isometric, top, lock section, screen section, and combined STL; reject any
   exterior tower, roof/screen mismatch, residual roof key, screen collision,
   incomplete hardware, or unexpected shell.
6. **Document and checkpoint.** Update the lock dimensions and installation
   sequence in the design records, mark only evidenced plan items complete,
   append the journal, regenerate plan indexes, audit both manifests, then
   commit the verified checkpoint.

## Acceptance

The highest screen roof and its adjoining vertical wall have a complete,
serviceable M3 tongue/socket locking interface across `X = 0`; no portion of
this upper seam remains a merely touching wall. The closed-front station fastens
from the inside of the `Y = 215` wall. A chamber-height reduction occurs only if
the complete remaining upper seam path is independently verified; the thin
inter-opening rail does not gain hardware without a later approved structural
need. All altered interfaces retain at least 3 mm wall/overlap/material width,
retain screen and port-plate service access, and pass the complete current-output
and assembly-review audits.
