---
plan_id: 2026-09-17-13-19-04_micro-cyberdeck-case-top-band-ledges-height-2mm
title: Reduce micro_cyberdeck_case top band ledge height to 2 mm (rev_0004 amend)
summary: Change the z extent of both top-band ledges from 3 mm (z = 42..45) to 2 mm (z = 43..45, top-aligned to the rim) per user direction, in-place amend of the rev_0004 candidate; rebuild, re-verify, and amend docs/provenance.
status: past
created_at: 2026-09-17-13-19-04
---

# Reduce micro_cyberdeck_case top band ledge height to 2 mm (rev_0004 amend)

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

User direction (verbatim): "i want to change the thickness (height) of the shelves on the left and
ride side to 2mm" — clarified to the z extent (band height) of the both-wall top-band ledges.
Approved strategy: new `top_band_height` parameter (default 3.0, older configs unchanged),
band becomes z = rim - 2 .. rim (top-aligned), depth stays 3 mm; in-place amend of the
rev_0004 candidate (no new revision, single-part design).

## 1. Source

- [x] 1.1 defaults.scad: add top_band_height (fallback 3.0); comment the 2 mm band-height
      user-directed exception to minimum_internal_edge_width
- [x] 1.2 case_body.scad: bottom_z = rim - top_band_height; asserts (positive height,
      bottom >= upper window top, documented 2.0 mm floor)
- [x] 1.3 rev_0004.json: add top_band_height: 2.0

## 2. Build + verify

- [x] 2.1 Rebuild rev_0004: 0 warnings, 1 STL + 17 PNG flat in output/
- [x] 2.2 Volume exactly 33,440.773222 mm³ (-252.000000 vs 801e0e9; = 2 ledges x 3 x 42 x 1
      removed z=42..43 strip); bounds [0,0,0]..[76,45,45] unchanged
- [x] 2.3 Facet delta vs 801e0e9 = 1904 vs 1908 (-4; z=42 coplanar faces merged);
      envelope clip stats confirm both ledges now z = 43..45
- [x] 2.4 Old-config isolation rev_0001..0003 (no top_band keys -> fallbacks, unchanged)

## 3. Docs

- [x] 3.1 Design README R4 section: 2 mm ledge height + fresh provenance
- [x] 3.2 Root README design entry line
- [x] 3.3 Journal 2026-09-17 entry

## 4. Closeout

- [x] 4.1 Archive plan to past; regenerate indexes; --check exit 0
- [ ] 4.2 Commit approved file set with approved message; push only on approval
