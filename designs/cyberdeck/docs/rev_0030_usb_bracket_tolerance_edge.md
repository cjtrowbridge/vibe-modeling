# Cyberdeck rev_0030 USB bracket-tolerance edge correction

Config: `designs/cyberdeck/configs/rev_0030.json`

Plan: `designs/cyberdeck/docs/rev_0030_usb_bracket_tolerance_edge_plan.md`

## Implemented correction

- Corrected the `rev_0029` datum to include both the `250 mm` physical screen
  bracket and its two `5 mm` side tolerances.
- Moved the screen-face USB column from `x = 143.875 mm` to
  `x = 148.875 mm` relative to the screen center.
- Increased the USB-side compact wedge half-width from `162.75 mm` to
  `167.75 mm`, keeping the USB-A flange aligned to the outer wall with the
  required material land.
- Changed all screen-bracket/USB assertions to measure from the complete
  tolerance-envelope edge at `x = 130 mm`.
- Kept the screen opening, symmetric M3 screen holes, drawers, divider, merge
  seam, and opposite-side face hardware unchanged.
- Added a named 45-degree print-span check for the now `223.45 mm`-wide right
  lid. Its `215.28 mm` rotated bounding span fits the `220 mm` square bed.

## Verified clearances

- Screen bracket plus tolerance half-width: `130.0 mm`
- USB-A through-hole to tolerance envelope: `4.375 mm`
- USB-A flange envelope to tolerance envelope: `3.0 mm`
- USB-C through-hole to tolerance envelope: `7.375 mm`
- USB-A flange envelope to USB-side outside wall: `3.0 mm`
- USB-side width increase from `rev_0029`: `5.0 mm`

## Structural verification

- Exact config: `designs/cyberdeck/configs/rev_0030.json`
- Minimum wall thickness: `3.0 mm`
- Minimum structural overlap: `3.0 mm`
- Minimum internal edge width: `3.0 mm`
- Config SHA-256:
  `cd993c0b69797cf55dd5edaca19a48dbd5b1eec5377b8b815ddf7183b7abbccc`
- Source-tree SHA-256:
  `ee1a53248e581e45d4b03a41c4ad497b90d3ef47f48f9e952a18c8d56bbd1ffa`
- OpenSCAD assertion and complete-render gate: passed for all ten parts.
- Full-structure manifold probe: `Simple: yes`.
- STL connectivity:
  - every individual printable STL has one connected triangle component,
  - the assembled two-chamber structure has one connected component,
  - the removable-panel set has three intentional removable components.
- Visual front-orthographic review: passed; the physical-left USB column moved
  the full omitted `5 mm` outward and retains a consistent outer-wall land.
- Slicer layer-path review: not performed because no supported command-line
  slicer is installed in the workspace.
- Structural joins: `unverified` pending slicer layer-path review of the exact
  revision; this correction moves an existing continuous shell boundary and
  creates no new structural join.
- Minimum internal edge/material width: `passed` for the changed USB-to-screen
  tolerance, USB-to-outer-wall, and right-lid print-fit regions through named
  assertions and exact derived dimensions.

## Artifact audit

Current build:

- Scope: complete manifest
- Destination: `output/cyberdeck/`
- Expected/actual: `10/10 STL`, `170/170 PNG`, `180/180 artifacts`
- Audit: passed

Immutable revision:

- Scope: complete manifest
- Destination: `revisions/cyberdeck/rev_0030/`
- Expected/actual: `10/10 STL`, `170/170 PNG`, `180/180 artifacts`
- Audit: passed

The current and immutable manifests record identical config, parts-manifest,
and source-tree hashes. Generated artifacts remain outside the source commit.
