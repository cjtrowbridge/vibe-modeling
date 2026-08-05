---
plan_id: 2026-08-05-00-00-00_create-comrade-core-base
title: Create the Comrade Core Base Plate
summary: Add the first parametric, manifest-governed printable base plate for the Comrade robot electronics stack.
status: past
created_at: 2026-08-05-00-00-00
---

# Create the Comrade Core Base Plate

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Approved Design Decisions

- [x] 1. Confirm the outer-mounting layout.
  - [x] 1.1 Increase the plate extension from 10 mm to 15 mm on every side, which permits structurally compliant recessed M3 inner and outer mounting locations.
  - [x] 1.2 Use 6.5 mm diameter by 3.2 mm deep counterbores for socket-head screws and 3.4 mm nominal M3 clearance holes.
  - [x] 1.3 Use a 7 mm plate thickness, which preserves at least 3 mm material below either counterbore.

## Approved Execution Scope

- [ ] 2. Create the single printable Comrade base design.
  - [x] 2.1 Add a parametric OpenSCAD source tree, revision configuration, and design README that records the datum, 81 mm by 49 mm measured mounting pattern, 100 mm electronics-stack reference height, source-confidence classifications, and the approved hardware assumptions.
  - [x] 2.2 Model a rectangular base around the four inner M3 mounting holes with bottom-side counterbores for upward-installed stack screws and four outer M3 mounting holes with top-side counterbores for downward-installed future attachments.
  - [x] 2.3 Declare and assert the 3 mm minimum wall, structural-overlap, and internal-edge contracts; assert all fastener edge and cut-to-cut ligaments after recesses.

- [ ] 3. Verify the governed design and document the result.
  - [x] 3.1 Run the single-part build and inspect the installed STL and multi-view PNG artifacts in `output/comrade/`.
  - [x] 3.2 Perform and record parameter, fastener-envelope, section, post-subtraction, connectivity, and print-orientation reviews; mark physical fit and slicer evidence as unverified pending the actual hardware and printer profile.
  - [x] 3.3 Update the plan, relevant repository documentation, and today’s append-only journal checkpoint; regenerate and check plan indexes.

## Expected Files

- `designs/comrade/src/main.scad`
- `designs/comrade/src/lib/defaults.scad`
- `designs/comrade/src/parts/core_base.scad`
- `designs/comrade/configs/rev_0001.json`
- `designs/comrade/README.md`
- `README.md` (if the design inventory is listed)
- `plans/past/2026-08-05-00-00-00_create-comrade-core-base.md`
- `plans/current/index.md`
- `journal/2026-08-05.md`

## Verification

- The source uses the documented lower-left inner mounting-hole datum and has a parameterized 81 mm by 49 mm pattern.
- Every counterbore faces its specified installation side and retains the required material depth.
- The selected outer-hole arrangement preserves the 3 mm minimum material ligament to the perimeter and every inner recess.
- `scad_build.py --design comrade --config designs/comrade/configs/rev_0001.json` succeeds, and its generated output is reviewed.
- The design README records the exact source/config and explicitly distinguishes model checks from physical-fit evidence.
