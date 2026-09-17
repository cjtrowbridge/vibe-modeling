---
plan_id: 2026-09-16-17-16-01_micro-cyberdeck-case-back-rail-rev-0004
title: Add back-wall rail to micro_cyberdeck_case as rev_0004
summary: Add a 57 mm horizontal 2 x 2 mm rail on the back wall's internal face (top 5 mm below the rim, 5 mm in from each internal side wall) with a full-wall through tenon, published as rev_0004.
status: past
created_at: 2026-09-16-17-16-01
---

# Add back-wall rail to micro_cyberdeck_case as rev_0004

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

Approved geometry basis (user direction, 2026-09-16, on the rev_0003 envelope of
76 x 45 x 45 mm, open top / open front):

- Rail extends from 5 mm off the left internal wall to 5 mm off the right
  internal wall: `x = 8..65` (57 mm span; internal walls at `x = 3` and
  `x = 70`).
- Rail cross-section 2 mm (y) x 2 mm (z); top 5 mm below the rim: `z = 38..40`.
- Rail sits inside (in front of) the back wall and is **extended through to the
  other face of the back wall**: the module spans `y = 40..45` — a 2 mm ledge
  protruding into the chamber (`y = 40..42`) plus a 3 mm tenon filling the full
  back-wall thickness (`y = 42..45`, flush with the outer rear face).
- Documented relaxation: the 2 mm rail section is below the declared
  `minimum_internal_edge_width` of 3.0 mm; this is user-approved for this
  feature and is asserted as `>= 2.0 mm` (the same documented-exception pattern
  as the fan's 0.63 mm ligament).
- Structural join: the tenon gives a continuous 57 mm x 2 mm x 3 mm
  positive-volume intersection with the back wall across the full seam —
  engagement depth 3.0 mm = `minimum_structural_overlap`, full-length (no
  discrete endpoints needed). The back wall remains solid at `y = 42..45`
  across the rail band, and no existing cut (left-wall windows stop at
  `x = 3`; fan cuts start near `x = 70`) reaches the rail's `x = 8..65` band
  at `z = 38..40`, so the overlap survives all downstream `difference()` ops.
- rev_0001/0002/0003 configs must keep rendering unchanged through
  `defaults.scad` `is_undef` fallbacks (`rail_enabled` default false).
- No numbered revision snapshots are published for this single-part design
  (no `parts.json`, no `revisions/micro_cyberdeck_case/`); publication is the
  governed `output/` build + config, per established rev_0002/rev_0003
  practice for this design.

- [x] 1. Mutable source: rev_0004 candidate rail geometry
  - [x] 1.1 `designs/micro_cyberdeck_case/src/lib/defaults.scad`: add rail
    params with `is_undef` fallbacks — `rail_enabled` (default `false`),
    `rail_x_inset` (5.0), `rail_section` (2.0), `rail_top_below_rim` (5.0).
    Tenon depth is derived from `wall_thickness` (through-wall), not a param.
  - [x] 1.2 `designs/micro_cyberdeck_case/src/parts/case_body.scad`: add
    derived functions — `rail_min_x() = wall_thickness + rail_x_inset`,
    `rail_max_x() = right_wall_inner_x() - rail_x_inset`,
    `rail_top_z() = case_outer_height() - rail_top_below_rim`,
    `rail_bottom_z() = rail_top_z() - rail_section`,
    `rail_front_y() = back_wall_y() - rail_section`.
  - [x] 1.3 `case_body.scad`: add `_back_rail()` module (cube at
    `x = rail_min_x()..rail_max_x()`, `y = rail_front_y()..back_wall_y() +
    wall_thickness` i.e. `y = 40..45`, `z = rail_bottom_z()..rail_top_z()`
    i.e. z 38..40) and union it into `_case_positive()` when
    `rail_enabled` is true.
  - [x] 1.4 `case_body.scad` `_assert_case_dimensions()`: add `if
    (rail_enabled)` block asserting — tenon engagement equals
    `wall_thickness >= minimum_structural_overlap`; `rail_section >= 2.0`
    (documented relaxation of the 3.0 mm minimum internal edge width);
    `case_outer_height() - rail_top_z() >= minimum_internal_edge_width`
    (rim band above rail); `rail_bottom_z() - rail_front_y() >= 0` and ledge
    clears the cavity (`rail_front_y() > wall_thickness`); span
    `rail_max_x() - rail_min_x() >= 2 * minimum_internal_edge_width`; when
    `divider_enabled`, `rail_bottom_z() > divider_top_z()` (no divider
    interference).

- [x] 2. Config
  - [x] 2.1 Create `designs/micro_cyberdeck_case/configs/rev_0004.json` from
    `rev_0003.json`: rename part to
    `micro_cyberdeck_case_body_rev_0004`, add `"rail_enabled": true` (other
    rail keys at defaults), everything else identical. `rev_0001..0003.json`
    untouched.

- [x] 3. Build, numeric, and probe verification
  - [x] 3.1 Build with
    `scripts/scad_build.py --design micro_cyberdeck_case --config
    designs/micro_cyberdeck_case/configs/rev_0004.json`: zero OpenSCAD
    warnings/errors, all asserts pass, flat install in
    `output/micro_cyberdeck_case/` (1 STL + 17 PNGs, no dirs or `.scad`).
  - [x] 3.2 Repo-external numeric probes (deleted after review) on the
    installed STL: bounds still `[0,0,0]..[76,45,45]`; sample points — solid
    at (36.5, 41, 39) ledge core, solid at (36.5, 44, 39) tenon core, void at
    (36.5, 39, 39) in front of the ledge, void at (36.5, 41, 37) below the
    ledge, void at (36.5, 41, 41) above the ledge, void at (7, 41, 39) and
    (66, 41, 39) beyond the rail ends.
  - [x] 3.3 Governed temporary section probes rendered into
    `output/micro_cyberdeck_case/` and deleted after review:
    a) horizontal section at `z = 39` showing the 57 mm ledge, 3 mm tenon
    flush with the rear face, and 5 mm side insets; b) vertical section at
    `x = 36.5` showing the L profile (2 mm ledge, 3 mm tenon, 5 mm below the
    rim); c) rear view confirming full-length tenon.
  - [x] 3.4 Revision isolation spot check: rebuild `rev_0003.json` and confirm
    the rev_0003 hash-verified 32,423.77 mm³ / 1,872-triangle STL is
    reproduced (older configs unaffected by the new params).

