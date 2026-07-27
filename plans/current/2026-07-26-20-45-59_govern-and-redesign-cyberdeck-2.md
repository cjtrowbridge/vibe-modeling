---
plan_id: 2026-07-26-20-45-59_govern-and-redesign-cyberdeck-2
title: Govern and Redesign Cyberdeck-2 as Three Full-Width Rack Modules
summary: Add enforceable multipart-assembly governance and rebuild Cyberdeck-2 as a split skeleton receiving three independent full-width ten-inch-rack modules.
status: current
created_at: 2026-07-26-20-45-59
---

# Govern and Redesign Cyberdeck-2 as Three Full-Width Rack Modules

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Binding Execution Milestones

The numbered sections below are a complete workstream inventory. Execute them
through these approval-bound milestones rather than as one uninterrupted change:

1. **Rejected baseline and minimum governance:** section 1 and the policy-only
   portions of section 2.
2. **Architecture blockout and fabrication feasibility:** sections 4 and 5,
   using a provisional assembly contract and no detailed hardware geometry.
   Stop for user approval of the reviewed blockout and any required module split.
3. **Assembly-tooling pilot and governance promotion:** section 3, exercised
   first against the approved Cyberdeck-2 blockout, then promoted to the general
   workflow with the remaining section 2 updates.
4. **Detailed geometry:** section 6, with review artifacts regenerated whenever
   architecture-affecting source, config, manifests, or transforms change.
5. **Verification and mutable checkpoint:** sections 7 and 8. Immutable revision
   publication remains a separate approval.

Each milestone requires a plan update and checkpoint report before the next one.
Evidence that changes the approved architecture, fabrication decomposition, or
scope requires a plan revision and approval.

## 1. Preserve and Correct the Rejected Baseline

- [ ] 1.1 Capture the exact rejected mutable candidate before replacing its geometry.
  - [ ] 1.1.1 Record the staged source, config, manifest, generated-build, and assembly-preview hashes for the rejected candidate.
  - [ ] 1.1.2 Record representative front, rear, side, top, skeleton, module, and seam findings, including the one-sided rear opening and unsupported display-frame rail.
  - [ ] 1.1.3 Add a design record that labels the candidate `REJECTED_ARCHITECTURE`, not a successful first draft or fabrication candidate.
- [ ] 1.2 Correct inaccurate lifecycle and verification claims without erasing history.
  - [ ] 1.2.1 Add a superseding note to the archived first-draft plan stating that later assembly review invalidated its architectural completion claim.
  - [ ] 1.2.2 Replace grouped rack and structural `PASS` entries in the mutable design evidence with interface-specific failures or `UNVERIFIED` results.
  - [ ] 1.2.3 Ensure root and design documentation no longer describe the rejected three-export model as the intended Cyberdeck-2 architecture.
- [ ] 1.3 Create a separate rejected-baseline checkpoint before rewriting the source.
  - [ ] 1.3.1 Review the corrected rejected-baseline diff and verify that it does not claim print or fabrication readiness.
  - [ ] 1.3.2 Preserve hashes, findings, and representative artifacts without requiring invalid source to enter `main`.
  - [ ] 1.3.3 Propose a rejected-source commit only if its regression value exceeds a minimized negative fixture, and obtain separate approval before creating it.

## 2. Add General Design-Intent and Multipart-Assembly Governance

- [ ] 2.1 Create a canonical product-decomposition contract.
  - [ ] 2.1.1 Add `playbooks/how_to_define_and_verify_canonical_product_decomposition.md`.
  - [ ] 2.1.2 Require every multipart design to declare its logical components, component roles, ownership boundaries, interfaces, allowed fabrication decomposition, and prohibited component absorption before geometry work begins.
  - [ ] 2.1.3 Require any change to the approved logical decomposition to stop implementation and return for approval.
  - [ ] 2.1.4 Define product assemblies, logical subassemblies, and printable leaf artifacts as separate hierarchy levels so printer constraints cannot silently change product architecture.
