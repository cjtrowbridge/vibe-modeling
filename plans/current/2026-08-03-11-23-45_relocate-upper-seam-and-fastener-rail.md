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
complete M3 locking interface housed in an integrated upper service band. Extend
the 45-degree screen-side profile, its side infills, rear closure, and horizontal
roof together above the unchanged screen rail, rather than raising only the roof.
Both connector halves must remain inside this continuous raised structure and
positively overlap the roof and supporting walls by at least 3 mm. The exact
45-degree screen transform and `222.25 x 88.90 mm` angled 2U aperture, the
50.8 mm behind-screen clearance, and the screen insertion/removal path remain
unchanged.

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
  - [ ] 1.6.1 Correct the high-roof lock hardware envelope before retaining its
    station. The current 15 mm depth with a 7.5 mm screw centre leaves only
    `0.375 mm` between the 8.25 mm head/washer recess and the 3 mm rear wall;
    it is not serviceable. Reposition and/or deepen the station so the head,
    washer, nut, driver, and insertion path each retain at least 3 mm from the
    rear wall, roof/opening edges, and all socket walls after every cut. Assert
    these boundaries individually rather than asserting only total block depth.
  - [-] 1.7 Restore the original roof/rear-closure datum. Superseded by the
    integrated upper service-band approach in item 1.8.
  - [ ] 1.8 Add an integrated upper service band above the screen 2U rail.
    Extend the complete 45-degree screen-side profile, side infills, rear
    closure, and horizontal roof together by a named band height; do not raise
    only the roof or create a detached tower. Retain the exact existing 45-degree
    screen transform and aperture. The band must be at least 18 mm, exceeding
    the 14.25 mm minimum required by an 8.25 mm M3 head/washer seat plus two
    3 mm material margins.
  - [ ] 1.8.1 Relocate the high-roof tongue/socket M3 station wholly within the
    new upper service band, above the 2U clearance envelope. Define and assert
    independent 3 mm margins for head/washer, nut, driver access, rear wall,
    roof exterior, screen opening, and every socket wall after all cuts.
  - [ ] 1.8.2 Add side, roof, and center-seam sections proving that the raised
    profile is continuous, both lock halves are contained within it, the screen
    aperture remains clear, and no exterior roof/screen mismatch or residual
    registration key remains.

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
  - [?] 4.1 Replace the two adjacent roof-opening cuts and their retained 3 mm
    divider with one named continuous cutout, preserving the existing exterior
    side rails, the port-plate mounting rails, and at least 3 mm before the rear
    seam block. The first implementation used separate rectangular cuts and
    did not create the required continuous transition profile.
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
  - [-] 5.7 Delete the generic top/rear seam tongue root and socket geometry.
    This was an unproven attribution for the visible nub and must not be changed
    again until feature-isolated inspection identifies its owner.
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

1. **Keep the screen fixed and add a unified band.** Keep
   `angled_screen_frame_transform()` unchanged so the screen aperture remains
   at 45 degrees. Extend the slope, side infills, rear closure, and roof together
   by an 18 mm minimum service band above—not inside—the 2U clearance envelope.
2. **Put both connector halves within the raised profile.** Place the left
   receiver and right tongue wholly in the new service band, where each root
   penetrates its roof and supporting walls by at least 3 mm. The exterior must
   be one continuous screen-to-roof profile with no detached tower.
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

## Opening-Transition Recovery Plan

The previous repair attempts failed because they treated the visible discontinuity
as a local bridge or a high-roof seam issue. The affected feature is instead the
2D roof-opening boundary where the 3 mm screen-side retained rail transitions
to the 14 mm port-plate M3 rail. Do not implement another overlay block.

- [ ] A. Diagnose the exact owners before changing geometry.
  - [ ] A.1 Add two temporary, governed assembly-review crops: one through each
    outside opening transition and one through the center-seam nub. Render the
    contributing chassis roof, screen frame, port rail, generic seam station,
    and removable plate in separately selectable diagnostic colors.
  - [ ] A.2 Inspect the installed crops and record the exact module and Boolean
    operation that creates every visible terminating edge and the nub. Do not
    delete or relocate a seam feature based only on visual proximity.