- [x] 4. Documentation integrity
  - [x] 4.1 `designs/micro_cyberdeck_case/README.md`: add a Revision 0004
    section (rail spec: `x = 8..65`, ledge `y = 40..42`, tenon `y = 42..45`,
    `z = 38..40`; through-wall tenon = full 3 mm `minimum_structural_overlap`;
    documented 2 mm section relaxation), a rev_0004 candidate verification
    record (R4 supersedes the R3 record as current candidate), and the
    SHA-256 provenance block (config, main.scad, defaults.scad,
    case_body.scad, installed STL).
  - [x] 4.2 Root `README.md`: extend the `designs/micro_cyberdeck_case/`
    entry with the back-wall rail (rev_0004).
  - [x] 4.3 `journal/2026-09-16.md`: agent work-log entries for the rail
    geometry, verification, and checkpoint (user-only fields untouched).

- [x] 5. Plan closeout and checkpoint
  - [x] 5.1 Mark completed items `[x]`, archive this plan to `plans/past/`
    when no execution remains, regenerate indexes, and verify with
    `python scripts/regenerate_plan_indexes.py --check --repo-root .` (exit 0).
  - [x] 5.2 Propose a task-scoped commit message; commit + push only on the
    user's explicit approval for this change (the rebuilt
    `output/micro_cyberdeck_case/` artifacts ride in the same commit under
    the standing artifact-commit directive).