- [ ] 2.2 Create a mandatory multipart assembly-review workflow.
  - [ ] 2.2.1 Add `playbooks/how_to_create_and_review_multipart_assembly_artifacts.md`.
  - [ ] 2.2.2 Require a primary assembled design artifact for every multipart design.
  - [ ] 2.2.3 Require opaque printable-only orthographic views, isometric views, an exploded view, seam crops, interface sections, a skeleton-only view, and a modules-only view.
  - [ ] 2.2.4 Require reference proxies to be independently hidden or made translucent so they cannot conceal printable geometry.
  - [ ] 2.2.5 Require the agent review record to address missing parts, duplicate parts, transforms, gaps, collisions, truncated features, unexplained holes, floating or dangling members, unsupported spans, symmetry, interface reach, seam continuity, and conformance to the approved decomposition.
  - [ ] 2.2.6 Prohibit revision acceptance when the primary assembly artifact or its review record is absent, stale, source-mismatched, or failed.
  - [ ] 2.2.7 Invalidate assembly approval whenever geometry, transforms, interfaces, split ownership, source, config, `parts.json`, or `assembly.json` changes; require a compact review set on every affected iteration and the full set at milestone gates.
- [ ] 2.3 Strengthen ten-inch-rack interface governance.
  - [ ] 2.3.1 Update `playbooks/working_with_ten_inch_racks.md` to distinguish `height_u` from a complete `ten_inch_rack_module` interface.
  - [ ] 2.3.2 Require a unique interface contract and requirement matrix for every claimed rack module, bay, and mounting plane.
  - [ ] 2.3.3 Require every complete rack module to assert its full face span, both mounting columns, U-hole sequence, mounting plane, hardware, support mode, insertion path, removal path, service envelope, and approved exceptions.
  - [ ] 2.3.4 Prohibit satisfying rack-module conformance through U-height alone or through conformance evidence from a different interface.
  - [ ] 2.3.5 Prohibit grouped `PASS` declarations across independent rack interfaces.
- [ ] 2.4 Strengthen split-feature and structural-support governance.
  - [ ] 2.4.1 Update `playbooks/how_to_design_split_print_parts_and_verify_reassembly.md` to require a split policy for every feature approaching or crossing a split plane.
  - [ ] 2.4.2 Define the allowed policies as `continuous_across_seam`, `left_owned`, `right_owned`, `separate_bridge`, or `intentionally_terminated` with a documented reason.
  - [ ] 2.4.3 Require continuous features to be modeled in assembly coordinates before fabrication splitting, then verify the recombined result against the unsplit master.
  - [ ] 2.4.4 Update `playbooks/how_to_design_and_verify_structural_openscad_joins.md` to require a support/load-path contract for every rail, web, flange, bridge, and spanning panel.
  - [ ] 2.4.5 Require two structural supports for a spanning member or an explicit cantilever load case and verification.
  - [ ] 2.4.6 Require a positive mechanical joint when a structural member crosses a printable-part seam; coplanar ends and visual alignment must fail.
- [ ] 2.5 Put design-verification gates in dependency order.
  - [ ] 2.5.1 Update the iteration and CAD-review playbooks so the required order is intent contract, assembly review, interface conformance, structural/fit/print review, then artifact/provenance audit.
  - [ ] 2.5.2 State explicitly that manifoldness, connectivity, exact artifact counts, hashes, or a passing build audit cannot override an earlier semantic or assembly failure.
  - [ ] 2.5.3 Require one requirement per matrix row and evidence that names the exact assertion, artifact/view, config, source, and interface.
  - [ ] 2.5.4 Add the new playbooks to `AGENTS.md`, the root `README.md`, and the authoritative playbook index.
  - [ ] 2.5.5 Apply the new assembly gate immediately to new or geometry-modified multipart designs; mark untouched legacy multipart designs `legacy_assembly_unverified` and migrate them through separate approved plans rather than breaking them silently.

## 3. Add Machine-Enforced Assembly Contracts and Review Artifacts

- [ ] 3.1 Define and document `designs/<design>/assembly.json` schema version 1.
  - [ ] 3.1.1 Require a `primary_assembly`, nested logical subassemblies, printable leaf dispatch IDs, parent relationships, transforms, interface IDs, split policies, required views, and proxy classifications.
  - [ ] 3.1.2 Require every authoritative printable part in `parts.json` to map to exactly one printable leaf beneath a declared logical subassembly.
  - [ ] 3.1.3 Reject assembly members absent from dispatch, duplicate members, unknown transforms, missing primary assemblies, and undeclared printable parts.
  - [ ] 3.1.4 Keep `parts.json` authoritative for printable exports and `assembly.json` authoritative for assembled product identity; document the boundary between them.
