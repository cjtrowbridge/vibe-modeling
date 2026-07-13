# Cyberdeck Revision 0015 Widened Display Wedge and Right-Side Arcade Buttons Plan

*Status: Proposed*

## Objective

Create a new cyberdeck iteration that:

- widens the compact enclosure's display-wedge/body width,
- adds two new arcade-button mounting positions to the right of the screen on the angled display face,
- preserves the current screen opening and screen mounting scheme unless the wider-button layout forces a documented adjustment,
- and records the resulting effect on left-chamber packaging for later storage/drawer work.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`

## Baseline

- Base the work on the current compact-body source recorded in `designs/cyberdeck/configs/rev_0013.json`.
- Create a new immutable revision/config for implementation rather than editing a prior revision in place.
- Preserve the current compact/de-dome layout, split strategy, lid system, handle-hole pattern, and right-side Orange Pi tray unless the widened display-wedge geometry requires a documented adjustment.

## Current Live Screen and Button Contract

From the current source:

- Display opening width: `210 mm`
- Display opening height: `87 mm`
- Display mount width: `250 mm`
- Display-face length: `95 mm`
- Display wedge width: `260 mm`
- Named display side margin: `5 mm` per side
- Display mount screw pattern: `115 mm` lateral offset, `76.2 mm` face spacing, `3.4 mm` M3 clearance holes
- Arcade-button mounting hole: `28 mm`
- Arcade-button outer envelope: `35 mm`
- Requested arcade-button hole margin: `5 mm`
- Global structural minimum: `3 mm`

## Design Intent

1. Use the screen as the primary anchor and add two human-reachable controls immediately to its right rather than relocating the screen.
2. Widen the display wedge enough that the new button holes are not crowding the screen cutout, screen mount holes, or exterior edges.
3. Keep the existing screen opening and screen fastener scheme if possible so the change remains additive rather than cascading into a display remount redesign.
4. Use the width increase as a deliberate packaging change that can be referenced by the later left-chamber storage redesign.

## Proposed Width Strategy

Recommended initial target:

- increase the display-wedge width from `260 mm` to approximately `345 mm`

This target is intended to provide:

- retained screen mount width and margins,
- two `28 mm` arcade-button holes on the right side of the display face,
- practical spacing between the two buttons,
- practical spacing from the screen-side flange area,
- and edge/ligament room that remains above the `3 mm` structural minimum instead of designing to a knife-edge minimum.

The implementation must not assume `345 mm` is correct without re-deriving all relevant margins and assertions in source.

## Proposed Button Layout

Initial planning assumptions:

- both new buttons land on the angled display face to the right of the screen opening,
- both use the existing arcade-button standard (`28 mm` mount hole, `35 mm` outer envelope),
- the buttons are aligned vertically relative to the face rather than offset diagonally unless section/ligament checks show a better arrangement,
- nominal button center-to-center spacing starts around `40 mm`,
- the inner button must remain clear of the display opening, right screen flange, and right-side display mount holes,
- the outer button must retain edge margin to the right display-wedge boundary and preserve enough material for the face-to-side-wall transition.

The exact button coordinates should be derived from named flange, edge, and inter-feature clearance dimensions rather than assigned as unexplained constants.

## Atomic Implementation Plan

1. Create a new revision config from `rev_0013` and assign the next revision output name.
2. Inventory the current compact-body dimensions affected by width:
   - display wedge width,
   - compact assembled width,
   - left chamber width,
   - right chamber width,
   - print-half widths,
   - and the current split position relative to the Orange Pi tray.
3. Add named parameters/functions for the widened display wedge, any resulting compact-body width change, and the two new right-of-screen arcade-button positions.
4. Re-derive the screen-face flange geometry so the existing display opening, side flanges, and M3 screen mount holes remain valid under the wider wedge.
5. Model two new arcade-button cuts on the right side of the angled display face using the current `28 mm` mounting-hole standard and existing button-envelope assumptions.
6. Add explicit assertions for:
   - button-to-screen-opening ligament,
   - button-to-screen-mount-hole ligament,
   - button-to-button ligament,
   - button-to-right-edge ligament,
   - button-to-face top/bottom edge margins,
   - and any post-subtraction ligament to nearby rear-housing or seam features.
7. Recalculate the widened compact-body outer envelope and the left/right printable-body widths. Assert continued fit within the configured print volume.
8. Re-evaluate the compact split relative to the Orange Pi tray and confirm the minimum-material contract still holds. If the wider body changes left/right half allocation materially, document whether the split remains unchanged or moves.
9. Re-evaluate the left chamber's usable width after the wedge/body change and record whether the width increase meaningfully improves later battery/Meshtastic storage options.
10. Update visual/mockup modules and the full-body exports so the widened wedge and new arcade-button layout appear in the current manifest outputs where relevant.
11. Update the authoritative part manifest only if the complete part set changes; otherwise keep the current manifest and revised geometry under the existing part names.
12. Update `designs/cyberdeck/README.md` with:
    - the new display-wedge width,
    - button layout rationale,
    - any changed overall body dimensions,
    - print-half dimensions,
    - and exact verification status for the implementation revision.
13. Build and audit the complete manifest, inspect sections through the changed screen-face/button region, and record the structural verification status for the exact new revision/config.

## Structural Contract

The current repository minimums remain mandatory:

- `minimum_wall_thickness = 3 mm`
- `minimum_structural_overlap = 3 mm`
- `minimum_internal_edge_width = 3 mm`

Required changed-join inventory:

- widened display-wedge side-wall transitions to the angled screen face,
- widened display-wedge end-wall transitions to the roof/rear housing as affected by the new width,
- any changed screen-face to side-wall seam or roof transition geometry created by the wider wedge,
- any newly thickened or reinforced local button-support geometry.

Required changed minimum-edge inventory:

- screen opening to screen mount holes,
- screen opening to new button holes,
- new button hole to new button hole,
- new button holes to outer wedge edge,
- new button holes to top/bottom face boundaries,
- new button holes to any seam, bulkhead, or fastener region behind the screen face,
- and any changed separator web or screen-adjacent support region affected by the wider wedge.

Every changed seam must retain at least `3 mm` of deliberate positive-volume overlap after all subtractions. Every remaining material ligament must stay at or above `3 mm`.

## Packaging Follow-Up Requirement

This width-change revision is expected to answer, with measured post-change dimensions, whether widening the body improves the previously blocked left-chamber drawer/storage concept.

The implementation should explicitly record:

- the new left-chamber usable width,
- whether the extra width changes only X capacity or also enables a different front/rear support strategy,
- and whether the dual-`160 mm` storage problem remains blocked by depth/height even after the width increase.

The likely outcome is that width alone will not fully solve the previous dual-drawer feasibility problem, but the implementation must verify rather than assume.

## Part-Manifest Expectations

The current authoritative manifest may remain unchanged if this revision only alters existing body and lid geometry. If the revision introduces any new standalone part, the manifest and expected artifact counts must be updated before the build.

The build is not complete until `build_manifest.json` passes `--audit-only`.

## Verification Plan

1. Create the new numbered revision/config from the current `rev_0013` baseline.
2. Run assertion-backed builds for every manifest part under the exact new config.
3. Build the complete manifest with `scripts/scad_build_all.py` into `output/cyberdeck/`.
4. Run `--audit-only` on the current build.
5. Build the immutable revision snapshot and audit it independently.
6. Inspect sections through:
   - the screen opening and right flange,
   - the new inner arcade-button hole,
   - the new outer arcade-button hole,
   - the tightest button-to-screen and button-to-edge ligaments,
   - and any affected bulkhead/bolt region behind the screen face.
7. Confirm the changed chamber exports have no unexpected disconnected positive-volume shells.
8. Review slicer layer paths for the widened screen-face/button region in the intended print orientation.
9. Record artifact counts, provenance hashes, and structural review results in the README for the exact implementation revision.

## Completion Criteria

- The cyberdeck uses a wider display wedge/body width appropriate for two added right-of-screen arcade buttons.
- Two new arcade-button mounting positions exist on the angled display face to the right of the screen.
- The current screen opening and M3 mounting-hole scheme remain valid, or any required changes are explicitly documented and verified.
- The widened body still satisfies print-volume, artifact-audit, and provenance requirements.
- All changed screen/button ligaments satisfy the `3 mm` minimum structural contract.
- Documentation records the resulting body width and the observed impact on later left-chamber storage options.

## Approval Gate

Execution of this plan assumes the following, which should be confirmed before geometry changes begin:

1. The widened-wedge strategy should keep the current screen opening and current M3 screen mount scheme if feasible.
2. The two new buttons should use the current arcade-button standard (`28 mm` hole, `35 mm` outer envelope).
3. The two new buttons should be placed on the angled display face to the right of the screen rather than moved to a different panel.
4. The width increase is acceptable even if it does not, by itself, fully solve the previously blocked left-chamber dual-drawer concept.
