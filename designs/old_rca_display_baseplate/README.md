# old_rca_display_baseplate

Display baseplate for a 4-tower `old_rca_building` row, sized for an IKEA Kallax cube footprint target and printable as either one piece or two lengthwise halves.

## Design Intent

- Plate envelope: `325 mm` wide x `210 mm` deep x `4 mm` thick.
- Supports four identical `old_rca_building` tower footprints in an even left-to-right row.
- Each tower location is a recessed locator **pocket** (full interior cut), so tower bases can drop into the recess shape instead of riding on an edge ring.
- The tower row is pushed toward the back edge (`tower_row_back_margin`) to maximize free area in front for future scene/details.
- A front faceplate is now an angled wedge from the front edge.
  - Side profile is a `20 mm x 20 mm` right triangle.
  - The display face is the `45 degree` sloped plane tilted back from the front edge.
- Faceplate quote text is raised from the front face: `"Those things are the old RCA building." -Neuromancer`.
- Part map includes full plate plus split-left/split-right variants for smaller printer build volumes.

## Part Map

- `part_id = 0`: full baseplate
- `part_id = 1`: left half (split at `x = split_x`)
- `part_id = 2`: right half (split at `x = split_x`)

## Orientation

- `-Y` is the front of the display (viewer/faceplate side).
- `+Y` is the back of the display.
- Tower recess geometry is oriented so the tower front faces `-Y`.

## Key Fit Parameters

- `recess_depth = 2.0`
- `recess_clearance = 0.5` (per side)
- `faceplate_h = 20.0`
- `faceplate_run = 20.0`
- `faceplate_text_relief = 0.5`
- `tower_row_side_margin = 8.0`
- `tower_row_back_margin = 2.0`

These defaults place the recesses as far back as practical while keeping a back-edge safety margin.

## Configs

- `configs/rev_0001.json` (full plate)
- `configs/rev_0001_split_left.json`
- `configs/rev_0001_split_right.json`

## Build / Verification

Dry run:

```bash
python scripts/scad_build.py --design old_rca_display_baseplate --config designs/old_rca_display_baseplate/configs/rev_0001.json --dry-run
```

Build full plate:

```bash
python scripts/scad_build.py --design old_rca_display_baseplate --config designs/old_rca_display_baseplate/configs/rev_0001.json
```

Build split halves:

```bash
python scripts/scad_build.py --design old_rca_display_baseplate --config designs/old_rca_display_baseplate/configs/rev_0001_split_left.json
python scripts/scad_build.py --design old_rca_display_baseplate --config designs/old_rca_display_baseplate/configs/rev_0001_split_right.json
```