- [ ] B. Rebuild the opening as one continuous roof profile.
  - [x] B.1 Delete the paired rectangular roof-opening subtractions and the
    post-split `merged_opening_side_rail_bridges()` overlay. Build one named
    2D polygonal opening boundary in the pre-split chassis master instead.
  - [ ] B.2 Define the left and right retained-rail profiles by named outer and
    inner boundaries. The 3 mm screen-side rail must widen into the 14 mm
    port-plate mounting rail over a named finite transition length; construct
    that material as one continuous polygon/extrusion, not as terminating
    cubes that share a face or edge.
  - [ ] B.3 Require the transition to overlap/engage both adjacent rail regions
    by at least 3 mm along the complete supported depth. Keep the opening clear
    of the screen frame and retain the required rear seam-block margin.
  - [ ] B.4 Place each port-plate M3 mounting hole only in the uniform 14 mm
    rail region. Assert the final post-cut exterior-edge, opening-edge, and
    hole-to-hole ligaments independently; each must be at least 3 mm.

- [ ] C. Resolve the nub from evidence.
  - [ ] C.1 Once its exact owner is established, remove the nub if it is
    unneeded geometry, or replace it with a named, serviceable tongue/socket
    fastener interface. A residual projection, coplanar contact, or partial
    feature is not acceptable.
  - [ ] C.2 Verify the selected resolution leaves no collision with the opening,
    port plate, screen frame, or required tool envelope.

- [ ] D. Prove the final result before checkpointing.
  - [ ] D.1 Add permanent installed-artifact views: left/right transition from
    above and below, a section at each transition midpoint, a section through
    each port-plate hole, and a center-nub ownership/clearance view.
  - [ ] D.2 Run the assembly-contract validator, complete manifest build,
    manifest audit, full artifact-bound assembly review, and review the exact
    installed PNG/STL set. Reject a result with a visible rail mismatch,
    isolated nub, missing material, or incomplete assembled lock.
  - [ ] D.3 Update the plan, design records, and append-only journal with the
    measured profile dimensions and verification evidence; commit only the
    reviewed checkpoint.

## Coordinated Screen and Top-Plate Interface Recovery Plan

The current angled screen interface assumes 7 mm-deep blind M3 insert bores,
and the top plate assumes four corner fasteners. Those assumptions do not provide
the requested through-bolted screen attachment or a complete 2U mounting pattern.
Replace them as one coordinated interface revision; do not retain blind bores,
partial hole patterns, or unsupported rail patches.

- [ ] E. Convert the angled 2U screen interface to through-bolted hardware.
  - [x] E.1 Replace the `4.0 mm x 7.0 mm` blind insert bores with `3.6 mm` M3
    through-holes at the canonical six positions on each of the two screen rails.
    Retain the exact `222.25 x 88.90 mm` aperture, `45 degree` transform, and
    canonical two-column six-hole pattern.
  - [x] E.2 Remove the obsolete broad 7 mm blind-insert rail depth. Retain a
    continuous 3 mm screen-face flange and 3 mm side-wall support, adding only
    named local backing/nut lands where required for a washer, nut, tool, or
    load path.
  - [ ] E.3 Define a complete chamber-side fastening stack for every screen
    bolt: exterior screw-head/washer choice, `3.6 mm` passage, M3 nut/washer
    pocket or captive-nut feature, insertion order, and driver/wrench envelope.
    Each pocket must be installable from the main chamber without blocking the
    screen insertion/removal path.
  - [ ] E.4 Assert all screen-rail post-cut ligaments: hole to aperture, hole
    to exterior edge, hole to adjacent hole, nut/washer pocket to every exterior
    edge and void, local backing-land thickness, and every rail/support overlap.
    Each value must be at least 3 mm.

