minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? 3.0 : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? 3.0 : minimum_internal_edge_width;

rack_front_width = is_undef(rack_front_width) ? 254.0 : rack_front_width;
rack_clear_opening_width = is_undef(rack_clear_opening_width) ? 222.25 : rack_clear_opening_width;
rack_equipment_width_max = is_undef(rack_equipment_width_max) ? 220.0 : rack_equipment_width_max;
rack_u_pitch = is_undef(rack_u_pitch) ? 44.45 : rack_u_pitch;
rack_height_u = is_undef(rack_height_u) ? 2 : rack_height_u;

enclosure_depth = is_undef(enclosure_depth) ? 215.0 : enclosure_depth;
rear_wall_thickness = is_undef(rear_wall_thickness) ? minimum_wall_thickness : rear_wall_thickness;
front_rail_depth = is_undef(front_rail_depth) ? 10.0 : front_rail_depth;
rack_internal_depth = is_undef(rack_internal_depth) ? enclosure_depth - rear_wall_thickness : rack_internal_depth;
front_reserved_depth = is_undef(front_reserved_depth) ? 0.0 : front_reserved_depth;
rear_reserved_depth = is_undef(rear_reserved_depth) ? 0.0 : rear_reserved_depth;
front_global_service_depth = is_undef(front_global_service_depth) ? 0.0 : front_global_service_depth;
rear_global_service_depth = is_undef(rear_global_service_depth) ? 0.0 : rear_global_service_depth;
equipment_front_fit_clearance = is_undef(equipment_front_fit_clearance) ? 0.5 : equipment_front_fit_clearance;
equipment_rear_fit_clearance = is_undef(equipment_rear_fit_clearance) ? 0.5 : equipment_rear_fit_clearance;

rack_insert_finished_diameter = is_undef(rack_insert_finished_diameter) ? 4.0 : rack_insert_finished_diameter;
rack_insert_nominal_length = is_undef(rack_insert_nominal_length) ? 5.7 : rack_insert_nominal_length;
rack_insert_hole_depth = is_undef(rack_insert_hole_depth) ? 7.0 : rack_insert_hole_depth;
rack_insert_washer_seat_diameter = is_undef(rack_insert_washer_seat_diameter) ? 8.25 : rack_insert_washer_seat_diameter;
main_rack_mount_hole_diameter = is_undef(main_rack_mount_hole_diameter) ? M3_STACKUP_HOLE_D_V2 : main_rack_mount_hole_diameter;
rack_hole_bottom_margin = is_undef(rack_hole_bottom_margin) ? 6.35 : rack_hole_bottom_margin;

printer_axis_limit = is_undef(printer_axis_limit) ? 220.0 : printer_axis_limit;
printer_axis_reserve = is_undef(printer_axis_reserve) ? 5.0 : printer_axis_reserve;

equipment_service_zone_height = is_undef(equipment_service_zone_height) ? 13.2 : equipment_service_zone_height;
device_support_rail_thickness = is_undef(device_support_rail_thickness) ? 3.0 : device_support_rail_thickness;
device_support_rail_inboard_overlap = is_undef(device_support_rail_inboard_overlap) ? 3.0 : device_support_rail_inboard_overlap;

