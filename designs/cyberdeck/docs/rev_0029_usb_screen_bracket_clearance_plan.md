# Cyberdeck rev_0029 USB-to-screen-bracket clearance plan

*Status: Executed — implementation evidence is recorded in `rev_0029_usb_screen_bracket_clearance.md`*

## Problem

Revision `rev_0028` checked the USB-A and USB-C cuts against the `210 mm`
screen opening and the M3 mounting holes, but not against the complete
`250 mm` physical screen mounting bracket. At the existing `x = 136.5 mm`
USB centerline, the `31.75 mm` USB-A flange envelope overlaps the bracket by
`4.375 mm`; the `23 mm` USB-C cut is tangent to it and has zero clearance.

## Approved corrective scope

1. Treat the full `250 mm` screen bracket as a reserved mechanical envelope.
2. Place the USB column outside that envelope with the required `3 mm`
   hardware clearance, using the larger USB-A flange as the controlling cut.
3. Derive the USB-side compact wedge boundary from the USB flange plus the
   required `3 mm` outer-wall material. This increases only the USB side by
   the amount required and aligns the ports to that outside wall.
4. Add named assertions for bracket-to-USB-A-hole, bracket-to-USB-A-flange,
   bracket-to-USB-C-hole, and USB-A-flange-to-outer-wall clearance.
5. Build all manifest parts into the governed current output, inspect the
   relevant face views, run manifest and geometry audits, and create immutable
   `revisions/cyberdeck/rev_0029/` artifacts only after all gates pass.

## Derived target geometry

- Screen bracket half-width: `125.0 mm`
- USB-A flange radius: `15.875 mm`
- Required bracket clearance: `3.0 mm`
- USB column: `125 + 15.875 + 3 = 143.875 mm`
- Required USB-side wedge half-width:
  `143.875 + 15.875 + 3 = 162.75 mm`
- Width increase from `rev_0028`: `162.75 - 155.375 = 7.375 mm`

## Acceptance criteria

- The complete USB-A flange envelope clears the physical screen bracket by at
  least `3 mm`.
- The USB-C cut clears the physical screen bracket by at least `3 mm`.
- The USB-A flange envelope retains exactly the named `3 mm` compact outer-wall
  margin, with no hidden magic-coordinate dependency.
- The screen opening and M3 mounting locations remain unchanged.
- All ten manifest parts render, current-output audit passes, changed-region
  structural and minimum-edge checks pass, and the revision artifact audit
  passes before documentation is marked complete.
