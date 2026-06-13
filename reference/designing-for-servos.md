# MG996R Servo Body Mounts, Screw Bosses, and Clearance Voids for Agentic OpenSCAD Designs

Technical reference for `vibe-modeling` projects that need to design printed structures that hold an MG996R-compatible standard hobby servo while leaving correct clearance for the output shaft, servo horn, attached moving part, screw mounts, and wiring.

## 1. Purpose

This document defines a source-backed MG996R servo body mounting profile for agentic OpenSCAD designs.

The goal is to prevent agents from inventing servo mount geometry. Agents should use the fixed dimensional profile in this document unless the project explicitly names a different servo model.

This document is the companion to the servo horn receiver document. The horn receiver document covers the rotating driven part. This document covers the fixed servo holder.

## 2. Core Rule

For MG996R-compatible servos, design the printed mount around the standard MG996R/standard-size servo footprint:

* Main body is approximately 40.3–40.7 mm long.
* Width is approximately 19.7–20.0 mm.
* Overall tab-to-tab/flange length is approximately 53.6–54.0 mm.
* Mounting holes/slots follow a four-hole pattern:

  * Longitudinal pitch: 50.0 mm.
  * Transverse pitch: 10.0 mm.
  * Tab hole/slot diameter: 4.0 mm.
* Shaft center is offset toward one end, not centered in the body.
* Shaft center is approximately 16.0 mm from the nearest overall flange end.

Agents should not say “measure the servo” as a substitute for designing the mount. Use the named MG996R profile below.

Measurement or supplier-specific validation is still useful for production, but the pipeline should be able to generate a correct first-pass MG996R mount from this document alone.

## 3. Source-Backed MG996R Dimensional Profile

Use this profile name in configs:

```text id="prof01"
mg996r_standard_servo_profile_v1
```

This profile consolidates the common MG996R mechanical drawings and TowerPro-style product dimensions.

### 3.1 Body and Flange Dimensions

| Parameter                        |              Value | Use                                                                |
| -------------------------------- | -----------------: | ------------------------------------------------------------------ |
| `body_length_mm`                 |               40.3 | Rectangular body/panel cutout length from common 2D drawings       |
| `body_length_alt_mm`             |               40.7 | TowerPro/datasheet body dimension                                  |
| `body_width_mm`                  |               20.0 | Mount pocket and panel cutout width                                |
| `body_width_alt_mm`              |               19.7 | TowerPro/datasheet body dimension                                  |
| `overall_flange_length_mm`       |               54.0 | Full length across mounting ears/tabs                              |
| `overall_flange_length_alt_mm`   |               53.6 | Common alternate drawing value                                     |
| `lower_body_to_tab_plane_mm`     |               26.6 | Bottom to mounting-ear/lower shoulder datum                        |
| `lower_body_to_tab_plane_alt_mm` |               26.8 | TowerPro product table value                                       |
| `body_top_height_mm`             |               36.6 | Body/case height datum from common drawing                         |
| `body_top_height_alt_mm`         |               37.0 | TowerPro product table value                                       |
| `overall_shaft_stack_height_mm`  |               47.6 | Overall height to top horn/shaft-stack reference in common drawing |
| `towerpro_spec_envelope_mm`      | 40.7 x 19.7 x 42.9 | Published TowerPro-style envelope                                  |

The two slightly different dimension sets reflect common MG996R drawing conventions. For CAD generation, use the normalized `54.0 / 40.3 / 20.0` mounting profile for holes, tabs, and cutouts.

Use the `40.7 x 19.7 x 42.9` published envelope when stating the datasheet size or when designing loose outer clearance.

### 3.2 Mounting Hole Pattern

The MG996R mounting ears use a four-hole pattern.

| Parameter                     | Value |
| ----------------------------- | ----: |
| `mount_hole_count`            |     4 |
| `mount_hole_diameter_mm`      |   4.0 |
| `mount_hole_x_pitch_mm`       |  50.0 |
| `mount_hole_y_pitch_mm`       |  10.0 |
| `mount_hole_x_from_center_mm` | ±25.0 |
| `mount_hole_y_from_center_mm` |  ±5.0 |

