# cyberdeck

First-draft visual mockup and design brief for a cyberdeck OpenSCAD model.

## Current scope

- Creates the standard design folder layout.
- Provides a `main.scad` scripted export entrypoint.
- Provides a minimal `rev_0001.json` config with numeric `part_id`.
- Provides a first-draft visual mockup for layout review.
- Uses known dimensions from the design brief where available.
- Uses clearly named proxy dimensions for hardware that still needs exact mechanical measurement.
- Does not yet define printable enclosure details, final mounting geometry, wiring channels, or manufacturable clearances.

## Part IDs

- `part_id = 0`: full visual mockup
- `part_id = 1`: top layout mockup
- `part_id = 2`: internal hardware proxy layout

## Revision 0001 Mockup Notes

- Overall visual envelope is currently `425 mm x 300 mm x 42 mm`.
- Chassis width is allowed to exceed the unfolded keyboard width so the screen can sit beside the acrylic eye module.
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
