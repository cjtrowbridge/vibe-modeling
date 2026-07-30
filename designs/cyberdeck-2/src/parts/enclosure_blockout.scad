function seam_pad_y0(rear) = rear
  ? rack_internal_depth - seam_pad_depth - seam_joint_pocket_clearance
  : 0;
function seam_fastener_y(rear) = seam_pad_y0(rear) + seam_pad_depth / 2;
function seam_fastener_z(top) = top
  ? equipment_top_z + seam_pad_height / 2
  : enclosure_bottom_z + seam_pad_height / 2;
function seam_head_layer_z0(top) = top
  ? enclosure_top_z - seam_head_layer_thickness
  : enclosure_bottom_z;
function seam_nut_layer_z0(top) = top
  ? equipment_top_z
  : equipment_bottom_z - seam_nut_layer_thickness;

module rack_insert_hole_cuts() {
  for (side = [-1, 1])
    for (hole_index = [0 : rack_height_u * 3 - 1])
      translate([rack_rail_column_x(side), -boolean_epsilon,
                 rack_hole_z(hole_index)])
        rotate([-90, 0, 0])
          cylinder(h = rack_insert_hole_depth + boolean_epsilon,
                   d = rack_insert_finished_diameter, $fn = 48);
}

module device_support_rails() {
  // Continuous shelves overlap each exterior wall and the device footprint.
  translate([-device_support_rail_outer_x, 0, device_support_rail_bottom_z])
    cube([device_support_rail_width, enclosure_depth,
          device_support_rail_thickness]);
  translate([device_support_rail_inner_x, 0, device_support_rail_bottom_z])
    cube([device_support_rail_width, enclosure_depth,
          device_support_rail_thickness]);
}

module shell_master_uncut() {
  outer_x0 = -rack_front_width / 2;

  union() {
    // Flush exterior plates replace the former projecting seam pads.
    translate([outer_x0, 0, enclosure_bottom_z])
      cube([rack_front_width, enclosure_depth, minimum_wall_thickness]);
    translate([outer_x0, 0, enclosure_top_z - minimum_wall_thickness])
      cube([rack_front_width, enclosure_depth, minimum_wall_thickness]);

    // Full-height side walls provide planar top/bottom and side-wall-down beds.
    translate([outer_x0, 0, enclosure_bottom_z])
      cube([minimum_wall_thickness, enclosure_depth, enclosure_height]);
    translate([rack_front_width / 2 - minimum_wall_thickness, 0,
               enclosure_bottom_z])
      cube([minimum_wall_thickness, enclosure_depth, enclosure_height]);

    // Full-height front rails retain the canonical twelve blind insert bores.
    translate([outer_x0, 0, enclosure_bottom_z])
      cube([rack_rail_face_width, front_rail_depth, enclosure_height]);
    translate([rack_clear_opening_width / 2, 0, enclosure_bottom_z])
      cube([rack_rail_face_width, front_rail_depth, enclosure_height]);

    // The integral rear remains fully closed at the enlarged rectangular height.
    translate([outer_x0, enclosure_depth - rear_wall_thickness,
               enclosure_bottom_z])
      cube([rack_front_width, rear_wall_thickness, enclosure_height]);

    device_support_rails();
  }
}

module shell_master() {
  difference() {
    shell_master_uncut();
    rack_insert_hole_cuts();
  }
}

module seam_head_cross_pocket_cut(rear, top) {
  pocket_z0 = seam_head_layer_z0(top) - boolean_epsilon;
  translate([-seam_joint_cross_width - seam_joint_pocket_clearance,
             seam_pad_y0(rear) - seam_joint_pocket_clearance,
             pocket_z0])
    cube([seam_joint_cross_width + seam_joint_pocket_clearance
          + boolean_epsilon,
          seam_pad_depth + 2 * seam_joint_pocket_clearance,
          seam_head_layer_thickness + 2 * boolean_epsilon]);
}

module seam_vertical_through_cut(rear, top) {
  cut_z0 = top ? equipment_top_z - boolean_epsilon
               : enclosure_bottom_z - boolean_epsilon;
  translate([0, seam_fastener_y(rear), cut_z0])
    cylinder(h = seam_pad_height + 2 * boolean_epsilon,
             d = seam_fastener_finished_diameter, $fn = 48);
}

module seam_vertical_head_recess_cut(rear, top) {
  cut_z0 = top ? enclosure_top_z - seam_head_washer_recess_depth
               : enclosure_bottom_z - boolean_epsilon;
  translate([0, seam_fastener_y(rear), cut_z0])
    cylinder(h = seam_head_washer_recess_depth + boolean_epsilon,
             d = seam_head_washer_recess_diameter, $fn = 64);
}

module seam_vertical_nut_recess_cut(rear, top) {
  cut_z0 = top ? equipment_top_z - boolean_epsilon
               : equipment_bottom_z - seam_nut_recess_depth;
  translate([0, seam_fastener_y(rear), cut_z0])
    cylinder(h = seam_nut_recess_depth + boolean_epsilon,
             d = seam_nut_circumscribed_diameter, $fn = 6);
}