These are the servo tab holes/slots, not necessarily the hole size to use in the printed boss. The servo tab hole is large enough for typical M3 hardware with clearance, washers, rubber grommets, or molded slot geometry.

### 3.3 Shaft Offset

The output shaft is offset toward one end of the servo.

Use this standard coordinate fact:

```text id="shaftoffset01"
shaft_center_to_nearest_flange_end_mm = 16.0
```

Given a 54.0 mm overall flange length:

```text id="shaftoffset02"
overall_flange_half_length = 27.0
shaft_x_from_flange_center = 27.0 - 16.0 = 11.0 mm
```

Therefore, in the recommended flange-centered coordinate system:

```text id="shaftoffset03"
shaft_center = [ +11.0, 0.0 ]
```

The shaft is not at `[0, 0]` if the origin is the center of the mounting flange footprint.

## 4. Recommended Coordinate Systems

Use one of these two coordinate systems. Do not mix them.

## 4.1 Flange-Centered Coordinate System

This is preferred for designing servo holders, screw bosses, and panel cutouts.

* Origin: center of the overall 54.0 mm x 20.0 mm mounting footprint.
* X axis: along the servo length and mounting tabs.
* Y axis: across the 20.0 mm servo width.
* Z axis: vertical, bottom of main body upward.
* Shaft center: `[+11.0, 0.0]`.

In this coordinate system:

```json id="flangecoord01"
{
  "coordinate_system": "flange_centered",
  "overall_flange_length_mm": 54.0,
  "overall_flange_width_mm": 20.0,
  "body_length_mm": 40.3,
  "body_width_mm": 20.0,
  "shaft_center_xy_mm": [11.0, 0.0],
  "mounting_hole_positions_xy_mm": [
    [-25.0, -5.0],
    [-25.0,  5.0],
    [ 25.0, -5.0],
    [ 25.0,  5.0]
  ]
}
```

### 4.2 Shaft-Centered Coordinate System

This is preferred when coordinating the servo body mount with horn receivers, rotating arms, or swept moving parts.

Convert from flange-centered coordinates by subtracting `[11.0, 0.0]`.

In shaft-centered coordinates:

```json id="shaftcoord01"
{
  "coordinate_system": "shaft_centered",
  "shaft_center_xy_mm": [0.0, 0.0],
  "overall_flange_x_extent_mm": [-38.0, 16.0],
  "overall_flange_y_extent_mm": [-10.0, 10.0],
  "body_x_extent_mm": [-31.15, 9.15],
  "body_y_extent_mm": [-10.0, 10.0],
  "mounting_hole_positions_xy_mm": [
    [-36.0, -5.0],
    [-36.0,  5.0],
    [ 14.0, -5.0],
    [ 14.0,  5.0]
  ]
}
```

The shaft-centered system is often more useful for mechanism design because the moving geometry rotates around `[0, 0]`.

## 5. Mount Types

Use one of these mount strategies.

### 5.1 Through-Panel Tab Mount

The servo body passes through a rectangular cutout. The ears/tabs sit on a panel surface and are fastened by four screws.

Use this for flat plates, robot panels, and actuator brackets.

Required features:

* Rectangular body cutout.
* Four screw holes or bosses.
* Shaft-side keepout.
* Wire-side exit clearance.
* Horn sweep keepout above the shaft side.

### 5.2 Drop-In Cradle with Tab Screws

The servo body drops into a shallow printed cradle. The mounting tabs land on shelves or pads. Four screws fasten the servo through the tabs.

Use this for most printed brackets.

Required features:

* Body pocket.
* Tab support ledges.
* Four screw bosses.
* Cable exit notch.
* Shaft keepout.
* Horn sweep clearance.

### 5.3 Split Clamp or Captive Cage

A printed cage or two-part clamp surrounds the servo body, usually with a removable cap or strap.

Use this only when the tabs cannot be used normally or when the servo must be trapped in a cartridge.

Required features:

* Body clearance pocket.
* Removable retaining feature.
* Mounting-tab relief, even if tabs are not used.
* Cable channel.
* Shaft and horn sweep keepout.
* Center screw access.

## 6. Body Cutout and Pocket Dimensions

For an MG996R through-panel body cutout, use:

```json id="bodycutout01"
{
  "body_cutout_nominal_mm": [40.3, 20.0],
  "body_cutout_fdm_serviceable_mm": [41.1, 20.8],
  "body_cutout_fdm_loose_mm": [41.5, 21.2]
}
```

The nominal body drawing is `40.3 x 20.0 mm`.

For FDM printed parts, the serviceable cutout adds about 0.4 mm per side:

```text id="bodycutout02"
body_cutout_fdm_serviceable =
  [40.3 + 0.8, 20.0 + 0.8] =
  [41.1, 20.8]
```

This is a manufacturing clearance, not a servo standard. The standard mechanical profile remains `40.3 x 20.0 mm`.

For a drop-in cradle, use the same XY clearance, but do not make the pocket a tight full-depth negative of the servo. The case has seams and ribs; use a simple rectangular pocket.

Recommended cradle inside dimensions:

```json id="cradle01"
{
  "cradle_inside_length_mm": 41.1,
  "cradle_inside_width_mm": 20.8,
  "cradle_depth_mm": 26.6
}
```

Use `26.6 mm` as the lower-body-to-tab-plane height if the cradle captures the lower body up to the tab/ear plane.

## 7. Mounting Ear / Tab Geometry

The overall flange footprint is:

```json id="flange01"
{
  "flange_nominal_length_mm": 54.0,
  "flange_nominal_width_mm": 20.0
}
```

The body footprint is:

```json id="flange02"
{
  "body_nominal_length_mm": 40.3,
  "body_nominal_width_mm": 20.0
}
```

Therefore, each tab extension beyond the main body is approximately:

```text id="tabextension01"
(54.0 - 40.3) / 2 = 6.85 mm
```

Use these tab zones in flange-centered coordinates:

```json id="tabzones01"
{
  "left_tab_x_extent_mm": [-27.0, -20.15],
  "right_tab_x_extent_mm": [20.15, 27.0],
  "tab_y_extent_mm": [-10.0, 10.0]
}
```

These tab zones should be supported by printed shelves, pads, or bosses.

## 8. Mounting Hole Coordinates

In flange-centered coordinates, use:

```json id="holesflange01"
{
  "hole_diameter_in_servo_tab_mm": 4.0,
  "hole_positions_xy_mm": [
    [-25.0, -5.0],
    [-25.0,  5.0],
    [ 25.0, -5.0],
    [ 25.0,  5.0]
  ]
}
```

In shaft-centered coordinates, use:

```json id="holesshaft01"
{
  "hole_diameter_in_servo_tab_mm": 4.0,
  "hole_positions_xy_mm": [
    [-36.0, -5.0],
    [-36.0,  5.0],
    [ 14.0, -5.0],
    [ 14.0,  5.0]
  ]
}
```

The agent should not invent placeholder screw positions. Use these.

## 9. Printed Screw Bosses for the Servo Mount

The servo tab holes are approximately Ø4.0 mm. The printed structure below them should be designed around the chosen fastener.

Default fastener for this profile:

```json id="fastener01"
{
  "default_fastener": "M3",
  "example_supplied_bolt": "M3x12",
  "servo_tab_hole_diameter_mm": 4.0
}
```

### 9.1 M3 Through-Bolt Pattern

Use this when the screw passes through the servo tab and printed bracket into a nut or threaded insert.

Recommended printed clearances:

```json id="m3through01"
{
  "screw": "M3",
  "printed_clearance_hole_mm": 3.3,
  "servo_tab_clearance_hole_mm": 4.0,
  "washer_recommended": true,
  "boss_outer_diameter_mm": 8.0,
  "preferred_boss_outer_diameter_mm": 9.0,
  "minimum_boss_wall_around_clearance_mm": 2.3
}
```

Rationale:

```text id="m3through02"
9.0 mm boss OD - 3.3 mm hole = 5.7 mm total wall
5.7 / 2 = 2.85 mm wall per side
```

This is a good default FDM screw boss.

### 9.2 M3 Heat-Set Insert Pattern

Use this when the servo is serviceable and the screws may be removed repeatedly.

```json id="m3insert01"
{
  "screw": "M3",
  "servo_tab_hole_diameter_mm": 4.0,
  "printed_insert_boss_outer_diameter_mm": 9.0,
  "printed_insert_hole_diameter_mm": "use insert datasheet; commonly 4.0-4.6 mm for M3 heat-set inserts",
  "minimum_boss_height_mm": "insert_length + 1.0"
}
```

