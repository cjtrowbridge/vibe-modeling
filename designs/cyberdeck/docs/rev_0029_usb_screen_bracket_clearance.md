# Cyberdeck rev_0029 USB-to-screen-bracket clearance repair

> Superseded by `rev_0030`: this revision reserved the `250 mm` bracket body
> but omitted its `5 mm` side tolerance, leaving the USB-A flange `2 mm` inside
> the complete tolerance envelope.

Config: `designs/cyberdeck/configs/rev_0029.json`

Plan: `designs/cyberdeck/docs/rev_0029_usb_screen_bracket_clearance_plan.md`

## Implemented correction

- Replaced the fixed `136.5 mm` USB column with a datum derived from the full
  `250 mm` physical screen-bracket width, the `31.75 mm` USB-A flange envelope,
  and the required `3 mm` hardware clearance.
- Moved the USB column to `x = 143.875 mm` relative to the screen center.
- Increased only the USB-side compact wedge half-width from `155.375 mm` to
  `162.75 mm`, a `7.375 mm` increase.
- Kept the screen opening and symmetric M3 screen-mount columns unchanged.
- Added explicit assertions for the USB-A hole, USB-A flange, and USB-C hole
  against the complete screen-bracket envelope.
- Added an assertion that the compact USB-A flange remains aligned to the
  outside wall with the required minimum material land.

## Measured clearances

- Physical screen-bracket half-width: `125.0 mm`
- USB-A hole to bracket: `4.375 mm`
- USB-A flange envelope to bracket: `3.0 mm`
- USB-C hole to bracket: `7.375 mm`
- USB-A flange envelope to USB-side outside wall: `3.0 mm`
- Screen M3 columns: unchanged at `x = +/-115 mm`
- Screen opening width: unchanged at `210 mm`

## Structural verification record

- Exact source/config: `designs/cyberdeck/configs/rev_0029.json`
- Minimum wall thickness: `3.0 mm`
- Minimum structural overlap: `3.0 mm`
- Minimum internal edge width: `3.0 mm`
- Config SHA-256:
  `cdfc7a0f6157a2e3b12bdec58fd4968414003a320442265ef6f510f118e5d8ba`
- Source-tree SHA-256:
  `63d4b21fe428ec8cc2ca115cef89e256e7e964e29e7bad6f222ca72d86b3eb4f`
- Parameter/assertion gate: passed for all ten manifest parts.
- Visual review: passed on the complete structure's front orthographic and
  front-left isometric renders; the USB pair is moved outward and retains a
  consistent outside-wall land.
- STL connectivity audit:
  - every individual printable STL contains one connected triangle component,
  - the assembled two-chamber structure contains one connected component,
  - the removable-panel set contains three intentional removable components.
- Slicer layer-path review: not performed because no supported command-line
  slicer is installed in the workspace.
- Structural joins result: `unverified` pending slicer layer-path review of the
  exact revision artifacts. This correction moves an existing continuous shell
  boundary and introduces no new structural join.
- Minimum internal edge/material width result: `passed` for the changed
  screen-bracket-to-port and port-to-outside-wall regions through named
  assertions and exact derived dimensions.

## Artifact audit

Current destination:

- Directory: `output/cyberdeck/`
- Build scope: complete manifest
- Expected/actual: `10/10 STL`, `170/170 PNG`, `180/180 artifacts`
- Audit-only result: passed

Immutable revision destination:

- Directory: `revisions/cyberdeck/rev_0029/`
- Build scope: complete manifest
- Expected/actual: `10/10 STL`, `170/170 PNG`, `180/180 artifacts`
- Audit result: passed

Both manifests record the same config and source-tree hashes. The independently
rendered STL files are not byte-identical, but their topology audit yields the
same intended component structure; the PNG hashes are identical. Generated
`output/` and `revisions/` artifacts remain outside the source commit scope.