- [ ] 3.2 Add an assembly-contract validator.
  - [ ] 3.2.1 Add `scripts/validate_cad_assembly_contract.py` with actionable errors naming the design, component, interface, and invalid field.
  - [ ] 3.2.2 Validate product-decomposition completeness, manifest-to-assembly coverage, stable member IDs, split policies, view requirements, interface evidence declarations, and source/config identity.
  - [ ] 3.2.3 Add positive and negative tests covering a valid assembly, an omitted module, a one-sided full-width interface, an undeclared fabrication subpart, and a stale review manifest.
  - [ ] 3.2.4 Independently derive exported-mesh bounds, rack-column locations, cross-seam span, receiver engagement, gaps, collisions, and shell connectivity rather than accepting `assembly.json` declarations or OpenSCAD construction parameters as proof.
  - [ ] 3.2.5 Require both construction assertions and independently derived exported-geometry evidence for every machine-verifiable interface claim.
- [ ] 3.3 Add governed assembly-review rendering.
  - [ ] 3.3.1 Add `scripts/scad_render_assembly_review.py` or extend existing build automation without mixing review artifacts into `output/<design>/`.
  - [ ] 3.3.2 Stage assembly review artifacts only under `.tmp/scad/<design>/assembly-review/`.
  - [ ] 3.3.3 Generate printable-only front, rear, left, right, top, bottom, isometric, exploded, skeleton-only, modules-only, seam, and declared interface-section artifacts.
  - [ ] 3.3.4 Write `assembly_review_manifest.json` containing exact expected names and hashes plus config, `parts.json`, `assembly.json`, OpenSCAD source-tree, Git, and artifact provenance.
  - [ ] 3.3.5 Add an audit-only mode that rejects missing, unexpected, stale, duplicate, or hash-mismatched review artifacts.
- [ ] 3.4 Integrate assembly review into completion gates.
  - [ ] 3.4.1 Update the manifest-build and provenance playbooks to require a passing assembly-contract validation and review audit before a complete design may be accepted.
  - [ ] 3.4.2 Update scripts or add a CI/local validation entrypoint so multipart designs cannot report completion without a passing primary assembly review.
  - [ ] 3.4.3 Update templates for design evidence and revision records with explicit architecture, assembly, interface, structural, printability, and artifact results.

## 4. Establish the Correct Cyberdeck-2 Product Contract

- [ ] 4.1 Declare the four non-negotiable logical subassemblies and their initial printable leaves.
  - [ ] 4.1.1 Declare `skeleton_assembly` as one logical subassembly initially fabricated as `skeleton_left` and `skeleton_right` printable leaves joined with M3 fasteners and registration.
  - [ ] 4.1.2 Declare `display_rack_module` as an independent full-width 2U ten-inch-rack logical subassembly mounted at 45 degrees.
  - [ ] 4.1.3 Declare `control_rack_module` as an independent full-width 3U flat arcade-control logical subassembly.
  - [ ] 4.1.4 Declare `raspberry_pi_rack_module` as an independent full-width rear 2U logical subassembly with the Raspberry Pi mounted sideways and an open back for connections.
  - [ ] 4.1.5 Assert that all three rack-module subassemblies cross the skeleton center seam, reach both rack mounting columns, engage both skeleton halves, remain independently removable, and remain identifiable with the skeleton hidden.
- [ ] 4.2 Define prohibited Cyberdeck-2 architectures.
  - [ ] 4.2.1 Prohibit integrating the display face or control panel into either skeleton half.
  - [ ] 4.2.2 Prohibit constraining any rack module to one skeleton half.
  - [ ] 4.2.3 Prohibit substituting a local opening, carrier, rail fragment, or decorative face for a complete rack module.
  - [ ] 4.2.4 Prohibit any full-width rail or panel from ending at the skeleton seam without an approved structural joint.
