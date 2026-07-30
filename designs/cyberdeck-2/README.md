# Cyberdeck-2 Split 2U Receiver Enclosure

Cyberdeck-2 is a clean design lineage for a standalone enclosure that receives
a generic ten-inch 2U rackmount device. It does not reuse the rejected earlier
Cyberdeck-2 geometry.

## Current Candidate

`configs/rev_0001.json` defines a mutable detailed candidate with:

- one product assembly and one split receiver subassembly;
- exactly two printable leaves, split longitudinally at product `X = 0`;
- a 254 x 215 mm enclosure with a 222.25 x 88.90 mm clear front bay;
- a fully closed, integral 3 mm rear wall;
- six canonical 2U M3 insert bores on each front rail;
- continuous top and bottom 3 mm front fascia outside the 2U opening, tying
  both insert rails into the front frame;
- four vertically fastened M3 seam joints recessed flush into the top/bottom,
  with captured sliding tongues, enclosed receiver sockets, and captive nuts;
- two continuous lower rails that support the generic device along its depth;
  and
- outer-side-wall-down print orientations within a 215 mm reserved axis limit.

The generic rack device is a non-printable clearance proxy. The front remains
open for insertion through the exact 2U rectangle; the rear has no openings.
The 124.5 mm rectangular chassis has 17.8 mm service zones above and below the
preserved 2U bay. Each right-leaf 3 mm tongue slides into a left-leaf socket
with 1 mm clearance on every non-insertion face and at its closed end, while
the exterior top and bottom remain planar.

## Build and Review

Use the complete manifest pipeline before the supplementary assembly review:

```powershell
python scripts/validate_cad_assembly_contract.py --design cyberdeck-2 --config designs/cyberdeck-2/configs/rev_0001.json
python scripts/scad_build_all.py --design cyberdeck-2 --config designs/cyberdeck-2/configs/rev_0001.json --destination current --dry-run
python scripts/scad_build_all.py --design cyberdeck-2 --config designs/cyberdeck-2/configs/rev_0001.json --destination current
python scripts/scad_build_all.py --design cyberdeck-2 --config designs/cyberdeck-2/configs/rev_0001.json --destination current --audit-only
python scripts/scad_render_assembly_review.py --design cyberdeck-2 --config designs/cyberdeck-2/configs/rev_0001.json --set full
python scripts/scad_render_assembly_review.py --design cyberdeck-2 --config designs/cyberdeck-2/configs/rev_0001.json --set full --audit-only
```

All current artifacts are installed together under `output/cyberdeck-2/`,
including `cyberdeck_2_assembled.stl`, the two printable leaf STLs, all printable
and assembly PNGs, and both provenance manifests.

## Evidence and Limits

- `docs/rev_0001.md`: candidate scope and readiness
- `docs/rack_and_depth_report.md`: rack conformance and depth budget
- `docs/fastener_and_structure_report.md`: seam stack, margins, and access
- `docs/rev_0001_validation.md`: exact machine and artifact evidence
- `docs/rev_0001_assembly_review.md`: findings-first visual review

This candidate is not fabrication-ready. The exact rack device, heat-set insert,
printer/material/profile, calibrated finished holes, slicer layers, physical fit,
mass, center of gravity, connector/cable service envelopes, and load case remain
unverified.