module seam_head_flange(rear, top) {
  difference() {
    translate([-seam_joint_cross_width, seam_pad_y0(rear),
               seam_head_layer_z0(top)])
      cube([seam_pad_half_width + seam_joint_cross_width,
            seam_pad_depth, seam_head_layer_thickness]);
    seam_vertical_through_cut(rear, top);
    seam_vertical_head_recess_cut(rear, top);
  }
}

module seam_nut_flange(rear, top) {
  root_web_z0 = top
    ? seam_nut_layer_z0(top) + seam_nut_layer_thickness
    : enclosure_bottom_z;
  root_web_height = seam_head_layer_thickness + seam_joint_layer_clearance;
  compression_land_z0 = top
    ? seam_nut_layer_z0(top) + seam_nut_layer_thickness
    : seam_nut_layer_z0(top) - seam_joint_layer_clearance;

  difference() {
    union() {
      translate([-seam_pad_half_width, seam_pad_y0(rear),
                 seam_nut_layer_z0(top)])
        cube([seam_pad_half_width + seam_joint_cross_width,
              seam_pad_depth, seam_nut_layer_thickness]);
      translate([-seam_pad_half_width, seam_pad_y0(rear), root_web_z0])
        cube([seam_joint_root_web_width, seam_pad_depth, root_web_height]);
      translate([0, seam_fastener_y(rear), compression_land_z0])
        cylinder(h = seam_joint_layer_clearance,
                 d = seam_joint_compression_land_diameter, $fn = 64);
    }
    seam_vertical_through_cut(rear, top);
    seam_vertical_nut_recess_cut(rear, top);
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

module prepared_shell_half(side) {
  difference() {
    shell_half(side);
    for (rear = [false, true])
      for (top = [false, true]) {
        // Cut the owning shell as well as the crossing flange. Without these
        // shell-level cuts, the union fills half of each nominal opening.
        seam_vertical_through_cut(rear, top);
        if (side < 0) {
          seam_vertical_nut_recess_cut(rear, top);
        } else {
          seam_vertical_head_recess_cut(rear, top);
        }
      }
    if (side < 0)
      for (rear = [false, true])
        for (top = [false, true])
          seam_head_cross_pocket_cut(rear, top);
  }
}

module leaf_assembly_geometry(side) {
  union() {
    prepared_shell_half(side);
    for (rear = [false, true])
      for (top = [false, true]) {
        if (side < 0)
          seam_nut_flange(rear, top);
        else
          seam_head_flange(rear, top);
      }
  }
}

module enclosure_left_print() {
  translate([0, 0, rack_front_width / 2])
    rotate([0, -90, 0])
      leaf_assembly_geometry(-1);
}

module enclosure_right_print() {
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
               equipment_bottom_z])
      cube([rack_equipment_width_max, generic_equipment_depth,
            rack_clear_height]);
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
  crop_z = top ? equipment_top_z : enclosure_bottom_z;
  intersection() {
    assembled_enclosure();
    translate([-seam_pad_total_width, -boolean_epsilon, crop_z])
      cube([2 * seam_pad_total_width, enclosure_depth + 2 * boolean_epsilon,
            seam_pad_height]);
  }
}

module seam_fastener_section(rear = false, top = true) {
  section_thickness = 0.8;
  crop_z = top ? equipment_top_z - 1 : enclosure_bottom_z - 1;
  intersection() {
    assembled_enclosure();
    translate([-seam_pad_half_width - 1,
               seam_fastener_y(rear) - section_thickness / 2,
               crop_z])
      cube([seam_pad_total_width + 2, section_thickness,
            seam_pad_height + 2]);
  }
}

module rack_insert_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([rack_rail_column_x(-1) - section_thickness / 2,
               -1, enclosure_bottom_z - 1])
      cube([section_thickness, front_rail_depth + 2,
            enclosure_height + 2]);
  }
}

module support_rail_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 1,
               enclosure_depth / 2 - section_thickness / 2,
               enclosure_bottom_z - 1])
      cube([rack_front_width + 2, section_thickness,
            seam_pad_height + device_support_rail_thickness + 2]);
  }
}

module seam_station_opening_crop(rear = false, top = true) {
  pair_y = rear ? 13 : -13;
  crop_z0 = top ? equipment_top_z : enclosure_bottom_z;
  translate([0, pair_y - seam_fastener_y(rear), -seam_fastener_z(top)])
    intersection() {
      assembled_enclosure();
      translate([-seam_pad_half_width - 1,
                 seam_pad_y0(rear) - 1,
                 crop_z0])
        cube([seam_pad_total_width + 2, seam_pad_depth + 2,
              seam_pad_height]);
    }
}

module seam_opening_pair(top = true) {
  seam_station_opening_crop(rear = false, top = top);
  seam_station_opening_crop(rear = true, top = top);
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
  } else if (view_id == 11) {
    support_rail_section();
  } else if (view_id == 12) {
    seam_opening_pair(top = true);
  } else if (view_id == 13) {
    seam_opening_pair(top = false);
  } else {
    assert(false, str("Unknown assembly_view_id: ", view_id));
  }
}
