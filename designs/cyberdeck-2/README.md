# Cyberdeck-2 Split 2U Receiver Enclosure

Cyberdeck-2 is a clean design lineage for a standalone enclosure that receives
a generic ten-inch 2U rackmount device. It does not reuse the rejected earlier
Cyberdeck-2 geometry.

## Current Candidate

## Removable Top 2U Port/Button Plate

The remaining flat roof accepts a standard external `254 x 88.90 mm` blank 2U
port/button plate. The printer's 220 mm axis limit requires two printable
`127 x 88.90 x 3 mm` leaves rather than an unprintable monolithic plate. The
left leaf has a 3 mm registration tongue; the right leaf has its matching socket
with 1 mm sliding clearance. The current candidate uses the canonical six
positions per side: twelve M3 clearance holes (`3.6 mm`) in total, through
16 mm-wide roof rails. Local underside nut lands are modeled below each station.
The final low-profile M3 head, nut-retention method, and tool path are still
unverified; do not treat the current geometry as fabrication-ready.

The fixed roof opening is deliberately smaller than the plate: it retains
constant 16 mm side rails from the angled-screen interface through the plate
opening, and a 3 mm margin before the rear seam block. The former tapered
screen-to-plate transition was removed because it left triangular rail-end
remnants in the lower angled-screen M3 envelopes.
The plate spans `Y = 100.732..189.632 mm`; the rear seam screw is centered at
`Y = 200 mm`, and its head recess/tool envelope remains uncovered. The plate is
intentionally blank. Port/button cutouts, hardware, cable bends, service access,
and physical FDM fit remain `BLOCKED_UNKNOWN` pending chosen components.

`configs/rev_0001.json` defines a mutable detailed candidate with:

- one product assembly and one split receiver subassembly;
- exactly two printable leaves, split longitudinally at product `X = 0`;
- a 254 x 215 mm enclosure with a 222.25 x 88.90 mm clear front bay;
- a fully closed, integral 3 mm rear wall;
- six canonical 2U M3 through-bolt passages on each main-chamber rail, with
  chamber-side captive-nut lands;
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

## Angled-Screen Rail Regression and Recovery

### What Happened

The 45-degree angled screen rails were rendered as **solid opaque blocks** with
no visible M3 holes, replacing the previously working 2U rail columns. This
regression was introduced when a full-height `angled_screen_side_infill()`
wedge (a `screen_rack_rear_clearance`-deep × 88.90 mm side-support wall on
each side) was reintroduced into the shell union. The wedge fused with the two
face-local rail columns, making the entire side appear solid and masking all
six M3 passages per side.

### Attempts Made (2026-08-13, before the root-cause diagnosis)

| Attempt | Result |
|---|---|
| Replaced side-support wedges with direct 3 mm rectangular overlaps to the flat chassis side rails | Source-diff review showed the replacement removed the required rail backs/support walls without engaging the actual flat rail. Reverted. |
| Restored end-wall fills; removed only the tapered flat-roof remnants obstructing the two lower M3 stations | User reported the full end-wall fill masked the angled-rail holes and backs again. |
| Removed the full-height `angled_screen_side_infill()` wedge from the shell union | Complete build/audit passed; face-side view showed open aperture. |
| Replaced the two 50.8 mm-deep screen side-support walls with four 3 mm endpoint tabs behind the rails | Visual review showed unsupported protrusions. Reversed. |
| Restored `angled_screen_exterior_side_wall()` as a named 3 mm outer skin | Closed the visible side-profile holes while retaining corrected 3 mm rail-face depth and 8.8 mm nut lands. |

Each attempt passed the complete printable manifest build and installed-output
audit (`4 STL + 68 PNG = 72`), but the rails continued to render as solid
blocks. The circular pattern—build passes, user reports solid, next attempt—repeated
across multiple commits without the holes appearing.

### Root Cause (diagnosed 2026-08-28)

**CGAL boolean precision failure.** The 3.6 mm M3 hole cylinders (r = 1.8 mm)
were being subtracted from a complex polyhedron union that contained 45-degree
rotated faces (the angled screen frame). CGAL's CGAL kernel silently failed to
perform the `difference()` operation on these small cylindrical cutters against
the rotated polyhedral surface—the holes vanished from the rendered STL without
any error or warning from OpenSCAD.

This was confirmed by controlled experimentation: the same cylinder cuts from
a plain axis-aligned box before the 45-degree rotation, and the holes appear
correctly. The failure is specific to the combination of small-cylinder cutters
and non-axis-aligned polyhedral faces in a single boolean operation.

### Resolution: Pre-Cut Approach

The fix moves the M3 hole subtraction to **before** the angled frame is unioned
into the shell:

1. `angled_screen_frame_uncut()` builds the raw frame geometry (rails, side
   walls, nut lands) without any hole cuts.
2. `angled_screen_insert_hole_cuts()` defines the twelve 3.6 mm cylinders in
   the **local coordinate system** of the unrotated frame, where they are
   axis-aligned.
3. `angled_screen_frame()` performs the `difference(frame_uncut, hole_cuts)`
   on the simple, unrotated box-based geometry—where CGAL reliably subtracts
   the cylinders.
4. `shell_master_uncut()` calls `angled_screen_frame()` (already hole-cut)
   rather than `angled_screen_frame_uncut()`, so the holes are preserved
   through the subsequent 45-degree rotation and shell union.
5. `shell_master()` no longer includes the duplicate `angled_screen_insert_hole_cuts()`
   in its difference, since the holes are already present.

User-verified: holes now appear in the rendered STL.

### Known Open Issues (as of 2026-08-28 pause)

| Issue | Status |
|---|---|
| Holes do not pass fully through the 8.8 mm nut lands | Cylinder is `screen_rack_face_rail_depth + 5.0` = 8.0 mm, but nut lands are 8.8 mm deep. Correct fix is `screen_rack_nut_land_depth + 5.0` = 13.8 mm. **Not yet applied** — code still has the old value. |
| Rail front-to-back depth is too thick (50.8 mm) | `screen_rack_rear_clearance` in `rev_0001.json` constrains the side-wall depth to 50.8 mm. User confirmed "too thick" means front-to-back. Candidate reduction to ~25.4 mm is blocked by the active plan constraint and requires plan revision. |
| Full provenance-bound assembly review | Deferred (plan item 4.2 `[?]`) pending targeted rail-face acceptance. |

### References

- **Active plan:** `plans/current/2026-08-13-17-44-00_restore-angled-screen-2u-rails.md`
- **Journal 2026-08-13:** `journal/2026-08-13.md` — full attempt history for the
  solid-rail regression (endpoint tabs, end-wall fills, side-support wedges).
- **Journal 2026-08-28:** `journal/2026-08-28.md` — CGAL root-cause diagnosis,
  pre-cut fix, build/audit, open issues, and pause checkpoint.
- **Governing config:** `configs/rev_0001.json` (overrides `src/lib/defaults.scad`)
- **Geometry source:** `src/parts/enclosure_blockout.scad`
- **Rack standard:** `src/lib/rack_v2_0_0.scad` (19-inch Rack Standard v2.0.0)

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

The complete printable manifest is installed under `output/cyberdeck-2/` first.
After the explicit assembly-review command and audit pass, that same directory
also contains `cyberdeck_2_assembled.stl`, assembly PNGs, and the assembly
review provenance manifest.

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
