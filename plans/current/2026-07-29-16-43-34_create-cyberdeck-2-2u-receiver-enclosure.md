---
plan_id: 2026-07-29-16-43-34_create-cyberdeck-2-2u-receiver-enclosure
title: Create a Split 2U Ten-Inch Rack Receiver Enclosure
summary: Build a maximum-depth two-piece enclosure that receives a generic 2U ten-inch-rack device and joins with four recessed M3 seam fasteners.
status: current
created_at: 2026-07-29-16-43-34
---

# Create a Split 2U Ten-Inch Rack Receiver Enclosure

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Approval and Milestones

Approval of this plan authorizes the reusable-tooling checkpoint and the
low-detail enclosure blockout. Per multipart-assembly policy, detailed rack
holes, lap joints, recesses, and production artifacts begin only after the user
reviews and approves the provenance-bound blockout assembly.

## 1. Checkpoint Reusable Multipart Governance

- [x] 1.1 Verify the preserved assembly-contract validator, review renderer,
  templates, tests, host policy, and general CAD playbook changes independently
  of Cyberdeck-2.
- [x] 1.2 Record a journal checkpoint, review the exact reusable-tooling diff,
  and commit it separately without pushing.

## 2. Establish the New Product Contract

- [ ] 2.1 Recreate `designs/cyberdeck-2/` as a new simple enclosure lineage;
  do not restore the rejected prior geometry or manifests.
- [ ] 2.2 Declare one product assembly, one logical
  `split_2u_receiver_enclosure` subassembly, and exactly two printable leaves:
  `enclosure_left` and `enclosure_right`.
- [ ] 2.3 Classify the installed rack device as a non-printable reference
  envelope, never as enclosure or manifest geometry.
- [ ] 2.4 Declare the center longitudinal split at `X = 0`; left and right
  leaves retain strict material ownership except for documented, clearance-fit
  lap tongues and pockets at the four seam fasteners.
- [ ] 2.5 Prohibit front/rear fabrication halves, absorption of the device proxy,
  unfastened coplanar seam contact, and changes to the two-leaf hierarchy without
  renewed approval.

## 3. Lock Rack and Printer Datums

- [ ] 3.1 Use `ten-inch-rack-m3-printed-design-spec` v2.0.0 and record bundle
  manifest SHA-256
  `330051136930b54f0abf91ff81ea217d0e6cad2dbe6503375ffb219e59e0210d`.
- [ ] 3.2 Use a `254.0 mm` nominal front width, `222.25 mm` clear equipment
  opening, `236.525 mm` rail-hole column spacing, `44.45 mm` U pitch, and the
  canonical `15.875 / 15.875 / 12.700 mm` hole sequence.
- [ ] 3.3 Provide a `2U = 88.90 mm` clear vertical bay with `3 mm` top, bottom,
  and side structural walls; nominal shell height is `94.90 mm` before external
  seam pads.
- [ ] 3.4 Resolve maximum outer depth to `215.0 mm`, using the established
  `220 x 220 x 220 mm` nominal printer volume with `5 mm` total axis reserve.
- [ ] 3.5 Print each leaf outer-side-wall-down; require final transformed bounds,
  including seam pads, to remain at or below `215 mm` on every axis.

## 4. Block Out and Approve the Assembly

- [ ] 4.1 Create only the open-front/open-rear shell, left/right split, nominal
  clear device envelope, and four coarse seam-pad envelopes.
- [ ] 4.2 Create synchronized `parts.json`, `assembly.json`, config, dispatch,
  and design-owned rack helpers before detailed geometry.
- [ ] 4.3 Validate the assembly contract and render a full blockout review under
  `.tmp/scad/cyberdeck-2/assembly-review/`.
- [ ] 4.4 Review front, rear, left, right, top, bottom, isometric, exploded,
  left-leaf, right-leaf, top-seam, and bottom-seam views for hierarchy, open
  insertion path, clear envelope, split ownership, collisions, and unexplained
  geometry.
- [ ] 4.5 Stop and request explicit user approval of the exact blockout hashes
  before detailed holes or join geometry.

## 5. Implement the Rack Receiver Interface

- [ ] 5.1 Model six canonical 2U mounting positions per front rail, centered on
  `X = +/-118.2625 mm`; use finished `3.6 mm` stack-up holes and preserve the
  complete ISO 7089 M3 washer seat.
- [ ] 5.2 Use round datum holes on one rail and calibrated horizontal slots on
  the opposite rail without changing nominal column centers or U pitch.
- [ ] 5.3 Assert rail width, hole/slot-to-edge material, washer support at every
  slot endpoint, hole-to-hole ligaments, and the full device insertion opening.
- [ ] 5.4 Keep the rear open and declare the maximum generic equipment interval;
  actual device body, mass, center of mass, connectors, cables, and service
  envelope remain `BLOCKED_UNKNOWN` until measured.

