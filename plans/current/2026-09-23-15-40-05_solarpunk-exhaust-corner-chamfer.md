---
plan_id: 2026-09-23-15-40-05_solarpunk-exhaust-corner-chamfer
title: solarpunk_exhaust V6: top-left corner chamfer + front-face magnet recesses
summary: Cut a 45-degree full-through corner chamfer (20 mm legs) off the plate's top-left corner for the bracket's corner margin, and flip the 8 magnet recesses from the back face to the front face (user: "the recesses are on the wrong side. they should be on the front, not the back."). One build, one audit, one review re-run, one commit.
status: current
created_at: 2026-09-23-15-40-05
---

# solarpunk_exhaust V6 — Top-Left Corner Chamfer + Front-Face Magnet Recesses

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Summary

Cut a **45-degree full-through chamfer (20 mm legs on the left and top
slotted edges)** out of the plate's top-left corner, clearing the bracket's
corner margin where the two intake pipes come together into the fitting.
**V6 addendum (user 2026-09-23):** flip the eight magnet recesses from the
back face to the **front face** — user: "the recesses are on the wrong side.
they should be the front, not the back." Same single mutable rev_0001
blockout iteration, one build, one audit, one review re-run, one commit.
Immutable revisions still not published; the published revision stays
unbuilt until the blockout is signed off.

## Approved context

- Part `solarpunk_exhaust_rev_0001` is the mutable blockout scaffold
  (V4 fan geometry + V5 velcro bands and 8 back-face magnet pockets,
  submitted 2026-09-23 as commit `815d757`).
- User request (2026-09-23): "lets also cut a slice out of the top left
  corner for the bracket's margn where the two pipes come together into the
  fitting"; resolved via structured questions — **45-degree chamfer, 20 mm
  legs, full through-cut, hygiene files folded into the V6 commit**.
