---
plan_id: 2026-07-29-19-11-14_internalize-cyberdeck-2-seam-and-add-device-rails
title: Internalize Cyberdeck-2 Seam Hardware and Add Device Rails
summary: Replace the exterior seam bumpouts with protected internal joints and add rails that support the 2U device while preserving its governed clearance envelope.
status: past
created_at: 2026-07-29-19-11-14
---

# Internalize Cyberdeck-2 Seam Hardware and Add Device Rails

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

The user approved the architecture on 2026-07-29: remove the four exterior
bumpouts, retain additional chassis space above and below the 2U insert area,
place the seam studs/joints inside those protected service zones, and add rails
to support the device weight.

## 1. Preserve the Product and Rack Contract

- [x] 1.1 Keep exactly two longitudinal printable leaves and the existing
  product/subassembly hierarchy.
- [x] 1.2 Preserve the 254 mm front width, 222.25 x 88.90 mm clear 2U envelope,
  twelve canonical front insert bores, 215 mm depth, and integral rear wall.
- [x] 1.3 Keep the current 121.3 mm maximum exterior height unless verification
  proves more is necessary; make the top and bottom exterior surfaces flush.

## 2. Internalize the Four-Fastener Seam

- [x] 2.1 Extend the rectangular side/front/rear shell to the full exterior
  height and relocate the top/bottom plates to its flush extrema.
- [x] 2.2 Relocate all four seam pads, through-holes, counterbores, captive-nut
  recesses, and lap registrations into the upper/lower service zones outside the
  2U device envelope.
- [x] 2.3 Preserve at least 3 mm wall, root overlap, edge width, recess residual,
  and key/pocket ligament at every joint.
- [x] 2.4 Verify straight exterior driver and nut access without any projection
  above or below the flush chassis surfaces.

## 3. Add Device-Weight Support

- [x] 3.1 Add continuous front-to-rear lower support rails whose top surfaces
  define the bottom of the 88.90 mm equipment envelope.
- [x] 3.2 Give each rail two positive-volume supports, at least 3 mm thickness
  and width, and keep rail geometry outside the generic 220 mm body envelope.
- [-] 3.3 Upper guides are not required for weight support and are deliberately
  omitted to preserve insertion clearance; rack ears provide vertical retention.

## 4. Verify and Build

- [x] 4.1 Run rack, structural, fastener, clearance, print-bound, source, and
  assembly-contract assertions and validators.
- [x] 4.2 Render and inspect sections through the support rails and all four
  internalized seam joints, including their roots and minimum throats.
- [x] 4.3 Build and atomically install the complete two-part manifest through
  the normal pipeline; require exactly 2 STL and 34 PNG and pass the audit.
- [x] 4.4 Review the exact installed artifacts, then regenerate and audit the
  artifact-bound full assembly set and combined STL.
- [x] 4.5 Record physical/slicer/calibration limits without claiming fabrication
  readiness.

## 5. Document and Close

- [x] 5.1 Update the design README, rack/depth report, structural/fastener
  report, validation log, and assembly review for the exact candidate.
- [x] 5.2 Append the journal, archive this plan, regenerate/check indexes, review
  the complete diff, and commit all changes. Do not push unless requested.

## Planned Files

- `designs/cyberdeck-2/configs/rev_0001.json`
- `designs/cyberdeck-2/src/lib/defaults.scad`
- `designs/cyberdeck-2/src/parts/enclosure_blockout.scad`
- `designs/cyberdeck-2/assembly.json`
- `designs/cyberdeck-2/README.md`
- `designs/cyberdeck-2/docs/*.md`
- this plan, plan indexes, and `journal/2026-07-29.md`

## Readiness Limits

The rails are governed geometric supports for a generic 220 mm-wide device
proxy. Specific device foot geometry, mass, center of gravity, rail contact,
material, layer orientation, creep, shock loading, insert calibration, and
physical fit remain unknown until measured and tested.
