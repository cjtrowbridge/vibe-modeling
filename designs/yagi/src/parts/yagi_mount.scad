include <../lib/util.scad>;

// 3-element yagi mount (printable backplane + mount stub).
//
// Coordinate convention:
//   z=0 is the focus datum (original plastic tube tip).
//   Mount seat plane is at z=-mount_seat_to_focus.
//
// Element placement (along +z):
//   director (front):   z = -element_spacing
//   driven (dipole):    z = 0
//   reflector (rear):   z = +element_spacing
//
// Elements are solid copper wire/rod; this part provides grooves only.
// The driven element groove includes a center cutout (dipole_gap) to help keep
// the two halves separated at the feedpoint and to provide clearance for a pigtail exit.

module yagi_mount() {
  seat_z = -mount_seat_to_focus;
  stub_top_z = seat_z + mount_stub_len;

  director_z = -element_spacing;
  driven_z = 0;
  reflector_z = element_spacing;

  groove_center_y = card_thickness / 2 - groove_depth / 2;

  director_groove_len = director_len + 2 * element_end_margin;
  driven_groove_len = driven_len + 2 * element_end_margin;
  reflector_groove_len = reflector_len + 2 * element_end_margin;

  assert(groove_depth > 0, "groove_depth must be > 0");
  assert(groove_depth < card_thickness, "groove_depth must be < card_thickness to preserve a back wall");
  assert(card_size_x > 0, "card_size_x must be > 0");
  assert(card_size > 0, "card_size must be > 0");
  assert(director_groove_len > 0, "Computed director_groove_len must be > 0");
  assert(driven_groove_len > 0, "Computed driven_groove_len must be > 0");
  assert(reflector_groove_len > 0, "Computed reflector_groove_len must be > 0");
  assert(director_groove_len <= card_size_x, "Director groove length must be <= card_size_x");
  assert(driven_groove_len <= card_size_x, "Driven groove length must be <= card_size_x");
  assert(reflector_groove_len <= card_size_x, "Reflector groove length must be <= card_size_x");
  assert(director_z - groove_w / 2 >= stub_top_z, "Card is too short (Z) to contain the director groove");
  assert(reflector_z + groove_w / 2 <= stub_top_z + card_size, "Card is too short (Z) to contain the reflector groove");

  difference() {
    union() {
      // Short 33mm OD stub near the mount seat plane.
      translate([0, 0, seat_z]) cylinder(d = mount_stub_od, h = mount_stub_len, $fn = 128);

      // Backplane/boom starting at the top of the stub.
      translate([-card_size_x / 2, -card_thickness / 2, stub_top_z])
        cube([card_size_x, card_thickness, card_size], center = false);
    }

    // Cable/pigtail path down into the metal shaft (axial).
    translate([0, 0, seat_z - 1])
      cylinder(d = cable_hole_d, h = mount_seat_to_focus + 2, $fn = 96);

    // Grooves for elements (cut from the top face).
    for (g = [
      [director_z, director_groove_len],
      [driven_z, driven_groove_len],
      [reflector_z, reflector_groove_len]
    ]) {
      translate([0, groove_center_y, g[0]])
        cube([g[1], groove_depth, groove_w], center = true);
    }

    // Driven element center cutout: makes space for coax exit and dipole separation.
    translate([0, groove_center_y, driven_z])
      cube([dipole_gap, groove_depth, groove_w + 2], center = true);
  }
}
