# solarpunk_exhaust

A single printable 120 mm fan mounting plate for the solarpunk greenhouse
exhaust branch: the intelligence-hub velcro side applied to a fan mount.
The fan (user-supplied commodity part, not in this repo) mounts onto the
plate's 4 raised M4-class collar bores, and 8 closed 20 mm × 5 mm velcro
through-windows in two bands on two adjacent edges (left + top, outside the
fan footprint) fasten the plate's back face to the greenhouse ventilation
screen behind it. 8 recessed Ø6.1 × 2.0 mm neodymium-magnet pockets on the
back face (V5) flank the four station bores and hold Ø6 × 2 mm retention
discs against the screen.

Canonical source of truth for this design and the solarpunk series:
[`docs/solarpunk_series.md`](../../docs/solarpunk_series.md)

*Status: scaffold (rev_0001, in phase, plan V4). All commodity fan values are
placeholders pending physical measurement of the target fan —
`minimum_wall_thickness` / `minimum_structural_overlap` (3.0 / 3.0), the
derived layout, and the 134 × 141 blockout are locked. (The original
rev_0001 geometry — no airflow opening, velcro slots on two opposite edges
inside the fan footprint — was rejected by the user and reworked to V4 in
place, still under `rev_0001` while the config remains a measured-
placeholder scaffold; V5 adds the 8 magnet pockets, still under `rev_0001`;
no immutable revision has been published yet.)*

## 1. Role

`exhaust_system` (product) → `exhaust_mount_assembly` (subassembly):

| Part | `part_id` | Printable |
|---|---|---|
| Mounting plate | 1 | **yes (T2)** |
| Fan proxy (120 mm block, Ø116 through-hole, + Ø110 intake notch) | 2 | reference only — exported for preview, never a print target |

Airflow series context: greenhouse top (warm air) → **hose** (user-supplied
part, out of scope for this repo) → fan intake → fan → plate with velcro
window slots → **out through the greenhouse ventilation screen**. The fan is
a commodity part and is not modeled as a printable element.

## 2. Design decisions (locked)

- **One 134 mm × 141 mm × 3 mm landscape plate** (part 1, origin at the
  bottom-left corner, front face +Z): the 120 mm fan box plus the derived
  band margin on the left and top edges, `fan_bottom_margin` (10 mm) below
  it, and `edge_margin` (3 mm) beyond it on the right. `plate_w() =
  band_margin() + fan_size + edge_margin`, `plate_h() = fan_bottom_margin +
  fan_size + band_margin()`, `band_margin() = velcro_gap + velcro_slot_h +
  velcro_gap` (= 11 mm at config defaults) — the plate dimensions are
  derived, never hardcoded. `minimum_wall_thickness = 3.0`,
  `minimum_structural_overlap = 3.0` (per AGENTS.md §10).
- **Airflow opening:** a Ø116 through-opening (`fan_opening_d`) centered on
  the fan — the user-specified 120 mm fan cutout (clearing the ~110 mm
  blade assembly). The fan exhausts through it toward the ventilation
  screen. It is the maximum airflow opening consistent with corner-station
  mounting (the 105 mm station square bounds it; a full-frame 120 mm
  opening is geometrically impossible because the corner screws need
  material).
- **Fan station cross** on the front face (+Z, greenhouse-interior side):
  4 × Ø4.3 (M4-class — user range 4.3–4.5, placeholder) at a 105 mm square
  centered at (71, 70). Each bore sits under a **raised Ø10.3 × 3 mm
  collar** (3 mm wall at the structural minimum), the series'
  raised-collar convention from the intelligence hub.
- **8 velcro through-windows, closed (slit, never open to the plate edge)**
  in the intelligence-hub slot language (open, square-cornered, 20 × 5
  slots): 2 bands on two **adjacent** edges (left + top) × 2 slots, each row
  on the 1/4 and 3/4 lines of its plate edge (left: y-centered
  35.25 / 105.75, x 3..8; top: x-centered 33.5 / 100.5, y 133..138). Every
  window is outside the fan box — hub band rule: solid `velcro_gap` (3 mm)
  from the window to the plate edge AND from the window to the fan box
  edge. This is what the rejected geometry did not have.
- **Front face** also carries a 1 mm raised "120MM FAN" label in the bottom
  strip under the fan, centered (series marking convention). The rev_0001
  outline ring was dropped in V4 — as a fan-face silhouette it would be a
  `(fan_size − fan_opening_d)/2 = 2.0 mm` internal rim, below the 3 mm
  minimum.
