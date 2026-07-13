# Cyberdeck Revision 0006 Compact Body Plan

*Status: Implemented — slicer gate unverified*

## Objective

Create a new cyberdeck iteration whose main body ends at the existing left edge of the screen structure, removes the dome zone, left-front opening/cover, and Raspberry Pi side-tray system, and relocates the two-piece division next to the Orange Pi tray to minimize unused internal space while preserving a structurally closed enclosure.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Baseline and Boundary Assumption

- Base the iteration on `designs/cyberdeck/configs/rev_0005.json` and the current cyberdeck source tree.
- Create `designs/cyberdeck/configs/rev_0006.json`; do not modify an immutable prior revision.
- Interpret "the edge of the screen structure on the left side" as `chamber_display_wedge_left_x()`, currently approximately assembled `x = -67.5 mm`.
- Make that datum a named compact-body boundary instead of duplicating its coordinate.
- Replace the current assembled `x = 0` division with a named split datum derived from the installed Orange Pi tray envelope plus its required service clearance, fastener clearance, structural wall thickness, and minimum internal edge width.
- Keep the complete Orange Pi tray and its opening on one printable half; the new division must not intersect the tray, its insertion path, mounting pads, backplate, exhaust route, or required cable/service volume.
- Obtain approval for this interpretation before changing geometry. If the intended boundary is the visible screen cutout rather than the display housing/wedge edge, revise this plan first.

## Intended Scope

Remove from the rev_0006 main assembly:

- The body volume left of the display structure.
- The dome roof, dome opening, dome fastener pattern, and dome-support region.
- The left-front compartment opening and its support frame.
- The left-front lid introduced in rev_0005.
- The left-side carrying handle and its chamber mounting features.
- Dome bucket and gimbal content from current assembly/mockup exports.
- The Raspberry Pi side tray, its side-wall opening, backplate seat, mounting holes, rails/supports, and associated proxy geometry.

Preserve unless geometry dependencies require a documented adjustment:

- The complete screen structure and display mounting geometry.
- The center and right front openings and covers.
- The removable rear-roof I/O panel.
- The Orange Pi tray system, including its insertion/service envelope and exhaust route.
- Wiring routes, cooling features, and the right exterior wall, except where the removed Raspberry Pi opening must be restored to continuous solid wall geometry.

## Atomic Implementation Plan

1. Create the rev_0006 config from rev_0005 and give it a rev_0006 output name.
2. Introduce named dimensions/functions for the compact body's left boundary, right boundary, and resulting assembled width.
3. Inventory the Orange Pi tray's complete installed, insertion, fastener, exhaust, wiring, and service envelope. Derive the new split position from the closest compliant plane beside that envelope rather than assigning an arbitrary coordinate.
4. Recalculate both printable half envelopes from the compact left boundary, tray-derived split, and right exterior boundary; assert that each complete part remains inside the configured `220 mm x 220 mm x 220 mm` print volume.
5. Refactor the chamber construction so the final main body starts at the display structure's left edge and divides at the new split without leaving zero-thickness or coincident geometry.
6. Relocate the paired joining walls, bolts, passthroughs, reinforcement, and related labels/assembly references from `x = 0` to the named split datum.
7. Add a new minimum-thickness left end wall that deliberately intersects the floor, front wall, rear/screen housing, and roof members by at least `minimum_structural_overlap` across every intended seam.
8. Remove dome and left-opening cuts, rails, fastener holes, passthroughs, labels, and handle mounting cuts that no longer belong to the compact body.
9. Remove the Raspberry Pi side tray and all geometry that exists only to receive it. Restore its exterior opening to a continuous wall and remove obsolete tray fastener and support cuts rather than merely hiding the separate tray export.
10. Update visual mockup, top-layout, internal-hardware, complete-structure, chamber, and removable-panel layout modules to use the compact envelope, relocated division, and revised hardware inventory.
11. Update the authoritative part manifest so the current complete build excludes obsolete left-lid, handle, dome bucket, dome-gimbal, and Raspberry Pi tray artifacts. Retain historical source modules unless removing them is separately approved.
12. Add or update dimensional assertions for the compact envelope, tray-derived split, restored Raspberry Pi wall, and every changed structural or cut-clearance contract.
13. Update `designs/cyberdeck/README.md` with rev_0006 scope, dimensions, split datum and rationale, removed features, part-set changes, and exact verification status.
14. Build and audit the complete rev_0006 manifest, inspect structural sections, and record results.

## Structural Contract

The existing design minimums remain authoritative:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

Required join inventory for this change:

- New left end wall to floor.
- New left end wall to front wall.
- New left end wall to rear/display housing.
- New left end wall to every roof or upper frame member that terminates there.
- Any screen support, rail, web, or mounting land newly terminated at the compact boundary.
- Relocated joining wall on each printable half to its floor, front wall, rear/display housing, roof, rails, and reinforcement.
- Relocated bolt lands, passthrough rims, and seam reinforcement to their receiving walls.
- Restored solid wall across the former Raspberry Pi side-tray opening and its transitions into surrounding wall material.

