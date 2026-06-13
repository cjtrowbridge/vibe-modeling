# Servo Horn Receiver Voids for Agentic OpenSCAD Designs

Technical reference for `vibe-modeling` projects that need to design printed parts which receive servo horns, servo arms, or servo discs.

## 1. Purpose

This document defines how agents should design voids, pockets, recesses, and attachment features for parts that interface with hobby servo horns.

The goal is not merely to explain what servo horns are. The goal is to give the agentic OpenSCAD pipeline enough design information to reliably produce printable parts that can receive, trap, align, and fasten the stock plastic or metal servo horns supplied with a servo.

This reference is intended for projects in the `vibe-modeling` pipeline, where agents generate OpenSCAD source, JSON parameter configs, STL files, preview renders, and numbered revisions.

## 2. Core Rule

Prefer designing the printed part to receive a stock servo horn.

Do not directly 3D print a custom internal servo spline unless the task explicitly requires it and a tested spline profile is available.

For MG996R-class servos, the output spline is small, highly loaded, and difficult to print accurately. A stock horn is usually better because it already contains the correct spline, already fits the metal output shaft, and can be replaced if it strips or breaks.

The printed part should therefore contain a shaped void or pocket that receives the horn. The horn then becomes a mechanical insert between the servo shaft and the printed part.

## 3. Terminology

### Servo

A position-controlled rotary actuator. In this reference, the main target servo is an MG996R-compatible standard-size metal-gear hobby servo.

### Output Shaft

The rotating metal shaft on top of the servo. The shaft has a toothed spline and is usually secured with a central screw.

### Spline

The small toothed interface on the servo output shaft. MG996R-compatible servos are commonly sold as 25T spline servos, meaning the output spline has 25 teeth. Spline dimensions vary by manufacturer and clone.

### Servo Horn / Servo Arm

The standard removable plastic or metal piece that presses onto the servo spline. It transfers torque from the servo to the external mechanism.

“Servo horn” is the broad term. “Servo arm” usually refers to straight, cross, or star-shaped horns. “Servo disc” or “servo wheel” refers to a circular horn.

### Receiver Void

A negative-space feature in the printed part that accepts the servo horn. This may be a shallow recess, a through-pocket, a captive insert cavity, or a shaped anti-rotation socket.

### Pocket

A receiver void with a controlled depth, usually intended to seat the horn flush or nearly flush into the part.

### Anti-Rotation Feature

A shape that prevents the horn from rotating inside the printed part. The anti-rotation feature should usually come from the horn outline itself: cross shape, arm shape, star shape, disc-with-screws, or flats.

### Screw Boss / Screw Void

Printed material and holes used to fasten the horn to the part with screws.

## 4. Target Servo: MG996R-Compatible Standard Servo

The default target servo for this reference is an MG996R-compatible metal-gear hobby servo.

Typical published servo properties:

* Model family: MG996R / MG995-style standard-size servo
* Body size: approximately 40.7 mm x 19.7 mm x 42.9 mm
* Weight: approximately 55 g
* Operating voltage: approximately 4.8 V to 7.2 V
* Stall torque: approximately 9.4 kgf·cm at 4.8 V and 11 kgf·cm at 6 V
* Gear type: metal
* Output: splined shaft, commonly described as 25T
* Included hardware: selection of servo arms/horns and screws

The exact servo body, output shaft, and included horns can vary between TowerPro originals, MG996R-compatible clones, and replacement horn kits. Treat all horn dimensions as measurable part geometry, not as universal constants.

## 5. Design Strategy

There are three possible interface strategies.

### Strategy A: Stock Horn Insert Pocket

This is the preferred strategy.

The printed part contains a void shaped to receive the stock servo horn. The horn is pressed, dropped, or screwed into the printed part. The horn remains responsible for engaging the servo shaft.

Use this strategy for most 3D printed parts.

Advantages:

* Avoids modeling a tiny spline.
* Uses the manufacturer’s spline fit.
* Allows the horn to be replaced.
* Reduces risk of printed spline stripping.
* Works well with FDM tolerances.

### Strategy B: Horn Captured Inside a Sandwich

Use this when the horn must be trapped between two printed layers or when the part must survive higher torque.

