# Cyberdeck Revision 0028 Drawer, Screen Face, Shell Seam, and Lid-Clearance Repair Plan

*Status: Executed — implementation evidence is recorded in `rev_0028_drawer_screen_shell_and_lid_clearance_repair.md`*

## Objective

Create a corrective cyberdeck revision that resolves the regressions visible in
the current `rev_0027` build without reusing the failed workarounds:

1. Restore usable retention holes for both left-chamber drawers.
2. Restore the screen mounting holes to the screen's mounting datum, between the
   screen opening and the left/right face hardware.
3. Eliminate the exterior shell step/seam while restoring a real structural join
   between the profiled display shell and the adjoining lower/flat shell.
4. Keep the left-chamber divider completely outside the lid seating and
   installation envelopes.
5. Keep the previously added wall-bisected standoffs and nut bosses removed.

The chassis and display wedge may grow laterally by as much as the measured
hardware and structural-clearance contracts require. Minimizing width is
secondary to making the fasteners usable, keeping the screen layout correct,
and producing continuous structural walls.

## Governing Playbooks

- `playbooks/how_to_iterate_openscad_designs.md`
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md`
- `playbooks/debugging_changes_that_lead_to_errors.md` if any repaired feature
  fails a verification gate
- `playbooks/how_to_commit_and_push_changes.md` for checkpoints and final
  publication

## Baseline and Revision Policy

- Treat the current `rev_0027` output as a known failing diagnostic baseline,
  not as proof that any of these four repairs passed.
- Preserve the current source/config/doc state in a task-scoped Git checkpoint
  before changing geometry, excluding generated `output/` and `revisions/`
  artifacts as required by repository policy.
- Create `designs/cyberdeck/configs/rev_0028.json` for implementation.
- Do not overwrite `revisions/cyberdeck/rev_0027/` or any other numbered
  revision directory. The completed geometry must be installed as a new
  immutable revision.
- Keep the existing `3.0 mm` minimum wall thickness, structural overlap, and
  internal edge width. Do not reduce these values to make the layout fit.

## Confirmed Failure Analysis

### 1. Drawer retention holes disappeared

The current source sets
`chamber_left_drawer_backplate_screw_x_abs()` to zero and calls each screw-cut
module only once at the drawer center. That point is inside the drawer opening,
which is already empty. The screw subtraction therefore removes no additional
visible material.

The earlier requirement was a single **vertical row** of fasteners, not a single
fastener: each drawer needs two horizontally separated M3 holes at one common
mid-height.

### 2. Screen mounting holes moved outside the face hardware

The current left screen-mount function returns the outermost allowed wedge
coordinate. This makes wedge width control the screen-hole location and places
the left M3 column outside the left arcade-button column. The right column still
uses the original `+115 mm` screen-mount datum, so the pattern is asymmetric.

Screen mounting geometry must be derived from the screen mount itself, not from
the outer wedge boundary or the positions of the buttons and ports.

### 3. Exterior shell seam remains and the join is not structurally valid

The current source removed `chamber_shell_wedge_tray_overlap`, removed its
assertion, and terminates the flat and profiled shell spans at coincident
boundaries. Coplanar face contact is not a structural join and can preserve a
visible boundary or step in the final result.

The corrected construction needs both one continuous exterior envelope and at
least `3.0 mm` of deliberate positive-volume engagement across the complete
internal join.

### 4. Divider interferes with lid installation

The current divider-height assertion checks only a nominal Z relationship. It
does not prove that the final divider, its end geometry, and all later Boolean
operations stay outside the lid's full seating and insertion/swept envelopes.
The final geometry must be reviewed in three dimensions and in sections through
both divider ends.

## Fixed Geometry Contracts

### Drawer retention pattern

For each left drawer:

- use exactly two M3 clearance holes,
- keep both hole centers at
  `chamber_left_drawer_backplate_single_row_z`,
- place one hole on each side of the drawer opening,
- keep every hole and its entire head/nut seating envelope outside the opening,
- use the same hole coordinates in the chamber wall and matching removable
  drawer backplate,
- leave no added cylindrical boss, standoff, or wall-bisected nut trap,
- provide unobstructed interior space for the selected head/nut envelope and
  reasonable tool/finger access,
- retain at least `3.0 mm` of solid material between the opening and fastener
  cut, between the fastener cut and every exterior boundary, and between nearby
  cuts,
- and preserve a flat seating land beneath the entire head or nut rather than
  checking only the `3.4 mm` through-hole.

The initial hardware envelope should use the existing M3 dimensions as the
minimum starting point:

- through-hole diameter: `3.4 mm`,
- screw-head/counterbore diameter: `7.0 mm`,
- M3 nut across flats: `5.5 mm`, with the across-corners diameter derived rather
  than approximated,
- plus a named non-structural installation clearance around the hardware
  envelope.

The exact fastener orientation must be documented before modeling the recess:
head on one face and nut/captive feature on the other. The plan does not permit
adding projecting chamber-side bosses to create this space. Increase the planar
wall/land width and locally relieve or set back the divider end if necessary.

### Screen face ordering

The face layout must follow this order from the screen outward:

`screen opening -> M3 screen-mount column -> arcade/USB hardware -> outer edge`

Required contracts:

- keep the screen opening centered at its established datum and `210 mm` wide,
- keep the M3 screen mounting columns symmetric at the screen-derived X
  positions; use the established `-115 mm` and `+115 mm` columns unless source
  measurement of the actual screen pattern proves another value is required,
- keep the screen mounting clearance diameter at `3.4 mm`,
- keep the two left arcade-button openings outside the left screen-mount column,
- keep the USB-A and USB-C openings outside the right screen-mount column,
- move the face hardware outward and increase the corresponding wedge half-width
  whenever necessary; do not move a screen-mount column outward merely to pass
  a hardware-margin assertion,
- and preserve at least `3.0 mm` of shortest-path solid material between every
  applicable pair of screen, screw, hardware, and outer-edge voids.

Because the stacked face hardware and screen screws have different face-offset
coordinates, pairwise clearance must be calculated in the angled face plane,
not from X distance alone.

### Profile-shell to flat-shell seam

The corrected seam must satisfy two independent requirements:

1. **Exterior continuity:** the upper/profiled and lower/flat construction uses
   the same exact exterior side plane and produces no lateral step.
2. **Structural continuity:** the members share at least `3.0 mm` of
   positive-volume engagement for the entire intended seam after all interior,
   lid, drawer, and hardware subtractions.

Preferred construction order:

- define one authoritative exterior side/profile envelope,
- extend the adjoining internal members through the nominal transition by a
  named `chamber_shell_wedge_tray_overlap`,
- union those overlapping members,
- trim to the single exterior envelope,
- then subtract one coherent interior void and the remaining feature cuts.

If the source can express the affected region as one continuous side-profile
polygon and extrude it across the necessary span, prefer that over two finished
shells touching at a boundary.

### Divider and lid clearance

- Build an explicit lid seating envelope from the lid outline, thickness, fit
  clearance, rails, and underside clearance.
- Build an explicit swept installation envelope covering the actual direction
  in which the lid must be inserted and lowered into place.
- Require the final divider and any supports to remain outside both envelopes by
  at least the named lid fit clearance.
- Inspect both the front and rear divider ends; a valid mid-span clearance does
  not prove valid end clearance.
- Lower, shorten, notch, or locally set back the divider as needed, while keeping
  its required drawer-end support.
- Any divider-to-floor/front/rear join that remains structural must retain at
  least `3.0 mm` of engagement and a `3.0 mm` minimum throat.
- If the divider becomes separate end brackets instead of a continuous wall,
  document that architecture and prove that both drawers retain adequate end
  support and anti-racking guidance.

## Atomic Execution Plan

1. **Checkpoint the known failing state.**
   - Review `git status -sb` and the complete source/config/doc diff.
   - Commit the current non-generated state with a message identifying it as the
     failed `rev_0027` baseline.
   - Exclude `output/`, `revisions/`, and `.tmp/` artifacts.

2. **Create the implementation revision.**
   - Add `designs/cyberdeck/configs/rev_0028.json` from the intended current
     compact configuration.
   - Update part names to `rev_0028` without changing the authoritative part
     manifest unless a real new printable part is introduced.

3. **Capture failing probes before editing.**
   - Store generated probes only under `output/cyberdeck/` and remove transient
     staging before accepting the final exact set.
   - Capture orthographic and sectional evidence of:
     - both missing drawer-hole regions,
     - both left/right screen mount and hardware columns,
     - the side-shell seam at its start, midpoint, and end,
     - and divider intersections with the lid seating/insertion envelopes.

4. **Inventory the actual packaging dimensions.**
   - Calculate the drawer opening width/height from the payload, drawer walls,
     fit clearance, and slide clearance.
   - Calculate the planar land required for the full M3 head/nut envelope plus
     installation clearance and minimum material.
   - Calculate the current left/right angled-face coordinates in face-plane
     space.
   - Calculate the exact additional left/right width required before moving any
     feature.

5. **Repair the drawer retention layout.**
   - Restore a two-hole horizontal pattern with one vertical mid-height row.
   - Use named left/right screw offsets rather than an `sx = 0` shortcut.
   - Enlarge the relevant planar front/rear wall lands and drawer backplate ears.
   - Increase left-chamber width as required.
   - Add divider-end clearance or setback only where needed for real head/nut
     access.
   - Apply identical coordinates to the chamber and each matching drawer part.
   - Confirm that the hole cuts intersect solid wall/backplate material before
     accepting a render.

6. **Repair the screen mount and face-hardware layout.**
   - Restore the screen-derived symmetric M3 columns.
   - Remove any screen-hole formula derived from the wedge outer edge.
   - Move the left arcade-button column outward far enough to clear the left M3
     holes and screen opening.
   - Keep or move the right USB column outward far enough to clear the right M3
     holes and screen opening.
   - Grow the corresponding wedge half-widths to preserve outer-edge material.
   - Recalculate body/wedge/split bounds explicitly so widening one face does not
     flip the chambers or move rear hardware into the Orange Pi chamber.

7. **Rebuild the shell transition.**
   - Restore a named overlap of at least `minimum_structural_overlap`.
   - Use one authoritative exterior side envelope for both shell regions.
   - Remove any coincident-face-only construction.
   - Ensure interior subtraction does not remove the overlap or leave a throat
     below `3.0 mm`.

8. **Repair divider/lid compatibility.**
   - Implement and display the lid seating and swept insertion envelopes.
   - Modify the divider/end supports until the final geometry clears both.
   - Preserve the drawer lanes, open inner drawer ends, and required right-side
     battery support.
   - Keep all divider/end-support structural joins intentionally overlapped.

9. **Add regression assertions.**
   - Drawer hole center is outside the drawer-opening bounds.
   - Exactly two chamber holes and two matching drawer holes exist per drawer.
   - Full head/nut seating envelopes fit without intersecting the opening,
     divider, side wall, or neighboring feature.
   - Screen mount columns are symmetric and lie between the screen and face
     hardware.
   - All applicable void-to-void and void-to-edge ligaments are at least
     `3.0 mm` in the angled face plane.
   - Shell overlap is at least `3.0 mm` across the complete seam.
   - Exterior side-plane coordinates match exactly.
   - Divider-to-lid seating and swept-envelope clearance is nonnegative after
     applying the named lid clearance.

10. **Run targeted verification before a complete build.**
    - Render the left chamber, both left drawers, right chamber, and assembled
      two-chamber structure under `rev_0028`.
    - Review the same camera directions as the user-provided failure images.
    - Inspect sections through both drawer holes on both openings.
    - Inspect seam sections at the start, midpoint, end, and nearest feature cut.
    - Inspect lid/divider sections at both divider ends and mid-span.
    - Reject the revision if a hole is only visible in source coordinates but
      does not cut solid material in the final Boolean result.

11. **Run structural and topology verification.**
    - Pass the OpenSCAD parameter/assertion gate.
    - Confirm the post-subtraction shell overlap and minimum throats in sections.
    - Confirm no unexpected disconnected positive-volume shells in the chamber
      STLs.
    - Review slicer layer paths through the repaired seam, drawer fastener lands,
      and divider joins in the intended print orientation.

12. **Build and audit the complete manifest.**
    - Run `scripts/scad_build_all.py` for `rev_0028` into
      `output/cyberdeck/`.
    - Run `--audit-only` and require a passing manifest before calling the build
      current.
    - If `parts.json` remains at ten parts, require exactly `10` STL and `170`
      PNG files; otherwise recalculate and document the expected counts from the
      changed manifest before building.
    - Install and independently audit the new immutable
      `revisions/cyberdeck/rev_0028/` snapshot.

13. **Review, document, and commit.**
    - Update `designs/cyberdeck/README.md` and add `rev_0028` implementation
      notes with exact dimensions and evidence.
    - Record structural joins, minimum edge widths, section locations,
      connectivity, slicer review, artifact counts, and provenance for the exact
      config/source hashes.
    - Review the final Git diff and commit only source, config, and documentation.
    - Push only after the repository's approval gate is satisfied.

## Required Verification Views and Sections

The implementation is not accepted from a general isometric render alone.
Required evidence includes:

- front orthographic view of the battery opening and both retention holes,
- rear orthographic view of the Meshtastic opening and both retention holes,
- inside-front and inside-rear views showing usable head/nut clearance,
- drawer-only front/rear views showing matching two-hole patterns,
- display-face orthographic view showing symmetric screen-mount columns,
- face-plane measurement overlay showing screen-to-screw, screw-to-hardware, and
  hardware-to-edge ligaments,
- exterior left and right orthographic views showing a flush shell silhouette,
- seam-normal sections at the start, midpoint, and end,
- lid/divider sections at the front end, midpoint, and rear end,
- and an assembled view with lids positioned and with their insertion envelope
  displayed as a debug-only volume.

## Completion Criteria

The repair is complete only when all of the following are true:

- Each left drawer visibly and measurably has two M3 retention holes in one
  middle-height row.
- Every retention hole cuts solid material and has a usable, unobstructed
  head/nut seating and installation envelope.
- No drawer fastener boss or standoff projects into the chamber.
- Screen mounting holes use the actual symmetric screen datum and sit between
  the screen opening and the face hardware on both sides.
- The left arcade buttons remain left of the screen and the USB-A/USB-C openings
  remain right of the screen.
- The exterior chassis side is flush with no upper/lower step.
- The shell transition has at least `3.0 mm` of positive-volume overlap across
  its complete intended seam after subtraction.
- The divider does not intersect the lid, lid rail, seating clearance, or swept
  installation envelope.
- All affected minimum material widths are at least `3.0 mm`.
- The exact `rev_0028` complete build and immutable revision audits pass.
- Structural section, connectivity, and slicer gates are recorded rather than
  inferred from render success.

## Approval Gate

Execution should begin only after the user approves this plan. Approval includes
permission to increase the left chamber and/or display-wedge width by the amount
required by the measured hardware envelopes and `3.0 mm` structural margins. It
does not authorize changing the screen opening, drawer payload envelopes,
Orange Pi placement, chamber split orientation, or hardware families.
