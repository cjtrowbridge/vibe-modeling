---
plan_id: 2026-09-14-17-04-06_micro-cyberdeck-case-real-recesses-38mm-fan-45mm-depth
title: Fix Fan Head Recesses, Widen Air Bore to 38 mm, Deepen Case to 45 mm
summary: In-place R2 amendment of the unpublished rev_0003 candidate: cut real M3-capable head recesses (currently inert due to a wrong rotation), correct the front-row hole breach by recentering the fan to the wall midpoint, widen the air bore to 38 mm, and deepen the case to 73 x 45 x 45 mm so every user-mandated 3 mm ring holds, with the single bore-to-station ligament kept as a user-approved documented exception. R3 Amendment (2026-09-14, user-approved): the right wall is deepened to a 6 mm slab; the head seats become blind half-depth bores; the M3 + O38 bores pass through the full wall; envelope 76 x 45 x 45 mm.
status: past
created_at: 2026-09-14-17-04-06
---

# Fix Fan Head Recesses, Widen Air Bore to 38 mm, Deepen Case to 45 mm

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Locked scope and assumptions (user-confirmed 2026-09-14)

- In-place amendment of the UNPUBLISHED mutable `rev_0003` candidate (`configs/rev_0003.json`,
  `src/lib/defaults.scad`, `src/parts/case_body.scad`). `rev_0001`/`rev_0002` untouched.
  No commit or push in this plan (separate approval required; a message will only be proposed).
- User defect report (both verified against source and the installed STL):
  - D1: `_fan_screw_recess_cut()` rotates its cylinders toward -x (into the cavity, x 67..70),
    so the difference removed nothing - no head recesses exist in the artifact; and a full M3
    head (O5.5) cannot seat against a 3 mm wall anyway.
  - D2: front screw stations sit at y=2, so the O4.2 holes extend to y=-0.1 and break the open
    front edge - no 3 mm wall all the way around the screw holes.
- User decisions driving this revision (verbatim intent):
  - "make the wall thicker" for M3-capable (O6 x 3) head recesses at all four stations;
  - "Deepen the right wall" for the back recess clearance;
  - "the opening for the fan needs to be 38mm, not 28mm";
  - "its fine for the recesses to overlap with the bore, as long as there is still a 3mm
    thick wall behind the recesses";
  - fan mounting pattern confirmed at 32 mm spacing; holes 4.2 mm.
