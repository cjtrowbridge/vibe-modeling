# Cyberdeck Revision 0014 Left-Chamber Dual Drawer Plan

*Status: Proposed*

## Objective

Add two removable drawer-style trays to the compact cyberdeck's left chamber:

- a front-access battery-bank drawer for a `60 mm x 60 mm x 160 mm` battery pack,
- a rear-access Meshtastic drawer for a provisional `60 mm x 60 mm x 160 mm` LilyGO 1W envelope,
- and a simple internal support structure that stabilizes both drawers and keeps the heavier battery drawer supported from the chamber's right side.

The new drawers should have side walls up to `60 mm` high and an open inner end rather than a closed inner wall.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Baseline

- Base the work on the current compact-body source recorded in `designs/cyberdeck/configs/rev_0013.json`.
- Create a new immutable revision/config for implementation rather than editing a prior revision in place.
- Preserve the current compact outer envelope unless the user explicitly approves a shell-size change.

## Key Feasibility Finding

The current compact body depth is `210 mm`, with approximately `204 mm` of interior depth after the `3 mm` front and rear walls are removed.

Two separate `160 mm` deep drawers cannot both occupy the same front-to-back lane inside that depth:

- front drawer + rear drawer depth demand: `160 mm + 160 mm = 320 mm`
- available internal depth: approximately `204 mm`

Therefore, the only in-envelope approach that matches the current outer shell is to place the two drawers at different heights so their front-to-back envelopes can overlap in plan view without colliding in 3D.

This plan assumes:

- the battery drawer is the lower front drawer,
- the Meshtastic drawer is the upper rear drawer,
- and the two drawers share overlapping Y coverage but remain vertically separated by a structural mid support/shelf.

If same-height front and rear drawers are required, the shell depth must increase or one/both drawers must become materially shorter.

## Design Intent

1. Use the left chamber as a two-level drawer bay.
2. Keep the heavier battery drawer low in the body to reduce cantilever load and center-of-mass rise during carry.
3. Give the battery drawer a right-side internal support surface or rail so its load is not carried only by the left wall near the handle side.
4. Put the Meshtastic drawer at the rear and higher in the chamber so an antenna can mount to the drawer's outside rear wall.
5. Add a simple structural separator between the drawers that also acts as an anti-sway guide and end support.

## Proposed Drawer Architecture

### Battery Drawer

- Access direction: out the front of the left chamber.
- Nominal payload envelope: `60 mm wide x 160 mm deep x 60 mm tall`.
- Proposed location: lower half of the left chamber.
- Tray form:
  - `3 mm` floor,
  - left and right side walls up to `60 mm`,
  - front closure/backplate integrated with the drawer,
  - open inner end.
- Guidance/support:
  - primary support from the chamber floor or low side rails,
  - additional right-side support rail or shelf tied into the chamber's right-side interior structure,
  - stop feature so the drawer cannot over-insert into the screen-side wall region.

### Meshtastic Drawer

- Access direction: out the back of the left chamber.
- Nominal payload envelope: provisional `60 mm wide x 160 mm deep x 60 mm tall`.
- Proposed location: upper half of the left chamber.
- Tray form:
  - `3 mm` floor,
  - left and right side walls up to `60 mm`,
  - rear closure/backplate integrated with the drawer,
  - open inner end.
- Special requirement:
  - outer rear wall should be suitable for an antenna mount once the exact bulkhead/SMA detail is chosen.
- Guidance/support:
  - upper side rails or shelf-guided support,
  - insertion stop and anti-rack features near both ends.

### Shared Internal Support Structure

Preferred baseline:

- one horizontal structural divider/shelf between the upper and lower drawer lanes,
- plus localized front/rear end brackets or short rail segments attached to the chamber side walls.

This support set should:

- separate the two drawer envelopes in Z,
- provide the battery drawer's requested right-side support,
- reduce drawer yaw/racking,
- and avoid adding a full-depth obstruction that blocks the drawers' open inner ends.

## Atomic Implementation Plan

1. Create a new revision config from `rev_0013` and assign the next revision output name.
2. Inventory the left chamber's actual usable internal width, depth, and height after wall thickness, lid rail intrusion, split-wall intrusion, and existing handle-hole region constraints are considered.
3. Add named parameters for the two new drawer payload envelopes, drawer wall thickness, slide clearance, lane heights, divider thickness, support-rail thickness, and insertion-stop depths.
4. Add named functions for the left chamber drawer bay datum system:
   - front opening plane,
   - rear opening plane,
   - lower drawer lane Z range,
   - upper drawer lane Z range,
   - and the overlap-free support/divider geometry.
5. Decide and assert the exact vertical stack:
   - lower battery drawer,
   - upper Meshtastic drawer,
   - with at least `minimum_internal_edge_width` preserved between drawer openings, divider, lid rails, and floor.