The printed assembly has a lower pocket, horn insert, and upper retaining layer or cap. Screws pass through the printed material and the horn.

Advantages:

* Stronger retention.
* Better for cyclic torque.
* Reduces reliance on glue or friction.
* Allows serviceable disassembly if screws are accessible.

### Strategy C: Direct Printed Spline

Use only when explicitly required.

The printed part contains an internal 25T spline and mounts directly to the servo shaft.

This is not recommended for first-pass FDM parts. If this is attempted, the design must include a test coupon and must not be used for high-torque applications without validation.

Risks:

* Tooth geometry may print poorly.
* Small features can fuse or round over.
* Plastic can split during installation.
* The spline may strip under torque.
* Clone servo spline geometry may differ.

## 6. Measurement-First Workflow

Before modeling a production part, the agent should ask whether the actual horn has been measured.

If measurements are unavailable, the agent may use the starter defaults in this document, but it must label them as assumptions in the config and revision notes.

Recommended measurements:

1. Servo model and supplier.
2. Horn type: disc, cross/star, straight arm, double arm, or custom metal horn.
3. Horn material: plastic, aluminum, steel, unknown.
4. Overall horn outline dimensions.
5. Horn thickness.
6. Hub diameter.
7. Hub height above horn plate.
8. Center screw clearance diameter.
9. Screw hole count.
10. Screw hole diameter.
11. Screw hole positions measured from center.
12. Whether the horn should sit flush, proud, or recessed.
13. Desired rotational zero orientation.
14. Required torque direction and expected loads.

The agent should prefer a measured JSON parameter set over hardcoded geometry.

## 7. Coordinate System

Use a consistent coordinate system for servo horn receiver design.

Recommended convention:

* Servo output shaft axis is the local Z axis.
* Horn lies in the local XY plane.
* Horn center is at local `[0, 0, 0]`.
* Positive Z points outward from the servo shaft into the attached part unless the design defines otherwise.
* Rotational alignment is controlled by `horn_rotation_deg`.
* The receiver void is subtracted from the printed part using a transform around the horn center.

A project may invert this if needed, but the config must state the convention.

## 8. Default Receiver Pocket Anatomy

A robust receiver pocket usually has these features:

1. Horn outline recess.
2. Center hub clearance.
3. Center screw access hole.
4. Horn mounting screw holes or pilot holes.
5. Optional screw head countersinks or counterbores.
6. Optional captive clearance for horn thickness.
7. Optional retention cap or clamp layer.
8. Optional debug ghost geometry for preview renders.

### 8.1 Horn Outline Recess

The horn outline recess prevents rotation.

For a circular servo disc, a plain circular recess is not enough to prevent rotation unless screws are also used. A disc must be constrained by screws, flats, pins, or an added non-round pocket feature.

For cross, star, or straight arms, the outline itself can provide anti-rotation if the pocket is close-fitting.

### 8.2 Center Hub Clearance

Most horns have a raised center hub around the spline. The printed part must leave clearance for this hub unless the horn is mounted with the hub facing away from the part.

The agent must determine the orientation:

* Hub toward printed part: include hub pocket.
* Hub away from printed part: include center screw access but hub pocket may not be needed.
* Horn embedded between layers: include hub clearance on the appropriate side.

### 8.3 Center Screw Access

The central servo screw must remain accessible unless the horn is permanently captured before final assembly.

For MG996R-class servos, assume an M3-class center screw clearance until measured. A starting access hole of 3.2 mm to 3.4 mm is reasonable for a clearance hole, but the design must allow this to be configured.

Do not bury the center screw under inaccessible material unless the design intentionally makes the servo/horn assembly non-serviceable.

### 8.4 Horn Mounting Screws

Stock plastic horns usually include small holes for self-tapping linkage screws. Metal replacement horns may use machine screws.

The printed part should include matching clearance, pilot, or heat-set insert holes as appropriate.

The agent must not assume all horn holes are usable. Some holes may be too close to the center, too close to the edge of the printed part, or too small for the intended fastener.

## 9. Starter Dimensions for MG996R-Compatible Horns

These values are starting points only. They must be verified against the actual horn used in the project.

