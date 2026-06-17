# Cyberdeck Dome Pan/Tilt Apparatus Plan

This document records the first implementation plan for the sensor dome mechanism before any OpenSCAD geometry is added.

The goal is a serviceable MG996R-based pan/tilt gimbal inside the existing dome bucket insert. The mechanism carries one `32 mm x 32 mm` USB PCB camera and two cylindrical laser diode modules, one on each side of the camera.

## Source References

- `reference/designing-for-servos.md`
- `reference/working-with-servo-receivers.md`

Servo rules from those references are binding for this mechanism:

- Use the `mg996r_standard_servo_profile_v1` body profile.
- Do not invent MG996R mounting geometry.
- Do not center the MG996R shaft in the servo body.
- Use the stock servo horn as the torque interface.
- Do not print a direct servo spline.
- Keep horn center-screw access serviceable.
- Include wire relief for every servo body mount.
- Treat horn dimensions as assumptions until the actual horn is measured.
- Prefer a test coupon for the first horn receiver pocket.

## Existing Bucket Constraints

- Dome roof hole: `96 mm`.
- Dome bucket outer diameter: `94 mm`, with `1 mm` radial slide clearance into the roof hole.
- Dome bucket wall thickness: `3 mm`.
- Dome bucket inner diameter: about `88 mm`.
- Dome bucket internal floor is elevated `3 mm` above the chamber base.
- Dome bucket floor thickness: `3 mm`.
- Dome bucket lip and bucket wall are both `3 mm` thick.
- Existing bucket includes front and side wiring passthrough windows.
- Acrylic dome outer diameter: `115 mm`.

The pan/tilt design must fit inside the dome bucket and remain inside the acrylic dome swept volume. The bucket insert is a removable/serviceable module, so the gimbal should be serviceable without reprinting the chamber body.

## Payload Assumptions

- Camera board:
  - Board size: `32 mm x 32 mm`.
  - Lens is centered on the board.
  - Diagram indicates top-side USB pads/connector markings and a rear-mounted USB pigtail.
  - Mounting holes appear near the four board corners, but exact hole diameter and center spacing must be measured before final screw bosses are modeled.
- Laser modules:
  - Quantity: `2`.
  - Shape: simple cylinder.
  - Diameter: `12 mm`.
  - Length: `35 mm`.
  - Wires exit from the rear of each cylinder.
  - One laser sits on each side of the camera board.
- Approximate face width:
  - Camera board: `32 mm`.
  - Two lasers: `12 mm + 12 mm`.
  - Minimum local clearance/mounting material between camera and lasers still needs to be assigned.
  - First-pass front carriage should assume at least `64 mm` total width before yoke pivots and side walls.

## Mechanism Architecture

### 1. Fixed Pan Servo Mount

- Mount one MG996R vertically on the raised bucket floor.
- The pan servo shaft axis is vertical and aligned to the bucket centerline.
- The servo body is offset from the bucket center because the MG996R shaft is offset from its body/flange center.
- Use shaft-centered MG996R coordinates for the mount:
  - Shaft center: `[0, 0]`.
  - Mounting holes: `[-36, -5]`, `[-36, 5]`, `[14, -5]`, `[14, 5]`.
  - Body extents in shaft-centered coordinates: approximately `x = -31.15 mm` to `9.15 mm`, `y = -10 mm` to `10 mm`.
- Add a rectangular body clearance pocket or cradle using the MG996R serviceable cutout dimensions:
  - Body cutout: `41.1 mm x 20.8 mm`.
- Add four M3-compatible mounting bosses or through holes at the real MG996R tab pattern.
- Provide an `8 mm x 5 mm` or larger wire relief path for the pan servo lead.
- Leave vertical access to the pan servo horn center screw.

### 2. Pan Rotating Plate

- The pan servo drives a rotating plate through a stock servo horn captured in a receiver pocket.
- Do not attach the rotating plate directly to a printed spline.
- Preferred first-pass interface:
  - Stock cross/star or disc horn inserted into a printed receiver pocket.
  - Center screw access hole aligned with the servo shaft.
  - Horn mounting screws or sandwich capture to transmit torque.
- A circular horn pocket alone is not acceptable unless screws or anti-rotation features carry torque.
- The rotating plate should include a broad bearing/skid surface or low-friction support pads so the servo shaft does not carry the whole vertical/radial load.
- Add mechanical pan hard stops to prevent wire wrap.
- Initial target pan travel should be less than continuous rotation; start with approximately `+/-90 degrees` unless a later cable-management design supports more.

### 3. Tilt Servo Mount On Pan Plate

- Mount the second MG996R on the rotating pan plate.
- The tilt servo shaft axis is horizontal.
- The tilt servo body rotates with the pan plate.
- Use the MG996R standard body profile and real tab-hole pattern.
- Include body clearance, tab supports, screw holes/bosses, horn sweep clearance, center screw access, and wire relief.
- Orient the tilt servo so its wire exits toward the rear or downward into the pan plate cable channel.
- The tilt servo should drive one side of the camera/laser armature through a stock horn receiver.

### 4. Tilt Yoke And Passive Axle

- Use a U-shaped yoke rather than a single-sided cantilever.
- One side is driven by the tilt servo horn.
- The opposite side uses a passive axle/bushing so the camera/laser carriage is supported on both sides.
- The passive axle should align with the tilt servo shaft centerline.
- The yoke side walls should clear the camera board, laser bodies, laser wiring, and USB pigtail during the full tilt sweep.
- Add mechanical tilt hard stops.
- Initial target tilt travel should be conservative, such as about `-30 degrees` downward to `+60 degrees` upward, until the dome and cable sweep are verified.

