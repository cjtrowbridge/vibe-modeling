# Cyberdeck Revision 0019 Asymmetric Wedge, Left-Seam Counterbore, and Tray-Compaction Plan

*Status: Proposed*

## Objective

Create the next compact cyberdeck iteration based on `rev_0018` that:

- removes the unintended extra left-side screen-wedge blank space so the widened screen face only grows where the right-side arcade buttons require it,
- thickens the left chamber's merge-seam wall enough to add recessed screw-head pockets for the chamber-joining M3 fasteners,
- changes all tray backplates from upper/lower screw rows to one reachable middle screw row,
- and removes as much excess width around the new left-chamber drawers as possible by tightening the compact split around them while preserving the current screen envelope and its required margins.

This plan covers the three requests together because they interact directly:

1. the display wedge layout determines how much left-side shell width is actually available to reclaim,
2. the seam wall thickness affects the join-fastener hardware treatment,
3. the tray backplate screw pattern affects drawer serviceability,
4. and the compact split position determines how much real excess drawer width remains.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Baseline

- Base implementation on the current compact drawer revision recorded in `designs/cyberdeck/configs/rev_0018.json`.
- Preserve `rev_0018` as an immutable checkpoint.
- Create a new implementation revision/config rather than editing `rev_0018` in place.

## Current Source Findings

### Chamber merge seam

- The left/right chamber merge still uses a plain six-hole `3.4 mm` M3 clearance pattern at the compact split wall.
- The seam wall is still effectively the base `3 mm` chamber wall thickness at the joint face.
- That is enough for through-holes, but not enough for practical recessed screw-head pockets on the left seam face.

### Display wedge packaging

- The current widened compact shell still uses the full `314 mm` display wedge needed to preserve the existing right-of-screen button-clearance contract.
- That width increase was applied symmetrically around the centered display datum, so the shell gained unused blank space on the left even though only the right side needed extra room for the buttons.
- The current screen/body layout therefore contains two different sources of extra left-side width:
  - unused left-side wedge margin created by the symmetric widening,
  - and the compact split still being derived from the Orange Pi tray rather than from the drawer packaging target.

### Left drawer packaging

- The extra width around the new left drawers is therefore not only a compact split-location problem; part of it is genuine leftover wedge width on the left side.
- Under `rev_0018`, the left drawer lanes currently retain approximately:
  - `16.3 mm` side margin at each outside edge,
  - `19.5 mm` spare front/back length around the `160 mm` drawer bodies,
  - and `17 mm` vertical clearance above the drawer opening.
- The compact split is still derived from the Orange Pi tray's left edge, which leaves more left-chamber width than the new drawer pair actually needs.

### Tray fastener usability

- The current tray backplates use upper/lower screw rows.
- For the installed trays, the lower row is not realistically serviceable because the back side is inaccessible for placing a nut.
- The practical correction is a single mid-height fastener row per tray backplate.

## Key Design Decisions To Carry Into Implementation

1. Do not shrink the display wedge just to remove left-drawer slack unless screen/button-margin assertions prove that it can be done safely.
2. First try to remove left-drawer excess width by moving the compact split left, not by narrowing the screen wedge.
3. Thicken only the left seam wall region enough to support recessed chamber-merge screw heads rather than globally thickening unrelated chamber walls.
4. Treat the seam thickening as a structural change that requires explicit post-subtraction ligament review around:
   - the six seam bolts,
   - the two passthroughs,
   - the front LED passage,
   - and any nearby screen-side bulkhead or wedge geometry.
5. Change every tray backplate to a single reachable middle screw row:
   - right Orange Pi rear tray,
   - left battery front drawer,
   - left Meshtastic rear drawer,
   - and the legacy Raspberry Pi side tray if that historical part remains in source.

## Assumptions

Unless the user directs otherwise during implementation:

1. Chamber-merge screw-head recesses on the left seam side should use the same general M3 recessed-fastener envelope already used elsewhere in the design as the initial default.
2. The chamber-merge hardware remains an M3 through-bolt scheme rather than changing to threaded inserts or captive nuts.
3. The tray backplates will still use two fasteners total per tray, one left and one right, centered vertically instead of four corner fasteners.
4. The current screen opening, screen mount-hole positions, and right-of-screen button layout remain preserved.
5. The screen does not gain a mirrored left-side button set; the widened display face should remain justified by the existing right-side button set only.

## Atomic Plan

