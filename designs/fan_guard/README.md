# Micro cyberdeck fan guard

A single-part, flat air guard for the 40 mm fan in the `micro_cyberdeck_case`
right (fan) wall. It is a flat square plate with a centered circular air
opening, held `standoff_height` above the fan face by four M3-bored posts at
the fan's four corner mounting stations. It protects the spinning blades while
keeping airflow in axially through the center opening and radially through the
perimeter gap between the fan face and the plate.

## Mounting to the case fan interface

The guard clamps to the case's existing fan interface using the case's four
existing M3 fan screws. Each post is bored to the same `Ø4.2 mm` (`stud_bore_d`)
as the case's `fan_mount_hole_d`, on the same 32 mm corner pitch (`stud_pitch`
== case `fan_hole_spacing`). Screw path: case right-wall hole → fan flange
hole → guard post bore. The post standoff height (`standoff_height`, 3 mm)
spaces the plate `3 mm` above the fan face.

## Dimensions (`rev_0001`)

- Guard plate: 46 mm square x 3 mm thick.
- Center air opening: Ø38 mm (coincides with the Ø38 mm fan blade circle).
- Standoff posts: Ø6 mm outer, Ø4.2 mm through-bore, 3 mm tall standoff below
  the plate; four posts at the ±16 mm corner stations (32 mm pitch).
- Flat ring between the center opening and the plate edge: 4 mm.
- Coordinate datum (guard local): the fan face lies in the `z = 0` plane with
  the fan center at the origin in `x/y`; the posts run `z = 0..6` and the plate
  spans `z = 3..6`. Global exported bounds: `x/y ∈ [−23, 23]`, `z ∈ [0, 6]`.

## Structural minima (AGENTS.md §10)

- `minimum_wall_thickness` = 3 mm.
- `minimum_structural_overlap` = 3 mm.
- `minimum_internal_edge_width` = 3 mm.

## Documented relaxations (mirroring the case's fan-wall ligament exceptions)

These sub-3 mm features are constrained by the Ø38 mm blade circle and the
32 mm station pitch; a full 3 mm width would put the posts inside the blade
circle. They are asserted at documented floors rather than the 3 mm minimum:

- Center-opening edge vs blade circle: the opening edge coincides with the
  blade circle (`opening_blade_clearance` = 0, asserted ≥ 0). The posts and the
  perimeter ring are what keep the tips clear.
- Post outer edge vs blade circle: `blade_clearance_actual` = 0.63 mm
  (asserted ≥ 0.5).
- Post outer edge vs center-opening rim: `stud_opening_clearance` = 0.63 mm
  (asserted ≥ 0.5).
- Post bore annulus (material around each M3 bore inside a post):
  `stud_bore_annulus` = 0.9 mm (asserted ≥ 0.8).

Everything else — plate thickness, flat ring (4 mm), bore-to-plate-edge margin
(4.9 mm), post embed into the plate (3 mm, a positive-volume join at the 3 mm
minimum structural overlap) — meets the 3 mm minimum.

## Build

```bash
python scripts/scad_build.py --design fan_guard --config designs/fan_guard/configs/rev_0001.json --dry-run
python scripts/scad_build.py --design fan_guard --config designs/fan_guard/configs/rev_0001.json
```

Generated artifacts are installed under `output/fan_guard/` (1 STL + 17 PNGs).

## Revision 0001 artifact verification — 2026-09-18

- Source revision/config: `configs/rev_0001.json` (the only config); mutable source under `src/`.
- Build scope and destination: one printable part built with `scripts/scad_build.py` into `output/fan_guard/`.
- Expected/actual artifacts: 1/1 STL and 17/17 PNG files; 18 total files, no directories or staged `.scad` files.
- Build log: zero OpenSCAD warnings or errors; all dimension and structural assertions passed.
- STL bounds: `x/y ∈ [−23, 23]`, `z ∈ [0, 6]` mm; 872 unique vertices, 1760 triangles.
- Connectivity: passed; the installed STL is a single connected component (verified with a temporary vertex-sharing mesh probe, deleted after review).
- Structural joins: passed; each of the four posts embeds the full 3 mm plate thickness into the plate (a positive-volume overlap at the 3 mm minimum structural overlap), so the guard is one solid.
- Minimum internal edge/material width: passed at the 3 mm minimum for the plate, flat ring, bore-to-edge margin, and post embed; the four documented relaxations above are asserted at their floors.
- Airflow: axial through the Ø38 mm center opening; radial through the 3 mm standoff gap between the fan face and the plate.
- Render review: passed for the flat plate, centered Ø38 opening, four bored corner posts standing in the standoff, and the posts trimmed off the opening rim.
- Physical fit against the specific case revision/fan, target-printer build volume, and slicer layer-path review: unverified; not yet fabrication-ready.
- Manifest audit: not applicable to this single-part design.

Note: during verification it was found that this host's OpenSCAD build ignores
the vector `center=[...]` form on `cube` (scalar `center=true` works). The
plate is therefore positioned by an explicit `translate([−plate_size/2,
−plate_size/2, ...])` rather than a vector center.

SHA-256 provenance for the verified revision 0001 (2026-09-18):

- Config `rev_0001.json`: `185F27387181AB42FC1052E58CFD9C1C16269EF09B4FDF3FC658EFE88987686B`
- Entrypoint `main.scad`: `48BBE31A9C84100D8277119CA71586DDD3251814866A9AC9E3FA6C925A3D48BD`
- Defaults `defaults.scad`: `6083851D16C6720233D3884CA5E8ADC297C2E98C11A0F7478B6A645F075442E6`
- Part source `fan_guard.scad`: `1F2329572F217D8276E8F664960C6D6D8E29A15588B1BB5CB2FA042E42D9537E`
- Installed STL: `1910AD8F2756CBEF618C2121A7D7C531C10CDF3FC198CFF897243800370BF49B`