- [ ] 4.3 Define the three rack interface contracts before modeling.
  - [ ] 4.3.1 Create separate requirement rows for the display, control, and Raspberry Pi module mounting interfaces.
  - [ ] 4.3.2 Define each module's 254 mm nominal face relationship, 236.525 mm mounting columns, required U sequence, clearances, hardware, support, datum, and keepouts from the selected rack reference.
  - [ ] 4.3.3 Define matching receiver geometry and access on both skeleton halves for every module.
  - [ ] 4.3.4 Define insertion, removal, cable, airflow, fastener, washer, nut, and tool envelopes for each module; unresolved physical inputs remain `BLOCKED_UNKNOWN`.
  - [ ] 4.3.5 Define a local rack coordinate frame for each mounting plane and one explicit transform from that frame into the product assembly; validate rack dimensions locally and collisions globally.
  - [ ] 4.3.6 Define installation order and prove each module's insertion, fastening, service, and removal path with neighboring modules installed, or document and approve every dependency.
- [ ] 4.4 Define split and load-path contracts.
  - [ ] 4.4.1 Define the skeleton center split plane, left/right material ownership, M3 joining method, registration, and post-subtraction ligaments.
  - [ ] 4.4.2 Declare all three rack modules `continuous_across_seam` at the logical product level.
  - [ ] 4.4.3 Define how each rack module transfers load to both skeleton halves and whether it contributes to, but does not replace, the skeleton seam connection.
  - [ ] 4.4.4 Inventory every screen rail, panel edge, rack ear, receiver, boss, web, and flange with support endpoints and named structural engagement.
- [ ] 4.5 Pass a low-detail architectural blockout gate before detailed geometry or generalized tooling is accepted.
  - [ ] 4.5.1 Model only the skeleton envelope, its two fabrication leaves, and the three color-distinct full-width logical rack modules at their correct mounting planes.
  - [ ] 4.5.2 Render front, rear, left, right, top, bottom, isometric, exploded, skeleton-only, modules-only, and per-module isolation views with proxies omitted.
  - [ ] 4.5.3 Review module count, hierarchy, full-width span, both-column reach, both-half engagement, mounting-plane transforms, major collisions, unexplained voids, unsupported members, and overall user intent.
  - [ ] 4.5.4 Record the exact blockout source/config hashes and obtain explicit user approval before detailed holes, controls, retainers, bosses, rails, or service geometry are implemented.

## 5. Resolve Fabrication Decomposition and Printer Feasibility

- [ ] 5.1 Verify the declared printer envelope before deciding printable decomposition.
  - [ ] 5.1.1 Confirm the nominal `220 x 220 x 220 mm` volume, the `215 mm` usable-axis target, and required safety margins.
  - [ ] 5.1.2 Calculate collision-free print transforms and transformed bounds for the left skeleton, right skeleton, 2U display module, 3U control module, and rear 2U Raspberry Pi module.
  - [ ] 5.1.3 Review bed contact, overhangs, bridge spans, support access, surface-critical faces, and anisotropic load direction for every candidate transform.
- [ ] 5.2 Preserve logical architecture if a full-width module cannot print as one artifact.
  - [ ] 5.2.1 Prefer one printable artifact per full-width rack module when verified to fit safely.
  - [ ] 5.2.2 If any module cannot fit, stop and propose a fabrication split that reassembles into the same independent full-width rack module; do not absorb the split pieces into the skeleton.
  - [ ] 5.2.3 Obtain explicit approval before increasing the expected printable-part count or adding a rack-module seam.
- [ ] 5.3 Approve the before/after manifest migration only after print transforms pass.
  - [ ] 5.3.1 Record the rejected mapping: ID 1 integrated left chassis/control, ID 2 integrated right chassis/control, and ID 3 half-width Raspberry Pi insert.
  - [ ] 5.3.2 Record the preferred five-leaf mapping, conditional on verified print transforms: ID 1 left skeleton, ID 2 right skeleton, ID 3 full-width Raspberry Pi rack module, ID 4 full-width display rack module, and ID 5 full-width control rack module.
  - [ ] 5.3.3 Treat the ID 1/2 renames and ID 3 geometry/identity correction as an explicit pre-publication breaking migration; do not silently recycle identities.
  - [ ] 5.3.4 Calculate exact printable IDs and artifact counts only after fabrication decomposition and the review-render view suite are approved; retain 5 STL, 85 PNG, and 90 modeled artifacts only as the provisional five-leaf estimate.

## 6. Rebuild Cyberdeck-2 From Assembly Coordinates