## 6. Implement the Four-Fastener Split Joint

- [ ] 6.1 Place one M3 joint at each longitudinal seam corner:
  top-front, top-rear, bottom-front, and bottom-rear.
- [ ] 6.2 Use clearance-fit overlapping lap pads outside the generic device
  clearance envelope so the full `222.25 x 88.90 mm` bay remains unobstructed.
- [ ] 6.3 Use `3.6 mm` finished through-holes, a recessed button/socket-head plus
  ISO 7089 washer envelope on the exterior side, and a captive M3 hex-nut recess
  on the mating side; derive screw length from the final stack.
- [ ] 6.4 Give every recess at least `3 mm` residual material, every hole/recess
  at least `3 mm` edge and pairwise ligament, and every pad-to-shell root at
  least `3 mm` positive-volume engagement.
- [ ] 6.5 Verify head, washer, nut, screw-tip, driver, nut insertion, tightening,
  and disassembly access for all four joints.
- [ ] 6.6 Compare the assembled split geometry with the unsplit shell contract;
  only the declared seam, lap clearance, hardware cuts, and external pads may
  differ.

## 7. Verify Geometry and Assembly

- [ ] 7.1 Run all rack, wall, overlap, ligament, fastener, clearance, and print
  bounds assertions for both printable leaves and the assembly dispatch.
- [ ] 7.2 Render sections through all four fasteners, seam-pad roots, front rack
  holes/slots, shell corners, and minimum remaining throats.
- [ ] 7.3 Export both STLs, confirm one connected positive-volume shell per
  printable leaf, and independently measure transformed bounds.
- [ ] 7.4 Review slicer layers if a supported slicer is available; otherwise mark
  layer-path, support, and physical fit claims `unverified`.
- [ ] 7.5 Regenerate the full assembly review after detailed geometry and record
  findings before accepting artifacts.

## 8. Build and Record Current Artifacts

- [ ] 8.1 Dry-run and build the complete two-part manifest through governed
  staging, then atomically install `output/cyberdeck-2/`.
- [ ] 8.2 Require exactly `2 STL`, `34 PNG`, and `36` modeled printable artifacts
  plus `build_manifest.json`; reject missing, unexpected, stale, or mismatched
  files.
- [ ] 8.3 Require a separate full assembly-review set of `12 PNG` and `1`
  assembled-geometry STL plus `assembly_review_manifest.json`, all bound to the
  same config, source, `parts.json`, and `assembly.json` hashes.
- [ ] 8.4 Do not create `revisions/cyberdeck-2/rev_0001/`; immutable publication
  requires calibrated hardware/device measurements, slicer review, physical fit
  evidence, and separate approval.

## 9. Document and Close

- [ ] 9.1 Add the design README, `rev_0001` mutable design record, rack
  requirement matrix, depth report, fastener stack-up, seam/ligament report,
  keepout inventory, validation log, and root README entry.
- [ ] 9.2 Record all `BLOCKED_UNKNOWN` device, process, material, calibration,
  load, support, cable, and service inputs without claiming fabrication readiness.
- [ ] 9.3 Archive this plan, regenerate/check plan indexes, append the journal,
  review the complete task diff, and commit the finished design checkpoint after
  the approved execution; do not push.

## Planned Files

- Existing reusable policy/tooling checkpoint:
  `AGENTS.md`, `README.md`, applicable general CAD playbooks, assembly scripts,
  templates, and tests.
- New design:
  `designs/cyberdeck-2/README.md`, `parts.json`, `assembly.json`,
  `configs/rev_0001.json`, `src/main.scad`, `src/lib/*.scad`,
  `src/parts/*.scad`, and `docs/*.md`.
- Lifecycle:
  root `README.md`, this plan and indexes, and `journal/2026-07-29.md`.
- Generated only:
  `output/cyberdeck-2/` and `.tmp/scad/cyberdeck-2/assembly-review/`.

## Explicit Assumptions Requiring Approval

1. `cyberdeck-2` is the intended design name for this clean restart.
2. The enclosure is a standalone generic ten-inch-rack receiver, not itself a
   rackmount device.
3. Front and rear remain open for insertion, connectors, and cable access.
4. "Split lengthwise" means a front-to-rear seam on the center `X = 0` plane,
   producing left and right printable leaves.
5. `215 mm` is the maximum modeled depth inside the established nominal
   `220 mm` printer axis.
6. Seam pads may project locally outside the nominal shell height so no fastener
   or recess enters the generic device clearance envelope.

## Readiness Limits

The current artifacts will be a dimensionally governed generic receiver draft,
not fabrication-ready. Exact device body/face dimensions, depth, mass, center of
mass, connectors, cables, airflow, screw product, printer/material/profile,
finished-hole calibration, support strategy, and physical coupons remain
required before a specific device or production print can be approved.
