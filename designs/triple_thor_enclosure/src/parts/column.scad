module column_body() {
  difference() {
    cylinder(h = cyl_h, r = base_center_bore_r, center = false);
    translate([0, 0, -0.1])
      cylinder(h = cyl_h + 0.2, r = base_center_bore_r - minimum_wall_thickness, center = false);
  }
}

module column_print() {
  column_body();
}