Required post-subtraction inventory:

- Screen recess and mounting holes near the new left wall.
- Rear-roof I/O opening and support structure near the new boundary.
- Center/right lid openings and their rails.
- Orange Pi tray opening, backplate fasteners, exhaust route, insertion path, and service envelope relative to the relocated division.
- Relocated joint bolts and passthroughs relative to one another, the Orange Pi tray system, screen structure, floor, roof, and exterior boundaries.
- Former Raspberry Pi opening, mounting holes, and support cuts; verify that no residual void, thin patch, or disconnected feature remains after their removal.
- Wiring, relocated-joint, fan, and service cutouts whose bounds could approach the new end wall or new split.
- Every applicable cut-to-cut pair in a shared wall, rail, flange, or web.

Each changed seam must retain at least 3 mm of positive-volume engagement and a minimum 3 mm post-subtraction throat for its complete intended length. Every remaining edge or ligament must be at least 3 mm wide.

## Part-Manifest Review

The implementation should classify every existing part as retained, changed, or removed from the current manifest. The expected removals are:

- `cyberdeck_left_front_lid`
- `cyberdeck_left_side_handle`
- `cyberdeck_dome_bucket_insert`
- `cyberdeck_dome_pan_servo_cradle`
- `cyberdeck_dome_pan_rotating_plate`
- `cyberdeck_dome_tilt_servo_yoke`
- `cyberdeck_dome_camera_laser_carriage`
- `cyberdeck_dome_gimbal_clearance_mockup`
- `cyberdeck_right_chamber_rpi_side_tray`

The exact expected STL and PNG counts must be calculated from the approved final manifest before building. Do not treat an output directory as complete until its `build_manifest.json` passes `--audit-only`.

## Verification Plan

1. Run OpenSCAD assertions for every manifest part under the exact rev_0006 config.
2. Build the complete manifest with:

   ```text
   python scripts/scad_build_all.py --design cyberdeck --config designs/cyberdeck/configs/rev_0006.json
   ```

3. Audit `output/cyberdeck` with `--audit-only`.
4. Create the immutable `revisions/cyberdeck/rev_0006/` snapshot using the repository revision workflow and audit it independently.
5. Inspect final-Boolean sections normal to every changed seam at its start, midpoint, end, corners, and nearby cutouts, including the complete relocated division and restored former Raspberry Pi opening.
6. Inspect minimum material around all nearby holes, openings, recesses, rails, and webs, with explicit checks between the relocated joint features and the complete Orange Pi tray envelope.
7. Audit exported STL connectivity and reject unexpected disconnected positive-volume shells.
8. Review slicer layers through the new left end wall and its joined members in the intended print orientation.
9. Record exact source/config provenance, expected and actual artifact counts, audit results, and structural results in the design README.

## Completion Criteria

- The assembled main body begins at the approved screen-structure boundary.
- No dome, left-front opening, left lid, or handle geometry remains in rev_0006 assembly exports.
- No Raspberry Pi tray, side opening, mounting cut, or tray-only support remains in rev_0006 assembly exports; the affected exterior wall is continuous.
- The printable-body division is located at the nearest structurally compliant plane beside the Orange Pi tray envelope, with no unnecessary empty strip intentionally retained between them.
- Both resulting enclosure halves fit within the configured print volume and retain serviceable Orange Pi tray insertion, wiring, exhaust, and fastener access.
- The new left end is a closed, printable structural boundary rather than a crop exposing cavities or terminating members.
- Structural assertions, sectional review, post-subtraction review, minimum-edge review, connectivity review, and slicer review pass for the changed geometry.
- The complete output and immutable revision manifests both pass artifact and provenance audits.
- Documentation matches the implemented source, config, manifest, and verification evidence.

## Approval Gate

The user approved this plan, including the left boundary at `chamber_display_wedge_left_x()`, the Orange-Pi-envelope-derived split strategy, and removal of the complete Raspberry Pi side-tray system and opening.

## Implementation Result

- Compact assembled envelope: `260 mm x 210 mm x 120.175 mm`, plus `2 mm` rear fan spacer projection.
- Calculated split: assembled `x = 136.4 mm`, `3 mm` beyond the Orange Pi tray backplate envelope.
- Printable body sections: `203.95 mm x 212 mm x 120.175 mm` and `56.15 mm x 212 mm x 120.175 mm`.
- Current manifest: eight parts; expected and actual counts are `8` STL, `136` PNG, and `144` modeled artifacts.
- Current and immutable rev_0006 artifact audits: passed.
- Enclosure connectivity: passed; each chamber STL is manifold and contains one connected triangle component.
- Changed-geometry assertions, sections, post-subtraction review, and minimum-edge review: passed.
- Slicer layer review: unverified because no supported slicer was installed.
- Overall structural status: unverified pending the slicer gate; do not treat rev_0006 as print-ready yet.