### 9.1 Servo Spline

Use only for reference unless direct-spline mode is explicitly requested.

* Tooth count: 25T
* Approximate spline outer diameter: 5.9 mm to 6.0 mm
* Approximate spline root diameter: around 5.4 mm
* Center screw: commonly M3-class
* Recommended direct printed spline clearance: begin with +0.10 mm to +0.20 mm radial/diameter adjustment depending on printer and material

Direct printed spline design requires a test coupon.

### 9.2 Circular Servo Disc / Wheel

Typical starting values:

* Disc outer diameter: 20 mm to 21 mm
* Horn plate thickness: 1.8 mm to 2.4 mm
* Raised hub outer diameter: 8 mm to 10 mm
* Raised hub height: 2 mm to 4 mm
* Screw hole pattern: often four or more holes around the center
* Common bolt circle starting range: 14 mm to 15 mm
* Small screw clearance: 2.0 mm to 3.0 mm depending on actual fastener
* Center screw access: 3.2 mm to 3.4 mm starting clearance

A circular disc must be mechanically constrained with screws, pins, flats, or other anti-rotation features. Do not rely on a circular friction pocket alone for torque transfer.

### 9.3 Cross / Star Horn

Typical starting values:

* Tip-to-tip span: 38 mm to 40 mm
* Arm width: 5 mm to 7 mm
* Arm thickness: 1.8 mm to 2.4 mm
* Hub outer diameter: 8 mm to 10 mm
* Screw holes: multiple small holes along each arm
* Hole spacing: often in 2 mm to 2.5 mm increments from center
* Small screw clearance: usually M2-class until measured

The cross/star outline is useful for anti-rotation, but the pocket must include enough clearance to actually insert the horn after printing.

### 9.4 Straight or Double Arm Horn

Typical starting values:

* Overall length: 30 mm to 35 mm
* Width near hub: 6 mm to 8 mm
* Width near ends: 4 mm to 6 mm
* Thickness: 1.8 mm to 2.4 mm
* Hole spacing: often 2 mm to 2.5 mm increments from center

A straight arm has weaker anti-rotation than a cross/star horn if the pocket is shallow. Prefer screws, a deeper pocket, or a sandwich capture if torque is significant.

## 10. Recommended FDM Tolerances

The following tolerances are starting points for FDM printing with PLA, PETG, or similar materials.

### 10.1 Pocket Side Clearance

For a horn inserted into a printed pocket:

* Tight fit: +0.10 mm to +0.15 mm per side
* Normal serviceable fit: +0.20 mm to +0.35 mm per side
* Loose fit with screws doing the alignment: +0.35 mm to +0.50 mm per side

Use normal serviceable fit unless the user explicitly requests press fit.

### 10.2 Pocket Depth Clearance

If the horn should sit flush:

* Pocket depth should be horn thickness + 0.10 mm to 0.30 mm.
* If the horn is slightly proud, subtract 0.10 mm to 0.30 mm from horn thickness.
* If the horn must be fully buried, include the horn thickness, hub height, and clearance.

### 10.3 Screw Hole Clearances

Starting values:

* M2 clearance hole: 2.2 mm to 2.4 mm
* M2 pilot hole for plastic self-tapping: 1.6 mm to 1.9 mm
* M2.5 clearance hole: 2.7 mm to 2.9 mm
* M3 clearance hole: 3.2 mm to 3.4 mm
* M3 pilot hole for plastic self-tapping: 2.5 mm to 2.8 mm

Use larger clearances if the printer tends to undersize holes.

### 10.4 Minimum Wall Thickness

Around horn pockets and screw holes:

* Minimum local wall thickness: 1.6 mm
* Preferred wall thickness: 2.4 mm to 3.2 mm
* High torque or cyclic load: 4.0 mm or more, with fillets and ribs

Do not place screw holes so close to the pocket wall that the surrounding material becomes a thin crescent.

### 10.5 Fillets, Chamfers, and Lead-Ins

The pocket should include a small lead-in chamfer or bevel when possible.

Recommended:

* Pocket edge chamfer: 0.3 mm to 0.6 mm
* External stress fillets around bosses/ribs: 1.0 mm to 3.0 mm
* Avoid sharp internal corners where torque loads concentrate.

