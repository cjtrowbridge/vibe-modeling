# cyberdeck

First-draft visual mockup and design brief for a cyberdeck OpenSCAD model.

## Current scope

- Creates the standard design folder layout.
- Provides a `main.scad` scripted export entrypoint.
- Provides a minimal `rev_0001.json` config with numeric `part_id`.
- Provides a first-draft visual mockup for layout review.
- Adds a two-piece open chamber structure for print-bed-constrained enclosure planning.
- Uses known dimensions from the design brief where available.
- Uses clearly named proxy dimensions for hardware that still needs exact mechanical measurement.
- Does not yet define printable enclosure details, final mounting geometry, wiring channels, or manufacturable clearances.

## Historical Part IDs

The source retains these IDs for historical configs and direct exports. The authoritative current part set is `parts.json`; rev_0006 intentionally excludes obsolete visual mockups, dome/handle parts, the removed left lid, and the Raspberry Pi side tray.

- `part_id = 0`: full visual mockup
- `part_id = 1`: top layout mockup
- `part_id = 2`: internal hardware proxy layout
- `part_id = 3`: two-piece open chamber structure
- `part_id = 4`: left open chamber printable body
- `part_id = 5`: right open chamber printable body
- `part_id = 6`: four removable panel preview layout
- `part_id = 7`: left-front inset lid
- `part_id = 8`: center-left inset lid
- `part_id = 9`: right-front inset lid
- `part_id = 10`: left-side carrying handle
- `part_id = 11`: dome bucket insert
- `part_id = 12`: right chamber Orange Pi tray
- `part_id = 13`: removable full-width rear-roof I/O panel
- `part_id = 14`: right chamber Raspberry Pi side tray
- `part_id = 15`: dome pan servo cradle
- `part_id = 16`: dome pan rotating plate
- `part_id = 17`: dome tilt servo yoke
- `part_id = 18`: dome camera and dual-laser carriage
- `part_id = 19`: dome gimbal clearance mockup
- `part_id = 20`: left chamber battery drawer
- `part_id = 21`: left chamber Meshtastic drawer

## Design Notes

- Dome pan/tilt apparatus planning is tracked in [docs/dome_pan_tilt_plan.md](docs/dome_pan_tilt_plan.md).
- The dome mechanism plan uses two MG996R-compatible servos: one fixed vertical pan servo in the bucket and one horizontal tilt servo carried by the rotating pan stage.
- The plan requires stock servo horns captured in printed receiver pockets instead of direct printed splines.
- The first implementation should be a serviceable gimbal cartridge with a supported pan plate, two-sided tilt yoke, camera/dual-laser carriage, hard stops, wire relief, and swept-volume checks inside the acrylic dome.
- Actual horn and camera mounting dimensions still need measurement before final receiver pockets and camera screw bosses are modeled.
- The first CAD implementation exports the dome mechanism as separate prototype units rather than merging them into the existing bucket STL:
  - pan servo cradle,
  - pan rotating plate,
  - tilt servo yoke,
  - camera plus dual-laser carriage,
  - assembled bucket/dome clearance mockup.
- The prototype uses the documented MG996R shaft-centered pan mount pattern and stock-horn receiver pockets with center-screw access.
- The tilt stage is intentionally low-profile so the `32 mm x 32 mm` camera board and two `12 mm x 35 mm` laser modules remain within the `115 mm` acrylic dome envelope.
- The laser carriage includes one laser saddle on each side of the camera, rear wire exits, a camera pigtail relief, and cable-routing clearance toward the existing front/side bucket passthrough windows.
- The horn receiver and camera mounting-hole positions remain starter defaults pending caliper measurement of the actual horn and camera PCB.

## Revision 0025 Drawer Nut-Boss Fastening Redesign

- Revision `rev_0025` replaces the previously unusable left-drawer plain through-hole mounting condition with modeled hardware pockets.
- Each left drawer backplate now includes two inward-projecting cylindrical nut bosses on the drawer side of the backplate, centered on the existing M3 screw bores.
- Each boss contains a blind hex M3 nut trap, so the drawer can be fastened with exterior screws through the chamber wall into trapped nuts instead of requiring loose hardware in the inaccessible chamber-side gap.
- The left drawer backplate flange footprint increases to support those nut bosses while keeping the required minimum material around the hole edges, the nut pockets, and the backplate perimeter.
- The chamber-side holes remain simple exterior-access screws; the meaningful usability change in this revision is the modeled nut volume and structure on the drawer side.

### Revision 0025 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0025.json` with source-tree hash `c2e0b75854574f6cc88bd5a253aa56f389d5946d938820dd3b17c081cc7a8694`.
- Build scope: complete ten-part manifest installed to both `revisions/cyberdeck/rev_0025` and `output/cyberdeck`. Both complete-build audits passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: both `revisions/cyberdeck/rev_0025/build_manifest.json` and `output/cyberdeck/build_manifest.json` match `designs/cyberdeck/configs/rev_0025.json` and `designs/cyberdeck/parts.json`. The config hash is `6135550b094bedf0edac39be6facee446b9bcb7413fbbc8b5dce802f0f946e6b`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions require the nut-trap depth to fit within the added boss depth, require at least the repository minimum wall material around the hex nut pockets, and require the enlarged boss footprints to remain fully inside the drawer backplate footprint while preserving the existing screw-hole edge margins.
- Visual review: audited the `rev_0025` left battery and Meshtastic drawer renders to confirm the new internal nut-boss geometry is present on both drawer backplates.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest builds.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: passed for the changed drawer-backplate fastening bosses and nut-pocket support geometry by construction and assertion; overall enclosure structural verification remains incomplete pending broader section and slicer review.
- Minimum internal edge/material width: passed for the rev_0025 changed geometry, including the enlarged backplate flanges and the remaining material around the nut traps and screw bores.
- Fabrication status: improved hardware usability for the left drawers, but not fully print-ready while the remaining whole-design section review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0024 Divider-Flush Drawer Openings and Wider Screw Margins

- Revision `rev_0024` removes the remaining divider-end notch mismatch in the left chamber by shifting each drawer opening so its divider-side edge terminates exactly flush with the center divider instead of overcutting into it.
- The front battery opening moves `1 mm` outward toward the left outer wall, and the rear Meshtastic opening moves `1 mm` outward toward the right outer wall of its lane, matching the existing `1 mm` slide-clearance offset that had previously been cutting into the divider.
- The left drawer backplate screw side offset increases from `4.8 mm` to `6.0 mm` so the tighter opening-to-screw ligaments at both the front and rear walls are no longer visually crowded.
- The drawer lanes themselves are unchanged; only the opening placement and the screw-column lateral offset change in this revision.

### Revision 0024 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0024.json` with source-tree hash `60b8e1b95653bbac4eaa4450410d6d3e8d5b46eefea3ed56e29b863001d382dd`.
- Build scope: complete ten-part manifest installed to both `revisions/cyberdeck/rev_0024` and `output/cyberdeck`. Both complete-build audits passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: both `revisions/cyberdeck/rev_0024/build_manifest.json` and `output/cyberdeck/build_manifest.json` match `designs/cyberdeck/configs/rev_0024.json` and `designs/cyberdeck/parts.json`. The config hash is `c711a4588d593176e7f699f981ec920d0d470a7f1c1b03e9d8f457f27920dd98`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions require both divider-side opening edges to land flush on the divider faces by construction, preserve the existing divider-end ligament minimum, and keep the left drawer backplate screw holes beyond the minimum required opening-edge clearance.
- Visual review: audited the updated `rev_0024` complete-build renders to confirm that the front and rear tray-opening cuts now stop at the divider faces and that the screw holes no longer crowd the front and rear opening edges.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest builds.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: passed for the changed left-chamber divider/opening terminations by construction and assertion; overall enclosure structural verification remains incomplete pending broader section and slicer review.
- Minimum internal edge/material width: passed for the rev_0024 changed geometry, including the divider-end ligaments and the front/rear opening-to-screw remaining wall widths.
- Fabrication status: not print-ready while the remaining whole-design section review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0023 Left-Chamber Divider-End Overlap Repair

- Revision `rev_0023` repairs the left-chamber center divider after review showed that the front and rear drawer-opening clearances were nibbling into the divider ends.
- The divider thickness increases from `3 mm` to `5 mm`.
- The front battery opening and rear Meshtastic opening still each overcut `1 mm` into the divider because of the existing `1 mm` slide clearance per side.
- That means the repaired end ligament is now `4 mm` at each affected divider-to-wall joint instead of the prior `2 mm`.
- The drawer lane side margins remain above the repository minimum after the thicker divider because the extra divider width is absorbed from the previously unused side margin.

### Revision 0023 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0023.json` with source-tree hash `9c6e402caccc9d9d1cc8e07dbcd6ca0a39ca655fbaed3adbc1d1db43f841d680`.
- Build scope: complete ten-part manifest installed to both `revisions/cyberdeck/rev_0023` and `output/cyberdeck`. Both complete-build audits passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: both `revisions/cyberdeck/rev_0023/build_manifest.json` and `output/cyberdeck/build_manifest.json` match `designs/cyberdeck/configs/rev_0023.json` and `designs/cyberdeck/parts.json`. The config hash is `f2aec4be663b574b4063d7db66b7115469f2a3cca9bfd357349af38661d7c5d3`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions now explicitly require the left divider end ligament after drawer-opening clearances to remain at least the `3 mm` repository minimum; at `rev_0023` that modeled ligament is `4 mm`.
- Visual review: audited the updated `rev_0023` left-chamber complete-build renders to confirm the thicker divider and the more substantial divider termination at the front and rear wall regions.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest builds.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: passed for the repaired divider front/rear end joints by construction and assertion; overall enclosure structural verification remains incomplete pending broader section and slicer review.
- Minimum internal edge/material width: passed for the rev_0023 changed geometry, including the repaired divider-end ligaments after the opening clearances.
- Fabrication status: not print-ready while the remaining whole-design section review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0022 Battery Drawer Display Window and Left-Handle Recenter