- **Fan proxy (part 2)**: a 120 × 120 × 25 mm box at the fan station on the
  front face with the 4 Ø4.3 bores (1:1 with the plate bores / collars), an
  Ø116 through-hole at the fan center (the airflow path, 1:1 with the plate
  opening), and a Ø110 × 5 mm intake notch on its intake face (where the
  out-of-scope hose connects). It is **reference mockup geometry** — present
  in the build/export only so the assembled stack previews correctly; it is
  never a print target.
- **Back-face magnet pockets (V5 addendum, user 2026-09-23):** 8 closed
  recessed circles Ø6.1 × 2.0 mm (`magnet_pocket_d`, `magnet_recess_depth`)
  in the back face, one on each of the two adjacent sides flanking every
  station bore (`magnet_offset` along the station line — refined by the
  agent from the user's provisional 11.0 mm to 11.5 mm so that every pocket
  void keeps the 3.0 mm minimum against the collar OD; 11.5 is the declared
  value). The pockets take Ø6 × 2 mm neodymium retention discs that press
  the plate to the ventilation screen; they are retention only — magnetic
  force pulls the discs *away* from the membrane toward the screen, so the
  membrane carries only the fan's static pressure. Each pocket leaves a
  1.0 mm back membrane (`plate_t` − `magnet_recess_depth`): a **documented,
  user-accepted structural sub-minimum** (asserted). Pocket voids: 52.5 mm
  from the fan center (planar) — all clear of the Ø116 opening and the
  velcro windows (tightest 7.45 mm vs right-edge and adjacent-band
  windows).
- **Out of scope (user-handled):** the exhaust duct / dryer-hose section
  (`exhaust_duct`) and the screen frame.
- **Open (pending physical fan measurement):** fan mounting span (105 mm),
  bore diameter (Ø4.3, M4-class), intake circle (Ø110 mm), fan depth (25 mm)
  are commodity placeholders; if the fitted fan differs, a new revision is
  required — the plate dimensions re-derive from the fan box + margins.

## 3. Layout blockout (rev_0001 V4, placeholder values)

```
plate 134 x 141 x 3, origin bottom-left, front face +Z (fan side)
fan box 120x120: x 11..131, y 10..130, center (71,70)
airflow opening (Ø116): center (71,70), x 13..129, y 12..128, full depth
fan stations (M4-class, Ø4.3): (18.5,17.5) (123.5,17.5)
                               (18.5,122.5) (123.5,122.5)
raised collars (Ø10.3 x 3, wall 3.0): one per station, front face
velcro windows (20 x 5, closed): left band  x 3..8, rows y-centered
                                 35.25 / 105.75 (ligament 50.5 row,
                                 25.25 end);
                                 top band   y 133..138, rows x-centered
                                 33.5 / 100.5 (ligament 47 row, 23.5 end)
label "120MM FAN" (size 4, raised 1 mm): center (71,5), top edge y 7
magnet pockets (V5, Ø6.1 x 2.0 recess, back face z 0..2): (30,17.5) (112,17.5)
                                                        (30,122.5) (112,122.5)
                                                        (18.5,29) (18.5,111)
                                                        (123.5,29) (123.5,111)
ligaments: opening edge to bore edge 14.1; bore to nearest plate edge
           8.35 (right edge, tightest); in-pattern bore ligament 100.7;
           collar to nearest edge 5.35 (right edge); window to fan box
           3.0; min window to opening 7.95 (top-band row 2, clamped
           corner); opening edge to fan-box edge 2.0 on all four sides
           (positive; bridged by the fan's own 5 mm frame rim at service —
           asserted > 0, deliberately sub-minimum); pocket edge to nearest
           void 3.30 (collar OD, tightest; bore 6.30, opening 5.56);
           pocket to plate edge / window min 7.45 (right-edge rows and
           adjacent-band windows); pocket ligaments same-side 75.9, corner
           10.16; back membrane 1.0 (documented sub-minimum, V5); minimum
           wall throughout 3.0 (except the two documented sub-minimums)
printable artifact: plate 134 x 141 x 3, prints flat (plate normal = Z);
                    with the 3 mm collars the stack is 6 mm tall
```

## 4. Verification contract (rev_0001 V4)

- **Structural joins (AGENTS.md §10):** `minimum_wall_thickness = 3.0`,
  `minimum_structural_overlap = 3.0` (asserted, `src/parts/solarpunk_exhaust.scad`
  header). `plate_t == minimum_wall_thickness`: the 3 mm plate **is** the
  structural element.
