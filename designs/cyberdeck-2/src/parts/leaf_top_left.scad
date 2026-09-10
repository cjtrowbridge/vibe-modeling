// Part 4: leaf_top_left (product quadrant X < 0, Z > 0).
// Exact quadrant [X -127..0] x [Y 0..80] x [Z 0..127]; see
// leaf_bottom_left.scad for the splitting convention and the print
// transform (rear face on the bed, opening face up, flat footprint).

module leaf_top_left_quadrant() {
  translate([-case_width / 2.0, 0.0, 0.0])
    cube([case_width / 2.0, case_depth_exterior, case_width / 2.0], center = false);
}

// This leaf owns 2 tongue slabs (plan 1.3): the top-front and top-rear
// slabs of the top ribbons. Same union-after-intersection / bore-cut
// pattern as leaf_bottom_left (see that file's notes; plan 3.2/4.1c).
module leaf_top_left_body() {
  difference() {
    union() {
      intersection() {
        enclosure_final();
        leaf_top_left_quadrant();
      }
      seam_station_slabs_top_left();
    }
    seam_station_slab_cuts_top_left();
  }
}

module leaf_top_left_print_assertions() {
  // Bed X: 127 quadrant + up to 11.0 slab reach (slabs cross the X = 0
  // split plane into this leaf) -> 138, asserted at the 141 bound. Bed Y:
  // the Z = 0 split plane sits at the quadrant edge, no geometry crosses
  // it here, so the plain 127 bound holds.
  assert(case_half + tongue_slab_len <= print_bed - print_reserve, "leaf print footprint X within usable bed (141 <= 215)");
  assert(case_width / 2.0 <= print_bed - print_reserve, "leaf print footprint Y within usable bed (127 <= 215)");
}

module leaf_top_left_print() {
  leaf_top_left_print_assertions();
  translate([case_width / 2.0, 0.0, case_depth_exterior])
    rotate([-90, 0, 0])
      leaf_top_left_body();
}