- [ ] F. Replace the flat top plate's four-corner retention with a full 2U pattern.
  - [x] F.1 Generate the canonical six-hole-per-side sequence in the top plate
    and its fixed roof rails: 12 aligned `3.6 mm` through-holes total, using the
    selected ten-inch rack datums rather than four corner coordinates.
  - [ ] F.2 Keep the 14 mm roof rails only if every resulting post-cut ligament
    passes. The 6.812 mm M3 nut circumscribed diameter leaves approximately
    3.59 mm across a 14 mm rail; assert the exact transformed result, including
    every adjacent canonical hole.
  - [ ] F.3 Use a specified low-profile M3 button-head or equivalently small
    head at the end-hole stations; do not use the 8.25 mm washer recess where
    the 6.35 mm canonical end margin would reduce the remaining exterior
    material below 3 mm. Define head, washer if used, captive/accessible nut,
    driver path, and install/remove order for all twelve stations.
  - [ ] F.4 Add underside nut pockets or an equally serviceable retained-fastener
    solution. Their orientation and depth must leave at least 3 mm to the plate
    edge, roof opening, neighboring pockets, and structural members after all
    cuts. The removable plate must remain removable without occupying the main
    receiver bay.

- [ ] G. Integrate the upper roof lock with these interfaces.
  - [?] G.1 Implement the 18 mm minimum upper screen service band from item
    1.8 as one continuous extension of the 45-degree slope, side infills, rear
    closure, and roof. It must create usable service volume above the screen
    aperture, not a raised roof disconnected from the screen structure.
  - [ ] G.2 Move the complete roof M3 tongue/socket station into that band. Keep
    both halves below the exterior roof, wholly above the 2U clearance envelope,
    and independently preserve 3 mm clearance for its head, washer, nut,
    driver, roof, walls, screen opening, and socket closure surfaces.
  - [ ] G.3 Verify that the new screen through-fastener pockets, the upper lock,
    the roof-opening transition, and the top-plate hardware have no intersecting
    swept, driver, nut-insertion, or screen-insertion envelopes.

- [ ] H. Validate and document the combined revision.
  - [ ] H.1 Add permanent installed-artifact views for each screen bolt's
    chamber side, top-plate end and middle stations, the upper lock centreline,
    the completed 3-to-14 mm opening transition, and the resolved former nub.
  - [ ] H.2 Run rack-reference and assembly-contract validation, then the
    complete manifest build, both audits, and full artifact-bound review.
    Inspect the installed combined STL and every targeted view; reject blind
    screen holes, missing 2U holes, inaccessible hardware, thin ligaments,
    residual nubs, or visible rail discontinuities.
  - [ ] H.3 Update the design README, rack/depth report, fastener/structure
    report, validation record, plan, and append-only journal with the selected
    M3 hardware, exact patterns, installation order, and all verification
    results before committing the reviewed checkpoint.

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

## Main-Chamber 2U Rear-Rail Through-Bolt Recovery

The main-chamber 2U rack rail currently uses the legacy 10 mm-deep blind-insert
configuration: a 4.0 mm bore stops within the rail. That makes the wall
unnecessarily thick and does not permit the requested through-bolt and
chamber-side nut installation. This recovery changes only that rack interface;
it does not alter the 222.25 x 88.90 mm aperture, the front/rear chassis datum,
or the screen and top-plate rack interfaces.

- [ ] I. Define the replacement rear-rail hardware contract.
  - [x] I.1 Replace the `10 mm` blind-insert rail with a named `3 mm`
    face flange and six canonical `3.6 mm` M3 through-passages per side.
    Preserve the exact 2U opening and the existing canonical rack coordinates.
  - [x] I.2 Model one local chamber-side nut land per hole, analogously to the
    top-plate rails: each land must overlap the 3 mm face flange by at least
    3 mm, retain a chamber-open hexagonal M3 nut pocket, and keep the screw
    passage continuous from the exterior face to that pocket.
  - [?] I.3 Define the selected M3 screw head/washer, nut, installation
    direction, wrench/driver path, and removal sequence. No blind insert,
    inaccessible nut, or unmodeled tool envelope may remain.
- [ ] J. Guard material and interface dimensions.
  - [x] J.1 Add named assertions for the 3 mm rail face, rail-to-land overlap,
    local land root, nut-pocket depth, exterior and aperture margins, and every
    hole-to-hole ligament after cuts. The governing edge/material width is
    `>= 3 mm`; the ten-inch-rack host override also requires `>= 3 mm` radial
    material around each primary M3 hole.
  - [?] J.2 Update the dedicated chamber-side rack-rail cross-section through an end and
    middle station, showing an unbroken screw passage, complete nut pocket,
    accessible tool side, and no intrusion into the 2U insertion envelope.