- Locked geometry (73 x 45 x 45 mm envelope; datum front-left-bottom = [0,0,0]):
  - `interior_depth` 37 -> 39.0: `case_outer_depth()` = 45, right wall x=70..73 spans y=0..45,
    back wall y=42..45 (inner face y=42). Interior region x=3..70, y=3..42, z=3..45.
  - Fan centered at (y=22.5, z=22.5) - the exact wall midpoint in both axes (y asserted
    `fan_center_y == case_outer_depth()/2`; z already asserted).
  - Screw stations at (y,z) in {6.5, 38.5} x {6.5, 38.5} (offset 16 on both axes,
    32 mm spacing).
  - Air bore O38 (`fan_air_opening_d` 28 -> 38), through the right wall x=70..73 (R3:
    through the full 6 mm wall x=70..76), spanning y=3.5..41.5, z=3.5..41.5.
  - Head recesses O6 x 3 (`fan_screw_recess_d`/`depth` unchanged at 6.0/3.0), cut INTO the
    wall from the internal face x=70 toward +x. Because recess depth (3) equals wall
    thickness (3), each station is an O6 through-bore: the screw head seats flush with the
    internal face (x=70) and the shank exits the outer face (x=73) to clamp the fan.
    (Superseded in R3: see the R3 amendment below - the wall becomes 6 mm thick and the
    seats become blind half-depth bores.)
  - Perimeter walls (all >= 3.0, asserted; R2 values, unchanged in y/z by R3):
    - O4.2 hole rings to the open perimeter: front 4.4 (edge y=4.4 vs y=0), back 4.4
      (edge y=40.6 vs outer back face y=45), bottom 4.4, top 4.4 (hole edge z=4.4 from
      outer bottom face z=0 and rim z=45).
    - O6 seat walls ("3 mm wall behind the recesses"): front 3.5 (seat edge y=3.5 vs
      y=0), back 3.5 (seat edge y=41.5 vs outer face y=45, i.e. 0.5 solid + 3.0 back wall),
      bottom 3.5, top 3.5. The rear seats do NOT reach the back wall inner face (y=42);
      0.5 mm of right-wall material separates them from it, with the full 3 mm back wall
      beyond - a continuous 3.5 mm wall, not a notch.
    - O38 bore to each outer edge: front 3.5, back 3.5, bottom 3.5, top 3.5.
  - Documented exception (single, user-approved 2026-09-14): the four diagonal ligaments
    between the O38 bore face and the O6 recess faces are `16*sqrt(2) - 19 - 3 = 0.63 mm`
    (and to the O4.2 hole faces `16*sqrt(2) - 19 - 2.1 = 1.53 mm`), both below the 3 mm
    `minimum_internal_edge_width`. The user explicitly accepts recess-to-bore overlap, so
    the two diagonal asserts are retargeted from >= 3.0 to >= 0.6 with a comment citing this
    decision. Every perimeter ring still holds >= 3 ms.
  - Consequence on the shared air channel: at the divider top (z=18) the O38 bore chord in
    the right wall extends `sqrt(19^2 - (22.5-18)^2) = 18.46 mm` in y from center, so the
    divider's right end is left with a front leg of `22.5 - 18.46 - 3 = 1.04 mm` (non-structural
    sliver, documented relaxation, assert retargeted from >= 1.5 to >= 1.0) and a back leg of
    `45 - 22.5 - 18.46 = 4.04 mm` (asserted >= 3.0). The divider's primary supports (left-wall
    and back-wall engagement, each 3.0 mm) are unchanged by the bore.
  - Left wall (x=0..3) and all its features (dual windows + flush lips, micro-SD, battery
    exit) are UNCHANGED in size; they remain 21.5 mm from the back outer edge, i.e. their
    centres shift +2 mm in y (to y=23.5) purely because the case is 2 mm deeper. All
    left-wall asserts (window margins, lip tightening, floor ligament, divider alignment)
    re-verify without change.
  - Divider stays z=15..18, now full depth y=3..45; bore spans it (3.5 < 15 and 41.5 > 18,
    asserted as the shared-channel requirement).
  - `Volumes: 2` in the installed STL is a known, user-accepted OpenSCAD quirk; never chased.
- Expected mutable output: one rev_0003 STL and 17 PNGs in `output/micro_cyberdeck_case/`
  (flat), replacing the current set. No `output/` or `revisions/` files committed.

## Approved strategy (user, 2026-09-14)

- R2 plan is the formal approval vehicle; all geometry above is user-confirmed per the
  recorded decisions. If execution reveals a number that violates a user-mandated perimeter
  ring, STOP and return a plan revision - do not silently move the fan or widen a hole.

## R3 amendment (user-approved 2026-09-14, after R2 verification)

- User decision (verbatim): "the wall just needs to be 6mm thick, with the head clearance
  bores only going halfway through, and the m3 and fan bores going all the way through."
  Approved together with "ok commit everything first and then go ahead".