The insert hole is not standardized by the servo. It is defined by the insert manufacturer.

### 9.3 M3 Nut Trap Pattern

Use this when inserts are unavailable and the mount must be serviceable.

For a normal M3 hex nut:

```json id="m3nuttrap01"
{
  "screw": "M3",
  "nut_trap_across_flats_mm": 5.8,
  "nut_trap_depth_mm": 2.6,
  "nut_trap_clearance_mm": 0.2,
  "boss_outer_diameter_mm": 10.0
}
```

Use a side-loading or bottom-loading nut trap depending on print orientation.

## 10. Servo Tab Screw Mount Structure

Each of the four mounting holes should have a printed boss or a reinforced pad below it.

Minimum structure:

```json id="bosslayout01"
{
  "boss_centers_flange_coordinates_mm": [
    [-25.0, -5.0],
    [-25.0,  5.0],
    [ 25.0, -5.0],
    [ 25.0,  5.0]
  ],
  "boss_outer_diameter_mm": 9.0,
  "boss_hole_diameter_mm": 3.3,
  "boss_height_mm": 6.0
}
```

For high-load servo mounts:

```json id="bosslayout02"
{
  "boss_outer_diameter_mm": 10.0,
  "boss_height_mm": 8.0,
  "rib_to_body_wall": true,
  "rib_thickness_mm": 3.0,
  "tab_support_pad_thickness_mm": 3.0
}
```

Do not mount the servo tabs to thin unsupported printed ears. The four screw bosses should connect to the main bracket body with walls or ribs.

## 11. Shaft Keepout

The shaft center is:

```json id="shaftkeepout01"
{
  "shaft_center_flange_coordinates_mm": [11.0, 0.0],
  "shaft_center_shaft_coordinates_mm": [0.0, 0.0]
}
```

At minimum, the fixed mount must not place material in the shaft/horn region.

Use this default keepout:

```json id="shaftkeepout02"
{
  "shaft_keepout_diameter_mm": 16.0,
  "preferred_shaft_keepout_diameter_mm": 20.0,
  "shaft_keepout_z_start_mm": 36.6,
  "shaft_keepout_z_end_mm": 60.0
}
```

The keepout starts at the top body/case height datum and extends above the horn/shaft stack.

If the servo horn or driven part is larger, the horn sweep keepout overrides this value.

## 12. Horn and Driven-Part Sweep Keepout

The fixed mount must leave room for the horn and the part attached to the horn.

Use the servo horn receiver document for exact horn geometry. For the fixed servo mount, reserve a conservative swept cylindrical volume unless the design has a specific angular sweep.

Default full-sweep keepout:

```json id="sweep01"
{
  "sweep_center": "shaft_center",
  "default_horn_sweep_radius_mm": 22.0,
  "default_horn_sweep_height_mm": 10.0,
  "sweep_z_start_mm": 36.6,
  "sweep_type": "full_cylinder"
}
```

For a standard cross/star horn near the MG996R, a `22 mm` radius clears a 40 mm tip-to-tip horn plus 2 mm radial clearance.

If the attached part is larger than the horn, compute:

```text id="sweep02"
sweep_radius = max(horn_tip_radius, attached_part_max_radius) + clearance
```

Use at least `1.5 mm` radial clearance for printed mechanisms.

## 13. Center Screw Access

The center screw retaining the horn is aligned with the shaft center.

The fixed mount should not block screwdriver access unless the design intentionally uses a removable cover.

Default access cylinder:

```json id="centerscrew01"
{
  "center_screw_access_center": "shaft_center",
  "center_screw_access_diameter_mm": 7.0,
  "center_screw_access_z_start_mm": 36.6,
  "center_screw_access_z_end_mm": 80.0
}
```

This is not the screw hole in the horn. It is a tool-access void.

## 14. Wire and Connector Clearance

The MG996R uses a three-wire servo lead. TowerPro-style descriptions list a JR/Futaba-compatible servo plug and about 30–32 cm wire length.

For the fixed mount, the important thing is the wire exit path.

