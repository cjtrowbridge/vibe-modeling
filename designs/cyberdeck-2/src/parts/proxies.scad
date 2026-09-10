// Non-printable review reference geometry (render-only, never exported).

// Maximum equipment envelope between the shelves: 220 wide (spec baseline),
// full chamber depth (Y 3..77), full clear-opening height (Z -111.125..111.125).
module equipment_proxy() {
  translate([0, (front_wall_t + (case_depth_exterior - rear_wall_t)) / 2.0, 0])
    cube([equipment_width_max, case_depth_exterior - front_wall_t - rear_wall_t, clear_opening], center = true);
}

// Assembled product; explode > 0 separates the four leaves along X/Z for the
// exploded review view.
module assembled_product(explode = 0, show_proxies = true) {
  union() {
    translate([-explode, 0, -explode]) leaf_bottom_left_body();
    translate([explode, 0, -explode]) leaf_bottom_right_body();
    translate([explode, 0, explode]) leaf_top_right_body();
    translate([-explode, 0, explode]) leaf_top_left_body();
  }
  if (show_proxies)
    color("lightblue")
      equipment_proxy();
}