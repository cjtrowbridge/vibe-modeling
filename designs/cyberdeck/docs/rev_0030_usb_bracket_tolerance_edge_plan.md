# Cyberdeck rev_0030 USB bracket-tolerance edge correction

*Status: Executed — implementation evidence is recorded in `rev_0030_usb_bracket_tolerance_edge.md`*

## Failure in rev_0029

`rev_0029` reserved the physical `250 mm` bracket body but omitted the existing
`5 mm` side tolerance. The true no-hardware envelope is therefore `260 mm`
wide, or `+/-130 mm` from the screen center. The USB-A flange's inner edge was
at `128 mm`, leaving it `2 mm` inside that tolerance envelope.

## Correction

1. Use the complete bracket tolerance half-width:
   `250 / 2 + 5 = 130 mm`.
2. Derive the USB center from that boundary, the `15.875 mm` USB-A flange
   radius, and the required `3 mm` clearance:
   `130 + 15.875 + 3 = 148.875 mm`.
3. Derive the compact USB-side outside wall from the same flange envelope plus
   its `3 mm` exterior material land:
   `148.875 + 15.875 + 3 = 167.75 mm`.
4. Validate every USB clearance assertion against the tolerance envelope, not
   the smaller bracket-body envelope.
5. Keep the screen opening, M3 screen holes, drawer geometry, divider, and seam
   unchanged.
6. Build and audit the complete manifest as current `rev_0030`, visually review
   the face, then create and audit immutable `revisions/cyberdeck/rev_0030/`.
7. Because the added USB-side width makes the right lid `223.45 mm` wide,
   validate its existing rectangular footprint at a `45 degree` print-bed
   orientation (`215.28 mm` square bounding span) rather than reducing the
   required USB clearance to preserve axis-aligned placement.

## Acceptance criteria

- USB-A flange to bracket-tolerance envelope: at least `3 mm`.
- USB-C hole to bracket-tolerance envelope: at least `3 mm`.
- USB-A flange to outside wall: exactly the named `3 mm` minimum land.
- Right lid: fits the `220 mm` square print bed at `45 degrees`.
- All ten manifest parts and all artifact/provenance audits pass.