### 5. Camera/Laser Carriage

- Build a front carriage that holds:
  - the `32 mm x 32 mm` camera PCB centered on the optical axis,
  - one `12 mm x 35 mm` laser cylinder to the left,
  - one `12 mm x 35 mm` laser cylinder to the right.
- Laser modules should be mounted in cylindrical clamp saddles, not loose holes.
- Each laser saddle should leave rear wire exit clearance.
- Camera mounting should use measured board holes when available; until then, use a proxy board and avoid committing final screw-hole positions.
- The two lasers should be parallel to the camera optical axis in the first revision.
- Add later adjustment features if distance calibration or laser spot convergence becomes important.
- Include strain relief for:
  - USB camera pigtail,
  - left laser wires,
  - right laser wires.

## Cable Routing Plan

- Route camera USB, laser wires, and tilt servo lead down through the rotating pan stage.
- Provide a central service loop around the pan axis.
- Avoid sharp bends immediately behind the camera PCB or laser modules.
- Route all wires toward the existing front/side bucket passthroughs.
- Add hard stops before any wire can wind around the pan axis.
- Do not assume unlimited pan rotation.

## Servo Horn Receiver Plan

Use a configurable receiver system for both pan and tilt driven parts.

Initial config fields should include:

- `servo_model = "MG996R-compatible standard servo"`.
- `servo_profile = "mg996r_standard_servo_profile_v1"`.
- `use_stock_horn = true`.
- `direct_spline_mode = false`.
- `horn_type = "cross"` or measured actual horn type.
- `horn_measurement_status = "starter defaults; verify with calipers"`.
- `horn_pocket_clearance_xy = 0.25`.
- `horn_pocket_depth = measured_horn_thickness + 0.2`.
- `hub_clearance_d = measured_hub_od + 0.6`.
- `center_screw_access_d = 7.0`.
- `horn_mounting_hole_positions = measured actual horn hole positions`.

Before finalizing the gimbal, create a small horn receiver test coupon with at least one pocket and center screw access.

## Laser Use Notes

- The lasers can be used for visual pointing.
- They do not independently measure distance unless a calibration method observes the laser spot positions through the camera or another sensor.
- If distance estimation is desired later, the two laser mounts should support calibration:
  - known baseline between laser centers,
  - known laser angle relative to camera axis,
  - stable, non-flexing mounts,
  - software calibration target procedure.

## First CAD Implementation Units

Implement the mechanism as separate parts before integrating into the bucket:

1. `dome_pan_servo_cradle`
   - fixed MG996R vertical pan mount,
   - shaft centered on bucket axis,
   - real tab-hole pattern,
   - wire relief,
   - center screw access.
2. `dome_pan_rotating_plate`
   - horn receiver pocket,
   - broad support surface,
   - mounting structure for tilt servo,
   - pan hard-stop features.
3. `dome_tilt_servo_yoke`
   - horizontal MG996R tilt mount,
   - passive axle support side,
   - horn receiver interface to carriage,
   - tilt hard stops.
4. `dome_camera_laser_carriage`
   - camera PCB proxy,
   - dual laser clamp saddles,
   - cable strain relief,
   - passive axle and driven horn interface.
5. `dome_gimbal_clearance_mockup`
   - assembled swept-volume study inside the current dome bucket and acrylic dome envelope.

Do not combine these into the existing bucket STL until their clearances are visually and dimensionally verified.

## Required Assertions And Reviews

When implemented, the SCAD/config must assert:

- MG996R body cutouts are at least `41.1 mm x 20.8 mm`.
- MG996R mount holes use the real `[+/-25, +/-5]` flange-centered or `[-36, +/-5]`, `[14, +/-5]` shaft-centered pattern.
- Pan servo shaft is centered on the bucket axis.
- Pan servo body and mounting bosses remain inside the bucket inner diameter with at least `3 mm` material where structural.
- Servo wire reliefs are present and do not cut required structural ligaments below `3 mm`.
- Horn receiver pockets preserve center screw access.
- Horn receiver pockets do not rely on circular friction alone for torque.
- Pan plate support/bearing surface clears the bucket wall through the intended pan range.
- Tilt yoke and carriage swept volume clears the acrylic dome and bucket wall.
- Camera USB pigtail and laser wires have clearance through the intended tilt range.
- Hard stops prevent wire wrap or collision before servo limits are reached.
- Every new structural join has at least `3 mm` positive-volume overlap.
- Every post-cut material ligament remains at least `3 mm`.

## Open Measurements Needed

- Actual MG996R supplier/model confirmation.
- Actual stock horn type to use for pan.
- Actual stock horn type to use for tilt.
- Horn thickness.
- Horn hub OD and height.
- Horn mounting-hole positions and diameters.
- Servo horn center screw head/tool access needs.
- Actual camera PCB mounting-hole diameter and spacing.
- Camera pigtail exit height and bend radius.
- Laser module wire-exit stiffness and minimum bend radius.
- Desired pan range.
- Desired tilt range.
- Whether lasers need adjustable convergence or fixed parallel alignment.

## Initial Recommendation

The two-MG996R pan/tilt architecture is viable, but it should be designed as a serviceable gimbal cartridge:

- fixed vertical pan servo in the bucket,
- horn-driven rotating pan plate with separate support surface,
- horizontal tilt servo on that plate,
- two-sided tilt yoke,
- camera and dual lasers on a balanced carriage,
- hard stops and wire service loops before any cosmetic detailing.

The most important risk to manage is not torque. It is packaging and cable motion inside the dome.