1. Create the next immutable implementation revision/config from `rev_0018`.

2. Inventory the current wedge, seam, and tray datums in source:
   - display opening center and width,
   - display mount width and screw positions,
   - current right-side button cutout location and required right-edge ligaments,
   - split-wall thickness at the merge face,
   - seam-bolt positions,
   - current seam-bolt clearances to the passthroughs and front LED passage,
   - current tray backplate screw datums,
   - and the left drawer lane-width derivation.

3. Rework the display wedge/body layout so the extra width exists only on the right side:
   - preserve the current display opening and right-side button hole positions relative to the screen,
   - reduce the left-side blank wedge margin to the minimum allowed by the screen mount and structural margin assertions,
   - and update any dependent body-center or wedge-edge calculations explicitly rather than relying on the prior symmetric width assumption.

4. Add named seam-fastener parameters for the chamber merge:
   - recessed head diameter,
   - recessed head depth,
   - local left-seam thickening amount,
   - post-counterbore throat,
   - and any local pad/boss width if needed.

5. Redesign the left chamber seam face so the merge-seam side is locally thicker where required for the recessed screw heads.
   - Prefer a deliberate seam-side thickened strip or bolt-pad system over an unexplained coordinate shift.
   - Keep the mating contract to the right chamber explicit and named.

6. Add the left-side seam screw-head recesses:
   - one recess for each chamber-merge bolt,
   - all derived from named head-envelope dimensions,
   - with explicit post-subtraction assertions for remaining material to the seam boundary and nearby cutouts.

7. Recalculate the seam-side structural checks:
   - recess-to-passthrough ligaments,
   - recess-to-LED-passage ligaments,
   - recess-to-outer and recess-to-inner wall margins,
   - and the remaining seam throat after counterboring.

8. Replace the tray backplate screw patterns with one reachable middle row:
   - add named single-row centerline functions for each tray family,
   - remove the upper/lower row logic,
   - preserve left/right spacing and edge margins,
   - and update any matching tray-part through-holes accordingly.

9. Update tray assertions for the new single-row fastener pattern:
   - screw-to-opening edge margins,
   - screw-to-outer-edge margins,
   - screw-to-screw spacing,
   - and post-cut remaining material.

10. Re-derive the compact split specifically from the left-drawer packaging target rather than from the Orange Pi tray edge.
   - Target the smallest left-chamber width that still preserves the minimum structural wall/edge contract around:
     - the battery drawer lane,
     - the Meshtastic drawer lane,
     - the divider,
     - the existing rear Power Cell opening,
     - and the newly reduced left-side display wedge/body envelope.

11. Explicitly verify that the revised asymmetric wedge and compact split still preserve:
    - screen wedge/body structural continuity,
    - left rear fan placement on the intended chamber half,
    - screen and button margin assertions,
    - and printable half bounds for both chamber pieces.

12. Update the README with the new revision note and verification record once geometry exists.

13. Build the complete manifest, audit it, and review the changed seam, wedge, and tray regions for the exact implementation revision.

## Structural Review Requirements

The implementation must explicitly review:

- the reduced left-side display wedge margin and its remaining screen-mount ligaments,
- the thickened left seam wall joins into the chamber shell,
- the seam-bolt counterbore pockets and their remaining throat,
- the seam-bolt relationship to the passthroughs and front LED passage,
- the revised split wall and any changed left/right load path at the compact seam,
- the revised tray backplate hole ligaments for all tray families,
- and the remaining material around the tightened left drawer lanes.

Repository minimums remain mandatory:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

## Expected Outcome

If the implementation follows the current source geometry correctly, the likely result should be:

- the screen wedge remains wide enough for the right-side buttons without carrying an unnecessary mirrored blank area on the left,
- the left chamber gains usable recessed seam screw heads,
- all tray backplates become practically serviceable with a single middle screw row,
- and the left drawer bay loses most of its unnecessary lateral slack without forcing a redesign of the current screen and button layout.

## Approval Gate

Before geometry changes begin, implementation should proceed on these assumptions unless the user redirects:

1. Use a new revision after `rev_0018`.
2. Preserve the current screen opening and the existing right-side button layout, but remove the unused mirrored left-side wedge growth.
3. Tighten the left chamber by combining an asymmetric wedge correction with a leftward compact-split move.
4. Use recessed M3 head pockets on the left seam side rather than changing the chamber-merge hardware family.