- Revision `rev_0022` adds a rectangular display-view window through the outer wall of the left battery drawer and a matching rectangular window through the left chamber outer wall behind it.
- The shared nominal viewing zone runs from `80 mm` to `140 mm` back from the front wall, for a `60 mm` front-to-rear span.
- The shared nominal viewing zone runs from `15 mm` to `50 mm` above the battery-drawer inside floor, for a `35 mm` vertical span.
- Because the drawer outer wall and chamber outer wall are separated by the existing left-lane side gap, the result is a viewing tunnel rather than one single-thickness opening.
- The left-side handle mounting-hole datum is now re-derived from the battery-display window center so the chamber-side handle pattern is centered on the new viewing zone instead of remaining centered on the chamber length.
- Under the existing `26 mm x 26 mm` handle plate hole pattern and `3.4 mm` M3 clearance holes, the nearest window-edge to handle-hole edge ligament is about `5.3 mm`, not `6 mm`.
- The revision keeps the current handle hardware family and pattern because that `5.3 mm` local ligament remains above the repository `3 mm` minimum internal-edge requirement.

### Revision 0022 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0022.json` with source-tree hash `5711e0a45f54cd4f7237d9d56bafff2c47147dab5ccde81506bdea332355f137`.
- Build scope: complete ten-part manifest installed to both `revisions/cyberdeck/rev_0022` and `output/cyberdeck`. Both complete-build audits passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: both `revisions/cyberdeck/rev_0022/build_manifest.json` and `output/cyberdeck/build_manifest.json` match `designs/cyberdeck/configs/rev_0022.json` and `designs/cyberdeck/parts.json`. The config hash is `6b6d0cddf0bba796c718ae0dad95f1f69df913ed6ef20573e748ca6e816fe794`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions cover drawer-window front/rear and top/bottom remaining-wall margins, chamber-window front/rear and top/bottom remaining-wall margins, and the minimum chamber-wall ligament from the relocated handle holes to the new window.
- Visual review: audited the updated `rev_0022` complete-build renders to confirm the new battery-drawer side window, the matching left outer-wall opening, and the rear-shifted left-handle hole pattern centered on that viewing zone.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest builds.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review covers the changed left outer-wall region, the existing chamber seams, and the window tunnel area.
- Minimum internal edge/material width: passed for the rev_0022 changed geometry via the updated assertion set, including the new window-to-handle-hole ligament checks.
- Fabrication status: not print-ready while the sectioned structural review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0021 Reduced Base Height

- Revision `rev_0021` reduces the flat chamber/body height by `10 mm`, from `85 mm` overall to `75 mm` overall.
- The named chamber clearance parameter drops from `82 mm` to `72 mm`.
- Because the flat lid rail remains inset `2 mm` below the deck top, the actual floor-to-lid underside clearance drops from `80 mm` to `70 mm`.
- The flat-lid clearance contract is now explicit as `chamber_min_flat_lid_internal_clearance_z = 70 mm` rather than being hard-coded in the assertion text.
- This keeps the current left-drawer opening stack valid: the drawer opening still tops out at `68 mm`, leaving `7 mm` to the new `75 mm` flat deck and preserving the repository `3 mm` minimum top-wall material requirement.
- The peaked rear housing lowers with the chamber body, so the overall peak height drops by the same `10 mm`, from approximately `152.175 mm` to `142.175 mm`.

### Revision 0021 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0021.json` with source-tree hash `3bd8a262e6f7cc5d428e41e449afe4d5f7fef0e2f460d4a0605082349e17748c`.
- Build scope: complete ten-part manifest installed to both `revisions/cyberdeck/rev_0021` and `output/cyberdeck`. Both complete-build audits passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: both `revisions/cyberdeck/rev_0021/build_manifest.json` and `output/cyberdeck/build_manifest.json` match `designs/cyberdeck/configs/rev_0021.json` and `designs/cyberdeck/parts.json`. The current output config hash is `6e19af7f7f6dff960d45b44857508d221e2da43e078dfc48cc49c130ad3a9c87`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions cover the reduced flat-lid clearance contract, while the existing drawer-opening, tray-opening, power-cell-opening, rear-fan, and print-envelope assertions all still pass at the lower body height.
- Visual review: audited the updated rev_0021 complete-build renders to confirm the shorter enclosure profile and unchanged drawer/backplate fit.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest builds.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review covers the lowered chamber/wedge transitions and the existing enclosure seams.
- Minimum internal edge/material width: passed for the rev_0021 changed geometry via the existing assertion set, including the reduced remaining top-wall material above the left drawer openings.
- Fabrication status: not print-ready while the sectioned structural review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0020 Left-Side Arcade Buttons and Right-Side Screen-Face USB Ports

- Revision `rev_0020` moves the two angled screen-face arcade-button holes from the right side of the display opening to the left side.
- The new left-side arcade-button column shifts inward to `x = -123 mm` relative to the screen center so it clears the current compact left wedge without widening the chassis again.
- The right side of the angled screen face now carries one `29 mm` USB-A hole and one `23 mm` USB-C hole, vertically stacked at the prior `40 mm` spacing and anchored at `x = +136.5 mm`.
- The compact wedge envelope remains effectively the `rev_0019` asymmetric shape because the left-side button relocation is handled by moving the button column inward rather than by broadening the shell.

### Revision 0020 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0020.json` with source-tree hash `bfe284f87a4b9573b6f9879a5d6f850ce42427d196615ad941c78abfa660f16c`.
- Build scope: complete ten-part manifest installed to both `revisions/cyberdeck/rev_0020` and `output/cyberdeck`. Both complete-build audits passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: both `revisions/cyberdeck/rev_0020/build_manifest.json` and `output/cyberdeck/build_manifest.json` match `designs/cyberdeck/configs/rev_0020.json` and `designs/cyberdeck/parts.json`. The current output config hash is `35ca4060c36300eeb2918ca76ce058e63e039351274a7f135f58d57a42363121`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions cover the inward-shifted left button column, the new right USB-A/USB-C screen-face column, the pairwise hole ligaments, the face-end material margins, and the hardware-to-screen-mount-screw clearances.
- Visual review: audited `output/cyberdeck/cyberdeck_two_chamber_structure_rev_0020_ortho_front.png` confirms the two arcade-button holes now sit left of the screen opening and the new USB-A/USB-C column sits right of the opening.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest builds.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review covers the changed screen-face hole region and the surrounding wedge shell.
- Minimum internal edge/material width: passed for the rev_0020 changed geometry via the updated assertion set.
- Fabrication status: not print-ready while the sectioned structural review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0019 Asymmetric Wedge, Seam Counterbores, and Center-Row Tray Fasteners

- Revision `rev_0019` removes the unintended mirrored left-side screen-wedge growth while preserving the right-side arcade-button clearance contract.
- The compact display wedge is now asymmetric around the preserved display datum: the right half remains `157 mm`, the left half is reduced to about `144.4 mm`, and the effective compact wedge width becomes about `301.4 mm`.
- The left chamber gains a reinforced inner seam strip sized for recessed M3 merge-bolt heads on the seam side, preserving the repository `3 mm` minimum throat behind the new counterbores.
- The right Orange Pi tray, the historical Raspberry Pi side tray, and both new left drawers now use a single reachable middle screw row instead of upper/lower screw rows.
- The tray backplate side offsets are reduced to `4.8 mm`, shrinking the backplates while preserving the `3 mm` minimum material contract to both the openings and the outer edges.
- The left chamber width is re-derived from the actual drawer and backplate packaging requirement rather than from the prior symmetric wedge. Under the new compact datums, the left chamber width is about `168.4 mm` and the remaining drawer side margin is about `10.5 mm`, down from the earlier `16.3 mm`.

### Revision 0019 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0019.json` with source-tree hash `6c471b866a9d50c2674d7442a8f52434f08e7483111921bf765e74fe544c745b`.
- Build scope: complete ten-part manifest installed to `output/cyberdeck`. The complete-build audit passed with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: `output/cyberdeck/build_manifest.json` matches `designs/cyberdeck/configs/rev_0019.json` and `designs/cyberdeck/parts.json`. The current output config hash is `3e3f9f4a28f0ea89d9257ba4da514eb63a72c3e663cbb85f15f95f00287b0ebe`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The updated assertions cover the asymmetric wedge extents, the right-button edge ligaments, the left seam counterbore clearances to the passthroughs and LED passage, the reinforced seam throat, the single-row tray fastener margins, and the reduced left-chamber drawer packaging.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest build.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review. The changed geometry now has assertion-backed wedge, seam, and tray contracts, but this record does not include explicit sectional seam captures through the reinforced left seam or the revised wedge transition.
- Minimum internal edge/material width: passed for the rev_0019 changed geometry via the updated assertion set.
- Fabrication status: not print-ready while the sectioned structural review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0018 Left-Chamber Side-by-Side Drawers

- Revision `rev_0018` adds a side-by-side dual-drawer layout to the widened left chamber.
- The battery drawer occupies the outer left lane and loads from the front of the cyberdeck.
- The Meshtastic drawer occupies the inner right lane and loads from the rear so its outer tray wall remains available for antenna-related follow-on work.
- Both drawer systems are sized around the requested `60 mm x 60 mm x 160 mm` payload envelope with derived slide clearance, `3 mm` walls, `3 mm` backplates, and shared M3 backplate fasteners.
- The left chamber now includes a full-depth central divider between the two drawer lanes. That divider provides the requested right-side support for the battery drawer while also stabilizing the rear Meshtastic drawer.
- Each drawer has a floor and two `60 mm` side walls, with the inboard end intentionally left open.
- The authoritative manifest now exports ten parts: the prior eight rev_0016 outputs plus `cyberdeck_left_battery_drawer` and `cyberdeck_left_meshtastic_drawer`.