- [ ] K. Implement and verify the exact candidate.
  - [x] K.1 Build the complete four-leaf manifest into `output/cyberdeck-2/`,
    inspect the installed rear-rail views and the combined assembly, then run
    both manifest audits and the full artifact-bound assembly review.
  - [ ] K.2 Update the rack/depth, fastener/structure, validation, plan, and
    append-only journal records with the changed hardware stack, exact output
    provenance, and any remaining physical-fit limits before committing the
    reviewed checkpoint.

## Generic Four-Station Seam Fastener Containment Recovery

The left printable enclosure leaf has partially open generic seam head/nut
recesses at the split edge. The exact cause is the current generic seam axis
`X = -3.9 mm`: an `8.25 mm` head recess extends to `X = +0.225 mm`, across the
`X = 0` printable-part boundary. Existing assertions measure only front/rear
depth margins and therefore miss this failed split-edge ligament. The assembled
union can visually mask the defect; acceptance must be based on each printable
leaf, not the assembled product alone.

- [x] L. Replace the generic seam layout with a contained overlapping joint.
  - [x] L.1 Establish named left-receiver width, right-tongue insertion width,
    screw-axis offset, head-seat radius, nut-pocket radius, and split-edge
    margin. For every one of the four top/bottom and front/rear stations, the
    complete head recess, through-passage, and nut pocket must be wholly inside
    the owning printable leaf with at least 3 mm material to its outside edge
    and to the `X = 0` split boundary.
  - [x] L.2 Replace the present 3 mm-wide right tongue with a deliberately
    wider tongue that extends into a matching left receiver far enough to carry
    the through-passage after assembly. It must retain 3 mm positive root,
    receiver, and closed-end overlap on all load-bearing faces; a hole located
    only in the left receiver cannot clamp the right leaf.
  - [?] L.3 Retain a single unambiguous M3 stack per station: exterior
    head/driver seat, 3.6 mm passage through both mating members, captive and
    accessible nut seat, insertion sequence, and tool path. Remove the old
    generic cuts and socket geometry completely rather than leaving overlapping
    legacy features.
- [?] M. Add split-aware structural and fastener verification.
  - [x] M.1 Assert separately for head, nut, passage, tongue, receiver, and
    every station: outside-edge margin, split-edge margin, front/rear margin,
    post-cut throat, tongue root, receiver wall, and full engagement length.
    All structural and material values must be `>= 3 mm` after every cut.
  - [?] M.2 Add permanent printable-leaf (not assembled-only) crops of all four
    stations from the head and nut sides, plus start/mid/end sections through
    the new receiver/tongue. Reject any partial circle, partial hexagon, split
    boundary breakthrough, or unreachable hardware envelope.
- [?] N. Rebuild and accept only evidence-bound artifacts.
  - [x] N.1 Run rack-reference and assembly-contract validation, the complete
    four-leaf build, current-output audit, full assembly review, and review
    audit. Inspect the exact left and right leaf STL/PNG views and the combined
    STL; a correct assembly view cannot compensate for a defective printable
    leaf.
  - [x] N.2 Update the fastener/structure report, validation record, plan, and
    append-only journal with the exact new seam dimensions, installation order,
    artifact provenance, and physical-fit limits before committing.

## Angled-Screen Rail Overlap and Through-Bolt Recovery

The full triangular left/right angled-screen side infills currently occupy the
rear-side M3 hardware envelope for the angled 2U screen rails. They are neither
needed nor acceptable as a substitute for a rail-to-rail structural connection:
the angled screen rail and the matching retained flat top-opening rail must
directly overlap as positive-volume members. The flat top and main-chamber rails
already use local chamber/open-side hex-nut lands; the angled rails currently
have only 3.6 mm passages and therefore lack a defined usable rear fastener
stack.

- [ ] O. Replace the triangular wedge infills with direct, supported rail joints.
  - [ ] O.1 Remove both `angled_screen_side_infill()` solids completely. Do not
    retain a residual nub, coplanar contact, or replacement web in the rear-side
    screen fastener/tool envelope.
  - [ ] O.2 Extend/reposition only the matching angled-screen rail root and
    flat top-opening rail endpoint until they have a named, positive-volume
    overlap of at least 3 mm. The overlap must carry through the full local
    3 mm rail thickness and connect each rail to two supported endpoints; do
    not change the exact `222.25 x 88.90 mm` angled 2U aperture or its 45-degree
    face angle.
  - [ ] O.3 Define assertions for both left and right rail-joint bounds,
    overlap depth, remaining throat, and the distances from every screen/flat
    rail hole and pocket. Every remaining ligament must be at least 3 mm after
    all cuts.
