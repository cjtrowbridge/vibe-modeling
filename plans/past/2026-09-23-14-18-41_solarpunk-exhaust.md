---
plan_id: 2026-09-23-14-18-41_solarpunk-exhaust
title: Solarpunk Exhaust Scaffold and Blockout
summary: Add solarpunk_exhaust — a single printable 3 mm 120 mm fan mounting plate over the greenhouse ventilation screen: Ø116 airflow opening, 4 M4-class station collars, and intelligence-hub 20x5 velcro slot bands on two adjacent edges (left + top). The hose/duct intake connection is out of scope (user-handled).
status: past
created_at: 2026-09-23-14-18-41
---

# Solarpunk Exhaust Scaffold and Blockout

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Approved context

User request (2026-09-23): new solarpunk-family design, a solarpunk exhaust
system — a mounting plate for a 120 mm fan with the same velcro holes as the
intelligence hub backplane on two opposite sides, velcroed to the greenhouse
frame where it overlaps the ventilation screen; a separate commodity aluminum
dryer hose brings air from the top of the greenhouse down to the fan.
User approved proceeding ("go ahead"): this plan is the approved governing
plan; execute items 1–3, stop at item 4 (commit) pending explicit approval.

Scope decision during execution (2026-09-23, user): the duct block and the
hose connection are out of scope for this design — "i will deal with that.
just focus on the single 120mm fan mounting plate with the velcro holes on
two sides."

Revision V4 (2026-09-23): the user rejected the locked rev_0001 geometry —
"this design doesn't make any sense. there is no 120mm bore for the fan to
blow through, and the velcro holes are inside the fan instead of at the
edge of two adjacent sides as instructed" — and supplied standard 120 mm
fan dimensions: 120 x 120 frame; 105 mm station span (±0.3); 115–116 mm
airflow cutout (116 adopted); 4.3–4.5 mm screw holes (4.3 working default
pending the physical fan; M4 / 7-32 class, not M3). The velcro bands move
to two adjacent edges: left + top (user choice). The architecture below is
the re-locked V4 geometry; the scaffold must be revised and items 1–2
re-executed against it.

Revision V5 (2026-09-23, user request): 8 recessed neodymium-magnet
pockets on the plate BACK face, one flanking each station bore along the
line between the hole pairs (user layout choice — the literal side
midpoints of the 105 mm station square sit inside the Ø116 opening, where
there is no material). Magnets: Ø6 x 2 mm discs (user); pockets Ø6.1 x
2.0 cut from z = 0, leaving a 1.0 mm membrane that the user accepted as
a documented sub-minimum (the magnetic force pulls the magnet AWAY from
the membrane, toward the screen; the membrane sees only fan static
pressure). At the user-proposed 11.0 mm offset the pocket wall to the
Ø10.3 collar OD would be 2.85 mm (another sub-minimum), so the offset is
refined to 11.5 mm, at which every adjacent-void wall clears
minimum_wall_thickness (collar OD 3.30 tightest; bore 6.30; opening
5.56; plate edge / window >= 7.45; pocket radius 66.6 mm from fan
center). Items 5.1–5.9 govern this addendum; the geometry change
invalidates the prior assembly review (re-run, item 5.5), and item 4.1's
message is amended below to cover the addendum.

## Architecture (locked by this plan)

- **Name:** `solarpunk_exhaust` (`designs/solarpunk_exhaust/`,
  `output/solarpunk_exhaust/`); `docs/solarpunk_series.md` is canonical.
- **Printed scope:** one printable 3 mm plate (part 1) + one non-printable
  fan-proxy reference mockup (part 2, per the reference-mockup playbook and
  the intelligence-hub precedent).
