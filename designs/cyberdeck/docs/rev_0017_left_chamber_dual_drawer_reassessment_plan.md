# Cyberdeck Revision 0017 Left-Chamber Dual Drawer Reassessment Plan

*Status: Proposed*

## Objective

Reassess and plan the addition of two removable drawer-style trays in the compact cyberdeck's left chamber under the current `rev_0016` geometry:

- a front-access battery drawer for a `60 mm x 60 mm x 160 mm` battery bank,
- a rear-access Meshtastic drawer for a provisional `60 mm x 60 mm x 160 mm` LilyGO 1W envelope,
- and a simple internal support structure that stabilizes both drawers and gives the heavier battery drawer meaningful right-side support.

Both drawers should keep:

- side walls up to `60 mm` high,
- an open inner end,
- independent removal from opposite ends of the chamber,
- and front/rear wall openings derived from a nominal `60 mm x 60 mm` face envelope plus the required clearances, structural margins, and fastening geometry.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Current Baseline

- Base any later implementation on the current compact-body source recorded in `designs/cyberdeck/configs/rev_0016.json`.
- Preserve the current compact shell size unless the user explicitly approves an envelope change.
- Treat this document as a reassessment of `designs/cyberdeck/docs/rev_0014_left_chamber_dual_drawer_plan.md`, not an in-place execution plan for that older baseline.

## Updated Feasibility Findings

### What improved since the older drawer plan

- The compact left printable half is now approximately `177.6 mm` wide externally.
- That leaves approximately `171.6 mm` of modeled internal width between the left outer wall and the compact split wall.
- Width is therefore no longer the primary blocker for `60 mm` wide drawer payloads.

### What did not improve

- The body depth is still `210 mm` externally.
- The modeled internal front-to-back depth remains approximately `204 mm` after the `3 mm` front and rear walls are removed.
- The flat-lid underside clearance remains `80 mm`.

### Practical conclusion

The rev_0016 widening makes a side-by-side interpretation feasible across X, but the front-to-back depth is still too short for two `160 mm` deep drawers to share the same Y lane.

- required combined depth if both share one Y lane: `160 + 160 = 320 mm`
- available internal depth: approximately `204 mm`

So the workable interpretation is:

- one front-opening drawer in one X lane,
- one rear-opening drawer in the adjacent X lane,
- each lane sized around a `60 mm x 60 mm` opening face plus margins,
- and a structural divider/web between the lanes.

## Recommended Architecture

Use a side-by-side two-lane left-chamber drawer bay:

1. one battery drawer in one X lane, opening out the front,
2. one Meshtastic drawer in the adjacent X lane, opening out the back,
3. one structural vertical divider/web between them,
4. short guide/support features at the chamber sides and divider,
5. explicit right-side support for the battery drawer so the load is not carried only by the handle-side wall.

This remains the best match to the current geometry because it:

- uses the newly available width,
- works around the unchanged front-to-back conflict by separating the drawers laterally,
- and keeps the Meshtastic rear wall available for a future antenna bulkhead.

## Key Design Constraints To Carry Into Implementation

1. Keep the drawers in separate X lanes rather than stacked in Z.
2. Size both front and rear openings from a nominal `60 mm x 60 mm` envelope plus wall, clearance, and fastener margins.
3. Keep both drawers intentionally separate printed parts.
4. Preserve at least `3 mm` minimum wall/edge material everywhere.
5. Do not allow the divider, rails, or stops to create floating shells.
6. Keep the inner end of each drawer open.
7. Keep the battery drawer supported on the chamber's right side.
8. Leave the Meshtastic rear exterior wall usable for later antenna mounting.

## Atomic Plan

1. Create a new implementation revision/config from `rev_0016`.
2. Inventory the left chamber's actual usable envelope under current compact geometry:
   - internal width to the compact split wall,
   - internal depth between front and rear walls,
   - usable left-lane width,
   - usable right-lane width,
   - usable lane height,
   - lid-rail intrusion,
   - handle-hole region intrusion,
   - and any front/rear opening margin constraints.
3. Add named parameters for:
   - battery payload envelope,
   - Meshtastic payload envelope,
   - drawer wall thickness,
   - slide/guide clearance,
   - divider thickness,
   - rail/support thickness,
   - stop depth,
   - front opening width/height,
   - rear opening width/height,
   - and front/rear face fastener geometry.
4. Add named functions for the left drawer-bay datum system:
   - front opening plane,
   - rear opening plane,
   - left lane bounds,
   - right lane bounds,
   - divider/web bounds,
   - and battery right-support engagement geometry.
5. Lock the side-by-side lane layout with assertions:
   - battery drawer lane,
   - Meshtastic drawer lane,
   - `>= 3 mm` remaining material to outer wall, split wall, floor, and lid structures,
   - `>= 3 mm` remaining material at the divider/web,
   - and `>= 3 mm` remaining material around both opening systems.
6. Model the front battery-drawer opening in the left chamber front wall.
7. Model the rear Meshtastic-drawer opening in the left chamber rear wall.
8. Add the internal support structure:
   - one vertical divider/web as the baseline,
   - plus short guide rails or brackets only where needed,
   - with explicit right-side load support for the battery drawer.
9. Add a new battery drawer part with:
   - `3 mm` floor,
   - side walls up to `60 mm`,
   - front closure face,
   - open inner end,
   - stops/guides,
   - and support compatibility with the chamber-side structure.
10. Add a new Meshtastic drawer part with:
   - `3 mm` floor,
   - side walls up to `60 mm`,
   - rear closure face,
   - open inner end,
   - stops/guides,
   - and a rear outer wall suitable for later antenna detail.
11. Update any assembly/preview modules so the installed positions of both drawers can be reviewed in place.
12. Update `designs/cyberdeck/parts.json` with the new drawer exports if implementation proceeds.
13. Add assertion coverage for:
   - opening-to-edge margins,
   - opening-to-fastener margins,
   - fastener-to-fastener ligaments,
   - divider/support overlaps,
   - drawer-to-drawer lateral separation,
   - drawer-to-floor and drawer-to-lid clearance,
   - drawer-to-split-wall clearance,
   - and right-side battery-support engagement.
14. Update `designs/cyberdeck/README.md` with the final drawer architecture and verification record once geometry exists.
15. Build the complete manifest, audit it, inspect sections through every new join/opening, and record structural status for the exact implementation revision.

## Structural Review Requirements

The implementation must explicitly review:

- front battery-opening frame joins,
- rear Meshtastic-opening frame joins,
- divider/web joins into both chamber sides,
- any brackets/rails/stops attached to chamber walls,
- battery right-support joins,
- and all remaining ligaments around the new opening and fastener patterns.

Minimum structural contract remains:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

## Approval Gate

Before geometry changes begin, the implementation should assume the following unless the user directs otherwise:

1. The two drawers occupy side-by-side X lanes rather than a vertical stack.
2. The battery drawer remains the front-opening drawer.
3. The Meshtastic drawer remains the rear-opening drawer.
4. The current compact outer shell remains unchanged.
