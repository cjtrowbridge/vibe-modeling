include <../lib/util.scad>;

// Mechanical proof-of-concept for a DirecTV-style replacement arm insert.
//
// Geometry:
// - Insert body: 45mm x 19mm x 15mm with beveled cross-section corners.
// - Outside pad: 50mm x 26mm x 3mm.
// - Screw hole: centered, vertical, 6mm diameter through insert section.
//
// Coordinate convention for this part:
// - Tube face is at z=0.
// - Insert extends into the tube toward negative z.
// - Outside pad extends toward positive z.

module beveled_rect_prism(w, h, d, b) {
  wb = w / 2;
  hb = h / 2;
  bb = min(b, min(w, h) / 2 - 0.01);

  linear_extrude(height = d, center = false)
    polygon(points = [
      [-wb + bb, -hb],
      [ wb - bb, -hb],
      [ wb, -hb + bb],
      [ wb,  hb - bb],
      [ wb - bb,  hb],
      [-wb + bb,  hb],
      [-wb,  hb - bb],
      [-wb, -hb + bb]
    ]);
}

module dtv_yagi_insert_poc() {
  assert(insert_width > 0, "insert_width must be > 0");
  assert(insert_height > 0, "insert_height must be > 0");
  assert(insert_depth > 0, "insert_depth must be > 0");
  assert(outer_width > 0, "outer_width must be > 0");
  assert(outer_height > 0, "outer_height must be > 0");
  assert(outer_thickness > 0, "outer_thickness must be > 0");
  assert(screw_hole_d > 0, "screw_hole_d must be > 0");
  assert(insert_corner_bevel >= 0, "insert_corner_bevel must be >= 0");
  assert(insert_corner_bevel < min(insert_width, insert_height) / 2,
    "insert_corner_bevel must be less than half of insert width/height");

  difference() {
    union() {
      // Insert segment that slides into the tube.
      translate([0, 0, -insert_depth])
        beveled_rect_prism(insert_width, insert_height, insert_depth, insert_corner_bevel);

      // Outside pad for future arm/card integration.
      translate([-outer_width / 2, -outer_height / 2, 0])
        cube([outer_width, outer_height, outer_thickness], center = false);
    }

    // Centered vertical mounting hole through the insert segment.
    translate([0, 0, -insert_depth / 2])
      rotate([90, 0, 0])
      centered_cylinder(screw_hole_d, max(insert_height, outer_height) + 2);
  }
}
