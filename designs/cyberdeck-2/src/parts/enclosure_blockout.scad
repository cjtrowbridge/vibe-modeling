function seam_pad_y0(rear) = rear
  ? rack_internal_depth - seam_pad_depth
  : 0;
function seam_fastener_x() = -seam_joint_cross_width / 2;
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
function seam_socket_cavity_z0(top) = top
  ? seam_nut_layer_z0(top) + seam_nut_layer_thickness
  : seam_head_layer_z0(top) + seam_head_layer_thickness;
function seam_tongue_z0(top) = seam_socket_cavity_z0(top)
  + seam_socket_sliding_clearance;
function seam_tongue_y0(rear) = seam_pad_y0(rear)
  + seam_socket_wall_thickness + seam_socket_sliding_clearance;
function seam_receiver_x0() = -seam_pad_half_width;
function seam_socket_cavity_x0() = -(seam_joint_cross_width
  + seam_socket_tip_clearance);

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

// Local screen-rack frame: X is shared with the receiver, +Y is the
// user-facing face normal, and +Z is face-local 2U height.  The transform puts
// its rear-most upper corner exactly at the open Y = 0 end while the face looks
// toward the integral closed wall at +Y.
module angled_screen_frame_transform() {
  translate([0, screen_rack_base_y, enclosure_top_z])
    rotate([screen_rack_face_angle, 0, 0])
      children();
}

module angled_screen_frame_uncut() {
  angled_screen_frame_transform()
    union() {
      // Two face-local 2U rails create a 222.25 x 88.90 mm clear screen
      // aperture.  Their 7 mm rearward material retains the blind M3 inserts.
      translate([-rack_front_width / 2, -screen_rack_face_rail_depth, 0])
        cube([rack_rail_face_width, screen_rack_face_rail_depth,
              screen_rack_face_height]);
      translate([rack_clear_opening_width / 2, -screen_rack_face_rail_depth, 0])
        cube([rack_rail_face_width, screen_rack_face_rail_depth,
              screen_rack_face_height]);

      // The outer side support walls carry each rail into the existing full
      // height chassis wall.  They intentionally leave the entire top and
      // center open: roof and rear closure are a later separate component.
      translate([-rack_front_width / 2, -screen_rack_rear_clearance, 0])
        cube([screen_rack_side_wall_thickness, screen_rack_rear_clearance,
              screen_rack_face_height]);
      translate([rack_front_width / 2 - screen_rack_side_wall_thickness,
                 -screen_rack_rear_clearance, 0])
        cube([screen_rack_side_wall_thickness, screen_rack_rear_clearance,
              screen_rack_face_height]);

    }
}

module angled_screen_enclosure_closure() {
  // These surfaces remain in assembled coordinates, not the angled face-local
  // frame: the roof is horizontally level and the rear is vertically at Y = 0.
  translate([-rack_front_width / 2, 0,
             screen_rack_top_z - screen_rack_upper_roof_thickness])
    cube([rack_front_width, screen_rack_upper_roof_front_y,
          screen_rack_upper_roof_thickness]);
  translate([-rack_front_width / 2, 0, screen_rack_rear_wall_bottom_z])
    cube([rack_front_width, screen_rack_rear_wall_thickness,
          screen_rack_top_z - screen_rack_rear_wall_bottom_z]);
}

module angled_screen_side_infill(side) {
  x0 = side < 0 ? -rack_front_width / 2
                : rack_front_width / 2 - screen_rack_side_wall_thickness;
  x1 = side < 0 ? -rack_front_width / 2 + screen_rack_side_wall_thickness
                : rack_front_width / 2;
  // Full exterior wedge face: it overlaps the side support, angled rail end,
  // roof, rear wall, and retained lower-chassis roof/side-wall material.
  polyhedron(
    points = [
      [x0, 0, enclosure_top_z],
      [x0, 0, screen_rack_top_z],
      [x0, screen_rack_upper_roof_front_y, screen_rack_top_z],
      [x0, screen_rack_base_y, enclosure_top_z],
      [x1, 0, enclosure_top_z],
      [x1, 0, screen_rack_top_z],
      [x1, screen_rack_upper_roof_front_y, screen_rack_top_z],
      [x1, screen_rack_base_y, enclosure_top_z]
    ],
    faces = [
      [0, 3, 2, 1], [4, 5, 6, 7], [0, 1, 5, 4], [1, 2, 6, 5],
      [2, 3, 7, 6], [3, 0, 4, 7]
    ]
  );
}

