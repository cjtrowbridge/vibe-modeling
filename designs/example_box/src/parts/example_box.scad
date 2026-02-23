include <../lib/util.scad>;

// Generic starter part: a simple printable tray/box for pipeline verification.
module example_box() {
  assert(box_x > 0, "box_x must be > 0");
  assert(box_y > 0, "box_y must be > 0");
  assert(box_z > 0, "box_z must be > 0");
  assert(wall >= 0, "wall must be >= 0");
  assert(floor_thickness >= 0, "floor_thickness must be >= 0");
  assert(wall * 2 < box_x, "wall too thick for box_x");
  assert(wall * 2 < box_y, "wall too thick for box_y");
  assert(floor_thickness < box_z, "floor_thickness must be < box_z");

  difference() {
    // Outer body
    translate([-box_x / 2, -box_y / 2, 0]) cube([box_x, box_y, box_z], center = false);

    // Hollow interior (top-open tray)
    translate([-(box_x - 2 * wall) / 2, -(box_y - 2 * wall) / 2, floor_thickness])
      cube([box_x - 2 * wall, box_y - 2 * wall, box_z - floor_thickness + 0.01], center = false);

    // Optional centered through-hole for fixture experiments.
    if (center_hole_d > 0)
      translate([0, 0, -0.5]) cylinder(d = center_hole_d, h = box_z + 1, $fn = 64);
  }
}
