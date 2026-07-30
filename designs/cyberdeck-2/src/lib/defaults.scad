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
rack_hole_bottom_margin = is_undef(rack_hole_bottom_margin) ? 6.35 : rack_hole_bottom_margin;

printer_axis_limit = is_undef(printer_axis_limit) ? 220.0 : printer_axis_limit;
printer_axis_reserve = is_undef(printer_axis_reserve) ? 5.0 : printer_axis_reserve;

seam_pad_total_width = is_undef(seam_pad_total_width) ? 24.0 : seam_pad_total_width;
seam_pad_depth = is_undef(seam_pad_depth) ? 18.0 : seam_pad_depth;
seam_pad_external_height = is_undef(seam_pad_external_height) ? 13.2 : seam_pad_external_height;
seam_fastener_finished_diameter = is_undef(seam_fastener_finished_diameter) ? 3.6 : seam_fastener_finished_diameter;
seam_head_washer_recess_diameter = is_undef(seam_head_washer_recess_diameter) ? 8.25 : seam_head_washer_recess_diameter;
seam_head_washer_recess_depth = is_undef(seam_head_washer_recess_depth) ? 3.8 : seam_head_washer_recess_depth;
seam_nut_across_flats = is_undef(seam_nut_across_flats) ? 5.9 : seam_nut_across_flats;
seam_nut_recess_depth = is_undef(seam_nut_recess_depth) ? 2.8 : seam_nut_recess_depth;
seam_nut_thickness = is_undef(seam_nut_thickness) ? 2.4 : seam_nut_thickness;
seam_screw_nominal_length = is_undef(seam_screw_nominal_length) ? 20.0 : seam_screw_nominal_length;
seam_lap_engagement = is_undef(seam_lap_engagement) ? 3.0 : seam_lap_engagement;
seam_lap_root_overlap = is_undef(seam_lap_root_overlap) ? 3.0 : seam_lap_root_overlap;
seam_lap_key_height = is_undef(seam_lap_key_height) ? 9.6 : seam_lap_key_height;
seam_lap_key_depth = is_undef(seam_lap_key_depth) ? 9.6 : seam_lap_key_depth;
seam_lap_fit_clearance_per_side = is_undef(seam_lap_fit_clearance_per_side) ? 0.3 : seam_lap_fit_clearance_per_side;
boolean_epsilon = is_undef(boolean_epsilon) ? 0.02 : boolean_epsilon;

rack_clear_height = rack_u_pitch * rack_height_u;
enclosure_height = rack_clear_height + 2 * minimum_wall_thickness;
rack_rail_face_width = (rack_front_width - rack_clear_opening_width) / 2;
seam_pad_root_overlap = minimum_wall_thickness;
seam_pad_height = seam_pad_external_height + seam_pad_root_overlap;
blockout_total_height = enclosure_height + 2 * seam_pad_external_height;
rack_usable_depth_start = front_reserved_depth + front_global_service_depth;
rack_usable_depth_end = rack_internal_depth - rear_reserved_depth - rear_global_service_depth;
rack_usable_depth = rack_usable_depth_end - rack_usable_depth_start;
generic_equipment_depth = rack_usable_depth - equipment_front_fit_clearance - equipment_rear_fit_clearance;
seam_pad_half_width = seam_pad_total_width / 2;
seam_lap_pocket_height = seam_lap_key_height + 2 * seam_lap_fit_clearance_per_side;
seam_lap_pocket_depth = seam_lap_key_depth + 2 * seam_lap_fit_clearance_per_side;
seam_nut_circumscribed_diameter = seam_nut_across_flats / cos(30);
seam_head_seat_x = -seam_pad_half_width + seam_head_washer_recess_depth;
seam_nut_seated_far_x = seam_pad_half_width - (seam_nut_recess_depth - seam_nut_thickness);
seam_required_screw_length = seam_nut_seated_far_x - seam_head_seat_x;

