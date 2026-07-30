---
plan_id: 2026-07-29-16-43-34_create-cyberdeck-2-2u-receiver-enclosure
title: Create a Split 2U Ten-Inch Rack Receiver Enclosure
summary: Build a maximum-depth two-piece enclosure that receives a generic 2U ten-inch-rack device and joins with four recessed M3 seam fasteners.
status: past
created_at: 2026-07-29-16-43-34
---

# Create a Split 2U Ten-Inch Rack Receiver Enclosure

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Approval and Milestones

The blockout-only gate was an execution error and is superseded. On 2026-07-29,
the user explicitly approved completing the requested enclosure through the
closed rear wall, twelve rack insert positions, four recessed M3 split joints,
combined assembly evidence, normal complete-manifest build, verification,
documentation, and commit. Every detail gate must first run the normal
complete-manifest pipeline into `output/<design>/`, audit it, and review those
exact artifacts. A source-rendered `.tmp` assembly can supplement that review
but can never replace or precede it.

## 1. Checkpoint Reusable Multipart Governance

- [x] 1.1 Verify the preserved assembly-contract validator, review renderer,
  templates, tests, host policy, and general CAD playbook changes independently
  of Cyberdeck-2.
- [x] 1.2 Record a journal checkpoint, review the exact reusable-tooling diff,
  and commit it separately without pushing.
- [x] 1.3 Correct host governance and assembly-review tooling so a passing,
  current complete build is a mandatory input to every multipart review and the
  real output artifact hashes are recorded and audited. Preserve the existing
  CLI, destination safety, staging, exact-set, and provenance contracts; exercise
  help, parser tests, complete-build dry-run/build/audit, assembly dry-run/build/
  audit, and stale-or-mismatched build-manifest failure behavior. Treat blank or
  invalid review views as a failed review set and correct their governed camera
  definitions before acceptance.

## 2. Establish the New Product Contract

- [x] 2.1 Recreate `designs/cyberdeck-2/` as a new simple enclosure lineage;
  do not restore the rejected prior geometry or manifests.
- [x] 2.2 Declare one product assembly, one logical
  `split_2u_receiver_enclosure` subassembly, and exactly two printable leaves:
  `enclosure_left` and `enclosure_right`.
- [x] 2.3 Classify the installed rack device as a non-printable reference
  envelope, never as enclosure or manifest geometry.
- [x] 2.4 Declare the center longitudinal split at `X = 0`; left and right
  leaves retain strict material ownership except for documented, clearance-fit
  lap tongues and pockets at the four seam fasteners.
- [x] 2.5 Prohibit front/rear fabrication halves, absorption of the device proxy,
  unfastened coplanar seam contact, and changes to the two-leaf hierarchy without
  renewed approval.

## 3. Lock Rack and Printer Datums

- [x] 3.1 Use `ten-inch-rack-m3-printed-design-spec` v2.0.0 and record bundle
  manifest SHA-256
  `330051136930b54f0abf91ff81ea217d0e6cad2dbe6503375ffb219e59e0210d`.
- [x] 3.2 Use a `254.0 mm` nominal front width, `222.25 mm` clear equipment
  opening, `236.525 mm` rail-hole column spacing, `44.45 mm` U pitch, and the
  canonical `15.875 / 15.875 / 12.700 mm` hole sequence.
- [x] 3.3 Provide a `2U = 88.90 mm` clear vertical bay with `3 mm` top, bottom,
  and side structural walls; nominal shell height is `94.90 mm` before external
  seam pads.
- [x] 3.4 Resolve maximum outer depth to `215.0 mm`, using the established
  `220 x 220 x 220 mm` nominal printer volume with `5 mm` total axis reserve.
- [x] 3.5 Print each leaf outer-side-wall-down; require final transformed bounds,
  including seam pads, to remain at or below `215 mm` on every axis.
- [x] 3.6 Run the selected rack-reference validator and add the explicit
  `rack_spec_version`, depth-class, support-mode, front/rear reserved-depth, and
  rack-insert parameters required by the selected specification.

## 4. Block Out and Approve the Assembly

- [x] 4.1 Create only the open-front/open-rear shell, left/right split, nominal
  clear device envelope, and four coarse seam-pad envelopes.
- [x] 4.2 Create synchronized `parts.json`, `assembly.json`, config, dispatch,
  and design-owned rack helpers before detailed geometry.
- [-] 4.3 Reject the earlier source-only `.tmp` review as a valid milestone; it
  was generated before the authoritative printable artifacts existed.
- [-] 4.4 Reject the earlier source-only visual findings and approval request;
  no output artifact review had occurred.
- [-] 4.5 Close the superseded source-only approval gate without approval.
- [x] 4.6 Dry-run and build the complete two-part blockout manifest through
  governed staging, atomically install `output/cyberdeck-2/`, and require exactly
  `2 STL`, `34 PNG`, and `36` modeled artifacts plus `build_manifest.json`.
- [x] 4.7 Audit the installed output exact set, sizes, hashes, config,
  `parts.json`, source tree, revision, and Git provenance.
- [x] 4.8 Bind the full assembly-review manifest to the passing output build
  manifest and the exact two installed STL hashes; reject stale or absent output.
- [x] 4.9 Review the actual output STLs and all generated output PNG classes,
  then review the artifact-bound front, rear, left, right, top, bottom,
  isometric, exploded, leaf-isolation, and seam views.
