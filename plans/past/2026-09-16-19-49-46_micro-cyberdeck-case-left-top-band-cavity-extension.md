---
plan_id: 2026-09-16-19-49-46_micro-cyberdeck-case-left-top-band-cavity-extension
title: Extend micro_cyberdeck_case left-wall top band 1 mm into the cavity (rev_0004 amend)
summary: Thicken the left-wall band above the micro-SD (upper) window from 3 mm to 4 mm (internal face x = 3 -> x = 4, band z = 42..45, full wall width y = 0..45) per user direction, rebuild and re-verify the rev_0004 candidate in place, and amend the R4 record and provenance.
status: past
created_at: 2026-09-16-19-49-46
---

# Extend micro_cyberdeck_case left-wall top band 1 mm into the cavity (rev_0004 amend)

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

Geometry basis (user direction, 2026-09-16, verbatim: "i want to extend just the very
top piece of the left side that goes across the top opening to be 1mm thicker into
the cavity"; amends the same rev_0004 candidate committed as `13b2ed0`; envelope
unchanged at 76 x 45 x 45 mm, open top / open front):

- The referenced piece is the solid band of the left wall directly above the
  micro-SD (upper) window: `x = 0..3`, `y = 0..45`, `z = 42..45`. Its bottom edge
  (`z = 42`) is the window top (`microsd_max_z()`); its top edge is the rim
  (`case_outer_height()`, `z = 45`); it spans the full wall width and crosses the
  top opening.
- The band's internal face (currently `x = wall_thickness = 3`) moves 1 mm into
  the cavity to `x = 4`: band becomes `x = 0..4`, `y = 0..45`, `z = 42..45`.
- New material is the shelf `x = 3..4`, `y = 0..42`, `z = 42..45` (the `y = 42..45`
  portion already exists as back wall): 1 x 42 x 3 = **+126.000000 mm³**. Expected
  body volume 32,936.77 + 126 = **33,062.77 mm³** (33,062.7732 signed). Bounds
  unchanged: `[0, 0, 0]` to `[76, 45, 45]`.
- Nothing else changes: left wall and floor stay 3 mm everywhere else; windows,
  divider, back-wall rail (ledge `y = 39..42`, band `z = 37..40`, span `x = 8..65`),
  and fan interface are untouched. The shelf tip (`x = 4`) is 4 mm clear of the
  rail start (`x = 8`) and clears the rail band in `z` as well (shelf `z = 42..45`,
  rail `z = 37..40`); no cut intersects the shelf band.
- Out of scope, deliberately (open questions reported to the user, not included
  here): (a) the "extends further down" component of the 2026-09-16 6:47 PM
  exchange (would lower the band bottom `z = 42 -> 41`); (b) what to do with the
  back-wall rail 3 x 3 amend in `13b2ed0`, which was built on a misread of that
  same exchange.

Governance notes (structural-joins playbook applies; rim/edge geometry):

- Structural join: the shelf unites to the left wall over a 45 x 3 mm
  coplanar-union face (internal wall face `x = 3`, `y = 0..45`, `z = 42..45`) and
  overlaps the back wall at `y = 42..45` (3 x 3 mm cross-section). Two verified
  supports; classified as a flat retention ledge, no load path expected; the
  1 mm overhang (bottom face `z = 42`) is a 1:1 cantilever, printable without
  supports.
- Minimum internal edge/material width: the 1 mm shelf thickness deliberately runs
  below the declared 3.0 mm `minimum_internal_edge_width`. This is a user-directed
  feature exception (documented, asserted floor `>= 1.0`), analogous to the other
  documented relaxations in this design; it is not a general relaxation.
- Rev practice: single-part design (no `parts.json`), no `revisions/` snapshots.
  The rev_0004 candidate is amended in place (established practice for this
  design); the R4 verification record and SHA-256 provenance in the design README
  are amended in the same commit. Git history retains the `13b2ed0` artifacts
  unchanged.
- Older configs (`rev_0001`..`rev_0003`) keep rendering unchanged via
  `defaults.scad` `is_undef` fallbacks (`top_band_extension_enabled` false).