### Revision 0018 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0018.json` with source-tree hash `5b1c73b870d5fbe580af85c044a38c42ec254804095d9613734b69195acd259c`.
- Build scope: complete ten-part manifest. `output/cyberdeck` passed the complete-build audit with `10` STL, `170` PNG, and `180` modeled artifacts, with no missing or unexpected files.
- Provenance: `output/cyberdeck/build_manifest.json` matches `designs/cyberdeck/configs/rev_0018.json` and `designs/cyberdeck/parts.json`. The current output config hash is `d2197644c0c1ff9dd867f639ca74bfd05ec0616df660d440c328885c2daa0422`; the parts-manifest hash is `decbe84edb26ea91bb861240190a24fa28f09a019acc1420c7171a13c0de1ea9`.
- Parameter and post-subtraction gates: passed. The new left-chamber assertions enforce the dual-lane side margins, the divider placement, the backplate screw edge margins, the rear opening's clearance from the existing Power Cell port, and the `160 mm` drawer depth fit inside the available chamber length.
- Visual review: audited `rev_0018` front, rear, and underside renders confirm the new front battery-drawer opening, the rear Meshtastic-drawer opening, the shared divider inside the left chamber, and the two new exported drawer parts.
- Connectivity gate: unverified in this record because no separate shell-topology audit was run beyond the successful OpenSCAD manifest build.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review. The changed geometry now has assertion-backed lane/divider/backplate contracts, but this record does not include explicit sectional seam captures through the new divider and opening margins.
- Minimum internal edge/material width: passed for the rev_0018 changed geometry via the new assertion set.
- Fabrication status: not print-ready while the sectioned structural review, shell/connectivity audit, and slicer gate remain incomplete.

## Revision 0016 Widened Screen Wedge and Right-Side Arcade Buttons

- Revision `rev_0016` widens the compact display wedge/body from `260 mm` to `314 mm` and adds two `28 mm` arcade-button mounting holes on the angled screen face to the right of the display opening.
- The planned `345 mm` wedge target was not printable under the existing `220 mm` X-axis build limit and would also have pushed the removable rear I/O panel beyond its supported `45 degree` print span. The implemented width is the largest value that keeps the current print contract while still fitting the new buttons with the required margins.
- The two new screen-face button holes share `x = +136.5 mm` relative to the screen center and are vertically stacked on the face with `40 mm` center-to-center spacing.
- The rear removable I/O panel remains printable because its width is no longer tied directly to the widened wedge; it stays centered on the display zone at the previous nominal printable width instead of expanding to the full new body width.
- The compact body's right-aligned Orange Pi tray remains unchanged, but the wider shell shifts the split and increases the left printable half from approximately `123.6 mm` to `177.6 mm` while the right half remains approximately `136.4 mm` wide.
- The wider body materially improves left-chamber width for later storage work, but it does not by itself resolve the previously blocked dual-`160 mm` drawer concept, which remains constrained by front-to-back depth and the low flat-lid clearance region.

### Revision 0016 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0016.json` with source-tree hash `02bccc2e1353e36ee238b30db39e482e3b7fa73b8a1828a089df4d85f5d6435d`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0016` passed independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both build manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. The widened `314 mm` screen wedge remains within the `220 mm` print-axis envelope, the centered rear I/O panel remains within its `45 degree` printable span, and the new screen-face arcade-button holes retain the modeled minimum ligaments to the display opening, the screen-mount holes, the face boundaries, and the new outer wedge edge.
- Visual review: audited front and top views confirm the widened display wedge and the two new right-of-screen arcade-button holes on the angled display face.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review; the changed screen-face and widened-wedge geometry pass their assertion-backed overlap and edge-width contracts, but this revision record does not include isolated section exports for every changed seam.
- Minimum internal edge/material width: passed for the rev_0016 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0013 Minimum-Tab Lid Mounts

- Revision `rev_0013` pushes the lid and roof-panel corner mounts to the smallest tabs permitted by the current `3 mm` minimum edge-width contract and the existing `7 mm` M3 counterbore head diameter.
- The corner-screw inset is reduced from `7.0 mm` to `6.5 mm`, which is the smallest value that still leaves the required `3 mm` of lid material outside the recessed counterbores.
- The corner-pad size is reduced from `15.0 mm` to `13.4 mm`, leaving only about `0.1 mm` of modeled margin above the minimum required rail overlap and support-hole material limits.

### Revision 0013 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0013.json` with source-tree hash `4526bd802bdacdb2d854b8ba4a4e959d1bd9ccbea55ab5377201c5ef37002d9e`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0013` passed independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both build manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. The `6.5 mm` inset preserves the required `3 mm` outer lid margin to the `7 mm` counterbores, and the `13.4 mm` corner pads retain the minimum support-hole material and approximately `3.1 mm` of front-lid rail overlap in the final assertion set.
- Visual review: audited `rev_0013` top views confirm the center lid, right lid, and roof I/O panel use the tightest current corner tabs while preserving the shared M3 recessed-fastener layout.
- Connectivity gate: passed. The left and right chamber exports are manifold (`Simple: yes`) and each has one connected vertex component. Their triangle counts remain `8506` and `5944` in the current audited output.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review; the changed lid-support and roof-panel support joins still pass their overlap assertions but were not isolated in a dedicated slice export for this revision record.
- Minimum internal edge/material width: passed for the rev_0013 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0012 Balanced Lid-Mount Update

- Revision `rev_0012` standardizes the angled screen-face mounting holes to the same `3.4 mm` M3-clearance pattern used elsewhere in the enclosure.
- The shared flat-lid support geometry is reduced from a `7 mm` rail and `16 mm` corner pads at `8 mm` inset to a `6.5 mm` rail and `15 mm` corner pads at `7 mm` inset.
- The removable lids and the roof I/O panel inherit the same updated corner mounting-point positions, reducing the visible corner tabs while keeping the existing M3 counterbore scheme.

### Revision 0012 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0012.json` with source-tree hash `eac880ac675f24ea2f03acdcfd50efd21be320f0adc17e389973df2fcccdcf1f`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0012` passed independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both build manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. The screen-face holes now use `3.4 mm` M3 clearance, the front-lid and roof-panel support rails remain at or above the `3 mm` minimum material contract, and the reduced corner pads still retain approximately `3.4 mm` of asserted overlap onto the front lid rails.
- Visual review: audited `rev_0012` lid and panel views confirm the corner screws moved outward on the center lid, right lid, and roof I/O panel, and the enclosure front view confirms the smaller screen mounting holes on the angled display face.
- Connectivity gate: passed. The left and right chamber exports are manifold (`Simple: yes`) and each has one connected vertex component. Their triangle counts are `8506` and `5944` in the current audited output.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until dedicated section and slicer layer-path review; the changed lid-support and roof-panel support joins retain their asserted overlap, but this revision record does not include an isolated slice export.
- Minimum internal edge/material width: passed for the rev_0012 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0011 Handle-Mount Ligament Verification

- Revision `rev_0011` records the final handle-mount source after explicit M3 hole-to-hole ligament assertions were added.
- The assertions require at least `3 mm` of remaining material both between adjacent holes in a mounting row and between the two handle-mount groups.

### Revision 0011 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0011.json` with source-tree hash `d03feafbaeaa55b97a94bdd794fbbe4609cbb70e6fdf7e8a3f0046e33c5fb0af`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0011` passed independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both build manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. Compact mode now restores the historical left-side handle-hole pattern, and the added pairwise ligament assertions require at least `3 mm` of remaining material both within each hole row and between the two mounting groups.
- Connectivity gate: passed. The left and right chamber exports are manifold (`Simple: yes`) and each has one connected vertex component. Their triangle counts are `8482` and `5904` in the current audited output.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until slicer layer-path review; this change restores exterior fastener holes and does not introduce a new joined structural member.
- Minimum internal edge/material width: passed for the rev_0011 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0010 Left-Side Handle Mount Pattern Restored

- Revision `rev_0010` restores the historical left-side handle mounting-hole pattern to the compact left chamber.
- The current manifest remains dome-free and does not export the historical standalone handle; this revision restores only the eight M3 clearance holes in the enclosure's left exterior wall for a future compatible handle.
- The taller `80 mm` actual internal clearance places the two screw rows at approximately `z = 29.5 mm` and `z = 55.5 mm`, retaining the existing asserted wall-edge margins.

### Revision 0010 Verification Record

- Initial geometric checkpoint only. The immutable `revisions/cyberdeck/rev_0010` artifact set was retained, but the final source for this task added explicit hole-to-hole ligament assertions and was recorded as `rev_0011`.

## Revision 0009 Increased Internal Height

- Revision `rev_0009` increases the flat-lid interior from the previous `48 mm` actual floor-to-lid clearance to `80 mm`.
- The named `chamber_internal_clearance_z` is `82 mm` rather than `80 mm` because the installed lid-support rail is intentionally inset `2 mm` below the flat deck; the resulting floor-to-lid underside distance is exactly `80 mm`.
- The flat enclosure height increases from `53 mm` to `85 mm`, and the unchanged screen profile rises with it from approximately `120.175 mm` to `152.175 mm` peak height. This remains within the configured `220 mm` print-height limit.
- The Orange Pi tray geometry, its right-aligned installed placement, and the horizontal split at `x = 56.1 mm` are unchanged.