- [x] 4.10 Record the user's approval to replace the incomplete blockout with the
  complete requested geometry; do not introduce another intermediate stop.

## 5. Implement the Rack Receiver Interface

- [x] 5.1 Model six canonical 2U M3 insert positions per front rail, centered on
  `X = +/-118.2625 mm`, with the repeating `15.875 / 15.875 / 12.700 mm`
  sequence and a documented 2U origin.
- [x] 5.2 Thicken both front rails for provisional thermoplastic M3 inserts: use
  a `4.0 mm` finished insert hole, approximately `5.7 mm` insert length,
  `7.0 mm` minimum blind-hole depth, and a continuous rail land that preserves
  host structural minima. Mark final insert fit as calibration-dependent.
- [x] 5.3 Assert rail width and depth, insert-hole-to-edge material,
  hole-to-hole ligaments, screw-tip keepout, ISO 7089 washer/tool approach on
  the installed device ear, and the full device insertion opening.
- [x] 5.4 Add an integral `3 mm` rear wall split between the printable leaves,
  with no unrequested openings. Resolve and document the resulting internal and
  usable equipment depth; keep actual device mass, center of mass, connectors,
  cables, and service envelope `BLOCKED_UNKNOWN` until measured.

## 6. Implement the Four-Fastener Split Joint

- [x] 6.1 Place one M3 joint at each longitudinal seam corner:
  top-front, top-rear, bottom-front, and bottom-rear.
- [x] 6.2 Use clearance-fit overlapping lap pads outside the generic device
  clearance envelope so the full `222.25 x 88.90 mm` bay remains unobstructed.
- [x] 6.3 Use `3.6 mm` finished through-holes, a recessed button/socket-head plus
  ISO 7089 washer envelope on the exterior side, and a captive M3 hex-nut recess
  on the mating side; derive screw length from the final stack.
- [x] 6.4 Give every recess at least `3 mm` residual material, every hole/recess
  at least `3 mm` edge and pairwise ligament, and every pad-to-shell root at
  least `3 mm` positive-volume engagement.
- [x] 6.5 Verify head, washer, nut, screw-tip, driver, nut insertion, tightening,
  and disassembly access for all four joints.
- [x] 6.6 Compare the assembled split geometry with the unsplit shell contract;
  only the declared seam, lap clearance, hardware cuts, and external pads may
  differ.

## 7. Verify Geometry and Assembly

- [x] 7.1 Run all rack, wall, overlap, ligament, fastener, clearance, and print
  bounds assertions for both printable leaves and the assembly dispatch.
- [x] 7.2 Render sections through all four fasteners, seam-pad roots, front rack
  holes/slots, shell corners, and minimum remaining throats.
- [x] 7.3 Export both STLs, confirm one connected positive-volume shell per
  printable leaf, and independently measure transformed bounds.
- [?] 7.4 No supported slicer is available; layer-path, support, and physical
  fit claims remain `unverified` as required.
- [x] 7.5 Regenerate the full assembly review after detailed geometry and record
  findings before accepting artifacts.
- [x] 7.6 Export and review a clearly named combined product STL in the governed
  assembly-review directory, bind it to the exact installed printable STL
  hashes, and include its discoverable path in the handoff.

## 8. Build and Record Current Artifacts

- [x] 8.1 Dry-run and build the complete two-part manifest through governed
  staging, then atomically install `output/cyberdeck-2/`.
- [x] 8.2 Require exactly `2 STL`, `34 PNG`, and `36` modeled printable artifacts
  plus `build_manifest.json`; reject missing, unexpected, stale, or mismatched
  files.
- [x] 8.3 Require a separate full assembly-review set of `17 PNG` and `1`
  assembled-geometry STL plus `assembly_review_manifest.json`, all bound to the
  same config, source, `parts.json`, and `assembly.json` hashes.
- [x] 8.4 Do not create `revisions/cyberdeck-2/rev_0001/`; immutable publication
  requires calibrated hardware/device measurements, slicer review, physical fit
  evidence, and separate approval.

## 9. Document and Close

- [x] 9.1 Add the design README, `rev_0001` mutable design record, rack
  requirement matrix, depth report, fastener stack-up, seam/ligament report,
  keepout inventory, validation log, and root README entry.
- [x] 9.2 Record all `BLOCKED_UNKNOWN` device, process, material, calibration,
  load, support, cable, and service inputs without claiming fabrication readiness.
- [x] 9.3 Archive this plan, regenerate/check plan indexes, append the journal,
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
3. The front remains open for insertion; the rear is an integral `3 mm` wall
   with no openings in this revision.
4. "Split lengthwise" means a front-to-rear seam on the center `X = 0` plane,
   producing left and right printable leaves.
5. `215 mm` is the maximum modeled depth inside the established nominal
   `220 mm` printer axis.
6. Seam pads may project locally outside the nominal shell height so no fastener
   or recess enters the generic device clearance envelope.

## Readiness Limits

The completed artifacts will be a dimensionally governed generic receiver draft,
not fabrication-ready. Exact device body/face dimensions, mass, center of mass,
connectors, cables, airflow, exact rack-insert product, printer/material/profile,
finished-hole calibration, support strategy, and physical coupons remain
required before a specific device or production print can be approved.