- [ ] 6.1 Replace the integrated shell model with separated source responsibilities.
  - [ ] 6.1.1 Create explicit skeleton, display-module, control-module, Raspberry-Pi-module, assembly, proxy, and shared-interface source modules.
  - [ ] 6.1.2 Model all three rack modules at full assembled width in canonical rack coordinates before applying print transforms.
  - [ ] 6.1.3 Model the skeleton receivers from the same named rack datums and interface parameters as their corresponding modules.
  - [ ] 6.1.4 Generate the two skeleton halves from an unsplit skeleton master using strict left/right intersection and material ownership.
- [ ] 6.2 Implement the left and right skeleton halves.
  - [ ] 6.2.1 Provide matching mounting receivers on both halves for all three full-width rack modules.
  - [ ] 6.2.2 Reimplement the M3 center seam, registration, cable passages, service access, and structural webs without truncating any rack interface.
  - [ ] 6.2.3 Assert full seam engagement, receiver alignment, rack-column position, post-cut ligaments, minimum internal edges, and tool access.
  - [ ] 6.2.4 Render and review the skeleton-only artifact before adding rack modules.
- [ ] 6.3 Implement the full-width 2U display rack module.
  - [ ] 6.3.1 Build one independent 2U module spanning both skeleton halves at the approved 45-degree mounting plane.
  - [ ] 6.3.2 Place the display opening, retainers, mounting holes, connector/service envelope, and structural frame entirely within the module's ownership.
  - [ ] 6.3.3 Ensure every upper and lower rail has declared support endpoints and no seam-adjacent dangling member.
  - [ ] 6.3.4 Assert both rack-column engagements, U-hole sequence, opening rims, pairwise cut ligaments, structural overlaps, and transformed print bounds.
- [ ] 6.4 Implement the full-width 3U arcade-control rack module.
  - [ ] 6.4.1 Build one independent flat 3U module spanning both skeleton halves.
  - [ ] 6.4.2 Place the joystick, four diamond-arranged primary buttons, and two vertically arranged auxiliary buttons from named semantic parameters.
  - [ ] 6.4.3 Keep control hardware, wiring, terminals, and swept installation envelopes as independently classifiable reference geometry.
  - [ ] 6.4.4 Assert both rack-column engagements, U-hole sequence, control clearances, pairwise cut ligaments, panel edge margins, structural support, and transformed print bounds.
- [ ] 6.5 Implement the full-width rear 2U Raspberry Pi rack module.
  - [ ] 6.5.1 Build one independent rear 2U module spanning both skeleton halves and both rack mounting columns.
  - [ ] 6.5.2 Mount the Raspberry Pi sideways within the module using named board, boss, fastener, cooler/HAT, connector, and cable parameters.
  - [ ] 6.5.3 Keep the module back open across the required connection/service region without creating a one-sided or half-width bay.
  - [ ] 6.5.4 Assert both rack-column engagements, U-hole sequence, full module span, board retention, open-back edge margins, boss ligaments, insertion/removal clearance, and transformed print bounds.
- [ ] 6.6 Rebuild dispatch, manifests, and documentation together.
  - [ ] 6.6.1 Update `parts.json`, `assembly.json`, `main.scad`, config dependencies, source includes, and stable part names in one checkpoint.
  - [ ] 6.6.2 Keep printable exports free of display, Raspberry Pi, joystick, button, fastener, and cable proxy geometry.
  - [ ] 6.6.3 Update the design README and mutable revision record with the corrected architecture and exact unresolved measurements.

## 7. Verify Architecture, Assembly, Rack Conformance, and Structure

- [ ] 7.1 Pass the intent and product-decomposition gate.
  - [ ] 7.1.1 Verify that the assembly contains two skeleton halves and exactly three independent full-width logical rack modules.
  - [ ] 7.1.2 Verify that hiding the three modules leaves only the split skeleton with three complete receiving interfaces.
  - [ ] 7.1.3 Verify that hiding the skeleton leaves three coherent, independently identifiable full-width rack modules.
  - [ ] 7.1.4 Verify that no display, control, or Raspberry Pi module geometry has been absorbed into a skeleton half.
- [ ] 7.2 Pass the primary assembly visual-review gate.
  - [ ] 7.2.1 Render and audit every required primary assembly view from the exact candidate config and source.
  - [ ] 7.2.2 Review all views with proxies disabled, then separately with translucent proxies enabled.
  - [ ] 7.2.3 Record findings for gaps, collisions, dangling members, unexplained holes, truncated openings, center-seam discontinuities, mismatched receivers, missing components, and incorrect controls.
  - [ ] 7.2.4 Require explicit user review of the primary assembly artifact before accepting the architecture.