### Revision 0009 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0009.json` with source-tree hash `213e66241ca4ebba13bdd985c057894cdf35e93b9894ef128b6c1215381c2292`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0009` passed independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both build manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. `chamber_flat_lid_internal_clearance_z()` asserts the required `80 mm` actual floor-to-lid clearance; print-envelope, tray, split, cutout, and fastener ligament assertions also passed at the taller profile.
- Section gate: passed for the relocated seam at front (`y = -90 mm`), middle (`y = 0 mm`), and rear (`y = 90 mm`) slices; each showed continuous final material through the taller seam.
- Connectivity gate: passed. The left and right chamber exports are manifold (`Simple: yes`) and each has one connected vertex component. Their horizontal envelopes remain approximately `123.6 mm x 212 mm` and `136.4 mm x 212 mm`; peak height is approximately `152.175 mm`.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until slicer layer-path review; changed-geometry parameter, section, post-subtraction, and connectivity gates passed.
- Minimum internal edge/material width: passed for the rev_0009 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0008 Right-Aligned Orange Pi Tray

- Revision `rev_0008` right-aligns the Orange Pi tray backplate against the compact body's right wall, retaining the required `3 mm` wall margin.
- The compact split remains derived from the tray's left edge minus `minimum_internal_edge_width`. With the tray moved right, the seam moves to approximately `x = 56.1 mm`.
- The charger-side left half is approximately `123.6 mm x 212 mm x 120.175 mm`; the Orange Pi right half is approximately `136.4 mm x 212 mm x 120.175 mm`.
- The unused space that was formerly to the tray's right is now part of the charger-side chamber. The tray opening and backplate fastener cuts remain in the physical right half.
- The historical non-compact layout remains left-aligned, preserving compatibility with earlier revisions.

### Revision 0008 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0008.json` with source-tree hash `3b0d3dbfb5209da088eb4a1241e355d6fe3d685d719cc97d4e6991eca055a770`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0008` passed independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both build manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. Assertions select right-aligned tray placement only for compact mode, retain the `3 mm` tray-to-right-wall margin, derive the split `3 mm` left of the tray, and retain the charger cutout's material margin to its new split.
- Section gate: passed for the relocated seam at front (`y = -90 mm`), middle (`y = 0 mm`), and rear (`y = 90 mm`) slices; each showed continuous final material through the seam.
- Connectivity gate: passed. The left and right chamber exports are manifold (`Simple: yes`) and each has one connected vertex component. Their measured envelopes are approximately `123.6 mm x 212 mm x 120.175 mm` and `136.4 mm x 212 mm x 120.175 mm`.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until slicer layer-path review; changed-geometry parameter, section, post-subtraction, and connectivity gates passed.
- Minimum internal edge/material width: passed for the rev_0008 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0007 Tray-Left Split Correction

- Revision `rev_0007` keeps the compact body but corrects the two-piece split orientation: it is now `x = 0 mm`, immediately to the left of the Orange Pi tray backplate.
- The split is derived as the installed Orange Pi backplate's left edge minus `minimum_internal_edge_width`; the current backplate begins at `x = 3 mm`, so the seam is `3 mm` clear of it.
- The left print half contains the rear Power Cell/charger opening and is approximately `67.55 mm x 212 mm x 120.175 mm`; the right print half contains the Orange Pi rear tray and is approximately `192.55 mm x 212 mm x 120.175 mm`.
- The charger opening's right edge remains `22.25 mm` from the new split, exceeding the `3 mm` minimum internal-edge requirement. The Orange Pi rear-opening cut is again emitted only in the physical right half.
- This supersedes the revision 0006 split placement only; the compact body footprint, dome/left-opening removal, and Raspberry Pi tray/opening removal remain unchanged.

### Revision 0007 Verification Record

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0007.json` with source-tree hash `e7a1c7097316cbf874ec79972447fdfe8c4c831297a64a4a606e6852d8a9303a`.
- Build scope: complete eight-part manifest. Both `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0007` passed their independent artifact audits: `8` STL, `136` PNG, `144` modeled artifacts, with no missing or unexpected files.
- Provenance: both manifests match the revision config, `designs/cyberdeck/parts.json`, and the exact source tree above.
- Parameter and post-subtraction gates: passed. Assertions enforce the tray-left split, the `3 mm` tray-side margin, and the charger cutout's material margin to both the screen-side wall and relocated split.
- Section gate: passed for the relocated seam at front (`y = -90 mm`), middle (`y = 0 mm`), and rear (`y = 90 mm`) slices; each showed continuous final material through the seam.
- Connectivity gate: passed. The left and right chamber exports are manifold (`Simple: yes`) and each has one connected triangle component. Their measured envelopes are approximately `67.55 mm x 212 mm x 120.175 mm` and `192.55 mm x 212 mm x 120.175 mm`.
- Slicer gate: unverified because no supported slicer executable is available in the verification environment.
- Structural joins: unverified overall until slicer layer-path review; changed-geometry parameter, section, post-subtraction, and connectivity gates passed.
- Minimum internal edge/material width: passed for the rev_0007 changed geometry.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0006 Compact Two-Piece Body

- Revision `rev_0006` enables `compact_body_enabled` and derives the assembled left boundary from `chamber_display_wedge_left_x()`, currently `x = -67.5 mm`.
- The assembled body is reduced from `385 mm` to `260 mm` wide. Its depth remains `210 mm`, with rear fan spacers extending the printable depth to approximately `212 mm`; peak height remains approximately `120.175 mm`.
- The complete dome zone, left-front opening and lid, left handle mounts, dome bucket, and dome-gimbal exports are removed from the current manifest.
- The Raspberry Pi side tray export, exterior opening, backplate fasteners, and tray-only proxy exports are removed. The right exterior wall is now continuous across the former opening.
- The Orange Pi rear tray retains its existing installed position and complete backplate, insertion, mounting, exhaust, and service envelope.
- The two-piece division moves from assembled `x = 0` to a calculated `x = 136.4 mm`, exactly `3 mm` beyond the Orange Pi tray backplate envelope.
- The resulting printable body widths are `203.95 mm` for the main/left section and `56.15 mm` for the right closure section. Including the rear fan spacer projection, each part has a maximum envelope of approximately `203.95 mm x 212 mm x 120.175 mm` or `56.15 mm x 212 mm x 120.175 mm`, within the configured `220 mm x 220 mm x 220 mm` print volume.
- The current complete manifest contains eight exports: the assembled structure, both enclosure sections, the remaining panel set, center lid, right lid, Orange Pi tray, and roof I/O panel.

### Revision 0006 Structural Review

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0006.json` with the current source tree.
- Structural minimums remain `3 mm` wall thickness, `3 mm` structural overlap, and `3 mm` minimum internal edge/material width.
- Parameter assertions derive the split from the Orange Pi backplate edge plus `minimum_internal_edge_width`, enforce both calculated part widths against the print volume, and retain the existing joint bolt/passthrough ligament checks at the relocated datum.
- The former Raspberry Pi opening and screw cuts are disabled in compact mode, so the exterior wall is produced by the original continuous shell rather than by adding a thin patch.
- Final build, sectional, connectivity, artifact, and provenance results are recorded after the complete rev_0006 verification run below.

### Revision 0006 Verification Record

- Build scope: complete eight-part manifest.
- Destinations: `output/cyberdeck` and immutable `revisions/cyberdeck/rev_0006`.
- Expected and actual artifacts at each destination: `8` STL, `136` PNG, `144` modeled artifacts; both manifest audits passed.
- Config and source provenance: both build manifests match `designs/cyberdeck/configs/rev_0006.json`, `designs/cyberdeck/parts.json`, and the exact OpenSCAD source tree used for the build.
- Parameter gate: passed for all eight manifest exports.
- Section gate: changed seam and left-end sections were reviewed at front, middle, and rear locations. The new left wall remains continuous; the relocated seam retains the intended wall/floor and upper-bulkhead material around its documented passthroughs.
- Post-subtraction and minimum-edge gate for changed geometry: passed by direct split/backplate/print-envelope assertions, existing bolt-to-passthrough and boundary ligament assertions, final sections, and removal of the Raspberry Pi cutters from the compact-mode final Boolean.
- Connectivity gate: passed. The left and right chamber STL exports are manifold (`Simple: yes`) and each contains one connected triangle component. The complete measured envelopes are `203.95 mm x 212 mm x 120.175 mm` and `56.15 mm x 212 mm x 120.175 mm`.
- Slicer gate: unverified because no supported slicer executable is installed in the verification environment.
- Structural joins: unverified overall until slicer layer-path review is completed; changed-geometry parameter, section, post-subtraction, and connectivity gates passed.
- Minimum internal edge/material width: passed for the rev_0006 changed geometry; unchanged legacy geometry remains governed by its earlier verification status.
- Fabrication status: not print-ready while the slicer gate remains unverified.

## Revision 0005 Left-Lid Auxiliary Mount Study

- The left-front inset lid removes its obround finger/pull slot.
- The left-front inset lid now has a centered `30 mm` circular through-hole.
- The left-front inset lid now has four additional M3 clearance holes in a centered `40 mm x 80 mm` rectangular pattern.
- The `80 mm` span is oriented across the lid width and the `40 mm` span is oriented front/back because the current lid is only about `80.8 mm` deep.
- The existing four recessed corner mounting holes and the `LEFT` top label are retained.
- The standalone `part_id = 7` export and the removable-panel preview `part_id = 6` both use the updated left lid.

### Revision 0005 Structural Review

