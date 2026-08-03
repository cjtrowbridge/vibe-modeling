---
plan_id: 2026-08-03-11-23-45_relocate-upper-seam-and-fastener-rail
title: Relocate Upper Seam Stations and Fasten the Inter-Opening Rail
summary: Move the upper chassis center-seam fasteners to the inside of the closed front wall, reduce the resulting upper service zone, and add a serviceable center-seam station at the roof rail between the two 2U openings.
status: future
created_at: 2026-08-03-11-23-45
---

# Relocate Upper Seam Stations and Fasten the Inter-Opening Rail

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Intent and Constraints

The closed `Y = 215 mm` wall is the requested mounting face. Replace both
upper horizontal seam stations with M3 tongue/socket stations whose screw axes,
head/washer seats, captive-nut seats, and tool paths are contained in that
wall's inside service structure. The roof may shrink only after the relocated
stations preserve the full 3 mm minimum walls, overlap, and all hardware/tool
envelopes.

Independently, add a fifth center-seam station below the narrow rail between the
screen lower-roof opening and the port-plate opening. The station must fasten the
two enclosure leaves together without obstructing either 2U opening, the angled
screen insertion envelope, the removable port plate, or the existing rear seam
screw. It must be installable from the screen-opening side and use a captive nut
or equivalent fully modeled M3 receiving feature; a nominal hole alone does not
count as a fastener.

The current upper service zone is 17.8 mm. The target is the smallest safe upper
zone, but no numeric reduction is approved until the wall-mounted station's
head/nut/driver envelopes, center seam, screen support, and print bounds are
proven. The lower 17.8 mm service zone and the exact 2U rack height remain
unchanged.

## Checklist

- [ ] 1. Model the wall-mounted upper seam interface.
  - [ ] 1.1 Define named front-wall M3 hole, head/washer, nut, driver, tongue,
    socket, closure-wall, and sliding-clearance dimensions; inventory every
    post-cut ligament to the exterior, 2U bay, screen interface, and nearby cuts.
  - [ ] 1.2 Replace both top horizontal seam stations with front-wall stations,
    preserving strict left/right ownership, positive 3 mm tongue/root/socket
    overlaps, and a documented insertion/tightening sequence.
  - [ ] 1.3 Reduce the upper service-zone height only to the value supported by
    those complete envelopes; retain a 3 mm roof and update all dependent
    screen, plate, enclosure, and print-transform datums.

- [ ] 2. Add the inter-opening rail center-seam station.
  - [ ] 2.1 Widen the rail only as needed for a complete M3 fastener block and
    3 mm material around every subtraction, preserving the screen lower-opening
    and port-plate-opening margins.
  - [ ] 2.2 Build a below-rail tongue/socket block with positive overlap into
    both leaf-owned rail structures, a serviceable screw from the lower screen
    opening, and a captive nut/washer/tool envelope that does not require a
    port-plate access hole.
  - [ ] 2.3 Assert clearances from the angled-screen frame and its insertion
    envelope, the port-plate mounting/opening geometry, and the rear seam block.

- [ ] 3. Update the assembly contract and inspection evidence.
  - [ ] 3.1 Update interfaces and add dedicated installed-artifact views for
    both front-wall upper stations, the shortened upper roof, and the new
    inter-opening rail fastener at its head, nut, and clearance sides.
  - [ ] 3.2 Update README, structure/fastener report, validation record, and
    today's append-only journal with dimensions, hardware, installation order,
    intentional separate parts, and unresolved physical-fit limits.

- [ ] 4. Validate the exact candidate.
  - [ ] 4.1 Run rack-reference validation, assembly-contract validation, and
    OpenSCAD assertions for every printable leaf and the assembled dispatch.
  - [ ] 4.2 Complete the normal manifest build, audit installed output, review
    the real STL/PNG artifacts and all new sections, then create and audit the
    full artifact-bound assembly review in `output/cyberdeck-2/`.
  - [ ] 4.3 Verify printable transformed bounds, unexpected-shell status,
    structural sections at each altered join, all post-cut ligaments, and exact
    artifact/provenance counts; archive the plan and commit the checkpoint.

## Acceptance

Both upper chassis seam stations fasten from the inside of the closed `Y = 215`
wall, allowing a verified reduction of the upper chassis service zone without
changing either 2U height. The rail between the two top openings has its own
complete, reachable M3 center-seam station. All altered interfaces retain at
least 3 mm wall/overlap/material width, retain screen and port-plate service
access, and pass the complete current-output and assembly-review audits.