6. Model the front battery-drawer opening through the left chamber front wall with a removable drawer backplate/face and explicit material-margin assertions around the cutout and fastener pattern.
7. Model the rear Meshtastic-drawer opening through the left chamber rear wall with a removable drawer backplate/face and explicit material-margin assertions around the cutout and fastener pattern.
8. Add the new internal divider/shelf and end-support brackets or rails as deliberate structural members with named overlap dimensions into the left wall, right-side interior support surface, front wall, rear wall, floor, and any receiving webs they terminate into.
9. Add the battery drawer as a new intentionally separate printed part with:
   - open inner end,
   - side walls to `60 mm`,
   - capture/guide geometry,
   - insertion stop,
   - and right-side load support compatibility.
10. Add the Meshtastic drawer as a new intentionally separate printed part with:
    - open inner end,
    - side walls to `60 mm`,
    - antenna-mount-ready rear exterior wall,
    - capture/guide geometry,
    - and insertion stop.
11. Update any assembly/mockup modules needed to show installed drawer positions and ensure the current split, lid openings, and handle-hole pattern remain coherent with the new left-chamber internals.
12. Update the authoritative part manifest to include the two new drawer exports and any new partial/body exports that are required for the current build.
13. Add assertions for:
    - opening-to-edge margins,
    - opening-to-opening margins,
    - rail/divider/post-cut ligaments,
    - drawer-to-drawer Z clearance,
    - drawer-to-lid and drawer-to-floor clearance,
    - drawer-to-split-wall clearance,
    - and right-side battery-support engagement.
14. Update `designs/cyberdeck/README.md` with the new drawer architecture, assumptions, part-set changes, and exact verification record for the implementation revision.
15. Build and audit the complete manifest, inspect changed sections, and record the structural verification status for the exact new revision/config.

## Structural Contract

The current repository minimums remain mandatory:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

Required new structural-join inventory:

- front battery-opening frame to adjacent front wall material,
- rear Meshtastic-opening frame to adjacent rear wall material,
- divider/shelf to left wall,
- divider/shelf to right-side support structure,
- divider/shelf to front and/or rear support brackets where used,
- any guide rails, lands, or stops attached to chamber walls,
- any reinforcement added near the handle-hole side of the left chamber.

Required new minimum-edge inventory:

- material around both new wall openings,
- material between each opening and nearby exterior edges,
- material between new fastener holes and opening edges,
- material between fastener holes within each drawer face,
- remaining ligaments between drawer guides/stops and existing chamber features,
- remaining throat between the upper drawer lane and lid-rail structures,
- remaining throat between the lower drawer lane and the floor/opening system,
- material around any future antenna-mount starter feature if that is included in the same revision.

Each structural seam must retain at least `3 mm` of deliberate positive-volume overlap across its full intended length after every subtraction. Every remaining material ligament must stay at or above `3 mm`.

## Part-Manifest Expectations

At minimum, the implementation is expected to add two new intentionally separate parts:

- front battery drawer
- rear Meshtastic drawer

The exact expected STL and PNG counts must be recalculated from the final approved manifest before building. A build is not complete until `build_manifest.json` passes `--audit-only`.

## Verification Plan

1. Create the new numbered revision/config from the current `rev_0013` baseline.
2. Run assertion-backed builds for every manifest part under the exact new config.
3. Build the complete manifest with `scripts/scad_build_all.py` into `output/cyberdeck/`.
4. Run `--audit-only` on the current build.
5. Build the immutable revision snapshot and audit it independently.
6. Inspect sections through:
   - the front opening frame,
   - the rear opening frame,
   - the divider/shelf joins,
   - the right-side battery support,
   - and the tightest drawer-clearance regions near the lid rails, floor, and split wall.
7. Confirm every new chamber body export has no unexpected disconnected positive-volume shells.
8. Confirm the drawers are intentionally separate parts and that no guide/support geometry becomes a loose floating shell.
9. Review slicer layer paths for the new opening frames, support shelf, and rail attachments in the intended print orientation.
10. Record artifact counts, provenance hashes, and structural review results in the README for the exact implementation revision.

## Completion Criteria

- The left chamber contains two intentionally separate removable drawer-style trays.
- The battery drawer exits the front and supports a `60 x 60 x 160 mm` payload envelope.
- The Meshtastic drawer exits the rear and supports a provisional `60 x 60 x 160 mm` payload envelope.
- Both drawers have side walls up to `60 mm` and no inner end wall.
- The battery drawer has meaningful right-side support inside the chamber.
- A simple divider/shelf or equivalent bracket system stabilizes both drawers.
- All new openings, supports, rails, stops, and fastener regions satisfy the `3 mm` minimum wall/edge contract.
- The complete current output and immutable revision output both pass artifact and provenance audits.
- Documentation matches the implemented geometry and verification evidence.

## Approval Gate

Execution of this plan assumes the following, which should be confirmed before geometry changes begin:

1. The two drawers will be vertically stacked rather than occupying the same height.
2. The battery drawer will be the lower front drawer.
3. The Meshtastic drawer will be the upper rear drawer.
4. The current compact outer shell size will remain unchanged unless the vertical-stack layout proves impossible after detailed clearance inventory.