- [ ] 7.3 Pass all three rack-interface gates independently.
  - [ ] 7.3.1 Validate the rack v2.0.0 bundle and record the exact bundle manifest hash.
  - [ ] 7.3.2 Validate display-module conformance with its own assertions, sections, views, and requirement rows.
  - [ ] 7.3.3 Validate control-module conformance with its own assertions, sections, views, and requirement rows.
  - [ ] 7.3.4 Validate Raspberry-Pi-module conformance with its own assertions, sections, views, and requirement rows.
  - [ ] 7.3.5 Fail any module that does not span both skeleton halves, reach both mounting columns, or match its receiving interface.
- [ ] 7.4 Pass split-reassembly and structural gates.
  - [ ] 7.4.1 Compare the recombined skeleton halves against the unsplit skeleton master and investigate every difference beyond declared clearance geometry.
  - [ ] 7.4.2 Inspect sections at every interface start, midpoint, end, fastener neighborhood, opening corner, rack ear, skeleton seam, and support endpoint.
  - [ ] 7.4.3 Validate named wall, overlap, throat, edge, cut-to-edge, and pairwise cut-to-cut assertions after all subtractions.
  - [ ] 7.4.4 Audit each exported artifact for unexpected disconnected shells and inspect slicer layer paths through structural joins.
  - [ ] 7.4.5 Record structural joins and minimum internal edge/material width independently for the exact candidate config.
- [ ] 7.5 Pass fit and fabrication-risk gates.
  - [ ] 7.5.1 Resolve or explicitly block physical display, control hardware, Raspberry Pi stack, connector, airflow, cable, and tool envelopes.
  - [ ] 7.5.2 Create fit coupons for rack holes, M3 seam hardware, module-to-skeleton mounting, and any uncertain sliding or locating feature.
  - [ ] 7.5.3 Review final print orientations, supports, bed adhesion, bridges, surface quality, and printer bounds for every printable artifact.
  - [ ] 7.5.4 Do not call the design print-ready while any physical measurement, calibration, support, or slicer gate remains unresolved.

## 8. Build, Audit, Review, and Close the New Mutable Draft

- [ ] 8.1 Build and audit the exact printable manifest.
  - [ ] 8.1.1 Dry-run every dispatch and verify the approved manifest/config pair and expected artifact names.
  - [ ] 8.1.2 Build the complete manifest through `.tmp/scad/cyberdeck-2/` and atomically replace only `output/cyberdeck-2/` after exact-set validation.
  - [ ] 8.1.3 Audit expected versus actual STL/PNG counts, names, byte sizes, hashes, source/config/manifest provenance, and absence of stale rejected-draft artifacts.
- [ ] 8.2 Build and audit the primary assembly review separately.
  - [ ] 8.2.1 Generate the primary assembly artifact set under `.tmp/scad/cyberdeck-2/assembly-review/`.
  - [ ] 8.2.2 Audit the assembly review manifest and confirm that it references the same config, printable manifest, assembly contract, source tree, and Git state as the complete printable build.
  - [ ] 8.2.3 Complete the findings-first agent review and obtain user acceptance of the assembled architecture.
- [ ] 8.3 Update all lifecycle records.
  - [ ] 8.3.1 Update `designs/cyberdeck-2/README.md`, the mutable revision record, root `README.md`, applicable playbooks, `AGENTS.md`, and the journal.
  - [ ] 8.3.2 Record every remaining `BLOCKED_UNKNOWN`, physical-test requirement, structural result, minimum-edge result, printability result, build count, artifact audit, and provenance result.
  - [ ] 8.3.3 Keep immutable `revisions/cyberdeck-2/rev_0001/` publication out of scope until all fabrication-readiness gates pass and the user separately approves publication.
- [ ] 8.4 Close the governed redesign checkpoint.
  - [ ] 8.4.1 Run plan-index regeneration and all new validator/test/check modes.
  - [ ] 8.4.2 Review the complete diff for unrelated or stale changes and map every changed file to an approved leaf item.
  - [ ] 8.4.3 Propose task-scoped commit boundaries for governance/tooling and Cyberdeck-2 geometry, then obtain approval before committing.
  - [ ] 8.4.4 Move this plan to `plans/past/` only after no approved implementation or verification work remains.