- [ ] P. Make all angled-screen rail stations usable through-bolted M3 mounts.
  - [ ] P.1 Replace the angled-screen rails' hole-only treatment with the same
    explicit pattern used by the other rails: 3.6 mm passage, one local backing
    land behind each of the six stations per rail following the 45-degree face
    normal, and a rear-open 5.9 mm-AF hex M3 nut pocket in that land.
  - [ ] P.2 Keep the lands local rather than creating a continuous thick wall.
    Define the screen-face screw direction, rear/open-side nut insertion and
    driver path, head and nut clearances, and a 3 mm minimum material margin to
    the 2U aperture, rail edge, joint, roof opening, and any screen envelope.
  - [ ] P.3 Add assertions that every nut/tool pocket is clear of the removed
    wedge volume, direct rail joint, and the exact screen insertion envelope.
- [ ] Q. Produce evidence before accepting geometry.
  - [ ] Q.1 Add permanent sections/crops normal to the angled rail for the
    lower, middle, and upper stations on each side. They must show complete
    through-passages, complete rear-open hex pockets, usable tool approach, and
    the direct rail overlap without a triangular obstruction.
  - [ ] Q.2 Run rack-reference and assembly-contract validation, complete
    four-leaf manifest build, current-output audit, full assembly review, and
    review audit. Inspect both printable leaves, all angled-rail crops, and the
    combined STL; reject an assembled-only visual pass.
  - [ ] Q.3 Update the structure/fastener report, validation record, active
    plan, and append-only journal with exact overlap, M3 land, clearance, and
    artifact provenance evidence before committing the checkpoint.

## High-Roof Seam Web Recovery

The rear high-roof locking block has a real roof and rear-wall overlap, but the
remaining triangular void between that block and the forward edge of the
horizontal high roof leaves the centre roof seam supported only at one short
station. The user requires this void to become a continuous seam web: a
longitudinal wall below the high roof that joins the existing rear lock to the
forward roof edge while remaining wholly above the angled screen's exact 2U
clearance zone.

- [ ] R. Add a continuous, load-bearing high-roof seam web.
  - [ ] R.1 Define the web as paired printable-leaf geometry along the `X = 0`
    roof seam, beginning with at least 3 mm positive overlap into the existing
    rear lock block and ending with at least 3 mm positive overlap into the
    forward high-roof edge/service band. It must not merely meet either member
    at a face or edge.
  - [ ] R.2 Shape the web to fill the currently open triangular transition under
    the horizontal high roof, with a continuous 3 mm-or-greater wall thickness.
    The assembled web may be visually continuous at the split, but its two
    printable halves must retain an explicit tongue/receiver or equivalent
    positive overlap; a zero-clearance coplanar wall at the leaf split is not a
    structural joint.
  - [ ] R.3 Keep the web above the face-local `222.25 x 88.90 mm` angled-screen
    insertion envelope and outside every screen M3 nut/head/tool envelope. Do
    not move the 45-degree screen plane, change the exact aperture, narrow its
    rear clearance, or obstruct screen insertion to create the web.
  - [ ] R.4 Add named assertions for roof-edge and lock-block overlap, web
    thickness, seam engagement, screen-envelope clearance, and all nearby
    high-roof-lock head/nut material margins. Each structural throat and void
    margin must remain at least 3 mm after cuts.
- [ ] S. Review the high-roof seam web as an installed and printable interface.
  - [ ] S.1 Add a side section through the former triangular gap and a
    printable-left/right seam crop. They must show a continuous filled web from
    rear lock to forward roof edge, positive split engagement, and an unchanged
    clear angled-screen envelope.
  - [ ] S.2 Include the web evidence in the complete build, both manifest
    audits, and full assembly review; inspect the individual leaves before
    accepting the combined STL.
  - [ ] S.3 Record exact geometry, remaining physical-fit limitations, and
    artifact provenance in the structure report, validation record, plan, and
    journal before committing.