Use this default cable relief unless the design is open on the wire side:

```json id="wire01"
{
  "wire_relief_enabled": true,
  "wire_slot_width_mm": 8.0,
  "wire_slot_height_mm": 5.0,
  "wire_slot_depth_mm": 12.0,
  "wire_exit_side": "rear_or_side_opposite_mechanism"
}
```

The slot is intentionally larger than the cable because the cable exits through molded strain relief and must not be pinched.

If the servo sits in a closed cradle, the wire relief is mandatory.

## 15. Recommended JSON Config Block

Every MG996R servo body mount should include this config block or a design-specific subset of it.

```json id="config01"
{
  "servo_mount": {
    "enabled": true,
    "profile": "mg996r_standard_servo_profile_v1",
    "servo_model": "MG996R-compatible standard servo",

    "coordinate_system": "flange_centered",
    "units": "mm",

    "body_length_mm": 40.3,
    "body_width_mm": 20.0,
    "body_height_to_top_case_mm": 36.6,
    "body_height_to_tab_plane_mm": 26.6,

    "overall_flange_length_mm": 54.0,
    "overall_flange_width_mm": 20.0,
    "tab_extension_each_end_mm": 6.85,

    "shaft_center_xy_mm": [11.0, 0.0],
    "shaft_center_to_nearest_flange_end_mm": 16.0,

    "mounting_hole_diameter_in_servo_tab_mm": 4.0,
    "mounting_hole_x_pitch_mm": 50.0,
    "mounting_hole_y_pitch_mm": 10.0,
    "mounting_hole_positions_xy_mm": [
      [-25.0, -5.0],
      [-25.0,  5.0],
      [ 25.0, -5.0],
      [ 25.0,  5.0]
    ],

    "body_cutout_clearance_per_side_mm": 0.4,
    "body_cutout_size_mm": [41.1, 20.8],

    "fastener_default": "M3",
    "printed_mount_hole_diameter_mm": 3.3,
    "servo_tab_hole_diameter_mm": 4.0,
    "boss_outer_diameter_mm": 9.0,
    "boss_height_mm": 6.0,

    "shaft_keepout_diameter_mm": 20.0,
    "shaft_keepout_z_start_mm": 36.6,
    "shaft_keepout_z_end_mm": 60.0,

    "horn_sweep_radius_mm": 22.0,
    "horn_sweep_height_mm": 10.0,
    "horn_sweep_z_start_mm": 36.6,

    "center_screw_access_diameter_mm": 7.0,

    "wire_relief_enabled": true,
    "wire_slot_width_mm": 8.0,
    "wire_slot_height_mm": 5.0,
    "wire_slot_depth_mm": 12.0
  }
}
```

## 16. OpenSCAD Reference Modules

### 16.1 Shared Parameters

```scad id="scadparams01"
mg996r_body_l = 40.3;
mg996r_body_w = 20.0;
mg996r_flange_l = 54.0;
mg996r_flange_w = 20.0;

mg996r_hole_x_pitch = 50.0;
mg996r_hole_y_pitch = 10.0;
mg996r_tab_hole_d = 4.0;

mg996r_shaft_x = 11.0;
mg996r_shaft_y = 0.0;

mg996r_body_top_z = 36.6;
mg996r_tab_plane_z = 26.6;

eps = 0.02;
```

### 16.2 Mounting Hole Positions

```scad id="scadholes01"
function mg996r_mount_holes_flange_centered() = [
    [-25.0, -5.0],
    [-25.0,  5.0],
    [ 25.0, -5.0],
    [ 25.0,  5.0]
];

function mg996r_mount_holes_shaft_centered() = [
    [-36.0, -5.0],
    [-36.0,  5.0],
    [ 14.0, -5.0],
    [ 14.0,  5.0]
];
```

### 16.3 Body Cutout Void

For through-panel or cradle designs:

```scad id="scadbodyvoid01"
module mg996r_body_cutout_void(
    clearance = 0.4,
    height = 80
) {
    translate([
        -mg996r_body_l / 2 - clearance,
        -mg996r_body_w / 2 - clearance,
        -eps
    ])
    cube([
        mg996r_body_l + 2 * clearance,
        mg996r_body_w + 2 * clearance,
        height + 2 * eps
    ], center = false);
}
```