module angled_screen_insert_hole_cuts() {
  angled_screen_frame_transform()
    for (side = [-1, 1])
      for (hole_index = [0 : screen_rack_interface_height_u * 3 - 1])
        translate([rack_rail_column_x(side), boolean_epsilon,
                   screen_rack_hole_z(hole_index)])
          rotate([90, 0, 0])
            cylinder(h = rack_insert_hole_depth + boolean_epsilon,
                     d = rack_insert_finished_diameter, $fn = 48);
}

module angled_screen_frame() {
  difference() {
    angled_screen_frame_uncut();
    angled_screen_insert_hole_cuts();
  }
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

    // Front fascia closes only the service zones, leaving the exact 2U opening
    // completely unobstructed while tying both insert rails into the chassis.
    translate([outer_x0, 0, enclosure_bottom_z])
      cube([rack_front_width, front_fascia_depth,
            seam_service_zone_total_height]);
    translate([outer_x0, 0, equipment_top_z])
      cube([rack_front_width, front_fascia_depth,
            seam_service_zone_total_height]);

    // The integral rear remains fully closed at the enlarged rectangular height.
    translate([outer_x0, enclosure_depth - rear_wall_thickness,
               enclosure_bottom_z])
      cube([rack_front_width, rear_wall_thickness, enclosure_height]);

    device_support_rails();
    angled_screen_frame_uncut();
    angled_screen_enclosure_closure();
    angled_screen_side_infill(-1);
    angled_screen_side_infill(1);
  }
}

module shell_master() {
  difference() {
    shell_master_uncut();
    rack_insert_hole_cuts();
    angled_screen_insert_hole_cuts();
    // A single stepped clearance opening now joins the lower screen opening to
    // the port-plate opening. The former 3 mm divider rail was not structural.
    // The narrower forward portion deliberately retains the 10 mm port-plate
    // mounting rails; the completed rear seam block remains uncut.
    translate([-rack_front_width / 2 + screen_rack_lower_roof_opening_side_margin,
               screen_rack_lower_roof_opening_start_y,
               enclosure_top_z - minimum_wall_thickness - boolean_epsilon])
      cube([merged_top_clearance_first_width,
            merged_top_clearance_first_length,
            minimum_wall_thickness + 2 * boolean_epsilon]);
    // The protected port-plate opening leaves continuous 10 mm side rails,
    // a 3 mm screen-side lip, and a 3 mm margin before the rear seam block.
    translate([port_plate_opening_x0, port_plate_opening_y0,
               enclosure_top_z - minimum_wall_thickness - boolean_epsilon])
      cube([port_plate_opening_width, port_plate_opening_length,
            minimum_wall_thickness + 2 * boolean_epsilon]);
    port_plate_chassis_mount_hole_cuts();
  }
}

module port_plate_chassis_mount_hole_cuts() {
  for (x = [-port_plate_mount_x, port_plate_mount_x])
    for (y = [port_plate_mount_y_front, port_plate_mount_y_rear])
      translate([x, y, enclosure_top_z - minimum_wall_thickness - boolean_epsilon])
        cylinder(h = minimum_wall_thickness + 2 * boolean_epsilon,
                 d = port_plate_mount_hole_diameter, $fn = 48);
}