- Source revision/config reviewed: source patch against current `designs/cyberdeck/configs/rev_0004.json` defaults and model source.
- Structural joins: not applicable; this change subtracts holes from an existing standalone lid and does not add a joined load-bearing feature.
- Minimum-edge review: new OpenSCAD assertions require the centered `30 mm` hole, the four auxiliary M3 holes, lid edges, and existing recessed corner fasteners to retain at least the configured `minimum_internal_edge_width`.
- The `80 mm` auxiliary M3 span is placed across X rather than front/back because a front/back `80 mm` span would leave no practical edge material in the current `80.8 mm` lid depth.
- Build status: unbuilt in this patch handoff; run the normal complete cyberdeck build/audit before treating the revision as fabrication-ready.

## Revision 0004 Dome Pan/Tilt Gimbal Prototype

- Revision `rev_0004` adds the first standalone dome gimbal prototype parts to the manifest.
- The implemented mechanism uses a fixed vertical MG996R pan servo cradle in the bucket, a horn-driven rotating pan plate, a low-profile tilt yoke, and a separate camera/dual-laser carriage.
- The carriage centers a `32 mm x 32 mm` camera board proxy and places one `12 mm x 35 mm` laser module saddle on each side of the camera.
- The assembled clearance mockup uses a cutaway bucket and the `115 mm` acrylic dome envelope so the servo stack, pan plate, camera, two lasers, and wire-route proxies can be inspected.
- The gimbal routes camera USB, laser wiring, and servo leads down through the rotating pan stage toward the bucket's existing front and side passthrough windows.
- The pan servo cradle uses the documented MG996R shaft-centered hole pattern: `[-36, +/-5]`, `[14, +/-5]`.
- The pan rotating plate includes a starter stock-horn receiver pocket with center-screw access and anti-rotation arm geometry rather than a printed spline.
- The tilt stage is intentionally compact; it uses low MG996R support ribs instead of a tall side-mounted servo cage so the payload remains inside the dome envelope.
- The new geometry includes direct assertions for the MG996R mount pattern, bucket radial clearance, dome height/radius clearance, laser saddle wall thickness, camera-board starter hole edge margins, yoke clearances, and wire-passthrough capacity.
- Complete builds passed for both `revisions/cyberdeck/rev_0004` and `output/cyberdeck`.
- Build audit result for the current output: `20` parts, `20` STL files, `340` PNG files, `360` modeled artifacts.
- Reviewed renders include the cutaway assembled dome mockup, front/top/right orthographic mockup views, bucket insert, pan cradle, pan plate, tilt yoke, and camera/dual-laser carriage.
- Prototype limit: this is suitable for first mechanical prototype printing, but the final horn receiver, tilt-servo retention, camera screw bosses, wire bend radii, and pan/tilt travel still need validation with actual hardware.

### Revision 0004 Structural Review

- Source revision/config reviewed: `designs/cyberdeck/configs/rev_0004.json`.
- Structural minimums remain `3 mm` wall thickness, `3 mm` structural overlap, and `3 mm` minimum internal edge/material width.
- The new gimbal parts use named dimensions and assertions for every critical clearance and minimum-material contract.
- Pan cradle: the circular cradle, servo guide walls, servo mounting pads, and wire relief retain the required radial material to the bucket wall and around mounting holes by assertion.
- Pan plate: the rotating stage fits inside the bucket with asserted radial clearance, keeps center-screw access, and uses non-circular horn-pocket arms for torque transfer.
- Tilt yoke: side plates, base, ribs, pivot clearances, and mounting features meet the configured minimum material width by assertion.
- Camera/laser carriage: the `32 mm` camera opening, four starter board holes, two `12 mm` laser saddles, pivot bosses, and rear wire exits retain asserted printed ligaments.
- Dome clearance: the mockup asserts that the tilted camera/laser payload remains below the `115 mm` dome envelope and above the bucket floor/chamber top.
- Wire routing: the bucket passthrough width is asserted to fit the first-pass gimbal wire bundle route.
- Verification evidence: `rev_0004` complete manifest build and audit passed, and the cutaway/orthographic PNGs were visually reviewed.
- Fabrication status: first prototype print only. Final hardware-fit print is blocked until the actual stock servo horn and camera PCB mounting dimensions are measured and folded into the model.

## Revision 0003 Rear-Roof I/O Study

- The keyboard is now treated as a separate accessory rather than a component that must fit on the deck's flat top.
- The unified rear housing grows from `25.4 mm` to `51.2 mm` deep so the existing I/O controls can move onto a removable panel above and behind the screen.
- The `45 degree`, `95 mm` screen face remains unchanged, but its ridge moves forward to assembled `y = 53.8 mm` and its foot moves forward to about `y = -13.376 mm`.
- All three front openings terminate at the dome-constrained `y = -20 mm` rear edge.
- All three finished front lids are `80.8 mm` deep.
- The center and right openings retain approximately `6.624 mm` of solid deck between their rear edges and the screen slope.
- The touched front-lid support rails are now `7 mm` wide and `3 mm` thick.
- Those rails overlap the surrounding front, side, and rear structures by the full `3 mm` minimum structural overlap.
- The removable I/O panel now spans the full `260 mm` display-housing width while retaining the two `3 mm` housing end walls and `0.6 mm` panel clearance on every side.
- The resulting I/O panel is `252.8 mm x 44 mm x 5 mm`; its roof recess is `254 mm x 45.2 mm`.
- The rear roof is locally thickened to a continuous `5 mm` structural frame.
- The top `2 mm` forms the panel recess, leaving a `3 mm` thick support floor.
- A `6 mm` support ledge surrounds the service opening, with integral `16 mm` corner lands for the four M3 mounting holes.
- Matching `3 mm` center-seam bulkheads now support the previously unsupported front I/O-panel rails on both chamber halves.
- Each bulkhead runs from the front support rail to the rear wall beneath the panel, with a horizontal top edge and a `45 degree` lower edge.
- The front of each bulkhead is truncated to retain a full `3 mm` vertical material width instead of ending at a zero-thickness point.
- The paired bulkheads use two aligned `3.4 mm` M3 clearance holes so the upper chamber structure can be bolted together.
- The bulkheads retain at least `3 mm` from the angled screen recess and remain clear of all current roof-panel connector and mounting holes.
- The roof frame overlaps the original `3 mm` housing roof through its full thickness rather than relying on coincident faces.
- The I/O panel sits `2 mm` into the roof and remains `3 mm` proud of the surrounding surface.
- The full-width panel is rotated `45 degrees` for its standalone export. Its rounded modeled footprint is approximately `207.4 mm x 207.4 mm`, inside the `220 mm x 220 mm` print bed.
- The roof I/O panel retains the Raspberry USB-A, Orange USB-A, and Neural Jack openings.
- The left side of the removable roof I/O panel includes keyed `20 mm` rocker-switch openings labeled `Fans` and `Ultraviolet`.
- Two additional keyed `20 mm` rocker-switch openings provide Raspberry Pi and Orange Pi power-switch positions, paired with their matching USB-A panel jacks.
- The Raspberry/Orange roof-panel order is Raspberry power switch, Raspberry USB-A, Orange power switch, Orange USB-A, then Neural Jack from left to right.
- The Raspberry and Orange USB-A pair shifts right so the Orange USB-A installed flange retains `10 mm` from the Neural Jack opening.
- The `Fans`, `Ultraviolet`, `Raspberry`, and `Orange` labels sit in front of their corresponding switch openings.
- Each switch opening uses a `20 mm` circular cut plus a right-facing keyed notch, producing the specified `20.8 mm` keyed span and keeping the notches toward `+X`.
- With the switch notch to the right, the intended installed orientation is back/off and forward/on.
- The center-front lid carries a rear/top push-to-talk button and an additional front/bottom double-USB-A panel jack.
- This USB-A opening is an additional port; the Raspberry and Orange USB-A openings remain on the roof I/O panel.
- The center lid's pull slot is removed to make room for the controls.
- The two full hardware envelopes are separated by exactly `3 mm`.
- `Push To Talk` is engraved vertically along both long sides between the mounting screws.
- The left and right labels use opposite rotations so the bottom of each text line faces the middle of the lid.
- Clearance checks treat each underside retaining nut as the same diameter as its visible top hardware: `35 mm` for PTT and `31.75 mm` for USB-A.
- The fixed center-lid support frame is relieved by `44 mm` and `40.75 mm` circles, providing `4.5 mm` radial clearance around the respective `35 mm` PTT and `31.75 mm` USB-A underside hardware envelopes.
- The larger PTT relief intentionally notches the `7 mm` rear support rail while retaining a `4.625 mm` continuous rail throat and at least `3.065 mm` of material around the nearest M3 support hole.
- A future adhesive blacklight LED strip can run horizontally along the inside face of the front wall across both chambers.
- The center chamber-bonding walls and the left display-divider wall each receive a `15 mm` semicircular passage centered vertically at `z = 26.5 mm`.
- Each passage starts at the front wall's interior face and curves rearward, preserving the complete `3 mm` wall-to-front structural overlap and leaving the exterior front face closed.
- The main control labels use Bahnschrift SemiBold for cleaner strokes and less ornamentation.
- The Raspberry/Orange switch labels use the largest shared front-of-switch label size that retains `3 mm` from the switch openings and panel front edge.
- The Neural Jack label is anchored `5 mm` from the roof panel's right edge, and its mounting hole sits `5 mm` immediately to the left of the text.
- The fixed `Power Cell` USB-C opening moves to the lower rear wall of the left chamber.
- Its cutter is centered on the `3 mm` rear-wall midplane and extends beyond both wall faces, ensuring the `23 mm` opening is a true through-hole rather than leaving an internal membrane.
- Its center is at assembled `x = -33.75 mm`, midway between the center joint and the full-depth display-divider wall, and at `z = 26.5 mm`.
- The `Power` / `Cell` marking is raised from the rear wall and centered below the opening, avoiding any reduction of the `3 mm` wall thickness.
- The rear-wall glyph geometry is mirrored before its inward structural extrusion so `Power` / `Cell` reads normally from outside the back of the chassis.
- Moving the screen also moves the rear center-joint passthrough to assembled `y = 47.15 mm`, keeping it aligned near the display's rear screw row.
- Exact-config assembly export is manifold (`Simple: yes`) with an envelope of approximately `385.05 mm x 212 mm x 120.176 mm`.