OpenSCAD may approximate these with cylinders, hulls, offsets, minkowski operations, or intentionally rounded 2D profiles.

## 11. JSON Config Pattern

Designs using servo horn receiver voids should include a dedicated config block.

Example:

```json
{
  "servo_interface": {
    "enabled": true,
    "servo_model": "MG996R-compatible",
    "servo_body_source": "published MG996R dimensions; verify actual unit",
    "use_stock_horn": true,
    "direct_spline_mode": false,

    "shaft_axis": "Z",
    "horn_center": [0, 0, 0],
    "horn_rotation_deg": 0,

    "horn_type": "cross",
    "horn_material": "stock plastic",
    "horn_tooth_count": 25,

    "horn_thickness_mm": 2.1,
    "horn_pocket_depth_mm": 2.3,
    "pocket_clearance_xy_mm": 0.25,
    "pocket_clearance_z_mm": 0.20,

    "hub_od_mm": 9.0,
    "hub_height_mm": 3.0,
    "hub_clearance_xy_mm": 0.30,
    "hub_clearance_z_mm": 0.30,

    "center_screw_access_diameter_mm": 3.4,

    "cross_tip_to_tip_mm": 39.0,
    "cross_arm_width_mm": 6.0,
    "cross_arm_end_radius_mm": 3.0,

    "mounting_holes_enabled": true,
    "mounting_hole_diameter_mm": 2.3,
    "mounting_hole_positions_mm": [
      [0, 7.5],
      [7.5, 0],
      [0, -7.5],
      [-7.5, 0]
    ],

    "measurement_status": "starter defaults; verify with calipers before final print",
    "notes": "Receiver pocket is for stock MG996R-compatible horn, not direct printed spline."
  }
}
```

Agents should expose these as config parameters rather than hardcoding them into `.scad` files.

## 12. OpenSCAD Design Pattern

The servo horn receiver should be modeled as subtractive geometry.

General pattern:

```scad
difference() {
    main_part();

    translate(horn_center)
        rotate([0, 0, horn_rotation_deg])
            servo_horn_receiver_void();
}
```

Use a small epsilon to avoid coplanar artifacts:

```scad
eps = 0.02;
```

Void geometry should extend slightly beyond the nominal cut depth:

```scad
translate([0, 0, -eps])
linear_extrude(height = pocket_depth + 2 * eps)
    horn_outline_2d();
```

### 12.1 Disk Receiver Void

For a circular horn disc:

```scad
module horn_disc_receiver_void(
    disc_od = 21,
    pocket_depth = 2.3,
    clearance_xy = 0.25,
    center_access_d = 3.4,
    hub_od = 9,
    hub_depth = 3.3,
    eps = 0.02
) {
    union() {
        cylinder(
            d = disc_od + 2 * clearance_xy,
            h = pocket_depth + 2 * eps,
            center = false,
            $fn = 96
        );

        cylinder(
            d = hub_od + 2 * clearance_xy,
            h = hub_depth + 2 * eps,
            center = false,
            $fn = 64
        );

        cylinder(
            d = center_access_d,
            h = 100,
            center = true,
            $fn = 48
        );
    }
}
```

A disc receiver must include screw holes or other anti-rotation features. Do not rely on the circular pocket alone.

### 12.2 Cross Horn Receiver Void

A cross horn can be approximated as two rounded rectangular arms crossing at 90 degrees.

