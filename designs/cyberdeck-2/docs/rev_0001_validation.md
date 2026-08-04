# Rev 0001 Validation Log

## Geometry

- Assembly contract: PASS; 2 assemblies, 2 printable leaves, 2 interfaces,
  23 governed review views.
- Rack-reference package: PASS for v2.0.0 source hashes, identity, 80
  requirements, and 20 synchronized constants.
- OpenSCAD assertions: PASS for both printable leaves and assembled dispatch.
- Left print bounds: `124.5 x 215.0 x 127.0 mm`.
- Right print bounds: `124.5 x 215.0 x 134.8 mm`.
- Assembled bounds: `254.0 x 215.0 x 124.5 mm`.
- Each leaf and the assembly: simple 3D object, one bounded connected solid plus
  exterior volume in the CGAL report.
- Top/bottom: planar at `Z = +/-62.25 mm`; no seam geometry projects beyond
  either surface.
- Device bay: preserved at `222.25 x 88.90 mm` with maximum 220 mm body proxy.
- Rear wall: closed and continuous.
- Rack openings: twelve present, six canonical blind bores per rail; continuous
  3 mm front fascia above and below the opening ties both rails into the frame.
- Seam joints: four vertical M3 captured tongue-and-socket stacks with recessed
  exterior heads, internal captive nuts, 3 mm socket walls, and 1 mm fit
  clearance on every non-insertion face.
- Seam openings: PASS in four dedicated installed-artifact crops; all four
  head recesses are complete circles and all four nut recesses are complete
  hexagons with centered through-passages. No owning-shell material occludes
  the openings.
- Device support: two continuous 3 mm rails at the bay-bottom datum with 3 mm
  device-footprint and side-wall overlaps.

## Artifact Pipeline

- Complete build: PASS and transactionally installed at `output/cyberdeck-2/`.
- Printable exact set: 2 STL + 34 PNG = 36 modeled artifacts.
- Printable audit: PASS; no missing, unexpected, stale, duplicate, or
  hash-mismatched artifact.
- Assembly review: PASS; exact set is 23 PNG + 1 combined STL = 24 review
  artifacts, with no missing, unexpected, stale, or hash-mismatched artifact.
- Unified output: PASS; exactly 3 STL + 57 PNG + 2 manifests = 62 files, with
  no subdirectories or undeclared files.
- Combined STL destination:
  `output/cyberdeck-2/cyberdeck_2_assembled.stl`.

Exact provenance and artifact hashes are recorded in
`rev_0001_assembly_review.md`.

## Unverified Claims

No supported slicer was used, so layer paths, supports, bridging behavior, and
print-time behavior are unverified. Insert fit, nut fit, joint fit, rail contact,
specific-device fit, load capacity, shock behavior, thermal behavior, and
long-term creep require coupons or a physical candidate. This revision is a
verified geometric candidate, not a fabrication-ready release.

## Angled Screen Checkpoint (Latest Mutable Candidate)

- Assembly contract: PASS; 3 logical assemblies, 2 printable leaves, 3
  interfaces, and 26 governed review views.
- Screen interface: PASS geometrically; 45 degrees, exact face-local 2U
  `222.25 x 88.90 mm` aperture, and two six-hole M3 rail columns.
- Rear envelope: PASS geometrically; the 50.8 mm normal clearance projects to
  but does not exceed the existing `Y = 0` back datum.
- Support joins and minimum internal material: PASS geometrically; all named
  screen rail, side-wall, and chassis engagement dimensions are at least 3 mm.
- Combined assembled STL: bounds `[-127, 0, -62.25]` to `[127, 215, 125.112]`;
  span `254 x 215 x 187.362 mm`.
- Print-oriented leaf spans: left `187.362 x 215.0 x 127.0 mm`; right
  `187.362 x 215.0 x 134.8 mm`, each within the `220 mm - 5 mm` reserved axis.
- Complete printable build: PASS; `2 STL + 34 PNG = 36` artifacts.
- Full artifact-bound assembly review: PASS; `1 STL + 26 PNG = 27` artifacts.
- Unified exact output: PASS; `3 STL + 60 PNG + 2 manifests = 65` files, with
  no subdirectories or undeclared files.