- **Commodity (not designed, dimensions open until measured):** 120 mm fan, frame/velcro hardware, greenhouse. (The aluminum dryer hose is user-handled and outside this design.)
- **Scope / airflow (user decision 2026-09-23):** this design covers ONLY the fan mounting plate (plus the fan reference mockup); the duct block and hose are out of scope. Context: warm air rises to the greenhouse top -> hose (user-supplied) -> fan intake -> 120 mm fan -> through the ventilation screen -> outside. The plate velcros over the screen on its back face; the fan mounts on its front (greenhouse-interior) face with exhaust toward the screen.
- **Airflow opening:** Ø116 through-opening (`fan_opening_d`) centered on the fan — the user-specified 120 mm fan cutout, clearing the ~110 mm blade assembly. The fan exhausts through it toward the ventilation screen. It is the maximum airflow opening consistent with corner-station mounting (the 105 mm station square bounds it; a full-frame 120 mm opening is geometrically impossible because the corner screws need material).
- **Velcro bands (hub language, adjacent edges):** 20 x 5 mm closed
  through-window slots, 2 per edge (8 total) on the LEFT and TOP edges at
  the 1/4 and 3/4 lines of that edge; band-cross layout per the hub: solid
  `velcro_gap` (3 mm) from the window to the plate edge, the window, then
  `velcro_gap` (3 mm) ligament to the fan box edge (hub rule: gap between
  the velcro holes and both the board edge and the parts below) — the band
  edges therefore carry margin `velcro_gap + velcro_slot_h + velcro_gap =
  11 mm`; the other two edges keep their slim margins (right = `edge_margin`
  3 mm, bottom = `fan_bottom_margin` 10 mm), so the fan is deliberately
  off-center on the plate.
- **Fan mount (standard values per user 2026-09-23; exact fan pending
  physical measurement):** 105 × 105 mm station span, Ø4.3 bores (user:
  4.3–4.5, M4 / 7-32 class — 4.3 is the working default) with raised
  Ø10.3 × 3 mm collars on the front face (collar wall = 3.0 mm exactly;
  series standoff convention).
- **Magnet pockets (V5 addendum 2026-09-23):** 8 closed circular
  pockets, Ø`magnet_pocket_d` (6.1) x `magnet_recess_depth` (2.0) deep,
  cut from the back face (z 0..2) — one per side line of the station
  square, `magnet_offset` (11.5) from each station bore toward the side
  midpoint, 66.6 mm radius from fan center. Retention magnets hold the
  plate to the screen with the velcro as the seal. The 1.0 mm back
  membrane (plate_t − recess_depth) is a documented, user-accepted
  sub-minimum; every pocket-to-void separation (collar OD 3.30, bore
  6.30, opening 5.56, plate edge / window >= 7.45) is asserted in
  source. Pockets NEVER touch the bores, collars, opening, windows, or
  edges below the asserted minimums.
- **Layout (origin bottom-left, +X right, +Y toward the top edge):** band
  edges (left, top) carry the derived 11 mm margin; `plate_w() = 11 +
  fan_size + edge_margin` = 134, `plate_h() = fan_bottom_margin + fan_size +
  11` = 141; fan box x 11..131, y 10..130, center (71, 70); Ø116 opening at
  the fan center (x 13..129, y 12..128); left-band windows x 3..8, rows
  y-centered 35.25 / 105.75 (1/4 and 3/4 of the plate edge); top-band
  windows y 133..138, rows x-centered 33.5 / 100.5 (x 23.5..43.5 /
  90.5..110.5). Front-face marking: "120MM FAN" label in the bottom strip
  under the fan (center (fan_cx(), fan_bottom_margin/2) = (71, 5)); the
  rev_0001 outline ring is dropped in V4 — as a fan-face silhouette it
  would be a (fan_size − fan_opening_d)/2 = 2.0 mm internal rim, below the
  3 mm minimum; the Ø116 opening edge IS the fan-frame boundary (the fan's
  own 5 mm frame rim bridges the 2.0 mm plateau at service). No
  size-derived constants hardcoded in source (parametric rule, cf.
  `solarpunk_seed_tray`).
- **Orientation:** prints flat (plate normal = Z); the raised M4-class
  collars define the front (fan-side) face; the back face (z = 0) is the
  velcro side over the screen.
- **Parametric surface (`configs/rev_0001.json`, pending physical
  measurement of the fan):** `plate_t = 3.0`, `fan_size = 120.0`,
  `fan_depth = 25.0`, `fan_opening_d = 116.0` (airflow bore; user 2026-09-23
  120 mm cutout), `fan_intake_d = 110.0` (context only: the proxy intake
  notch), `fan_mount_span = 105.0`, `fan_bore_d = 4.3` (user range 4.3–4.5;
  4.3 working default), `standoff_h = 3.0`, `standoff_od = 10.3`,
  `velcro_gap = 3.0`, `velcro_slot_w = 20.0`, `velcro_slot_h = 5.0`,
  `velcro_n = 2` per band, `edge_margin = 3.0` (right edge),
  `fan_bottom_margin = 10.0`, `minimum_wall_thickness = 3.0`,
  `minimum_structural_overlap = 3.0`, `maximum_print_dimension = 300.0`.
  V5 adds `magnet_pocket_d = 6.1`, `magnet_recess_depth = 2.0`,
  `magnet_offset = 11.5`. (`velcro_edge_margin` and `fan_top_margin`
  dropped — the band edges carry
  the derived 11 mm margin; `fan_top_margin` is no longer a free parameter
  because the top edge is a band edge.)
