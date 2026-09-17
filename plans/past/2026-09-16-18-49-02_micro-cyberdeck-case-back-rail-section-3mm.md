---
plan_id: 2026-09-16-18-49-02_micro-cyberdeck-case-back-rail-section-3mm
title: Grow micro_cyberdeck_case back-rail section to 3 x 3 mm (rev_0004 amend)
summary: Grow the uncommitted rev_0004 back-rail section from 2 x 2 mm to 3 x 3 mm (ledge y = 39..42, band z = 37..40, span x = 8..65 unchanged), replace the documented 2 mm relaxation with full 3.0 mm compliance, rebuild and re-verify, and amend the candidate in place.
status: past
created_at: 2026-09-16-18-49-02
---

# Grow micro_cyberdeck_case back-rail section to 3 x 3 mm (rev_0004 amend)

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

Geometry basis (user direction, 2026-09-16, amending the same uncommitted
rev_0004 candidate; envelope unchanged at 76 x 45 x 45 mm, open top / open
front):

- The rail section grows by 1 mm in both dimensions: one confirmed reading
  locked with the user — ledge depth `y` 2 mm -> 3 mm (ledge front face moves
  `y = 40` -> `y = 39`, extending 1 mm further out into the cavity) and
  height `z` 2 mm -> 3 mm (bottom drops `z = 38` -> `z = 37`; the top stays at
  `z = 40`, 5 mm below the rim).
- Rail band: `x = 8..65` (57 mm span, ends unchanged), `y = 39..45` (3 mm
  ledge `y = 39..42` in front of the back-wall internal face + 3 mm
  through-wall tenon `y = 42..45`, flush with the rear outer face),
  `z = 37..40`.
- The 3 mm section equals the declared `minimum_internal_edge_width` of
  3.0 mm: the documented 2 mm rail-section relaxation is retired (user
  decision) and the assert upgrades to full compliance
  (`rail_section >= minimum_internal_edge_width`).
- New material versus rev_0003 baseline: ledge only, 57 x 3 x 3 =
  +513.000000 mm³ (tenon already interior to the back wall); expected body
  volume 32,423.77 + 513 = 32,936.77 mm³. Envelope unchanged:
  `[0, 0, 0]` to `[76, 45, 45]`.
- No cut intersects the widened rail band: left-wall windows/exit stop at
  `x = 3`; divider top is `z = 18` (19 mm below the rail bottom); fan bore
  and seats are in the right wall `x = 70..76`.
- rev_0001/0002/0003 configs keep rendering unchanged through
  `defaults.scad` `is_undef` fallbacks (`rail_enabled` false; rail
  parameters unused when the rail is disabled).
- No numbered revision snapshots (single-part design, no `parts.json`);
  publication is the governed `output/` build + config, per the established
  rev_0002/rev_0003 practice for this design.

- [ ] 1. Mutable source + config: rail section 2 mm -> 3 mm
  - [x] 1.1 `designs/micro_cyberdeck_case/src/lib/defaults.scad`: change the
    `rail_section` `is_undef` default from 2.0 to 3.0 and update the
    back-rail comment block (3 mm (y) x 3 mm (z) section; no relaxation).
  - [x] 1.2 `designs/micro_cyberdeck_case/src/parts/case_body.scad`: update
    the back-rail placement comment (ledge 3 mm deep, `y = 39..42`; tenon
    unchanged through-wall). Derived functions stay as-is — `rail_front_y()`
    and `rail_bottom_z()` already track `rail_section`.
  - [x] 1.3 `case_body.scad` `_assert_case_dimensions()` rail block: replace
    the documented 2 mm relaxation (its comment plus
    `assert(rail_section >= 2.0, "Rail section is below the documented 2 mm
    floor.")`) with the full-compliance assert
    `assert(rail_section >= minimum_internal_edge_width, "Rail section is
    below the minimum internal edge width.")`. All other rail asserts are
    unchanged and re-checked against the new geometry.
  - [x] 1.4 `designs/micro_cyberdeck_case/configs/rev_0004.json`: add
    `"rail_section": 3.0` so the config is explicit and authoritative about
    the rail section (other rail keys remain at their defaults).
