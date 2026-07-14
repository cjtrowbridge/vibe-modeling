# Cyberdeck rev_0026 notes

Config: `designs/cyberdeck/configs/rev_0026.json`

Scope:

- move the left display mount holes into the actual left wedge margin instead of keeping them on the old symmetric x-offset
- move the left drawer captive hardware support from the drawer backplates to chamber-side nut-boss pockets
- remove the coplanar tray/profile overlap that was showing as a visible side-wall seam at the wedge transition

Geometry notes:

- the right display mount holes remain on the previous right-side x datum
- the left display mount holes are now derived from the available space between the left arcade-button envelope and the left outer wedge edge
- the left chamber now owns the tray captive-nut seating geometry on the chamber side, while the drawers keep simple M3 clearance holes in their backplates
- the wedge shell and lower tray now overlap by `chamber_shell_wedge_tray_overlap`, with the wedge shell owning the wedge-span outer profile

Structural verification record:

- Source revision/config: `designs/cyberdeck/configs/rev_0026.json`
- Minimum wall thickness: `3.0 mm`
- Minimum structural overlap: `3.0 mm`
- Minimum internal edge width: `3.0 mm`
- Join inventory reviewed:
  - wedge shell to flat tray overlap at the display-wedge span
  - chamber-side left drawer nut-boss attachments to the front and rear walls
- Internal edge/material-strip inventory reviewed:
  - left display mount holes to screen opening
  - left display mount holes to left wedge outer edge
  - left display mount holes to left arcade-button holes
  - right display mount holes to right-side port holes
  - chamber-side left drawer nut-boss wall thickness around the M3 nut traps
- Evidence:
  - OpenSCAD assertion gate passed for `rev_0026`
  - complete manifest build installed to `output/cyberdeck`
  - manifest audit passed for `output/cyberdeck` with 10 STL and 170 PNG artifacts
- Unexpected positive-volume shells: not reviewed beyond OpenSCAD export/manifold success
- Slicer layer-path review: not performed
- Result: `unverified`