## Upper-Wall and Triangle-Owner Regression Recovery

The first execution attempt removed `angled_screen_side_infill()` wholesale.
That was incorrect: the same geometry had been carrying both the upper exterior
side-wall closure and the unwanted inward triangles. The build therefore lost
the upper walls while retaining separate triangle/nub owners near the roof and
screen transitions. This recovery must split those responsibilities before any
rail or fastener change is accepted.

- [ ] T. Restore exterior closure without restoring internal obstructions.
  - [ ] T.1 Recreate the left and right upper exterior side walls as named,
    continuous 3 mm enclosure faces. Each must positively overlap the roof,
    rear wall, and its supported lower side structure by at least 3 mm; neither
    wall may depend on a triangle/web inside the screen hardware volume.
  - [-] T.1.1 Extend the exterior-only wall profile from the roof-front datum
      to the existing angled-support datum. Superseded: the user selected a
      direct rail-to-rail transition with no triangular wall wedge.
  - [ ] T.2 Identify every remaining triangle/nub by its producing module and
    remove only that geometry. Do not use a broad deletion of a side-wall or
    roof module to remove an obstruction. The rear side of each angled screen
    M3 station, including its nut/driver envelope, must be clear.
    - [-] T.2.1 Removed the long angled side-support wedges. Reversed after
      diff review showed that they are the required rail backs/support walls.
- [ ] T.3 Implement the direct angled-to-flat rail joint as an explicit
    overlap member outside the exact screen aperture, not as a triangular
    filler. Preserve its named 3 mm minimum overlap and all 2U clearances.
  - [-] T.3.1 Replaced both side-support wedges with rectangular overlap
    blocks. Reversed: the blocks did not engage the actual flat rail.
- [ ] U. Prove the repaired separation of wall, rail, and hardware spaces.
  - [?] U.1 Add dedicated side and underside assembly crops covering both
    transition locations. They must show continuous upper exterior walls, no
    internal triangular obstruction, a real rail-to-rail overlap, and each
    rear-open M3 nut/tool pocket.
  - [?] U.2 Add assertions for upper-wall overlap/thickness, removed-triangle
    keepout, rail overlap, and every nearby post-cut ligament. Require at least
    3 mm for each structural throat or edge margin.
  - [?] U.3 Rebuild the complete manifest and run both audits plus full assembly
    review. Inspect individual leaf artifacts before documenting evidence and
    committing; do not accept a combined-assembly-only result.

## 2026-08-12 Artifact-Regeneration Recovery

- [x] V. Preserve required assembly review artifacts during stale-output rebuilds.
  - [x] V.1 After the complete printable build and printable audit, invoke the
    full assembly review, its audit, and a final unified-output audit.
  - [x] V.2 Retain explicit executable logging and the existing non-zero failure
    behavior; do not fold assembly-review artifacts into the printable manifest.

## 2026-08-12 High-Roof Lock Clearance Recovery

- [x] W. Restore a usable high-roof M3 head seat without changing the other
  seam stations.
  - [x] W.1 Cut the high-roof through passage and head seat through the master
    roof shell, not only through the separate receiver lock block.
  - [x] W.2 Increase the high-roof lock height from 15 mm to 18 mm and require
    three 3 mm material bands in addition to the 8.25 mm head/washer seat.
  - [x] W.3 Match the standard seam receiver width, tongue insertion/root,
    closed-end clearance, and `X = -8 mm` screw axis exactly.
  - [x] W.4 Match the standard 17.8 mm vertical seam stack; retain the 20 mm
    roof-band depth required by the forward roof-edge clearance, and remove the
    lower angled-screen clearance cut that perforated either exterior side wall.

## 2026-08-12 Angled-Screen Lower-Hardware Recovery

- [ ] X. Restore the two lowest angled-screen hardware interfaces without
  reopening either exterior wall.
  - [x] X.1 Split the exterior-wall closure from the lower M3 rear-approach
    envelope, removing only the two interfering inboard triangle owners on
    each side.
  - [x] X.2 Make every angled-screen rear nut land an explicit, per-hole
    structural feature and verify the two lowest stations retain their nut
    backs after every shell subtraction.
  - [?] X.3 Add source assertions and review crops for both lower stations;
    rebuild the complete printable manifest and audit the installed output.