### Revision 0003 Structural Review

- Roof-frame join: the new frame intersects the existing roof through the complete `3 mm` roof thickness across the frame footprint.
- Roof support: the recessed seat retains a `3 mm` support floor and a `6 mm` ledge, both meeting the repository structural minimums.
- Roof fasteners: each M3 hole is retained in an integral `16 mm` corner land with more than `3 mm` material outside the hole.
- Upper center seam: each `3 mm` bulkhead overlaps the front roof rail by `6 mm`, the rear wall by `3 mm`, and the roof support vertically by `3 mm`.
- Upper center fasteners: the front M3 hole's limiting edge ligament is approximately `6.785 mm`; the rear hole's limiting edge ligament is `9.9 mm`.
- Screen and I/O clearance: the bulkhead-to-screen-recess ligament is approximately `3.011 mm`; direct assertions also protect every current USB-A, USB-C, and nearest roof-panel fastener opening from the new seam structure.
- Front-lid rails: all three frames share the same rear datum; rail thickness is `3 mm`, rail width is `7 mm`, attachment overlap is `3 mm`, and the corner-pad-to-rail overlap is approximately `3.4 mm`.
- Center-joint fasteners: the upper center M3 hole is at `z = 38 mm`; its shortest post-subtraction ligament to the angled screen recess is approximately `3.45 mm` and is enforced by a direct assertion.
- Control-panel engraving: the shallow roof-panel and lid engravings retain more than `3 mm` of solid lid thickness below every engraving.
- Roof-panel rocker switches: the four `20 mm` keyed switch cuts retain at least `3 mm` to the panel edges, support ledge, corner screw heads, adjacent I/O keepouts, and the hidden center-seam bulkhead.
- Center-lid controls: the `28 mm` PTT and new `29 mm` USB-A holes retain at least `3 mm` printed material to lid edges, neighboring holes, and recessed corner fasteners.
- Two-sided hardware clearance: the `35 mm` PTT and `31.75 mm` USB-A installed envelopes are checked identically above and below the lid.
- Underside support clearance: matching circular reliefs remove the conflicting portions of the center-lid corner pads while retaining at least `3 mm` around every M3 support hole; the PTT relief intentionally notches the rear rail while retaining a `4.625 mm` throat.
- Front LED-strip route: the three aligned `15 mm` semicircular passages retain the full `3 mm` front-wall joint, `16 mm` above the floor, `19 mm` below the wall top, and approximately `8.21 mm` from the nearest chamber-bonding bolt.
- Minimum-edge review: roof borders, support ledges, screw-hole ligaments, front-lid separator, rear Power Cell margins, and label margins are asserted at or above `3 mm`; the rear label is raised instead of engraved into the minimum-thickness wall.
- Verification evidence: the exact `rev_0003` assembly export and all 17 configured preview images completed after the LED-route change; a focused final-Boolean section confirms the semicircular divider-wall cut while the exterior front wall remains closed.
- Connectivity audit: each standalone chamber STL contains one dominant connected structural shell spanning the complete chamber bounds; every smaller component is confined to the intentionally separate raised floor-label glyph height at `z = 3.2 mm` to `3.55 mm`.
- Fabrication status: this revision verifies the changed roof, front-lid, and Power Cell geometry only. Unchanged legacy subsystems remain subject to the broader structural audit before the complete deck is fabrication-ready.

## Revision 0002 Printable Chamber Study

