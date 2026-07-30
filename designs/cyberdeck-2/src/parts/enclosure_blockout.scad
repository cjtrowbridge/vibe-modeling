function seam_pad_y0(rear) = rear ? enclosure_depth - seam_pad_depth : 0;
function seam_pad_z0(top) = top
  ? rack_clear_height / 2
  : -enclosure_height / 2 - seam_pad_external_height;
function seam_fastener_y(rear) = seam_pad_y0(rear) + seam_pad_depth / 2;
function seam_fastener_z(top) = seam_pad_z0(top) + seam_pad_height / 2;

module rack_insert_hole_cuts() {
  for (side = [-1, 1])
    for (hole_index = [0 : rack_height_u * 3 - 1])
      translate([rack_rail_column_x(side), -boolean_epsilon,
                 rack_hole_z(hole_index)])
        rotate([-90, 0, 0])
          cylinder(h = rack_insert_hole_depth + boolean_epsilon,
                   d = rack_insert_finished_diameter, $fn = 48);
}

module shell_master_uncut() {
  outer_x0 = -rack_front_width / 2;
  outer_z0 = -enclosure_height / 2;

  union() {
    // Full-width horizontal plates overlap side, front-rail, and rear members.
    translate([outer_x0, 0, outer_z0])
      cube([rack_front_width, enclosure_depth, minimum_wall_thickness]);
    translate([outer_x0, 0, rack_clear_height / 2])
      cube([rack_front_width, enclosure_depth, minimum_wall_thickness]);

    // Full-depth exterior side walls.
    translate([outer_x0, 0, outer_z0])
      cube([minimum_wall_thickness, enclosure_depth, enclosure_height]);
    translate([rack_front_width / 2 - minimum_wall_thickness, 0, outer_z0])
      cube([minimum_wall_thickness, enclosure_depth, enclosure_height]);

    // Deep continuous front rails provide the blind M3 insert lands.
    translate([outer_x0, 0, outer_z0])
      cube([rack_rail_face_width, front_rail_depth, enclosure_height]);
    translate([rack_clear_opening_width / 2, 0, outer_z0])
      cube([rack_rail_face_width, front_rail_depth, enclosure_height]);

    // The rear is deliberately closed and integrated into both printable leaves.
    translate([outer_x0, enclosure_depth - rear_wall_thickness, outer_z0])
      cube([rack_front_width, rear_wall_thickness, enclosure_height]);
  }
}

module shell_master() {
  difference() {
    shell_master_uncut();
    rack_insert_hole_cuts();
  }
}

module seam_lap_key(rear, top) {
  translate([-seam_lap_root_overlap,
             seam_fastener_y(rear) - seam_lap_key_depth / 2,
             seam_fastener_z(top) - seam_lap_key_height / 2])
    cube([seam_lap_root_overlap + seam_lap_engagement,
          seam_lap_key_depth, seam_lap_key_height]);
}

module seam_lap_pocket_cut(rear, top) {
  translate([-boolean_epsilon,
             seam_fastener_y(rear) - seam_lap_pocket_depth / 2,
             seam_fastener_z(top) - seam_lap_pocket_height / 2])
    cube([seam_lap_engagement + seam_lap_fit_clearance_per_side
          + boolean_epsilon,
          seam_lap_pocket_depth, seam_lap_pocket_height]);
}

module seam_through_hole_cut(rear, top) {
  translate([-seam_pad_half_width - boolean_epsilon,
             seam_fastener_y(rear), seam_fastener_z(top)])
    rotate([0, 90, 0])
      cylinder(h = seam_pad_total_width + 2 * boolean_epsilon,
               d = seam_fastener_finished_diameter, $fn = 48);
}

module seam_head_washer_recess_cut(rear, top) {
  translate([-seam_pad_half_width - boolean_epsilon,
             seam_fastener_y(rear), seam_fastener_z(top)])
    rotate([0, 90, 0])
      cylinder(h = seam_head_washer_recess_depth + boolean_epsilon,
               d = seam_head_washer_recess_diameter, $fn = 64);
}

module seam_nut_recess_cut(rear, top) {
  translate([seam_pad_half_width - seam_nut_recess_depth,
             seam_fastener_y(rear), seam_fastener_z(top)])
    rotate([0, 90, 0])
      cylinder(h = seam_nut_recess_depth + boolean_epsilon,
               d = seam_nut_circumscribed_diameter, $fn = 6);
}

module seam_pad_half(side, rear, top) {
  assert(side == -1 || side == 1, "SEAM: side must be -1 or 1");
  pad_x0 = side < 0 ? -seam_pad_half_width : 0;