- [ ] 2. Build and verification
  - [x] 2.1 Rebuild the candidate with
    `python scripts/scad_build.py --design micro_cyberdeck_case --config
    designs/micro_cyberdeck_case/configs/rev_0004.json` into a flat
    `output/micro_cyberdeck_case/`: 1/1 STL + 17/17 PNG, zero OpenSCAD
    warnings or errors, all assertions pass.
  - [x] 2.2 Numeric STL verification (temporary probe script, deleted after):
    bounds `[0, 0, 0]` to `[76, 45, 45]`; signed volume 32,936.77 mm³
    (exact +513.000000 mm³ vs rev_0003 32,423.77 mm³); 3D parity check with
    adjusted positions — ledge core solid, tenon core solid, points in front
    of / below / above the ledge and beyond both rail ends void.
  - [x] 2.3 Governed temporary section probes (gated behind `-D sect=N`,
    rendered, viewed, removed with the probe file): (a) horizontal section at
    `z = 38.5` — 57 x 3 mm ledge bar at `x = 8..65`, `y = 39..42`; (b)
    constant-x section at `x = 36.5` — clean L profile, 3 mm ledge continuous
    into the 3 mm back wall, no seam gap; (c) rear ortho — tenon flush with
    `y = 45`.
  - [x] 2.4 Fresh rev_0003 isolation rebuild (current source tree) +
    full-mesh facet-multiset delta audit: the R3 rebuild must be
    geometry-identical to the committed R3 STL (same 1,872-triangle surface,
    same bounds, 32,423.77 mm³), and every facet delta between the R3 rebuild
    and the new R4 build must lie in the rail band — new ledge faces plus
    re-triangulation of the unchanged `y = 42` back-wall face only.
  - [x] 2.5 Remove all temporary probe/delta scripts and the superseded
    2 x 2 mm R4 artifacts' staging remnants (none expected in flat output);
    verify `output/micro_cyberdeck_case/` is flat: 18 files, no directories,
    no `.scad`.
- [ ] 3. Documentation (same task)
  - [x] 3.1 `designs/micro_cyberdeck_case/README.md`: amend the "Revision
    0004 dimensions, back-wall rail" section and the R4 verification record
    in place (never published): 3 x 3 mm section, band `z = 37..40`,
    +513.000000 mm³, measured volume/triangle counts, the retired-relaxation
    wording replaced by full-compliance wording, full-mesh audit result, and
    a refreshed SHA-256 provenance block (config, main.scad, defaults.scad,
    case_body.scad, installed STL).
  - [x] 3.2 Root `README.md` project entry: rail clause 2 mm x 2 mm ->
    3 mm x 3 mm, ledge `y = 39..42` at `z = 37..40`.
  - [x] 3.3 `journal/2026-09-16.md`: append Repo Work Log entries for the
    user decision (both dimensions +1 mm, in-place amend), source/config
    change, rebuild + verification, and documentation updates; user-only
    fields stay `-`.
- [ ] 4. Closeout
  - [x] 4.1 Move this plan to `plans/past/`, regenerate plan indexes
    (`python scripts/regenerate_plan_indexes.py --repo-root .`), verify
    `--check` exits 0.
  - [x] 4.2 Present the task-scoped commit message and the exact staged file
    set (including the 18 output artifacts per the 2026-09-14 artifact
    directive); commit and push only after explicit user approval of the
    exact message. The earlier 2 x 2 mm candidate's still-pending commit
    proposal is superseded by this amended one (nothing was committed).

## Authoring Rules

- Use `YYYY-MM-DD-HH-mm-ss_slug.md` with a lowercase, hyphenated slug.
- Make `plan_id` match the filename stem exactly.
- Use only the required front matter keys shown above.
- Decompose work until each leaf item has one clear completion condition.
- Use `[-]` only for intentionally closed or de-scoped work.
- Keep file location aligned to `future`, `current`, or `past` status.