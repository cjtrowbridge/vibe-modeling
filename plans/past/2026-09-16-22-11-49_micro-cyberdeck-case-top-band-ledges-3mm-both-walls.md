---
plan_id: 2026-09-16-22-11-49_micro-cyberdeck-case-top-band-ledges-3mm-both-walls
title: Extend micro_cyberdeck_case top band ledges to 3 mm on both walls (rev_0004 amend)
summary: Grow the left-wall top-band ledge from 1 mm to 3 mm into the cavity and add a symmetric 3 mm ledge on the right (fan) wall pointing inward (band z = 42..45, full wall width y = 0..45) per user direction, rebuild and re-verify the rev_0004 candidate in place, and amend the R4 record and provenance.
status: past
created_at: 2026-09-16-22-11-49
---

# Extend micro_cyberdeck_case top band ledges to 3 mm on both walls (rev_0004 amend)

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

User direction (verbatim): "i want to increase the 1mm to 3mm and add the same thing
on the right side, also pointing inward." Approved strategy: symmetric pair of flat
ledges on the top band (z = 42..45), each 3 mm deep into the cavity, in-place amend
of the rev_0004 candidate (no new revision, no parts.json single-part design).

## 1. Source

- [x] 1.1 defaults.scad: top_band_cavity_extension stays; add top_band_right_enabled
      (default false, older configs unchanged); note the 3 mm now meets
      minimum_internal_edge_width (drop 1 mm exception language)
- [x] 1.2 case_body.scad: add _right_wall_top_band_extension() at x = case_inner_x_max - ext;
      union when enabled; adjust asserts (>= minimum_internal_edge_width floor)
- [x] 1.3 rev_0004.json: top_band_cavity_extension 1.0 -> 3.0; top_band_right_enabled true

## 2. Build + verify

- [x] 2.1 Rebuild rev_0004: 0 warnings, STL 1 + PNG 17 flat in output/
- [x] 2.2 Volume exactly +630.000000 mm3 vs 81dd652 STL -> 33,692.7732; bounds unchanged
- [x] 2.3 Facet isolation + ray parity vs current STL; section probes z=43.5, y=22.5 removed after
- [-] 2.4 --audit-only pass; old-config isolation rev_0001..0003 byte-identical
      (audit: not applicable to this single-part design; isolation: verified - older
      configs declare no top_band_* keys, is_undef fallbacks keep both ledges disabled)

## 3. Docs

- [x] 3.1 Design README R4 section: 3 mm both-wall ledges
- [x] 3.2 Root README design entry line
- [x] 3.3 Journal 2026-09-16 entry

## 4. Closeout

- [x] 4.1 Archive plan to past; regenerate indexes; --check exit 0
- [ ] 4.2 Commit approved file set with approved message; push only on approval
