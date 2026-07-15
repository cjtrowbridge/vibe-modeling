# Cyberdeck rev_0027 notes

Config: `designs/cyberdeck/configs/rev_0027.json`

Scope:

- remove the failed chamber-side left-drawer nut-boss / nut-trap workaround
- replace each left drawer's wall-adjacent screw pair with a single centered M3 retention screw
- lower the left-chamber divider so it clears the lid-install envelope
- restore the display wedge contract so the left screen-mount holes live in valid left-side face width
- simplify the wedge/flat-tray ownership so the wedge span is no longer built from overlapping side-wall shells

Geometry notes:

- the left battery drawer and left Meshtastic drawer now each retain through one centered backplate screw instead of two side screws
- the left drawer backplates narrow to a simple opening-cover flange because they no longer need the old side screw ears
- the left chamber divider now terminates at `chamber_left_drawer_opening_top_z()`, keeping it below the keyboard-lid rail envelope
- the compact left display wedge now guarantees enough width for the left button column and the left M3 screen-mount hole column simultaneously
- the previous wedge/tray overlap parameter is removed; the wedge span is now owned directly by the profile shell, with flat tray spans ending at the wedge boundaries

Structural verification record:

- Source revision/config: `designs/cyberdeck/configs/rev_0027.json`
- Minimum wall thickness: `3.0 mm`
- Minimum structural overlap: `3.0 mm`
- Minimum internal edge width: `3.0 mm`
- Join inventory reviewed:
  - left drawer divider to chamber floor/front/back engagement
  - compact display wedge shell to the adjoining flat-tray spans at the wedge boundaries
  - left drawer backplates to their retained chamber openings through the new centered screw pattern
- Internal edge/material-strip inventory reviewed:
  - left display mount holes to screen opening, left button-column envelope, and left wedge outer edge
  - left drawer backplate center screw to backplate perimeter
  - left drawer opening top wall above the lowered divider
  - right-side wedge silhouette after removing the prior overlap workaround
- Evidence:
  - OpenSCAD assertion gate passed for `rev_0027`
  - complete manifest build installed to `output/cyberdeck`
  - `python scripts/scad_build_all.py --design cyberdeck --config designs/cyberdeck/configs/rev_0027.json --audit-only` passed with `10` STL and `170` PNG artifacts (`180` total)
  - visual review of `cyberdeck_left_chamber_rev_0027` and `cyberdeck_two_chamber_structure_rev_0027` confirms:
    - the left divider stays below the lid rail path,
    - the left drawers now use centered screws,
    - the wall-bisected nut bosses are gone,
    - and the right-side outer silhouette is flush again
- Unexpected positive-volume shells: unverified beyond successful OpenSCAD export/manifold success
- Slicer layer-path review: not performed
- Revision destination note:
  - `revisions/cyberdeck/rev_0027/` already existed from an earlier dry-run snapshot and contains only `params.json`
  - the immutable revision installer correctly refused to overwrite that directory
  - this record therefore verifies the current build in `output/cyberdeck`, not a rebuilt immutable `rev_0027` artifact set
- Result: `unverified`
