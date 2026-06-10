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
- `part_id = 6`: three inset lid preview layout
- `part_id = 7`: left-front inset lid
- `part_id = 8`: center-left inset lid
- `part_id = 9`: right-front inset lid
- `part_id = 10`: left-side carrying handle
- `part_id = 11`: dome bucket insert
- `part_id = 12`: right chamber Orange Pi tray

## Revision 0002 Printable Chamber Study

- Printer build-volume constraint is assumed to be `220 mm x 220 mm x 220 mm`.
- The cyberdeck lower structure is split into two printable chambers that meet at the centerline.
- Each chamber body footprint is currently `192.5 mm x 210 mm`, so each individual print fits inside the build volume.
- Flat chamber height is currently `52 mm`; side-profile peak height is currently about `119.2 mm`.
- Raised back-wall top height is currently about `93.8 mm`.
- Combined assembled footprint is currently about `385 mm x 210 mm x 119.2 mm`.
- The raised display wedge is right-aligned and currently `260 mm` wide.
- The left edge of the raised display wedge lands at assembled `x = -67.5 mm`.
- The left flat dome planning area is currently `125 mm` wide.
- The left dome area has a flat `2 mm` top roof extending from the display wedge edge to the left outer edge.
- The left dome roof is currently a `125 mm x 125 mm` planning area for the acrylic dome footprint.
- A matching flat `2 mm` top band now extends from the dome roof edge across the front of the display wedge to the right outer edge.
- This front control band runs from assembled `y = -20 mm` to the start of the `45 degree` screen slope at assembled `y = 12.424 mm`.
- The front control band includes two `23 mm` circular cutouts for screw-in heavy-duty USB-C panel jacks.
- The USB-C jack cutouts are centered front/back in the control band at about assembled `y = -3.8 mm`.
- The USB-C jack cutout centers align left/right with the `210 mm` screen void edges at assembled `x = -42.5 mm` and `x = 167.5 mm`.
- The shared OpenSCAD label font is currently `Orbitron:style=Bold`.
- The USB-C jack labels are wrapped as two-line engravings on the inner side of the holes: `Power` / `Cell` beside the left jack and `Neural` / `Jack` beside the right jack.
- The dome roof has a centered `96 mm` circular cutout.
- The acrylic dome mount uses four M3 clearance holes on a `56 mm` radius bolt circle.
- The dome M3 holes are placed in the top-left, top-right, bottom-left, and bottom-right quadrant positions around the dome cutout.
- The flat keyboard bay is intentionally open from above for continued layout, mounting, and service-access design.
- The flat keyboard bay now includes an internal support rail for a future inset lid.
- The future keyboard-area lid is planned to sit `2 mm` below the flat deck top and rest on a `6 mm` wide, `2 mm` tall rail around the opening.
- All three front lid rail frames now stop at assembled `y = -20 mm`, matching the front edge of the dome roof and front control band.
- The keyboard-area lid rail is constrained to the display/keyboard bay to the right of the dome roof so it does not intersect the dome cutout.
- The center and right front lids are shortened to match the left-front lid depth, leaving the new solid control band behind them.
- The three inset lids are modeled as separate `5 mm` thick panels with `0.6 mm` edge clearance, `3 mm` corner radii, engraved orientation labels, and obround pull slots.
- Each lid opening has small corner pads pulled into the opening for M3 corner fasteners.
- Each lid has four M3 clearance holes inset `8 mm` from the lid edges, with `7 mm` diameter counterbores so the screw heads sit below the top face.
- The thicker lids rest on the inset rail and may sit slightly proud of the surrounding deck surface.
- The three-lid preview layout shows all lids together; export the individual lid part IDs for printable files.
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
- Chamber walls and bottom floor are currently `2 mm` thick.
- The short rear clearance slope and forward screen slope are shelled with a `2 mm` normal offset.
- The flat keyboard deck area remains open; it does not have a top roof panel.
- The four left/right side walls now use a hybrid raised-back side profile instead of the earlier peaked tent profile.
- The front area remains at the flat keyboard-deck height.
- The front flat keyboard bay is now about `117.4 mm` deep in the current side-profile study.
- The screen slope starts farther back to clear the approximately `115 mm` keyboard depth.
- The rear edge is now a raised vertical back wall, not a low flat-height edge.
- The short rear slope runs from the side-profile ridge down to the raised back-wall top.
- Current side-profile ridge rises about `67.2 mm` above the flat chamber top.
- The short rear clearance slope uses a `25.4 mm` run and `25.4 mm` drop, matching the approximate `1 inch` screen-depth clearance target.
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
- The center seam keeps the lower base-wall joint structure, flush passthroughs, bolt bosses, and M3 bolt pattern.
- The display wedge uses an external split-line joining rail at the left/right chamber seam.
- Each printed half gets one half of the rail at its mating edge, with M3 clearance holes running through the rail across the split.
- The split-line rail is proud of the rear clearance slope, embedded `1 mm` into the `2 mm` wall for print attachment without protruding into the interior, and remains outside the screen void area.
- The split-line rail is modeled as a continuous flat-ended `15 mm` tab that follows the rear slope and extends down the rear back wall to the bottom of the chamber.
- The two upper M3 hole centers remain inset `10 mm` from the rear-slope bends so screw heads and nuts have edge clearance.
- The rear-wall extension keeps two M3 through-holes at `z = 65 mm` and `z = 83 mm` so the raised connector block can clamp the two printed halves together above the tray backplate.
- The lower vertical part of the rear external join-ridge now starts above the right-tray backplate, leaving at least `1 mm` clearance over the backplate top.
- The right chamber has a rear slide-out tray opening through the lower back wall.
- The right tray back opening is `164.5 mm` wide and `44 mm` tall, leaving side material around the opening for M3 backplate fasteners.
- The right chamber includes low internal floor rails to guide the tray and keep it registered against the chamber bottom.
- The right tray is a separate `3 mm` thick drawer-style part with a rear backplate, low side walls, Orange Pi mounting pads, and an exhaust opening in the backplate.
- The tray backplate bottom is flush with the tray floor bottom, so the rear wall does not extend below the sliding tray.
- The tray backplate is slightly larger than the rear opening and uses four M3 corner holes with at least `3 mm` edge margin on both the wall and the backplate.
- The Orange Pi proxy mount is rotated so the long mount-hole spacing runs front/back toward the rear exhaust backplate.
- The rear stud pair is the exhaust-side pair, matching the cottage-style tray convention.
- The Orange Pi proxy footprint starts about `10 mm` from the left edge of the right tray.
- The right tray also includes Raspberry Pi 5 M2.5 mounting studs in the marked right-side area.
- The Raspberry Pi 5 mount uses the provided `85 mm x 56 mm` board envelope and `58 mm x 49 mm` mounting-hole rectangle.
- The Raspberry Pi 5 footprint is rotated so the port/jack edge faces the front of the deck.
- The Raspberry Pi 5 footprint starts `20 mm` to the right of the Orange Pi footprint.
- This first variant models the side-profile shell and angled rear/screen surfaces; it does not yet add the actual screen recess or dome mounting ring.
- The left and right chambers have matching circular side passthroughs on the mating faces.
- Current design uses two `30 mm` passthroughs, split front/back from the centerline.
- The passthrough centerline is lowered to `z = 22 mm` so the flush conduit holes clear the inset lid rails.
- Passthrough centers are currently `52.5 mm` forward and `73 mm` back from the middle of the mating face.
- The rear passthrough is aligned near the rear `2U` screw row to put more material continuity around the display cutout.
- The mating faces use a six-bolt M3 pattern.
- Four bolts sit near the mating-face corners.
- Two bolts sit on the vertical centerline, one low and one high.
- Bolt holes are modeled as `3.4 mm` M3 clearance holes.
- Local reinforcement bosses remain around the M3 bolt pattern, while the passthrough conduits are plain flush holes through the mating faces.
- This revision is still an enclosure architecture study, not a final printable mechanical design.
- Next steps are to add top mounting interfaces for the keyboard/screen, internal standoffs, cooling ducts, cable paths, and service clearances.

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
