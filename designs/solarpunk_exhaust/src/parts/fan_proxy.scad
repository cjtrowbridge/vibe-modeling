// Fan proxy — reference mockup (part_id 2, NOT printable).
//
// Block-level stand-in for a commodity 120 mm fan: a 120 x 120 x 25 mm box
// with the 105 mm M4-class Ø4.3 station bore cross, a Ø110 intake notch on
// the intake face, and — new in V4 — a full-depth Ø116 through-hole at the
// fan center, the same Ø116 as the plate's airflow opening (the airflow
// pass path: greenhouse interior -> intake -> blades -> opening -> screen
// -> outside). Exported by the build pipeline for preview / artifact review
// only (intelligence-hub part-2 precedent: reference geometry, never a
// print target). It sits on the plate front face (+Z) at the fan station:
// the 4 bores align 1:1 with the plate's 4 station bores through the 4
// collars, and the intake face (local -Z) rides on the plate, facing the
// greenhouse interior where the user-supplied hose connects (out of scope).
//
// Placement contract: fan_proxy(91) IS the assembly transform for fan_proxy
// (assembly.json: member part_id 2 inside exhaust_mount_assembly,
// translate([fan_cx(), fan_cy(), fan_z()])); the raw box is fan_proxy_box().
//
// All dimensions come from lib/defaults.scad; no size-derived constants are
// hardcoded.

// Reference mockup: fan_proxy(91) is a fan box block anchored to the plate
// front face at the fan station transform from assembly.json (member
// part_id 2: translate([fan_cx(), fan_cy(), fan_z()])). Locked V4 blockout
// anchor (placeholder fan values): the assembled plate stays 134 x 141 at
// rev_0001; re-anchor at the first revision with measured dimensions.
assert(plate_w() == 134.0 && plate_h() == 141.0,
       str("plate envelope (", plate_w(), "x", plate_h(),
           ") drifted from the locked 134x141 blockout V4"));
// The station collar relief must fit inside the fan box on both axes
// (containment, not a minimum-width claim): 2 x (52.5 + 5.15) = 115.3
// <= 120.
assert(2 * (station_offset() + standoff_od / 2) <= fan_size + boolean_epsilon,
       str("fan station collar relief (Ø",
           2 * (station_offset() + standoff_od / 2),
           " mm) exceeds the fan box (Ø", fan_size, ")"));

// The 120 mm fan box, local origin (0, 0) at the fan-box bottom-left corner,
// z = 0 at the plate front face. Intake face = -Z (rides on the plate);
// the exhaust face (disc) faces the greenhouse ventilation screen / outside.
module fan_proxy_box() {
    difference() {
        color("skyblue", [0.5, 0.7, 1.0, 0.7])
            cube([fan_size, fan_size, fan_depth]);
        // Full-depth Ø116 airflow through-hole at the fan center, 1:1 with
        // the plate's airflow opening (V4: airflow passes all the way
        // through the assembled proxy + plate pair).
        translate([fan_size / 2, fan_size / 2, -boolean_epsilon])
            cylinder(h = fan_depth + 2 * boolean_epsilon,
                     d = fan_opening_d, $fn = 96);
        // Station bores: 105 mm square, Ø4.3 M4-class (placeholder pending
        // the actual fan hardware), 1:1 with the plate's 4 bores through
        // the 4 collars.
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([fan_size / 2 + sx * station_offset(),
                           fan_size / 2 + sy * station_offset(), -boolean_epsilon])
                    cylinder(h = fan_depth + 2 * boolean_epsilon,
                             d = fan_bore_d, $fn = 32);
        // Ø110 intake notch on the intake (+Z) face: shows where the frame
        // clearance is (the hose connects here, out of scope).
        translate([fan_size / 2, fan_size / 2, fan_depth - fan_intake_notch_depth])
            cylinder(h = fan_intake_notch_depth + 2 * boolean_epsilon,
                     d = fan_intake_d, $fn = 64);
    }
}

// Positioned proxy at the fan station on the plate front face
// (translate([fan_cx(), fan_cy(), fan_z()])), matching the assembly.json
// member transform.
module fan_proxy() {
    translate([fan_cx(), fan_cy(), fan_z()])
        fan_proxy_box();
}