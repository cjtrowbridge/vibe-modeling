# old_rca_building

Specification-first design folder for a simplified, widened "30 Rock" tower model (Neuromancer-inspired) intended to hold and cool multiple phones.

This folder now includes OpenSCAD geometry revisions:

- `rev_0001`: initial stepped-massing draft
- `rev_0002`: maximum-simplification L-shape draft with rotated phone-void orientation

## Status

- Phase: simplified L-shape airflow prototype implemented (`rev_0002`)
- OpenSCAD source: created under `src/` with configs in `configs/rev_0001.json` and `configs/rev_0002.json`
- Primary goal of this README: preserve requirements traceability and implementation intent

## Model Orientation (Canonical)

- Front of model: the skinny tower side opposite the bump-out.
- Back of model: the bump-out side, where the fan mount hardware and USB exit are located.
- Left/Right: side faces when looking at the model from the front.
- Top: phone insertion opening.
- Bottom: print bed side / base floor.

For the current `rev_0002` default (`wing_attach_side = 1`), this maps to:

- `+Y` = back (bump-out/fan side)
- `-Y` = front (skinny side opposite bump-out)

## Design Intent

Create a stylized tower that functions as a top-loading phone bay:

- Phone inserts from the top into a vertical internal void.
- Top is open above the void.
- Internal rails keep the phone off walls to maintain airflow gaps.
- Bottom support cage holds the phone at least 70 mm above the model floor.
- A center opening under the phone lets the charging cable bend and route out.
- Rear stub volume is a hollow plenum with an open-back 40 mm fan mount.
- Below fan mount, a small cable opening routes USB out of the model and can be sealed with hot glue to reduce air leakage.
- Split-print workflow caps each printed piece for printer fit (`<= 220 mm` build area with ~`5 mm` margin), while allowing the assembled tower to fully enclose the tallest target phone.

## Initial Target Devices

The internal envelope must accommodate all of these devices:

| Device | External dimensions | Total system RAM | Estimated free RAM (after OS overhead) |
| --- | --- | --- | --- |
| Pixel 7 Pro | 162.9 x 76.6 x 8.9 mm | 12 GB | ~8.5 GB |
| Pixel 4a | 144.0 x 69.4 x 8.2 mm | 6 GB | ~3.8 GB |
| Pixel 2 | 145.7 x 69.7 x 7.8 mm | 4 GB | ~2.2 GB |
| LG V20 | 159.7 x 78.1 x 7.7 mm | 4 GB | ~1.8 GB |
| Galaxy S26 Ultra | 163.6 x 78.1 x 7.9 mm | 12 GB | ~8.5 GB |

## Source Documents (Reference Set)

This section describes the four source images provided in-chat on 2026-04-04 and how each one constrains the design.

### Source A: Tan Architectural Souvenir Miniature (Front-Left View)

Observed characteristics:

- Strong Art Deco massing with multiple vertical setbacks toward the top.
- Dominant central tower with smaller offset shafts.
- Rear/right-side lower volume that reads as a separate attached block.
- Continuous vertical window rhythm that creates a "ribbed" facade texture.

Design implications:

- Keep the main body as a stepped-stack silhouette, not a smooth taper.
- Preserve a distinct "tower plus attached rear/stubby volume" composition.
- Use simplified but repeated vertical facade patterning to preserve recognizable identity.
- Prioritize silhouette fidelity over micro-detail ornamentation in early revisions.

### Source B: Silver Detailed Model (High-Detail Physical Build)

Observed characteristics:

- Confirms stepped massing hierarchy and podium-to-tower transitions.
- Shows deep facade articulation and dense window grid.
- Highlights side/back offset masses and service-like rear block volumes.
- Base/podium geometry reads as a separate horizontal band under the tower.

Design implications:

- Model should include clear vertical zoning: podium, mid tower, upper setbacks.
- Rear stub volume should feel architecturally integrated, not an afterthought.
- Keep lower facade blockiness and step transitions even if windows are abstracted.
- If detail must be reduced for printability, preserve macro mass steps first, fenestration second.

### Source C: Simplified Digital Block Model (Gold/Black Render)

Observed characteristics:

- Demonstrates that a low-complexity facade can still read as "30 Rock" if massing is correct.
- Vertical stripe language (light wall + dark window channels) gives strong visual identity.
- Shows practical simplification path for a printable functional enclosure.
- Rear attached volume remains simple rectangular massing.

Design implications:

- Initial printable revision can use simplified rectangular primitives and stepped extrusions.
- Facade can be represented by shallow grooves/ridges instead of fully modeled windows.
- This is the preferred abstraction level for the first functional cooling prototype.
- Mechanical constraints (void, rails, fan plenum, cable path) take priority over facade fine detail.

### Source D: 40 mm USB Fan Mechanical Diagram

Observed characteristics (explicit dimensions shown in source):

- Fan frame: `40.0 +/- 0.5 mm` square.
- Fan thickness: `10.0 +/- 0.5 mm`.
- Mounting hole spacing: `32.0 +/- 0.5 mm` square (center-to-center).
- Mounting hole diameter: `3.5 +/- 0.2 mm`.
- Cable length shown: `500 +/- 15 mm`.
- Lead wire reference: `UL1061, AWG#24`.
- Airflow direction and front/side profile are explicitly indicated.

Design implications:

- Rear plenum fan opening and standoff should assume a nominal 40x40x10 fan body.
- Hole pattern for first revision should be centered 32 mm square.
- Hole clearances should account for print/process tolerance (draft target: `3.6-3.8 mm` printable clearance).
- Cable exit path below fan must allow USB lead to bend without sharp pinching.
- A sealable cable notch below the fan remains required to reduce leak bypass.

### Cross-Source Synthesis (What Must Be Preserved)

- Architectural identity: stepped 30 Rock-like silhouette with attached lower rear mass.
- Functional conversion: interior must be widened/hollowed for multi-phone insertion and airflow.
- Mechanical realism: fan mount and cable path should follow source fan dimensions.
- Practical printability: use simplified facade language while keeping major massing transitions.

## Derived Envelope (Draft Baseline)

Using the table above:

- Max phone height: `163.6 mm`
- Max phone width: `78.1 mm`
- Max phone thickness: `8.9 mm`
- Overall model height cap (`overall_height_max`): `215.0 mm`

Draft internal sizing targets for revision `rev_0002` implementation:

- Void inner thickness axis (`void_x`): `18.0 mm`
- Void inner width axis (`void_y`): `88.0 mm`
- Tower phone-void top behavior: full-height through-cut (no partial lip overhang)
- Top insertion aperture is sized by rail clearances:
  - `top_open_x = void_x - 2*rail_side_protrusion_x = 14.0 mm`
  - `top_open_y = void_y - 2*rail_protrusion_y = 84.0 mm`
- Usable supported phone height above cage (`void_z_above_support`): `145.0 mm` (phones extend above top by design)
- Support elevation above model floor (`support_z`): `70.0 mm` minimum (must stay `>= 70.0 mm`)

These values are intended to:

- fit all listed phones,
- preserve air channels around the device body,
- and leave tolerance for insertion/removal without binding.

## Internal Rail Plan (Draft)

Current interpretation of the rail requirement from discussion:

- Front wall: 2 vertical rails
- Back wall: 2 vertical rails
- Wide side walls: 1 vertical rail on each side
- Total vertical rails in phone void: 6

Rail behavior targets:

- Rails are the primary side contact points (minimal contact area).
- Rails create consistent stand-off so most of each phone side remains exposed to moving air.
- Rails continue downward into a bottom cage structure.

Draft starting rail dimensions:

- Front/back rail protrusion into void: `2.0 mm`
- Front/back rail width (`X`): `2.8 mm`
- Wide-side rail protrusion into void (`X`): `2.0 mm`
- Wide-side rail span (`Y`): `18.0 mm`
- Rail bottoms start at phone-void floor (`support_z`) and do not extend below it
- Enforced minimum phone-to-rail slide margin: `2.0 mm`
- Current computed margins:
  - width axis margin at front/back rails: `(88.0 - 2*2.0 - 78.1)/2 = 2.95 mm`
  - thickness axis margin at wide-side rails: `(18.0 - 2*2.0 - 8.9)/2 = 2.55 mm`
- Rail edge treatment: small chamfer/round to reduce insertion snagging
- Top lead-in: chamfer at opening to guide insertion

## Bottom Cage + Cable Bend Zone (Draft)

Required behavior:

- Phone is supported at least 70 mm above floor.
- Support structure is not a full closed plate.
- Center region remains open so charging cable can bend under phone.

Draft baseline geometry:

- Side support runners integrated with rail bases
- Front and back bridging elements for stiffness
- Center cable window left open (`~22-26 mm` width target, finalized in OpenSCAD revision)

## Rear Stub / Fan Plenum (Draft)

Rear mass behind front facade is a simple hollow rectangular volume:

- Open back for fan access and intake/exhaust interface.
- Mount area designed for nominal `40 mm` fan body.
- Fan mount pattern (from source fan drawing): `32.0 +/- 0.5 mm` hole spacing square.
- Fan mounting hole target: `3.5 mm` nominal with print-tolerance tuning.
- Small cable exit opening directly below fan region.
- Cable exit is intentionally glue-sealable to limit unwanted air leakage.

## Airflow Strategy (Draft)

- Fan drives air through rear plenum into/through the phone void region.
- Rails maintain clearance channels to avoid full wall contact.
- Top opening functions as primary exhaust path.
- Cable exit leak is accepted and can be sealed in assembly.

## Printing / Manufacturing Assumptions (Draft)

- FDM baseline with `0.4 mm` nozzle.
- Wall thickness target for `rev_0002`: `2.0 mm` (configurable via `wall`).
- Internal structural members sized for reliable bridging where possible.
- Orientation target: print upright unless overhang review shows better split orientation.

## Facade Setback Plan (Approved)

Priority is side silhouette fidelity via major tiered setbacks only (no windows or fine ornament).

- Keep all functional internals unchanged (phone void, rails, cage, fan plenum, cable slot).
- Add side-only external tiers as additive masses on the left/right tower faces (the wide side faces).
- Use a single tier protrusion variable (`side_setback_step`, currently `7.0 mm`) and apply the same protrusion distance to all four tiers, with mirrored left/right break heights.
- Add front-face tiers on the skinny front wall using the same four tier heights, with cumulative protrusion by `front_setback_step` (`3/6/9/12 mm` in `rev_0002`).
- Add a second front tier set centered on the middle third of the front width (`front_center_x_start_frac = 1/3`, `front_center_x_end_frac = 2/3`), with slightly raised tier-top heights and `+3 mm` additional protrusion versus each matching primary front tier.
- Top tier top is held below tower top by `side_top_tier_top_gap` (`10.0 mm` in `rev_0002`).
- Tier depth-by-reach rule (from back wall toward front):
  - top tier reaches center (`0%` of center-to-front span),
  - second tier reaches `25%` from center to front,
  - third tier reaches `50%` from center to front,
  - fourth tier reaches `75%` from center to front.
- Tier height normalization rule: with the current top and bottom tier-top heights held fixed, the two middle tier-top heights are evenly spaced between them.
- Tier base rule: all side tiers start at the model floor (`z=0`) with no floating tier bands.
- Preserve printability by building setbacks from the base upward (no floating decorative ledges).
- Keep the design intentionally coarse and structural, matching the simplified Neuromancer-style intent.

## Open Questions For Next Geometry Revision