```scad
module rounded_arm_2d(length, width) {
    hull() {
        translate([-length / 2 + width / 2, 0])
            circle(d = width, $fn = 32);
        translate([ length / 2 - width / 2, 0])
            circle(d = width, $fn = 32);
    }
}

module cross_horn_outline_2d(
    tip_to_tip = 39,
    arm_width = 6,
    clearance_xy = 0.25
) {
    offset(delta = clearance_xy) {
        union() {
            rounded_arm_2d(tip_to_tip, arm_width);
            rotate(90)
                rounded_arm_2d(tip_to_tip, arm_width);
            circle(d = arm_width * 1.5, $fn = 48);
        }
    }
}

module cross_horn_receiver_void(
    tip_to_tip = 39,
    arm_width = 6,
    pocket_depth = 2.3,
    clearance_xy = 0.25,
    hub_od = 9,
    hub_depth = 3.3,
    center_access_d = 3.4,
    eps = 0.02
) {
    union() {
        translate([0, 0, -eps])
            linear_extrude(height = pocket_depth + 2 * eps)
                cross_horn_outline_2d(
                    tip_to_tip = tip_to_tip,
                    arm_width = arm_width,
                    clearance_xy = clearance_xy
                );

        translate([0, 0, -eps])
            cylinder(
                d = hub_od + 2 * clearance_xy,
                h = hub_depth + 2 * eps,
                center = false,
                $fn = 64
            );

        cylinder(
            d = center_access_d,
            h = 100,
            center = true,
            $fn = 48
        );
    }
}
```

### 12.3 Mounting Screw Voids

Mounting screw voids should be separate modules so the agent can reuse them across disc, cross, and arm receivers.

```scad
module servo_horn_mounting_hole_voids(
    hole_positions = [[0, 7.5], [7.5, 0], [0, -7.5], [-7.5, 0]],
    hole_d = 2.3,
    through_depth = 100,
    countersink_enabled = false,
    head_d = 4.5,
    head_depth = 1.5
) {
    for (p = hole_positions) {
        translate([p[0], p[1], 0]) {
            cylinder(d = hole_d, h = through_depth, center = true, $fn = 32);

            if (countersink_enabled) {
                translate([0, 0, through_depth / 2 - head_depth])
                    cylinder(d = head_d, h = head_depth + 0.02, center = false, $fn = 32);
            }
        }
    }
}
```

The agent should align screw holes to actual horn holes whenever measurements are available.

## 13. Agent Instructions for New Designs

When a user asks for a part that attaches to a servo:

1. Identify the servo model.
2. Ask whether the user will use the stock horn, a metal replacement horn, or a direct printed spline.
3. Default to stock horn insert pocket unless told otherwise.
4. Ask for caliper measurements or reference photos if the horn shape is important.
5. Add a `servo_interface` block to the design config.
6. Keep all horn dimensions configurable.
7. Model the receiver void as subtractive geometry.
8. Include center screw access.
9. Include mounting screw holes if the horn is a disc or if torque loads are meaningful.
10. Preserve serviceability unless the user explicitly wants a permanent assembly.
11. Generate preview renders that clearly show the pocket from below, above, and isometric angles.
12. Report assumptions in the revision notes.

Do not silently invent a direct spline. Do not bury the center screw. Do not rely on friction alone for torque transfer unless the user explicitly asks for a press-fit prototype.

## 14. Verification Checklist

Before marking a servo-horn receiver design complete, the agent must verify:

* The config includes servo model and horn type.
* The design states whether it uses a stock horn or direct printed spline.
* The receiver void has enough XY clearance for the chosen process.
* The horn can physically be inserted in the modeled orientation.
* The center screw remains accessible.
* Screw holes align with the horn or are clearly marked as assumptions.
* There is enough wall thickness around the pocket.
* The horn has an anti-rotation path.
* Torque is transferred through shape, screws, clamp force, or a sandwich capture, not through an accidental thin wall.
* Preview renders show the receiver pocket.
* A first-use project includes either a small test coupon or a low-risk prototype print.

## 15. Recommended Test Coupon

For a new horn or supplier, create a small test coupon before printing the full part.

The coupon should include:

* The horn outline pocket.
* The hub clearance.
* The center screw access.
* At least two representative mounting holes.
* A label embossed or engraved with the clearance value.
* Optional variants with clearances such as 0.15 mm, 0.25 mm, and 0.35 mm.

A test coupon is especially important when:

* The horn is a clone part.
* The horn is metal.
* The pocket is meant to be tight.
* The final part is large or slow to print.
* The mechanism will carry torque or cyclic loads.

## 16. Common Failure Modes

### Pocket Too Tight

Symptoms:

* Horn does not seat.
* Part splits during insertion.
* Horn bows or bends.
* Screw holes do not align after forcing.

Fixes:

* Increase `pocket_clearance_xy_mm`.
* Add chamfers.
* Add a test coupon.
* Confirm printer hole compensation.