module blockout_contract_assertions() {
  assert(minimum_wall_thickness >= 3.0,
         "STRUCTURE: wall thickness must remain at least 3 mm");
  assert(minimum_structural_overlap >= minimum_wall_thickness,
         "STRUCTURE: structural overlap must be at least wall thickness");
  assert(minimum_internal_edge_width >= minimum_wall_thickness,
         "STRUCTURE: internal edge width must be at least wall thickness");
  assert(rack_height_u == 2,
         "RACK: this blockout is exactly 2U");
  assert(abs(rack_clear_height - 88.90) < 0.001,
         "RACK: 2U clear height must be 88.90 mm");
  assert(rack_front_width > rack_clear_opening_width,
         "RACK: front width must exceed the clear opening");
  assert(rack_rail_face_width >= minimum_internal_edge_width,
         "RACK: each front rail face must meet minimum material width");
  assert(rack_equipment_width_max <= rack_clear_opening_width,
         "RACK: generic equipment proxy exceeds the clear opening");
  assert(enclosure_depth <= printer_axis_limit - printer_axis_reserve,
         "PRINT: enclosure depth exceeds the reserved printer axis");
  assert(rear_wall_thickness >= minimum_wall_thickness,
         "STRUCTURE: rear wall is below minimum thickness");
  assert(front_rail_depth >= rack_insert_hole_depth + minimum_wall_thickness,
         "FAST-M3: front rail lacks residual material behind rack inserts");
  assert(abs(rack_internal_depth - (enclosure_depth - rear_wall_thickness)) < 0.001,
         "DEPTH: rack internal depth must terminate at the rear wall");
  assert(rack_usable_depth > 0 && generic_equipment_depth > 0,
         "DEPTH: generic equipment interval must be positive");
  assert(rack_insert_finished_diameter == 4.0,
         "FAST-M3: candidate uses the selected provisional 4.0 mm insert hole");
  assert(rack_insert_hole_depth >= rack_insert_nominal_length + 2 * 0.5,
         "FAST-M3: insert hole depth must exceed insert length by two pitches");
  assert(seam_pad_total_width / 2 >= minimum_internal_edge_width,
         "SEAM: each owned half of a seam pad is too narrow");
  assert(seam_pad_depth >= 2 * minimum_internal_edge_width,
         "SEAM: coarse pad depth is too short for later fastener margins");
  assert(seam_pad_root_overlap >= minimum_structural_overlap,
         "SEAM: pad-to-shell root overlap is insufficient");
  assert(seam_lap_root_overlap >= minimum_structural_overlap,
         "SEAM: lap key root overlap is insufficient");
  assert(seam_lap_engagement >= minimum_structural_overlap,
         "SEAM: lap engagement is insufficient");
  assert((seam_lap_key_height - seam_fastener_finished_diameter) / 2
         >= minimum_internal_edge_width,
         "SEAM: lap key material around through-hole is too thin");
  assert((seam_pad_height - seam_lap_pocket_height) / 2
         >= minimum_internal_edge_width,
         "SEAM: pocket-to-pad vertical margin is too thin");
  assert((seam_pad_depth - seam_lap_pocket_depth) / 2
         >= minimum_internal_edge_width,
         "SEAM: pocket-to-pad depth margin is too thin");
  assert((seam_pad_height - seam_head_washer_recess_diameter) / 2
         >= minimum_internal_edge_width,
         "SEAM: head recess vertical margin is too thin");
  assert((seam_pad_depth - seam_head_washer_recess_diameter) / 2
         >= minimum_internal_edge_width,
         "SEAM: head recess depthwise margin is too thin");
  assert(seam_pad_half_width - seam_head_washer_recess_depth
         >= minimum_internal_edge_width,
         "SEAM: head recess leaves insufficient center-side material");
  assert(seam_pad_half_width - seam_nut_recess_depth
         >= minimum_internal_edge_width,
         "SEAM: nut recess leaves insufficient center-side material");
  assert(seam_screw_nominal_length >= seam_required_screw_length,
         "FAST-M3: selected seam screw is too short for the stack");
  assert(seam_head_seat_x + seam_screw_nominal_length <= seam_pad_half_width,
         "FAST-M3: selected seam screw protrudes outside the nut-side pad");
  assert(max(blockout_total_height, rack_front_width / 2 + seam_lap_engagement,
             enclosure_depth)
         <= printer_axis_limit,
         "PRINT: side-wall-down leaf exceeds the printer axis limit");
  children();
}