- Locked R3 geometry (in-place on the same unpublished rev_0003 candidate):
  - The right wall is one 6 mm slab (x = 70..76) via new key `fan_wall_thickness` = 6.0
    in `rev_0003.json`; the left/back walls and floor stay `wall_thickness` = 3.0. The
    `defaults.scad` fallback is
    `is_undef(fan_wall_thickness) ? wall_thickness : fan_wall_thickness`, so
    rev_0001/rev_0002 configs keep their existing 3 mm right wall and envelopes.
  - Envelope: 76 x 45 x 45 mm (x 0..76); y and z dimensions unchanged. All y/z fan
    features, stations, margins, left-wall windows, divider, and the documented R2
    exceptions (0.63 mm bore-to-seat diagonal ligament, 1.04 mm divider front-right
    sliver) are UNCHANGED.
  - Head seats: O6 x 3 BLIND bores from the internal face x=70 (spanning x 70..73, the
    same footprint as the R2 through-bore), leaving 3 mm of solid behind each seat floor
    (x 73..76) - the "3 mm wall behind the recesses" rule now holds within the wall.
  - The M3 mount holes (O4.2) and the O38 air bore pass through the full 6 mm (x 70..76).
  - Screw seating sequence: head flush at the internal face x=70; O4.2 shank through
    x 73..76; screw exits the outer face x=76 to clamp the fan.
  - Structural join: the right wall now overlaps the floor and the back wall over a
    6 mm deep region (still >= 3 mm minimum structural overlap); no other seam changes.
  - Expected volume: ~32,421 mm3 (R2 29,914.68 + 6,075 mm3 slab - 3,402.3 mm3 longer
    air bore - 166.2 mm3 of longer M3 bores); record the exact actual value.

## Checklist

- [x] 1. Source: `designs/micro_cyberdeck_case/src/parts/case_body.scad`
  - [x] 1.1 Fix `_fan_screw_recess_cut()`: face the cylinders INTO the wall - start at
    `translate([case_outer_width() - wall_thickness - boolean_epsilon, ...])` with
    `rotate([0, 90, 0])`, `h = fan_screw_recess_depth + 2 * boolean_epsilon` (mirrors
    `_fan_air_cut`/`_fan_mount_cut`); update the comment (O6 through-bore semantics because
    recess depth == wall thickness).
  - [x] 1.2 Replace the front recess cosmetic assert (`>= -wall_thickness`) with
    `fan_center_y - fan_screw_offset() - fan_screw_recess_d / 2 >= minimum_internal_edge_width`
    (3.5 >= 3).
  - [x] 1.3 Replace the front hole cosmetic assert (`>= -0.5`) with
    `fan_center_y - fan_screw_offset() - fan_mount_hole_d / 2 >= minimum_internal_edge_width`
    (4.4 >= 3).
  - [x] 1.4 Retarget the back recess bound from `<= back_wall_y() - minimum_internal_edge_width`
    to `<= case_outer_depth() - minimum_internal_edge_width` (41.5 <= 42), and add the
    matching outer-face ring; do NOT assert against the back wall inner face (that gap is the
    documented 0.5 mm solid, not a margin).
  - [x] 1.5 Keep the bottom/top recess assert (3.5 >= 3) and the bore front/back/bottom/top
    margin asserts (3.5 >= 3) and the `fan_screw_clearance_margin` assert (4.4 >= 3).
  - [x] 1.6 Retarget the two diagonal ligament asserts to the documented 0.6 floor with a
    comment quoting the user decision: `sqrt(2)*offset - air_r - recess_r >= 0.6` (0.63) and
    `fan_corner_land() >= 0.6` (1.53).
  - [x] 1.7 Retarget `divider_right_front_leg` assert `>= 1.5` to `>= 1.0` (documented
    non-structural sliver; divider supported by left + back walls); keep the back leg
    `>= minimum_internal_edge_width` (4.04 >= 3).
  - [x] 1.8 Add `assert(fan_center_y == case_outer_depth() / 2, "...")` to enforce the
    centered depth placement (replaces the ad-hoc y=18 shift rationale).
- [x] 2. Config: `designs/micro_cyberdeck_case/configs/rev_0003.json`
  - [x] 2.1 `interior_depth` 37.0 -> 39.0.
  - [x] 2.2 `fan_air_opening_d` 28.0 -> 38.0.
  - [x] 2.3 `fan_center_y` 18.0 -> 22.5.
  - [x] 2.4 Leave all other keys unchanged (holes 4.2, spacing 32, recess 6.0/3.0, windows,
    exits, divider, lips, minimums).
