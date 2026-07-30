# Rev 0001 Validation Log

## Geometry

- Assembly contract: PASS; 2 assemblies, 2 printable leaves, 2 interfaces,
  18 governed review views.
- Rack-reference package: PASS for v2.0.0 source hashes, identity, 80
  requirements, and 20 synchronized constants.
- OpenSCAD assertions: PASS for both printable leaves and assembled dispatch.
- Left print bounds: `121.3 x 215.0 x 134.8 mm`.
- Right print bounds: `121.3 x 215.0 x 134.8 mm`.
- Assembled bounds: `254.0 x 215.0 x 121.3 mm`.
- Each leaf and the assembly: simple 3D object, one bounded connected solid plus
  exterior volume in the CGAL report.
- Top/bottom: planar at `Z = +/-60.65 mm`; no seam geometry projects beyond
  either surface.
- Device bay: preserved at `222.25 x 88.90 mm` with maximum 220 mm body proxy.
- Rear wall: closed and continuous.
- Rack openings: twelve present, six canonical blind bores per rail.
- Seam joints: four vertical M3 stacks with recessed exterior heads, internal
  captive nuts, layered flanges, and compression lands.
- Device support: two continuous 3 mm rails at the bay-bottom datum with 3 mm
  device-footprint and side-wall overlaps.

## Artifact Pipeline

- Complete build: PASS and atomically installed at `output/cyberdeck-2/`.
- Printable exact set: 2 STL + 34 PNG = 36 modeled artifacts.
- Printable audit: PASS; no missing, unexpected, stale, duplicate, or
  hash-mismatched artifact.
- Assembly review: PASS; exact set is 18 PNG + 1 combined STL = 19 review
  artifacts, with no missing, unexpected, stale, or hash-mismatched artifact.
- Combined STL destination:
  `.tmp/scad/cyberdeck-2/assembly-review/cyberdeck_2_assembled.stl`.

Exact provenance and artifact hashes are recorded in
`rev_0001_assembly_review.md`.

## Unverified Claims

No supported slicer was used, so layer paths, supports, bridging behavior, and
print-time behavior are unverified. Insert fit, nut fit, joint fit, rail contact,
specific-device fit, load capacity, shock behavior, thermal behavior, and
long-term creep require coupons or a physical candidate. This revision is a
verified geometric candidate, not a fabrication-ready release.
