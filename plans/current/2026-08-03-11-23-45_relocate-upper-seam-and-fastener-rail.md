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

The highest horizontal screen roof is split at `X = 0` and currently has only
butt contact. Add a full-depth, in-plane tongue/socket joint to this roof: 3 mm
positive lateral engagement, 1 mm assembly clearance, and no geometry below its
existing underside. It must preserve the `222.25 x 88.90 mm` angled 2U aperture,
the 50.8 mm behind-screen clearance, and the screen insertion/removal path.

The narrow rail between the lower screen opening and the top port-plate opening
is not a required load path in this design and shall be removed. Merge the two
roof cutouts into one uninterrupted clearance opening while preserving the
screen frame, the port-plate support rails, and the named minimum margins to the
rear seam block. A dedicated M3 block there is deliberately de-scoped.

The current upper service zone is 17.8 mm. The target is the smallest safe upper
zone, but no numeric reduction is approved until the relocated front station and
the remaining screen-end upper load path provide two verified connections across
the full assembly. The lower 17.8 mm service zone and the exact 2U rack height
remain unchanged.

## Checklist

- [ ] 1. Establish the high screen-roof center seam.
  - [x] 1.1 Define named roof tongue, socket, 1 mm fit clearance, 3 mm positive
    overlap, full engagement length, and every remaining roof-edge ligament.
  - [x] 1.2 Model strict left/right roof ownership and the in-plane interlock;
    do not add a block below the existing roof underside or into the screen
    aperture/rear-clearance envelope.
  - [?] 1.3 Add assertions and section/probe views demonstrating that the roof
    joint has continuous positive engagement while its lowest surface, aperture,
    50.8 mm rear clearance, and screen insertion envelope remain unchanged.

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

- [ ] 5. Update the assembly contract and inspection evidence.
  - [ ] 5.1 Update interfaces and add dedicated installed-artifact views for
    the high-roof seam, the front-wall station, any necessary screen-rear-wall
    station, the shortened upper roof, and their tool/clearance sides.
  - [ ] 5.2 Update README, structure/fastener report, validation record, and
    today's append-only journal with dimensions, hardware, installation order,
    intentional separate parts, and unresolved physical-fit limits.

- [ ] 6. Validate the exact candidate.
  - [ ] 6.1 Run rack-reference validation, assembly-contract validation, and
    OpenSCAD assertions for every printable leaf and the assembled dispatch.
  - [ ] 6.2 Complete the normal manifest build, audit installed output, review
    the real STL/PNG artifacts and all new sections, then always create and
    audit the full artifact-bound assembly review in `output/cyberdeck-2/`.
  - [ ] 6.3 Verify printable transformed bounds, unexpected-shell status,
    structural sections at each altered join, all post-cut ligaments, and exact
    artifact/provenance counts; archive the plan and commit the checkpoint.

## Acceptance

The highest screen roof has a full, clearance-neutral positive-volume interlock
across `X = 0`. The closed-front station fastens from the inside of the `Y = 215`
wall. A chamber-height reduction occurs only if the complete remaining upper
seam path is independently verified; the thin inter-opening rail does not gain
hardware without a later approved structural need. All altered interfaces retain
at least 3 mm wall/overlap/material width, retain screen and port-plate service
access, and pass the complete current-output and assembly-review audits.