## Corrected Canonical Architecture

| Logical subassembly | Initial printable leaves | Required role | Crosses skeleton seam | Must engage both skeleton halves | May be absorbed into skeleton |
|---|---|---|---:|---:|---:|
| `skeleton_assembly` | `skeleton_left`, `skeleton_right` | Split structural receiver skeleton | N/A | N/A | N/A |
| `display_rack_module` | One preferred; approved split allowed | Independent full-width 2U display module at 45 degrees | Yes | Yes | No |
| `control_rack_module` | One preferred; approved split allowed | Independent full-width 3U flat arcade-control module | Yes | Yes | No |
| `raspberry_pi_rack_module` | One preferred; approved split allowed | Independent full-width rear 2U open-backed Pi module | Yes | Yes | No |

The three rack modules are logical product components even if later print-volume
evidence requires an approved fabrication split. A fabrication split must
reassemble into the same removable full-width module and must never transfer the
module's geometry or ownership into the skeleton.

## Rejected and Target Manifest Mapping

| Part ID | Rejected identity | Target identity | Migration treatment |
|---:|---|---|---|
| 1 | Integrated left chassis/control module | Left skeleton half | Explicit pre-publication rename and geometry replacement |
| 2 | Integrated right chassis/control module | Right skeleton half | Explicit pre-publication rename and geometry replacement |
| 3 | Half-width Raspberry Pi insert | Full-width Raspberry Pi rack module | Preserve conceptual Pi role; replace invalid interface and geometry |
| 4 | Absent | Full-width display rack module | New printable export |
| 5 | Absent | Full-width control rack module | New printable export |

This five-export target is conditional on print-volume verification. If a rack
module requires multiple fabrication parts, pause and revise this mapping with
user approval while preserving the four-subassembly logical architecture.

## Authority, Baselines, and Host Overrides

- Rack reference: `ten-inch-rack-m3-printed-design-spec` v2.0.0.
- Rack bundle manifest SHA-256:
  `330051136930b54f0abf91ff81ea217d0e6cad2dbe6503375ffb219e59e0210d`.
- Host minimum wall thickness: `3 mm`.
- Host minimum structural overlap: `3 mm` and never less than wall thickness.
- Host minimum internal edge/material width: `3 mm`.
- Primary rack and seam hardware family: M3x0.5 with ISO 7089 M3 washers;
  final head, nut, stack, tool, and calibration details remain unresolved.
- Nominal printer volume: `220 x 220 x 220 mm`; candidate usable-axis target:
  `215 x 215 x 215 mm`, subject to verification for each print transform.
- Mutable candidate lineage remains `rev_0001`; immutable publication remains
  prohibited until separately approved after all publication gates pass.

## Required Cyberdeck-2 Interface Assertions

Each of `display_rack_module`, `control_rack_module`, and
`raspberry_pi_rack_module` must have independently named assertions and evidence
for at least:

```text
module_is_independently_defined
module_printable_leaf_coverage_is_complete
module_reassembles_independently_of_skeleton
module_is_present_in_primary_assembly
module_spans_skeleton_center_seam
module_reaches_left_rack_mounting_column
module_reaches_right_rack_mounting_column
module_matches_left_skeleton_receiver
module_matches_right_skeleton_receiver
module_u_height_matches_contract
module_u_hole_sequence_matches_contract
module_has_declared_insertion_path
module_has_declared_removal_path
module_has_declared_support_endpoints
module_post_cut_minimum_edge_width
module_post_cut_minimum_structural_overlap
module_transformed_bounds_fit_printer
exported_geometry_confirms_module_span
exported_geometry_confirms_both_receiver_engagements
exported_geometry_confirms_expected_shell_connectivity
```

Passing assertions must be tied to the exact module interface, source tree,
config, assembly artifact, and review record. Evidence from one module cannot be
used to pass another module. Declarative fields and construction parameters are
requirements, not independent proof; exported-geometry measurements must confirm
every machine-verifiable spatial claim.

## Required Assembly Review Artifacts

