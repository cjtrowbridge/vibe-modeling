// Part 1: leaf_bottom_left (product quadrant X < 0, Z < 0).
//
// The product solid is cut at the EXACT split planes X = 0 and Z = 0; this
// leaf is the precise quadrant [X -127..0] x [Y 0..80] x [Z -127..0].
// Exact split planes are CGAL-safe here: no enclosure face lies at X = 0
// or Z = 0 (faces sit at +/-127, +/-124, +/-111.125), and the two Z = 0
// rack holes are intentionally bisected - each leaf carries the
// half-passage, half-seat, and half-pocket at that row (plan sections 2
// and 4.1).
//
// Print transform: rotate([-90,0,0]) maps product (x,y,z) -> (x,z,-y): the
// solid rear face (product Y = 80) becomes the flat bed foot and the opening
// face points up. The translate drops this leaf into print [0,127] x [0,127]
// x [0,80] (flat footprint by construction).

module leaf_bottom_left_quadrant() {
  translate([-case_width / 2.0, 0.0, -case_width / 2.0])
    cube([case_width / 2.0, case_depth_exterior, case_width / 2.0], center = false);
}

// This leaf owns 4 tongue slabs (plan 1.3): the bottom-front and
// bottom-rear slabs of the top/bottom ribbons plus the left-front and
// left-rear slabs of the left ribbon. Each slab is unioned IN AFTER the
// quadrant intersection (its 3.0 root fuse at u -3..0 would otherwise be
// subtracted by the split) and its 3.6 bore is then cut, so the printed
// part is one manifold piece with the slab registered in its pad root and
// reaching into the receiver leaf's socket void (plan 3.2/4.1c).
module leaf_bottom_left_body() {
  difference() {
    union() {
      intersection() {
        enclosure_final();
        leaf_bottom_left_quadrant();
      }
      seam_station_slabs_bottom_left();
    }
    seam_station_slab_cuts_bottom_left();
  }
}

module leaf_bottom_left_print_assertions() {
  // Print envelope: footprint 138 x 138 (127 quadrant + 11.0 max slab
  // reach past the split plane on both the tongue- and receiver-side
  // slabs; asserted at the conservative 141 bound), height 80 (product
  // exterior depth) - all within the 220 mm bed with the 5 mm reserve,
  // and the footprint is planar-flat on the bed.
  assert(case_half + tongue_slab_len <= print_bed - print_reserve, "leaf print footprint within usable bed (141 <= 215)");
  assert(case_depth_exterior <= print_bed - print_reserve, "leaf print height within usable bed");
}

module leaf_bottom_left_print() {
  leaf_bottom_left_print_assertions();
  translate([case_width / 2.0, case_width / 2.0, case_depth_exterior])
    rotate([-90, 0, 0])
      leaf_bottom_left_body();
}