seam_pad_total_width = is_undef(seam_pad_total_width) ? 24.0 : seam_pad_total_width;
seam_receiver_width = is_undef(seam_receiver_width) ? 18.0 : seam_receiver_width;
seam_tongue_insert_width = is_undef(seam_tongue_insert_width) ? 14.0 : seam_tongue_insert_width;
seam_tongue_root_overlap = is_undef(seam_tongue_root_overlap) ? minimum_structural_overlap : seam_tongue_root_overlap;
seam_fastener_axis_x = is_undef(seam_fastener_axis_x) ? -8.0 : seam_fastener_axis_x;
seam_pad_depth = is_undef(seam_pad_depth) ? 18.0 : seam_pad_depth;
seam_fastener_finished_diameter = is_undef(seam_fastener_finished_diameter) ? 3.6 : seam_fastener_finished_diameter;
seam_head_washer_recess_diameter = is_undef(seam_head_washer_recess_diameter) ? 8.25 : seam_head_washer_recess_diameter;
seam_head_washer_recess_depth = is_undef(seam_head_washer_recess_depth) ? 3.8 : seam_head_washer_recess_depth;
seam_nut_across_flats = is_undef(seam_nut_across_flats) ? 5.9 : seam_nut_across_flats;
seam_nut_recess_depth = is_undef(seam_nut_recess_depth) ? 2.8 : seam_nut_recess_depth;
seam_nut_thickness = is_undef(seam_nut_thickness) ? 2.4 : seam_nut_thickness;
main_rack_nut_land_depth = is_undef(main_rack_nut_land_depth) ? seam_nut_recess_depth + minimum_structural_overlap : main_rack_nut_land_depth;
seam_screw_nominal_length = is_undef(seam_screw_nominal_length) ? 12.0 : seam_screw_nominal_length;
seam_joint_cross_width = is_undef(seam_joint_cross_width) ? 7.8 : seam_joint_cross_width;
seam_socket_wall_thickness = is_undef(seam_socket_wall_thickness) ? minimum_wall_thickness : seam_socket_wall_thickness;
seam_socket_sliding_clearance = is_undef(seam_socket_sliding_clearance) ? 1.0 : seam_socket_sliding_clearance;
seam_socket_tip_clearance = is_undef(seam_socket_tip_clearance) ? 1.0 : seam_socket_tip_clearance;
seam_tongue_thickness = is_undef(seam_tongue_thickness) ? minimum_wall_thickness : seam_tongue_thickness;
seam_tongue_depth = is_undef(seam_tongue_depth) ? 16.0 : seam_tongue_depth;
front_fascia_depth = is_undef(front_fascia_depth) ? minimum_wall_thickness : front_fascia_depth;
screen_rack_face_angle = is_undef(screen_rack_face_angle) ? 45.0 : screen_rack_face_angle;
screen_rack_rear_clearance = is_undef(screen_rack_rear_clearance) ? 50.8 : screen_rack_rear_clearance;
screen_rack_face_rail_depth = is_undef(screen_rack_face_rail_depth) ? rack_insert_hole_depth : screen_rack_face_rail_depth;
screen_rack_side_wall_thickness = is_undef(screen_rack_side_wall_thickness) ? minimum_wall_thickness : screen_rack_side_wall_thickness;
screen_rack_interface_height_u = is_undef(screen_rack_interface_height_u) ? 2 : screen_rack_interface_height_u;
screen_rack_upper_roof_thickness = is_undef(screen_rack_upper_roof_thickness) ? minimum_wall_thickness : screen_rack_upper_roof_thickness;
screen_rack_rear_wall_thickness = is_undef(screen_rack_rear_wall_thickness) ? minimum_wall_thickness : screen_rack_rear_wall_thickness;
// The high roof remains on the 45-degree screen datum.  The seam lock occupies
// the unused triangular volume directly against the rear wall below this roof.
screen_rack_upper_service_raise = is_undef(screen_rack_upper_service_raise) ? 0.0 : screen_rack_upper_service_raise;
screen_rack_upper_service_band_height = is_undef(screen_rack_upper_service_band_height) ? 18.0 : screen_rack_upper_service_band_height;
screen_rack_lower_roof_opening_start_y = is_undef(screen_rack_lower_roof_opening_start_y) ? seam_pad_depth : screen_rack_lower_roof_opening_start_y;
screen_rack_lower_roof_opening_forward_rim = is_undef(screen_rack_lower_roof_opening_forward_rim) ? minimum_wall_thickness : screen_rack_lower_roof_opening_forward_rim;
screen_rack_lower_roof_opening_side_margin = is_undef(screen_rack_lower_roof_opening_side_margin) ? minimum_wall_thickness : screen_rack_lower_roof_opening_side_margin;
screen_roof_seam_tongue_width = is_undef(screen_roof_seam_tongue_width) ? minimum_structural_overlap : screen_roof_seam_tongue_width;
screen_roof_seam_clearance = is_undef(screen_roof_seam_clearance) ? 1.0 : screen_roof_seam_clearance;
screen_roof_seam_end_margin = is_undef(screen_roof_seam_end_margin) ? minimum_wall_thickness : screen_roof_seam_end_margin;
screen_roof_lock_depth = is_undef(screen_roof_lock_depth) ? 15.0 : screen_roof_lock_depth;
screen_roof_lock_height = is_undef(screen_roof_lock_height) ? 15.0 : screen_roof_lock_height;
// The fastener block deliberately penetrates the horizontal roof by this
// structural amount.  The hardware zone remains below the roof underside.
screen_roof_lock_roof_overlap = is_undef(screen_roof_lock_roof_overlap) ? minimum_structural_overlap : screen_roof_lock_roof_overlap;
screen_mount_hole_diameter = is_undef(screen_mount_hole_diameter) ? M3_STACKUP_HOLE_D_V2 : screen_mount_hole_diameter;
port_plate_thickness = is_undef(port_plate_thickness) ? minimum_wall_thickness : port_plate_thickness;
port_plate_mount_hole_diameter = is_undef(port_plate_mount_hole_diameter) ? 3.6 : port_plate_mount_hole_diameter;
port_plate_mount_washer_diameter = is_undef(port_plate_mount_washer_diameter) ? 7.0 : port_plate_mount_washer_diameter;
port_plate_opening_side_rail_width = is_undef(port_plate_opening_side_rail_width) ? 16.0 : port_plate_opening_side_rail_width;
port_plate_opening_front_lip = is_undef(port_plate_opening_front_lip) ? minimum_wall_thickness : port_plate_opening_front_lip;
port_plate_opening_seam_margin = is_undef(port_plate_opening_seam_margin) ? minimum_wall_thickness : port_plate_opening_seam_margin;
port_plate_mount_edge_margin = is_undef(port_plate_mount_edge_margin) ? 8.0 : port_plate_mount_edge_margin;
port_plate_seam_tongue_width = is_undef(port_plate_seam_tongue_width) ? minimum_structural_overlap : port_plate_seam_tongue_width;
port_plate_seam_clearance = is_undef(port_plate_seam_clearance) ? 1.0 : port_plate_seam_clearance;
port_plate_seam_end_margin = is_undef(port_plate_seam_end_margin) ? 8.0 : port_plate_seam_end_margin;
boolean_epsilon = is_undef(boolean_epsilon) ? 0.02 : boolean_epsilon;

