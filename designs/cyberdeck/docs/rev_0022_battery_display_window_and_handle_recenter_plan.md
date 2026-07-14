# Cyberdeck Revision 0022 Battery-Drawer Display Window and Handle-Recenter Plan

*Status: Proposed*

## Objective

Create the next cyberdeck iteration based on `rev_0021` that:

- adds a display-viewing window to the outer wall of the left battery drawer,
- adds a corresponding viewing window through the left chamber outer wall,
- re-centers the left-side handle mounting pattern on that window,
- and preserves the repository structural and minimum-edge contracts around the new side-wall cutouts and relocated handle holes.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Baseline

- Base implementation on `designs/cyberdeck/configs/rev_0021.json`.
- Preserve `rev_0021` as the immutable checkpoint.
- Create a new implementation revision/config rather than editing `rev_0021` in place.

## Requested Geometry

### Battery-display window location

Apply the same nominal viewing rectangle to:

- the battery drawer outer side wall,
- and the left chamber outer side wall behind it.

Requested window envelope:

- depth direction: from `80 mm` to `140 mm` measured from the front wall,
- vertical direction: from `15 mm` to `50 mm` measured above the tray inside floor,
- nominal rectangle size: `60 mm x 35 mm`.

### Handle relocation

- Move the left-side handle mounting pattern so it is centered on the new viewing window.
- Keep the existing handle hardware family and screw pattern unless assertion review proves that a pattern change is required.

## Current Source Findings

### Battery drawer geometry

- The left battery drawer currently has:
  - `3 mm` floor thickness,
  - `3 mm` side-wall thickness,
  - `60 mm` side-wall height above the floor,
  - and `163 mm` total outer floor depth (`160 mm` payload depth + `2 mm` fit clearance + `3 mm` backplate thickness).
- The tray's side walls run the full current drawer depth, so the requested `80 mm` to `140 mm` display zone lands fully inside the existing side-wall span.

### Left chamber spacing

- The left drawer lanes currently retain about `10.5 mm` side margin to the outer chamber wall.
- That means the battery drawer wall and the chamber outer wall are not flush together.
- A matching drawer window and chamber-wall window will therefore create a viewing tunnel across a gap, not one continuous single-thickness opening.

### Current handle datums

- The current handle as a whole is centered at `y = 0`.
- The two handle mounting-plate centers sit at `y = +/-50 mm`.
- Each plate uses a `26 mm x 26 mm` M3 hole pattern, so each screw row/column is offset `13 mm` from its local plate center.
- The handle mount center in Z is currently `chamber_total_z() / 2`.

### Requested window center under current coordinates

- The requested front/back window span (`80 mm` to `140 mm` from the front wall) centers at `110 mm` from the front wall.
- With the left chamber front wall currently at `y = -105 mm`, that places the requested window center at:
  - `y = +5 mm`.
- Under `rev_0021`, the requested vertical span (`15 mm` to `50 mm` above the tray inside floor) centers at:
  - `z = 38.5 mm`.
- The current handle mount center in Z is:
  - `75 / 2 = 37.5 mm`.
- So the existing handle is already nearly vertically centered on the requested display zone; the larger relocation is in Y, not Z.

### Margin check for the requested centered-handle interpretation

- If the existing handle pattern is shifted rearward by `5 mm` so its overall center matches the requested window center:
  - the nearest handle-hole centers fall `7 mm` from the front and rear window edges in the depth direction,
  - and because the handle holes are `3.4 mm` diameter, the actual window-edge to hole-edge material becomes about `5.3 mm`.
- Therefore the current-source interpretation does **not** produce `6 mm` of material from the window edge to each handle-hole set.
- The accurate current nominal value is about:
  - `7 mm` to hole centerline,
  - `5.3 mm` edge-to-edge to the M3 clearance holes.

## Design Intent

The implementation should preserve the basic user request but make the geometry explicit and defensible:

1. keep the requested display-view window size unless assertion review forces a change,
2. keep the current handle hardware family unless the window-to-hole margin proves too weak,
3. center the handle on the viewing window using named datums rather than hand-placed coordinates,
4. and add the structural checks needed so the drawer wall, chamber wall, and relocated handle holes remain within the repository minimum-edge rules.

## Assumptions

Unless the user redirects during implementation:

1. The window should remain a plain rectangular cutout rather than an inset transparent lens pocket.
2. The drawer wall cutout and chamber wall cutout should share the same nominal rectangle unless the chamber-wall structural review requires a smaller outer opening.
3. The current left-side handle part geometry remains unchanged; only the chamber-side mounting-hole positions move.
4. The handle mounting-hole pattern remains the current `26 mm` square per mounting plate unless the required wall margin proves inadequate.
5. Battery retention/alignment features are follow-on work unless implementation proves they are required for the viewing window to make practical sense.

## Atomic Plan

1. Create the next immutable implementation revision/config from `rev_0021`.

2. Inventory the current source datums needed for the change:
   - battery drawer outer side-wall extents,
   - left chamber outer side-wall extents,
   - drawer-to-chamber side gap,
   - handle mount-hole Y and Z datums,
   - handle-hole diameter and plate spacing,
   - and the minimum wall/edge contract.

3. Introduce named parameters for the new battery-display viewing zone:
   - front offset from chamber front wall,
   - rear offset from chamber front wall,
   - bottom offset from the tray inside floor,
   - top offset from the tray inside floor,
   - and any optional corner radius if later desired.

4. Derive explicit helper functions for:
   - window center Y,
   - window center Z,
   - window width/depth span,
   - and the corresponding chamber-side and drawer-side cutout extents.

5. Add the new battery-drawer outer-wall cutout to the drawer part:
   - using the named window datums,
   - and with explicit post-subtraction checks for remaining wall material above, below, ahead of, and behind the cutout.

6. Add the corresponding left chamber outer-wall cutout:
   - aligned to the same viewing zone,
   - and with explicit post-subtraction checks to the chamber edges, drawer opening, and relocated handle holes.

7. Re-center the left chamber handle mounting pattern on the window:
   - derive the new handle mount center from the window center,
   - preserve the existing screw pattern unless structural checks fail,
   - and update any affected handle-hole helper functions to use the new datum.

8. Recompute and assert the critical cut-to-cut and cut-to-edge margins:
   - chamber-wall window to each relocated handle hole,
   - chamber-wall window to chamber front/rear edges,
   - chamber-wall window to chamber top/bottom remaining wall,
   - drawer-wall window to drawer floor and wall terminations,
   - and any local ligament between the chamber-wall window and the battery-drawer front opening geometry.

9. If the current centered-window interpretation still leaves only about `5.3 mm` from the window to the handle holes:
   - decide whether to accept that margin as sufficient under the `3 mm` repository minimum,
   - or shrink/shift the window slightly to restore the preferred larger margin.

10. Update `designs/cyberdeck/README.md` with:
    - the new battery-display window geometry,
    - the new handle mounting datum,
    - and the exact verification status for the changed left-side wall geometry.

11. Build the complete manifest for the new revision and run the artifact audit.

12. Review the exact implementation revision for:
    - chamber-wall window placement,
    - drawer-wall window placement,
    - relocated handle-hole margins,
    - side-wall connectivity,
    - and any new risk created by the window tunnel between the drawer and outer chamber wall.

## Structural Review Requirements

The implementation must explicitly review:

- chamber-wall window to handle-hole ligaments,
- chamber-wall window to front and rear outer-edge ligaments,
- chamber-wall window to top and bottom remaining wall ligaments,
- drawer-wall window to front, rear, top, and floor ligaments,
- and the final side-wall connectivity after both the handle holes and the new window are subtracted.

Repository minimums remain mandatory:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

## Open Questions To Resolve During Implementation

1. Is the current about-`5.3 mm` window-to-hole edge margin acceptable, or should the window be reduced/shifted to recover more material?
2. Should the chamber-side opening exactly match the drawer-side opening, or should the chamber window be slightly smaller to preserve more wall strength around the handle holes?
3. Do we need battery-location features inside the drawer so the display reliably stays aligned to the new window?

## Expected Outcome

If the implementation follows the current source geometry correctly, the likely result should be:

- a battery-display viewing window through both the battery drawer and the outer left chamber wall,
- a left-side handle pattern recentered on that viewing zone,
- a visible display tunnel across the current drawer-to-wall side gap,
- and assertion-backed minimum-edge checks showing whether the requested window size is acceptable as-is or needs a small refinement.
