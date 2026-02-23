include <../lib/util.scad>;

// 3-element yagi element card (backplane/boom only; no mount stub).
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

module yagi_card() {
  card_bottom_z = -mount_seat_to_focus + card_bottom_from_seat;

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
  assert(director_z - groove_w / 2 >= card_bottom_z, "Card is too short (Z) to contain the director groove");
  assert(reflector_z + groove_w / 2 <= card_bottom_z + card_size, "Card is too short (Z) to contain the reflector groove");

  difference() {
    // Backplane/boom.
    translate([-card_size_x / 2, -card_thickness / 2, card_bottom_z])
      cube([card_size_x, card_thickness, card_size], center = false);

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