- User request (2026-09-23, V6 addendum): "the recesses are on the wrong
  side. they should be on the front, not the back." — the V5 magnet pockets
  open on the front (fan/collar) face instead of the back (velcro) face.
  The V5 retention-only rationale ("magnets against the ventilation
  screen") is superseded by the user-directed flip; no new functional story
  is invented in the docs — provenance recorded as user-directed
  (2026-09-23), with the mechanical consequence (magnets seat flush on the
  front face, under the fan frame) documented as fact.
- Standing flag from the plan window: `magnet_offset` 11.0 -> 11.5 mm
  refinement (V5 addendum) is ratified by the user's continued iteration.
  Unrelated pre-existing staleness (flag-only, NOT fixed here):
  `docs/solarpunk_series.md` section 3 `solarpunk_intelligence_hub` row
  says rev_0002/2026-09-20 while section 6 says rev_0003/2026-09-22.
- Post-commit checkpoint hygiene from the V5 commit (`815d757`),
  uncommitted in the worktree, is **folded into this one commit** (user
  2026-09-23): journal checkpoint entry + Plan link update; archived plan
  closure (4.1 [x], 4.2 [x], 4.3 [-]) and `git mv` to `plans/past/`;
  index regeneration.
- Post-commit artifact audit of the 40-file installed set passed (2 STL /
  36 PNG / 2 manifests; all STL and review-manifest hashes re-verified).
- No hardware or material change.

## Chamfer geometry and derived values (recomputed from the committed blockout)

Plate 134 x 141, 3 mm. Top-left corner = minimum-X, maximum-Y corner
(adjacent to the two slotted edges: left band velcro at X 3..8, top band at
Y 133..138). Locked blockout values (all from `defaults.scad`):
`fan_cx=71, fan_cy=70, fan_size=120, fan_opening_d=116, station_offset=52.5,
standoff_od=10.3, fan_bore_d=4.3, magnet_pocket_d=6.1, magnet_offset=11.5,
velcro_slot_w=20, velcro_slot_h=5, edge_margin=3, plate_t=3,
minimum_wall_thickness=3`. Fan box X 11..131, Y 10..130.

Cut: the corner triangle where `x >= 0, y <= plate_h, x + (plate_h - y)
<= leg` with `leg = 20`. Chamfer face line `y = x + 121`, endpoints
(0, 121) -> (20, 141). Distance from a point PT to the face:
`d = (x + (plate_h - y) - leg) / sqrt(2)`.

| Feature | Locked value | Clearance to face | Result |
| --- | --- | --- | --- |
| Left-band top window corner (3, 115.75) | window X 3..8, Y 25.25..45.25 & 95.75..115.75 | 6.05 (corner to chamfer vertex (0, 121); re-derived at execution: the earlier 5.83 was face-line only) | >= 3 PASS |
| Top-band left window corners | window Y 133..138, X 23.5..43.5 & 90.5..110.5 | 4.61 (corner (23.5, 138) to chamfer vertex (20, 141); re-derived at execution — the (23.5, 133) corner is 8.13) | >= 3 PASS |
| Top-left magnet pocket (30, 122.5) r 3.05 | flipped to the front face with V6 addendum; planar values unchanged | 17.10 | >= 3 PASS |
| Top-left station bore (18.5, 122.5) r 2.15 | through-bore | 9.87 | >= 3 PASS |
| Top-left collar OD r 5.15 (center 18.5, 122.5) | z plate_t..plate_t+standoff_h | 6.87 | >= 3 PASS |
| Airflow opening (center 71,70, r 58, 45-degree radial to the corner) | opening edge | 28.27 | >= 3 PASS |
| Fan box top-left corner (11, 130) | reference part, not plate material | 1.41 | NEW documented sub-minimum |
| Chamfer face -> left plate edge | face start (0, 121): window top 115.75 | 5.25 solid | >= 3 PASS |
| Chamfer face -> top plate edge | face end (20, 141): window start 23.5 | 3.50 solid | >= 3 PASS |

Hard ceiling: the chamfer face reaches the fan box top-left corner (11,
130) at `leg = 11 + 130 - 121 = 22`, so leg = 20 leaves a 1.41 mm
margin to the fan box corner. The 1.41 mm is declared as a **documented
user-accepted sub-minimum** in the same class as the existing 2.0 mm
opening-to-fan-box plateau: it bounds plate material to the reference part,
not plate material to plate voids. **No asserted minimum below
`minimum_wall_thickness` is introduced.**

## V6 addendum — magnet recess face flip (front face)

The 8 pockets keep identity, centers (8 locked points), Ø6.1, depth 2.0, and
every planar clearance. The only change is the Z interval:

- **Before (V5):** recess open on the **back** face — cut z `0..2.0`,
  closed bottom at z = 2.0, 1.0 mm membrane z 2.0..3.0 on the front side.
- **After (V6):** recess open on the **front** face — cut z `1.0..3.0`
  (i.e. `plate_t - magnet_recess_depth` .. `plate_t`), closed bottom at
  z = 1.0, 1.0 mm membrane now at z `0..1.0` (back side, between cavity
  and velcro face). Back face is **solid 3 mm** under each pocket, so the
  velcro bands carry all screen retention.
- The documented 1.0 mm membrane sub-minimum magnitude is **unchanged**;
  face wording flips back-side <-> front-side in every doc and in the
  part's assert messages.
- **Mechanical consequence (documented as fact):** every pocket opening now
  sits ENTIRELY under the 120x120 fan footprint. Tightest edge margin:
  top-left opening (26.95..33.05, 119.45..125.55) -> fan box left edge X=11
  and top edge Y=130: margins 15.95 / 4.45 mm (>= 3.0, new assert); the
  top-right opening is symmetric. All other openings are farther in. With
  the fan mounted, the 8 x Ø6 x 2 magnets seat **flush with the front face,
  under the fan frame** — they clamp the fan frame to the plate; the M4
  screws at the corners carry the corner loads (per the existing fastener
  note). The old V5 rationale ("holding the magnets against the
  ventilation screen") is marked superseded by the user-directed flip;
  provenance recorded as user-directed (2026-09-23) — **no fabricated
  functional story**.
- No parameter or key changes (`magnet_pocket_d`, `magnet_recess_depth`,
  `magnet_offset` unchanged), no `fan_proxy.scad` geometry change (the
  pockets are outside the proxy box; the new assert lives in the plate
  part), no `assembly.json` change.
- Planar asserts (bore 6.30 / collar OD 3.30 / opening 5.56 / edges 7.45 /
  windows 7.45 / same-side 75.9 / corner 10.16) are UNCHANGED. Z-interval
  asserts flip: recess stays closed at `plate_t - magnet_recess_depth = 1.0`
  (sub-minimum, existing assert form retained with face wording flipped);
  NEW: each pocket opening's planar footprint lies inside the fan box with
  edge margin >= `minimum_wall_thickness` (tightest 4.45). With the
  collars on the front face too, the cut still uses
  `plate_t + standoff_h + 2*eps` so any collar/pocket intersection is
  honest (there is none: collar->pocket face clearance 3.30).

## Source edits (exact targets)

1. `designs/solarpunk_exhaust/src/lib/defaults.scad`:
   - Add `corner_chamfer_leg = 20.0;` (is_undef pattern) with provenance
     comment (user 2026-09-23; cuts the top-left corner where the bracket's
     corner margin meets; 45-degree, leg = 20; ceiling 22 at the fan box).
   - Add `function corner_cut_d() = corner_chamfer_leg;`.
2. `designs/solarpunk_exhaust/src/parts/solarpunk_exhaust.scad`:
   - Header docs: add V6 (chamfer) + V6 addendum (front-face recesses)
     bullets; flip the V5 "back face / membrane on the front side" wording
     to the front-face state (V5 recorded as superseded).
   - Assert block (before geometry):
     - chamfer endpoint well-formedness: each face endpoint clears the
       nearest feature of its slotted edge by >=
       `minimum_wall_thickness` (derived values above: 5.25 left / 3.50
       top; these are the only slotted-edge features inside the corners):

       `plate_h() - corner_cut_d() >= velcro_slot_y_left(velcro_n - 1) + velcro_slot_w/2 + minimum_wall_thickness`
       (121 >= 118.75 PASS);
       `corner_cut_d() <= velcro_slot_x_top(0) - velcro_slot_w/2 - minimum_wall_thickness`
       (20 <= 20.5 PASS);
     - chamfer face to fan box corner (declared sub-minimum, NOT mwt):
       `(2 * band_margin() - corner_cut_d()) / sqrt(2) >= 1.0 - boolean_epsilon`
       (1.414 >= 1.0 PASS): the fan-box top-left corner is
       `(fan_cx() - fan_size/2, fan_cy() + fan_size/2) = (11, 130)`, and
       at the locked blockout its coordinates satisfy
       `x + (plate_h - y) = 2 * band_margin()` (both margins are 11), so
       its distance to the face line `x + (plate_h - y) = corner_cut_d()`
       is exactly `(2*band_margin() - corner_cut_d()) / sqrt(2)`;
     - chamfer face to each of the 8 pocket openings (17.10 min) and each
       of the 4 bores/collars (9.87 min face, collar radial 6.87) — reuse
       the `magnet_pocket_centers()` and station loops; and to the opening
       (28.27, radial at 45 degrees);
     - V6 addendum: pocket recess closed on the back face / open on the
       front: `magnet_recess_depth < plate_t` (existing) + face wording
       flip; membrane `plate_t - magnet_recess_depth >= 1.0 - eps`
       (existing, wording: membrane is now the back z 0..1);
     - V6 addendum NEW: each pocket opening footprint inside the fan box:
       loop over `magnet_pocket_centers()`,
       `min(_px - (fan_cx() - fan_size/2), (fan_cx() + fan_size/2) - _px,
       _py - (fan_cy() - fan_size/2), (fan_cy() + fan_size/2) - _py)
       - magnet_pocket_d/2 >= minimum_wall_thickness` (min 4.45 PASS);
   - Geometry:
     - cut the chamfer triangle from the plate, full through-cut, with a
       Z-bias of `boolean_epsilon` to keep the boolean clean:
       `polygon` at `translate([0, plate_h() - corner_cut_d(), -eps])`
       with points `(0,0)`, `(leg,0)`, `(0,leg)` in local XY, extruded
       `plate_t + 2*eps` (i.e. a vertical prism at the corner), subtracted
       in the top-level `difference()`;
     - flip the 8 pocket cylinders:
       `translate([..., ..., plate_t() - magnet_recess_depth - eps])`
       with `h = magnet_recess_depth + 2*eps` (open on front face,
       closed bottom at z = 1.0); keep d = `magnet_pocket_d`, $fn = 32.
3. `designs/solarpunk_exhaust/configs/rev_0001.json`:
   - Add `"corner_chamfer_leg": 20.0`.
   - Update the `status` string: append the V6 + V6 addendum summary
     (corner chamfer / 20 mm / 45-degree / top-left; magnet recesses on the
     front face, 1.0 mm back membrane) and adjust the V5 phrasing
     ("8 back-face magnet pockets" -> "8 front-face magnet recesses
     (V5, front-face in V6)").

No changes to `fan_proxy.scad` (geometry), `parts.json`, or
`assembly.json` (transform/identity all hold).

## Provenance

- User 2026-09-23 (chamfer request + structured answers: 45-degree chamfer
  / 20 mm legs / full through / hygiene folded in); user 2026-09-23
  (recess face flip: "the recesses are on the wrong side. they should be
  on the front, not the back."); OpenSCAD 2021.01 with
  `boolean_epsilon = 0.001` (repo standard per
  `scripts/scad_build.py` `--dry-run` and the build driver).
- Geometric derivation above recomputed from the committed `defaults.scad`
  constants (2026-09-23), not from memory of the earlier bad draft.

## Verification (before any commit)

1. `python scripts/scad_build.py --design solarpunk_exhaust --config designs/solarpunk_exhaust/configs/rev_0001.json --dry-run` PASS (17 expected invocations), asserts green (chamfer set + flipped/set pocket set + new fan-box pocket assert).
2. `python scripts/validate_cad_assembly_contract.py --design solarpunk_exhaust` PASS.
3. Complete build: `python scripts/scad_build_all.py --design solarpunk_exhaust --config designs/solarpunk_exhaust/configs/rev_0001.json` then `--audit-only` PASS (2 STL, 36 PNG, 2 manifests; 36 pre-review).
4. Assembly review re-run (mandatory — geometry changed):
   `python scripts/scad_render_assembly_review.py --design solarpunk_exhaust --config designs/solarpunk_exhaust/configs/rev_0001.json`; verify `output/solarpunk_exhaust/` on disk is 40 files (2 STL + 36 PNG + 2 manifests), flat, no directories, no stray .scad; review-manifest re-bound to new hashes (STL hashes change for the plate; proxy STL hash should stay `C24EE202F534E73BEBEE3738BF72BF47D762139D7C70E7F5903F87F68C46F355` — the proxy is untouched; review manifest rebind is mandatory); visual spot-check of the chamfer ISO + front-face view (8 pockets visible on the front face; back face solid).
5. README + `docs/solarpunk_series.md` updated (see Docs update) with the
   flipped wording and the third documented sub-minimum (1.41 mm).

## Docs update

1. `designs/solarpunk_exhaust/README.md`:
   - Decision bullet: V6 corner chamfer (45-degree, 20 mm legs, top-left;
     purpose: bracket corner margin; ceiling 22; 1.41 mm fan-box margin
     documented).
   - Decision bullet flipped: magnet recesses on the front face (V6
     addendum, user-directed); the V5 "against the ventilation screen"
     rationale marked superseded; mechanical consequence (magnets flush
     under the fan frame, clamping it to the plate) documented as fact.
   - Blockout diagram + ligament table: add the chamfer row + flip the
     membrane face wording (1.0 mm back membrane z 0..1); ligament table
     list the three documented sub-minimums: (a) 2.0 mm opening->fan-box
     plateau, (b) 1.0 mm back membrane, (c) 1.41 mm chamfer->fan-box
     corner.
   - Assert list updated accordingly (chamfer asserts, flipped pocket
     asserts, new fan-box pocket assert).
   - Artifact-bound review line updated after the review re-run.
2. `docs/solarpunk_series.md`:
   - Section 3 inventory row: bump status text (V6 addendum: corner
     chamfer + front-face recesses; rebuilt + audited 2026-09-23).
   - Section 7 solarpunk_exhaust: status / decisions / geometry /
     structural minimums bullets updated (three documented sub-minimums);
     front-face recess rationale recorded as user-directed 2026-09-23.

## Journal + plan bookkeeping

- Append a work-log entry to `journal/2026-09-23.md` (append-only;
  `Today's Intentions` and `Notes / Reflections` stay `-`).
- Mark ALL checklist items [x] when verified; archive plan to `plans/past/`
  with `status: past` (see item 7).

## Commit and push (pending explicit approval)

1. Suggested message (finalize at approval): `Add solarpunk_exhaust V6: top-left corner chamfer for the bracket margin, magnet recess face-flip to the front, plus post-commit checkpoint hygiene for 815d757`.
2. ONE commit: includes all source/config/README/series edits + the
   `output/` + `revisions/` (n/a here) artifact set + the 5 hygiene files
   + this plan file. No other files.
3. Push ONLY if explicitly requested (currently `main` ahead 1 of
   origin; this commit makes it ahead 2).

## Post-commit checkpoint

- Journal checkpoint entry for the V6 commit; update plan index if
  archived; regenerate indexes; STOP for user approval of the
  checkpoint commit before committing it.

## Checklist

- [x] 1. Source edits: `defaults.scad` (leg param + accessor + provenance), part file (header V6/addendum docs; chamfer triangle cut + asserts; pocket flip + assert wording + new fan-box pocket assert), config (key + status).
- [x] 2. Governance + build: dry-run PASS (17 invocations, asserts green, including chamfer + flipped + new pocket asserts); contract PASS; complete build + `--audit-only` PASS (2 STL / 36 PNG / 2 manifests; 36 pre-review).
- [x] 3. Assembly review re-run (mandatory): re-bind + disk-verify 40 files (2 STL + 36 PNG + 2 manifests, flat); visual check of chamfer + front-face pockets; proxy STL hash unchanged.
- [x] 4. Docs: README decision bullets (chamfer + front-face recesses, superseded V5 rationale), ligament table (three documented sub-minimums), assert list, review line; `docs/solarpunk_series.md` sections 3 + 7.
- [x] 5. Journal append + plan items [x] + index regenerate + `--check` (exit 0/0).
- [ ] 6. STOP for explicit commit approval: single commit (suggested message + artifact set from disk review). `git status -sb` shows ahead 2 after commit; push only if requested.
- [ ] 7. Post-commit: journal checkpoint entry, close item 6, archive plan to `plans/past/` with `status: past` + index regen + `--check`, STOP for checkpoint-commit approval.