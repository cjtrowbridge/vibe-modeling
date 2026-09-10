module base_sector_body() {
  difference() {
    // Outer shell: strong annular sector ring with 3 mm minimum wall.
    rotate_extrude(angle = 120) {
      polygon([
        [base_ring_inner_r, 0],
        [base_r_out, 0],
        [base_r_out, base_h],
        [base_ring_inner_r, base_h]
      ]);
    }

    // Open center bore for the central column and access duct.
    translate([0, 0, -0.1])
      rotate_extrude(angle = 120) {
        polygon([
          [0, 0],
          [base_center_bore_r, 0],
          [base_center_bore_r, base_h],
          [0, base_h]
        ]);
      }

    // Thor recess pocket: open bottom, 3 mm anti-drop lip left around it.
    translate([0, 0, -0.1])
      rotate([0, 0, -60])
      translate([-thor_w/2, -thor_d/2, 0])
      cube([thor_w, thor_d, thor_recess_depth + 0.2]);

    // Cylinder receiving lip seat at the outer edge.
    translate([0, 0, -0.1])
      rotate_extrude(angle = 120) {
        polygon([
          [cyl_outer_r - minimum_wall_thickness, 0],
          [base_r_out, 0],
          [base_r_out, minimum_wall_thickness],
          [cyl_outer_r - minimum_wall_thickness, minimum_wall_thickness]
        ]);
      }

    // M3 seam / hardware holes.
    rotate([90, 0, 90])
      translate([0, 0, -base_r_out])
      cylinder(h = base_r_out * 2, d = m3_hole_d, center = false);
  }
}

module base_sector_print() {
  base_sector_body();
}