Current build provenance: config SHA-256
`c253b18c6e5af89fe0f4b0c05b89ac8d741e5c7bb8c7891855fba78d5c336c30`,
source SHA-256 `de223b2c8fb4a1e8adced2f855aef7d111eb1c333d95ab1b27d58d82d78afea4`,
and combined STL SHA-256
`54a8b88eb20e26bef7252ceb429a4f077344a4f96f7b42e41a08f8c90edd2709`.
The physical screen, panel-mount stack, cable exit/bend, roof/lid, FDM fit, and
load/cycle validation remain `BLOCKED_UNKNOWN`; a representative screen-frame
and insert-fit coupon is required before fabrication release.

## Screen Roof and Lower-Roof Opening Checkpoint

The screen section now has a 3 mm horizontal roof and 3 mm `Y = 0` rear wall.
The lower chassis roof is open beneath it from `Y = 24.0` to `100.732 mm`, across
`X = -124 to +124 mm`; both 3 mm exterior side strips and the rear `Y = 0..24 mm`
seam screw-block zone remain intact. Full review and unified audit passed as
`3 STL + 62 PNG + 2 manifests = 67 files`; combined STL SHA-256 is
`0132c39a33c7f7b1a863afda6feb49efc999a7381995c603ac8aa2c26d096bc4`.

## Top 2U Port/Button Plate Checkpoint

- Complete artifact build: PASS; four printable leaves (two enclosure and two
  127 x 88.90 x 3 mm plate leaves), `4 STL + 68 PNG`.
- Full artifact-bound assembly review: PASS; `1 STL + 31 PNG`.
- Unified output audit: PASS; `5 STL + 99 PNG + 2 manifests = 106 files`.
- Plate interface: 254 x 88.90 mm assembled external envelope, four 3.6 mm M3
  clearances on retained 10 mm roof rails, 3 mm plate/lip material, 3 mm center
  tongue overlap, and 1 mm registration socket clearance.
- Rear seam: PASS geometrically; the plate ends at Y=189.632 while the rear
  M3 head recess/tool envelope begins at Y=195.875.
- Installed artifacts reviewed: `port_plate_roof_opening`,
  `port_plate_split`, and `port_plate_rear_seam_access`.
- Port/button cutouts, physical fastener/tool fit, and FDM clearance remain
  `BLOCKED_UNKNOWN`; this mutable candidate is not fabrication-ready.

## High-Roof and Merged-Opening Checkpoint

- Added a clearance-neutral, in-plane high-screen-roof center interlock: 3 mm
  tongue engagement and 1 mm receiving-socket clearance, with no geometry below
  the pre-existing roof underside.
- Removed the non-structural 3 mm divider between the lower screen clearance
  opening and the port-plate clearance opening. The resulting opening is stepped
  only to retain the 10 mm port-plate side mounting rails.
- Complete printable manifest build: PASS; `4 STL + 68 PNG` in the canonical
  current output. The separate full assembly review is generated after this
  checkpoint and is not a substitute for the remaining seam/height verification.
- The closed-front wall seam relocation, screen-end upper load-path verification,
  and any main-chamber height reduction remain pending.

## 2026-08-04 Interface-Recovery Execution (Unverified Candidate)

- Complete manifest build and both current-output audits: PASS. The installed
  current set is `4 STL + 68 PNG`, and the full review adds `1 STL + 31 PNG`,
  for a unified exact set of `5 STL + 99 PNG + 2 manifests = 106 files`.
- Assembly contract and full artifact-bound review: PASS. The combined STL span
  is `254.0 x 215.0 x 200.09 mm`.
- The screen face rails are now 3 mm deep with canonical six-per-side 3.6 mm
  through-passages; the old 7 mm blind-insert treatment is removed.
- The top plate and fixed roof rails now expose six 3.6 mm positions per side
  (twelve total); rails are 16 mm wide and have local underside nut lands.
- A named 18 mm upper screen service band and a single polygonal lower-to-top
  roof opening are present in the candidate source.
- These passes verify artifact completeness and renderability only. The
  chamber-side screen hardware stack, all new top-plate nut/tool envelopes,
  the high-roof lock, the opening-transition load path, unexpected-shell status,
  and the residual-nub owner remain `UNVERIFIED`; no fabrication-ready claim is
  made from this checkpoint.