- [ ] 1. Mutable source + config
  - [x] 1.1 `designs/micro_cyberdeck_case/src/lib/defaults.scad`: add
    `top_band_extension_enabled` (fallback `false`) and
    `top_band_cavity_extension` (fallback `1.0`) with a comment block naming the
    piece (left-wall band above the micro-SD window, internal face `x = 3 -> 4`).
  - [x] 1.2 `designs/micro_cyberdeck_case/src/parts/case_body.scad`: add derived
    band functions (`left_top_band_bottom_z() = microsd_max_z()`,
    `left_top_band_top_z() = case_outer_height()`), a
    `_left_wall_top_band_extension()` module (union shelf
    `x = wall_thickness..wall_thickness + top_band_cavity_extension`,
    `y = 0..back_wall_y()`, `z = band bottom..top`), union it into
    `_case_positive()` when enabled, and update the file's wall/feature comments.
  - [x] 1.3 `case_body.scad` `_assert_case_dimensions()`: when enabled, assert the
    shelf extension is positive and `<= wall_thickness`, the band is non-degenerate
    (`left_top_band_top_z() - left_top_band_bottom_z() > 0`), and the documented
    `>= 1.0` floor (user-directed exception to the 3 mm internal-edge minimum) with
    its comment.
  - [x] 1.4 `designs/micro_cyberdeck_case/configs/rev_0004.json`: add
    `"top_band_extension_enabled": true` and `"top_band_cavity_extension": 1.0`.
- [ ] 2. Build and verification
  - [x] 2.1 Rebuild the candidate with `python scripts/scad_build.py --design
    micro_cyberdeck_case --config designs/micro_cyberdeck_case/configs/rev_0004.json`
    into flat `output/micro_cyberdeck_case/`: 1/1 STL + 17/17 PNG, zero OpenSCAD
    warnings or errors, all assertions pass.
  - [x] 2.2 Numeric STL verification (repo-external temporary probe script, deleted
    after): bounds `[0, 0, 0]` to `[76, 45, 45]`; signed volume 33,062.77 mm³
    (exact +126.000000 mm³ vs `13b2ed0`'s 32,936.77 mm³); 3D point-in-solid parity
    — shelf core `(3.5, 22.5, 43.5)` solid, shelf front strip `(3.5, 1.5, 43.5)`
    solid, back-wall corner `(3.5, 43.5, 43.5)` solid, old wall `(2.5, 22.5, 43.5)`
    solid, beyond the shelf tip `(4.5, 22.5, 43.5)` void, below the band
    `(3.5, 22.5, 41.0)` void, cavity `(22.5, 22.5, 43.5)` void, rail-ledge regression
    point `(36.5, 40.5, 38.5)` solid.
  - [x] 2.3 Governed temporary section probes (gated behind `-D sect=N`, rendered,
    viewed, removed with the probe file): (a) horizontal section at `z = 43.5` —
    1 mm shelf strip `x = 3..4` spanning `y = 0..42`, continuous into the back
    wall, 4 mm clear of the rail start; (b) constant-`y` section at `y = 22.5` —
    left-wall profile: 3 mm wall with a 1 mm step at `z = 42..45`, both windows
    untouched below; (c) an interior view (iso right) — shelf visible inside the
    cavity along the full width above the upper window.
  - [x] 2.4 Regression isolation: extract the committed `13b2ed0` rev_0004 STL from
    Git and compare facet multisets; the delta must be confined to the shelf band
    (`x = 3..4`, `y = 0..45`, `z = 42..45`) plus coplanar re-triangulation on the
    `z = 45` top faces / `x = 3` wall face, with the signed volume delta exactly
    +126.000000 mm³.
  - [x] 2.5 Cleanup: flat `output/micro_cyberdeck_case/` (18 files, no directories,
    no staged `.scad`), all temporary probe scripts deleted.
- [ ] 3. Documentation
  - [x] 3.1 `designs/micro_cyberdeck_case/README.md`: amend the R4 section in place
    — dimensions (left-wall top band now 4 mm at `z = 42..45`, internal face
    `x = 4`), verification record (volume 33,062.77 mm³, probe updates, structural
    join + documented 1 mm exception), and SHA-256 provenance for the amended
    candidate.
  - [x] 3.2 Root `README.md`: update the design description only if it currently
    describes this geometry (it describes the rev_0004 rail geometry, so the
    left-wall top-band shelf clause was added to the design entry).
  - [x] 3.3 `journal/2026-09-16.md`: append the work-log entry for this amend.
- [ ] 4. Plan maintenance and stop point
  - [x] 4.1 Archive this plan to `plans/past/`; regenerate and verify indexes with
    `python scripts/regenerate_plan_indexes.py --repo-root .` (and `--check`).
  - [x] 4.2 Review the complete diff (including the two still-uncommitted
    bookkeeping files from the prior task: the 19:21 journal entry and the 3 x 3
    plan's final flag); propose the task-scoped commit message; **stop and request
    approval before committing or pushing**. Proposed commit message: "Extend
    micro_cyberdeck_case left top band 1 mm into the cavity (rev_0004 amend)".