module port_plate_mount_hole_cuts() {
  for (x = [-port_plate_mount_x, port_plate_mount_x])
    for (y = [port_plate_mount_y_front, port_plate_mount_y_rear])
      translate([x, y, enclosure_top_z - boolean_epsilon])
        cylinder(h = port_plate_thickness + 2 * boolean_epsilon,
                 d = port_plate_mount_hole_diameter, $fn = 48);
}

module port_plate_master() {
  translate([-port_plate_width / 2, port_plate_y0, enclosure_top_z])
    cube([port_plate_width, port_plate_height, port_plate_thickness]);
}

module port_plate_left_assembled() {
  difference() {
    union() {
      intersection() {
        port_plate_master();
        translate([-port_plate_width / 2 - boolean_epsilon, port_plate_y0 - boolean_epsilon,
                   enclosure_top_z - boolean_epsilon])
          cube([port_plate_width / 2 + boolean_epsilon, port_plate_height + 2 * boolean_epsilon,
                port_plate_thickness + 2 * boolean_epsilon]);
      }
      // Positive 3 mm overlap into the left plate carries the registration tongue.
      translate([-port_plate_seam_tongue_width, port_plate_seam_y0, enclosure_top_z])
        cube([2 * port_plate_seam_tongue_width, port_plate_seam_length,
              port_plate_thickness]);
    }
    port_plate_mount_hole_cuts();
  }
}

module port_plate_right_assembled() {
  difference() {
    intersection() {
      port_plate_master();
      translate([0, port_plate_y0 - boolean_epsilon, enclosure_top_z - boolean_epsilon])
        cube([port_plate_width / 2 + boolean_epsilon, port_plate_height + 2 * boolean_epsilon,
              port_plate_thickness + 2 * boolean_epsilon]);
    }
    // The socket is intentionally 1 mm wider than the tongue for sliding assembly.
    translate([-boolean_epsilon, port_plate_seam_y0 - boolean_epsilon,
               enclosure_top_z - boolean_epsilon])
      cube([port_plate_socket_width + boolean_epsilon,
            port_plate_seam_length + 2 * boolean_epsilon,
            port_plate_thickness + 2 * boolean_epsilon]);
    port_plate_mount_hole_cuts();
  }
}

module port_plate_left_print() { port_plate_left_assembled(); }
module port_plate_right_print() { port_plate_right_assembled(); }

module seam_vertical_through_cut(rear, top) {
  cut_z0 = top ? equipment_top_z - boolean_epsilon
               : enclosure_bottom_z - boolean_epsilon;
  translate([seam_fastener_x(), seam_fastener_y(rear), cut_z0])
    cylinder(h = seam_pad_height + 2 * boolean_epsilon,
             d = seam_fastener_finished_diameter, $fn = 48);
}

module seam_vertical_head_recess_cut(rear, top) {
  cut_z0 = top ? enclosure_top_z - seam_head_washer_recess_depth
               : enclosure_bottom_z - boolean_epsilon;
  translate([seam_fastener_x(), seam_fastener_y(rear), cut_z0])
    cylinder(h = seam_head_washer_recess_depth + boolean_epsilon,
             d = seam_head_washer_recess_diameter, $fn = 64);
}

module seam_vertical_nut_recess_cut(rear, top) {
  cut_z0 = top ? equipment_top_z - boolean_epsilon
               : equipment_bottom_z - seam_nut_recess_depth;
  translate([seam_fastener_x(), seam_fastener_y(rear), cut_z0])
    cylinder(h = seam_nut_recess_depth + boolean_epsilon,
             d = seam_nut_circumscribed_diameter, $fn = 6);
}

module seam_socket_cavity_cut(rear, top) {
  translate([seam_socket_cavity_x0(),
             seam_pad_y0(rear) + seam_socket_wall_thickness,
             seam_socket_cavity_z0(top)])
    cube([seam_joint_cross_width + seam_socket_tip_clearance + boolean_epsilon,
          seam_socket_cavity_depth, seam_socket_cavity_height]);
}

