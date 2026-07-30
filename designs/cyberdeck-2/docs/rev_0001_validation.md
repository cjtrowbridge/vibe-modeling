# Rev 0001 Validation Log

## Geometry

- Assembly contract: PASS; 2 assemblies, 2 printable leaves, 2 interfaces,
  17 governed review views.
- OpenSCAD assertions: PASS for both leaves and assembled dispatch.
- Left print bounds: `121.3 x 215.0 x 130.0 mm`.
- Right print bounds: `121.3 x 215.0 x 127.0 mm`.
- Assembled bounds: `254.0 x 215.0 x 121.3 mm`.
- Each leaf: simple 3D object, one bounded connected solid plus exterior volume
  in the CGAL report.
- Rear wall: closed and continuous in rear orthographic and isometric evidence.
- Rack openings: twelve present, with six canonical positions per rail.
- Seam joints: four present; orthographic sections cover every head recess, lap,
  through-hole, nut recess, and pad root.

## Artifact Pipeline

- Complete build: PASS and atomically installed at `output/cyberdeck-2/`.
- Printable exact set: 2 STL + 34 PNG = 36 modeled artifacts.
- Printable audit: PASS; no missing, unexpected, stale, duplicate, or
  hash-mismatched artifact.
- Assembly review: 17 PNG + 1 combined STL; exact-set audit PASS.
- Combined STL:
  `.tmp/scad/cyberdeck-2/assembly-review/cyberdeck_2_assembled.stl`.

Exact provenance and artifact hashes are recorded in
`rev_0001_assembly_review.md` after the final review render.

## Unverified Claims

No supported slicer was used, so layer paths, supports, bridging behavior, and
print-time behavior are unverified. Insert fit, nut fit, seam fit, specific
device fit, load capacity, thermal behavior, and long-term creep require coupons
or a physical candidate. This revision is a verified geometric candidate, not a
fabrication-ready release.
