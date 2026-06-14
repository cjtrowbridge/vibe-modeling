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

## Part IDs

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
- The roof I/O panel retains the Raspberry USB-A, Orange USB-A, and Neural Jack openings and labels.
- The center-front lid now carries a rear/top push-to-talk button and an additional front/bottom double-USB-A panel jack.
- This USB-A opening is an additional port; the Raspberry and Orange USB-A openings remain on the roof I/O panel.
- The center lid's pull slot is removed to make room for the controls.
- `Push To Talk` is engraved on one centered line between the two installed hardware envelopes.
- Clearance checks treat each underside retaining nut as the same diameter as its visible top hardware: `34 mm` for PTT and `31.75 mm` for USB-A.
- All four control labels use the same `5.48 mm` Bahnschrift SemiBold type size for cleaner strokes and less ornamentation.
- The `Raspberry` label size is derived from measured Bahnschrift bounds: its rotated length is approximately `33.97 mm`, leaving at least `5 mm` to both depth edges of the `44 mm` roof panel and `5 mm` to the installed USB-A flange.
- The Neural Jack label is anchored `5 mm` from the roof panel's right edge, and its mounting hole sits `5 mm` immediately to the left of the text.
- The fixed `Power Cell` USB-C opening moves to the lower rear wall of the left chamber.
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
- Control-panel engraving: the common `5.48 mm` label size leaves approximately `5.016 mm` at the Raspberry label's limiting panel edges, `5 mm` to its installed connector flange, and `4.45 mm` of solid lid thickness below every engraving.
- Center-lid controls: the `28 mm` PTT and new `29 mm` USB-A holes retain at least `3 mm` printed material to lid edges, neighboring holes, and recessed corner fasteners.
- Two-sided hardware clearance: the `34 mm` PTT and `31.75 mm` USB-A installed envelopes are checked identically above and below the lid, including clearance from the centered single-line label and corner fasteners.
- Minimum-edge review: roof borders, support ledges, screw-hole ligaments, front-lid separator, rear Power Cell margins, and label margins are asserted at or above `3 mm`; the rear label is raised instead of engraved into the minimum-thickness wall.
- Verification evidence: the exact `rev_0003` assembly export and all 17 configured preview images completed after the bulkhead change; an isolated final-Boolean Y-Z section confirms the continuous front-rail and rear-wall intersections.
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
- The installed push-to-talk cap is modeled as `34 mm` diameter, the USB-A flange/nut envelope is `31.75 mm`, and both envelopes are checked above and below the lid.
- The removable I/O panel includes two centered `29 mm` mounting holes for the Raspberry and Orange USB-A panel jacks, followed by the Neural Jack at the right.
- The USB-A jacks use a `31.75 mm` (`1.25 inch`) installed flange footprint, with `3 mm` between the two flange edges.
- The left USB-A jack is labeled `Raspberry`; the right USB-A jack is labeled `Orange`.
- The removable-panel control order is Raspberry USB-A, Orange USB-A, then Neural Jack from left to right.
- The single-line `Push To Talk` engraving sits between the PTT and new USB-A openings on the center lid, while `Neural` / `Jack` remains to the right of its roof-panel hole.
- Raspberry and Orange remain rotated `90 degrees`; all control labels now use the same larger type size.
- The existing right-side `Neural` / `Jack` USB-C opening and engraving move onto the removable I/O panel. The left-side `Power` / `Cell` connector remains on the left chamber roof.
- The right-side USB-C opening is centered front/back and positioned `5 mm` immediately left of its Neural Jack label.
- Push To Talk uses a single horizontal line on the center lid; Neural Jack retains its horizontal two-line roof-panel treatment.
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
- The three front lids are modeled as separate `5 mm` thick panels with `0.6 mm` edge clearance and `3 mm` corner radii. The left and right lids retain obround pull slots; the control-filled center lid does not.
- Each lid opening has small corner pads pulled into the opening for M3 corner fasteners.
- Each lid has four M3 clearance holes inset `8 mm` from the lid edges, with `7 mm` diameter counterbores so the screw heads sit below the top face.
- The thicker lids rest on the inset rail and may sit slightly proud of the surrounding deck surface.
- The removable-panel preview layout shows the three front lids and right-side I/O panel together; export the individual part IDs for printable files.
- The first carrying-handle study is a separate printable part intended for the left side of the deck.
- The carrying handle uses a `100 mm` cylindrical grip span, a `40 mm` outer reach from the chassis side, and a `14 mm` tube diameter.
- The handle terminates in two `40 mm x 40 mm x 3 mm` square mounting plates with four M3 clearance holes per plate.
- The tube-to-plate joints use tapered collars to spread load into the mounting plates.
- Matching M3 clearance holes are cut into the left outside wall of the left chamber and the right outside wall of the right chamber.
- The mirrored side-wall handle hole patterns are centered front/back on each chamber side, with plate centers at assembled `y = -50 mm` and `y = 50 mm`.
- The side-wall handle screw rows are centered vertically on the flat chamber side at assembled `z = 13 mm` and `z = 39 mm`.
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
- The right chamber has a rear slide-out tray opening through the lower back wall.
- The right tray back opening is `164.5 mm` wide and `44 mm` tall, leaving side material around the opening for M3 backplate fasteners.
- The former low internal floor rails in the right chamber are removed. Any replacement tray-guidance or retention system will be designed later.
- The right tray is a separate `3 mm` thick drawer-style part with a rear backplate, low side walls, Orange Pi mounting pads, and an exhaust opening in the backplate.
- The tray backplate bottom is flush with the tray floor bottom, so the rear wall does not extend below the sliding tray.
- The tray backplate is slightly larger than the rear opening and uses four M3 corner holes with at least `3 mm` edge margin on both the wall and the backplate.
- The Orange Pi mount uses the proven cottage tray orientation: the `94 mm` hole spacing runs across the tray and the `98 mm` spacing runs front/back toward the rear exhaust backplate.
- The rear stud pair is `3 mm` from the rear tray datum, matching the cottage-style exhaust-side convention.
- The Orange Pi board envelope starts `10 mm` from the left edge of the right tray.
- The right tray still contains the earlier Raspberry Pi 5 M2.5 mounting-stud study.
- The Raspberry Pi 5 mount uses the provided `85 mm x 56 mm` board envelope and `58 mm x 49 mm` mounting-hole rectangle.
- The Raspberry Pi 5 footprint is rotated so the port/jack edge faces the front of the deck.
- The corrected Orange Pi footprint makes the requested side-by-side Raspberry Pi placement exceed the tray width. Tray export remains intentionally blocked until the Raspberry Pi is relocated or removed.
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
