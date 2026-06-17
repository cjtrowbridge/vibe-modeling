// OpenSCAD alignment/boolean helper for the Gigachad head + Xavier void cutter.
//
// How to use:
// 1) Open this file in OpenSCAD and press F5 (preview).
// 2) Leave mode_boolean_result = true while positioning.
// 3) Adjust head_translate/head_rotate and head_ground_z until the head sits on the plate.
// 4) Adjust cutter_translate/cutter_rotate until it is where you want inside the head.
// 5) Set mode_boolean_result = true and render (F6), then export STL.

// -------------------------
// Scene toggles
// -------------------------
mode_boolean_result = true; // false = alignment preview, true = difference(head - cutter)
show_plate = false;
show_axes = false;

// -------------------------
// Build plate visual (for alignment only)
// -------------------------
plate_x = 256;
plate_y = 256;
plate_thickness = 1;

// -------------------------
// Imported files (relative to this .scad file)
// -------------------------
head_file = "gigachad_voxel_2p0.stl";
cutter_file = "gigachad_xavier_simple_void.stl";

// -------------------------
// Head transform controls
// -------------------------
// head_ground_z: amount to lower the imported head so its lowest point lands on Z=0.
// If the model is "floating", increase this value.
head_translate = [0, 0, 0]; // XY centering / final placement on plate
head_rotate = [0, 0, 0];    // rotate head if needed
head_scale = [1, 1, 1];     // keep 1,1,1 unless your import units are wrong
head_ground_z = 0;          // tune this until the model sits on the plate

// -------------------------
// Cutter transform controls
// -------------------------
// Start with the cutter centered at the origin; move it into the head from there.
cutter_translate = [0, -30, 40];
cutter_rotate = [0, 0, 0];

// -------------------------
// Helpers
// -------------------------
module build_plate() {
  if (show_plate) {
    color([0.85, 0.88, 0.92, 0.35])
      translate([-plate_x / 2, -plate_y / 2, -plate_thickness])
        cube([plate_x, plate_y, plate_thickness], center = false);
  }
}

module axes(len = 80, d = 1.5) {
  if (show_axes) {
    color("red")   rotate([0, 90, 0]) cylinder(h = len, d = d, center = false, $fn = 24);   // +X
    color("green") rotate([-90, 0, 0]) cylinder(h = len, d = d, center = false, $fn = 24);  // +Y
    color("blue")  cylinder(h = len, d = d, center = false, $fn = 24);                        // +Z
  }
}

module head_mesh_raw() {
  import(head_file, convexity = 10);
}

module cutter_mesh_raw() {
  import(cutter_file, convexity = 10);
}

module head_mesh_positioned() {
  translate(head_translate)
    rotate(head_rotate)
      scale(head_scale)
        translate([0, 0, -head_ground_z])
          head_mesh_raw();
}

module cutter_mesh_positioned() {
  translate(cutter_translate)
    rotate(cutter_rotate)
      cutter_mesh_raw();
}

module boolean_result() {
  difference() {
    head_mesh_positioned();
    cutter_mesh_positioned();
  }
}

// -------------------------
// Scene output
// -------------------------
build_plate();
axes();

if (mode_boolean_result) {
  color("gainsboro") boolean_result();
} else {
  color([0.75, 0.75, 0.78, 0.65]) head_mesh_positioned();
  color([1.00, 0.35, 0.10, 0.55]) cutter_mesh_positioned();
}

