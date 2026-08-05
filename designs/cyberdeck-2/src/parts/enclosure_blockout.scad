function seam_pad_y0(rear) = rear
  ? rack_internal_depth - seam_pad_depth
  : 0;
function seam_fastener_x() = seam_fastener_axis_x;
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
function seam_receiver_x0() = -seam_receiver_width;
function seam_socket_cavity_x0() = -(seam_tongue_insert_width
  + seam_socket_tip_clearance);

// Canonical main-chamber rack holes are through-bolted: 3 mm face rail,
// continuous 3.6 mm passage, and a chamber-open M3 nut pocket.
module main_rack_mount_hole_cuts() {
  for (side = [-1, 1])
    for (hole_index = [0 : rack_height_u * 3 - 1])
      translate([rack_rail_column_x(side), -boolean_epsilon,
                 rack_hole_z(hole_index)])
        rotate([-90, 0, 0])
          cylinder(h = front_rail_depth + boolean_epsilon,
                   d = main_rack_mount_hole_diameter, $fn = 48);
}

module main_rack_nut_lands() {
  for (side = [-1, 1])
    for (hole_index = [0 : rack_height_u * 3 - 1])
      translate([side < 0 ? -rack_front_width / 2 : rack_clear_opening_width / 2,
                 0, rack_hole_z(hole_index) - rack_rail_face_width / 2])
        cube([rack_rail_face_width, main_rack_nut_land_depth,
              rack_rail_face_width]);
}

module main_rack_nut_pocket_cuts() {
  for (side = [-1, 1])
    for (hole_index = [0 : rack_height_u * 3 - 1])
      translate([rack_rail_column_x(side), front_rail_depth - boolean_epsilon,
                 rack_hole_z(hole_index)])
        rotate([-90, 0, 0])
          cylinder(h = main_rack_nut_land_depth - front_rail_depth
                       + 2 * boolean_epsilon,
                   d = seam_nut_circumscribed_diameter, $fn = 6);
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

      // This solid fascia is above the 2U aperture.  Together with the side
      // infills and upper roof it forms the continuous 45-degree service band
      // that contains the high-roof locking station.
      translate([-rack_front_width / 2, -screen_rack_face_rail_depth,
                 screen_rack_face_height])
        cube([rack_front_width, screen_rack_face_rail_depth,
              screen_rack_upper_service_band_height]);

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

      // Local rear-side lands make every screen-rail M3 passage usable with a
      // captive nut without recreating a continuous side wall.
      for (side = [-1, 1])
        for (hole_index = [0 : screen_rack_interface_height_u * 3 - 1])
          translate([side < 0 ? -rack_front_width / 2 : rack_clear_opening_width / 2,
                     -screen_rack_nut_land_depth,
                     screen_rack_hole_z(hole_index) - rack_rail_face_width / 2])
            cube([rack_rail_face_width, screen_rack_nut_land_depth,
                  rack_rail_face_width]);

    }
}

module angled_screen_nut_pocket_cuts() {
  angled_screen_frame_transform()
    for (side = [-1, 1])
      for (hole_index = [0 : screen_rack_interface_height_u * 3 - 1])
        translate([rack_rail_column_x(side), -screen_rack_face_rail_depth + boolean_epsilon,
                   screen_rack_hole_z(hole_index)])
          rotate([90, 0, 0])
            cylinder(h = screen_rack_nut_land_depth - screen_rack_face_rail_depth
                         + 2 * boolean_epsilon,
                     d = seam_nut_circumscribed_diameter, $fn = 6);
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
          cylinder(h = screen_rack_face_rail_depth + 2 * boolean_epsilon,
                   d = screen_mount_hole_diameter, $fn = 48);
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

    // 3 mm full-height main-chamber rails are locally thickened only at the
    // twelve chamber-open M3 nut pockets.
    translate([outer_x0, 0, enclosure_bottom_z])
      cube([rack_rail_face_width, front_rail_depth, enclosure_height]);
    translate([rack_clear_opening_width / 2, 0, enclosure_bottom_z])
      cube([rack_rail_face_width, front_rail_depth, enclosure_height]);

    main_rack_nut_lands();

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
    port_plate_chassis_nut_lands();
  }
}

module shell_master() {
  difference() {
    shell_master_uncut();
    main_rack_mount_hole_cuts();
    main_rack_nut_pocket_cuts();
    angled_screen_insert_hole_cuts();
    angled_screen_nut_pocket_cuts();
    merged_roof_opening_cut();
    port_plate_chassis_mount_hole_cuts();
    port_plate_chassis_nut_pocket_cuts();
  }
}