- **Derived blockout V4 (source computes and asserts these):** plate
  134 x 141 x 3; fan center (71, 70); stations (18.5/123.5, 17.5/122.5);
  fan box x 11..131, y 10..130 (plate edge ligaments: left 11 / right 3 /
  bottom 10 / top 11); Ø116 opening x 13..129, y 12..128; left-band
  windows x 3..8, rows y-centered 35.25 / 105.75 (row ligament 50.5, end
  ligament 25.25); top-band windows y 133..138, rows x-centered 33.5 / 100.5
  (x 23.5..43.5 / 90.5..110.5, row ligament 47, end ligament 23.5);
  label 21.8 x 4 centered (71, 5); opening edge to station-bore edge 14.1;
  station bore to nearest plate edge: right 8.35 / left 16.35 / top 16.35 /
  bottom 15.35; in-pattern bore ligament 100.7; collar wall 3.0; collar to
  nearest plate edge: right 5.35 / left 13.35 / top 13.35 / bottom 12.35;
  window-to-fan-box ligament 3.0; min window-to-opening ligament ≈ 7.95
  (clamped corner of the top-band row-2 window to the opening);
  label top edge to nearest bore edge 8.35; opening edge to fan-box edge
  2.0 (fan-rim-supported, cosmetic); tightest structural minimums = 3.0 mm
  (minimum_wall_thickness).
## Work items