- [x] 3. Defaults: `designs/micro_cyberdeck_case/src/lib/defaults.scad`
  - [x] 3.1 Fallbacks: `interior_depth` 37.0 -> 39.0, `fan_air_opening_d` 28.0 -> 38.0,
    `fan_center_y` 18.0 -> 22.5 (match config).
- [x] 4. Build and verify
  - [x] 4.1 From repo root: `python scripts/scad_build.py --design micro_cyberdeck_case
    --config designs/micro_cyberdeck_case/configs/rev_0003.json` - zero warnings; record the
    73 x 45 x 45 envelope from the render log.
  - [x] 4.2 Numeric STL pass: bounds, exact volume and triangle count (record exact values;
    expect a shift from the current 30,298.36 mm3 / 1,428 tris due to the deeper shell and
    the newly real O38 bore + four O6 bores); confirm the installed `output/` set is flat
    with 1 STL + 17 PNGs, names unchanged. (Recorded actual: 73 x 45 x 45, 29,914.68 mm3 /
    1,296 tris; Volumes: 2.)
  - [x] 4.3 Point-prober on the installed STL (temp script, repo-external, deleted after):
    at each of the 4 stations the hole centre is VOID and r=2.5 points (inside O6, outside
    O4.2) are now VOID across the wall (recess present); r=5 points SOLID; mid-bore VOID;
    solid-wall controls SOLID. (Executed repo-external with 3D point-in-solid parity + 2D
    constant-x planar slices; no probe files ever placed under `output/`.)
  - [x] 4.4 Governed section probes under `output/micro_cyberdeck_case/` (deleted after):
    right-wall slab through the fan (four O6 bores + O38 bore visible), divider plane
    z=16.5 (chord + legs visible), internal-face check (heads seat flush at x=70).
    (Executed as repo-external 2D slices of the installed STL instead; `output/` stayed
    flat.)
- [x] 5. Documentation
  - [x] 5.1 `designs/micro_cyberdeck_case/README.md`: revise the rev_0003 spec and
    verification record (73x45x45 envelope, fan at (22.5, 22.5), O38 bore, 32 mm pattern,
    four O6 through-bore stations, the perimeter margin table, the single documented 0.63 mm
    diagonal ligament exception, the 1.04 mm divider sliver note); correct the now-known-
    false "recesses verified" line; refresh the STL hash/size/volume provenance block.
  - [x] 5.2 Root `README.md` design bullet: update the envelope/feature sentence if it lists
    the old 73 x 43 x 45 or O28 bore.
- [x] 6. Journal
  - [x] 6.1 `journal/2026-09-14.md`: append work-log entries (append-only - supersede, never
    edit, the earlier "recesses verified" line); set plan checkpoint linkage to this plan;
    keep `Today's Intentions` / `Notes / Reflections` as user-only `-`.