module seam_receiver_socket(rear, top) {
  service_z0 = top ? equipment_top_z : enclosure_bottom_z;
  difference() {
    union() {
      // The exterior head wall and bay-facing nut wall close the socket in Z.
      translate([seam_receiver_x0(), seam_pad_y0(rear),
                 seam_head_layer_z0(top)])
        cube([seam_pad_half_width, seam_pad_depth,
              seam_head_layer_thickness]);
      translate([seam_receiver_x0(), seam_pad_y0(rear),
                 seam_nut_layer_z0(top)])
        cube([seam_pad_half_width, seam_pad_depth,
              seam_nut_layer_thickness]);

      // Front, rear, and closed-end walls leave the center-seam mouth as the
      // sole insertion path for the mating tongue.
      translate([seam_receiver_x0(), seam_pad_y0(rear), service_z0])
        cube([seam_pad_half_width, seam_socket_wall_thickness,
              seam_service_zone_total_height]);
      translate([seam_receiver_x0(),
                 seam_pad_y0(rear) + seam_pad_depth - seam_socket_wall_thickness,
                 service_z0])
        cube([seam_pad_half_width, seam_socket_wall_thickness,
              seam_service_zone_total_height]);
      translate([seam_receiver_x0(), seam_pad_y0(rear), service_z0])
        cube([seam_pad_half_width - (seam_joint_cross_width
              + seam_socket_tip_clearance), seam_pad_depth,
              seam_service_zone_total_height]);
    }
    seam_socket_cavity_cut(rear, top);
    seam_vertical_through_cut(rear, top);
    seam_vertical_head_recess_cut(rear, top);
    seam_vertical_nut_recess_cut(rear, top);
  }
}

module seam_tongue(rear, top) {
  service_z0 = top ? equipment_top_z : enclosure_bottom_z;
  difference() {
    union() {
      translate([-seam_joint_cross_width, seam_tongue_y0(rear),
                 seam_tongue_z0(top)])
        cube([seam_joint_cross_width + seam_socket_wall_thickness,
              seam_tongue_depth, seam_tongue_thickness]);
      // A full-height root block positively joins the tongue into the right
      // shell and front/rear service structure before the tongue enters the
      // left receiver.
      translate([0, seam_pad_y0(rear), service_z0])
        cube([seam_socket_wall_thickness, seam_pad_depth,
              seam_service_zone_total_height]);
    }
    seam_vertical_through_cut(rear, top);
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
    if (side > 0)
      screen_roof_seam_socket_cut();
    if (side < 0)
      for (rear = [false, true])
        for (top = [false, true]) {
          // The left shell owns the complete head and nut cuts. Cutting it as
          // well as the socket prevents the shell union from filling recesses.
          seam_vertical_through_cut(rear, top);
          seam_vertical_nut_recess_cut(rear, top);
          seam_vertical_head_recess_cut(rear, top);
        }
  }
}

module screen_roof_seam_socket_cut() {
  // This is entirely within the existing roof thickness; it cannot project
  // below the pre-existing roof underside into the screen insertion envelope.
  translate([-boolean_epsilon, screen_roof_seam_y0 - boolean_epsilon,
             screen_rack_top_z - screen_rack_upper_roof_thickness - boolean_epsilon])
    cube([screen_roof_seam_socket_width + boolean_epsilon,
          screen_roof_seam_length + 2 * boolean_epsilon,
          screen_rack_upper_roof_thickness + 2 * boolean_epsilon]);
}

module screen_roof_seam_tongue() {
  // The root overlaps the left roof by the named positive structural amount.
  translate([-screen_roof_seam_tongue_width, screen_roof_seam_y0,
             screen_rack_top_z - screen_rack_upper_roof_thickness])
    cube([2 * screen_roof_seam_tongue_width, screen_roof_seam_length,
          screen_rack_upper_roof_thickness]);
}