1. Final phone orientation relative to facade (screen toward front vs back).
2. Whether dimensions should include phone cases (and what case thickness budget).
3. Whether rails are needed on front/back walls in addition to left/right pairs.
4. Exact fan screw strategy (M3 machine screws vs fan self-tapping).
5. Visual facade complexity level for first printable revision (minimal stepped massing vs decorative vertical detailing).

## Implemented Artifacts (`rev_0001`, `rev_0002`)

Created in this revision:

- `src/main.scad`
- `src/lib/defaults.scad`
- `src/parts/old_rca_building.scad`
- `configs/rev_0001.json`
- `configs/rev_0002.json`
- `configs/rev_0002_split_lower.json`
- `configs/rev_0002_split_upper.json`
- `configs/rev_0002_wing_roof_insert.json`

`part_id` map:

- `0`: full printable model
- `1`: outer architectural mass only
- `2`: negative cutters (debug)
- `3`: internal supports only (rails + cage)
- `4`: lower split section (below `split_z`)
- `5`: upper split section (at/above `split_z`)
- `6`: removable wing-roof insert (print separately)

Implemented in `rev_0001` `part_id = 0`:

- one-piece printable shell with internal phone void,
- side rails,
- bottom cage with center cable opening,
- rear fan plenum and cable slot,
- no advanced facade ornamentation beyond simplified stepped silhouette.

Implemented in `rev_0002` `part_id = 0`:

- maximum-simplification L-shape massing (tower + low wing),
- phone-void orientation rotated 90 degrees in plan from prior draft,
- phone void centered in tower section,
- fan-wing bump-out and intake rotated 90 degrees in plan from the prior orientation,
- `rev_0002` keeps bump-out width equal to tower skinny-side width for silhouette consistency,
- `rev_0002` targets a 2:1 tower-long-side to exposed bump-out-length ratio,
- `wing_attach_side` parameter controls which Y side gets the bump-out (`+1` or `-1`),
- `rev_0002` uses `2.0 mm` walls/floor and a configurable `bump_margin` (currently `2.0 mm`),
- `rev_0002` enforces a split-piece height cap of `215.0 mm` (for a `220 mm` Z build area with ~`5 mm` margin),
- with split printing, `rev_0002` tower height is increased to fully enclose the tallest target phone inside the void,
- `rev_0002` void enclosed height is `tower_z - support_z = 242.0 - 70.0 = 172.0 mm`, which fits `phone_h_max = 163.6 mm` with `8.0 mm` top clearance,
- `rev_0002` side facade now uses four tiers per side on wide faces with one shared `7.0 mm` protrusion value applied equally to every tier,
- left/right side tier geometry is mirrored, with matching Z breakpoints on both wide faces,
- `rev_0002` now also includes a front-face 4-tier set (same tier heights), with cumulative protrusions of `3/6/9/12 mm` from the front wall,
- `rev_0002` now includes an additional centered front 4-tier set over the middle third of facade width (`1/3` to `2/3` across X), with tier tops raised by `4.0 mm` and protrusions increased by `+3.0 mm` versus the primary front-tier set (centered set becomes `6/9/12/15 mm` where primary is `3/6/9/12 mm`),
- `rev_0002` top tier ends `10.0 mm` below the tower top (`side_top_tier_top_gap = 10.0`),
- `rev_0002` tier depth progression is back-to-front by center-relative reach: top=`0%`, tier2=`25%`, tier3=`50%`, tier4=`75%` of center-to-front span,
- all `rev_0002` side tiers now start at floor level (`z=0`) so tier bottoms are grounded to the base,
- bump-out X/Z envelope is compacted so there is no extra space above the fan, below the USB slot, or beside the fan beyond `bump_margin`,
- bump-out wing cavity is now open at the top in the main body (roof moved to separate insert part),
- fan-end mounting plate now uses a central circular intake (`fan_intake_d = 38.0 mm`) on the same center point so the four `32 mm`-spacing mounting holes remain aligned to the fan pattern,
- USB cable slot at fan face is `12.0 mm` wide by `7.0 mm` tall in `rev_0002`,
- tower phone void now extends vertically through the tower top (no partial top lip), eliminating the prior support-requiring overhang at that boundary,
- tower air-chamber roof now uses a full-depth `45 degree` inverse bevel from the phone-void opening out to the inner tower walls (no flat internal ceiling), implemented with `tower_inner_roof_bevel = 0.0` auto mode,
- bump-out roof no longer uses an integrated half-pipe vault; the separate insert provides a flat roof panel when installed,
- tower-to-wing plenum link now matches the full open-top wing cavity height,
- removable wing-roof insert (`part_id = 6`) is now a cap-style cover: the plate seats on the wing top rim with no overhang on the tower-side edge, and three retention lips (both X edges + tower-side Y edge) extend into the opening,
- the insert lips use opening-clearance sizing (`roof_insert_clearance`) and inset placement (`roof_insert_lip_inset`) so the tabs enter cleanly and the cover cannot drop through,
- wing-roof insert is exported in print orientation with panel face down and lips up; flip for installation into the open wing cavity,
- optional debug mode `debug_open_bottom = 1` opens the tower/wing cavities from below for inspection; production/slicing config keeps `debug_open_bottom = 0`,
- horizontal split export is supported via `split_z` (default `support_z - cage_bar_h`) so the upper section starts with the phone-holder base floor,
- split exports apply a tiny internal epsilon on both sides of the split with strict Z ownership (no overlap: `lower < split_z`, `upper > split_z`) to avoid coplanar/phantom sliver artifacts,
- dedicated split configs are provided: `rev_0002_split_lower.json` (`part_id = 4`) and `rev_0002_split_upper.json` (`part_id = 5`),
- rails in `rev_0002` include front/back pairs plus two wide-side rails, with bottoms flush to the void floor,
- `rev_0002` enforces a minimum `2.0 mm` clearance from phones to rails on both width and thickness axes,
- `rev_0002` no longer includes the previous bump-out-side 45 degree wedge/buttress under the phone support ring,
- upper split part now includes phone-base end ties to the front/back inner tower walls so both platform ends are mechanically connected without changing lower split geometry,
- the phone-base cable window in `rev_0002` is nominally centered; the bump-side strip is kept open to preserve a more direct intake path near the fan feed,
- the remaining unsupported underside of the phone catch platform in `rev_0002` is extended down to the floor, while the bump-side strip is intentionally left open as a direct airflow path from the fan plenum,
- open base interior/plenum path from end-face fan intake to tower void region,
- top-open exhaust through the tower.

## Build / Verification Commands

Dry-run path/config verification:

```bash
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0001.json --dry-run
```

Generate STL + multi-view PNG set:

```bash
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0001.json
```

For the simplified L-shape draft:

```bash
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0002.json --dry-run
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0002.json
```

For horizontal split exports:

```bash
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0002_split_lower.json
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0002_split_upper.json
```

For the removable wing-roof insert:

```bash
python scripts/scad_build.py --design old_rca_building --config designs/old_rca_building/configs/rev_0002_wing_roof_insert.json
```

Additional below-view outputs from the build pipeline:

- `<part>_iso_bottom_front_right.png`
- `<part>_iso_bottom_front_left.png`
- `<part>_iso_bottom_back_right.png`
- `<part>_iso_bottom_back_left.png`
- `<part>_inspect_inside_bottom_iso.png` (angled perspective into lower tower cavity)
- `<part>_inspect_inside_bottom_ortho.png` (orthographic underside framing focused on bevel region)
- `<part>_ortho_bottom.png`

Build contract: every `scad_build.py` run always renders the complete multi-view PNG set above (plus legacy `<part>.png`) and fails if any expected image is missing.
