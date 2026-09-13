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
python scripts/scad_build.py --design micro_cyberdeck_case --config designs/micro_cyberdeck_case/configs/rev_0002.json
```

Generated scratch artifacts are installed under `output/micro_cyberdeck_case/`.
