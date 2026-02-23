include <../lib/util.scad>;

// A first-pass clamp-based mount that can be iterated quickly.
// This is intentionally simple: a split clamp around the metal post/tube with
// a pass-through cable hole and a flat platform for future feed geometry.

module feed_mount() {
  clamp_id = post_od + post_clearance;
  clamp_od = clamp_id + 2 * clamp_wall;

  platform_d = clamp_od + 16;
  platform_t = 6;

  difference() {
    union() {
      // Clamp body
      cylinder(d = clamp_od, h = clamp_height, $fn = 128);

      // Platform on top for future feed mounting
      translate([0, 0, clamp_height]) cylinder(d = platform_d, h = platform_t, $fn = 128);

      // Two screw bosses across the slit
      translate([clamp_od / 2 - clamp_boss_d / 2, 0, clamp_height / 2])
        rotate([0, 90, 0]) centered_cylinder(clamp_boss_d, clamp_wall + 8);
      translate([-(clamp_od / 2 - clamp_boss_d / 2), 0, clamp_height / 2])
        rotate([0, 90, 0]) centered_cylinder(clamp_boss_d, clamp_wall + 8);
    }

    // Inner bore for the metal post/tube
    translate([0, 0, -1]) cylinder(d = clamp_id, h = clamp_height + platform_t + 2, $fn = 128);

    // Split slit
    translate([0, -clamp_gap / 2, -1])
      cube([clamp_od + 2, clamp_gap, clamp_height + platform_t + 2], center = true);

    // Through screw hole
    translate([-platform_d / 2, 0, clamp_height / 2])
      rotate([0, 90, 0]) bolt_hole_through(clamp_screw_d, platform_d);

    // Screw head pocket (one side)
    translate([platform_d / 2 - clamp_screw_head_h, 0, clamp_height / 2])
      rotate([0, 90, 0]) cylinder(d = clamp_screw_head_d, h = clamp_screw_head_h + 1, $fn = 48);

    // Cable pass-through (down into the post/tube)
    translate([0, 0, -1]) cylinder(d = cable_hole_d, h = clamp_height + platform_t + 2, $fn = 64);
  }
}