- [x] 1. V4 geometry rework of the scaffold (scaffold itself already
  exists on disk from the pre-V4 run; the listed deltas are the required
  changes)
  - [x] 1.1 `src/lib/defaults.scad` — add `fan_opening_d = 116.0`
        (user 2026-09-23); default `fan_bore_d` 3.2 -> 4.3; standoff
        default 9.2 -> 10.3; add `band_margin() = velcro_gap + velcro_slot_h
        + velcro_gap` (= 11); `plate_w() = band_margin() + fan_size +
        edge_margin` (= 134); `plate_h() = fan_bottom_margin + fan_size +
        band_margin()` (= 141); `fan_cx() = band_margin() + fan_size / 2`
        (= 71); `fan_cy()` unchanged (70); `station_radius() = sqrt(2) *
        station_offset()` (= 74.25, the bores sit on the span square's
        diagonals); left-band x0 = `velcro_gap` (3), top-band y0 =
        `plate_h() - velcro_gap - velcro_slot_h` (133); left-band row
        centers `(i + 0.5) * plate_h() / velcro_n` (35.25 / 105.75),
        top-band row centers `(i + 0.5) * plate_w() / velcro_n`
        (33.5 / 100.5); drop `velcro_edge_margin`, `fan_top_margin`,`
        `outline_h`/`outline_w` (ring dropped), the right-band x helpers,
        and `device_outline`; keep all helpers computed (parametric rule).
  - [x] 1.2 `src/parts/solarpunk_exhaust.scad` — cut the circular Ø116
        airflow opening at the fan center (through the plate); reposition the
        8 velcro windows to the left + top bands (2 per band, hub band
        layout above); M4-class bores Ø4.3 + collars Ø10.3 x 3; drop the
        outline ring (V4: it would be a 2.0 mm internal rim, below the
        minimum); "120MM FAN" label in the front-face bottom strip at
        (fan_cx(), fan_bottom_margin/2); rewrite the §10 assert set for the
        re-locked geometry: `plate_t == minimum_wall_thickness`;
        `minimum_structural_overlap >=` minimum; plate-derivation
        identities; fan box to each plate edge ≥ minimum (11 / 3 / 10 /
        11); opening edge to nearest station-bore edge ≥ minimum (14.1 —
        the bores sit on the 105 square's diagonals: station_radius()
        − fan_opening_d/2 − fan_bore_d/2); in-pattern station ligament ≥
        minimum (100.7); every station bore to the nearest plate edge ≥
        minimum (tightest 8.35 — the right-edge bores; the plate is
        side-asymmetric by design: 11 mm left / 3 mm right); every collar
        to its nearest plate edge ≥ minimum (tightest 5.35, right-edge
        collars); collar wall ≥ minimum (3.0); slot dimensions ≥ minimum;
        `velcro_gap` ≥ minimum (window to plate edge AND to fan box — the
        fix for the rejected geometry); band-strip position identities;
        per-band row-identity asserts (1/4 and 3/4 of the plate edge);
        slot end-to-plate-end ligament ≥ minimum (left 25.25 / top 23.5);
        clamped-corner plan distance to the opening center minus
        fan_opening_d/2 ≥ minimum (8 windows asserted; ≈ 7.95 in the locked
        blockout — the top-band row-2 window); label fits (width ≤
        fan box; top edge to nearest bore edge ≥ minimum, 8.35); opening
        edge to fan-box edge (2.0 mm) > 0 — positive clearance, intended
        to be bridged by the fan's own 5 mm frame rim at service, asserted
        as positive but NOT claimed as a plate ligament (`fan_opening_d <
        fan_size` asserted); plate within `maximum_print_dimension`.
  - [x] 1.3 `src/parts/fan_proxy.scad` — station bores Ø4.3; an Ø116
        through-hole at the fan center (the airflow path) plus the existing
        Ø110 x 5 intake-face notch (blade-assembly context); update the
        envelope drift assert to the re-locked 134 x 141 plate; keep the
        standoff-OD-vs-fan-box containment assert (119.5 <= 120).
  - [x] 1.4 `configs/rev_0001.json` — `fan_bore_d` 4.3; `standoff_od` 10.3;
        add `fan_opening_d` 116.0; drop `velcro_edge_margin`,
        `fan_top_margin`; `status` text: placeholder pending physical fan
        (116 mm cutout, 105 span, 4.3–4.5 mm screw holes per user 2026-09-23;
        4.3 working default).
  - [x] 1.5 `assembly.json` — the member transforms and interface frames
        are derived from the same defaults: `exhaust_mount_assembly` member
        part 2 translate (63, 70, 3) -> (71, 70, 3); `fan_mount_interface`
        local_frame (71, 70, 3); `velcro_band_interface_left` local_frame
        (5.5, 70.5, 0) (band midpoint); the right-band interface is
        replaced by `velcro_band_interface_top` at (67, 135.5, 0) (band
        midpoint); must pass `scripts/validate_cad_assembly_contract.py`.
  - [x] 1.6 `designs/solarpunk_exhaust/README.md` — update for the re-locked
        V4 geometry (airflow path through the Ø116 opening; adjacent left +
        top bands; M4-class default; derived values; assert locations).
- [x] 2. Governance and build (re-run against the V4 geometry)
  - [x] 2.1 Dry-run: `python scripts/scad_build.py --design solarpunk_exhaust
        --config designs/solarpunk_exhaust/configs/rev_0001.json --dry-run`
        prints STL + PNG commands cleanly.
  - [x] 2.2 `python scripts/validate_cad_assembly_contract.py --design
        solarpunk_exhaust` passes.
  - [x] 2.3 Complete build: `python scripts/scad_build_all.py --design
        solarpunk_exhaust --config configs/rev_0001.json` installs a flat set
        into `output/solarpunk_exhaust/` (no staging left, no `.scad`, no
        directories).
  - [x] 2.4 `python scripts/scad_build_all.py --design solarpunk_exhaust
        --config configs/rev_0001.json --audit-only` passes on the installed
        set.
  - [x] 2.5 Artifact-bound assembly review in `output/solarpunk_exhaust/`:
        render + audit (`scripts/scad_render_assembly_review.py` after the
        complete build) producing `assembly_review_manifest.json` bound to
        the `build_manifest.json` hash and every STL hash; review the
        installed STL/PNGs (fan proxy seated at the station on the front
        face with its Ø116 through-hole aligning to the plate opening, 4
        collars through the 4 bores, 8 slots in the two ADJACENT bands left
        + top and fully clear of the fan footprint, single manifold shell
        per part).
- [x] 3. Series documentation and journal
  - [x] 3.1 `docs/solarpunk_series.md` §3 inventory: add the
        `solarpunk_exhaust` row (scaffold complete; placeholder config,
        pending fan measurement; hose/duct intake out of scope).
  - [x] 3.2 New `docs/solarpunk_series.md` design section for
        `solarpunk_exhaust` (goal, commodity scope, printed part, context
        airflow with the hose intake explicitly out of scope, key
        placeholder dimensions, print/structural parameters, open
        decisions: real fan model/hole pattern/depth, material — working
        proposal PETG, hose intake method owned by the user); renumber the
        siphon-filter and cross-design sections and fix in-doc
        cross-references.
  - [x] 3.3 `docs/solarpunk_series.md` §4 (architecture): annotate the
        ventilation/exhaust branch (greenhouse top → hose [out of scope,
        user-supplied] → fan plate → screen) alongside the hydroponic loop.
  - [x] 3.4 Root `README.md`: add `solarpunk_exhaust` to the included-designs
        line and update the stale "two solarpunk_* designs are in the design
        phase (no geometry yet)" note to reflect current statuses.
  - [x] 3.5 Journal entry `journal/2026-09-23.md` recording the scaffold,
        placeholders, build/audit/review results, and open items.
  - [x] 3.6 `python scripts/regenerate_plan_indexes.py --repo-root .` run and
        `--check` passes.
- [x] 4. Commit (done 2026-09-23 15:38 local with explicit user approval)
  - [x] 4.1 Suggested message (amended V5 to cover the pocket addendum;
        same uncommitted change set) used verbatim for commit `815d757`:
        "Add solarpunk_exhaust scaffold: 120 mm fan mounting plate with 116
        mm airflow opening, adjacent-side velcro slot bands, and 8 recessed
        magnet pockets". (54 files, +41977/−5; `main` ahead 1 of origin,
        NOT pushed.)
  - [x] 4.2 User approval obtained ("go ahead") before `git commit`.
  - [-] 4.3 Push only if the user explicitly requests it. — push not
        requested; closed without action (still ahead 1, unpushed).

### 5. Revision V5 — 8 back-face magnet pockets (approved addendum)

- [x] 5.1 `src/lib/defaults.scad`: add `magnet_pocket_d`,
      `magnet_recess_depth`, `magnet_offset` + pocket-center derived
      helpers; provenance comment.
- [x] 5.2 `src/parts/solarpunk_exhaust.scad`: 8 pocket subtractions from
      the back face + full void-separation assert set (membrane 1.0
      documented sub-minimum; collar 3.30 / bore 6.30 / opening 5.56 /
      plate edge + window >= 7.45 at offset 11.5, all asserted green at
      render).
- [x] 5.3 `configs/rev_0001.json`: the 3 new parameters + status note.
- [x] 5.4 Dry-run PASS (17 invocations) + contract PASS (assemblies=2,
      parts=2, interfaces=3, views=2) + complete build (pocket asserts
      green, flat install, no staging) + `--audit-only` PASS (2 parts,
      2 STL, 34 PNG, 36 artifacts pre-review; 40 files post-review).
- [x] 5.5 Assembly review re-run — geometry change invalidates the prior
      review; fresh `scad_render_assembly_review.py` run bound to the new
      manifest + STL hashes (hashes verified against disk); visual review
      confirms 8 recessed pockets flanking the 4 collar bores, clear of
      opening and windows.
- [x] 5.6 Docs: design README (magnet-recess decisions, ligament table,
      both documented sub-minimums) + `docs/solarpunk_series.md` §3/§7
      (status / decisions / geometry / structural minimums).
- [x] 5.7 Journal append to `journal/2026-09-23.md` (V5 entries 15:37–
      15:55 local).
- [x] 5.8 Mark V5 items complete + `scripts/regenerate_plan_indexes.py`
      (+ `--check`, exit 0).
- [ ] 5.9 STOP — present the diff summary + item 4.1's amended commit
      message and request explicit commit approval. Push only on an
      explicit request.
## Out of scope (this plan)

- The duct block / dryer-hose intake connection — explicitly out of scope  by user decision (2026-09-23); user handles it separately.
- Physical measurement of the actual fan (refines the config; any geometry
  change lands as a new revision).
- First immutable numbered revision publication
  (`how_to_create_verify_and_publish_immutable_openscad_revisions.md`) —
  after the print/measurement feedback loop.
- Printed hose clamp/boot, cable management, material selection, and any
  greenhouse-frame hardware.

## Verification approach

- Dry-run prints the expected command set before any render.
- Structural asserts fire in source: a deliberately wrong parameter
  (e.g. `velcro_gap = 1.0`) fails at build time; spot-checked once, not
  committed.
- Installed output passes `--audit-only` as a flat exact set (expected:
  2 STL + the standard multi-view PNG set + `build_manifest.json` +
  `assembly_review_manifest.json`).
- Assembly review shows the fan proxy seated at the station on the front
  face with the Ø116 openings aligned (collars through the 4 bores), 8
  slots in the two adjacent bands (left + top) fully clear of the fan
  box, and a single manifold shell per part.
- `scripts/regenerate_plan_indexes.py --check --repo-root .` exits 0.
