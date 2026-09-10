// Part 3: leaf_top_right (product quadrant X > 0, Z > 0).
// Exact quadrant [X 0..127] x [Y 0..80] x [Z 0..127]; see
// leaf_bottom_left.scad for the splitting convention and the print
// transform (rear face on the bed, opening face up, flat footprint).

module leaf_top_right_quadrant() {
  translate([0.0, 0.0, 0.0])
    cube([case_width / 2.0, case_depth_exterior, case_width / 2.0], center = false);
}

module leaf_top_right_body() {
  intersection() {
    enclosure_final();
    leaf_top_right_quadrant();
  }
}

module leaf_top_right_print_assertions() {
  assert(case_width / 2.0 <= print_bed - print_reserve, "leaf print footprint within usable bed");
  assert(case_depth_exterior <= print_bed - print_reserve, "leaf print height within usable bed");
}

module leaf_top_right_print() {
  leaf_top_right_print_assertions();
  translate([0.0, 0.0, case_depth_exterior])
    rotate([-90, 0, 0])
      leaf_top_right_body();
}