- **Asserted in source** (`solarpunk_exhaust.scad`, named dimensions):
  plate-t/overlap governance; plate derivation identities (134 / 141);
  fan box to every plate edge ≥ 3 (11 / 10 / 11 / 3); `fan_opening_d <
  fan_size` and per-edge opening-to-fan-box clearance > 0 (2.0, documented
  sub-minimum, fan-rim-bridged); opening edge to nearest station-bore edge
  ≥ 3 (14.1, diagonal via `station_radius()`); magnet recess closed on the
  back face and back membrane ≥ 1.0 − ε (exactly 1.0, **documented,
  user-accepted sub-minimum** — retention only, away from the membrane);
  every pocket void edge to its nearest void ≥ 3 (bore 6.30, collar OD 3.30,
  opening 5.56; `magnet_offset = 11.5` keeps all of these at the minimum,
  refined from the user's provisional 11.0 mm); every pocket to every plate
  edge ≥ 3 (min 7.45, right-edge rows); every pocket to every velcro window
  (clamped-corner) ≥ 3 (min 7.45, adjacent band); pocket ligaments ≥ 3
  (same-side 75.9; corner 10.16); in-pattern station ligament
  ≥ 3 (100.7); every station bore to the nearest plate edge ≥ 3 (min 8.35,
  right edge); collar wall ≥ 3 (3.0, exactly); every collar to the nearest
  plate edge ≥ 3 (min 5.35, right edge); slot dimensions and `velcro_gap`
  ≥ 3 (window to plate edge AND to fan box); band row identities (1/4 and
  3/4 of each plate edge); row-to-row and end ligaments ≥ 3 (left 50.5 /
  25.25, top 47 / 23.5); all 8 windows' clamped-corner plan distance to the
  opening center minus `fan_opening_d / 2` ≥ 3 (min 7.95); label fit and
  label-top clearance; plate within `maximum_print_dimension` (134 × 141
  ≤ 300).
- **Documented sub-minimums (asserted positive, not claimed as plate
  ligaments):** (1) opening edge → fan-box edge is 2.0 mm on all four
  sides — the fan's own 5 mm frame rim spans this plateau at service; the
  plate never carries it as structure. (2) The back membrane below the 8
  magnet pockets is 1.0 mm (V5 — user-accepted 2026-09-23, asserted
  ≥ 1.0 − ε): retention-only, away from the membrane; it carries only the
  fan's static pressure.
- **Connectivity:** single manifold solid per printable part (OpenSCAD
  render reports `Simple: yes` per part; reviewer-confirmed on the
  installed renders).
- **Artifact-bound review:** contract gate via
  `validate_cad_assembly_contract.py` (PASS: primary=exhaust_system,
  assemblies=2, parts=2, interfaces=3, views=2) then
  `scad_render_assembly_review.py`: `assembly_review_manifest.json` bound
  to the `build_manifest.json` hash and every STL hash (front view: proxy
  seated at the station, its Ø116 through-hole aligned with the plate
  opening, 4 collars through the 4 bores, 8 windows in the two adjacent
  bands clear of the fan box; back face: 8 magnet-pocket recesses flanking
  the 4 collar bores, all clear of the opening and windows).
- **Print orientation:** flat (plate normal = Z, back face on the bed);
  no supporting structure required for the 3 mm features; the fan box and
  duct are not modeled (user-supplied parts).

## 5. Configuration

- `configs/rev_0001.json` — single config (landscape, 2-slot bands, all
  placeholder commodity values, incl. the V5 magnet-pocket triple
  `magnet_pocket_d` 6.1 / `magnet_recess_depth` 2.0 / `magnet_offset`
  11.5; `part_id` 1 = plate, 2 = fan proxy, 90 = assembly review) — no
  parameter set has been frozen/locked: rev_0001 remains the mutable
  scaffold (plan item 4).
- `src/main.scad` — entry point, dispatches `part_id` 1/2/90.
- `src/lib/defaults.scad` — parametric defaults (all values `-D`
  overridable; derived layout lives here, not in the part sources).
- `src/parts/solarpunk_exhaust.scad` — printable plate (part 1).
- `src/parts/fan_proxy.scad` — reference-only fan block (part 2).
- `src/parts/assembly_review.scad` — internal assembly-review scene
  (view_id 0: product assembly, `show_proxies = true`).

## 6. Build / verify commands

```bash
python scripts/scad_build_all.py --design solarpunk_exhaust \
    --config designs/solarpunk_exhaust/configs/rev_0001.json
python scripts/scad_build_all.py --design solarpunk_exhaust \
    --config designs/solarpunk_exhaust/configs/rev_0001.json --audit-only
python scripts/validate_cad_assembly_contract.py --design solarpunk_exhaust
python scripts/scad_render_assembly_review.py --design solarpunk_exhaust \
    --config designs/solarpunk_exhaust/configs/rev_0001.json
python scripts/regenerate_plan_indexes.py --repo-root . --check
```