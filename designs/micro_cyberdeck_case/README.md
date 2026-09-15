# Micro cyberdeck open-front case

A single-piece blockout for a small cyberdeck case. It has a rectangular floor,
two short side walls, and a back wall. The top and the entire front long face are
open.

## Revision 0001 dimensions

- Nominal equipment envelope: 65 mm wide x 37 mm deep x 37 mm tall.
- Exterior envelope: 71 mm wide x 43 mm deep x 40 mm tall.
- Remaining wall thickness: 3 mm.
- Floor thickness: 3 mm.
- Front floor apron: 3 mm deep; this is the floor area under the omitted front wall.
- Coordinate datum: outer-front-left-bottom corner at `[0, 0, 0]`.

The nominal equipment envelope retains the original four-wall cavity datum:
`x = 3..68`, `y = 3..40`, and `z = 3..40`. Because the front wall is omitted,
the usable open space continues from `y = 3` to the outer front edge at `y = 0`.

## Revision 0002 dimensions and microSD opening

- Nominal equipment envelope: 67 mm wide x 37 mm deep x 37 mm tall.
- Exterior envelope: 73 mm wide x 43 mm deep x 40 mm tall.
- Remaining wall thickness and floor thickness: 3 mm.
- The rectangular opening passes through the left wall and measures exactly 15 mm front-to-back x 10 mm vertically.
- Its center is 22 mm forward from the outer back edge and 12 mm above the internal floor surface: `[x, y, z] = [1.5, 21, 15]` at the wall mid-plane.
- Opening bounds are `y = 13.5..28.5` and `z = 10..20`; the cut passes through `x = 0..3` with a separate 0.01 mm Boolean epsilon beyond each wall face.
- Nominal post-cut margins are 13.5 mm to the front edge, 14.5 mm to the back edge, 7 mm above the internal floor, and 20 mm below the rim.

The opening is an exact nominal access opening. No printer compensation or
functional clearance has been added, so physical microSD card-through fit is
unverified.

### Revision 0002 candidate artifact verification - 2026-09-13

- Source revision/config: mutable `rev_0002` candidate / `configs/rev_0002.json`; `rev_0001.json` remains unchanged.
- Build scope and destination: one printable part built with `scripts/scad_build.py` into `output/micro_cyberdeck_case/`.
- Expected/actual artifacts: 1/1 STL and 17/17 PNG files; 18 total `rev_0002` files, no `rev_0001` files, directories, or staged `.scad` files.
- STL bounds: `[0, 0, 0]` to `[73, 43, 40]` mm, a 73 x 43 x 40 mm span.
- Installed render review: passed for the 67 x 37 x 37 mm nominal equipment envelope, open top, open front, intact floor/apron, and rectangular left-wall opening.
- Opening geometry: passed at exact STL corner coordinates `y = 13.5/28.5` and `z = 10/20`, establishing a 15 x 10 mm through-opening centered at `y = 21`, `z = 15`.
- Parameter and minimum-width assertions: passed for 13.5 mm front, 14.5 mm back, 7 mm above-floor, and 20 mm below-rim post-cut margins.
- Section review: passed for the isolated left-wall opening elevation and horizontal sections immediately below, through the midpoint of, and immediately above the opening. The floor and both rear corners remain continuous after subtraction.
- Connectivity: passed; the installed 48-triangle STL contains one connected component.
- Revision isolation: passed; rebuilding unchanged `rev_0001.json` produces the original 71 x 43 x 40 mm, 28-triangle body without microSD-opening corner vertices.
- Structural joins: passed for all remaining wall-to-floor and rear-corner joins after subtraction.
- Minimum internal edge/material width: passed; the narrowest named material is 3 mm.
- Physical microSD fit, target-printer build volume, and slicer layer-path review: unverified; this candidate is not yet fabrication-ready.
- Manifest audit: not applicable to this single-part design.

SHA-256 provenance for the verified revision 0002 candidate:

- Config `rev_0002.json`: `BEA2A90962873241C220ECA7D028C23046E7B57639D16ABEE64A30D5CFEE1A75`
- Entrypoint `main.scad`: `20B10F91D42D4D880944F6917BAEE1D11A116B410D2F93943937227FFEEE8118`
- Defaults `defaults.scad`: `2C598EF43B90CC5E579DD733AE53A65BECD15ECB775990AA5B499047B4A84287`
- Part source `case_body.scad`: `ABAB84D8B6ECDA5860B205D62C5615ED5798983594311344F81A62D63AE0D242`
- Installed STL: `1BF20919B187E1839332B5537A345A41699AD91150C38DCDDAAD05AEFB2CF153`

## Revision 0003 dimensions, dual-chamber walls, and fan interface