  difference() {
    union() {
      translate([pad_x0, seam_pad_y0(rear), seam_pad_z0(top)])
        cube([seam_pad_half_width, seam_pad_depth, seam_pad_height]);
      if (side < 0)
        seam_lap_key(rear, top);
    }

    seam_through_hole_cut(rear, top);
    if (side < 0)
      seam_head_washer_recess_cut(rear, top);
    else {
      seam_lap_pocket_cut(rear, top);
      seam_nut_recess_cut(rear, top);
    }
  }
}

module shell_half(side) {
  clip_x0 = side < 0 ? -rack_front_width : 0;
  intersection() {
    shell_master();
    translate([clip_x0, -boolean_epsilon, -printer_axis_limit])
      cube([rack_front_width, enclosure_depth + 2 * boolean_epsilon,
            2 * printer_axis_limit]);
  }
}

module leaf_assembly_geometry(side) {
  union() {
    shell_half(side);
    for (rear = [false, true])
      for (top = [false, true])
        seam_pad_half(side, rear, top);
  }
}

module enclosure_left_print() {
  // Outer left wall is the bed-contact face. The male lap keys point upward.
  translate([0, 0, rack_front_width / 2])
    rotate([0, -90, 0])
      leaf_assembly_geometry(-1);
}

module enclosure_right_print() {
  // Outer right wall is the bed-contact face; pockets remain support-accessible.
  translate([0, 0, rack_front_width / 2])
    rotate([0, 90, 0])
      leaf_assembly_geometry(1);
}

module enclosure_left_assembled() {
  leaf_assembly_geometry(-1);
}

module enclosure_right_assembled() {
  leaf_assembly_geometry(1);
}

module generic_device_clearance_proxy() {
  color([0.95, 0.25, 0.05, 0.35])
    translate([-rack_equipment_width_max / 2,
               rack_usable_depth_start + equipment_front_fit_clearance,
               -rack_clear_height / 2 + 0.5])
      cube([rack_equipment_width_max, generic_equipment_depth,
            rack_clear_height - 1.0]);
}

module assembled_enclosure(explode = 0, proxies = false) {
  if (proxies) {
    color([0.66, 0.76, 0.82, 0.35]) {
      translate([-explode, 0, 0]) enclosure_left_assembled();
      translate([ explode, 0, 0]) enclosure_right_assembled();
    }
    generic_device_clearance_proxy();
  } else {
    translate([-explode, 0, 0]) enclosure_left_assembled();
    translate([ explode, 0, 0]) enclosure_right_assembled();
  }
}

module seam_crop(top = true) {
  crop_z = top ? rack_clear_height / 2 - 3
               : -enclosure_height / 2 - seam_pad_external_height;
  intersection() {
    assembled_enclosure();
    translate([-seam_pad_total_width, -boolean_epsilon, crop_z])
      cube([2 * seam_pad_total_width, enclosure_depth + 2 * boolean_epsilon,
            seam_pad_external_height + minimum_wall_thickness + 3]);
  }
}

module seam_fastener_section(rear = false, top = true) {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([-seam_pad_half_width - 1,
               seam_fastener_y(rear) - section_thickness / 2,
               seam_pad_z0(top) - 1])
      cube([seam_pad_total_width + 2, section_thickness,
            seam_pad_height + 2]);
  }
}

module rack_insert_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([rack_rail_column_x(-1) - section_thickness / 2,
               -1, -enclosure_height / 2 - 1])
      cube([section_thickness, front_rail_depth + 2,
            enclosure_height + 2]);
  }
}

module assembly_review(view_id = 0, proxies = false) {
  if (view_id == 0) {
    assembled_enclosure(proxies = proxies);
  } else if (view_id == 1) {
    assembled_enclosure(explode = 20);
  } else if (view_id == 2) {
    enclosure_left_assembled();
  } else if (view_id == 3) {
    enclosure_right_assembled();
  } else if (view_id == 4) {
    seam_crop(top = true);
  } else if (view_id == 5) {
    seam_crop(top = false);
  } else if (view_id == 6) {
    rack_insert_section();
  } else if (view_id == 7) {
    seam_fastener_section(rear = false, top = true);
  } else if (view_id == 8) {
    seam_fastener_section(rear = true, top = true);
  } else if (view_id == 9) {
    seam_fastener_section(rear = false, top = false);
  } else if (view_id == 10) {
    seam_fastener_section(rear = true, top = false);
  } else {
    assert(false, str("Unknown assembly_view_id: ", view_id));
  }
}