rack_clear_height = rack_u_pitch * rack_height_u;
rack_rail_face_width = (rack_front_width - rack_clear_opening_width) / 2;
rack_usable_depth_start = front_reserved_depth + front_global_service_depth;
rack_usable_depth_end = rack_internal_depth - rear_reserved_depth - rear_global_service_depth;
rack_usable_depth = rack_usable_depth_end - rack_usable_depth_start;
generic_equipment_depth = rack_usable_depth - equipment_front_fit_clearance - equipment_rear_fit_clearance;

equipment_bottom_z = -rack_clear_height / 2;
equipment_top_z = rack_clear_height / 2;
seam_nut_circumscribed_diameter = seam_nut_across_flats / cos(30);
// Retained only for the separately governed high screen-roof lock.
seam_pad_half_width = seam_pad_total_width / 2;
seam_head_layer_thickness = seam_head_washer_recess_depth + minimum_internal_edge_width;
seam_nut_layer_thickness = seam_nut_recess_depth + minimum_internal_edge_width
                           + 0.2;
seam_socket_cavity_height = seam_tongue_thickness + 2 * seam_socket_sliding_clearance;
seam_socket_cavity_depth = seam_tongue_depth + 2 * seam_socket_sliding_clearance;
seam_service_zone_total_height = seam_head_layer_thickness
                               + seam_socket_cavity_height
                               + seam_nut_layer_thickness;
seam_pad_height = seam_service_zone_total_height;
enclosure_height = rack_clear_height + 2 * seam_service_zone_total_height;
enclosure_bottom_z = -enclosure_height / 2;
enclosure_top_z = enclosure_height / 2;
seam_required_screw_length = seam_service_zone_total_height
                             - seam_head_washer_recess_depth
                             - (seam_nut_recess_depth - seam_nut_thickness);
seam_screw_tip_clearance_to_bay = seam_service_zone_total_height
                                  - seam_head_washer_recess_depth
                                  - seam_screw_nominal_length;

device_support_rail_inner_x = rack_equipment_width_max / 2 - device_support_rail_inboard_overlap;
device_support_rail_outer_x = rack_front_width / 2;
device_support_rail_width = device_support_rail_outer_x - device_support_rail_inner_x;
device_support_rail_bottom_z = equipment_bottom_z - device_support_rail_thickness;