// One continuous polygonal opening replaces the former two rectangular cuts.
// Its side boundary widens the retained roof material from the 3 mm screen
// margin to the 16 mm port-plate mounting rail without a touching rail end.
module merged_roof_opening_cut() {
  translate([0, 0, enclosure_top_z - minimum_wall_thickness - boolean_epsilon])
    linear_extrude(height = minimum_wall_thickness + 2 * boolean_epsilon)
      polygon(points = [
        [screen_opening_x0, screen_rack_lower_roof_opening_start_y],
        [screen_opening_x1, screen_rack_lower_roof_opening_start_y],
        [screen_opening_x1, opening_transition_y0],
        [port_plate_opening_x1, port_plate_opening_y0],
        [port_plate_opening_x1, port_plate_opening_y1],
        [port_plate_opening_x0, port_plate_opening_y1],
        [port_plate_opening_x0, port_plate_opening_y0],
        [screen_opening_x0, opening_transition_y0]
      ]);
}

module port_plate_chassis_mount_hole_cuts() {
  for (x = [-port_plate_mount_x, port_plate_mount_x])
    for (index = [0 : rack_height_u * 3 - 1])
      translate([x, port_plate_mount_y(index), enclosure_top_z - minimum_wall_thickness - boolean_epsilon])
        cylinder(h = minimum_wall_thickness + 2 * boolean_epsilon,
                 d = port_plate_mount_hole_diameter, $fn = 48);
}

// Local under-rail lands retain captive M3 nuts without restoring a thick
// continuous wall below the removable top plate.
module port_plate_chassis_nut_lands() {
  for (x = [-port_plate_mount_x, port_plate_mount_x])
    for (index = [0 : rack_height_u * 3 - 1])
      translate([x < 0 ? -rack_front_width / 2 : port_plate_opening_x1,
                 port_plate_mount_y(index) - seam_nut_across_flats / 2 - minimum_internal_edge_width,
                 enclosure_top_z - port_plate_nut_land_depth])
        cube([port_plate_opening_side_rail_width,
              seam_nut_across_flats + 2 * minimum_internal_edge_width,
              port_plate_nut_land_depth]);
}

module port_plate_chassis_nut_pocket_cuts() {
  for (x = [-port_plate_mount_x, port_plate_mount_x])
    for (index = [0 : rack_height_u * 3 - 1])
      translate([x, port_plate_mount_y(index),
                 enclosure_top_z - port_plate_nut_land_depth - boolean_epsilon])
        cylinder(h = seam_nut_recess_depth + boolean_epsilon,
                 d = seam_nut_circumscribed_diameter, $fn = 6);
}

module port_plate_mount_hole_cuts() {
  for (x = [-port_plate_mount_x, port_plate_mount_x])
    for (index = [0 : rack_height_u * 3 - 1])
      translate([x, port_plate_mount_y(index), enclosure_top_z - boolean_epsilon])
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
    cube([seam_tongue_insert_width + seam_socket_tip_clearance + boolean_epsilon,
          seam_socket_cavity_depth, seam_socket_cavity_height]);
}