- Printable-only: front, rear, left, right, top, bottom, and isometric.
- Printable-only exploded assembly.
- Skeleton-only isometric plus views of all six module-receiver sides.
- Modules-only isometric showing three independent full-width rack modules.
- Center-seam crop and section for each module mounting plane.
- Left and right rack-column crop for each of the three modules.
- Display-frame support sections with the display proxy hidden.
- Rear Pi-module open-back and service-path views with the Pi proxy translucent.
- Control-layout view with all reference hardware independently toggleable.
- A findings-first review record bound by hash to all rendered artifacts.

The compact iteration set is printable-only front, rear, left, right, isometric,
skeleton-only, modules-only, and the affected interface/seam crops. Regenerate
it after every architecture-affecting change. The complete set above is required
at blockout, detailed-geometry, and mutable-release milestones.

## Known Inputs and Publication Blockers

- Exact touchscreen face, body, hole, connector, cable, and retention dimensions.
- Exact joystick body, mounting pattern, shaft, plate, and swept envelope.
- Exact primary and auxiliary button diameters, bodies, terminals, and wiring.
- Exact Raspberry Pi model, board mounting pattern, cooler/HAT stack, ports,
  connector bodies, cable bends, airflow, and service access.
- Rack internal depth, front/rear reserved zones, module insertion paths, and
  cable ownership.
- Final M3 screw heads, nuts or inserts, washers, stack lengths, driver access,
  tightening sequence, and calibration results.
- Material, nozzle, layer height, printer/profile calibration, print orientation,
  supports, bed adhesion, bridge behavior, and slicer-layer verification.

Unknown physical inputs may remain parameterized during architectural drafting,
but every affected requirement must be `BLOCKED_UNKNOWN`, and immutable
publication or fabrication-readiness claims are prohibited.

## Planned Files and Areas

- `AGENTS.md`
- `README.md`
- `templates/`
- `playbooks/how_to_define_and_verify_canonical_product_decomposition.md`
- `playbooks/how_to_create_and_review_multipart_assembly_artifacts.md`
- `playbooks/working_with_ten_inch_racks.md`
- `playbooks/how_to_design_split_print_parts_and_verify_reassembly.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`
- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_review_cad_changes_for_risk_and_regression.md`
- `playbooks/how_to_build_install_and_audit_manifest_driven_openscad_designs.md`
- `playbooks/how_to_record_cad_verification_and_artifact_provenance.md`
- `scripts/validate_cad_assembly_contract.py`
- `scripts/scad_render_assembly_review.py` or approved equivalent integration
- validator and assembly-render tests/fixtures
- `designs/cyberdeck-2/assembly.json`
- `designs/cyberdeck-2/parts.json`
- `designs/cyberdeck-2/src/`
- `designs/cyberdeck-2/configs/`
- `designs/cyberdeck-2/docs/`
- `designs/cyberdeck-2/README.md`
- `plans/` and `journal/`

## Verification Commands and Evidence

The exact command surface may change under approved tooling work, but completion
must include equivalents of:

```powershell
python scripts/regenerate_plan_indexes.py --check --repo-root .
python scripts/validate_ten_inch_rack_reference.py
python scripts/validate_cad_assembly_contract.py --design cyberdeck-2 --config <candidate-config>
python scripts/scad_render_assembly_review.py --design cyberdeck-2 --config <candidate-config>
python scripts/scad_render_assembly_review.py --design cyberdeck-2 --config <candidate-config> --audit-only
python scripts/scad_build_all.py --design cyberdeck-2 --config <candidate-config>
python scripts/scad_build_all.py --design cyberdeck-2 --config <candidate-config> --audit-only
```

Also required:

- automated positive and negative tests for the new assembly schema and gates;
- OpenSCAD assertion runs for every printable dispatch and assembly dispatch;
- transformed build-volume reports for every printable artifact;
- section and crop review for every structural interface and full-width module;
- STL shell/connectivity audit and slicer-layer-path review;
- exact expected/actual printable and assembly-review artifact counts;
- config, parts-manifest, assembly-contract, source-tree, Git, and artifact hashes;
- explicit user approval of the corrected primary assembly before immutable
  revision publication is proposed.

## Completion Definition

This plan is complete only when the repository enforces the new governance, the
rejected draft is accurately recorded, and Cyberdeck-2's reviewed primary
assembly visibly and mechanically consists of one two-leaf skeleton subassembly
receiving three independent full-width ten-inch-rack-module subassemblies. A passing render, manifold
STL, connected shell, assertion set, artifact count, or provenance audit is not
sufficient without a passing canonical-architecture and assembly review.