- Nominal equipment envelope: 67 mm wide x 39 mm deep x 42 mm tall.
- Exterior envelope: 73 mm wide x 45 mm deep x 45 mm tall.
- Wall thickness and floor thickness: 3 mm each (right wall `x = 70..73`, back wall `y = 42..45`).
- Dual-chamber divider band: 3 mm slab at `z = 15..18`, running `y = 3..45` from the left wall into the back wall, with a front-left cable notch `x = 0..8`, `y = 3..13`.
- Left-wall windows, effective after lip tightening: micro-SD `y = 6.5..40.5`, `z = 18..42` (34 x 24 mm, bottom edge flush with the divider top); battery exit `y = 6.5..40.5`, `z = 3..15` (34 x 12 mm, sitting on the internal floor and closed at the divider).
- Retention lips add no geometry: each window cut is tightened by `lip_width` (1.5 mm) on its leading and trailing edges, so the remaining material forms a shelf flush with the outer left face (`x = 0`). Nothing projects outside the 73 x 45 x 45 mm envelope.
- Right-wall fan interface, centered at `y = 22.5`, `z = 22.5` (the exact 45 mm wall midpoint on both axes): Ø38 mm through air opening (spanning 3.5..41.5 on both axes, a 3.5 mm ring to every outer edge) plus four Ø4.2 mm mount holes on a 32 mm pitch (stations `y, z = 6.5/38.5` on both axes). The air opening spans the divider band, so one shared channel feeds both chambers.
- Screw head seats: Ø6 x 3 mm blind seats cut in +x from the internal right-wall face (`x = 70`) at each mount station, so M3-class mounting heads sit flush with the internal face. In the current 3 mm right wall the seat depth equals the wall thickness, so each seat is flush with the outer face (`x = 73`) — no material lies radially behind a seat floor. The approved R3 amendment (6 mm right wall, envelope 76 x 45 x 45) turns these into true blind seats with 3 mm of solid behind each seat floor.
- Perimeter rings (all asserted): Ø4.2 mount-hole rings are ≥ 4.4 mm to every open/outer edge (front, back, bottom, top); Ø6 seat rings are ≥ 3.5 mm to the open front, bottom, and top edges and 3.5 mm to the outer back (0.5 mm of right-wall material plus the full 3 mm back wall).
- Documented user-approved ligament exceptions (the Ø38 bore's edge is 16√2 mm away on the diagonal from the front-left station centers): the bore-to-seat diagonal ligament is 16√2 − 19 − 3 = 0.63 mm (asserted ≥ 0.6), and that station's mount-hole ring to the seat rim is 16√2 − 19 − 2.1 = 1.53 mm (asserted ≥ 0.6).
- Documented non-structural relaxation: at the fan air chord the divider's front right leg is a 1.04 mm sliver (asserted ≥ 1.0); the divider's primary supports are the left wall and the back wall, both at the 3 mm minimum structural overlap. The divider's back right leg is 4.04 mm (asserted ≥ 3).

### Revision 0003 candidate artifact verification - 2026-09-14 (R2, supersedes the R1 record)

- Source revision/config: mutable `rev_0003` candidate / `configs/rev_0003.json`; `rev_0001.json` and `rev_0002.json` remain unchanged (older configs keep working through `defaults.scad` fallbacks).
- Build scope and destination: one printable part built with `scripts/scad_build.py` into `output/micro_cyberdeck_case/`.
- Expected/actual artifacts: 1/1 STL and 17/17 PNG files; 18 total files, no directories or staged `.scad` files.
- Build log: zero OpenSCAD warnings or errors; all dimension, margin, and lip assertions passed.
- STL bounds: `[0, 0, 0]` to `[73, 45, 45]` mm, a 73 x 45 x 45 mm span.
- Signed STL volume: 29,914.68 mm³ across 1,296 triangles. The exporter reports `Volumes: 2`; this is a known, user-accepted export characteristic of this design and is not chased.
- Installed render review: passed for the 67 x 39 x 42 mm nominal equipment envelope, open front, open top, divider band, both left-wall windows with flush shelves, and the right-wall fan opening.
- Numeric STL verification (repo-external temporary probes: 3D point-in-solid parity plus 2D constant-x planar slices, deleted after review): passed. All four mount holes, the Ø38 air bore, and the four Ø6 x 3 head seats were confirmed at the true stations (y,z = 6.5/38.5 on both axes; fan center 22.5/22.5); no feature geometry exists at the former (y,z = 7.5/37.5) stations; no front-edge breach.
- Structural joins: passed for all wall/floor, rear-corner, and divider joins, including the documented exceptions: the 1.04 mm non-structural divider front-right sliver (asserted ≥ 1.0) and the user-approved 0.63 mm bore-to-seat diagonal ligament (asserted ≥ 0.6).
- Minimum internal edge/material width: passed against the 3 mm minimum for all named members except the two documented exceptions above.
- Thermal behavior: unverified.
- Physical fit (fan flange, micro-SD card, battery), target-printer build volume, and slicer layer-path review: unverified; this candidate is not yet fabrication-ready.
- Manifest audit: not applicable to this single-part design.
- Correction of the earlier record (same date, R1): the prior verification record in this section stated that the right-wall slice showed "four Ø6 x 3 head recesses". The R1 seat cuts were actually rotated −x (into the cavity air) and were a no-op, so the R1 artifact had no functional head recesses. The rotation fix in this build makes the seats real, and that record is superseded.

SHA-256 provenance for the verified revision 0003 candidate (R2, 2026-09-14):

- Config `rev_0003.json`: `EF97BEF0996F539FD15552A2A08D41256C06615BDF7E57E4C4D3CCC445453EC8`
- Entrypoint `main.scad`: `20B10F91D42D4D880944F6917BAEE1D11A116B410D2F93943937227FFEEE8118`
- Defaults `defaults.scad`: `37BB9E4A61241FF5E1C2B1ABA63A902347AE0475A3FD96FFA34EDD946220CCBA`
- Part source `case_body.scad`: `4AE33EB504B45BB5736CA6FD6D9420C511C33BFCB3008367C423C6FF7142129B`
- Installed STL: `F7624F3A8AE1D43C814CABAF8BA68C692D5D485C71B601D5A1C6607342A681BA`

## Export classification

`part_id = 0` exports the config's named case body, the only printable part.
There are no reference, cutter, preview, or intentionally disconnected exports,
so this single-part design does not use `parts.json` or `assembly.json`.

## Revision 0001 structural verification record

- Source revision/config: mutable `rev_0001` candidate / `configs/rev_0001.json`.
- Minimum wall thickness: 3 mm.
- Minimum structural overlap: 3 mm.
- Minimum internal edge width: 3 mm.
- Join inventory: each of three walls overlaps the floor through its full 3 mm thickness; each side wall overlaps the back wall by 3 mm for the full 37 mm height above the floor.
- Internal edge/material-strip inventory: 3 mm walls, 3 mm floor, and 3 mm front floor apron; no holes, recesses, or other subtractions.
- Intended print orientation: floor flat on the build plate.
- Physical fit, target-printer build volume, and slicer layer-path review: unverified.
- Intentional disconnected geometry: none.

### Candidate artifact verification — 2026-09-12

- Build scope: single printable part built with `scripts/scad_build.py`.
- Build destination: `output/micro_cyberdeck_case/`.
- Expected/actual artifacts: 1/1 STL and 17/17 PNG files; 18 total files and no staged `.scad` files.
- STL bounds: `[0, 0, 0]` to `[71, 43, 40]` mm, a 71 x 43 x 40 mm span.
- Installed render review: passed for the open top, completely open front long face, intact rectangular floor/front apron, three remaining walls, and unobstructed nominal equipment envelope.
- Parameter assertions: passed for the 3 mm walls, floor, wall-to-floor overlaps, rear-corner overlaps, front floor apron, and exterior dimensions.
- Section review: passed through both side-wall/floor seams near the open front and through both rear corners immediately above the floor, at wall mid-height, and at the rim.
- Post-subtraction review: not applicable; the model contains no subtraction operations.
- Connectivity: passed by the positive-volume source construction, continuous section profiles, and a simple CGAL STL export with no unexpected disconnected material.
- Minimum internal edge/material width: passed; every wall, the floor, and the front apron is at least 3 mm thick.
- Slicer layer-path, physical fit, and target-printer build-volume review: unverified; this candidate is not yet fabrication-ready.
- Manifest audit: not applicable to this single-part design. Config/source provenance is recorded below.

SHA-256 provenance for the verified candidate:

- Config `rev_0001.json`: `3F351681B7C4B6281448D51E175FE8215A2B086C83717369A2CDC2068C57A1D3`
- Entrypoint `main.scad`: `20B10F91D42D4D880944F6917BAEE1D11A116B410D2F93943937227FFEEE8118`
- Defaults `defaults.scad`: `8785843BE4386E471EFE635E9CE1E7AA1894CC9A44D14765485A3148C6413D1E`
- Part source `case_body.scad`: `DD2B8D722B02F715AB628D5288ECE0AD35D4FAABF79F3B78FAA70AF0F146134E`
- Installed STL: `46A58999166C0CA6277199EBC7EAC2FD93B61128127F38306497A2A53E63D8FA`

## Build

```powershell
python scripts/scad_build.py --design micro_cyberdeck_case --config designs/micro_cyberdeck_case/configs/rev_0003.json
```

Generated scratch artifacts are installed under `output/micro_cyberdeck_case/`.