module seam_receiver_socket(rear, top) {
  service_z0 = top ? equipment_top_z : enclosure_bottom_z;
  difference() {
    union() {
      // The exterior head wall and bay-facing nut wall close the socket in Z.
      translate([seam_receiver_x0(), seam_pad_y0(rear),
                 seam_head_layer_z0(top)])
        cube([seam_receiver_width, seam_pad_depth,
              seam_head_layer_thickness]);
      translate([seam_receiver_x0(), seam_pad_y0(rear),
                 seam_nut_layer_z0(top)])
        cube([seam_receiver_width, seam_pad_depth,
              seam_nut_layer_thickness]);

      // Front, rear, and closed-end walls leave the center-seam mouth as the
      // sole insertion path for the mating tongue.
      translate([seam_receiver_x0(), seam_pad_y0(rear), service_z0])
        cube([seam_receiver_width, seam_socket_wall_thickness,
              seam_service_zone_total_height]);
      translate([seam_receiver_x0(),
                 seam_pad_y0(rear) + seam_pad_depth - seam_socket_wall_thickness,
                 service_z0])
        cube([seam_receiver_width, seam_socket_wall_thickness,
              seam_service_zone_total_height]);
      translate([seam_receiver_x0(), seam_pad_y0(rear), service_z0])
        cube([seam_receiver_width - (seam_tongue_insert_width
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
      translate([-seam_tongue_insert_width, seam_tongue_y0(rear),
                 seam_tongue_z0(top)])
        cube([seam_tongue_insert_width + seam_tongue_root_overlap,
              seam_tongue_depth, seam_tongue_thickness]);
      // A full-height root block positively joins the tongue into the right
      // shell and front/rear service structure before the tongue enters the
      // left receiver.
      translate([0, seam_pad_y0(rear), service_z0])
        cube([seam_tongue_root_overlap, seam_pad_depth,
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

// Complete M3 locking station below the highest horizontal screen roof and
// directly against the rear wall. Each half overlaps the roof and rear wall by
// at least 3 mm; neither half projects above the roof. The nut is inserted
// through the centre-seam mouth before the right tongue slides over it, then
// the screw is driven through the flush roof-head seat.
module screen_roof_lock_through_cut() {
  translate([screen_roof_lock_screw_x, screen_roof_lock_screw_y,
             screen_roof_lock_hardware_z0 - boolean_epsilon])
    cylinder(h = screen_roof_lock_height + 2 * boolean_epsilon,
             d = seam_fastener_finished_diameter, $fn = 48);
}

module screen_roof_lock_head_cut() {
  translate([screen_roof_lock_screw_x, screen_roof_lock_screw_y,
             screen_roof_lock_top_z - seam_head_washer_recess_depth])
    cylinder(h = seam_head_washer_recess_depth + boolean_epsilon,
             d = seam_head_washer_recess_diameter, $fn = 64);
}

module screen_roof_lock_nut_cut() {
  translate([screen_roof_lock_screw_x, screen_roof_lock_screw_y,
             screen_roof_lock_hardware_z0 - boolean_epsilon])
    cylinder(h = seam_nut_recess_depth + boolean_epsilon,
             d = seam_nut_circumscribed_diameter, $fn = 6);
}

module screen_roof_lock_receiver() {
  difference() {
    translate([-seam_pad_half_width, screen_roof_lock_y0, screen_roof_lock_root_z0])
      cube([seam_pad_half_width, screen_roof_lock_depth, screen_roof_lock_total_height]);
    // Socket is open only at the centre-seam mouth; 3 mm side walls and the
    // roof-overlap root remain after all hardware cuts.
    translate([-seam_joint_cross_width, screen_roof_lock_y0 + minimum_wall_thickness,
               screen_roof_lock_hardware_z0 + seam_nut_recess_depth])
      cube([seam_joint_cross_width, screen_roof_lock_depth - 2 * minimum_wall_thickness,
            screen_roof_lock_height - seam_nut_recess_depth - seam_head_washer_recess_depth]);
    screen_roof_lock_through_cut();
    screen_roof_lock_head_cut();
    screen_roof_lock_nut_cut();
  }
}

module screen_roof_lock_tongue() {
  difference() {
    union() {
      translate([-seam_joint_cross_width, screen_roof_lock_y0 + minimum_wall_thickness + screen_roof_seam_clearance,
                 screen_roof_lock_hardware_z0 + seam_nut_recess_depth + screen_roof_seam_clearance])
        cube([seam_joint_cross_width + minimum_structural_overlap,
              screen_roof_lock_depth - 2 * (minimum_wall_thickness + screen_roof_seam_clearance),
              screen_roof_lock_height - seam_nut_recess_depth - seam_head_washer_recess_depth
              - 2 * screen_roof_seam_clearance]);
      translate([0, screen_roof_lock_y0, screen_roof_lock_root_z0])
        cube([minimum_structural_overlap, screen_roof_lock_depth, screen_roof_lock_total_height]);
    }
    screen_roof_lock_through_cut();
  }
}

module leaf_assembly_geometry(side) {
  union() {
    prepared_shell_half(side);
    for (rear = [false, true])
      for (top = [false, true]) {
        if (side < 0)
          seam_receiver_socket(rear, top);
        else
          seam_tongue(rear, top);
      }
    if (side < 0)
      screen_roof_lock_receiver();
    else
      screen_roof_lock_tongue();
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
      cube([section_thickness, main_rack_nut_land_depth + 2,
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

// Printable-leaf-only evidence: excludes the right tongue so a recess crossing
// X=0 cannot be visually hidden by the assembled union.
module left_seam_opening_pair(top = true) {
  pair_y = 13;
  crop_z0 = top ? equipment_top_z : enclosure_bottom_z;
  translate([0, pair_y - seam_fastener_y(false), -seam_fastener_z(top)])
    intersection() {
      enclosure_left_assembled();
      translate([-seam_receiver_width - 1, seam_pad_y0(false) - 1, crop_z0])
        cube([seam_receiver_width + 2, seam_pad_depth + 2, seam_pad_height]);
    }
  translate([0, -pair_y - seam_fastener_y(true), -seam_fastener_z(top)])
    intersection() {
      enclosure_left_assembled();
      translate([-seam_receiver_width - 1, seam_pad_y0(true) - 1, crop_z0])
        cube([seam_receiver_width + 2, seam_pad_depth + 2, seam_pad_height]);
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
  } else if (view_id == 23) {
    left_seam_opening_pair(top = true);
  } else {
    assert(false, str("Unknown assembly_view_id: ", view_id));
  }
}