This module assumes flange-centered XY coordinates.

### 16.4 Servo Tab Support Pads

```scad id="scadtabsupport01"
module mg996r_tab_support_pads(
    pad_z = 0,
    pad_thickness = 3.0,
    pad_extra_y = 2.0
) {
    tab_extension = (mg996r_flange_l - mg996r_body_l) / 2;

    for (sx = [-1, 1]) {
        translate([
            sx * (mg996r_body_l / 2 + tab_extension / 2),
            -(mg996r_flange_w + pad_extra_y) / 2,
            pad_z - pad_thickness
        ])
        cube([
            tab_extension,
            mg996r_flange_w + pad_extra_y,
            pad_thickness
        ], center = false);
    }
}
```

### 16.5 Servo Mount Screw Bosses

```scad id="scadboss01"
module screw_boss(
    boss_od = 9.0,
    boss_h = 6.0,
    hole_d = 3.3,
    z_base = -6.0
) {
    difference() {
        translate([0, 0, z_base])
            cylinder(d = boss_od, h = boss_h, center = false, $fn = 48);

        translate([0, 0, z_base - eps])
            cylinder(d = hole_d, h = boss_h + 2 * eps, center = false, $fn = 32);
    }
}

module mg996r_mount_screw_bosses(
    boss_od = 9.0,
    boss_h = 6.0,
    hole_d = 3.3,
    z_base = -6.0
) {
    for (p = mg996r_mount_holes_flange_centered()) {
        translate([p[0], p[1], 0])
            screw_boss(
                boss_od = boss_od,
                boss_h = boss_h,
                hole_d = hole_d,
                z_base = z_base
            );
    }
}
```

### 16.6 Servo Tab Hole Clearance Voids

Use this when modeling a top plate or a through-hole mount:

```scad id="scadtabholevoid01"
module mg996r_tab_hole_clearance_voids(
    d = 4.2,
    h = 20
) {
    for (p = mg996r_mount_holes_flange_centered()) {
        translate([p[0], p[1], -h / 2])
            cylinder(d = d, h = h, center = false, $fn = 32);
    }
}
```

Use `4.2 mm` if the printed part itself must clear the same screw path as the servo tab. Use `3.3 mm` if the printed part receives an M3 through-bolt below the tab.

### 16.7 Shaft Keepout Void

```scad id="scadshaftvoid01"
module mg996r_shaft_keepout_void(
    d = 20.0,
    z_start = mg996r_body_top_z,
    z_end = 60.0
) {
    translate([mg996r_shaft_x, mg996r_shaft_y, z_start - eps])
        cylinder(d = d, h = z_end - z_start + 2 * eps, center = false, $fn = 96);
}
```

### 16.8 Horn Sweep Keepout Void

```scad id="scadsweepvoid01"
module mg996r_horn_sweep_keepout_void(
    r = 22.0,
    h = 10.0,
    z_start = mg996r_body_top_z
) {
    translate([mg996r_shaft_x, mg996r_shaft_y, z_start - eps])
        cylinder(r = r, h = h + 2 * eps, center = false, $fn = 128);
}
```

### 16.9 Center Screw Access Void

```scad id="scadcentervoid01"
module mg996r_center_screw_access_void(
    d = 7.0,
    z_start = mg996r_body_top_z,
    z_end = 90.0
) {
    translate([mg996r_shaft_x, mg996r_shaft_y, z_start - eps])
        cylinder(d = d, h = z_end - z_start + 2 * eps, center = false, $fn = 64);
}
```

### 16.10 Wire Relief Void

```scad id="scadwirevoid01"
module mg996r_wire_relief_void(
    slot_w = 8.0,
    slot_h = 5.0,
    slot_depth = 12.0,
    side = "negative_x"
) {
    if (side == "negative_x") {
        translate([
            -mg996r_body_l / 2 - slot_depth,
            -slot_w / 2,
            3.0
        ])
        cube([slot_depth + eps, slot_w, slot_h], center = false);
    }

    if (side == "positive_x") {
        translate([
            mg996r_body_l / 2,
            -slot_w / 2,
            3.0
        ])
        cube([slot_depth + eps, slot_w, slot_h], center = false);
    }
}
```