- Structural minimum wall thickness, structural overlap, and internal edge width are each defined as `3 mm`.
- Printer build-volume constraint is assumed to be `220 mm x 220 mm x 220 mm`.
- The cyberdeck lower structure is split into two printable chambers that meet at the centerline.
- Each chamber body footprint is currently `192.5 mm x 210 mm`.
- The rear fan spacers increase the complete per-half print envelope to approximately `192.5 mm x 212 mm`, still inside the build volume.
- Flat chamber height is currently `53 mm`; side-profile peak height is currently about `120.2 mm`.
- The unified rear-housing wall reaches the full side-profile peak height of about `120.2 mm`.
- Combined assembled footprint is currently about `385 mm x 212 mm x 120.2 mm`.
- The raised display wedge is right-aligned and currently `260 mm` wide.
- The left edge of the raised display wedge lands at assembled `x = -67.5 mm`.
- The left flat dome planning area is currently `125 mm` wide.
- The left dome area has a flat `3 mm` top roof extending from the display wedge edge to the left outer edge.
- The left dome roof is currently a `125 mm x 125 mm` planning area for the acrylic dome footprint.
- A matching flat `3 mm` top band now extends from the dome roof edge across the front of the display wedge to the right outer edge.
- The fixed left-side control band runs from assembled `y = -20 mm` to the start of the `45 degree` screen slope at assembled `y = 12.424 mm`.
- On the right chamber, the control roof extends forward to about assembled `y = -38.8 mm` to form the separator web and support the removable I/O-panel opening.
- The front control system includes two `23 mm` circular cutouts for screw-in heavy-duty USB-C panel jacks: the fixed left `Power Cell` connector and the removable-panel `Neural Jack`.
- The fixed left `Power Cell` USB-C cutout remains at about assembled `y = -3.8 mm`; the removable right `Neural Jack` cutout is centered on its panel at about assembled `y = -13.2 mm`.
- The USB-C jack cutout centers align left/right with the `210 mm` screen void edges at assembled `x = -42.5 mm` and `x = 167.5 mm`.
- The right-side portion of the control band becomes a separate removable I/O panel so connector and control layouts can change without reprinting the right chamber.
- The removable I/O panel is `44 mm` deep and uses the same `5 mm` panel thickness, `0.6 mm` edge clearance, recessed M3 corner fasteners, and inset support-rail approach as the front lids.
- The I/O-panel opening leaves a `3 mm` fixed chassis border before the screen slope, matching the `3 mm` solid separator web between the I/O-panel opening and the shortened right-front lid opening.
- The shortened right-front lid remains full width, keeps its existing front and side boundaries, and is approximately `63 mm` deep.
- The resulting finished gap between the right-front lid and I/O panel is approximately `4.2 mm`, including the two `0.6 mm` panel clearances around the `3 mm` chassis web.
- Arcade-button planning assumes a `28 mm` mounting hole, `34 mm` external button body, and at least `5 mm` of panel material around a mounting hole.
- The center-front lid includes a rear/top `28 mm` arcade-button mounting hole for push-to-talk control and a new front/bottom `29 mm` double-USB-A mounting hole.
- The installed push-to-talk cap/nut envelope is modeled as `35 mm` diameter, the USB-A flange/nut envelope is `31.75 mm`, and both envelopes are checked above and below the lid.
- The removable I/O panel includes Raspberry and Orange control groups: a keyed `20 mm` power-switch opening immediately followed by a `29 mm` USB-A panel-jack opening for each board.
- The USB-A jacks use a `31.75 mm` (`1.25 inch`) installed flange footprint, and the rocker switches use a `23.2 mm` installed top footprint.
- Adjacent Raspberry/Orange hardware footprints retain at least `3 mm` of clearance, and the Orange USB-A footprint retains `10 mm` from the Neural Jack opening.
- The removable-panel control order is Raspberry power switch, Raspberry USB-A, Orange power switch, Orange USB-A, then Neural Jack from left to right.
- Two vertical `Push To Talk` engravings sit along the long sides of the center lid with their bottoms facing inward, while `Neural` / `Jack` remains to the right of its roof-panel hole.
- Raspberry and Orange move to front-of-switch roof-panel labels so each label identifies both the board's power switch and the adjacent USB-A port.
- The existing right-side `Neural` / `Jack` USB-C opening and engraving move onto the removable I/O panel. The left-side `Power` / `Cell` connector remains on the left chamber roof.
- The right-side USB-C opening is centered front/back and positioned `5 mm` immediately left of its Neural Jack label.
- Push To Talk uses mirrored inward-facing vertical lines on the center lid; Neural Jack retains its horizontal two-line roof-panel treatment.
- The shared OpenSCAD control-label font is `Bahnschrift:style=SemiBold`; matching font installation is required to reproduce the measured text bounds exactly.
- The fixed `Power` / `Cell` USB-C label remains a horizontal two-line engraving beside the left jack.
- The dome roof has a centered `96 mm` circular cutout.
- The acrylic dome mount uses four M3 clearance holes on a `56 mm` radius bolt circle.
- The dome M3 holes are placed in the top-left, top-right, bottom-left, and bottom-right quadrant positions around the dome cutout.
- The flat keyboard bay is intentionally open from above for continued layout, mounting, and service-access design.
- The flat keyboard bay now includes an internal support rail for a future inset lid.
- The future keyboard-area lid is planned to sit `2 mm` below the flat deck top and rest on a `6 mm` wide, `2 mm` tall rail around the opening.
- The left and center front lid rail frames stop at assembled `y = -20 mm`, matching the front edge of the dome roof and control band.
- The keyboard-area lid rail is constrained to the display/keyboard bay to the right of the dome roof so it does not intersect the dome cutout.
- The center lid remains aligned with the left-front lid depth, while the right-front lid is shortened further to make room for the removable I/O panel and separator web.
- The three front lids are modeled as separate `5 mm` thick panels with `0.6 mm` edge clearance and `3 mm` corner radii. The right lid retains an obround pull slot; the left lid now uses a centered auxiliary `30 mm` hole plus a `40 mm x 80 mm` M3 pattern, and the control-filled center lid has no pull slot.
- Each lid opening has small corner pads pulled into the opening for M3 corner fasteners.
- Each lid has four M3 clearance holes inset `8 mm` from the lid edges, with `7 mm` diameter counterbores so the screw heads sit below the top face.
- The thicker lids rest on the inset rail and may sit slightly proud of the surrounding deck surface.
- The removable-panel preview layout shows the three front lids and right-side I/O panel together; export the individual part IDs for printable files.
- The first carrying-handle study is a separate printable part intended for the left side of the deck.
- The carrying handle uses a `100 mm` cylindrical grip span, a `40 mm` outer reach from the chassis side, and a `14 mm` tube diameter.
- The handle terminates in two `40 mm x 40 mm x 3 mm` square mounting plates with four M3 clearance holes per plate.
- The tube-to-plate joints use tapered collars to spread load into the mounting plates.
- Matching M3 clearance holes are cut only into the left outside wall of the left chamber.
- The left-side pattern has plate centers at assembled `y = -50 mm` and `y = 50 mm`, with screw rows at `z = 13 mm` and `z = 39 mm`.
- The right chamber has no carrying-handle mounting holes or mounting lands.
- The dome bucket insert is a separate printable pot for the pan/tilt eye and laser mechanism.
- The insert body is sized to slide into the `96 mm` dome roof hole with `1 mm` radial clearance, giving a `94 mm` outer cylinder.
- The bucket, raised internal floor, top lip, and screw-hole edge margin all use `3 mm` wall thickness/margin.
- The bucket lip covers the `115 mm` acrylic dome outline and extends to the existing four-hole M3 dome bolt pattern with `3 mm` of material outside the screw holes.
- The bucket sidewall continues through the top lip, keeping the lip's internal opening continuous with the bucket's internal diameter.
- The bucket sides reach to the chamber base, while the internal floor is lifted `3 mm` above the chamber base.
- The bucket includes front and side passthrough windows for servo/camera/laser wiring to reach nearby internal passthroughs.
- Internal vertical clearance is set to `50 mm` for component volume planning.
- Chamber walls and bottom floor are currently `3 mm` thick.
- The angled screen face, rear-housing roof, rear wall, and outer end walls are generated as one continuous hollow profile.
- The angled screen face has a `3 mm` normal wall thickness; the rear-housing roof and rear wall are each `3 mm` thick.
- The flat keyboard deck area remains open; it does not have a top roof panel.
- The four left/right side walls now use a hybrid raised-back side profile instead of the earlier peaked tent profile.
- The front area remains at the flat keyboard-deck height.
- The front flat keyboard bay is now about `117.4 mm` deep in the current side-profile study.
- The screen slope starts farther back to clear the approximately `115 mm` keyboard depth.
- The rear edge is a full-height vertical wall joined directly to a horizontal rear-housing roof.
- Current side-profile ridge rises about `67.2 mm` above the flat chamber top.
- The rear housing is `25.4 mm` deep from the screen-face peak to the rear wall, preserving the approximate `1 inch` screen-depth clearance target.
- The forward screen slope uses about a `67.2 mm` run from the ridge back down to the flat keyboard deck.
- The forward screen slope is now sized as a `95 mm` long mounting face at `45 degrees`.
- The screen void is `210 mm` wide and `87 mm` tall, centered on the angled display face.
- The `87 mm` screen void leaves about `4 mm` of face-height margin above and below within the current `95 mm` mounting face.
- The display void cuts `25.4 mm` inward from the angled face for the screen body depth.
- The `2U` screw rows are based on the rack-hole outer pair spacing: `3.0 in` / `76.2 mm` center-to-center.
- The `2U` screw rows are centered on the angled display face, so each row is `38.1 mm` from the display face centerline.
- The screw columns sit in the side flanges at `115 mm` left/right from the display centerline: centered between the `210 mm` screen void and the `250 mm` full display/flange width.
- Display mount screw clearance is currently modeled as `5.5 mm` placeholder holes for rack-style hardware.
- The display body is expected to need about `210 mm` internal width, with mounting flanges extending another `20 mm` on each side.
- The raised display wedge width is based on the `250 mm` display/flange width plus `5 mm` side margin on each side.
- The flat roof area to the left of the display wedge is reserved for the acrylic dome module.
- The acrylic dome planning area is based on a `115 mm` dome outer diameter plus `5 mm` margin on each side.
- The inner left edge of the display wedge is modeled as a full-depth structural web that extends down to the bottom of the build.
- The display wedge web uses the same two circular passthrough openings as the center chamber joint.
- The raised display wedge is open across the center seam so there is no full-height wall in the middle of the display area.
- The center seam keeps the lower base-wall joint structure, flush passthroughs, and six-hole M3 pattern.
- The former cylindrical reinforcement bosses around the center-joint M3 holes are removed; the fasteners now pass directly through the `3 mm` mating walls.
- The outer M3 rows move `1 mm` toward the front/rear chamber edges so the rear lower hole retains at least `3 mm` of material from the nearby passthrough.
- The temporary external connector block on the rear-housing roof is removed. A replacement upper joining structure will be designed later.
- Two 40 mm exhaust-fan interfaces are cut into the raised vertical rear wall behind the display, one at each end of the display wedge.
- The fan interfaces reuse the `cottage_pi6_plus` mounting pattern: a `28 mm` central airflow opening and four `4.2 mm` mounting holes on a `32 mm x 32 mm` square pattern.
- The former pair of fan towers and intervening rear wedge have been replaced by one continuous full-width rear housing.
- The rear housing is created from one outer side-profile extrusion and one continuous cavity subtraction, so its roof, rear wall, angled screen face, and end walls are connected by construction.
- The fan openings are direct cuts through the same continuous rear wall and exhaust from the shared internal plenum above and behind the screen.
- Each fan uses a `46 mm` wide mounting land, providing `3 mm` around the `40 mm` fan body and sufficient flat support for the modeled `6 mm` M3 screw-head envelope.
- Each fan frame is top-aligned with the housing, with its upper edge `3 mm` below the roof.
- The left and right fan patterns remain entirely on their respective printed chamber halves.
- Each fan screw hole has a `10.4 mm` diameter annular spacer that projects `2 mm` behind the rear wall.
- Each spacer overlaps the complete `3 mm` rear-wall thickness and leaves a nominal `3.1 mm` of radial material around its `4.2 mm` screw hole.
- The four spacers hold each fan `2 mm` off the rear wall, providing a protected wiring gap and reducing direct wire pressure against the fan housing.
- The right chamber has a left-aligned rear slide-out tray opening through the lower back wall.
- The right tray back opening is `108 mm` wide and `44 mm` tall.
- The `130.4 mm` wide backplate is positioned as far left as the structural rules allow: its left edge retains exactly `3 mm` of right-chamber rear wall.
- This places the opening's left edge `14.2 mm` from the chamber boundary while leaving substantially more intact wall at the right.
- The former low internal floor rails in the right chamber are removed. Any replacement tray-guidance or retention system will be designed later.
- The right tray has a `106 mm` wide flat sliding bed extending `131 mm` from its front edge to the backplate datum, with a `3 mm` floor, rear backplate, Orange Pi mounting pads, and an exhaust opening in the backplate.
- The Orange Pi tray intentionally has no interior perimeter lips or side walls so the board ports and switches remain accessible.
- The floor continues through the full `3 mm` backplate thickness, producing a required `3 mm` structural overlap and a `134 mm` overall front-to-rear STL envelope.
- The tray backplate bottom is flush with the tray floor bottom, so the rear wall does not extend below the sliding tray.
- The tray backplate is slightly larger than the rear opening and uses four M3 corner holes with at least `3 mm` edge margin on both the wall and the backplate.
- The Orange Pi mount uses the proven cottage tray orientation: the `94 mm` hole spacing runs across the tray and the `98 mm` spacing runs front/back toward the rear exhaust backplate.
- The rear stud pair is `3 mm` from the rear tray datum, matching the cottage-style exhaust-side convention.
- The Orange Pi board envelope is centered across the narrowed tray with `3 mm` nominal clearance at each side.
- The Raspberry Pi mounting study has been removed from this tray. The Raspberry Pi remains part of the overall hardware plan but requires a different internal mount.
- The tray opening, backplate, fasteners, and Orange Pi footprint are all derived from the narrowed cottage-style tray dimensions rather than the full chamber width.
- A second independent tray enters through the right outside wall for the Raspberry Pi 5.
- The Raspberry Pi tray occupies the narrow strip beside the Orange Pi tray without changing the chamber dimensions. Its inserted left edge retains approximately `3.3 mm` clearance from the Orange Pi tray.
- The Raspberry Pi board is rotated so its `56 mm` dimension runs across the chamber and its `85 mm` dimension runs front-to-back, parallel to the Orange Pi board.
- The Raspberry Pi connector edge faces the deck front.
- The board datum is biased `1 mm` toward the front to preserve at least `3 mm` of physical board clearance and prevent point-only contact between the rear mounting bosses and tray rail.
- The side tray has a `65 mm` insertion depth and `93 mm` front-to-back bed, with a `95 mm x 44 mm` chamber opening and `1 mm` slide clearance.
- Its `117.4 mm x 52 mm` exterior closure plate uses four M3 holes and ends `3 mm` ahead of the rear chamber edge, placing the tray as far back as the required edge margin permits.
- The Raspberry Pi mount preserves the drawing's rotated `49 mm x 58 mm` M2.5 hole pattern and its `3.5 mm` board-edge datum.
- The `9 mm` mounting pads retain at least `3 mm` of material around their holes and to the nearest tray edge.
- The Raspberry Pi tray intentionally has no interior perimeter lips, side walls, or leading wall so the board ports and switches remain accessible.
- The tray floor and closure plate are `3 mm` thick. The floor overlaps through the full `3 mm` closure-plate thickness.
- The left and right chambers have matching circular side passthroughs on the mating faces.
- Current design uses two `30 mm` passthroughs, split front/back from the centerline.
- The passthrough centerline is lowered to `z = 22 mm` so the flush conduit holes clear the inset lid rails.
- Passthrough centers are currently `52.5 mm` forward and `73 mm` back from the middle of the mating face.
- The rear passthrough is aligned near the rear `2U` screw row to put more material continuity around the display cutout.
- The mating faces use a six-bolt M3 pattern.
- Four bolts sit near the mating-face corners.
- Two bolts sit on the vertical centerline, one low and one high.
- The upper center bolt is lowered to `z = 38 mm`, leaving approximately `3.45 mm` of material between its `3.4 mm` clearance hole and the angled screen recess.
- A direct post-subtraction ligament assertion now prevents the upper center bolt from approaching the screen recess more closely than the `3 mm` minimum internal-edge requirement.
- Bolt holes are modeled as `3.4 mm` M3 clearance holes.
- The M3 bolt pattern and passthrough conduits are plain flush holes through the mating walls, with no internal reinforcement bosses.
- This revision is still an enclosure architecture study, not a final printable mechanical design.
- Next steps are to repair the remaining legacy structural joins, resolve the tray board layout, and complete internal standoffs, cooling ducts, cable paths, and service clearances.