// The existing closed wall at Y = enclosure_depth is the user-facing front for
// the angled-screen assembly.  The screen is therefore rooted at the open Y = 0
// end, faces +Y, and remains inside the lower receiver footprint.
screen_rack_face_height = rack_u_pitch * screen_rack_interface_height_u;
screen_rack_profile_height = screen_rack_face_height + screen_rack_upper_service_band_height;
screen_rack_face_run = screen_rack_face_height * cos(screen_rack_face_angle);
screen_rack_face_rise = screen_rack_face_height * sin(screen_rack_face_angle);
screen_rack_rear_projection_y = screen_rack_rear_clearance * cos(screen_rack_face_angle);
screen_rack_rear_projection_z = screen_rack_rear_clearance * sin(screen_rack_face_angle);
screen_rack_base_y = screen_rack_face_run + screen_rack_rear_projection_y;
screen_rack_top_z = enclosure_top_z + screen_rack_profile_height * sin(screen_rack_face_angle)
                    + screen_rack_upper_service_raise;
screen_rack_lowest_support_z = enclosure_top_z - screen_rack_rear_projection_z;
screen_rack_footprint_depth = screen_rack_base_y + screen_rack_face_rail_depth * cos(screen_rack_face_angle);
screen_rack_upper_roof_front_y = screen_rack_base_y
                                - screen_rack_profile_height * cos(screen_rack_face_angle);
screen_rack_rear_wall_bottom_z = enclosure_top_z;
screen_rack_lower_roof_opening_end_y = screen_rack_footprint_depth
                                      - screen_rack_lower_roof_opening_forward_rim;
screen_rack_lower_roof_opening_width = rack_front_width
                                     - 2 * screen_rack_lower_roof_opening_side_margin;
screen_rack_lower_roof_opening_length = screen_rack_lower_roof_opening_end_y
                                      - screen_rack_lower_roof_opening_start_y;
screen_roof_seam_y0 = screen_rack_rear_wall_thickness + screen_roof_seam_end_margin;
screen_roof_seam_y1 = screen_rack_upper_roof_front_y - screen_roof_seam_end_margin;
screen_roof_seam_length = screen_roof_seam_y1 - screen_roof_seam_y0;
screen_roof_seam_socket_width = screen_roof_seam_tongue_width + screen_roof_seam_clearance;
// The high-roof M3 station is wholly beneath the continuous exterior roof and
// begins at the rear plane.  Its 3 mm rear-wall engagement is real material,
// not a touching face or a forward-floating block.
screen_roof_lock_y0 = 0;
screen_roof_lock_y1 = screen_roof_lock_y0 + screen_roof_lock_depth;
screen_roof_lock_screw_x = -seam_nut_circumscribed_diameter / 2 + screen_roof_seam_clearance;
screen_roof_lock_screw_y = screen_roof_lock_y0 + screen_rack_rear_wall_thickness
                           + minimum_internal_edge_width
                           + seam_head_washer_recess_diameter / 2;
screen_roof_lock_root_z0 = screen_rack_top_z - screen_rack_upper_roof_thickness
                           - screen_roof_lock_height;
screen_roof_lock_hardware_z0 = screen_roof_lock_root_z0;
screen_roof_lock_top_z = screen_rack_top_z;
screen_roof_lock_total_height = screen_roof_lock_top_z - screen_roof_lock_root_z0;

// The removable blank 2U plate covers a deliberately smaller roof opening.
// It is split at X=0 into two printable leaves; the left leaf's tongue enters
// the right leaf's socket only for registration, while four M3 fasteners carry
// the removable-panel retention load into retained roof rails.
port_plate_width = rack_front_width;
port_plate_height = rack_clear_height;
port_plate_y0 = screen_rack_lower_roof_opening_end_y;
port_plate_y1 = port_plate_y0 + port_plate_height;
port_plate_opening_x0 = -rack_front_width / 2 + port_plate_opening_side_rail_width;
port_plate_opening_x1 = rack_front_width / 2 - port_plate_opening_side_rail_width;
port_plate_opening_y0 = port_plate_y0 + port_plate_opening_front_lip;
port_plate_seam_block_y0 = rack_internal_depth - seam_pad_depth;
port_plate_opening_y1 = port_plate_seam_block_y0 - port_plate_opening_seam_margin;
port_plate_opening_width = port_plate_opening_x1 - port_plate_opening_x0;
port_plate_opening_length = port_plate_opening_y1 - port_plate_opening_y0;
screen_opening_x0 = -rack_front_width / 2 + screen_rack_lower_roof_opening_side_margin;
screen_opening_x1 = rack_front_width / 2 - screen_rack_lower_roof_opening_side_margin;
opening_transition_length = is_undef(opening_transition_length) ? 18.0 : opening_transition_length;
opening_transition_y0 = port_plate_opening_y0 - opening_transition_length;
port_plate_mount_x = abs(rack_rail_column_x(1));
function port_plate_mount_y(index) = port_plate_y0 + rack_hole_z(index) + rack_clear_height / 2;
port_plate_nut_land_depth = seam_nut_recess_depth + minimum_structural_overlap;
port_plate_seam_y0 = port_plate_y0 + port_plate_seam_end_margin;
port_plate_seam_y1 = port_plate_y1 - port_plate_seam_end_margin;
port_plate_seam_length = port_plate_seam_y1 - port_plate_seam_y0;
port_plate_socket_width = port_plate_seam_tongue_width + port_plate_seam_clearance;
function screen_rack_hole_z(index) = rack_hole_z(index) - equipment_bottom_z;