The wire side depends on the servo orientation in the mechanism. The geometry should always include a cable exit, but the side should be controlled by config.

## 17. Complete Through-Panel Mount Pattern

A through-panel mount should be based on this subtractive pattern:

```scad id="scadpanel01"
difference() {
    panel_or_bracket();

    // Body passes through panel.
    mg996r_body_cutout_void(clearance = 0.4, height = 80);

    // Four screw holes at actual MG996R mounting pattern.
    mg996r_tab_hole_clearance_voids(d = 3.3, h = 30);

    // Output side must remain open.
    mg996r_shaft_keepout_void(d = 20.0);
    mg996r_horn_sweep_keepout_void(r = 22.0, h = 10.0);
    mg996r_center_screw_access_void(d = 7.0);

    // Cable exit.
    mg996r_wire_relief_void(side = "negative_x");
}
```

Use positive boss geometry under or around the four tab holes:

```scad id="scadpanel02"
union() {
    panel_or_bracket_base();
    mg996r_mount_screw_bosses(
        boss_od = 9.0,
        boss_h = 6.0,
        hole_d = 3.3,
        z_base = -6.0
    );
}
```

## 18. Complete Drop-In Cradle Pattern

A drop-in cradle should include:

* Lower body pocket: `41.1 x 20.8 mm`.
* Cradle depth: about `26.6 mm` if supporting up to the tab plane.
* Tab support pads under both ears.
* Four screw bosses at `[±25, ±5]`.
* Shaft keepout centered at `[11, 0]`.
* Wire relief.

The agent should not center the shaft in the cradle. The shaft is offset.

## 19. Design Rules for Agents

When designing an MG996R servo holder:

1. Use `mg996r_standard_servo_profile_v1`.
2. Use a 54.0 mm x 20.0 mm flange footprint.
3. Use a 40.3 mm x 20.0 mm body cutout.
4. Use four mounting holes at `[±25, ±5]` in flange-centered coordinates.
5. Use Ø4.0 mm for the servo tab hole/slot model.
6. Use M3 as the default printed fastener system.
7. Use 3.3 mm printed clearance holes for M3 through-bolts.
8. Use 9.0 mm OD screw bosses as the default FDM boss.
9. Place the shaft center at `[+11, 0]` in flange-centered coordinates.
10. In shaft-centered coordinates, place the mounting holes at `[-36, ±5]` and `[+14, ±5]`.
11. Leave a shaft keepout cylinder centered on the shaft.
12. Leave a horn sweep keepout above the shaft side.
13. Leave center screw access above the shaft.
14. Leave wire relief on the configured cable-exit side.
15. Do not ask the user to measure basic MG996R mount geometry.
16. Only ask for clarification if the servo is not MG996R-compatible or if the user has selected a nonstandard servo.

## 20. Acceptance Checklist

A generated MG996R servo body mount is acceptable only if:

* It uses a named MG996R profile.
* The shaft is offset correctly.
* The mounting holes are at the real four-hole pattern.
* The printed screw bosses line up with the servo tab holes.
* The body cutout is at least `40.3 x 20.0 mm` plus manufacturing clearance.
* The tab support zones exist under the ears.
* The shaft keepout does not collide with the servo output.
* The horn sweep keepout is modeled.
* The center screw remains accessible.
* The wire has a modeled exit path.
* The design uses M3-compatible screw features unless a different fastener is explicitly selected.
* Renders show the body cutout, four screw mounts, shaft keepout, horn sweep, and wire relief.

## 21. Short Rule Summary

* MG996R flange: `54 x 20 mm`.
* Body cutout: `40.3 x 20 mm` plus print clearance.
* Mounting holes: four holes, `50 x 10 mm` pitch.
* Servo tab holes: `Ø4 mm`.
* Default mount screws: M3.
* Printed M3 clearance: `Ø3.3 mm`.
* Default boss OD: `9 mm`.
* Shaft center: `+11 mm` from flange center.
* Shaft center: `16 mm` from nearest flange end.
* Shaft-centered screw holes: `[-36, ±5]` and `[+14, ±5]`.
* Do not center the shaft in the body.
* Do not block the horn sweep.
* Do not block center screw access.
* Do not crush the wire.
