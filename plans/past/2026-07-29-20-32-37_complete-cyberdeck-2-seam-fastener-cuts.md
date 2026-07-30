---
plan_id: 2026-07-29-20-32-37_complete-cyberdeck-2-seam-fastener-cuts
title: Complete Cyberdeck-2 Seam Fastener Cuts
summary: Remove shell material that occludes half of each seam fastener passage and verify all four installed holes as complete enclosed circles.
status: past
created_at: 2026-07-29-20-32-37
---

# Complete Cyberdeck-2 Seam Fastener Cuts

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

The installed top/bottom assembly views and the user's slicer screenshot show
that every nominally circular seam opening is only partially present. Diagnosis:
the passage, head recess, and nut recess were subtracted from the crossing
flanges, but the later union with the owning half's main shell left half of each
opening filled by the top/bottom plate or front/rear shell material.

## 1. Correct Boolean Ownership

- [x] 1.1 Apply each vertical 3.6 mm passage and 8.25 mm head recess to the
  right owning shell as well as its crossing head flange at all four stations.
- [x] 1.2 Apply each vertical passage and captive 5.9 mm AF nut opening to the
  left owning shell as well as its crossing nut flange at all four stations.
- [x] 1.3 Preserve the existing flange overlap, 3 mm root web, 3 mm radial
  material, 0.3 mm general clearance, local compression land, bay keepout, and
  planar exterior bounds.

## 2. Add Regression Evidence

- [x] 2.1 Add dedicated exterior fastener crops or sections that make complete
  circular head openings and complete internal nut openings unambiguous.
- [x] 2.2 Inspect every top/bottom and front/rear station in isolated leaves and
  assembled views; reject crescents, edge breakouts, or shell-filled passages.

## 3. Rebuild and Verify the Real Artifacts

- [x] 3.1 Rebuild the complete printable manifest and full assembly set into the
  single `output/cyberdeck-2/` directory through the corrected normal pipeline.
- [x] 3.2 Pass source assertions, rack/assembly validators, exact unified output
  audits, print bounds, connected-shell checks, and independent combined bounds.
- [x] 3.3 Review the actual combined STL and output PNGs, not source previews;
  preserve explicit physical/slicer/calibration limits.

## 4. Document and Close

- [x] 4.1 Update Cyberdeck-2 fastener, validation, and assembly-review records,
  append the journal, and record exact rebuilt hashes.
- [x] 4.2 Archive this plan, regenerate/check indexes, review the complete diff,
  and commit all accumulated approved changes. Do not push unless requested.

## Planned Files

- `designs/cyberdeck-2/src/parts/enclosure_blockout.scad`
- `designs/cyberdeck-2/assembly.json` if new review views are required
- `designs/cyberdeck-2/docs/*.md`
- this plan, plan indexes, and `journal/2026-07-29.md`

## Acceptance

All four fastener stations must show a complete circular exterior head opening
and a complete internal captive-nut opening in final installed evidence. A
successful render, manifold STL, or partial circular silhouette is insufficient.