module leaf_assembly_geometry(side) {
  union() {
    prepared_shell_half(side);
    if (side < 0)
      screen_roof_seam_tongue();
    for (rear = [false, true])
      for (top = [false, true]) {
        if (side < 0)
          seam_receiver_socket(rear, top);
        else
          seam_tongue(rear, top);
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
    translate([-explode / 2, 0, 0]) port_plate_left_assembled();
    translate([ explode / 2, 0, 0]) port_plate_right_assembled();
  } else {
    translate([-explode, 0, 0]) enclosure_left_assembled();
    translate([ explode, 0, 0]) enclosure_right_assembled();
    translate([-explode / 2, 0, 0]) port_plate_left_assembled();
    translate([ explode / 2, 0, 0]) port_plate_right_assembled();
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

module front_fascia_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 1, -boolean_epsilon,
               enclosure_bottom_z - 1])
      cube([rack_front_width + 2, section_thickness,
            enclosure_height + 2]);
  }
}

module angled_screen_crop() {
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 1, -1, screen_rack_lowest_support_z - 1])
      cube([rack_front_width + 2, screen_rack_footprint_depth + 2,
            screen_rack_top_z - screen_rack_lowest_support_z + 2]);
  }
}

module angled_screen_side_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 0.1, -1, screen_rack_lowest_support_z - 1])
      cube([section_thickness, screen_rack_footprint_depth + 2,
            screen_rack_top_z - screen_rack_lowest_support_z + 2]);
  }
}

module angled_screen_rail_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([rack_rail_column_x(-1) - section_thickness / 2, -1,
               screen_rack_lowest_support_z - 1])
      cube([section_thickness, screen_rack_footprint_depth + 2,
            screen_rack_top_z - screen_rack_lowest_support_z + 2]);
  }
}

module screen_roof_rear_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 1, screen_rack_rear_wall_thickness / 2
               - section_thickness / 2, enclosure_top_z - 1])
      cube([rack_front_width + 2, section_thickness,
            screen_rack_top_z - enclosure_top_z + 2]);
  }
}

module lower_roof_opening_section() {
  section_thickness = 0.8;
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 1,
               screen_rack_lower_roof_opening_start_y + section_thickness,
               enclosure_top_z - 8])
      cube([rack_front_width + 2, screen_rack_lower_roof_opening_length
            - 2 * section_thickness, 16]);
  }
}

module port_plate_roof_opening_crop() {
  intersection() {
    assembled_enclosure();
    translate([-rack_front_width / 2 - 1, port_plate_y0 - 1,
               enclosure_top_z - minimum_wall_thickness - 1])
      cube([rack_front_width + 2, port_plate_height + 2,
            port_plate_thickness + minimum_wall_thickness + 2]);
  }
}

module port_plate_rear_seam_access_crop() {
  intersection() {
    assembled_enclosure();
    translate([-seam_pad_total_width, port_plate_opening_y1 - 2,
               enclosure_top_z - minimum_wall_thickness - 1])
      cube([2 * seam_pad_total_width, enclosure_depth - port_plate_opening_y1 + 3,
            port_plate_thickness + minimum_wall_thickness + 2]);
  }
}

module port_plate_split_crop() {
  intersection() {
    assembled_enclosure();
    translate([-12, port_plate_y0 - 1, enclosure_top_z - 1])
      cube([24, port_plate_height + 2, port_plate_thickness + 2]);
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
  } else if (view_id == 14) {
    front_fascia_section();
  } else if (view_id == 15) {
    angled_screen_crop();
  } else if (view_id == 16) {
    angled_screen_side_section();
  } else if (view_id == 17) {
    angled_screen_rail_section();
  } else if (view_id == 18) {
    screen_roof_rear_section();
  } else if (view_id == 19) {
    lower_roof_opening_section();
  } else if (view_id == 20) {
    port_plate_roof_opening_crop();
  } else if (view_id == 21) {
    port_plate_rear_seam_access_crop();
  } else if (view_id == 22) {
    port_plate_split_crop();
  } else {
    assert(false, str("Unknown assembly_view_id: ", view_id));
  }
}