module blockout_contract_assertions() {
  assert(minimum_wall_thickness >= 3.0,
         "STRUCTURE: wall thickness must remain at least 3 mm");
  assert(minimum_structural_overlap >= minimum_wall_thickness,
         "STRUCTURE: structural overlap must be at least wall thickness");
  assert(minimum_internal_edge_width >= minimum_wall_thickness,
         "STRUCTURE: internal edge width must be at least wall thickness");
  assert(rack_height_u == 2 && abs(rack_clear_height - 88.90) < 0.001,
         "RACK: receiver must preserve an exact 88.90 mm 2U envelope");
  assert(rack_rail_face_width >= minimum_internal_edge_width,
         "RACK: each front rail face must meet minimum material width");
  assert(rack_equipment_width_max <= rack_clear_opening_width,
         "RACK: generic equipment exceeds the clear opening");
  assert(enclosure_depth <= printer_axis_limit - printer_axis_reserve,
         "PRINT: enclosure depth exceeds the reserved printer axis");
  assert(enclosure_height <= printer_axis_limit - printer_axis_reserve,
         "PRINT: enclosure height exceeds the reserved printer axis");
  assert(rear_wall_thickness >= minimum_wall_thickness,
         "STRUCTURE: rear wall is below minimum thickness");
  assert(main_rack_mount_hole_diameter == M3_STACKUP_HOLE_D_V2,
         "FAST-M3: main rack mount must use the selected M3 clearance diameter");
  assert(front_rail_depth >= minimum_wall_thickness,
         "FAST-M3: main rack face rail is below the structural minimum");
  assert(main_rack_nut_land_depth >= front_rail_depth + seam_nut_recess_depth,
         "FAST-M3: main rack nut land lacks rail overlap or nut depth");
  assert((rack_rail_face_width - seam_nut_circumscribed_diameter) / 2
         >= minimum_internal_edge_width,
         "FAST-M3: main rack nut pocket lacks exterior-edge material");
  assert(rack_hole_bottom_margin - seam_nut_across_flats / 2
         >= minimum_internal_edge_width,
         "FAST-M3: lower main rack nut pocket lacks 2U aperture material");
  assert(rack_hole_z(rack_height_u * 3 - 1) + rack_clear_height / 2
         - seam_nut_across_flats / 2 >= minimum_internal_edge_width,
         "FAST-M3: upper main rack nut pocket lacks 2U aperture material");
  assert(abs(rack_internal_depth - (enclosure_depth - rear_wall_thickness)) < 0.001,
         "DEPTH: rack internal depth must terminate at the rear wall");
  assert(rack_usable_depth > 0 && generic_equipment_depth > 0,
         "DEPTH: generic equipment interval must be positive");

  assert(device_support_rail_thickness >= minimum_wall_thickness,
         "SUPPORT: lower rail thickness is below the structural minimum");
  assert(device_support_rail_inboard_overlap >= minimum_structural_overlap,
         "SUPPORT: rail does not overlap the device footprint by 3 mm");
  assert(device_support_rail_width >= 2 * minimum_wall_thickness,
         "SUPPORT: lower rail is too narrow");
  assert(device_support_rail_outer_x - (rack_front_width / 2 - minimum_wall_thickness)
         >= minimum_structural_overlap,
         "SUPPORT: rail-to-side-wall overlap is insufficient");
  assert(abs(device_support_rail_bottom_z + device_support_rail_thickness
             - equipment_bottom_z) < 0.001,
         "SUPPORT: rail top must define the 2U envelope floor");