### Structural Verification Record

- Source revision/config: `designs/cyberdeck/configs/rev_0002.json`
- Minimum wall thickness: `3 mm`
- Minimum structural overlap: `3 mm`
- Minimum internal edge width: `3 mm`
- Rear housing: locally verified as one continuous positive-volume shell formed from one outer profile and one cavity subtraction.
- Rear housing joins reviewed: screen-to-roof bend, roof-to-rear-wall bend, roof/rear/screen-to-end-wall joins, and full-wall engagement of the fan spacers.
- Rear housing internal edges reviewed: fan center-to-fastener ligaments, fan fastener-to-outer-edge margins, spacer annulus thickness, and center-joint bolt-to-passthrough ligaments.
- Export evidence: exact-config assembly STL rendered `Simple: yes`; per-half component audits found one connected structural shell in each chamber body plus intentionally separate raised floor-label glyphs.
- Printable-half bounds: approximately `192.55 mm x 212 mm x 120.18 mm` for each chamber, within the `220 mm` build volume.
- Full-design result: structurally unverified. Existing lid rails, handle joins, tray/backplate features, and other geometry outside this rear-housing change still require repair and section/slicer review under the repository structural-join policy.
- Fabrication status: not print-ready.

## Revision 0001 Mockup Notes

- Overall visual envelope is currently `480 mm x 300 mm x 42 mm`.
- Chassis width is allowed to exceed the unfolded keyboard width so the screen, eye module, and top control row can sit naturally without crowding.
- Chassis depth is tightened around the current screen/dome, top control row, and raised keyboard layout.
- Top layout places the acrylic eye module in the upper-left area.
- Top layout places the full-size unfolded keyboard footprint in the lower-right area.
- The mounted touchscreen uses the provided `208 mm x 85 mm` active area and `250 mm` rail width.
- The full `250 mm` touchscreen rack-rail width sits to the right of the acrylic eye module in the upper layout band.
- The four independent power toggles are arranged side-by-side above the screen.
- The Meshtastic e-ink visibility window sits to the right of the switch row.
- The keyboard is moved up close beneath the screen/control cluster.
- SMA connector placeholders are omitted from this mockup; RF connectors are assumed to move to a future top-side edge placement.
- The Orange Pi 5 Plus proxy is placed near the front with a visible exhaust grille at the top/front edge.
- Internal board and module volumes are placeholders for visual planning only.
- A rough `4 x 18650` future UPS bay is shown as a planning placeholder, not a power-system design.

## Initial Hardware Inventory

- Main SBC: Orange Pi 5 Plus
  - Primary compute board for the cyberdeck.
  - USB-C Alt Mode output is intended to drive XReal AR glasses.
- AI coprocessor stack: Raspberry Pi 5 with 16 GB RAM
  - Paired with a separate LLM8850 AI accelerator with an additional 8 GB RAM.
  - Intended role is a local AI coprocessor for perception, agentic control, and model workloads.
- Mounted secondary display
  - Touchscreen active/display body: `208 mm x 85 mm`.
  - Resolution support: up to `1280 x 400`.
  - Designed for a `2U 10 inch` rack opening.
  - Rack-mount rails extend total width to `250 mm`.
- Keyboard
  - Samsers foldable full-size keyboard.
  - Unfolded size: approximately `13.5 in x 4.5 in`.
  - Folded size: approximately `180 mm x 115 mm`.
  - Intended to attach to the cyberdeck top so it can fold open for use and fold closed for transport.
- Radio and positioning modules
  - HackRF.
  - Meshtastic node.
  - Meshtastic node includes an e-ink display that must remain visible through the case.
  - GY-NEO6MV2 NEO-6M GPS module.
- Sensor dome assembly
  - `4 inch` transparent acrylic dome.
  - Internal 3D-printed servo-controlled pan/tilt apparatus.
  - Camera: `32 mm x 32 mm`, `130 degree` wide-angle high-definition USB camera.
  - Software-switchable laser pointer.
  - Intended uses include AI-guided looking/pointing, manual remote control, and video calls.
- Hardware power controls
  - Separate physical toggle for Meshtastic node power.
  - Separate physical toggle for Orange Pi 5 Plus power.
  - Separate physical toggle for mounted touchscreen power.
  - Separate physical toggle for Raspberry Pi 5 / AI coprocessor power.
- Future power system
  - Explore an `18650` cell UPS strategy later.
  - For now, power-system work should remain conceptual while the design focuses on mockups for visual layout and ergonomics.

## Aesthetic and Concept Direction

- Target mood is Neuromancer / Snow Crash inspired cassette futurism.
- The design should feel like a cyberpunk field computer rather than a generic electronics box.
- Core visual ingredients:
  - full-size folding keyboard as a prominent physical interface
  - unusual super-wide mounted touchscreen
  - XReal AR glasses as the primary immersive display path
  - visible or implied agentic AI core
  - acrylic "eye" module with a moving camera and software-controlled laser
- The Raspberry Pi + accelerator stack is conceptually the home of a personality construct.
- That construct has limited proprioceptive capability through the servo-controlled eye module:
  - it can look around using the pan/tilt camera
  - it can point at things using the laser
  - it can support manual control, AI control, or video-call use cases

## High-Level Physical Layout

- Overall form factor is expected to be basically rectangular.
- The current mockup allows the chassis to become wide enough for the screen to sit beside the dome.
- Top-view composition should be intentionally asymmetric.
- The acrylic eye module should anchor the upper-left area.
- The secondary touchscreen should sit next to the acrylic eye module in the upper layout band.
- The current mockup prioritizes screen/dome composition and shows the full display rail width.
- The hardware toggle bank should be a single side-by-side row above the touchscreen.
- The Meshtastic e-ink display should sit to the right of the switch row.
- SMA antenna connectors for Meshtastic and HackRF are deferred from the top-panel mockup and assumed to belong on a future top-side edge.
- The keyboard should sit toward the lower-right area, close to the screen/control cluster rather than leaving a large empty spacer.
- The secondary touchscreen sits above the keyboard in a cutout/opening.
- The secondary touchscreen should clear the acrylic dome in top view rather than tucking underneath it.
- The touchscreen mounts from both sides using bolts into the `2U` rack holes on the display rails.
- The acrylic dome assembly is the distinct upper-left feature rather than a centered display topper.
- The dome protects the pan/tilt camera and laser platform while allowing the camera to look around.
- The Raspberry Pi AI coprocessor is expected to control or assist the dome apparatus, including camera motion and software-controlled laser pointing.
- Internal layout must preserve an exhaust path for the Orange Pi 5 Plus.
- Orange Pi exhaust should exit at the top edge of the front of the device.

## Open Design Questions

- Overall enclosure footprint, thickness, carrying handle strategy, and orientation.
- Whether the XReal glasses are the primary display, with the mounted touchscreen as secondary/control/status, or whether both are equal-primary.
- Exact Orange Pi 5 Plus, Raspberry Pi 5, accelerator, HackRF, Meshtastic, GPS, hub, power, and cooling mounting requirements.
- Battery system, power conversion, charging path, external power input, and power-switching strategy.
- Future `18650` UPS architecture, cell count, protection/BMS, charging module, switchover behavior, serviceability, and safety constraints.
- Exact switch type, placement, labeling, current rating, and wiring path for each independent power toggle.
- Whether toggles should be visually grouped as a power-control bank or distributed near their controlled subsystems.
- Exact future top-side SMA bulkhead connector type, antenna clearance, strain relief, and RF cable paths for Meshtastic and HackRF.
- Internal cable paths for USB-C Alt Mode, USB camera, touchscreen, radios, GPS antenna, and laser/servo wiring.
- Whether the 250 mm display rail width should define the cyberdeck width or sit in a wider printed frame.
- Whether the final chassis should keep this wider screen-plus-dome footprint or use a different mounting strategy.
- How the foldable keyboard attaches mechanically and whether it needs a hinge, latch, magnetic retention, or removable mount.
- Dome mounting method, serviceability, and protection for the servo platform during transport.
- How to express cassette futurism without compromising serviceability, cooling, or printability.
- Exact front-edge/top-edge vent geometry for the Orange Pi 5 Plus exhaust path.
