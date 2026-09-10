module cap_sector_body() {
  difference() {
    rotate_extrude(angle = 120) {
      polygon([
        [cap_r_in + minimum_wall_thickness, 0],
        [cap_r_out, 0],
        [cap_r_out, cap_h],
        [cap_r_in + minimum_wall_thickness, cap_h]
      ]);
    }

    // Open center and keep only the structural ring around the column seat.
    translate([0, 0, -0.1])
      rotate_extrude(angle = 120) {
        polygon([
          [0, 0],
          [cap_r_in, 0],
          [cap_r_in, cap_h],
          [0, cap_h]
        ]);
      }

    // Keep the centering lip distinct from the top plate.
    translate([0, 0, -0.1])
      rotate_extrude(angle = 120) {
        polygon([
          [cyl_outer_r - minimum_wall_thickness, 0],
          [cap_r_out, 0],
          [cap_r_out, minimum_wall_thickness],
          [cyl_outer_r - minimum_wall_thickness, minimum_wall_thickness]
        ]);
      }
  }
}

module cap_sector_print() {
  cap_sector_body();
}
