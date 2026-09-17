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
- Exterior envelope: 76 mm wide x 45 mm deep x 45 mm tall.
- Wall thickness and floor thickness: left wall and floor 3 mm each; right (fan) wall 6 mm at `x = 70..76`; back wall 3 mm at `y = 42..45`.
- Dual-chamber divider band: 3 mm slab at `z = 15..18`, spanning `x = 0..76` and `y = 3..45` from the open front into the back and right walls, with a front-left cable notch `x = 0..8`, `y = 3..13`. Its right end merges into the 6 mm right wall, giving a 6 mm seam overlap at `x = 70..76`.
- Left-wall windows, effective after lip tightening: micro-SD `y = 6.5..40.5`, `z = 18..42` (34 x 24 mm, bottom edge flush with the divider top); battery exit `y = 6.5..40.5`, `z = 3..15` (34 x 12 mm, sitting on the internal floor and closed at the divider).
- Retention lips add no geometry: each window cut is tightened by `lip_width` (1.5 mm) on its leading and trailing edges, so the remaining material forms a shelf flush with the outer left face (`x = 0`). Nothing projects outside the 76 x 45 x 45 mm envelope.
- Right-wall fan interface, centered at `y = 22.5`, `z = 22.5` (the exact 45 mm wall midpoint on both axes): Ø38 mm through air opening (spanning 3.5..41.5 on both axes, a 3.5 mm ring to every outer edge) plus four Ø4.2 mm mount holes on a 32 mm pitch (stations `y, z = 6.5/38.5` on both axes). The air opening spans the divider band, so one shared channel feeds both chambers.
- Screw head seats (R3, blind): Ø6 mm seats 3 mm deep, cut in +x from the internal right-wall face (`x = 70`) at each mount station and stopped at `x = 73`, leaving 3 mm of solid wall behind each seat floor (asserted at or above the 3 mm minimum internal edge width); M3-class mounting heads sit flush with the internal face. The Ø4.2 mm mount holes are through-bores across the full 6 mm wall, so screw shanks exit at the outer face.
- Perimeter rings (all asserted): Ø4.2 mount-hole rings are ≥ 4.4 mm to every open/outer edge (front, back, bottom, top); Ø6 seat rings are ≥ 3.5 mm to the open front, bottom, and top edges and 3.5 mm to the outer back (0.5 mm of right-wall material plus the full 3 mm back wall).
- Documented user-approved ligament exceptions (the Ø38 bore's edge is 16√2 mm away on the diagonal from the front-left station centers): the bore-to-seat diagonal ligament is 16√2 − 19 − 3 = 0.63 mm (asserted ≥ 0.6), and that station's mount-hole ring to the seat rim is 16√2 − 19 − 2.1 = 1.53 mm (asserted ≥ 0.6).
- Documented non-structural relaxation: at the fan air chord the divider's front right leg is a 1.04 mm sliver (asserted ≥ 1.0); the divider's primary supports are the left wall and the back wall, both at the 3 mm minimum structural overlap. The divider's back right leg is 4.04 mm (asserted ≥ 3).

### Revision 0003 candidate artifact verification - 2026-09-14 (R3, supersedes the R2 record)

- Source revision/config: mutable `rev_0003` candidate / `configs/rev_0003.json`; `rev_0001.json` and `rev_0002.json` remain unchanged (older configs keep working through `defaults.scad` fallbacks).
- Build scope and destination: one printable part built with `scripts/scad_build.py` into `output/micro_cyberdeck_case/`.
- Expected/actual artifacts: 1/1 STL and 17/17 PNG files; 18 total files, no directories or staged `.scad` files.
- Build log: zero OpenSCAD warnings or errors; all dimension, margin, lip, fan-wall, and blind-seat assertions passed.
- STL bounds: `[0, 0, 0]` to `[76, 45, 45]` mm, a 76 x 45 x 45 mm span.
- Signed STL volume: 32,423.77 mm³ across 1,872 triangles. The exporter reports `Volumes: 2`; this is a known, user-accepted export characteristic of this design and is not chased.
- Installed render review: passed for the 76 x 45 x 45 mm envelope, the 6 mm right (fan) wall, both left-wall windows with flush shelves, the divider band reaching the right wall, and the right-wall fan opening.
- Numeric STL verification (repo-external temporary probes: 3D point-in-solid parity plus 2D constant-x planar slices, deleted after review): passed. Per mount station (y,z = 6.5/38.5 on both axes) the Ø6 seats read void at x = 71.5 and solid at x = 74.5, with the seat-floor boundary confirmed void at x = 72.99 and solid at x = 73.01; the Ø4.2 holes read void at x = 71.5, through x = 74.5, and just behind the seat floor; the Ø38 bore read void at the fan centre and at four azimuth radii at both x = 71.5 and x = 74.5; corner lands, the wall top/front/bottom margins, the divider slab, and the cavity read as expected; no front-edge breach.
- Structural joins: passed for all wall/floor, rear-corner, and divider joins; the divider-to-right-wall seam is now a 6 mm overlap at x = 70..76 (at least the 3 mm minimum), including the documented exceptions: the 1.04 mm non-structural divider front-right sliver (asserted ≥ 1.0) and the user-approved 0.63 mm bore-to-seat diagonal ligament (asserted ≥ 0.6).
- Minimum internal edge/material width: passed against the 3 mm minimum for all named members except the two documented exceptions above; the 3 mm of solid behind each blind seat floor satisfies the rule at that location.
- Supersession: this record replaces the R2 candidate artifact (3 mm right wall, Ø6 seats flush with the outer face at x = 73, 73 x 45 x 45 envelope, 29,914.68 mm³ / 1,296 triangles), which no longer matches the source. The R1 false-record correction quoted in the superseded R2 record remains in effect.
- Thermal behavior: unverified.
- Physical fit (fan flange, micro-SD card, battery), target-printer build volume, and slicer layer-path review: unverified; this candidate is not yet fabrication-ready.
- Manifest audit: not applicable to this single-part design.

SHA-256 provenance for the verified revision 0003 candidate (R3, 2026-09-14):

- Config `rev_0003.json`: `20FB8EEE48C93745E3605E7BC9BFE6288851B6C97BD72B53A697493BE46E0FE5`
- Entrypoint `main.scad`: `20B10F91D42D4D880944F6917BAEE1D11A116B410D2F93943937227FFEEE8118` (unchanged since R2)
- Defaults `defaults.scad`: `2BF18E53F637977C89E7D6E2D9849C9ACEAA55362E1ECF2D971A44AC5345CAAE`
- Part source `case_body.scad`: `52867E0A897B3D698E6FD1C4E0BEDB72BA8F1A2406C545BC28130C5181CCA4E9`
- Installed STL: `589CBC6AB9332E642CE3A0BD6D5C4179BD49C32EB5DA6672F586531DEA43FED7`

#### Superseded R2 record - 2026-09-14 (3 mm right wall, seats flush with the outer face)

Retained for history only; its artifact no longer matches the source.

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

SHA-256 provenance for the R2 candidate (superseded):

- Config `rev_0003.json`: `EF97BEF0996F539FD15552A2A08D41256C06615BDF7E57E4C4D3CCC445453EC8`
- Entrypoint `main.scad`: `20B10F91D42D4D880944F6917BAEE1D11A116B410D2F93943937227FFEEE8118`
- Defaults `defaults.scad`: `37BB9E4A61241FF5E1C2B1ABA63A902347AE0475A3FD96FFA34EDD946220CCBA`
- Part source `case_body.scad`: `4AE33EB504B45BB5736CA6FD6D9420C511C33BFCB3008367C423C6FF7142129B`
- Installed STL: `F7624F3A8AE1D43C814CABAF8BA68C692D5D485C71B601D5A1C6607342A681BA`

## Revision 0004 dimensions, back-wall rail, and left top-band extension

- Left-wall top band (R4 amend, 2026-09-16, user-directed): the solid band of the left wall directly above the micro-SD (upper) window - `x = 0..3`, full wall width `y = 0..45`, `z = 42..45` (window top to the rim) - extends 1 mm into the cavity, so its internal face moves `x = 3` -> `x = 4` and the band is 4 mm thick where it crosses the top opening. It is a flat retention ledge with no expected load path; its 1 mm shelf thickness is a user-directed documented exception to the 3.0 mm `minimum_internal_edge_width` (asserted at a 1.0 mm floor in `case_body.scad`).
- Back-wall rail (R4): a horizontal 3 mm (y) x 3 mm (z) section running `x = 8..65` (a 57 mm span) across the back wall's internal face, 5 mm in from each internal side wall face and with its top 5 mm below the case rim (`z = 37..40`).
- One solid cube: 3 mm deep ledge `y = 39..42` in front of the back-wall internal face, plus a through-wall tenon `y = 42..45` spanning the full 3 mm back-wall thickness, flush with the rear outer face (`y = 45`). The tenon provides 57 mm of continuous structural engagement across the rail-to-wall seam.
- New material: the rail ledge, 57 x 3 x 3 = +513.000000 mm³ (the tenon volume already existed as back wall), plus the left top-band shelf, 1 x 42 x 3 = +126.000000 mm³ (its `y = 42..45` portion already exists as back wall): +639.000000 mm³ versus revision 0003. No envelope change: the body spans exactly `[0, 0, 0]` to `[76, 45, 45]` as in R3.
- No cut intersects the rail band (`x = 8..65`, `y = 39..45`, `z = 37..40`) or the left top-band shelf (`x = 3..4`, `y = 0..45`, `z = 42..45`): the left-wall windows/exit are at `x = 0..3` and the upper (micro-SD) window top is flush with the shelf bottom at `z = 42`, the divider top is `z = 18` (24 mm below the shelf bottom and 19 mm below the rail bottom), the fan air opening, seats, and mount holes are in the right wall only (`x = 70..76`) or in the `z <= 41.5` fan-wall band (asserted by the rail clears-the-divider check at the shared `z` limits). The shelf tip (`x = 4`) is 4 mm clear of the rail start (`x = 8`) and clears the rail band in `z` as well (shelf `z = 42..45`, rail `z = 37..40`).

### Revision 0004 candidate artifact verification - 2026-09-16 (R4, 3 x 3 mm cross-section + 1 mm left top-band extension, supersedes the R3 record as current candidate; amended in place the same day)

- Source revision/config: mutable `rev_0004` candidate / `configs/rev_0004.json` (now also declaring `top_band_extension_enabled: true` and `top_band_cavity_extension: 1.0`); `rev_0001.json`, `rev_0002.json`, and `rev_0003.json` remain unchanged (older configs keep working through the `is_undef` fallbacks in `defaults.scad`, so `rail_enabled` and `top_band_extension_enabled` are false for them and their geometry is byte-identical to before).
- Build scope and destination: one printable part built with `scripts/scad_build.py` into `output/micro_cyberdeck_case/`.
- Expected/actual artifacts: 1/1 STL and 17/17 PNG files; 18 total files, no directories or staged `.scad` files.
- Build log: zero OpenSCAD warnings or errors; all dimension, margin, lip, fan-wall, blind-seat, divider, rail, and top-band assertions passed (OpenSCAD: 936 vertices, 470 facets at export; `Volumes: 2` reported as usual for this design).
- STL bounds: `[0, 0, 0]` to `[76, 45, 45]` mm, a 76 x 45 x 45 mm span.
- Signed STL volume: 33,062.77 mm³ across 1,900 triangles; exact +639.000000 mm³ versus revision 0003 (32,423.77 mm³ recorded in the R3 record above) - the 57 x 3 x 3 rail ledge (tenon already interior to the back wall) plus the 1 x 42 x 3 left top-band shelf (its `y = 42..45` portion already interior to the back wall) - and exactly +126.000000 mm³ versus the pre-amend `13b2ed0` commit's mesh (32,936.77 mm³). The exporter reports `Volumes: 2`; this is a known, user-accepted export characteristic of this design and is not chased.
- Installed render review: passed for the 76 x 45 x 45 mm envelope, the left top-band shelf (1 mm step at `z = 42..45` above the upper window, visible along the full width inside the cavity), the back-wall rail (57 mm ledge band `z = 37..40` on the back-wall internal face, flush rear tenon), both left-wall windows, the divider band, and the right-wall fan interface.
- Numeric STL verification (repo-external temporary probe script, deleted after review): passed. On the amended mesh, STL bounds `[0, 0, 0]` to `[76, 45, 45]`, signed volume 33,062.7732 mm³ across 1,900 triangles - exact +126.000000 mm³ (= 1 x 42 x 3, the shelf) versus the STL extracted from `13b2ed0` (1,888 triangles, 32,936.7732 mm³). A 3D construction-model ray-parity check matched 8/8 on the amended mesh: solid at the shelf core `(3.5, 22.5, 43.5)`, the shelf front strip `(3.5, 1.5, 43.5)`, the shelf/back-wall corner `(3.5, 43.5, 43.5)`, and the left wall under the shelf face `(2.5, 22.5, 43.5)`; void at `(4.5, 22.5, 43.5)` beyond the `x = 4` tip, at `(3.5, 22.5, 41.0)` inside the upper window below the band, and at `(22.5, 22.5, 43.5)` in the cavity; the rail-ledge regression point `(36.5, 40.5, 38.5)` reads solid. On the extracted `13b2ed0` mesh, a 4-point contrast check confirmed the pre-amend state: void exactly at the shelf core (the new material is absent), solid at the back-wall corner, the left wall, and the rail ledge.
- Governed temporary section probes (temporary `.scad` under `output/micro_cyberdeck_case/` instantiating the production body module with exactly the config's defines, rendered, viewed, and removed with its PNGs): (a) horizontal section at `z = 43.5` - top-down ortho - shows the left wall's top band as one continuous 4 mm strip spanning the full wall width into the back-wall corner with no seam gap, and the right (fan) wall unchanged; (b) constant-`y` section at `y = 22.5` - front ortho - shows the left-wall profile: 3 mm wall with the 1 mm shelf step at `z = 42..45` (internal face `x = 4`), both windows below it (`z = 3..15` battery exit, `z = 18..42` upper window) untouched, divider band `z = 15..18` and the 6 mm fan wall unchanged; (c) interior iso view (front-right iso on the uncut body) shows the new shelf step inside the cavity along the full width above the upper window. (The rail's own `z = 38.5` / `x = 36.5` / rear-ortho probes from the earlier `13b2ed0` record pass unchanged, as confirmed by the numeric rail-regression checks above.)
- Full-mesh identity check (temporary script, deleted after review): comparing the facet multisets of the STL extracted from `13b2ed0` (1,888 triangles) and the amended rebuild (1,900 triangles), the delta is 25 added and 13 removed triangles; every delta triangle has all three vertices on one of the faces `z = 45` (rim top), `x = 3` (left-wall internal face), `y = 42` (back-wall internal face), `y = 0` (left-wall outer front face, coplanar with the shelf's new front face), or fully inside the shelf box `x = 3..4`, `y = 0..42`, `z = 42..45` - i.e., the shelf plus coplanar re-triangulation of the faces it touches. No facet delta lies outside that envelope.
- Structural joins: passed for all pre-amend joins (the extracted `13b2ed0` mesh and the amended rebuild share 1,875 facets) plus the rail join (unchanged) and the new shelf join. The rail occupies a positive 57 x 3 x 3 mm volume across the full 3 mm back-wall thickness - a `minimum_structural_overlap`-meeting continuous engagement along the entire 57 mm seam, with no cuts in the rail band; asserted (`rail_tenon_rear_y() - back_wall_y() == wall_thickness`, `wall_thickness >= minimum_structural_overlap`). The shelf unites to the left wall over a 45 x 3 mm coplanar-union face (the wall's internal face at `x = 3`, `y = 0..45`, `z = 42..45`) and overlaps the back wall as a solid 3 x 3 mm cross-section at `y = 42..45` - two verified supports meeting the declared `minimum_structural_overlap` across the full seam, with no cuts in the band; it is a flat retention ledge with no expected load path, its bottom face is a 1 mm (1:1) cantilever overhang, printable without supports.
- Minimum internal edge/material width: passed - the rail's 3 x 3 mm section equals the declared 3.0 mm `minimum_internal_edge_width` directly (the earlier documented 2 mm rail-section relaxation is retired, user decision 2026-09-16; asserted `rail_section >= minimum_internal_edge_width`), and every other named member is at or above 3 mm: each internal side-wall face is 5 mm away from the rail ends, the rail-to-rim material is 5 mm, the rail ledge to divider top is 19 mm, the shelf bottom to divider top is 24 mm, and the material behind the rail tenon is 3 mm (the rear wall face itself). One user-directed documented exception: the left top-band shelf is 1 mm thick (internal face `x = 3..4`), deliberately below the 3.0 mm minimum - a flat retention ledge with no expected load path, asserted at its documented 1.0 mm floor in `case_body.scad`.
- Supersession: this record replaces the R3 record as current candidate; the R3 source (`configs/rev_0003.json` and the current source tree) remains buildable unchanged. Exact R3 bytes are no longer reproducible from the current tree: the OpenSCAD ASCII STL exporter emits CRLF line endings on this host (the committed git blob is pure LF, differing only by 13,106 carriage returns) and facet triangle ordering is not deterministic between builds, so a fresh rev_0003 rebuild matches the R3 geometry (same 1,872-triangle surface, identical bounds, 32,423.77 mm³) but not the R3 record's exact file hash.
  - R3 record installed STL `589CBC6AB9332E642CE3A0BD6D5C4179BD49C32EB5DA6672F586531DEA43FED7` was the R3-time on-host working file (CRLF line endings).
  - Committed rev_0003 STL git blob `517c562772df7ed12c28f17cfa7ef52b1b981f2d` (pure LF): SHA-256 `9394C2D6CA39A72D5E244C295F2FEC90D276155F0F55948878CC17594E0D7F26`.
  - Rev_0003 rebuilt from the current (post-3 x 3 amend) source tree: facet multiset identical to the committed R3 blob's facet multiset (1,872 facets). On-disk bytes (CRLF): SHA-256 `6DBCB2204BEC138E5804A40829188DA98AFFF65A7DA7E1CA6785992446C65D6B`; identical geometry after CRLF-to-LF normalization: SHA-256 `D4FF6F70CE026D9D7A2882E8F16420E93FEA331F36275CAFDC553E59196C7624`.
- Thermal behavior: unverified.
- Physical fit of whatever mounts on the rail, target-printer build volume, and slicer layer-path review: unverified; this candidate is not yet fabrication-ready.
- Manifest audit: not applicable to this single-part design.

SHA-256 provenance for the verified revision 0004 candidate (R4 + left top-band extension amend, 2026-09-16):

- Config `rev_0004.json`: `B78D381EB6A145FF81700D5466412A9248EE2E9DAF2FE42D11E25F87DB518B60`
- Entrypoint `main.scad`: `20B10F91D42D4D880944F6917BAEE1D11A116B410D2F93943937227FFEEE8118` (unchanged since R2)
- Defaults `defaults.scad`: `2DF3A3E37B5F605A19308F4AF7CA037568363C110BD00B27B8C495E611B0C72A`
- Part source `case_body.scad`: `B1A30BBB6ABA4F1C444A7B54988C1D1D3A8B169A29F63B249305AB97ACDAC9AE`
- Installed STL: `192AF9C4A49CF33420A6EC94AB7D6E438DA33782D1F86D3957B37779C5347E8C`

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
python scripts/scad_build.py --design micro_cyberdeck_case --config designs/micro_cyberdeck_case/configs/rev_0004.json
```

Generated scratch artifacts are installed under `output/micro_cyberdeck_case/`.
