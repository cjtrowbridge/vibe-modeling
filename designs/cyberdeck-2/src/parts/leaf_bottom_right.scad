// Part 2: leaf_bottom_right (product quadrant X > 0, Z < 0).
// Exact quadrant [X 0..127] x [Y 0..80] x [Z -127..0]; see
// leaf_bottom_left.scad for the splitting convention and the print
// transform (rear face on the bed, opening face up, flat footprint).

module leaf_bottom_right_quadrant() {
  translate([0.0, 0.0, -case_width / 2.0])
    cube([case_width / 2.0, case_depth_exterior, case_width / 2.0], center = false);
}

// This leaf owns 2 tongue slabs (plan 1.3): the right-front and
// right-rear slabs of the right ribbon (seam Z = 0). Each slab crosses the
// Z = 0 split plane (z -3..11), so it is unioned IN AFTER the quadrant
// intersection and its 3.6 bore then cut, keeping this leaf one manifold
// piece (plan 3.2/4.1c; same pattern as leaf_bottom_left).
module leaf_bottom_right_body() {
  difference() {
    union() {
      intersection() {
        enclosure_final();
        leaf_bottom_right_quadrant();
      }
      seam_station_slabs_bottom_right();
    }
    seam_station_slab_cuts_bottom_right();
  }
}

module leaf_bottom_right_print_assertions() {
  // Bed X: the right ribbons cross the Z = 0 split plane, not the X = 0
  // one, so the plain 127 bound holds. Bed Y: 127 quadrant + up to 11.0
  // slab reach -> 138, asserted at the 141 bound.
  assert(case_width / 2.0 <= print_bed - print_reserve, "leaf print footprint X within usable bed (127 <= 215)");
  assert(case_half + tongue_slab_len <= print_bed - print_reserve, "leaf print footprint Y within usable bed (141 <= 215)");
}

module leaf_bottom_right_print() {
  leaf_bottom_right_print_assertions();
  translate([0.0, case_width / 2.0, case_depth_exterior])
    rotate([-90, 0, 0])
      leaf_bottom_right_body();
}