- [x] 7. Governance closeout
  - [x] 7.1 Mark completed `[x]`, uncertain `[?]`; archive the plan to `plans/past/` with
    `status: past` once no execution remains.
  - [x] 7.2 `python scripts/regenerate_plan_indexes.py --repo-root .` then
    `python scripts/regenerate_plan_indexes.py --check --repo-root .` (exit 0).
  - [x] 7.3 Final summary with the required completion fields + propose (do NOT run) a
    task-scoped commit message covering the still-uncommitted R1+R2 working tree.
  - [x] 7.4 Commit the R1+R2 working tree (user-approved 2026-09-14: "commit everything
    first") with a task-scoped imperative message; do not push.
    (Done: commit 326207d, not pushed.)
- [x] 8. R3 source: `designs/micro_cyberdeck_case/src/parts/case_body.scad`
  - [x] 8.1 Add `right_wall_inner_x()` (= `wall_thickness + interior_width`); re-express
    `case_outer_width() = right_wall_inner_x() + fan_wall_thickness`; `_right_wall()`
    becomes the 6 mm slab at x=70. Floor, back wall, and divider inherit the new width
    automatically.
  - [x] 8.2 Re-anchor the `_fan_air_cut` / `_fan_mount_cut` / `_fan_screw_recess_cut`
    starts from `case_outer_width() - wall_thickness` (which would be the outer face
    x=76) to `right_wall_inner_x() - boolean_epsilon`; air + mount get
    `h = fan_wall_thickness + 2 * boolean_epsilon` (full through); the seat cut keeps
    `h = fan_screw_recess_depth + 2 * boolean_epsilon` (blind, half depth).
  - [x] 8.3 New asserts: `fan_wall_thickness >= minimum_wall_thickness`; blind seat
    (`fan_screw_recess_depth < fan_wall_thickness`); wall behind seat floor
    (`fan_wall_thickness - fan_screw_recess_depth >= minimum_internal_edge_width`); refresh
    the seat-ring comment to the true 4.4/3.5 margins (perimeter rings are measured on the
    internal face; outer face x=76 gets the 4.4 mm M3 rings and 3.5 mm bore rings); update
    the `_fan_screw_recess_cut` comment to blind-seat semantics.
- [x] 9. R3 config + defaults
  - [x] 9.1 `configs/rev_0003.json`: add `fan_wall_thickness` 6.0; leave every other key
    unchanged.
  - [x] 9.2 `defaults.scad`: add the matching `fan_wall_thickness` fallback (no other
    changes).
- [x] 10. R3 build + verify
  - [x] 10.1 Rebuild `rev_0003.json` (zero warnings); bounds exactly x 0..76 (76 x 45 x
    45); record volume (expect ~32,421 mm3) + triangle count; flat `output/` set = 1 STL
    + 17 PNGs, no directories or `.scad`. (Recorded actual: zero warnings, bounds
    [0,0,0]..[76,45,45], 32,423.77 mm3 / 1,872 tris; Volumes: 2 quirk as before; flat 18
    files, 0 directories.)
  - [x] 10.2 Repo-external point probe (deleted after): at each of the 4 stations,
    (Executed: 45/45 PASS incl. seat ring, floor boundary 72.99/73.01, M3 through,
    bore azimuths, corner land, controls; temp tool deleted after.)
    r=2.5 at x=71.5 is VOID (seat ring), r=1.5 at x=74.5 is VOID (M3 through), r=2.5 at
    x=74.5 is SOLID (seat floor; r > 2.1 M3 radius), r=12 at x=74.5 is VOID (air bore
    through), r=21 at x=74.5 is SOLID.
  - [x] 10.3 Repo-external 2D slice (deleted after): the x=71.5 slice shows the seat ring
    (Executed: both slices matched the decisive expectations; temp tool deleted after.)
    VOID; the x=74.5 slice shows the seat ring SOLID with the M3 VOID - proof of the
    half-depth seats.
- [x] 11. R3 documentation
  - [x] 11.1 Design README rev_0003 section: 76 x 45 x 45 envelope, 6 mm right wall,
    blind O6 x 3 head seats (3 mm solid behind the seat floor), through M3 + O38 bores,
    updated margin table, supersession note, fresh verification record + provenance
    block (new STL hash).
  - [x] 11.2 Root `README.md` design bullet: 76 x 45 x 45, 6 mm right wall, blind head
    seats, through M3 + O38.
- [x] 12. R3 journal + closeout
  - [x] 12.1 `journal/2026-09-14.md`: append the R3 work logs (append-only); user-only
    fields stay `-`.
  - [x] 12.2 Mark items 8-11 `[x]`; archive the plan to `plans/past/` with
    `status: past`; regenerate + check indexes (exit 0).
  - [x] 12.3 Final summary with the section 12 completion fields + propose (do NOT run)
    the commit message for the R3 working tree.