### Pocket Too Loose

Symptoms:

* Horn rattles.
* Mechanism has backlash.
* Screws carry all torque.
* Printed part rotates before servo motion begins.

Fixes:

* Reduce clearance.
* Add screws.
* Add ribs or flats.
* Use a sandwich capture.
* Use a cross/star horn instead of a circular disc.

### Center Screw Inaccessible

Symptoms:

* Servo cannot be assembled or serviced.
* Horn cannot be removed.
* Assembly requires destructive disassembly.

Fixes:

* Add a through access hole.
* Add a removable cap.
* Move retaining screws outward.
* Change horn orientation.

### Circular Horn Slips

Symptoms:

* Disc rotates inside the printed pocket.
* Screws loosen.
* Servo moves but part lags or twists.

Fixes:

* Use screws as real torque pins.
* Add keyed flats.
* Add dowel pin holes.
* Use a non-circular horn.
* Increase pocket depth and use a retaining layer.

### Printed Spline Strips

Symptoms:

* Part installs but loses position under load.
* Servo shaft spins inside printed part.
* Tooth geometry is rounded or fused.

Fixes:

* Use the stock horn.
* Use a metal horn.
* Use a clamp hub.
* Increase material strength.
* Print a calibrated test spline only if direct spline is unavoidable.

## 17. Third-Party Reference Models

Third-party CAD models may be useful, but they must not become hidden assumptions.

Acceptable uses:

* Visual reference.
* Servo body clearance checking.
* Horn outline reference.
* Creating measured starter configs.
* Comparing approximate geometry.

Unsafe uses:

* Blindly copying dimensions.
* Assuming all MG996R clones match.
* Treating downloaded horn geometry as a standard.
* Depending on remote files at build time.

If vendoring third-party resources, place them under a dedicated folder such as:

```text
third_party/
  mg996r/
    README.md
    LICENSE-or-source-notes.md
    reference_models/
    measured_configs/
```

Each vendored reference should include:

* Source name.
* Original author or supplier if known.
* License if known.
* Date downloaded.
* File format.
* What the file is used for.
* Whether dimensions were verified by measurement.
* Whether the file is allowed to be redistributed.

Do not make the OpenSCAD build depend on non-committed external downloads.

## 18. Suggested Repository Placement

This document should live at:

```text
docs/technical/servo_horn_receiver_voids.md
```

Projects that use this interface may also include design-specific notes at:

```text
designs/<design>/docs/servo_interface.md
```

A reusable OpenSCAD helper may eventually live at:

```text
designs/<design>/src/lib/servo_horn_receivers.scad
```

or, if the repository adds shared OpenSCAD libraries:

```text
lib/servo_horn_receivers.scad
```

## 19. Minimum Acceptance Criteria for Agentic Pipeline Use

A servo-horn receiver design is acceptable only if:

1. It uses config-driven dimensions.
2. It identifies the servo model.
3. It identifies the horn type.
4. It states whether dimensions are measured or assumed.
5. It keeps the center screw accessible or explicitly documents why not.
6. It includes an anti-rotation strategy.
7. It includes screw holes, clamp features, or sandwich capture when needed.
8. It generates STL and preview artifacts through the normal pipeline.
9. It produces inspection renders showing the receiver void.
10. It records all assumptions in the revision notes.

## 20. Default Agent Prompt Snippet

When designing a servo-driven part, the agent should internally apply this prompt:

> The part interfaces with an MG996R-compatible servo. Default to receiving a stock servo horn in a printed pocket rather than printing a direct spline. Use configurable OpenSCAD parameters for horn type, horn outline, pocket clearance, pocket depth, hub clearance, center screw access, mounting screw holes, and horn rotation. Treat starter dimensions as assumptions until measured. Preserve serviceability and generate inspection renders showing the receiver void.

## 21. Short Design Rule Summary

* Use the stock horn.
* Measure the actual horn.
* Put dimensions in JSON.
* Subtract a shaped receiver void.
* Keep the center screw accessible.
* Use screws or shape for torque.
* Do not trust circular friction pockets.
* Do not print a direct spline unless explicitly required.
* Make a test coupon for new horns.
* Document every assumption.
