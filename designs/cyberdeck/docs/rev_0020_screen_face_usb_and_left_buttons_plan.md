# Cyberdeck Revision 0020 Screen-Face Port Swap and Left-Button Rebalance Plan

*Status: Proposed*

## Objective

Create the next cyberdeck iteration from `rev_0019` that:

- moves the two screen-face arcade buttons from the right side of the display opening to the left side,
- adds one USB-A hole and one USB-C hole on the right side of the angled screen face,
- preserves the current screen opening and screen mount contract,
- and rebalances the display wedge only as much as necessary to satisfy the structural margin rules.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Baseline

- Base implementation on `designs/cyberdeck/configs/rev_0019.json`.
- Preserve `rev_0019` as the immutable checkpoint.
- Create a new implementation revision/config rather than editing `rev_0019` in place.

## Current Source Findings

### Existing screen-face hardware layout

- The current angled screen face uses a right-side arcade-button column at `x = +136.5 mm` relative to the screen center.
- The two existing arcade-button holes are vertically stacked at `40 mm` center-to-center spacing.
- The current screen opening remains `210 mm` wide.
- The current screen-mount width remains `250 mm`, with the screen-mount screw columns at `x = +/-115 mm`.

### Current compact wedge envelope

- Under `rev_0019`, the compact display wedge is asymmetric:
  - left half is about `144.4 mm`,
  - right half is `157 mm`,
  - total effective wedge width is about `301.4 mm`.
- That asymmetry was chosen to preserve the right-side button contract while removing unnecessary left-side blank space.

### Consequence for the requested swap

- The right side already has enough face width for a small vertical hardware column containing one USB-A hole and one USB-C hole.
- The left side does not currently have enough width for the same two-button column under the existing margin rules.
- Therefore the limiting change is not the new right-side port column; it is the new left-side arcade-button column.

## Design Intent

The implementation should prefer the smallest defensible geometry change:

1. keep the screen opening unchanged,
2. keep the screen mount-hole contract unchanged unless the new hardware proves to collide with it,
3. replace the current right-side arcade-button column with a right-side port column,
4. add a mirrored left-side button column,
5. and increase left-side face width only by the minimum amount needed to restore margin compliance.

## Assumptions

Unless source review during implementation proves otherwise:

1. The USB-A and USB-C screen-face holes should be vertically stacked on the right side, using the current button-column zone as the starting point.
2. The new left-side arcade-button pair should remain vertically stacked at the current `40 mm` spacing unless face-height checks require a change.
3. The screen opening and the current M3 screen-mount hole pattern should remain unchanged if that can be done without violating minimum margins.
4. The preferred wedge change is a small leftward rebalance rather than a large total-width increase.
5. If the current right-side width becomes marginal after the rebalance, the total wedge may grow slightly rather than sacrificing the minimum-edge contract.

## Atomic Plan

1. Create the next immutable implementation revision/config from `rev_0019`.

2. Inventory the current screen-face datums in source:
   - screen opening width and center,
   - wedge left/right half widths,
   - screen mount width,
   - screen mount screw-column positions,
   - current right-side button-column `x` position,
   - button vertical spacing,
   - USB-A hole diameter and outer envelope,
   - USB-C hole diameter and required margins,
   - and the minimum wall/edge contract.

3. Refactor the screen-face hardware layout helpers so the face no longer assumes:
   - buttons exist only on the right side,
   - or that only one hardware family occupies the angled face.

4. Introduce explicit left/right screen-face hardware parameters for:
   - left button-column `x`,
   - right USB-A `x`,
   - right USB-C `x`,
   - and the face-offset positions for the stacked hardware.

5. Replace the current right-side arcade-button cuts with:
   - one USB-A hole,
   - one USB-C hole,
   - and updated assertion coverage for screen-edge, outer-edge, screw-column, and face-end ligaments.

6. Add the new left-side arcade-button pair:
   - mirrored from the current right-side concept where useful,
   - but re-derived from named left-side dimensions rather than by implicit symmetry.

7. Rebalance the wedge to create valid left-side button clearance:
   - first try a small shift that adds only the needed left-side width,
   - preserve as much of the current right-side packaging as possible,
   - and avoid changing the screen opening or screen mount-hole locations unless assertions force it.

8. Recompute all affected structural and edge checks:
   - button-to-screen-opening ligaments,
   - button-to-outer-face-edge ligaments,
   - button-to-screen-mount-screw ligaments,
   - USB-A-to-screen-opening ligament,
   - USB-C-to-screen-opening ligament,
   - USB-A-to-USB-C ligament,
   - port-to-outer-face-edge ligaments,
   - port-to-screen-mount-screw ligaments,
   - and face-end ligaments for all stacked hardware.

9. Update revision documentation in `designs/cyberdeck/README.md` with:
   - the new wedge dimensions,
   - the new left/right hardware arrangement,
   - and the exact verification status for the changed geometry.

10. Build the complete manifest for the new revision and run the artifact audit.

11. Review the exact implementation revision for:
   - screen-face edge margins,
   - screen-mount screw clearance,
   - connectivity of the revised wedge/body shell,
   - changed printable half extents,
   - and any new risks introduced by the relocated hardware.

## Structural Review Requirements

The implementation must explicitly review:

- the left-side button-column margin to the screen opening,
- the left-side button-column margin to the outer wedge edge,
- the left-side button-column clearance to the left screen-mount screw column,
- the right-side USB-A and USB-C margins to the screen opening,
- the right-side USB-A and USB-C margins to the outer wedge edge,
- the ligament between the USB-A and USB-C holes,
- the clearance from each new right-side port to the right screen-mount screw column,
- and any resulting change to the wedge shell continuity where the face width changes.

Repository minimums remain mandatory:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

## Expected Outcome

If the implementation follows the current constraints correctly, the likely result should be:

- two arcade buttons positioned on the left side of the screen face,
- one USB-A hole and one USB-C hole positioned on the right side of the screen face,
- a modestly widened or rebalanced left side of the display wedge,
- and no unnecessary broadening of the shell beyond what the new left-side button column actually requires.

## Pre-Execution Commit Scope

Before geometry changes begin, the pre-execution commit should include:

- this plan document,
- and any other intended source/doc changes already present.

It should not include:

- `output/` artifacts,
- `revisions/` artifacts,
- or unrelated user scratch files,

because repository governance explicitly forbids committing generated build directories.