  assert(abs(seam_service_zone_total_height
             - (equipment_service_zone_height + minimum_wall_thickness)) < 0.001,
         "SEAM: configured service zone must match the captured joint stack");
  assert(seam_socket_wall_thickness >= minimum_structural_overlap,
         "SEAM: socket walls are below the structural minimum");
  assert(seam_tongue_thickness >= minimum_structural_overlap,
         "SEAM: tongue thickness is below the structural minimum");
  assert(seam_socket_sliding_clearance >= 1.0,
         "FIT: socket clearance must provide the approved 1 mm sliding margin");
  assert(seam_socket_tip_clearance >= 1.0,
         "FIT: socket closed-end clearance must provide the approved 1 mm margin");
  assert(seam_socket_cavity_depth + 2 * seam_socket_wall_thickness
         <= seam_pad_depth,
         "SEAM: socket lacks front/rear walls around the tongue");
  assert(seam_receiver_width - (seam_tongue_insert_width + seam_socket_tip_clearance)
         >= seam_socket_wall_thickness,
         "SEAM: socket lacks a 3 mm closed end behind the tongue");
  assert(seam_tongue_root_overlap >= minimum_structural_overlap,
         "SEAM: tongue lacks a 3 mm root in its owning leaf");
  assert(seam_fastener_axis_x + seam_head_washer_recess_diameter / 2
         <= -minimum_internal_edge_width,
         "SEAM: head recess crosses the printable split edge");
  assert(seam_fastener_axis_x - seam_head_washer_recess_diameter / 2
         >= -seam_receiver_width + minimum_internal_edge_width,
         "SEAM: head recess lacks left receiver exterior material");
  assert(seam_fastener_axis_x + seam_nut_circumscribed_diameter / 2
         <= -minimum_internal_edge_width,
         "SEAM: nut recess crosses the printable split edge");
  assert(seam_fastener_axis_x - seam_nut_circumscribed_diameter / 2
         >= -seam_receiver_width + minimum_internal_edge_width,
         "SEAM: nut recess lacks left receiver exterior material");
  assert(seam_fastener_axis_x - seam_fastener_finished_diameter / 2
         >= -seam_tongue_insert_width + minimum_internal_edge_width,
         "SEAM: tongue through-passage lacks closed-end material");
  assert(seam_fastener_axis_x + seam_fastener_finished_diameter / 2
         <= -minimum_internal_edge_width,
         "SEAM: tongue through-passage lacks split-edge material");
  assert(front_fascia_depth >= minimum_structural_overlap,
         "FRONT: fascia depth is below the structural minimum");
  assert(front_rail_depth >= minimum_structural_overlap,
         "FRONT: main rack rails lack full fascia overlap");
  assert(seam_head_layer_thickness - seam_head_washer_recess_depth
         >= minimum_internal_edge_width,
         "SEAM: recessed head lacks residual material");
  assert(seam_nut_layer_thickness - seam_nut_recess_depth
         >= minimum_internal_edge_width,
         "SEAM: captive nut lacks residual material");
  assert((seam_pad_depth - seam_head_washer_recess_diameter) / 2
         >= minimum_internal_edge_width,
         "SEAM: head recess depthwise margin is too thin");
  assert((seam_pad_depth - seam_nut_circumscribed_diameter) / 2
         >= minimum_internal_edge_width,
         "SEAM: nut recess depthwise margin is too thin");
  assert(seam_screw_nominal_length >= seam_required_screw_length,
         "FAST-M3: selected vertical seam screw is too short for the stack");
  assert(seam_screw_tip_clearance_to_bay >= 0,
         "FAST-M3: selected vertical seam screw protrudes into the 2U bay");
  assert(screen_rack_interface_height_u == 2
         && abs(screen_rack_face_height - rack_clear_height) < 0.001,
         "SCREEN: angled screen interface must retain the exact 2U face height");
  assert(abs(screen_rack_face_angle - 45.0) < 0.001,
         "SCREEN: screen face must remain at 45 degrees");
  assert(screen_rack_rear_clearance <= 50.8,
         "SCREEN: behind-screen normal envelope exceeds the approved 50.8 mm");
  assert(screen_mount_hole_diameter == M3_STACKUP_HOLE_D_V2,
         "SCREEN: through-mount holes must use the selected M3 clearance diameter");
  assert(screen_rack_face_rail_depth >= minimum_wall_thickness,
         "SCREEN: face rails are below the structural minimum");
  assert(screen_rack_upper_service_band_height >= 18.0,
         "SCREEN: upper service band must provide the approved 18 mm minimum");
  assert(screen_rack_side_wall_thickness >= minimum_wall_thickness,
         "SCREEN: side support walls are below the structural minimum");
  assert(screen_rack_upper_roof_thickness >= minimum_structural_overlap,
         "SCREEN: upper roof is below the structural minimum");
  assert(screen_roof_seam_tongue_width >= minimum_structural_overlap,
         "SCREEN-ROOF: seam tongue overlap is below the structural minimum");
  assert(screen_roof_seam_clearance >= 1.0,
         "SCREEN-ROOF: seam socket requires 1 mm assembly clearance");
  assert(screen_roof_seam_length >= minimum_internal_edge_width,
         "SCREEN-ROOF: seam engagement is not meaningful");
  assert(screen_roof_lock_depth >= seam_head_washer_recess_depth
         + seam_nut_recess_depth + 2 * minimum_wall_thickness,
         "SCREEN-ROOF: M3 lock lacks head/nut closure walls");
  assert(screen_roof_lock_screw_y - seam_head_washer_recess_diameter / 2
         - screen_rack_rear_wall_thickness >= minimum_internal_edge_width,
         "SCREEN-ROOF: M3 head seat lacks rear-wall clearance");
  assert(screen_rack_upper_roof_front_y - (screen_roof_lock_screw_y
         + seam_head_washer_recess_diameter / 2) >= minimum_internal_edge_width,
         "SCREEN-ROOF: M3 head seat lacks forward roof clearance");
  assert(screen_roof_lock_height - seam_head_washer_recess_diameter
         >= 2 * minimum_internal_edge_width,
         "SCREEN-ROOF: M3 lock lacks vertical material around washer seat");
  assert(screen_roof_lock_roof_overlap >= minimum_structural_overlap,
         "SCREEN-ROOF: M3 lock must overlap the high roof structurally");
  assert(screen_rack_upper_service_raise == 0,
         "SCREEN-ROOF: roof must remain on the fixed 45-degree screen datum");
  assert(screen_roof_lock_y0 <= screen_rack_rear_wall_thickness
         - minimum_structural_overlap,
         "SCREEN-ROOF: lock must overlap the rear wall by at least 3 mm");
  assert(screen_roof_lock_y1 <= screen_rack_upper_roof_front_y
         - minimum_internal_edge_width,
         "SCREEN-ROOF: top lock cuts into the forward roof edge");
  assert(screen_roof_lock_screw_x - seam_head_washer_recess_diameter / 2
         >= -seam_pad_half_width + minimum_internal_edge_width,
         "SCREEN-ROOF: top lock head seat lacks left exterior ligament");
  assert(screen_roof_lock_screw_x + seam_nut_circumscribed_diameter / 2 >= 0,
         "SCREEN-ROOF: captive nut needs an open centre-seam insertion path");
  assert(screen_rack_upper_roof_thickness >= minimum_wall_thickness,
         "SCREEN-ROOF: interlock must not reduce the roof underside clearance");
  assert(screen_rack_rear_wall_thickness >= minimum_structural_overlap,
         "SCREEN: rear wall is below the structural minimum");
  assert(screen_rack_face_run >= minimum_structural_overlap
         && screen_rack_face_rise >= minimum_structural_overlap,
         "SCREEN: 45-degree face projections must be structural");
  assert(screen_rack_lowest_support_z <= enclosure_top_z - minimum_structural_overlap,
         "SCREEN: side supports do not positively overlap the base side walls");
  assert(screen_rack_base_y - screen_rack_face_run - screen_rack_rear_projection_y >= -0.001,
         "SCREEN: rear screen envelope placement is inconsistent");
  assert(screen_rack_base_y - screen_rack_face_run - screen_rack_rear_projection_y < 0.001,
         "SCREEN: rear screen envelope must reach, but not project past, Y = 0");
  assert(screen_rack_footprint_depth <= enclosure_depth,
         "SCREEN: angled screen projects past the lower receiver footprint");
  assert(screen_rack_upper_roof_front_y >= screen_rack_rear_wall_thickness,
         "SCREEN: upper roof cannot engage the rear wall by 3 mm");
  assert(screen_rack_lower_roof_opening_start_y >= seam_pad_depth,
         "SCREEN: lower roof opening cuts into the rear seam screw-block zone");
  assert(screen_rack_lower_roof_opening_end_y
         <= screen_rack_footprint_depth - minimum_internal_edge_width,
         "SCREEN: lower roof lacks the forward structural rim beneath the screen");
  assert(screen_rack_lower_roof_opening_length >= minimum_internal_edge_width,
         "SCREEN: lower roof opening is not a meaningful opening");
  assert(opening_transition_y0 - screen_rack_lower_roof_opening_start_y
         >= minimum_internal_edge_width,
         "ROOF: screen-side segment of the continuous opening is not meaningful");
  assert(screen_rack_lower_roof_opening_side_margin >= minimum_internal_edge_width,
         "SCREEN: lower roof opening leaves insufficient side-wall material");
  assert(screen_rack_lower_roof_opening_width > rack_clear_opening_width,
         "SCREEN: lower roof opening must clear the screen aperture width");
  assert(port_plate_thickness >= minimum_wall_thickness,
         "PORT-PLATE: plate thickness is below the 3 mm minimum");
  assert(abs(port_plate_width - rack_front_width) < 0.001
         && abs(port_plate_height - rack_clear_height) < 0.001,
         "PORT-PLATE: exterior must retain the exact 254 x 88.90 mm 2U envelope");
  assert(port_plate_opening_side_rail_width >= minimum_internal_edge_width,
         "PORT-PLATE: retained side rail is below minimum material width");
  assert(port_plate_opening_front_lip >= minimum_internal_edge_width,
         "PORT-PLATE: retained front lip is below minimum material width");
  assert(port_plate_opening_seam_margin >= minimum_internal_edge_width,
         "PORT-PLATE: opening-to-seam-block margin is below minimum material width");
  assert(port_plate_opening_length >= minimum_internal_edge_width,
         "PORT-PLATE: roof opening is not meaningful");
  assert(port_plate_y1 < seam_fastener_y(true) - seam_head_washer_recess_diameter / 2,
         "PORT-PLATE: plate covers the rear seam screw head/tool envelope");
  assert(port_plate_opening_y1 <= port_plate_seam_block_y0 - minimum_internal_edge_width,
         "PORT-PLATE: opening cuts into the protected rear seam block");
  assert(port_plate_mount_hole_diameter == M3_STACKUP_HOLE_D_V2,
         "PORT-PLATE: mounting clearance must use the selected M3 stack-up hole");
  assert(port_plate_mount_washer_diameter >= M3_ISO_7089_WASHER_OD_V2,
         "PORT-PLATE: washer support is below ISO 7089 M3 outside diameter");
  assert(port_plate_mount_x + seam_nut_circumscribed_diameter / 2
         <= rack_front_width / 2 - minimum_internal_edge_width,
         "PORT-PLATE: M3 nut land lacks exterior-edge material");
  assert(port_plate_mount_x - seam_nut_circumscribed_diameter / 2
         >= port_plate_opening_x1 + minimum_internal_edge_width,
         "PORT-PLATE: M3 nut land lacks material to the roof opening");
  assert(opening_transition_length >= minimum_structural_overlap,
         "ROOF: continuous opening transition is below structural minimum");
  for (index = [0 : rack_height_u * 3 - 1]) {
    assert(port_plate_mount_y(index) - seam_nut_across_flats / 2
           >= port_plate_y0 + minimum_internal_edge_width,
           "PORT-PLATE: end nut land lacks front-edge material");
    assert(port_plate_y1 - (port_plate_mount_y(index) + seam_nut_across_flats / 2)
           >= minimum_internal_edge_width,
           "PORT-PLATE: end nut land lacks rear-edge material");
  }
  assert(port_plate_seam_tongue_width >= minimum_structural_overlap,
         "PORT-PLATE: registration tongue overlap is below structural minimum");
  assert(port_plate_seam_clearance >= 1.0,
         "PORT-PLATE: registration socket requires 1 mm sliding clearance");
  assert(port_plate_seam_length >= minimum_internal_edge_width,
         "PORT-PLATE: registration seam is not meaningful");
  assert(screen_rack_top_z - enclosure_bottom_z <= printer_axis_limit,
         "PRINT: angled screen makes the rotated leaf exceed the printer axis");
  assert(max(enclosure_height, rack_front_width / 2 + seam_joint_cross_width,
             enclosure_depth) <= printer_axis_limit,
         "PRINT: side-wall-down leaf exceeds the printer axis limit");
  children();
}
