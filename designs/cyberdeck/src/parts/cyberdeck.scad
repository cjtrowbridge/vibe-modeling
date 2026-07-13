// First-draft cyberdeck visual mockup.
//
// This is intentionally a layout study, not a printable enclosure. It uses
// real dimensions where they are known from the design brief and clearly named
// proxy volumes where exact hardware drawings are still needed.

function deck_top_z() = deck_h;
function front_y() = -deck_y / 2;
function back_y() = deck_y / 2;
function left_x() = -deck_x / 2;
function right_x() = deck_x / 2;
function display_visual_x() =
  display_show_rack_rails ? display_rail_x : display_active_x + 2 * display_bezel_margin;
function display_visual_y() =
  display_show_rack_rails ? display_rail_y : display_active_y + 2 * display_bezel_margin;
function display_left_x() = display_center_x - display_visual_x() / 2;
function display_right_x() = display_center_x + display_visual_x() / 2;
function display_top_y() = display_center_y + display_visual_y() / 2;
function display_bottom_y() = display_center_y - display_visual_y() / 2;
function keyboard_top_y() = keyboard_center_y + keyboard_unfolded_y / 2;
function eye_dome_layout_d() = eye_dome_d + eye_base_ring_w;
function eye_dome_left_x() = eye_center_x - eye_dome_layout_d() / 2;
function eye_dome_right_x() = eye_center_x + eye_dome_layout_d() / 2;
function eye_dome_bottom_y() = eye_center_y - eye_dome_layout_d() / 2;
function toggle_col(i) = i % toggle_columns;
function toggle_row(i) = floor(i / toggle_columns);
function toggle_rows() = ceil(toggle_count / toggle_columns);
function toggle_x(i) =
  toggle_bank_center_x
  + (toggle_col(i) - (toggle_columns - 1) / 2) * toggle_spacing_x;
function toggle_y(i) =
  toggle_bank_center_y
  - (toggle_row(i) - (toggle_rows() - 1) / 2) * toggle_spacing_y;
function toggle_bank_top_y() =
  toggle_bank_center_y + (toggle_rows() - 1) * toggle_spacing_y / 2 + toggle_plate_y / 2;
function toggle_bank_bottom_y() =
  toggle_bank_center_y - (toggle_rows() - 1) * toggle_spacing_y / 2 - toggle_plate_y / 2 - 8;
function exhaust_slot_pitch() = opi_exhaust_slot_w + opi_exhaust_slot_gap;
function exhaust_total_x() =
  opi_exhaust_slot_count * opi_exhaust_slot_w
  + (opi_exhaust_slot_count - 1) * opi_exhaust_slot_gap;
function cell_pitch() = cell18650_d + 2.5;
function chamber_total_z() = chamber_bottom + chamber_internal_clearance_z;
function chamber_legacy_assembly_left_x() = -chamber_piece_x;
function chamber_assembly_right_x() = chamber_piece_x;
function chamber_display_wedge_right_x() = chamber_assembly_right_x();
function chamber_display_wedge_left_x() =
  chamber_display_wedge_right_x() - chamber_display_wedge_x;
function chamber_assembly_left_x() =
  compact_body_enabled
    ? chamber_display_wedge_left_x()
    : chamber_legacy_assembly_left_x();
function chamber_display_wedge_center_x() =
  (chamber_display_wedge_left_x() + chamber_display_wedge_right_x()) / 2;
function chamber_left_flat_area_x() =
  chamber_display_wedge_left_x() - chamber_assembly_left_x();
function chamber_dome_roof_left_x() = chamber_assembly_left_x();
function chamber_dome_roof_right_x() = chamber_display_wedge_left_x();
function chamber_dome_roof_back_y() = chamber_piece_y / 2;
function chamber_dome_roof_front_y() = chamber_dome_roof_back_y() - chamber_dome_area_y;
function chamber_dome_roof_center_x() =
  (chamber_dome_roof_left_x() + chamber_dome_roof_right_x()) / 2;
function chamber_dome_roof_center_y() =
  (chamber_dome_roof_front_y() + chamber_dome_roof_back_y()) / 2;
function chamber_dome_mount_screw_xy_offset() =
  chamber_dome_mount_screw_radius / sqrt(2);
function chamber_profile_peak_z() = chamber_total_z() + chamber_profile_peak_rise;
function chamber_profile_peak_y() =
  chamber_piece_y / 2 - chamber_rear_housing_depth;
function chamber_profile_screen_foot_y() =
  chamber_profile_peak_y() - chamber_profile_screen_slope_run;
function chamber_profile_screen_face_len() =
  sqrt(
    chamber_profile_peak_rise * chamber_profile_peak_rise
    + chamber_profile_screen_slope_run * chamber_profile_screen_slope_run
  );
function chamber_profile_screen_face_angle() =
  atan(chamber_profile_peak_rise / chamber_profile_screen_slope_run);
function chamber_display_void_center_y() =
  (chamber_profile_screen_foot_y() + chamber_profile_peak_y()) / 2;
function chamber_display_void_center_z() =
  (chamber_total_z() + chamber_profile_peak_z()) / 2;
function chamber_control_band_front_y() =
  chamber_keyboard_lid_back_edge_y;
function chamber_control_band_back_y() =
  chamber_profile_screen_foot_y();
function chamber_power_cell_rear_x() =
  (chamber_display_wedge_left_x() + 0) / 2;
function chamber_power_cell_rear_z() =
  chamber_total_z() / 2;
function chamber_power_cell_rear_wall_center_y() =
  chamber_piece_y / 2 - chamber_wall / 2;
function chamber_power_cell_rear_cut_depth() =
  chamber_wall + 1.2;
function chamber_power_cell_rear_label_center_z() =
  minimum_internal_edge_width
  + chamber_power_cell_rear_label_size / 2
  + chamber_power_cell_rear_label_line_gap / 2;
function handle_half_length() = handle_length / 2;
function handle_plate_center_z() = handle_mount_plate_size / 2;
function handle_plate_outer_x() = -handle_mount_plate_thickness;
function handle_plate_inner_x() = 0;
function handle_grip_center_x() = -(handle_standoff - handle_bar_d / 2);
function handle_bevel_inner_x() =
  handle_plate_outer_x() + handle_mount_overlap;
function handle_bevel_outer_x() =
  handle_plate_outer_x() - handle_mount_bevel_len;
function handle_chamber_mount_center_z() =
  chamber_total_z() / 2;
function handle_mount_plate_center_y(i) =
  i == 0 ? -handle_half_length() : handle_half_length();
function handle_mount_screw_y(i, sy) =
  handle_mount_plate_center_y(i) + sy * handle_mount_screw_spacing / 2;
function handle_chamber_mount_screw_z(sz) =
  handle_chamber_mount_center_z() + sz * handle_mount_screw_spacing / 2;
function chamber_display_void_cut_overlap() = chamber_wall + 0.6;
function chamber_display_mount_screw_y(face_offset) =
  chamber_display_void_center_y()
  + face_offset * chamber_profile_screen_slope_run / chamber_profile_screen_face_len();
function chamber_display_mount_screw_z(face_offset) =
  chamber_display_void_center_z()
  + face_offset * chamber_profile_peak_rise / chamber_profile_screen_face_len();
function chamber_display_mount_rear_screw_y() =
  chamber_display_mount_screw_y(chamber_display_mount_screw_face_spacing / 2);
function chamber_keyboard_lid_rail_top_z() =
  chamber_total_z() - chamber_keyboard_lid_inset;
function chamber_flat_lid_internal_clearance_z() =
  chamber_keyboard_lid_rail_top_z() - chamber_bottom;
function chamber_keyboard_lid_rail_center_z() =
  chamber_keyboard_lid_rail_top_z() - chamber_keyboard_lid_rail_h / 2;
function chamber_keyboard_lid_front_edge_y() =
  -chamber_piece_y / 2 + chamber_wall;
function chamber_lid_front_y() =
  chamber_keyboard_lid_front_edge_y() + chamber_lid_clearance;
function chamber_lid_right_back_y() =
  chamber_keyboard_lid_back_edge_y - chamber_lid_clearance;
function chamber_lid_left_back_y() =
  chamber_keyboard_lid_left_back_edge_y - chamber_lid_clearance;
function chamber_io_panel_opening_front_y() =
  chamber_profile_peak_y() + chamber_io_panel_screen_border;
function chamber_io_panel_opening_back_y() =
  chamber_piece_y / 2 - chamber_io_panel_screen_border;
function chamber_io_panel_front_y() =
  chamber_io_panel_opening_front_y() + chamber_lid_clearance;
function chamber_io_panel_back_y() =
  chamber_io_panel_opening_back_y() - chamber_lid_clearance;
function chamber_right_lid_back_y() =
  chamber_lid_right_back_y();
function chamber_left_lid_xa() =
  chamber_assembly_left_x() + chamber_wall + chamber_lid_clearance;
function chamber_left_lid_xb() =
  chamber_dome_roof_right_x() - chamber_wall - chamber_lid_clearance;
function chamber_center_lid_xa() =
  chamber_dome_roof_right_x() + chamber_wall + chamber_lid_clearance;
function chamber_center_lid_xb() =
  -chamber_wall - chamber_lid_clearance;
function chamber_right_lid_xa() =
  chamber_wall + chamber_lid_clearance;
function chamber_right_lid_xb() =
  chamber_assembly_right_x() - chamber_wall - chamber_lid_clearance;
function chamber_lid_w(xa, xb) = xb - xa;
function chamber_lid_d(yf, yb) = yb - yf;
function chamber_left_lid_w() = chamber_lid_w(chamber_left_lid_xa(), chamber_left_lid_xb());
function chamber_center_lid_w() = chamber_lid_w(chamber_center_lid_xa(), chamber_center_lid_xb());
function chamber_right_lid_w() = chamber_lid_w(chamber_right_lid_xa(), chamber_right_lid_xb());
function chamber_left_lid_d() = chamber_lid_d(chamber_lid_front_y(), chamber_lid_left_back_y());
function chamber_main_lid_d() = chamber_lid_d(chamber_lid_front_y(), chamber_lid_right_back_y());
function chamber_right_lid_d() = chamber_lid_d(chamber_lid_front_y(), chamber_right_lid_back_y());
function chamber_io_panel_xa() =
  chamber_display_wedge_left_x() + chamber_wall + chamber_lid_clearance;
function chamber_io_panel_xb() =
  chamber_display_wedge_right_x() - chamber_wall - chamber_lid_clearance;
function chamber_io_panel_opening_xa() =
  chamber_io_panel_xa() - chamber_lid_clearance;
function chamber_io_panel_opening_xb() =
  chamber_io_panel_xb() + chamber_lid_clearance;
function chamber_io_panel_w() = chamber_lid_w(chamber_io_panel_xa(), chamber_io_panel_xb());
function chamber_io_panel_opening_w() =
  chamber_io_panel_opening_xb() - chamber_io_panel_opening_xa();
function chamber_io_panel_opening_d() =
  chamber_io_panel_opening_back_y() - chamber_io_panel_opening_front_y();
function chamber_io_panel_center_x() =
  (chamber_io_panel_xa() + chamber_io_panel_xb()) / 2;
function chamber_io_panel_center_y() =
  (chamber_io_panel_front_y() + chamber_io_panel_back_y()) / 2;
function chamber_io_panel_seat_z() =
  chamber_profile_peak_z() - chamber_keyboard_lid_inset;
function chamber_io_panel_frame_bottom_z() =
  chamber_profile_peak_z() - chamber_io_panel_frame_h;
function chamber_io_panel_through_xa() =
  chamber_io_panel_xa() + chamber_io_panel_support_w;
function chamber_io_panel_through_xb() =
  chamber_io_panel_xb() - chamber_io_panel_support_w;
function chamber_io_panel_through_front_y() =
  chamber_io_panel_front_y() + chamber_io_panel_support_w;
function chamber_io_panel_through_back_y() =
  chamber_io_panel_back_y() - chamber_io_panel_support_w;
function chamber_io_bulkhead_front_y() =
  chamber_io_panel_front_y();
function chamber_io_bulkhead_back_y() =
  chamber_piece_y / 2;
function chamber_io_bulkhead_top_z() =
  chamber_io_panel_seat_z();
function chamber_io_bulkhead_front_lower_z() =
  chamber_io_panel_frame_bottom_z();
function chamber_io_bulkhead_lower_z(y) =
  chamber_io_bulkhead_front_lower_z()
  - (y - chamber_io_bulkhead_front_y());
function chamber_io_bulkhead_rear_lower_z() =
  chamber_io_bulkhead_lower_z(chamber_io_bulkhead_back_y());
function chamber_io_bulkhead_screen_ligament() =
  chamber_screen_face_tangent_position(
    chamber_io_bulkhead_front_y(),
    chamber_io_bulkhead_front_lower_z()
  ) - chamber_display_void_h / 2;
function chamber_io_bulkhead_bolt_y(i) =
  chamber_io_bulkhead_front_y()
  + (
    i == 0
      ? chamber_io_bulkhead_front_bolt_offset_y
      : chamber_io_bulkhead_rear_bolt_offset_y
  );
function chamber_io_bulkhead_bolt_z(i) =
  chamber_io_bulkhead_top_z()
  - (
    i == 0
      ? chamber_io_bulkhead_front_bolt_drop_z
      : chamber_io_bulkhead_rear_bolt_drop_z
  );
function chamber_io_bulkhead_bolt_top_ligament(i) =
  chamber_io_bulkhead_top_z()
  - chamber_io_bulkhead_bolt_z(i)
  - chamber_io_bulkhead_bolt_clearance_d / 2;
function chamber_io_bulkhead_bolt_front_ligament(i) =
  chamber_io_bulkhead_bolt_y(i)
  - chamber_io_bulkhead_front_y()
  - chamber_io_bulkhead_bolt_clearance_d / 2;
function chamber_io_bulkhead_bolt_back_ligament(i) =
  chamber_io_bulkhead_back_y()
  - chamber_io_bulkhead_bolt_y(i)
  - chamber_io_bulkhead_bolt_clearance_d / 2;
function chamber_io_bulkhead_bolt_lower_ligament(i) =
  (
    chamber_io_bulkhead_bolt_z(i)
    - chamber_io_bulkhead_lower_z(chamber_io_bulkhead_bolt_y(i))
  ) / sqrt(2)
  - chamber_io_bulkhead_bolt_clearance_d / 2;
function chamber_io_bulkhead_cut_ligament(global_cut_x, cut_d) =
  abs(global_cut_x)
  - chamber_io_bulkhead_wall
  - cut_d / 2;
function chamber_io_panel_print_span_45() =
  (chamber_io_panel_w() + chamber_io_panel_d) / sqrt(2);
function chamber_io_panel_usb_c_x() =
  chamber_io_panel_usb_c_label_x()
  - chamber_io_panel_neural_label_w() / 2
  - chamber_io_panel_label_mount_margin
  - chamber_control_usb_c_jack_d / 2;
function chamber_io_panel_usb_c_y() = 0;
function chamber_io_panel_usb_c_label_x() =
  chamber_io_panel_w() / 2
  - chamber_io_panel_label_edge_margin
  - chamber_io_panel_neural_label_w() / 2;
function chamber_io_panel_usb_a_y() = 0;
function chamber_io_panel_rotated_label_thickness() =
  chamber_io_panel_label_size
  * chamber_io_panel_rotated_label_thickness_per_size;
function chamber_io_panel_usb_a_left_label_x() =
  chamber_io_panel_usb_a_left_x
  - chamber_io_panel_usb_a_outer_d / 2
  - chamber_io_panel_label_mount_margin
  - chamber_io_panel_rotated_label_thickness() / 2;
function chamber_io_panel_usb_a_right_label_x() =
  chamber_io_panel_usb_a_right_x
  + chamber_io_panel_usb_a_outer_d / 2
  + chamber_io_panel_label_mount_margin
  + chamber_io_panel_rotated_label_thickness() / 2;
function chamber_io_panel_raspberry_length() =
  chamber_io_panel_label_size
  * chamber_io_panel_raspberry_width_per_size;
function chamber_io_panel_neural_label_w() =
  chamber_io_panel_label_size
  * chamber_io_panel_neural_width_per_size;
function chamber_io_panel_horizontal_label_h() =
  chamber_io_panel_label_size
  * chamber_io_panel_horizontal_label_height_per_size;
function chamber_io_panel_two_line_label_h() =
  chamber_io_panel_label_line_gap
  + chamber_io_panel_horizontal_label_h();
function chamber_io_panel_switch_notch_depth() =
  chamber_io_panel_switch_keyed_span_x - chamber_io_panel_switch_mount_d;
function chamber_io_panel_switch_cut_right_radius() =
  chamber_io_panel_switch_mount_d / 2
  + chamber_io_panel_switch_notch_depth();
function chamber_io_panel_switch_outer_radius() =
  chamber_io_panel_switch_outer_d / 2;
function chamber_io_panel_switch_global_x(x) =
  chamber_io_panel_center_x() + x;
function chamber_io_panel_switch_global_y(y) =
  chamber_io_panel_center_y() + y;
function chamber_io_panel_switch_panel_x_ligament(x) =
  chamber_io_panel_w() / 2
  - abs(x)
  - chamber_io_panel_switch_outer_radius();
function chamber_io_panel_switch_panel_y_ligament(y) =
  chamber_io_panel_d / 2
  - abs(y)
  - chamber_io_panel_switch_outer_radius();
function chamber_io_panel_switch_support_left_ligament(x) =
  chamber_io_panel_switch_global_x(x)
  - chamber_io_panel_switch_outer_radius()
  - chamber_io_panel_through_xa();
function chamber_io_panel_switch_support_right_ligament(x) =
  chamber_io_panel_through_xb()
  - chamber_io_panel_switch_global_x(x)
  - chamber_io_panel_switch_outer_radius();
function chamber_io_panel_switch_support_front_ligament(y) =
  chamber_io_panel_switch_global_y(y)
  - chamber_io_panel_switch_outer_radius()
  - chamber_io_panel_through_front_y();
function chamber_io_panel_switch_support_back_ligament(y) =
  chamber_io_panel_through_back_y()
  - chamber_io_panel_switch_global_y(y)
  - chamber_io_panel_switch_outer_radius();
function chamber_io_panel_switch_bulkhead_ligament(x) =
  abs(chamber_io_panel_switch_global_x(x))
  - chamber_io_bulkhead_wall
  - chamber_io_panel_switch_cut_right_radius();
function chamber_io_panel_switch_pair_ligament() =
  abs(chamber_io_panel_switch_uv_x - chamber_io_panel_switch_fans_x)
  - chamber_io_panel_switch_outer_d;
function chamber_io_panel_hardware_x_ligament(left_x, left_d, right_x, right_d) =
  right_x - left_x - left_d / 2 - right_d / 2;
function chamber_io_panel_usb_a_neural_jack_ligament() =
  chamber_io_panel_hardware_x_ligament(
    chamber_io_panel_usb_a_right_x,
    chamber_io_panel_usb_a_outer_d,
    chamber_io_panel_usb_c_x(),
    chamber_control_usb_c_jack_d
  );
function chamber_io_panel_switch_to_corner_screw_ligament(x, y, sx, sy) =
  sqrt(
    pow(sx * (chamber_io_panel_w() / 2 - chamber_lid_mount_inset) - x, 2)
    + pow(sy * (chamber_io_panel_d / 2 - chamber_lid_mount_inset) - y, 2)
  )
  - chamber_lid_mount_screw_head_d / 2
  - chamber_io_panel_switch_outer_radius();
function chamber_io_panel_switch_to_round_hardware_ligament(
  switch_x,
  switch_y,
  hardware_x,
  hardware_y,
  hardware_d
) =
  sqrt(
    pow(switch_x - hardware_x, 2)
    + pow(switch_y - hardware_y, 2)
  )
  - chamber_io_panel_switch_outer_radius()
  - hardware_d / 2;
function chamber_io_panel_switch_label_h() =
  chamber_io_panel_switch_label_size
  * chamber_io_panel_horizontal_label_height_per_size;
function chamber_io_panel_switch_fans_label_w() =
  chamber_io_panel_switch_label_size
  * chamber_io_panel_switch_fans_width_per_size;
function chamber_io_panel_switch_uv_label_w() =
  chamber_io_panel_switch_label_size
  * chamber_io_panel_switch_uv_width_per_size;
function chamber_io_panel_switch_raspberry_label_w() =
  chamber_io_panel_switch_label_size
  * chamber_io_panel_switch_raspberry_width_per_size;
function chamber_io_panel_switch_orange_label_w() =
  chamber_io_panel_switch_label_size
  * chamber_io_panel_switch_orange_width_per_size;
function chamber_io_panel_switch_label_edge_ligament(x, label_w) =
  chamber_io_panel_w() / 2 - abs(x) - label_w / 2;
function chamber_io_panel_switch_label_y_edge_ligament() =
  chamber_io_panel_d / 2
  - abs(chamber_io_panel_switch_label_y)
  - chamber_io_panel_switch_label_h() / 2;
function chamber_io_panel_switch_label_to_switch_ligament() =
  abs(chamber_io_panel_switch_label_y - chamber_io_panel_switch_y)
  - chamber_io_panel_switch_label_h() / 2
  - chamber_io_panel_switch_outer_radius();
function chamber_center_lid_ptt_x_pos() =
  chamber_center_lid_ptt_x;
function chamber_center_lid_ptt_y_pos() =
  chamber_center_lid_ptt_y;
function chamber_center_lid_usb_a_x_pos() =
  chamber_center_lid_usb_a_x;
function chamber_center_lid_usb_a_y_pos() =
  chamber_center_lid_usb_a_y;
function chamber_center_lid_control_label_w() =
  chamber_io_panel_label_size
  * chamber_center_lid_control_label_width_per_size;
function chamber_center_lid_control_label_h() =
  chamber_io_panel_horizontal_label_h();
function chamber_center_lid_ptt_support_clearance_d() =
  chamber_arcade_button_outer_d
  + chamber_center_lid_support_fit_clearance_d;
function chamber_center_lid_usb_support_clearance_d() =
  chamber_io_panel_usb_a_outer_d
  + chamber_center_lid_support_fit_clearance_d;
function chamber_center_lid_installed_envelope_gap() =
  chamber_center_lid_ptt_y_pos()
  - chamber_arcade_button_outer_d / 2
  - (
    chamber_center_lid_usb_a_y_pos()
    + chamber_io_panel_usb_a_outer_d / 2
  );
function chamber_center_lid_ptt_to_label_gap() =
  chamber_center_lid_ptt_y_pos()
  - chamber_arcade_button_outer_d / 2
  - (
    chamber_center_lid_control_label_y
    + chamber_center_lid_control_label_h() / 2
  );
function chamber_center_lid_label_to_usb_gap() =
  chamber_center_lid_control_label_y
  - chamber_center_lid_control_label_h() / 2
  - (
    chamber_center_lid_usb_a_y_pos()
    + chamber_io_panel_usb_a_outer_d / 2
  );
function chamber_center_lid_hardware_to_corner_screw_gap(
  hardware_x,
  hardware_y,
  hardware_outer_d,
  sx,
  sy
) =
  sqrt(
    pow(
      sx * (chamber_center_lid_w() / 2 - chamber_lid_mount_inset)
      - hardware_x,
      2
    )
    + pow(
      sy * (chamber_main_lid_d() / 2 - chamber_lid_mount_inset)
      - hardware_y,
      2
    )
  )
  - chamber_lid_mount_screw_head_d / 2
  - hardware_outer_d / 2;
function chamber_center_lid_support_cut_to_screw_ligament(
  hardware_x,
  hardware_y,
  support_clearance_d,
  sx,
  sy
) =
  sqrt(
    pow(
      sx * (chamber_center_lid_w() / 2 - chamber_lid_mount_inset)
      - hardware_x,
      2
    )
    + pow(
      sy * (chamber_main_lid_d() / 2 - chamber_lid_mount_inset)
      - hardware_y,
      2
    )
  )
  - support_clearance_d / 2
  - chamber_lid_mount_screw_clearance_d / 2;
function chamber_center_lid_support_inner_front_y() =
  chamber_keyboard_lid_front_edge_y()
  - minimum_structural_overlap
  + chamber_keyboard_lid_rail_w;
function chamber_center_lid_support_inner_back_y() =
  chamber_keyboard_lid_back_edge_y
  + minimum_structural_overlap
  - chamber_keyboard_lid_rail_w;
function chamber_center_lid_center_y() =
  (chamber_lid_front_y() + chamber_lid_right_back_y()) / 2;
function chamber_center_lid_ptt_support_to_rear_rail_gap() =
  chamber_center_lid_support_inner_back_y()
  - (
    chamber_center_lid_center_y()
    + chamber_center_lid_ptt_y_pos()
    + chamber_center_lid_ptt_support_clearance_d() / 2
  );
function chamber_center_lid_usb_support_to_front_rail_gap() =
  (
    chamber_center_lid_center_y()
    + chamber_center_lid_usb_a_y_pos()
    - chamber_center_lid_usb_support_clearance_d() / 2
  )
  - chamber_center_lid_support_inner_front_y();
function chamber_center_lid_ptt_rear_rail_throat() =
  chamber_keyboard_lid_rail_w
  + min(chamber_center_lid_ptt_support_to_rear_rail_gap(), 0);
function chamber_center_lid_usb_front_rail_throat() =
  chamber_keyboard_lid_rail_w
  + min(chamber_center_lid_usb_support_to_front_rail_gap(), 0);
function chamber_lid_set_w() =
  max(
    chamber_right_lid_w() + chamber_lid_layout_gap + chamber_io_panel_w(),
    chamber_left_lid_w() + chamber_lid_layout_gap + chamber_center_lid_w()
  );
function chamber_lid_set_d() =
  max(chamber_right_lid_d(), chamber_io_panel_d)
  + chamber_lid_layout_gap
  + max(chamber_left_lid_d(), chamber_main_lid_d());
function chamber_dome_bucket_outer_d() =
  chamber_dome_roof_hole_d - 2 * chamber_dome_bucket_slide_clearance;
function chamber_dome_bucket_inner_d() =
  chamber_dome_bucket_outer_d() - 2 * chamber_dome_bucket_wall;
function chamber_dome_bucket_lip_outer_d() =
  max(
    chamber_dome_outer_d,
    2 * (
      chamber_dome_mount_screw_radius
      + chamber_dome_mount_screw_clearance_d / 2
      + chamber_dome_bucket_lip_screw_edge_margin
    )
  );
function chamber_dome_bucket_lip_inner_d() =
  chamber_dome_bucket_inner_d();
function chamber_dome_bucket_total_h() =
  chamber_total_z() + chamber_dome_bucket_lip_h;
function chamber_dome_bucket_floor_z() =
  chamber_dome_bucket_floor_lift;
function chamber_dome_bucket_passage_center_z() =
  chamber_dome_bucket_floor_lift
  + chamber_dome_bucket_wall
  + chamber_dome_bucket_passage_h / 2
  + 4;
function dome_gimbal_bucket_inner_radius() =
  chamber_dome_bucket_inner_d() / 2;
function dome_gimbal_pan_cradle_radius() =
  dome_gimbal_pan_cradle_d / 2;
function dome_gimbal_pan_plate_radius() =
  dome_gimbal_pan_plate_d / 2;
function dome_gimbal_pan_servo_body_center_x() =
  (dome_gimbal_servo_mount_x_a + dome_gimbal_servo_mount_x_b) / 2;
function dome_gimbal_pan_servo_body_min_x() =
  dome_gimbal_pan_servo_body_center_x()
  - dome_gimbal_servo_service_cutout_x / 2;
function dome_gimbal_pan_servo_body_max_x() =
  dome_gimbal_pan_servo_body_center_x()
  + dome_gimbal_servo_service_cutout_x / 2;
function dome_gimbal_pan_servo_body_min_y() =
  -dome_gimbal_servo_service_cutout_y / 2;
function dome_gimbal_pan_servo_body_max_y() =
  dome_gimbal_servo_service_cutout_y / 2;
function dome_gimbal_pan_cradle_radial_clearance() =
  dome_gimbal_bucket_inner_radius() - dome_gimbal_pan_cradle_radius();
function dome_gimbal_pan_plate_radial_clearance() =
  dome_gimbal_bucket_inner_radius() - dome_gimbal_pan_plate_radius();
function dome_gimbal_tilt_yoke_half_w() =
  dome_gimbal_tilt_yoke_outer_w / 2;
function dome_gimbal_tilt_yoke_inner_w() =
  dome_gimbal_tilt_yoke_outer_w - 2 * dome_gimbal_tilt_yoke_side_t;
function dome_gimbal_tilt_servo_body_center_x() =
  dome_gimbal_tilt_yoke_half_w()
  - dome_gimbal_tilt_yoke_side_t
  - dome_gimbal_servo_body_x / 2;
function dome_gimbal_carriage_side_clearance() =
  (dome_gimbal_tilt_yoke_inner_w()
    - dome_gimbal_camera_laser_carriage_w) / 2;
function dome_gimbal_camera_laser_required_w() =
  2 * (
    dome_gimbal_laser_center_x
    + dome_gimbal_laser_d / 2
  );
function dome_gimbal_laser_saddle_wall() =
  (dome_gimbal_laser_saddle_w
    - dome_gimbal_laser_saddle_clearance_d) / 2;
function dome_gimbal_carriage_edge_ligament() =
  dome_gimbal_camera_laser_carriage_w / 2
  - dome_gimbal_laser_center_x
  - dome_gimbal_laser_saddle_w / 2;
function dome_gimbal_mock_cradle_z() =
  chamber_dome_bucket_floor_z() + chamber_dome_bucket_wall;
function dome_gimbal_mock_pan_plate_z() =
  dome_gimbal_mock_cradle_z()
  + dome_gimbal_pan_cradle_h
  + dome_gimbal_servo_body_z
  + 1.0;
function dome_gimbal_mock_yoke_z() =
  dome_gimbal_mock_pan_plate_z() + dome_gimbal_pan_plate_h;
function dome_gimbal_mock_tilt_axis_z() =
  dome_gimbal_mock_yoke_z() + dome_gimbal_tilt_axis_z;
function dome_gimbal_mock_carriage_top_z() =
  dome_gimbal_mock_tilt_axis_z()
  + dome_gimbal_camera_laser_carriage_h / 2;
function dome_gimbal_mock_carriage_bottom_z() =
  dome_gimbal_mock_tilt_axis_z()
  - dome_gimbal_camera_laser_carriage_h / 2;
function dome_gimbal_mock_dome_base_z() =
  chamber_total_z();
function dome_gimbal_mock_dome_top_z() =
  dome_gimbal_mock_dome_base_z() + chamber_dome_outer_d / 2;
function dome_gimbal_mock_max_payload_radius() =
  sqrt(
    pow(
      dome_gimbal_laser_center_x
      + dome_gimbal_laser_saddle_w / 2,
      2
    )
    + pow(
      dome_gimbal_camera_laser_carriage_plate_t / 2
      + dome_gimbal_laser_len
      + dome_gimbal_laser_saddle_extra_len,
      2
    )
  );
function dome_gimbal_mock_dome_radius_at_tilt_axis() =
  sqrt(
    pow(chamber_dome_outer_d / 2, 2)
    - pow(
      dome_gimbal_mock_tilt_axis_z()
      - dome_gimbal_mock_dome_base_z(),
      2
    )
  );
function dome_gimbal_pan_mount_radius(mx, my) =
  sqrt(pow(mx, 2) + pow(my, 2));
function chamber_tray_opi_board_w() =
  chamber_tray_opi_board_y;
function chamber_tray_opi_board_d() =
  chamber_tray_opi_board_x;
function chamber_tray_w() =
  chamber_tray_opi_board_w() + 2 * chamber_tray_board_clearance_xy;
function chamber_tray_d() =
  chamber_tray_opi_board_d()
  + 2 * chamber_tray_board_clearance_xy
  + chamber_tray_service_depth;
function chamber_tray_opening_w() =
  chamber_tray_w() + 2 * chamber_tray_slide_clearance;
function chamber_tray_y_back() =
  chamber_piece_y / 2;
function chamber_tray_y_front() =
  chamber_tray_y_back() - chamber_tray_d();
function chamber_tray_floor_y_back() =
  chamber_tray_y_back() + chamber_tray_wall;
function chamber_tray_backplate_w() =
  chamber_tray_opening_w()
  + 2 * (
    chamber_tray_backplate_screw_side_offset
    + chamber_tray_backplate_screw_clearance_d / 2
    + chamber_tray_backplate_screw_edge_margin
  );
function chamber_tray_center_x(chamber_xa) =
  chamber_xa
  + minimum_internal_edge_width
  + chamber_tray_backplate_w() / 2;
function chamber_tray_compact_center_x(chamber_xb) =
  chamber_xb
  - minimum_internal_edge_width
  - chamber_tray_backplate_w() / 2;
function chamber_tray_center_x_for_body(chamber_xa, chamber_xb) =
  compact_body_enabled
    ? chamber_tray_compact_center_x(chamber_xb)
    : chamber_tray_center_x(chamber_xa);
function chamber_tray_installed_center_x() =
  chamber_tray_center_x_for_body(0, chamber_assembly_right_x());
function chamber_tray_installed_left_x() =
  chamber_tray_installed_center_x() - chamber_tray_backplate_w() / 2;
function chamber_tray_installed_right_x() =
  chamber_tray_installed_center_x() + chamber_tray_backplate_w() / 2;
function chamber_compact_split_x() =
  chamber_tray_installed_left_x() - minimum_internal_edge_width;
function chamber_split_x() = compact_body_enabled ? chamber_compact_split_x() : 0;
function chamber_left_piece_w() = chamber_split_x() - chamber_assembly_left_x();
function chamber_right_piece_w() = chamber_assembly_right_x() - chamber_split_x();
function chamber_piece_center_x(side) =
  side < 0
    ? (chamber_assembly_left_x() + chamber_split_x()) / 2
    : (chamber_split_x() + chamber_assembly_right_x()) / 2;
function chamber_tray_backplate_bottom_z() =
  chamber_tray_back_opening_z0;
function chamber_tray_backplate_body_h() =
  chamber_tray_backplate_h - chamber_tray_backplate_bottom_z();
function chamber_tray_backplate_center_z() =
  chamber_tray_backplate_bottom_z() + chamber_tray_backplate_body_h() / 2;
function chamber_tray_back_opening_center_z() =
  chamber_tray_back_opening_z0 + chamber_tray_back_opening_h / 2;
function chamber_tray_back_opening_top_z() =
  chamber_tray_back_opening_z0 + chamber_tray_back_opening_h;
function chamber_tray_backplate_screw_x_abs() =
  chamber_tray_opening_w() / 2 + chamber_tray_backplate_screw_side_offset;
function chamber_tray_backplate_screw_low_z() =
  chamber_tray_back_opening_z0 + chamber_tray_backplate_screw_z_offset;
function chamber_tray_backplate_screw_high_z() =
  chamber_tray_back_opening_top_z() - chamber_tray_backplate_screw_z_offset;
function chamber_tray_opi_center_x() =
  0;
function chamber_tray_opi_center_y_pos() =
  chamber_tray_y_back()
  - chamber_tray_wall
  - chamber_tray_opi_rear_row_wall_inset
  - chamber_tray_opi_mount_y_spacing / 2;
function chamber_tray_opi_front_row_y() =
  chamber_tray_opi_center_y_pos() - chamber_tray_opi_mount_y_spacing / 2;
function chamber_tray_opi_rear_row_y() =
  chamber_tray_opi_center_y_pos() + chamber_tray_opi_mount_y_spacing / 2;
function chamber_tray_exhaust_center_x() =
  chamber_tray_opi_center_x() + chamber_tray_exhaust_x_offset;
function chamber_tray_exhaust_center_z() =
  chamber_tray_back_opening_z0
  + chamber_tray_opi_mount_stud_h
  + chamber_tray_opi_standoff_z
  + chamber_tray_opi_board_thickness
  + chamber_tray_exhaust_z_from_board_top;
function chamber_rpi_side_tray_insertion_d() =
  chamber_rpi_side_tray_board_y
  + 2 * chamber_rpi_side_tray_board_clearance_x;
function chamber_rpi_side_tray_span_y() =
  chamber_rpi_side_tray_board_x
  + 2 * chamber_rpi_side_tray_board_clearance_y;
function chamber_rpi_side_tray_opening_y() =
  chamber_rpi_side_tray_span_y()
  + 2 * chamber_rpi_side_tray_slide_clearance;
function chamber_rpi_side_tray_backplate_y() =
  chamber_rpi_side_tray_opening_y()
  + 2 * (
    chamber_rpi_side_tray_backplate_screw_side_offset
    + chamber_rpi_side_tray_backplate_screw_clearance_d / 2
    + chamber_rpi_side_tray_backplate_screw_edge_margin
  );
function chamber_rpi_side_tray_center_y() =
  chamber_piece_y / 2
  - minimum_internal_edge_width
  - chamber_rpi_side_tray_backplate_y() / 2;
function chamber_rpi_side_tray_floor_left_x() =
  -chamber_rpi_side_tray_insertion_d();
function chamber_rpi_side_tray_floor_right_x() =
  chamber_rpi_side_tray_backplate_t;
function chamber_rpi_side_tray_board_center_x() =
  -chamber_rpi_side_tray_insertion_d() / 2;
function chamber_rpi_side_tray_opening_center_z() =
  chamber_rpi_side_tray_opening_z0
  + chamber_rpi_side_tray_opening_h / 2;
function chamber_rpi_side_tray_opening_top_z() =
  chamber_rpi_side_tray_opening_z0
  + chamber_rpi_side_tray_opening_h;
function chamber_rpi_side_tray_screw_y_abs() =
  chamber_rpi_side_tray_opening_y() / 2
  + chamber_rpi_side_tray_backplate_screw_side_offset;
function chamber_rpi_side_tray_screw_low_z() =
  chamber_rpi_side_tray_opening_z0
  + chamber_rpi_side_tray_backplate_screw_z_offset;
function chamber_rpi_side_tray_screw_high_z() =
  chamber_rpi_side_tray_opening_top_z()
  - chamber_rpi_side_tray_backplate_screw_z_offset;
function chamber_rpi_side_tray_mount_x(sx) =
  chamber_rpi_side_tray_board_center_x()
  + sx * chamber_rpi_side_tray_mount_x_spacing / 2;
function chamber_rpi_side_tray_mount_pattern_center_y() =
  chamber_rpi_side_tray_board_center_y
  + chamber_rpi_side_tray_board_x / 2
  - chamber_rpi_side_tray_mount_edge_inset
  - chamber_rpi_side_tray_mount_y_spacing / 2;
function chamber_rpi_side_tray_mount_y(sy) =
  chamber_rpi_side_tray_mount_pattern_center_y()
  + sy * chamber_rpi_side_tray_mount_y_spacing / 2;
function chamber_rpi_side_tray_left_x_assembled() =
  chamber_piece_x
  - chamber_wall
  - chamber_rpi_side_tray_insertion_d();
function chamber_tray_right_x_assembled() =
  chamber_tray_installed_center_x() + chamber_tray_w() / 2;
function chamber_rear_fan_panel_w() =
  chamber_rear_fan_frame + 2 * chamber_rear_fan_edge_margin;
function chamber_rear_fan_center_z() =
  chamber_profile_peak_z()
  - chamber_rear_fan_edge_margin
  - chamber_rear_fan_frame / 2;
function chamber_rear_fan_left_x() =
  chamber_display_wedge_left_x()
  + chamber_rear_fan_panel_w() / 2;
function chamber_rear_fan_right_x() =
  chamber_display_wedge_right_x()
  - chamber_rear_fan_panel_w() / 2;
function chamber_rear_fan_center_x(side) =
  side < 0 ? chamber_rear_fan_left_x() : chamber_rear_fan_right_x();
function chamber_rear_fan_spacer_center_y() =
  chamber_piece_y / 2
  + (
    chamber_rear_fan_spacer_projection
    - chamber_rear_fan_spacer_wall_overlap
  ) / 2;
function chamber_angled_wall_vertical_offset() = chamber_wall * sqrt(2);
function chamber_housing_inner_screen_corner_y() =
  chamber_profile_peak_y()
  + (
    chamber_angled_wall_vertical_offset() - chamber_wall
  ) / (
    chamber_profile_peak_rise / chamber_profile_screen_slope_run
  );
function chamber_passthrough_y(i) =
  i == 0
    ? chamber_joint_passthrough_front_y
    : chamber_joint_passthrough_rear_y;
function chamber_bolt_low_z() = chamber_bottom + chamber_joint_bolt_edge_inset_z;
function chamber_bolt_high_z() = chamber_total_z() - chamber_joint_bolt_edge_inset_z;
function chamber_bolt_outer_y() =
  chamber_piece_y / 2 - chamber_joint_bolt_edge_inset_y;
function chamber_bolt_y(i) =
  i < 2 ? -chamber_bolt_outer_y()
    : i < 4 ? chamber_bolt_outer_y()
    : 0;
function chamber_bolt_z(i) =
  i == 5
    ? chamber_joint_center_upper_bolt_z
    : (i == 0 || i == 2 || i == 4)
      ? chamber_bolt_low_z()
      : chamber_bolt_high_z();
function chamber_screen_face_tangent_position(y, z) =
  (
    (y - chamber_display_void_center_y()) * chamber_profile_screen_slope_run
    + (z - chamber_display_void_center_z()) * chamber_profile_peak_rise
  ) / chamber_profile_screen_face_len();
function chamber_center_upper_bolt_screen_recess_ligament() =
  -chamber_display_void_h / 2
  - chamber_screen_face_tangent_position(
      0,
      chamber_joint_center_upper_bolt_z
    )
  - chamber_joint_bolt_clearance_d / 2;
function chamber_bolt_passthrough_ligament(i, j) =
  sqrt(
    pow(chamber_bolt_y(i) - chamber_passthrough_y(j), 2)
    + pow(chamber_bolt_z(i) - chamber_joint_center_z, 2)
  )
  - chamber_joint_bolt_clearance_d / 2
  - chamber_joint_passthrough_d / 2;
function chamber_front_led_strip_passage_center_y() =
  -chamber_piece_y / 2 + chamber_wall;
function chamber_front_led_strip_passage_center_z() =
  chamber_total_z() / 2;
function chamber_front_led_strip_passage_floor_ligament() =
  chamber_front_led_strip_passage_center_z()
  - chamber_front_led_strip_passage_d / 2
  - chamber_bottom;
function chamber_front_led_strip_passage_top_ligament() =
  chamber_total_z()
  - chamber_front_led_strip_passage_center_z()
  - chamber_front_led_strip_passage_d / 2;
function chamber_front_led_strip_passage_bolt_ligament(i) =
  sqrt(
    pow(
      chamber_bolt_y(i) - chamber_front_led_strip_passage_center_y(),
      2
    )
    + pow(
      chamber_bolt_z(i) - chamber_front_led_strip_passage_center_z(),
      2
    )
  )
  - chamber_joint_bolt_clearance_d / 2
  - chamber_front_led_strip_passage_d / 2;

module _assert_dims() {
  assert(minimum_wall_thickness >= 3.0,
    "cyberdeck minimum wall thickness must be at least 3 mm");
  assert(minimum_structural_overlap >= minimum_wall_thickness,
    "minimum structural overlap must be at least the minimum wall thickness");
  assert(minimum_internal_edge_width >= minimum_wall_thickness,
    "minimum internal edge width must be at least the minimum wall thickness");

  assert(deck_x > 0 && deck_y > 0 && deck_h > 0,
    "deck dimensions must be > 0");
  assert(deck_corner_r >= 0 && deck_corner_r * 2 <= min(deck_x, deck_y),
    "deck_corner_r is out of range");

  assert(display_active_x > 0 && display_active_y > 0,
    "display active dimensions must be > 0");
  assert(display_rail_x >= display_active_x,
    "display_rail_x must be >= display_active_x");
  assert(display_rail_y >= display_active_y,
    "display_rail_y must be >= display_active_y");

  assert(keyboard_unfolded_x > 0 && keyboard_unfolded_y > 0,
    "keyboard unfolded dimensions must be > 0");
  assert(eye_dome_d > 0,
    "eye_dome_d must be > 0");
  assert(eye_dome_left_x() >= left_x() && eye_dome_right_x() <= right_x(),
    "eye dome exceeds chassis width");
  assert(display_left_x() > eye_dome_right_x(),
    "display visual envelope overlaps the eye dome in top view");
  assert(display_bottom_y() > keyboard_top_y(),
    "display visual envelope overlaps the keyboard footprint in top view");
  assert(display_left_x() >= left_x() && display_right_x() <= right_x(),
    "display visual envelope exceeds chassis width");
  assert(eink_window_x > 0 && eink_window_y > 0,
    "e-ink window dimensions must be > 0");
  assert(eink_center_y - (eink_window_y + 10) / 2 > display_top_y(),
    "e-ink window must sit above the display band");
  assert(eink_center_x - (eink_window_x + 10) / 2 > toggle_x(toggle_count - 1) + toggle_plate_x / 2,
    "e-ink window must sit to the right of the toggle row");
  assert(toggle_count == 4,
    "this mockup expects four independent hardware toggles");
  assert(toggle_columns > 0 && toggle_columns <= toggle_count,
    "toggle_columns must be between 1 and toggle_count");
  assert(toggle_bank_bottom_y() > display_top_y(),
    "toggle bank must sit above the display band");
  assert(keyboard_top_y() < display_bottom_y(),
    "keyboard must sit below the display band");
  assert(keyboard_center_x - keyboard_unfolded_x / 2 >= left_x()
    && keyboard_center_x + keyboard_unfolded_x / 2 <= right_x(),
    "keyboard footprint exceeds chassis width");
  assert(opi_exhaust_slot_count > 0,
    "opi_exhaust_slot_count must be > 0");

  assert(print_volume_x > 0 && print_volume_y > 0 && print_volume_z > 0,
    "print volume dimensions must be > 0");
  assert(chamber_piece_x <= print_volume_x,
    "each chamber must fit the print volume in X");
  assert(chamber_left_piece_w() <= print_volume_x
      && chamber_right_piece_w() <= print_volume_x,
    "each calculated chamber half must fit the print volume in X");
  assert(chamber_left_piece_w() > 2 * chamber_wall
      && chamber_right_piece_w() > 2 * chamber_wall,
    "each calculated chamber half must retain usable width");
  assert(!compact_body_enabled
      || abs(chamber_split_x()
          - chamber_tray_installed_left_x()
          + minimum_internal_edge_width) < 0.01,
    "compact split must retain minimum material before the Orange Pi backplate");
  assert(chamber_piece_y + chamber_rear_fan_spacer_projection
      <= print_volume_y,
    "each chamber plus rear fan spacers must fit the print volume in Y");
  assert(chamber_total_z() <= print_volume_z,
    "each chamber must fit the print volume in Z");
  assert(chamber_wall >= minimum_wall_thickness
      && chamber_bottom >= minimum_wall_thickness,
    "chamber wall and bottom thickness must meet the structural minimum");
  assert(chamber_display_cutout_h > 0 && chamber_display_mount_margin >= 0,
    "display cutout height must be > 0 and margin must be >= 0");
  assert(chamber_display_mount_face_len >= chamber_display_cutout_h + 2 * chamber_display_mount_margin,
    "display mount face length must include the cutout and top/bottom margins");
  assert(chamber_display_mount_width > 0 && chamber_display_mount_side_margin >= 0,
    "display mount width must be > 0 and side margin must be >= 0");
  assert(chamber_display_wedge_x >= chamber_display_mount_width + 2 * chamber_display_mount_side_margin,
    "display wedge width must include the display width and side margins");
  assert(chamber_display_wedge_x <= 2 * chamber_piece_x,
    "display wedge width exceeds the assembled chamber width");
  assert(chamber_display_void_x > 0 && chamber_display_void_h > 0,
    "display void dimensions must be > 0");
  assert(chamber_display_void_x < chamber_display_wedge_x,
    "display void width must fit inside the display wedge");
  assert(chamber_display_void_h < chamber_profile_screen_face_len(),
    "display void height must fit inside the angled display face");
  assert(chamber_display_void_depth >= 25.4,
    "display void depth must be at least 25.4 mm");
  assert(chamber_display_mount_screw_x_offset > chamber_display_void_x / 2
    && chamber_display_mount_screw_x_offset < chamber_display_mount_width / 2,
    "display mount screws must land in the display side flanges");
  assert(chamber_display_mount_screw_face_spacing > 0
    && chamber_display_mount_screw_face_spacing < chamber_profile_screen_face_len(),
    "display mount screw spacing must fit on the angled display face");
  assert(chamber_display_mount_screw_clearance_d >= 3.0,
    "display mount screw clearance must clear M3 hardware");
  assert(chamber_dome_outer_d > 0 && chamber_dome_mount_margin >= 0,
    "dome outer diameter must be > 0 and dome margin must be >= 0");
  assert(chamber_dome_area_x >= chamber_dome_outer_d + 2 * chamber_dome_mount_margin,
    "dome area width must include the dome diameter and side margins");
  assert(chamber_dome_area_y >= chamber_dome_outer_d + 2 * chamber_dome_mount_margin,
    "dome area depth must include the dome diameter and side margins");
  assert(chamber_dome_roof_hole_d > 0
    && chamber_dome_roof_hole_d < min(chamber_dome_area_x, chamber_dome_area_y),
    "dome roof hole must fit inside the dome roof area");
  assert(chamber_dome_mount_screw_clearance_d >= 3.0,
    "dome mount holes should clear M3 hardware");
  assert(chamber_dome_mount_screw_radius - chamber_dome_mount_screw_clearance_d / 2
    > chamber_dome_roof_hole_d / 2,
    "dome mount screws intersect the dome roof hole");
  assert(chamber_dome_mount_screw_xy_offset() + chamber_dome_mount_screw_clearance_d / 2
    <= min(chamber_dome_area_x, chamber_dome_area_y) / 2,
    "dome mount screws exceed the dome roof area");
  assert(compact_body_enabled || chamber_left_flat_area_x() >= chamber_dome_area_x,
    "left flat dome area is too narrow for the acrylic dome");
  assert(chamber_dome_roof_front_y() >= -chamber_piece_y / 2,
    "dome roof area exceeds the chamber depth");
  assert(compact_body_enabled || chamber_display_wedge_left_x() > chamber_assembly_left_x(),
    "display wedge leaves no flat left-side dome area");
  assert(chamber_display_wedge_left_x() < 0,
    "display wedge left structural web should land inside the left chamber");
  assert(chamber_piece_x > 2 * chamber_wall && chamber_piece_y > 2 * chamber_wall,
    "chamber walls are too thick for the selected footprint");
  assert(chamber_internal_clearance_z >= 50,
    "chamber internal clearance must be at least 50 mm");
  assert(chamber_profile_peak_rise > 0,
    "chamber profile peak rise must be > 0");
  assert(chamber_rear_housing_depth > 2 * chamber_wall,
    "rear housing depth must leave room for its walls and cavity");
  assert(chamber_housing_inner_screen_corner_y()
      < chamber_piece_y / 2 - chamber_wall,
    "rear housing cavity must remain open between the screen and rear wall");
  assert(chamber_profile_screen_slope_run > 0,
    "chamber screen slope run must be > 0");
  assert(abs(chamber_profile_peak_rise - chamber_profile_screen_slope_run) < 0.02,
    "screen face must remain 45 degrees");
  assert(abs(
      chamber_angled_wall_vertical_offset() / sqrt(2) - chamber_wall
    ) < 0.01,
    "screen face inner offset must preserve the selected normal wall thickness");
  assert(chamber_profile_screen_face_len() >= chamber_display_mount_face_len,
    "screen face length is too short for the display mounting face");
  assert(chamber_profile_peak_z() <= print_volume_z,
    "side profile peak exceeds print volume Z");
  assert(chamber_profile_peak_y() < chamber_piece_y / 2,
    "side profile peak must sit forward of the rear edge");
  assert(chamber_profile_screen_foot_y() > -chamber_piece_y / 2,
    "side profile screen slope must meet the flat deck inside the chamber depth");
  assert(chamber_profile_screen_foot_y() < chamber_profile_peak_y(),
    "side profile screen foot must be forward of the peak");
  assert(chamber_rear_fan_frame == 40
      && chamber_rear_fan_hole_spacing == 32
      && chamber_rear_fan_mount_hole_d == 4.2
      && chamber_rear_fan_center_cutout_d == 28,
    "rear fan interface must match the cottage_pi6_plus 40 mm pattern");
  assert(chamber_rear_fan_hole_spacing + chamber_rear_fan_mount_hole_d
      <= chamber_rear_fan_frame,
    "rear fan mounting holes must fit within the fan frame");
  assert(chamber_rear_fan_center_cutout_d < chamber_rear_fan_frame,
    "rear fan airflow cutout must fit within the fan frame");
  assert(chamber_profile_peak_rise
      >= chamber_rear_fan_frame + 2 * chamber_rear_fan_edge_margin,
    "rear housing wall is too short for the fan footprint and margins");
  assert(chamber_rear_fan_panel_w()
      >= chamber_rear_fan_frame + 2 * chamber_rear_fan_edge_margin,
    "rear fan mounting land is too narrow for the fan footprint and margins");
  assert(chamber_rear_fan_hole_spacing / 2
      + chamber_rear_fan_screw_head_d / 2
      <= chamber_rear_fan_panel_w() / 2,
    "rear fan mounting land does not support the screw heads");
  assert(
    sqrt(
      pow(chamber_rear_fan_hole_spacing / 2, 2)
      + pow(chamber_rear_fan_hole_spacing / 2, 2)
    )
      - chamber_rear_fan_center_cutout_d / 2
      - chamber_rear_fan_mount_hole_d / 2
      >= minimum_internal_edge_width,
    "rear fan center and mounting holes need minimum separating material"
  );
  assert(chamber_rear_fan_panel_w() / 2
      - chamber_rear_fan_hole_spacing / 2
      - chamber_rear_fan_mount_hole_d / 2
      >= minimum_internal_edge_width,
    "rear fan mounting holes need minimum outer-edge material");
  assert(abs(chamber_rear_fan_spacer_projection - 2.0) < 0.01,
    "rear fan spacers must project 2 mm from the housing");
  assert(chamber_rear_fan_spacer_wall_overlap
      >= minimum_structural_overlap
    && chamber_rear_fan_spacer_wall_overlap <= chamber_wall,
    "rear fan spacers must overlap the rear wall by the structural minimum");
  assert(
    (chamber_rear_fan_spacer_outer_d
      - chamber_rear_fan_mount_hole_d) / 2
      >= minimum_internal_edge_width,
    "rear fan spacers need minimum material around each screw hole"
  );
  assert(chamber_rear_fan_spacer_outer_d
      >= chamber_rear_fan_screw_head_d,
    "rear fan spacers must support the modeled screw-head envelope");
  assert(abs(
      chamber_rear_fan_center_z() + chamber_rear_fan_frame / 2
      - (chamber_profile_peak_z() - chamber_rear_fan_edge_margin)
    ) < 0.01,
    "rear fan footprint must remain aligned to the top tower margin");
  assert(chamber_rear_fan_center_z() - chamber_rear_fan_frame / 2
      >= chamber_total_z() + chamber_rear_fan_edge_margin,
    "rear fan footprint must retain a bottom tower margin");
  assert(chamber_rear_fan_left_x() - chamber_rear_fan_panel_w() / 2
      >= chamber_display_wedge_left_x()
    && chamber_rear_fan_right_x() + chamber_rear_fan_panel_w() / 2
      <= chamber_display_wedge_right_x(),
    "rear fan interfaces must remain inside the display-wedge ends");
  assert(chamber_rear_fan_left_x() + chamber_rear_fan_panel_w() / 2 < chamber_split_x()
    && chamber_rear_fan_right_x() - chamber_rear_fan_panel_w() / 2 > chamber_split_x(),
    "each rear fan interface must remain on its own printed chamber half");
  assert(chamber_rear_fan_center_z()
      - chamber_rear_fan_hole_spacing / 2
      - chamber_rear_fan_mount_hole_d / 2
      > chamber_tray_back_opening_z0 + chamber_tray_back_opening_h,
    "right rear fan mounting holes must clear the tray opening");
  assert(chamber_keyboard_lid_inset > 0
    && chamber_keyboard_lid_rail_top_z() < chamber_total_z(),
    "keyboard lid rail must sit below the flat deck top");
  assert(chamber_flat_lid_internal_clearance_z() >= 80,
    "flat lids must retain at least 80 mm of internal floor-to-lid clearance");
  assert(chamber_keyboard_lid_rail_w >= minimum_internal_edge_width
      && chamber_keyboard_lid_rail_h >= minimum_wall_thickness,
    "front lid rails must meet the minimum edge and wall dimensions");
  assert(
    chamber_keyboard_lid_rail_w
      - chamber_wall
      - chamber_lid_clearance
      - chamber_lid_mount_inset
      + chamber_lid_mount_pad_size / 2
      >= minimum_structural_overlap,
    "front lid corner pads must overlap their support rails structurally"
  );
  assert(chamber_keyboard_lid_rail_center_z() - chamber_keyboard_lid_rail_h / 2 > chamber_bottom,
    "keyboard lid rail must stay above the chamber floor");
  assert(chamber_keyboard_lid_back_edge_y > chamber_keyboard_lid_front_edge_y()
    + 2 * chamber_keyboard_lid_rail_w,
    "center/right lid rail back edge must leave a usable front opening");
  assert(chamber_profile_screen_foot_y() - chamber_keyboard_lid_back_edge_y
      >= chamber_io_panel_separator_d - 0.01,
    "center/right lid openings must retain the screen-side separator");
  if (!compact_body_enabled) {
  assert(abs(
      chamber_keyboard_lid_back_edge_y
      - chamber_keyboard_lid_left_back_edge_y
    ) < 0.01,
    "all three front lid openings must share the same rear datum");
  assert(abs(chamber_left_lid_d() - chamber_main_lid_d()) < 0.01
    && abs(chamber_left_lid_d() - chamber_right_lid_d()) < 0.01,
    "all three front lids must have the same finished depth");
  assert(chamber_keyboard_lid_left_back_edge_y > chamber_keyboard_lid_front_edge_y()
    + 2 * chamber_keyboard_lid_rail_w,
    "left keyboard lid rail back edge must leave a usable opening");
  assert(chamber_keyboard_lid_left_back_edge_y <= chamber_dome_roof_front_y() + 0.1,
    "left keyboard lid rail back edge must stay in front of the dome roof");
  assert(chamber_left_lid_center_hole_d > 0,
    "left lid center hole diameter must be > 0");
  assert(chamber_left_lid_m3_pattern_x > 0
      && chamber_left_lid_m3_pattern_y > 0,
    "left lid M3 pattern dimensions must be > 0");
  assert(chamber_left_lid_m3_hole_d >= 3.0,
    "left lid auxiliary M3 holes should clear M3 hardware");
  assert(chamber_left_lid_center_hole_d / 2
      + minimum_internal_edge_width <= min(chamber_left_lid_w(), chamber_left_lid_d()) / 2,
    "left lid centered 30 mm hole must retain minimum edge material");
  assert(chamber_left_lid_m3_pattern_x / 2
      + chamber_left_lid_m3_hole_d / 2
      + minimum_internal_edge_width <= chamber_left_lid_w() / 2,
    "left lid M3 pattern must retain minimum side-edge material");
  assert(chamber_left_lid_m3_pattern_y / 2
      + chamber_left_lid_m3_hole_d / 2
      + minimum_internal_edge_width <= chamber_left_lid_d() / 2,
    "left lid M3 pattern must retain minimum front/back edge material");
  assert(
    sqrt(
      pow(chamber_left_lid_m3_pattern_x / 2, 2)
      + pow(chamber_left_lid_m3_pattern_y / 2, 2)
    )
      - chamber_left_lid_center_hole_d / 2
      - chamber_left_lid_m3_hole_d / 2
      >= minimum_internal_edge_width,
    "left lid centered hole and auxiliary M3 holes must retain minimum material"
  );
  assert(
    sqrt(
      pow(chamber_left_lid_w() / 2 - chamber_lid_mount_inset
          - chamber_left_lid_m3_pattern_x / 2, 2)
      + pow(chamber_left_lid_d() / 2 - chamber_lid_mount_inset
          - chamber_left_lid_m3_pattern_y / 2, 2)
    )
      - chamber_lid_mount_screw_head_d / 2
      - chamber_left_lid_m3_hole_d / 2
      >= minimum_internal_edge_width,
    "left lid auxiliary M3 holes must clear recessed corner fasteners"
  );
  }
  assert(chamber_arcade_button_outer_d >= chamber_arcade_button_mount_d,
    "arcade-button external diameter must not be smaller than its mounting hole");
  assert(abs(chamber_center_lid_ptt_x_pos())
      + chamber_arcade_button_mount_d / 2
      + chamber_arcade_button_mount_margin
      <= chamber_center_lid_w() / 2,
    "center-lid push-to-talk hole must retain its requested side margin");
  assert(chamber_main_lid_d() / 2
      - chamber_center_lid_ptt_y_pos()
      - chamber_arcade_button_mount_d / 2
      >= minimum_internal_edge_width,
    "center-lid push-to-talk hole must retain minimum rear-edge material");
  assert(chamber_center_lid_w() / 2
      - abs(chamber_center_lid_ptt_x_pos())
      - chamber_arcade_button_outer_d / 2
      >= 0,
    "center-lid push-to-talk top cap and underside nut must fit across the lid");
  assert(chamber_main_lid_d() / 2
      - chamber_center_lid_ptt_y_pos()
      - chamber_arcade_button_outer_d / 2
      >= 0,
    "center-lid push-to-talk top cap and underside nut must fit on the lid");
  assert(abs(chamber_center_lid_usb_a_x_pos())
      + chamber_io_panel_usb_a_mount_d / 2
      + chamber_arcade_button_mount_margin
      <= chamber_center_lid_w() / 2,
    "center-lid USB-A hole must retain its requested side margin");
  assert(chamber_center_lid_usb_a_y_pos()
      + chamber_main_lid_d() / 2
      - chamber_io_panel_usb_a_mount_d / 2
      >= minimum_internal_edge_width,
    "center-lid USB-A hole must retain minimum front-edge material");
  assert(chamber_center_lid_w() / 2
      - abs(chamber_center_lid_usb_a_x_pos())
      - chamber_io_panel_usb_a_outer_d / 2
      >= 0,
    "center-lid USB-A top flange and underside nut must fit across the lid");
  assert(chamber_center_lid_usb_a_y_pos()
      + chamber_main_lid_d() / 2
      - chamber_io_panel_usb_a_outer_d / 2
      >= 0,
    "center-lid USB-A top flange and underside nut must fit on the lid");
  assert(chamber_center_lid_ptt_y_pos()
      - chamber_center_lid_usb_a_y_pos()
      - chamber_arcade_button_mount_d / 2
      - chamber_io_panel_usb_a_mount_d / 2
      >= minimum_internal_edge_width,
    "center-lid PTT and USB-A through-holes must retain minimum material");
  assert(chamber_center_lid_installed_envelope_gap()
      >= 3.0,
    "center-lid installed hardware envelopes must retain 3 mm clearance");
  assert(chamber_io_panel_usb_a_mount_d > 0
      && chamber_io_panel_usb_a_outer_d >= chamber_io_panel_usb_a_mount_d,
    "USB-A flange diameter must enclose its mounting hole");
  assert(chamber_io_panel_usb_a_flange_gap >= 2,
    "USB-A flange footprints need at least 2 mm between them");
  assert(chamber_io_panel_usb_a_right_x - chamber_io_panel_usb_a_left_x
      >= chamber_io_panel_usb_a_outer_d + chamber_io_panel_usb_a_flange_gap,
    "USB-A flange footprints must retain their requested separation");
  for (x = [
    chamber_io_panel_usb_a_left_x,
    chamber_io_panel_usb_a_right_x
  ]) {
    assert(abs(x) + chamber_io_panel_usb_a_outer_d / 2
        <= chamber_io_panel_w() / 2,
      "USB-A flange footprint must fit within the I/O panel width");
    assert(abs(chamber_io_panel_usb_a_y())
        + chamber_io_panel_usb_a_outer_d / 2
        <= chamber_io_panel_d / 2,
      "USB-A flange footprint must fit within the I/O panel depth");
  }
  assert(chamber_io_panel_usb_a_right_x + chamber_io_panel_usb_a_outer_d / 2
      + minimum_internal_edge_width
      <= chamber_io_panel_usb_c_x() - chamber_control_usb_c_jack_d / 2,
    "Orange USB-A flange must remain clear of the Neural Jack opening");
  assert(chamber_io_panel_usb_a_neural_jack_ligament()
      >= chamber_io_panel_usb_a_neural_jack_gap,
    "Orange USB-A flange must retain the requested clearance from the Neural Jack opening");
  assert(chamber_io_panel_label_size > 0
      && chamber_io_panel_label_line_gap
        > chamber_io_panel_horizontal_label_h(),
    "I/O-panel label dimensions must be valid");
  assert(chamber_io_panel_usb_c_label_x()
      - chamber_io_panel_neural_label_w() / 2
      >= chamber_io_panel_usb_c_x()
        + chamber_control_usb_c_jack_d / 2
        + chamber_io_panel_label_mount_margin
    && chamber_io_panel_usb_c_label_x()
      + chamber_io_panel_neural_label_w() / 2
      <= chamber_io_panel_w() / 2 - chamber_io_panel_label_edge_margin,
    "Neural Jack label must clear the jack and panel edge");
  for (sy = [-1, 1]) {
    assert(
      sqrt(
        pow(
          chamber_io_panel_w() / 2 - chamber_lid_mount_inset
            - chamber_io_panel_usb_c_x(),
          2
        )
        + pow(
          sy * (chamber_io_panel_d / 2 - chamber_lid_mount_inset)
            - chamber_io_panel_usb_c_y(),
          2
        )
      )
        - chamber_lid_mount_screw_head_d / 2
        - chamber_control_usb_c_jack_d / 2
        >= minimum_internal_edge_width,
      "Neural Jack must clear the right-side recessed panel fasteners"
    );
  }
  assert(chamber_center_lid_w() / 2
      - chamber_center_lid_control_label_x
      - chamber_center_lid_control_label_h() / 2
      >= minimum_internal_edge_width,
    "center-lid side labels must retain minimum outer-edge material");
  assert(chamber_center_lid_control_label_x
      - chamber_center_lid_control_label_h() / 2
      - max(
        chamber_arcade_button_outer_d,
        chamber_io_panel_usb_a_outer_d
      ) / 2
      >= minimum_internal_edge_width,
    "center-lid side labels must clear both installed hardware envelopes");
  assert(chamber_center_lid_control_label_w()
      <= chamber_main_lid_d()
        - 2 * (
          chamber_lid_mount_inset
          + chamber_lid_mount_screw_head_d / 2
          + minimum_internal_edge_width
        ),
    "vertical push-to-talk labels must clear the front/rear fasteners");
  assert(chamber_lid_thickness - chamber_control_usb_c_label_engrave_h
      >= minimum_internal_edge_width,
    "control-label engraving must retain minimum lid thickness");
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      assert(
        chamber_center_lid_hardware_to_corner_screw_gap(
          chamber_center_lid_ptt_x_pos(),
          chamber_center_lid_ptt_y_pos(),
          chamber_arcade_button_outer_d,
          sx,
          sy
        )
          >= minimum_internal_edge_width,
        "center-lid PTT top cap and underside nut must clear recessed corner fasteners"
      );
      assert(
        chamber_center_lid_hardware_to_corner_screw_gap(
          chamber_center_lid_usb_a_x_pos(),
          chamber_center_lid_usb_a_y_pos(),
          chamber_io_panel_usb_a_outer_d,
          sx,
          sy
        )
          >= minimum_internal_edge_width,
        "center-lid USB-A flange and underside nut must clear recessed corner fasteners"
      );
      assert(
        chamber_center_lid_support_cut_to_screw_ligament(
          chamber_center_lid_ptt_x_pos(),
          chamber_center_lid_ptt_y_pos(),
          chamber_center_lid_ptt_support_clearance_d(),
          sx,
          sy
        )
          >= minimum_internal_edge_width,
        "center-lid PTT underside relief must retain minimum material around support screws"
      );
      assert(
        chamber_center_lid_support_cut_to_screw_ligament(
          chamber_center_lid_usb_a_x_pos(),
          chamber_center_lid_usb_a_y_pos(),
          chamber_center_lid_usb_support_clearance_d(),
          sx,
          sy
        )
          >= minimum_internal_edge_width,
        "center-lid USB-A underside relief must retain minimum material around support screws"
      );
    }
  }
  assert(chamber_center_lid_ptt_rear_rail_throat()
      >= minimum_internal_edge_width,
    "center-lid PTT underside relief must retain minimum rear-rail throat");
  assert(chamber_center_lid_usb_front_rail_throat()
      >= minimum_internal_edge_width,
    "center-lid USB-A underside relief must retain minimum front-rail throat");
  assert(abs(
      chamber_rear_housing_depth
      - (
        chamber_io_panel_d
        + 2 * chamber_lid_clearance
        + 2 * chamber_io_panel_screen_border
      )
    ) < 0.01,
    "rear housing depth must derive from the full-width I/O panel and borders");
  assert(chamber_io_panel_opening_front_y()
      - chamber_profile_peak_y() >= minimum_internal_edge_width
    && chamber_piece_y / 2 - chamber_io_panel_opening_back_y()
      >= minimum_internal_edge_width,
    "I/O roof opening must retain minimum front and rear border material");
  assert(chamber_io_panel_opening_xa()
      - chamber_display_wedge_left_x() >= chamber_wall
    && chamber_display_wedge_right_x()
      - chamber_io_panel_opening_xb() >= chamber_wall,
    "I/O roof opening must retain the display-housing end walls");
  assert(abs(chamber_io_panel_opening_d()
      - (chamber_io_panel_d + 2 * chamber_lid_clearance)) < 0.01
    && abs(chamber_io_panel_opening_w()
      - (chamber_io_panel_w() + 2 * chamber_lid_clearance)) < 0.01,
    "I/O roof opening must preserve the configured panel clearance");
  assert(abs(chamber_io_panel_screen_border - chamber_io_panel_separator_d) < 0.01,
    "I/O roof border must match the front-lid screen separator");
  assert(chamber_io_panel_frame_h >= chamber_wall
    && chamber_io_panel_frame_h - chamber_keyboard_lid_inset
      >= minimum_wall_thickness,
    "I/O roof frame and recessed support floor must meet wall thickness");
  assert(chamber_io_panel_support_w >= minimum_structural_overlap,
    "I/O panel support ledge must meet the structural overlap minimum");
  assert(chamber_io_panel_through_xb() > chamber_io_panel_through_xa()
    && chamber_io_panel_through_back_y()
      > chamber_io_panel_through_front_y(),
    "I/O roof through-opening must remain positive");
  assert(chamber_lid_mount_inset
      - chamber_lid_mount_screw_clearance_d / 2
      >= minimum_internal_edge_width
    && chamber_lid_mount_pad_size / 2
      - chamber_lid_mount_screw_clearance_d / 2
      >= minimum_internal_edge_width,
    "I/O roof screw holes must retain minimum panel and support-pad material");
  assert(chamber_io_panel_support_w >= minimum_structural_overlap,
    "I/O roof corner pads must overlap the support ledge structurally");
  assert(chamber_io_bulkhead_wall >= minimum_wall_thickness,
    "I/O center bulkheads must meet the minimum wall thickness");
  assert(chamber_io_bulkhead_top_z()
      - chamber_io_bulkhead_front_lower_z()
      >= minimum_wall_thickness,
    "I/O center bulkheads must retain a full-thickness front tip");
  assert(chamber_io_panel_through_front_y()
      - chamber_io_bulkhead_front_y()
      >= minimum_structural_overlap,
    "I/O center bulkheads must overlap the front roof rail structurally");
  assert(chamber_io_bulkhead_back_y()
      - (chamber_piece_y / 2 - chamber_wall)
      >= minimum_structural_overlap,
    "I/O center bulkheads must overlap the rear wall structurally");
  assert(chamber_io_bulkhead_top_z()
      - chamber_io_panel_frame_bottom_z()
      >= minimum_structural_overlap,
    "I/O center bulkheads must overlap the roof support through its full thickness");
  assert(abs(
      chamber_io_bulkhead_front_lower_z()
      - chamber_io_bulkhead_rear_lower_z()
      - (
        chamber_io_bulkhead_back_y()
        - chamber_io_bulkhead_front_y()
      )
    ) < 0.01,
    "I/O center bulkhead lower edges must remain at 45 degrees");
  assert(chamber_io_bulkhead_rear_lower_z()
      >= chamber_total_z() + minimum_internal_edge_width,
    "I/O center bulkheads must leave minimum clearance above the lower chamber");
  assert(chamber_io_bulkhead_screen_ligament()
      >= minimum_internal_edge_width,
    "I/O center bulkheads must retain minimum material from the screen recess");
  assert(chamber_io_bulkhead_bolt_count == 2,
    "I/O center bulkhead study expects two matched M3 bonding holes");
  assert(chamber_io_bulkhead_bolt_clearance_d >= 3.4,
    "I/O center bulkhead holes must clear M3 hardware");
  for (i = [0 : chamber_io_bulkhead_bolt_count - 1]) {
    assert(chamber_io_bulkhead_bolt_top_ligament(i)
        >= minimum_internal_edge_width,
      "I/O center bulkhead bolt must retain minimum top-edge material");
    assert(chamber_io_bulkhead_bolt_front_ligament(i)
        >= minimum_internal_edge_width,
      "I/O center bulkhead bolt must retain minimum front-edge material");
    assert(chamber_io_bulkhead_bolt_back_ligament(i)
        >= minimum_internal_edge_width,
      "I/O center bulkhead bolt must retain minimum rear-edge material");
    assert(chamber_io_bulkhead_bolt_lower_ligament(i)
        >= minimum_internal_edge_width,
      "I/O center bulkhead bolt must retain minimum material above the 45-degree edge");
  }
  for (x = [
    chamber_io_panel_center_x() + chamber_io_panel_usb_a_left_x,
    chamber_io_panel_center_x() + chamber_io_panel_usb_a_right_x
  ]) {
    assert(chamber_io_bulkhead_cut_ligament(
        x,
        chamber_io_panel_usb_a_mount_d
      ) >= minimum_internal_edge_width,
      "I/O center bulkheads must clear the roof-panel USB-A openings");
  }
  assert(chamber_io_bulkhead_cut_ligament(
      chamber_io_panel_center_x() + chamber_io_panel_usb_c_x(),
      chamber_control_usb_c_jack_d
    ) >= minimum_internal_edge_width,
    "I/O center bulkheads must clear the Neural Jack opening");
  assert(chamber_io_bulkhead_cut_ligament(
      chamber_io_panel_center_x()
        - (chamber_io_panel_w() / 2 - chamber_lid_mount_inset),
      chamber_lid_mount_screw_clearance_d
    ) >= minimum_internal_edge_width,
    "I/O center bulkheads must clear the nearest roof-panel mounting holes");
  assert(chamber_control_band_back_y() - chamber_control_band_front_y()
      >= chamber_wall - 0.01,
    "front lids must retain a full-wall separator before the screen slope");
  assert(chamber_control_usb_c_jack_d > 0,
    "USB-C jack cutout diameter must be > 0");
  assert(chamber_power_cell_rear_x() - chamber_display_wedge_left_x()
      - chamber_control_usb_c_jack_d / 2 >= minimum_internal_edge_width
    && chamber_split_x() - chamber_power_cell_rear_x()
      - chamber_control_usb_c_jack_d / 2 >= minimum_internal_edge_width,
    "Power Cell rear opening must retain material to both dividing walls");
  assert(chamber_power_cell_rear_z()
      - chamber_control_usb_c_jack_d / 2
      - chamber_bottom >= minimum_internal_edge_width
    && chamber_total_z()
      - chamber_power_cell_rear_z()
      - chamber_control_usb_c_jack_d / 2 >= minimum_internal_edge_width,
    "Power Cell rear opening must retain lower-wall edge material");
  assert(chamber_power_cell_rear_cut_depth() > chamber_wall,
    "Power Cell rear opening cutter must pass completely through the wall");
  assert(chamber_control_usb_c_label_gap >= 0
    && chamber_power_cell_rear_label_size > 0
    && chamber_power_cell_rear_label_line_gap
      > chamber_power_cell_rear_label_size
    && chamber_control_usb_c_label_engrave_h > 0,
    "USB-C jack label dimensions must be valid");
  assert(chamber_power_cell_rear_label_center_z()
      - chamber_power_cell_rear_label_line_gap / 2
      - chamber_power_cell_rear_label_size / 2
      >= minimum_internal_edge_width
    && chamber_power_cell_rear_z()
      - chamber_control_usb_c_jack_d / 2
      - (
        chamber_power_cell_rear_label_center_z()
        + chamber_power_cell_rear_label_line_gap / 2
        + chamber_power_cell_rear_label_size / 2
      ) >= minimum_internal_edge_width,
    "Power Cell rear label must retain floor and jack-opening margins");
  assert(handle_length > 0 && handle_standoff > 0 && handle_bar_d > 0,
    "handle length, standoff, and bar diameter must be > 0");
  assert(handle_mount_plate_size > 0 && handle_mount_plate_thickness > 0,
    "handle mounting plate dimensions must be > 0");
  assert(handle_mount_screw_clearance_d >= 3.0,
    "handle mounting screw holes should clear M3 hardware");
  assert(handle_mount_screw_spacing > handle_mount_screw_clearance_d
    && handle_mount_screw_spacing + handle_mount_screw_clearance_d
      < handle_mount_plate_size,
    "handle screw pattern must fit inside each mounting plate");
  assert(handle_mount_screw_spacing - handle_mount_screw_clearance_d
      >= minimum_internal_edge_width
    && 2 * handle_half_length()
      - handle_mount_screw_spacing
      - handle_mount_screw_clearance_d
      >= minimum_internal_edge_width,
    "handle mounting-hole rows must retain minimum material between holes");
  assert(handle_mount_bevel_d >= handle_bar_d
    && handle_mount_bevel_d < handle_mount_plate_size,
    "handle bevel collar must fit on the mounting plate");
  assert(handle_mount_bevel_len > 0
    && handle_standoff - handle_bar_d / 2
      > handle_mount_plate_thickness + handle_mount_bevel_len,
    "handle standoff must leave room for the beveled collars");
  assert(handle_length + handle_mount_plate_size <= print_volume_y,
    "handle length and mounting plates must fit print volume Y");
  assert(handle_standoff <= print_volume_x,
    "handle standoff must fit print volume X");
  assert(handle_mount_plate_size <= print_volume_z,
    "handle mounting plate height must fit print volume Z");
  assert(handle_mount_plate_size <= chamber_piece_y,
    "handle mounting plates must fit centered on the chamber side depth");
  for (i = [0 : 1]) {
    for (sy = [-1, 1]) {
      assert(abs(handle_mount_screw_y(i, sy)) + handle_mount_screw_clearance_d / 2
        <= chamber_piece_y / 2 - chamber_wall,
        "handle side-wall screw holes exceed chamber depth");
    }
  }
  for (sz = [-1, 1]) {
    assert(handle_chamber_mount_screw_z(sz) - handle_mount_screw_clearance_d / 2
        >= chamber_bottom
      && handle_chamber_mount_screw_z(sz) + handle_mount_screw_clearance_d / 2
        <= chamber_total_z() - chamber_wall,
      "handle side-wall screw holes exceed the flat chamber side height");
  }
  assert(chamber_lid_clearance > 0,
    "chamber lid clearance must be > 0");
  assert(chamber_lid_thickness > 0,
    "chamber lid thickness must be > 0");
  assert(chamber_lid_corner_r >= 0,
    "chamber lid corner radius must be >= 0");
  assert(chamber_lid_pull_slot_w > chamber_lid_pull_slot_d
    && chamber_lid_pull_slot_d > 0,
    "chamber lid pull slot dimensions are invalid");
  assert(chamber_lid_pull_slot_front_offset > chamber_lid_pull_slot_d,
    "chamber lid pull slot must sit inside the lid front edge");
  assert(chamber_lid_mount_inset > chamber_lid_mount_screw_head_d / 2
    && chamber_lid_mount_pad_size > chamber_lid_mount_screw_head_d + 2,
    "lid corner mounting pads must clear recessed screw heads");
  assert(chamber_lid_mount_inset - chamber_lid_mount_screw_head_d / 2
      >= minimum_internal_edge_width
    && chamber_lid_mount_pad_size / 2
      - chamber_lid_mount_screw_clearance_d / 2
      >= minimum_internal_edge_width,
    "lid fasteners must retain minimum material around heads and support holes");
  assert(chamber_lid_mount_screw_clearance_d >= 3.0,
    "lid screw clearance holes should clear M3 hardware");
  assert(chamber_lid_mount_screw_head_d > chamber_lid_mount_screw_clearance_d
    && chamber_lid_mount_screw_head_depth > 0
    && chamber_lid_mount_screw_head_depth < chamber_lid_thickness,
    "lid screw counterbores must fit inside the lid thickness");
  assert(compact_body_enabled || chamber_left_lid_w() > 2 * chamber_lid_corner_r
    && chamber_left_lid_d() > 2 * chamber_lid_corner_r,
    "left-front lid dimensions are invalid");
  assert((compact_body_enabled || (chamber_left_lid_w() > 2 * chamber_lid_mount_inset
    && chamber_left_lid_d() > 2 * chamber_lid_mount_inset
    ))
    && chamber_center_lid_w() > 2 * chamber_lid_mount_inset
    && chamber_main_lid_d() > 2 * chamber_lid_mount_inset
    && chamber_right_lid_w() > 2 * chamber_lid_mount_inset
    && chamber_right_lid_d() > 2 * chamber_lid_mount_inset
    && chamber_io_panel_w() > 2 * chamber_lid_mount_inset
    && chamber_io_panel_d > 2 * chamber_lid_mount_inset,
    "lid corner screw holes must fit inside each lid");
  assert(chamber_center_lid_w() > max(2 * chamber_lid_corner_r, chamber_lid_pull_slot_w)
    && chamber_main_lid_d() > 2 * chamber_lid_corner_r,
    "center-left lid dimensions are invalid");
  assert(chamber_right_lid_w() > chamber_lid_pull_slot_w
    && chamber_right_lid_d() > 2 * chamber_lid_corner_r,
    "right-front lid dimensions are invalid");
  assert(chamber_io_panel_w() > 2 * chamber_lid_corner_r
    && chamber_io_panel_d > 2 * chamber_lid_corner_r,
    "full-width roof I/O panel dimensions are invalid");
  assert(abs(chamber_io_panel_usb_c_x()) + chamber_control_usb_c_jack_d / 2
      < chamber_io_panel_w() / 2
    && abs(chamber_io_panel_usb_c_y()) + chamber_control_usb_c_jack_d / 2
      < chamber_io_panel_d / 2,
    "roof-panel USB-C cutout must remain enclosed by the I/O panel");
  assert(chamber_io_panel_switch_mount_d == 20
      && chamber_io_panel_switch_keyed_span_x >= chamber_io_panel_switch_mount_d
      && chamber_io_panel_switch_notch_w > 0
      && chamber_io_panel_switch_outer_d >= chamber_io_panel_switch_mount_d,
    "roof-panel rocker switch geometry must match the keyed 20 mm panel opening");
  assert(abs(chamber_io_panel_switch_notch_depth() - 0.8) < 0.01,
    "roof-panel rocker switch notch must preserve the 20.8 mm keyed opening span");
  assert(chamber_io_panel_switch_pair_ligament()
      >= minimum_internal_edge_width,
    "roof-panel rocker switch caps must retain minimum clearance from each other");
  assert(chamber_io_panel_hardware_x_ligament(
        chamber_io_panel_switch_raspberry_x,
        chamber_io_panel_switch_outer_d,
        chamber_io_panel_usb_a_left_x,
        chamber_io_panel_usb_a_outer_d
      ) >= minimum_internal_edge_width
    && chamber_io_panel_hardware_x_ligament(
        chamber_io_panel_usb_a_left_x,
        chamber_io_panel_usb_a_outer_d,
        chamber_io_panel_switch_orange_x,
        chamber_io_panel_switch_outer_d
      ) >= minimum_internal_edge_width
    && chamber_io_panel_hardware_x_ligament(
        chamber_io_panel_switch_orange_x,
        chamber_io_panel_switch_outer_d,
        chamber_io_panel_usb_a_right_x,
        chamber_io_panel_usb_a_outer_d
      ) >= minimum_internal_edge_width,
    "roof-panel Raspberry/Orange power and USB-A hardware must retain minimum clearance");
  assert(chamber_io_panel_hardware_x_ligament(
        chamber_io_panel_switch_uv_x,
        chamber_io_panel_switch_outer_d,
        chamber_io_panel_switch_raspberry_x,
        chamber_io_panel_switch_outer_d
      ) >= minimum_internal_edge_width,
    "roof-panel utility switches must clear the Raspberry power switch");
  for (x = [
    chamber_io_panel_switch_fans_x,
    chamber_io_panel_switch_uv_x,
    chamber_io_panel_switch_raspberry_x,
    chamber_io_panel_switch_orange_x
  ]) {
    assert(chamber_io_panel_switch_panel_x_ligament(x)
        >= minimum_internal_edge_width
      && chamber_io_panel_switch_panel_y_ligament(chamber_io_panel_switch_y)
        >= minimum_internal_edge_width,
      "roof-panel rocker switches must retain minimum material to panel edges");
    assert(chamber_io_panel_switch_support_left_ligament(x)
        >= minimum_internal_edge_width
      && chamber_io_panel_switch_support_right_ligament(x)
        >= minimum_internal_edge_width
      && chamber_io_panel_switch_support_front_ligament(chamber_io_panel_switch_y)
        >= minimum_internal_edge_width
      && chamber_io_panel_switch_support_back_ligament(chamber_io_panel_switch_y)
        >= minimum_internal_edge_width,
      "roof-panel rocker switches must clear the under-panel support ledge");
    assert(chamber_io_panel_switch_bulkhead_ligament(x)
        >= minimum_internal_edge_width,
      "roof-panel rocker switches must clear the center seam bulkhead underneath");
    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        assert(chamber_io_panel_switch_to_corner_screw_ligament(
            x,
            chamber_io_panel_switch_y,
            sx,
            sy
          ) >= minimum_internal_edge_width,
          "roof-panel rocker switch caps must clear recessed corner screws");
      }
    }
    for (hardware = [
      [chamber_io_panel_usb_a_left_x, chamber_io_panel_usb_a_y(), chamber_io_panel_usb_a_outer_d],
      [chamber_io_panel_usb_a_right_x, chamber_io_panel_usb_a_y(), chamber_io_panel_usb_a_outer_d],
      [chamber_io_panel_usb_c_x(), chamber_io_panel_usb_c_y(), chamber_control_usb_c_jack_d]
    ]) {
      assert(chamber_io_panel_switch_to_round_hardware_ligament(
          x,
          chamber_io_panel_switch_y,
          hardware[0],
          hardware[1],
          hardware[2]
        ) >= minimum_internal_edge_width,
        "roof-panel rocker switch caps must clear existing I/O keepouts");
    }
  }
  assert(chamber_io_panel_switch_label_size > 0
      && chamber_io_panel_switch_label_y_edge_ligament()
        >= minimum_internal_edge_width
      && chamber_io_panel_switch_label_to_switch_ligament()
        >= minimum_internal_edge_width,
    "roof-panel rocker switch labels must fit between the switch caps and nearest panel edge");
  assert(chamber_io_panel_switch_label_edge_ligament(
        chamber_io_panel_switch_fans_x,
        chamber_io_panel_switch_fans_label_w()
      ) >= minimum_internal_edge_width
    && chamber_io_panel_switch_label_edge_ligament(
        chamber_io_panel_switch_uv_x,
        chamber_io_panel_switch_uv_label_w()
      ) >= minimum_internal_edge_width
    && chamber_io_panel_switch_label_edge_ligament(
        chamber_io_panel_switch_raspberry_x,
        chamber_io_panel_switch_raspberry_label_w()
      ) >= minimum_internal_edge_width
    && chamber_io_panel_switch_label_edge_ligament(
        chamber_io_panel_switch_orange_x,
        chamber_io_panel_switch_orange_label_w()
      ) >= minimum_internal_edge_width,
    "roof-panel rocker switch labels must retain minimum side margins");
  assert(chamber_left_lid_w() <= print_volume_x
    && chamber_left_lid_d() <= print_volume_y
    && chamber_center_lid_w() <= print_volume_x
    && chamber_main_lid_d() <= print_volume_y
    && chamber_right_lid_w() <= print_volume_x
    && chamber_right_lid_d() <= print_volume_y
    && chamber_lid_thickness <= print_volume_z,
    "each front lid must fit the print volume");
  assert(chamber_io_panel_print_span_45() <= print_volume_x
    && chamber_io_panel_print_span_45() <= print_volume_y
    && chamber_lid_thickness <= print_volume_z,
    "the full-width I/O panel must fit the print bed at 45 degrees");
  assert(chamber_dome_bucket_wall == 3,
    "dome bucket walls and lip are intentionally fixed at 3 mm for this study");
  assert(chamber_dome_bucket_outer_d() > 2 * chamber_dome_bucket_wall
    && chamber_dome_bucket_outer_d() < chamber_dome_roof_hole_d,
    "dome bucket must slide into the dome roof hole with margin");
  assert(chamber_dome_bucket_lip_outer_d() >= chamber_dome_outer_d
    && chamber_dome_bucket_lip_outer_d() / 2
      >= chamber_dome_mount_screw_radius
        + chamber_dome_mount_screw_clearance_d / 2
        + chamber_dome_bucket_lip_screw_edge_margin,
    "dome bucket lip must cover the acrylic dome and keep margin outside the M3 holes");
  assert(chamber_dome_bucket_lip_h == chamber_dome_bucket_wall,
    "dome bucket lip must be 3 mm thick");
  assert(chamber_dome_bucket_floor_lift >= chamber_dome_bucket_wall
    && chamber_dome_bucket_floor_lift + chamber_dome_bucket_wall < chamber_total_z(),
    "dome bucket floor must sit above the chamber base");
  assert(chamber_dome_bucket_passage_w > 0
    && chamber_dome_bucket_passage_h > 0
    && chamber_dome_bucket_passage_h < chamber_total_z() - chamber_dome_bucket_wall,
    "dome bucket passthrough openings are invalid");
  assert(chamber_dome_bucket_passage_center_z() - chamber_dome_bucket_passage_h / 2
      > chamber_dome_bucket_floor_lift + chamber_dome_bucket_wall
    && chamber_dome_bucket_passage_center_z() + chamber_dome_bucket_passage_h / 2
      < chamber_total_z() - chamber_dome_bucket_wall,
    "dome bucket passthrough openings must clear the raised floor and top lip");
  assert(chamber_dome_mount_screw_radius < chamber_dome_bucket_lip_outer_d() / 2
    && chamber_dome_mount_screw_radius - chamber_dome_mount_screw_clearance_d / 2
      > chamber_dome_bucket_lip_inner_d() / 2,
    "dome bucket lip screw centers must match the existing dome bolt pattern");
  assert(dome_gimbal_servo_profile == "mg996r_standard_servo_profile_v1",
    "dome gimbal expects the documented MG996R profile");
  assert(dome_gimbal_servo_service_cutout_x >= 41.1
      && dome_gimbal_servo_service_cutout_y >= 20.8,
    "MG996R body cutout must be at least the documented serviceable size");
  assert(dome_gimbal_servo_mount_x_a == -36.0
      && dome_gimbal_servo_mount_x_b == 14.0
      && dome_gimbal_servo_mount_y_abs == 5.0,
    "MG996R pan-servo mount holes must use the shaft-centered reference pattern");
  for (mx = [dome_gimbal_servo_mount_x_a, dome_gimbal_servo_mount_x_b]) {
    for (my = [-dome_gimbal_servo_mount_y_abs, dome_gimbal_servo_mount_y_abs]) {
      assert(
        dome_gimbal_pan_mount_radius(mx, my)
          + dome_gimbal_servo_mount_screw_clearance_d / 2
          <= dome_gimbal_pan_cradle_radius()
            - minimum_internal_edge_width,
        "pan-servo mounting holes must retain minimum material to the cradle edge"
      );
    }
  }
  assert(dome_gimbal_pan_cradle_radial_clearance()
      >= minimum_internal_edge_width,
    "pan-servo cradle needs at least 3 mm radial clearance inside the bucket");
  assert(dome_gimbal_pan_plate_radial_clearance()
      >= minimum_internal_edge_width,
    "pan plate needs at least 3 mm radial clearance inside the bucket");
  assert(dome_gimbal_pan_cradle_h >= minimum_wall_thickness
      && dome_gimbal_pan_plate_h >= minimum_wall_thickness
      && dome_gimbal_tilt_yoke_base_h >= minimum_wall_thickness
      && dome_gimbal_tilt_yoke_side_t >= minimum_wall_thickness
      && dome_gimbal_camera_laser_carriage_plate_t >= minimum_wall_thickness,
    "dome gimbal primary printed walls/plates must meet the 3 mm minimum");
  assert(dome_gimbal_tilt_servo_support_rib_w >= minimum_wall_thickness
      && dome_gimbal_tilt_servo_support_rib_h >= minimum_wall_thickness,
    "tilt-servo support ribs must meet the 3 mm minimum");
  assert(dome_gimbal_horn_center_screw_access_d >= 7.0,
    "servo horn receiver must preserve center-screw access");
  assert(dome_gimbal_horn_pocket_arm_w >= minimum_internal_edge_width,
    "servo horn receiver cross arms need printable material width");
  assert(dome_gimbal_tilt_yoke_inner_w()
      > dome_gimbal_camera_laser_carriage_w,
    "camera/laser carriage needs clearance between the yoke side plates");
  assert(dome_gimbal_carriage_side_clearance() >= 0.5,
    "camera/laser carriage needs mechanical side clearance inside the yoke");
  assert(dome_gimbal_camera_laser_required_w()
      + 2 * minimum_internal_edge_width
      <= dome_gimbal_camera_laser_carriage_w,
    "camera plus two laser bodies need minimum side material on the carriage");
  assert(dome_gimbal_laser_saddle_wall()
      >= minimum_internal_edge_width,
    "laser saddles need at least 3 mm material around the 12 mm modules");
  assert(dome_gimbal_carriage_edge_ligament()
      >= minimum_internal_edge_width,
    "laser saddle outer edge must retain at least 3 mm material");
  assert(dome_gimbal_camera_mount_spacing
      + dome_gimbal_camera_mount_screw_clearance_d
      + 2 * minimum_internal_edge_width
      <= min(
        dome_gimbal_camera_laser_carriage_w,
        dome_gimbal_camera_laser_carriage_h
      ),
    "starter camera mounting holes need minimum material on the printed carriage plate");
  assert(
    sqrt(
      pow(dome_gimbal_tilt_yoke_half_w(), 2)
      + pow(dome_gimbal_tilt_yoke_base_d / 2, 2)
    )
      <= dome_gimbal_bucket_inner_radius(),
    "tilt yoke rotating base must fit through the bucket inner diameter"
  );
  assert(
    sqrt(
      pow(dome_gimbal_tilt_yoke_half_w(), 2)
      + pow(dome_gimbal_tilt_yoke_side_d / 2, 2)
    )
      <= dome_gimbal_bucket_inner_radius(),
    "tilt yoke side plates must fit through the bucket inner diameter"
  );
  assert(dome_gimbal_mock_carriage_top_z()
      <= dome_gimbal_mock_dome_top_z(),
    "camera/laser carriage top exceeds the acrylic dome height");
  assert(compact_body_enabled || dome_gimbal_mock_carriage_bottom_z()
      >= chamber_total_z(),
    "camera/laser carriage bottom must remain above the bucket lip plane");
  assert(dome_gimbal_mock_max_payload_radius()
      <= dome_gimbal_mock_dome_radius_at_tilt_axis(),
    "camera/laser payload exceeds the acrylic dome radius at the tilt axis");
  assert(chamber_dome_bucket_passage_w
      >= dome_gimbal_camera_laser_carriage_wire_slot_w,
    "bucket passthrough must accommodate the gimbal wire bundle");
  assert(chamber_tray_wall == 3,
    "right chamber tray is intentionally fixed at 3 mm wall thickness for this study");
  assert(chamber_tray_board_clearance_xy >= minimum_internal_edge_width,
    "Orange Pi tray board clearance must meet the minimum internal edge width");
  assert(chamber_tray_w()
      == chamber_tray_opi_board_w() + 2 * chamber_tray_board_clearance_xy,
    "Orange Pi tray width must derive from the cottage board-clearance footprint");
  assert(chamber_tray_d()
      == chamber_tray_opi_board_d()
        + 2 * chamber_tray_board_clearance_xy
        + chamber_tray_service_depth,
    "Orange Pi tray depth must derive from the cottage service-clearance footprint");
  assert(chamber_tray_opening_w()
      == chamber_tray_w() + 2 * chamber_tray_slide_clearance,
    "rear tray opening must match the narrowed tray plus slide clearance");
  assert(!compact_body_enabled || abs(
      chamber_assembly_right_x()
      - chamber_tray_installed_right_x()
      - minimum_internal_edge_width
    ) < 0.01,
    "compact tray backplate must be right aligned with the minimum wall margin");
  assert(compact_body_enabled || abs(
      chamber_tray_installed_left_x() - minimum_internal_edge_width
    ) < 0.01,
    "legacy tray backplate must be left aligned with the minimum wall margin");
  assert(chamber_tray_installed_left_x() >= minimum_internal_edge_width
    && chamber_tray_installed_right_x()
      <= chamber_assembly_right_x() - minimum_internal_edge_width,
    "tray backplate must retain minimum material to both chamber side walls");
  assert(chamber_tray_installed_center_x() - chamber_tray_opening_w() / 2
      >= minimum_internal_edge_width
    && chamber_tray_installed_center_x() + chamber_tray_opening_w() / 2
      <= chamber_assembly_right_x() - minimum_internal_edge_width,
    "rear tray opening must retain minimum chamber side-wall material");
  assert(chamber_tray_y_front()
      >= -chamber_piece_y / 2 + chamber_wall,
    "cottage-sized tray must remain inside the right chamber depth");
  assert(chamber_tray_floor_y_back() - chamber_tray_y_back()
      >= minimum_structural_overlap,
    "tray floor and rear backplate must overlap by the minimum structural amount");
  assert(chamber_tray_w()
      >= chamber_tray_opi_mount_x_spacing + chamber_tray_opi_mount_pad_d,
    "right chamber tray is too narrow for the Orange Pi mounting pads");
  assert(chamber_tray_d()
      >= chamber_tray_opi_mount_y_spacing + chamber_tray_opi_mount_pad_d,
    "right chamber tray is too shallow for the Orange Pi mounting pads");
  assert(chamber_tray_back_opening_h > chamber_tray_wall
    && chamber_tray_back_opening_top_z() < chamber_total_z(),
    "right chamber tray rear opening must fit in the lower chamber wall");
  assert(chamber_tray_backplate_h > chamber_tray_back_opening_top_z(),
    "right chamber tray backplate must be taller than the rear opening");
  assert(chamber_tray_backplate_w() > chamber_tray_opening_w()
    + 2 * (
      chamber_tray_backplate_screw_clearance_d / 2
      + chamber_tray_backplate_screw_edge_margin
    ),
    "tray backplate needs side flange material around screw holes");
  assert(chamber_tray_backplate_screw_x_abs()
      > chamber_tray_opening_w() / 2
        + chamber_tray_backplate_screw_clearance_d / 2
        + chamber_tray_backplate_screw_edge_margin
    && chamber_tray_backplate_screw_x_abs()
      <= chamber_tray_backplate_w() / 2
        - chamber_tray_backplate_screw_clearance_d / 2
        - chamber_tray_backplate_screw_edge_margin,
    "tray backplate screw holes must keep 3 mm margin from opening and outer edge");
  assert(chamber_tray_backplate_screw_low_z()
      > chamber_tray_backplate_bottom_z()
        + chamber_tray_backplate_screw_clearance_d / 2
        + chamber_tray_backplate_screw_edge_margin
    && chamber_tray_backplate_screw_high_z()
      < chamber_tray_backplate_h
        - chamber_tray_backplate_screw_clearance_d / 2
        - chamber_tray_backplate_screw_edge_margin,
    "tray backplate screw holes must keep 3 mm vertical edge margin");
  assert(abs(chamber_tray_opi_center_x()) < 0.01,
    "Orange Pi board must remain centered in the cottage-sized tray");
  assert(abs(
      chamber_tray_opi_board_w() - chamber_tray_opi_mount_x_spacing
    ) / 2 >= minimum_internal_edge_width,
    "Orange Pi cross-board hole inset must meet the minimum edge-width rule");
  assert(chamber_tray_opi_board_d() > chamber_tray_opi_mount_y_spacing,
    "Orange Pi front/back hole spacing must fit its board envelope");
  assert(chamber_tray_opi_center_x() + chamber_tray_opi_mount_x_spacing / 2
      + chamber_tray_opi_mount_pad_d / 2
      <= chamber_tray_w() / 2,
    "Orange Pi tray mount holes exceed tray width");
  assert(chamber_tray_opi_front_row_y()
      - chamber_tray_opi_mount_pad_d / 2
      >= chamber_tray_y_front(),
    "Orange Pi tray mount holes exceed tray depth");
  assert(abs(
      chamber_tray_y_back() - chamber_tray_opi_rear_row_y()
      - chamber_tray_wall
      - chamber_tray_opi_rear_row_wall_inset
    ) < 0.01,
    "rear Orange Pi stud row must use the cottage exhaust-wall datum");
  assert(chamber_tray_opi_mount_x_spacing == 94
      && chamber_tray_opi_mount_y_spacing == 98,
    "Orange Pi tray mount must preserve the cottage 94 x 98 mm rotated pattern");
  assert(chamber_tray_exhaust_w == 79
      && chamber_tray_exhaust_h == 24,
    "Orange Pi tray exhaust must preserve the cottage 79 x 24 mm opening");
  assert(abs(
      chamber_tray_exhaust_center_x()
      - chamber_tray_opi_center_x()
      - chamber_tray_exhaust_x_offset
    ) < 0.01,
    "Orange Pi exhaust X position must derive from the corrected mount center");
  assert(chamber_tray_exhaust_center_z() - chamber_tray_exhaust_h / 2
      >= chamber_tray_backplate_bottom_z() + minimum_internal_edge_width
    && chamber_tray_exhaust_center_z() + chamber_tray_exhaust_h / 2
      <= chamber_tray_backplate_h - minimum_internal_edge_width,
    "Orange Pi exhaust must retain minimum top and bottom backplate material");
  if (!compact_body_enabled) {
  assert(chamber_rpi_side_tray_wall == minimum_wall_thickness,
    "Raspberry Pi side tray must use the minimum wall thickness");
  assert(chamber_rpi_side_tray_board_clearance_x
      >= minimum_internal_edge_width
    && chamber_rpi_side_tray_board_clearance_y
      >= minimum_internal_edge_width,
    "Raspberry Pi side tray board clearance must meet the minimum edge width");
  assert(chamber_rpi_side_tray_insertion_d()
      == chamber_rpi_side_tray_board_y
        + 2 * chamber_rpi_side_tray_board_clearance_x,
    "Raspberry Pi side tray insertion depth must derive from the rotated board width");
  assert(chamber_rpi_side_tray_span_y()
      == chamber_rpi_side_tray_board_x
        + 2 * chamber_rpi_side_tray_board_clearance_y,
    "Raspberry Pi side tray span must derive from the board length");
  assert(chamber_rpi_side_tray_opening_y()
      == chamber_rpi_side_tray_span_y()
        + 2 * chamber_rpi_side_tray_slide_clearance,
    "Raspberry Pi side opening must include slide clearance");
  assert(chamber_rpi_side_tray_left_x_assembled()
      - chamber_tray_right_x_assembled()
      >= minimum_internal_edge_width,
    "Raspberry Pi and Orange Pi trays need minimum separating clearance");
  assert(chamber_rpi_side_tray_center_y()
      - chamber_rpi_side_tray_backplate_y() / 2
      >= -chamber_piece_y / 2 + minimum_internal_edge_width
    && chamber_rpi_side_tray_center_y()
      + chamber_rpi_side_tray_backplate_y() / 2
      <= chamber_piece_y / 2 - minimum_internal_edge_width,
    "Raspberry Pi side-tray backplate must fit the chamber side wall");
  assert(chamber_rpi_side_tray_center_y()
      - chamber_rpi_side_tray_opening_y() / 2
      >= -chamber_piece_y / 2 + minimum_internal_edge_width
    && chamber_rpi_side_tray_center_y()
      + chamber_rpi_side_tray_opening_y() / 2
      <= chamber_piece_y / 2 - minimum_internal_edge_width,
    "Raspberry Pi side opening must retain chamber side-wall material");
  assert(chamber_rpi_side_tray_opening_h > chamber_rpi_side_tray_wall
    && chamber_rpi_side_tray_opening_top_z() < chamber_total_z(),
    "Raspberry Pi side opening must fit the lower chamber wall");
  assert(chamber_rpi_side_tray_backplate_h
      > chamber_rpi_side_tray_opening_top_z(),
    "Raspberry Pi side-tray backplate must be taller than its opening");
  assert(chamber_rpi_side_tray_screw_y_abs()
      > chamber_rpi_side_tray_opening_y() / 2
        + chamber_rpi_side_tray_backplate_screw_clearance_d / 2
        + chamber_rpi_side_tray_backplate_screw_edge_margin
    && chamber_rpi_side_tray_screw_y_abs()
      <= chamber_rpi_side_tray_backplate_y() / 2
        - chamber_rpi_side_tray_backplate_screw_clearance_d / 2
        - chamber_rpi_side_tray_backplate_screw_edge_margin,
    "Raspberry Pi side-tray screws need margin from the opening and backplate edges");
  assert(chamber_rpi_side_tray_screw_low_z()
      > chamber_rpi_side_tray_opening_z0
        + chamber_rpi_side_tray_backplate_screw_clearance_d / 2
        + chamber_rpi_side_tray_backplate_screw_edge_margin
    && chamber_rpi_side_tray_screw_high_z()
      < chamber_rpi_side_tray_backplate_h
        - chamber_rpi_side_tray_backplate_screw_clearance_d / 2
        - chamber_rpi_side_tray_backplate_screw_edge_margin,
    "Raspberry Pi side-tray screws need vertical backplate edge margin");
  assert(chamber_rpi_side_tray_mount_x_spacing == 49
      && chamber_rpi_side_tray_mount_y_spacing == 58
      && chamber_rpi_side_tray_mount_edge_inset == 3.5,
    "Raspberry Pi side tray must preserve the rotated 49 x 58 mm hole pattern");
  assert(chamber_rpi_side_tray_board_center_y
      - chamber_rpi_side_tray_board_x / 2
      >= -chamber_rpi_side_tray_span_y() / 2
        + minimum_internal_edge_width
    && chamber_rpi_side_tray_board_center_y
      + chamber_rpi_side_tray_board_x / 2
      <= chamber_rpi_side_tray_span_y() / 2
        - minimum_internal_edge_width,
    "Raspberry Pi board must retain minimum front/back tray clearance");
  assert(
    (
      chamber_rpi_side_tray_mount_pad_d
      - chamber_rpi_side_tray_mount_screw_clearance_d
    ) / 2 >= minimum_internal_edge_width,
    "Raspberry Pi mounting pads need minimum material around M2.5 holes");
  for (sx = [-1, 1]) {
    assert(chamber_rpi_side_tray_mount_x(sx)
        - chamber_rpi_side_tray_mount_pad_d / 2
        >= chamber_rpi_side_tray_floor_left_x()
      && chamber_rpi_side_tray_mount_x(sx)
        + chamber_rpi_side_tray_mount_pad_d / 2
        <= 0,
      "Raspberry Pi mounting pads exceed the side tray insertion depth");
  }
  for (sy = [-1, 1]) {
    assert(chamber_rpi_side_tray_mount_y(sy)
        - chamber_rpi_side_tray_mount_pad_d / 2
        >= -chamber_rpi_side_tray_span_y() / 2
      && chamber_rpi_side_tray_mount_y(sy)
        + chamber_rpi_side_tray_mount_pad_d / 2
        <= chamber_rpi_side_tray_span_y() / 2,
      "Raspberry Pi mounting pads exceed the side tray front/back span");
  }
  assert(chamber_rpi_side_tray_floor_right_x()
      >= chamber_rpi_side_tray_backplate_t,
    "Raspberry Pi side-tray floor must overlap the backplate through its full thickness");
  assert(chamber_rpi_side_tray_wall >= minimum_structural_overlap,
    "Raspberry Pi mounting pads must overlap through the full tray-floor thickness");
  }
  assert(chamber_joint_passthrough_count == 2,
    "this chamber mockup expects two front/back passthroughs");
  assert(chamber_joint_passthrough_d > 0,
    "chamber passthrough diameter must be > 0");
  assert(chamber_joint_passthrough_spacing_y > 0,
    "chamber passthrough spacing must be > 0");
  assert(abs(
      chamber_joint_passthrough_spacing_y
      - (
        chamber_joint_passthrough_rear_y
        - chamber_joint_passthrough_front_y
      )
    ) < 0.01,
    "chamber passthrough spacing must match the front/rear datums");
  assert(chamber_joint_passthrough_front_y < chamber_joint_passthrough_rear_y,
    "front passthrough must be forward of rear passthrough");
  assert(abs(chamber_joint_passthrough_rear_y - chamber_display_mount_rear_screw_y()) < 5,
    "rear passthrough should stay near the rear display screw row");
  assert(chamber_joint_center_z - chamber_joint_passthrough_d / 2 > chamber_bottom,
    "chamber passthrough intersects the chamber floor");
  assert(chamber_joint_center_z + chamber_joint_passthrough_d / 2 < chamber_total_z(),
    "chamber passthrough exceeds the open chamber height");
  for (i = [0 : chamber_joint_passthrough_count - 1]) {
    assert(abs(chamber_passthrough_y(i)) + chamber_joint_passthrough_d / 2 <= chamber_piece_y / 2,
      "chamber passthrough exceeds chamber depth");
  }
  assert(chamber_joint_center_z - chamber_joint_passthrough_d / 2 >= chamber_bottom,
    "chamber passthrough intersects the chamber floor");
  assert(chamber_joint_center_z + chamber_joint_passthrough_d / 2 <= chamber_total_z(),
    "chamber passthrough exceeds the open chamber height");
  assert(chamber_joint_center_z + chamber_joint_passthrough_d / 2
    < chamber_keyboard_lid_rail_center_z() - chamber_keyboard_lid_rail_h / 2,
    "chamber passthrough must clear the keyboard lid rail");
  assert(chamber_joint_bolt_count == 6,
    "this chamber mockup expects six M3 bolts on the mating face");
  assert(chamber_joint_bolt_clearance_d >= 3.0,
    "M3 bolt clearance should be at least 3.0 mm");
  assert(chamber_front_led_strip_passage_d == 15.0,
    "front LED-strip wall passages must remain 15 mm diameter");
  assert(chamber_wall >= minimum_structural_overlap,
    "front LED-strip passages must preserve a full-thickness wall-to-front join");
  assert(chamber_front_led_strip_passage_floor_ligament()
      >= minimum_internal_edge_width,
    "front LED-strip passages need minimum material above the chamber floor");
  assert(chamber_front_led_strip_passage_top_ligament()
      >= minimum_internal_edge_width,
    "front LED-strip passages need minimum material below the wall top");
  assert(
    chamber_center_upper_bolt_screen_recess_ligament()
      >= minimum_internal_edge_width,
    str(
      "upper center chamber bolt needs minimum material below the screen recess; actual=",
      chamber_center_upper_bolt_screen_recess_ligament(),
      " mm"
    )
  );
  for (i = [0 : chamber_joint_bolt_count - 1]) {
    assert(
      chamber_piece_y / 2
        - abs(chamber_bolt_y(i))
        - chamber_joint_bolt_clearance_d / 2
        >= minimum_internal_edge_width,
      "chamber bolt hole needs minimum material to the front/rear edge"
    );
    assert(chamber_bolt_z(i)
        - chamber_joint_bolt_clearance_d / 2
        - chamber_bottom
        >= minimum_internal_edge_width,
      "chamber bolt hole needs minimum material above the floor");
    assert(chamber_total_z()
        - chamber_bolt_z(i)
        - chamber_joint_bolt_clearance_d / 2
        >= minimum_internal_edge_width,
      "chamber bolt hole needs minimum material below the open top");
    assert(chamber_front_led_strip_passage_bolt_ligament(i)
        >= minimum_internal_edge_width,
      "front LED-strip passage needs minimum material from chamber bonding bolts");
    for (j = [0 : chamber_joint_passthrough_count - 1]) {
      assert(chamber_bolt_passthrough_ligament(i, j)
          >= minimum_internal_edge_width,
        "chamber bolt and passthrough holes need minimum separating material");
    }
  }
}

module _rounded_rect_2d(w, d, r) {
  if (r <= 0) {
    square([w, d], center = true);
  } else {
    hull() {
      for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
          translate([sx * (w / 2 - r), sy * (d / 2 - r)])
            circle(r = r, $fn = 48);
        }
      }
    }
  }
}

module _rounded_box(w, d, h, r) {
  linear_extrude(height = h, center = false, convexity = 8)
    _rounded_rect_2d(w, d, r);
}

module _chamber_shell(side, center_x, assembly_position) {
  global_body_xa = side < 0 ? chamber_assembly_left_x() : chamber_split_x();
  global_body_xb = side < 0 ? chamber_split_x() : chamber_assembly_right_x();
  model_x_offset = assembly_position ? 0 : -chamber_piece_center_x(side);
  wedge_xa = max(chamber_display_wedge_left_x(), global_body_xa) + model_x_offset;
  wedge_xb = min(chamber_display_wedge_right_x(), global_body_xb) + model_x_offset;
  wedge_global_xa = max(chamber_display_wedge_left_x(), global_body_xa);
  wedge_global_xb = min(chamber_display_wedge_right_x(), global_body_xb);
  keep_wedge_left_wall = abs(wedge_global_xa - chamber_display_wedge_left_x()) < 0.01;
  keep_wedge_right_wall = abs(wedge_global_xb - chamber_display_wedge_right_x()) < 0.01;
  roof_xa = max(chamber_dome_roof_left_x(), global_body_xa) + model_x_offset;
  roof_xb = min(chamber_dome_roof_right_x(), global_body_xb) + model_x_offset;
  control_roof_xa = max(chamber_dome_roof_right_x(), global_body_xa) + model_x_offset;
  control_roof_xb = global_body_xb + model_x_offset;
  left_keyboard_rail_xa = global_body_xa + model_x_offset;
  left_keyboard_rail_xb = min(chamber_dome_roof_right_x(), global_body_xb) + model_x_offset;
  keyboard_rail_xa = max(chamber_dome_roof_right_x(), global_body_xa) + model_x_offset;
  keyboard_rail_xb = global_body_xb + model_x_offset;

  union() {
    _chamber_flat_tray(
      global_body_xa + model_x_offset,
      global_body_xb + model_x_offset,
      -chamber_piece_y / 2,
      chamber_piece_y / 2
    );

    if (keyboard_rail_xb > keyboard_rail_xa) {
      _chamber_keyboard_lid_support_rail(
        keyboard_rail_xa,
        keyboard_rail_xb,
        chamber_keyboard_lid_front_edge_y(),
        chamber_keyboard_lid_back_edge_y,
        side < 0
      );
    }

    if (left_keyboard_rail_xb > left_keyboard_rail_xa) {
      _chamber_keyboard_lid_support_rail(
        left_keyboard_rail_xa,
        left_keyboard_rail_xb,
        chamber_keyboard_lid_front_edge_y(),
        chamber_keyboard_lid_left_back_edge_y
      );
    }

    if (wedge_xb > wedge_xa) {
      _chamber_profile_shell(
        wedge_xa,
        wedge_xb,
        -chamber_piece_y / 2,
        chamber_piece_y / 2,
        keep_wedge_left_wall,
        keep_wedge_right_wall
      );
      _chamber_io_roof_frame(wedge_xa, wedge_xb);
    }

    if (roof_xb > roof_xa) {
      _chamber_flat_roof(
        roof_xa,
        roof_xb,
        chamber_dome_roof_front_y(),
        chamber_dome_roof_back_y()
      );
    }

    if (control_roof_xb > control_roof_xa) {
      _chamber_flat_roof(
        control_roof_xa,
        control_roof_xb,
        chamber_control_band_front_y(),
        chamber_control_band_back_y()
      );
    }
  }
}

module _chamber_flat_tray(xa, xb, y_front, y_back) {
  difference() {
    _chamber_flat_prism(xa, xb, y_front, y_back, 0, 0);
    _chamber_flat_prism(
      xa + chamber_wall,
      xb - chamber_wall,
      y_front + chamber_wall,
      y_back - chamber_wall,
      chamber_bottom,
      0.6
    );
  }
}

module _chamber_flat_prism(xa, xb, y_front, y_back, z_bottom, top_extra) {
  multmatrix([
    [0, 0, 1, xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = xb - xa, center = false, convexity = 4)
      polygon(points = [
        [y_front, z_bottom],
        [y_back, z_bottom],
        [y_back, chamber_total_z() + top_extra],
        [y_front, chamber_total_z() + top_extra]
      ]);
}

module _chamber_flat_roof(xa, xb, y_front, y_back) {
  translate([
    (xa + xb) / 2,
    (y_front + y_back) / 2,
    chamber_total_z() - chamber_wall / 2
  ])
    cube([xb - xa + 0.05, y_back - y_front, chamber_wall], center = true);
}

module _chamber_io_roof_frame(xa, xb) {
  translate([
    xa,
    chamber_profile_peak_y(),
    chamber_io_panel_frame_bottom_z()
  ])
    cube([
      xb - xa,
      chamber_rear_housing_depth,
      chamber_io_panel_frame_h
    ], center = false);
}

module _chamber_io_center_bulkhead(side, joint_face_x) {
  bulkhead_xa =
    side < 0
      ? joint_face_x - chamber_io_bulkhead_wall
      : joint_face_x;

  multmatrix([
    [0, 0, 1, bulkhead_xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(
      height = chamber_io_bulkhead_wall,
      center = false,
      convexity = 4
    )
      polygon(points = [
        [
          chamber_io_bulkhead_front_y(),
          chamber_io_bulkhead_front_lower_z()
        ],
        [
          chamber_io_bulkhead_front_y(),
          chamber_io_bulkhead_top_z()
        ],
        [
          chamber_io_bulkhead_back_y(),
          chamber_io_bulkhead_top_z()
        ],
        [
          chamber_io_bulkhead_back_y(),
          chamber_io_bulkhead_rear_lower_z()
        ]
      ]);
}

module _chamber_io_center_bulkhead_bolt_cut(joint_face_x, i) {
  translate([
    joint_face_x,
    chamber_io_bulkhead_bolt_y(i),
    chamber_io_bulkhead_bolt_z(i)
  ])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_io_bulkhead_bolt_clearance_d,
        h = chamber_io_bulkhead_wall * 2 + 1.2,
        center = true,
        $fn = 32
      );
}

module _right_chamber_tray_rear_opening_cut(xa, xb) {
  tray_center_x = chamber_tray_center_x_for_body(xa, xb);

  translate([
    tray_center_x,
    chamber_piece_y / 2,
    chamber_tray_back_opening_center_z()
  ])
    cube([
      chamber_tray_opening_w(),
      chamber_wall * 6,
      chamber_tray_back_opening_h
    ], center = true);
}

module _right_chamber_tray_backplate_screw_cut(xa, xb, sx, sz) {
  tray_center_x = chamber_tray_center_x_for_body(xa, xb);
  screw_z = sz < 0
    ? chamber_tray_backplate_screw_low_z()
    : chamber_tray_backplate_screw_high_z();

  translate([
    tray_center_x + sx * chamber_tray_backplate_screw_x_abs(),
    chamber_piece_y / 2,
    screw_z
  ])
    rotate([90, 0, 0])
      cylinder(
        d = chamber_tray_backplate_screw_clearance_d,
        h = chamber_wall * 6,
        center = true,
        $fn = 32
      );
}

module _right_chamber_tray_backplate_screw_cuts(xa, xb) {
  for (sx = [-1, 1]) {
    for (sz = [-1, 1]) {
      _right_chamber_tray_backplate_screw_cut(xa, xb, sx, sz);
    }
  }
}

module _right_chamber_rpi_side_opening_cut(side_face_x) {
  translate([
    side_face_x,
    chamber_rpi_side_tray_center_y(),
    chamber_rpi_side_tray_opening_center_z()
  ])
    cube([
      chamber_wall * 6,
      chamber_rpi_side_tray_opening_y(),
      chamber_rpi_side_tray_opening_h
    ], center = true);
}

module _right_chamber_rpi_side_backplate_screw_cut(
  side_face_x,
  sy,
  sz
) {
  screw_z =
    sz < 0
      ? chamber_rpi_side_tray_screw_low_z()
      : chamber_rpi_side_tray_screw_high_z();

  translate([
    side_face_x,
    chamber_rpi_side_tray_center_y()
      + sy * chamber_rpi_side_tray_screw_y_abs(),
    screw_z
  ])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_rpi_side_tray_backplate_screw_clearance_d,
        h = chamber_wall * 6,
        center = true,
        $fn = 32
      );
}

module _right_chamber_rpi_side_backplate_screw_cuts(side_face_x) {
  for (sy = [-1, 1]) {
    for (sz = [-1, 1]) {
      _right_chamber_rpi_side_backplate_screw_cut(
        side_face_x,
        sy,
        sz
      );
    }
  }
}

module _chamber_keyboard_lid_support_rail(
  xa,
  xb,
  y_front,
  y_back,
  include_center_control_clearances = false
) {
  attach_overlap = minimum_structural_overlap;
  outer_xa = xa + chamber_wall - attach_overlap;
  outer_xb = xb - chamber_wall + attach_overlap;
  outer_y_front = y_front - attach_overlap;
  outer_y_back = y_back + attach_overlap;
  rail_x = outer_xb - outer_xa;
  rail_y = outer_y_back - outer_y_front;
  pad_z = chamber_keyboard_lid_rail_center_z() - chamber_keyboard_lid_rail_h / 2;

  if (rail_x > 2 * chamber_keyboard_lid_rail_w
      && rail_y > 2 * chamber_keyboard_lid_rail_w) {
    difference() {
      union() {
        translate([
          (outer_xa + outer_xb) / 2,
          (outer_y_front + outer_y_back) / 2,
          pad_z
        ])
          linear_extrude(height = chamber_keyboard_lid_rail_h, center = false, convexity = 4)
            difference() {
              square([rail_x, rail_y], center = true);
              square([
                rail_x - 2 * chamber_keyboard_lid_rail_w,
                rail_y - 2 * chamber_keyboard_lid_rail_w
              ], center = true);
            }

        for (sx = [-1, 1]) {
          for (sy = [-1, 1]) {
            translate([
              sx < 0
                ? xa + chamber_wall + chamber_lid_clearance + chamber_lid_mount_inset
                : xb - chamber_wall - chamber_lid_clearance - chamber_lid_mount_inset,
              sy < 0
                ? y_front + chamber_lid_clearance + chamber_lid_mount_inset
                : y_back - chamber_lid_clearance - chamber_lid_mount_inset,
              chamber_keyboard_lid_rail_center_z()
            ])
              cube([
                chamber_lid_mount_pad_size,
                chamber_lid_mount_pad_size,
                chamber_keyboard_lid_rail_h
              ], center = true);
          }
        }
      }

      for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
          translate([
            sx < 0
              ? xa + chamber_wall + chamber_lid_clearance + chamber_lid_mount_inset
              : xb - chamber_wall - chamber_lid_clearance - chamber_lid_mount_inset,
            sy < 0
              ? y_front + chamber_lid_clearance + chamber_lid_mount_inset
              : y_back - chamber_lid_clearance - chamber_lid_mount_inset,
            chamber_keyboard_lid_rail_center_z()
          ])
            cylinder(
              d = chamber_lid_mount_screw_clearance_d,
              h = chamber_keyboard_lid_rail_h + 1.2,
              center = true,
              $fn = 32
            );
        }
      }

      if (include_center_control_clearances) {
        _chamber_center_lid_support_clearance_cuts(
          (xa + xb) / 2
        );
      }
    }
  }
}

module _chamber_center_lid_support_clearance_cut(
  center_x,
  local_x,
  local_y,
  clearance_d
) {
  translate([
    center_x + local_x,
    chamber_center_lid_center_y() + local_y,
    chamber_keyboard_lid_rail_center_z()
  ])
    cylinder(
      d = clearance_d,
      h = chamber_keyboard_lid_rail_h + 1.2,
      center = true,
      $fn = 72
    );
}

module _chamber_center_lid_support_clearance_cuts(center_x) {
  _chamber_center_lid_support_clearance_cut(
    center_x,
    chamber_center_lid_ptt_x_pos(),
    chamber_center_lid_ptt_y_pos(),
    chamber_center_lid_ptt_support_clearance_d()
  );
  _chamber_center_lid_support_clearance_cut(
    center_x,
    chamber_center_lid_usb_a_x_pos(),
    chamber_center_lid_usb_a_y_pos(),
    chamber_center_lid_usb_support_clearance_d()
  );
}

module _chamber_profile_shell(
  xa,
  xb,
  y_front,
  y_back,
  keep_left_wall = true,
  keep_right_wall = true
) {
  difference() {
    _chamber_profile_outer_prism(xa, xb, y_front, y_back);

    _chamber_profile_inner_void(
      keep_left_wall ? xa + chamber_wall : xa - 0.6,
      keep_right_wall ? xb - chamber_wall : xb + 0.6,
      y_front + chamber_wall,
      y_back - chamber_wall,
      chamber_bottom
    );
  }
}

module _chamber_profile_outer_prism(
  xa,
  xb,
  y_front,
  y_back
) {
  z_flat = chamber_total_z();
  y_screen = chamber_profile_screen_foot_y();
  y_peak = chamber_profile_peak_y();
  z_peak = chamber_profile_peak_z();

  multmatrix([
    [0, 0, 1, xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = xb - xa, center = false, convexity = 4)
      polygon(points = [
        [y_front, 0],
        [y_back, 0],
        [y_back, z_peak],
        [y_peak, z_peak],
        [y_screen, z_flat],
        [y_front, z_flat]
      ]);
}

module _chamber_profile_inner_void(
  xa,
  xb,
  y_front,
  y_back,
  z_bottom
) {
  z_flat = chamber_total_z();
  y_screen = chamber_profile_screen_foot_y();
  y_screen_roof = chamber_housing_inner_screen_corner_y();
  z_peak_inner = chamber_profile_peak_z() - chamber_wall;

  multmatrix([
    [0, 0, 1, xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = xb - xa, center = false, convexity = 4)
      polygon(points = [
        [y_front, z_bottom],
        [y_back, z_bottom],
        [y_back, z_peak_inner],
        [y_screen_roof, z_peak_inner],
        [y_screen, z_flat - chamber_angled_wall_vertical_offset()],
        [y_screen, z_flat + 0.6],
        [y_front, z_flat + 0.6]
      ]);
}

module _chamber_passthrough_cut(joint_face_x, i) {
  translate([joint_face_x, chamber_passthrough_y(i), chamber_joint_center_z])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_joint_passthrough_d,
        h = chamber_wall * 4 + 1.2,
        center = true,
        $fn = 72
      );
}

module _chamber_front_led_strip_passage_cut(wall_x) {
  passage_r = chamber_front_led_strip_passage_d / 2;
  cut_x = chamber_wall * 4 + 1.2;

  intersection() {
    translate([
      wall_x,
      chamber_front_led_strip_passage_center_y(),
      chamber_front_led_strip_passage_center_z()
    ])
      rotate([0, 90, 0])
        cylinder(
          d = chamber_front_led_strip_passage_d,
          h = cut_x,
          center = true,
          $fn = 72
        );

    translate([
      wall_x,
      chamber_front_led_strip_passage_center_y()
        + (passage_r + 0.6) / 2,
      chamber_front_led_strip_passage_center_z()
    ])
      cube([
        cut_x,
        passage_r + 0.6,
        chamber_front_led_strip_passage_d + 1.2
      ], center = true);
  }
}

module _chamber_dome_roof_cut(center_x, center_y) {
  translate([center_x, center_y, chamber_total_z() - chamber_wall / 2])
    cylinder(
      d = chamber_dome_roof_hole_d,
      h = chamber_wall + 1.2,
      center = true,
      $fn = 128
    );
}

module _chamber_dome_mount_screw_cut(center_x, center_y, sx, sy) {
  translate([
    center_x + sx * chamber_dome_mount_screw_xy_offset(),
    center_y + sy * chamber_dome_mount_screw_xy_offset(),
    chamber_total_z() - chamber_wall / 2
  ])
    cylinder(
      d = chamber_dome_mount_screw_clearance_d,
      h = chamber_wall + 1.2,
      center = true,
      $fn = 32
    );
}

module _chamber_dome_mount_screw_cuts(center_x, center_y) {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      _chamber_dome_mount_screw_cut(center_x, center_y, sx, sy);
    }
  }
}

module _chamber_power_cell_rear_jack_cut(center_x) {
  translate([
    center_x,
    chamber_power_cell_rear_wall_center_y(),
    chamber_power_cell_rear_z()
  ])
    rotate([90, 0, 0])
      cylinder(
        d = chamber_control_usb_c_jack_d,
        h = chamber_power_cell_rear_cut_depth(),
        center = true,
        $fn = 72
      );
}

module _chamber_power_cell_rear_label_line(x, z, label_text) {
  translate([
    x,
    chamber_piece_y / 2 + chamber_control_usb_c_label_engrave_h,
    z
  ])
    rotate([90, 0, 0])
      linear_extrude(
        height = chamber_wall + chamber_control_usb_c_label_engrave_h,
        center = false,
        convexity = 2
      )
        mirror([1, 0, 0])
          text(
            label_text,
            size = chamber_power_cell_rear_label_size,
            font = chamber_label_font,
            halign = "center",
            valign = "center"
          );
}

module _chamber_power_cell_rear_label(x) {
  _chamber_power_cell_rear_label_line(
    x,
    chamber_power_cell_rear_label_center_z()
      + chamber_power_cell_rear_label_line_gap / 2,
    chamber_control_usb_c_left_label_line_1
  );
  _chamber_power_cell_rear_label_line(
    x,
    chamber_power_cell_rear_label_center_z()
      - chamber_power_cell_rear_label_line_gap / 2,
    chamber_control_usb_c_left_label_line_2
  );
}

module _chamber_io_roof_recess_cut(model_x_offset) {
  translate([
    chamber_io_panel_center_x() + model_x_offset,
    chamber_io_panel_center_y(),
    chamber_io_panel_seat_z()
  ])
    _rounded_box(
      chamber_io_panel_opening_w(),
      chamber_io_panel_opening_d(),
      chamber_keyboard_lid_inset + 0.6,
      chamber_lid_corner_r + chamber_lid_clearance
    );
}

module _chamber_io_roof_through_cut(model_x_offset) {
  cut_h =
    chamber_io_panel_seat_z() - chamber_io_panel_frame_bottom_z() + 1.2;
  cut_center_z =
    (chamber_io_panel_seat_z() + chamber_io_panel_frame_bottom_z()) / 2;

  difference() {
    translate([
      (
        chamber_io_panel_through_xa()
        + chamber_io_panel_through_xb()
      ) / 2 + model_x_offset,
      (
        chamber_io_panel_through_front_y()
        + chamber_io_panel_through_back_y()
      ) / 2,
      cut_center_z
    ])
      cube([
        chamber_io_panel_through_xb() - chamber_io_panel_through_xa(),
        chamber_io_panel_through_back_y() - chamber_io_panel_through_front_y(),
        cut_h
      ], center = true);

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        translate([
          chamber_io_panel_center_x()
            + sx * (chamber_io_panel_w() / 2 - chamber_lid_mount_inset)
            + model_x_offset,
          chamber_io_panel_center_y()
            + sy * (chamber_io_panel_d / 2 - chamber_lid_mount_inset),
          cut_center_z
        ])
          cube([
            chamber_lid_mount_pad_size,
            chamber_lid_mount_pad_size,
            cut_h + 1.2
          ], center = true);
      }
    }
  }
}

module _chamber_io_roof_mount_cuts(model_x_offset) {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      translate([
        chamber_io_panel_center_x()
          + sx * (chamber_io_panel_w() / 2 - chamber_lid_mount_inset)
          + model_x_offset,
        chamber_io_panel_center_y()
          + sy * (chamber_io_panel_d / 2 - chamber_lid_mount_inset),
        (
          chamber_profile_peak_z()
          + chamber_io_panel_frame_bottom_z()
        ) / 2
      ])
        cylinder(
          d = chamber_lid_mount_screw_clearance_d,
          h = chamber_io_panel_frame_h + 1.2,
          center = true,
          $fn = 32
        );
    }
  }
}

module _chamber_io_roof_cuts(model_x_offset) {
  _chamber_io_roof_recess_cut(model_x_offset);
  _chamber_io_roof_through_cut(model_x_offset);
  _chamber_io_roof_mount_cuts(model_x_offset);
}

module _io_panel_usb_c_jack_cut() {
  translate([
    chamber_io_panel_usb_c_x(),
    chamber_io_panel_usb_c_y(),
    chamber_lid_thickness / 2
  ])
    cylinder(
      d = chamber_control_usb_c_jack_d,
      h = chamber_lid_thickness + 1.2,
      center = true,
      $fn = 72
    );
}

module _io_panel_vertical_label_line_cut(x, y, label_text, label_size) {
  translate([
    x,
    y,
    chamber_lid_thickness - chamber_control_usb_c_label_engrave_h
  ])
    linear_extrude(
      height = chamber_control_usb_c_label_engrave_h + 0.25,
      center = false,
      convexity = 2
    )
      rotate([0, 0, 90])
        text(
          label_text,
          size = label_size,
          font = chamber_label_font,
          halign = "center",
          valign = "center"
        );
}

module _io_panel_horizontal_label_line_cut(x, y, label_text) {
  translate([
    x,
    y,
    chamber_lid_thickness - chamber_control_usb_c_label_engrave_h
  ])
    linear_extrude(
      height = chamber_control_usb_c_label_engrave_h + 0.25,
      center = false,
      convexity = 2
    )
      text(
        label_text,
        size = chamber_io_panel_label_size,
        font = chamber_label_font,
        halign = "center",
        valign = "center"
      );
}

module _io_panel_horizontal_two_line_label_cut(x, y, line_1, line_2) {
  _io_panel_horizontal_label_line_cut(
    x,
    y + chamber_io_panel_label_line_gap / 2,
    line_1
  );
  _io_panel_horizontal_label_line_cut(
    x,
    y - chamber_io_panel_label_line_gap / 2,
    line_2
  );
}

module _center_lid_ptt_button_cut() {
  translate([
    chamber_center_lid_ptt_x_pos(),
    chamber_center_lid_ptt_y_pos(),
    chamber_lid_thickness / 2
  ])
    cylinder(
      d = chamber_arcade_button_mount_d,
      h = chamber_lid_thickness + 1.2,
      center = true,
      $fn = 72
    );
}

module _io_panel_usb_a_jack_cut(x, y = chamber_io_panel_usb_a_y()) {
  translate([
    x,
    y,
    chamber_lid_thickness / 2
  ])
    cylinder(
      d = chamber_io_panel_usb_a_mount_d,
      h = chamber_lid_thickness + 1.2,
      center = true,
      $fn = 72
    );
}

module _io_panel_switch_cut(x, y = chamber_io_panel_switch_y) {
  cut_h = chamber_lid_thickness + 1.2;
  notch_depth = chamber_io_panel_switch_notch_depth();
  notch_overlap = min(0.05, notch_depth / 2);

  translate([
    x,
    y,
    chamber_lid_thickness / 2
  ])
    cylinder(
      d = chamber_io_panel_switch_mount_d,
      h = cut_h,
      center = true,
      $fn = 72
    );

  translate([
    x
      + chamber_io_panel_switch_mount_d / 2
      + notch_depth / 2
      - notch_overlap / 2,
    y,
    chamber_lid_thickness / 2
  ])
    cube([
      notch_depth + notch_overlap,
      chamber_io_panel_switch_notch_w,
      cut_h
    ], center = true);
}

module _io_panel_switch_label_cut(x, label_text) {
  translate([
    x,
    chamber_io_panel_switch_label_y,
    chamber_lid_thickness - chamber_control_usb_c_label_engrave_h
  ])
    linear_extrude(
      height = chamber_control_usb_c_label_engrave_h + 0.25,
      center = false,
      convexity = 2
    )
      text(
        label_text,
        size = chamber_io_panel_switch_label_size,
        font = chamber_label_font,
        halign = "center",
        valign = "center"
      );
}

module _io_panel_control_labels_cut() {
  _io_panel_switch_label_cut(
    chamber_io_panel_switch_fans_x,
    chamber_io_panel_switch_fans_label
  );
  _io_panel_switch_label_cut(
    chamber_io_panel_switch_uv_x,
    chamber_io_panel_switch_uv_label
  );
  _io_panel_switch_label_cut(
    chamber_io_panel_switch_raspberry_x,
    chamber_io_panel_switch_raspberry_label
  );
  _io_panel_switch_label_cut(
    chamber_io_panel_switch_orange_x,
    chamber_io_panel_switch_orange_label
  );
  _io_panel_horizontal_two_line_label_cut(
    chamber_io_panel_usb_c_label_x(),
    chamber_io_panel_usb_c_y(),
    chamber_control_usb_c_right_label_line_1,
    chamber_control_usb_c_right_label_line_2
  );
}

module _center_lid_side_label_cut(x, rotation_z) {
  translate([
    x,
    chamber_center_lid_control_label_y,
    chamber_lid_thickness - chamber_control_usb_c_label_engrave_h
  ])
    linear_extrude(
      height = chamber_control_usb_c_label_engrave_h + 0.25,
      center = false,
      convexity = 2
    )
      rotate([0, 0, rotation_z])
        text(
          chamber_center_lid_control_label,
          size = chamber_io_panel_label_size,
          font = chamber_label_font,
          halign = "center",
          valign = "center"
        );
}

module _center_lid_ptt_label_cuts() {
  _center_lid_side_label_cut(
    -chamber_center_lid_control_label_x,
    90
  );
  _center_lid_side_label_cut(
    chamber_center_lid_control_label_x,
    -90
  );
}

module _center_lid_usb_a_jack_cut() {
  _io_panel_usb_a_jack_cut(
    chamber_center_lid_usb_a_x_pos(),
    chamber_center_lid_usb_a_y_pos()
  );
}

module _chamber_display_void_cut(center_x) {
  translate([
    center_x,
    chamber_display_void_center_y(),
    chamber_display_void_center_z()
  ])
    rotate([chamber_profile_screen_face_angle() - 90, 0, 0])
      translate([
        0,
        (chamber_display_void_depth - chamber_display_void_cut_overlap()) / 2,
        0
      ])
        cube([
          chamber_display_void_x,
          chamber_display_void_depth + chamber_display_void_cut_overlap(),
          chamber_display_void_h
        ], center = true);
}

module _chamber_rear_fan_spacers(center_x) {
  for (sx = [-1, 1]) {
    for (sz = [-1, 1]) {
      translate([
        center_x + sx * chamber_rear_fan_hole_spacing / 2,
        chamber_rear_fan_spacer_center_y(),
        chamber_rear_fan_center_z()
          + sz * chamber_rear_fan_hole_spacing / 2
      ])
        rotate([90, 0, 0])
          cylinder(
            d = chamber_rear_fan_spacer_outer_d,
            h = chamber_rear_fan_spacer_wall_overlap
              + chamber_rear_fan_spacer_projection,
            center = true,
            $fn = 48
          );
    }
  }
}

module _chamber_rear_fan_cut(center_x) {
  translate([
    center_x,
    chamber_piece_y / 2 - chamber_wall / 2,
    chamber_rear_fan_center_z()
  ])
    rotate([90, 0, 0])
      cylinder(
        d = chamber_rear_fan_center_cutout_d,
        h = chamber_wall + 1.2,
        center = true,
        $fn = 96
      );

  for (sx = [-1, 1]) {
    for (sz = [-1, 1]) {
      translate([
        center_x + sx * chamber_rear_fan_hole_spacing / 2,
        chamber_rear_fan_spacer_center_y(),
        chamber_rear_fan_center_z()
          + sz * chamber_rear_fan_hole_spacing / 2
      ])
        rotate([90, 0, 0])
          cylinder(
            d = chamber_rear_fan_mount_hole_d,
            h = chamber_rear_fan_spacer_wall_overlap
              + chamber_rear_fan_spacer_projection
              + 1.2,
            center = true,
            $fn = 36
          );
    }
  }
}

module _chamber_display_mount_screw_cut(center_x, face_offset) {
  translate([
    center_x,
    chamber_display_void_center_y(),
    chamber_display_void_center_z()
  ])
    rotate([chamber_profile_screen_face_angle() - 90, 0, 0])
      translate([0, chamber_display_void_cut_overlap() / 2, face_offset])
        rotate([90, 0, 0])
          cylinder(
            d = chamber_display_mount_screw_clearance_d,
            h = chamber_display_void_cut_overlap() * 2,
            center = true,
            $fn = 36
          );
}

module _chamber_display_mount_screw_cuts(center_x) {
  for (sx = [-1, 1]) {
    for (sz = [-1, 1]) {
      _chamber_display_mount_screw_cut(
        center_x + sx * chamber_display_mount_screw_x_offset,
        sz * chamber_display_mount_screw_face_spacing / 2
      );
    }
  }
}

module _chamber_bolt_cut(joint_face_x, i) {
  translate([joint_face_x, chamber_bolt_y(i), chamber_bolt_z(i)])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_joint_bolt_clearance_d,
        h = chamber_wall * 4 + 1.2,
        center = true,
        $fn = 28
      );
}

module _chamber_handle_mount_screw_cut(side_face_x, i, sy, sz) {
  translate([
    side_face_x,
    handle_mount_screw_y(i, sy),
    handle_chamber_mount_screw_z(sz)
  ])
    rotate([0, 90, 0])
      cylinder(
        d = handle_mount_screw_clearance_d,
        h = chamber_wall * 4 + 1.2,
        center = true,
        $fn = 32
      );
}

module _chamber_handle_mount_screw_cuts(side_face_x) {
  for (i = [0 : 1]) {
    for (sy = [-1, 1]) {
      for (sz = [-1, 1]) {
        _chamber_handle_mount_screw_cut(side_face_x, i, sy, sz);
      }
    }
  }
}

module _chamber_floor_label(center_x, label_text) {
  color([0.70, 0.70, 0.60, 1.0])
    translate([center_x, 0, chamber_bottom + 0.2])
      _label(label_text, 8, 0.35);
}

module _chamber_body(side, assembly_position, label_text) {
  center_x = assembly_position ? chamber_piece_center_x(side) : 0;
  global_body_xa = side < 0 ? chamber_assembly_left_x() : chamber_split_x();
  global_body_xb = side < 0 ? chamber_split_x() : chamber_assembly_right_x();
  model_x_offset = assembly_position ? 0 : -chamber_piece_center_x(side);
  joint_face_x = chamber_split_x() + model_x_offset;
  outer_side_face_x =
    (side < 0 ? global_body_xa : global_body_xb) + model_x_offset;
  wedge_web_x = chamber_display_wedge_left_x() + model_x_offset;
  dome_roof_cut_x = chamber_dome_roof_center_x() + model_x_offset;
  display_void_cut_x = chamber_display_wedge_center_x() + model_x_offset;

  color(side < 0 ? [0.10, 0.105, 0.11, 0.88] : [0.12, 0.115, 0.10, 0.88])
    union() {
      difference() {
        union() {
          _chamber_shell(side, center_x, assembly_position);
          _chamber_rear_fan_spacers(
            chamber_rear_fan_center_x(side) + model_x_offset
          );
        }
        for (i = [0 : chamber_joint_passthrough_count - 1]) {
          _chamber_passthrough_cut(joint_face_x, i);
        }
        _chamber_front_led_strip_passage_cut(joint_face_x);
        _chamber_display_void_cut(display_void_cut_x);
        _chamber_display_mount_screw_cuts(display_void_cut_x);
        _chamber_io_roof_cuts(model_x_offset);
        _chamber_rear_fan_cut(
          chamber_rear_fan_center_x(side) + model_x_offset
        );
        if (side > 0) {
          _right_chamber_tray_rear_opening_cut(
            0 + model_x_offset,
            global_body_xb + model_x_offset
          );
          _right_chamber_tray_backplate_screw_cuts(
            0 + model_x_offset,
            global_body_xb + model_x_offset
          );
          if (!compact_body_enabled) {
            _right_chamber_rpi_side_opening_cut(outer_side_face_x);
            _right_chamber_rpi_side_backplate_screw_cuts(
              outer_side_face_x
            );
          }
        }
        if (side < 0) {
          _chamber_power_cell_rear_jack_cut(
            chamber_power_cell_rear_x() + model_x_offset
          );
          if (!compact_body_enabled) {
            for (i = [0 : chamber_joint_passthrough_count - 1]) {
              _chamber_passthrough_cut(wedge_web_x, i);
            }
            _chamber_front_led_strip_passage_cut(wedge_web_x);
            _chamber_dome_roof_cut(dome_roof_cut_x, chamber_dome_roof_center_y());
            _chamber_dome_mount_screw_cuts(dome_roof_cut_x, chamber_dome_roof_center_y());
          }
        }
        if (side < 0) {
          _chamber_handle_mount_screw_cuts(outer_side_face_x);
        }
        for (i = [0 : chamber_joint_bolt_count - 1]) {
          _chamber_bolt_cut(joint_face_x, i);
        }
      }

      difference() {
        _chamber_io_center_bulkhead(side, joint_face_x);
        for (i = [0 : chamber_io_bulkhead_bolt_count - 1]) {
          _chamber_io_center_bulkhead_bolt_cut(joint_face_x, i);
        }
      }

      if (side < 0) {
        _chamber_power_cell_rear_label(
          chamber_power_cell_rear_x() + model_x_offset
        );
      }
    }

  if (!compact_body_enabled) {
    _chamber_floor_label(center_x, label_text);
  }
}

module _lid_pull_slot(slot_w, slot_d, cut_h) {
  hull() {
    for (sx = [-1, 1]) {
      translate([sx * (slot_w - slot_d) / 2, 0, cut_h / 2])
        cylinder(d = slot_d, h = cut_h, center = true, $fn = 28);
    }
  }
}

module _lid_corner_mount_cut(x, y, cut_h) {
  translate([x, y, cut_h / 2])
    cylinder(
      d = chamber_lid_mount_screw_clearance_d,
      h = cut_h,
      center = true,
      $fn = 32
    );

  translate([
    x,
    y,
    chamber_lid_thickness - chamber_lid_mount_screw_head_depth / 2 + 0.15
  ])
    cylinder(
      d = chamber_lid_mount_screw_head_d,
      h = chamber_lid_mount_screw_head_depth + 0.35,
      center = true,
      $fn = 40
    );
}

module _chamber_lid_panel(
  w,
  d,
  label_text,
  include_title = true,
  include_ptt = false,
  include_pull_slot = true
) {
  label_size = min(8, max(4, w / 10));
  cut_h = chamber_lid_thickness + 0.8;

  difference() {
    _rounded_box(
      w,
      d,
      chamber_lid_thickness,
      min(chamber_lid_corner_r, min(w, d) / 4)
    );

    if (include_pull_slot) {
      translate([
        0,
        -d / 2 + chamber_lid_pull_slot_front_offset,
        -0.4
      ])
        _lid_pull_slot(chamber_lid_pull_slot_w, chamber_lid_pull_slot_d, cut_h);
    }

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _lid_corner_mount_cut(
          sx * (w / 2 - chamber_lid_mount_inset),
          sy * (d / 2 - chamber_lid_mount_inset),
          cut_h
        );
      }
    }

    if (include_title) {
      translate([0, d / 2 - 14, chamber_lid_thickness - 0.35])
        linear_extrude(height = 0.8, center = false, convexity = 2)
          text(
            label_text,
            size = label_size,
            font = chamber_label_font,
            halign = "center",
            valign = "center"
          );
    }

    if (include_ptt) {
      _center_lid_ptt_button_cut();
      _center_lid_ptt_label_cuts();
      _center_lid_usb_a_jack_cut();
    }
  }
}

module _left_lid_aux_cut_pattern(cut_h) {
  translate([0, 0, -0.4])
    cylinder(
      d = chamber_left_lid_center_hole_d,
      h = cut_h,
      center = false,
      $fn = 96
    );

  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      translate([
        sx * chamber_left_lid_m3_pattern_x / 2,
        sy * chamber_left_lid_m3_pattern_y / 2,
        -0.4
      ])
        cylinder(
          d = chamber_left_lid_m3_hole_d,
          h = cut_h,
          center = false,
          $fn = 32
        );
    }
  }
}

module _chamber_left_lid_panel() {
  w = chamber_left_lid_w();
  d = chamber_left_lid_d();
  cut_h = chamber_lid_thickness + 0.8;

  difference() {
    // Reuse the standard lid panel and its four recessed corner fasteners,
    // but disable the obround finger/pull slot for this left lid.
    _chamber_lid_panel(w, d, "LEFT", true, false, false);
    _left_lid_aux_cut_pattern(cut_h);
  }
}

module _chamber_io_panel() {
  w = chamber_io_panel_w();
  d = chamber_io_panel_d;
  cut_h = chamber_lid_thickness + 0.8;

  difference() {
    _rounded_box(
      w,
      d,
      chamber_lid_thickness,
      min(chamber_lid_corner_r, min(w, d) / 4)
    );

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _lid_corner_mount_cut(
          sx * (w / 2 - chamber_lid_mount_inset),
          sy * (d / 2 - chamber_lid_mount_inset),
          cut_h
        );
      }
    }

    _io_panel_usb_a_jack_cut(chamber_io_panel_usb_a_left_x);
    _io_panel_usb_a_jack_cut(chamber_io_panel_usb_a_right_x);
    _io_panel_switch_cut(chamber_io_panel_switch_fans_x);
    _io_panel_switch_cut(chamber_io_panel_switch_uv_x);
    _io_panel_switch_cut(chamber_io_panel_switch_raspberry_x);
    _io_panel_switch_cut(chamber_io_panel_switch_orange_x);
    _io_panel_usb_c_jack_cut();
    _io_panel_control_labels_cut();
  }
}

module _chamber_lid_installed(xa, xb, yf, yb, label_text) {
  translate([
    (xa + xb) / 2,
    (yf + yb) / 2,
    chamber_keyboard_lid_rail_top_z()
  ])
    _chamber_lid_panel(xb - xa, yb - yf, label_text);
}

module _chamber_lid_set_layout() {
  upper_row_w = chamber_right_lid_w() + chamber_lid_layout_gap + chamber_io_panel_w();
  upper_row_d = max(chamber_right_lid_d(), chamber_io_panel_d);
  lower_row_w = compact_body_enabled
    ? chamber_center_lid_w()
    : chamber_left_lid_w() + chamber_lid_layout_gap + chamber_center_lid_w();
  lower_row_d = compact_body_enabled
    ? chamber_main_lid_d()
    : max(chamber_left_lid_d(), chamber_main_lid_d());
  upper_y = chamber_lid_layout_gap / 2 + upper_row_d / 2;
  lower_y = -chamber_lid_layout_gap / 2 - lower_row_d / 2;
  right_x = -upper_row_w / 2 + chamber_right_lid_w() / 2;
  io_x = upper_row_w / 2 - chamber_io_panel_w() / 2;
  left_x = -lower_row_w / 2 + chamber_left_lid_w() / 2;
  center_x = compact_body_enabled
    ? 0
    : lower_row_w / 2 - chamber_center_lid_w() / 2;

  translate([right_x, upper_y, 0])
    _chamber_lid_panel(chamber_right_lid_w(), chamber_right_lid_d(), "RIGHT");

  translate([io_x, upper_y, 0])
    _chamber_io_panel();

  if (!compact_body_enabled) {
    translate([left_x, lower_y, 0])
      _chamber_left_lid_panel();
  }

  translate([center_x, lower_y, 0])
    _chamber_lid_panel(
      chamber_center_lid_w(),
      chamber_main_lid_d(),
      "CENTER",
      false,
      true,
      false
    );
}

module _dome_bucket_lip_screw_cut(sx, sy) {
  translate([
    sx * chamber_dome_mount_screw_xy_offset(),
    sy * chamber_dome_mount_screw_xy_offset(),
    chamber_total_z() + chamber_dome_bucket_lip_h / 2
  ])
    cylinder(
      d = chamber_dome_mount_screw_clearance_d,
      h = chamber_dome_bucket_lip_h + 1.2,
      center = true,
      $fn = 32
    );
}

module _dome_bucket_front_passage_cut() {
  translate([
    0,
    -chamber_dome_bucket_outer_d() / 2,
    chamber_dome_bucket_passage_center_z()
  ])
    cube([
      chamber_dome_bucket_passage_w,
      4 * chamber_dome_bucket_wall,
      chamber_dome_bucket_passage_h
    ], center = true);
}

module _dome_bucket_side_passage_cut() {
  rotate([0, 0, chamber_dome_bucket_side_passage_angle])
    translate([
      chamber_dome_bucket_outer_d() / 2,
      0,
      chamber_dome_bucket_passage_center_z()
    ])
      cube([
        4 * chamber_dome_bucket_wall,
        chamber_dome_bucket_passage_w,
        chamber_dome_bucket_passage_h
      ], center = true);
}

module _dome_bucket_body() {
  join_overlap = 0.6;

  difference() {
    union() {
      difference() {
        cylinder(
          d = chamber_dome_bucket_outer_d(),
          h = chamber_dome_bucket_total_h(),
          center = false,
          $fn = 128
        );
        translate([0, 0, -0.6])
          cylinder(
            d = chamber_dome_bucket_inner_d(),
            h = chamber_dome_bucket_total_h() + 1.2,
            center = false,
            $fn = 128
          );
      }

      translate([0, 0, chamber_dome_bucket_floor_z()])
        cylinder(
          d = chamber_dome_bucket_outer_d(),
          h = chamber_dome_bucket_wall,
          center = false,
          $fn = 128
        );

      translate([0, 0, chamber_total_z() - join_overlap])
        difference() {
          cylinder(
            d = chamber_dome_bucket_lip_outer_d(),
            h = chamber_dome_bucket_lip_h + join_overlap,
            center = false,
            $fn = 128
          );
          translate([0, 0, -0.6])
            cylinder(
              d = chamber_dome_bucket_lip_inner_d(),
              h = chamber_dome_bucket_lip_h + join_overlap + 1.2,
              center = false,
              $fn = 128
            );
        }
    }

    _dome_bucket_front_passage_cut();
    _dome_bucket_side_passage_cut();
    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _dome_bucket_lip_screw_cut(sx, sy);
      }
    }
  }
}

module _dome_bucket_cutaway_body() {
  intersection() {
    _dome_bucket_body();
    translate([
      0,
      chamber_dome_bucket_outer_d() / 4,
      chamber_dome_bucket_total_h() / 2
    ])
      cube([
        chamber_dome_bucket_lip_outer_d() + 2,
        chamber_dome_bucket_outer_d() / 2 + 2,
        chamber_dome_bucket_total_h() + 2
      ], center = true);
  }
}

module _dome_shell_cutaway_body() {
  intersection() {
    sphere(d = chamber_dome_outer_d, $fn = 128);
    translate([0, 0, chamber_dome_outer_d / 4])
      cube([
        chamber_dome_outer_d,
        chamber_dome_outer_d,
        chamber_dome_outer_d / 2
      ], center = true);
    translate([
      0,
      chamber_dome_outer_d / 4,
      chamber_dome_outer_d / 4
    ])
      cube([
        chamber_dome_outer_d + 2,
        chamber_dome_outer_d / 2 + 2,
        chamber_dome_outer_d / 2 + 2
      ], center = true);
  }
}

module _dome_gimbal_obround_slot_y(slot_w, slot_d, cut_h) {
  hull() {
    for (sy = [-1, 1]) {
      translate([0, sy * (slot_d - slot_w) / 2, cut_h / 2])
        cylinder(d = slot_w, h = cut_h, center = true, $fn = 28);
    }
  }
}

module _dome_gimbal_servo_mount_hole_cut(x, y, cut_h) {
  translate([x, y, -0.4])
    cylinder(
      d = dome_gimbal_servo_mount_screw_clearance_d,
      h = cut_h + 0.8,
      center = false,
      $fn = 32
    );
}

module _dome_gimbal_tilt_base_mount_cut(x, y, cut_h) {
  translate([x, y, -0.4])
    cylinder(
      d = dome_gimbal_tilt_base_mount_screw_clearance_d,
      h = cut_h + 0.8,
      center = false,
      $fn = 32
    );
}

module _dome_gimbal_horn_receiver_cuts(cut_h) {
  translate([0, 0, dome_gimbal_horn_pocket_depth / 2 - 0.1])
    cube([
      dome_gimbal_horn_pocket_arm_l,
      dome_gimbal_horn_pocket_arm_w,
      dome_gimbal_horn_pocket_depth + 0.2
    ], center = true);

  translate([0, 0, dome_gimbal_horn_pocket_depth / 2 - 0.1])
    cube([
      dome_gimbal_horn_pocket_arm_w,
      dome_gimbal_horn_pocket_arm_l,
      dome_gimbal_horn_pocket_depth + 0.2
    ], center = true);

  translate([0, 0, -0.4])
    cylinder(
      d = dome_gimbal_horn_hub_clearance_d,
      h = dome_gimbal_horn_pocket_depth + 0.8,
      center = false,
      $fn = 48
    );

  translate([0, 0, -0.4])
    cylinder(
      d = dome_gimbal_horn_center_screw_access_d,
      h = cut_h + 0.8,
      center = false,
      $fn = 40
    );

  for (a = [0, 90]) {
    rotate([0, 0, a])
      for (x = [-dome_gimbal_horn_pocket_arm_l / 4,
                dome_gimbal_horn_pocket_arm_l / 4]) {
        translate([x, 0, -0.4])
          cylinder(
            d = dome_gimbal_horn_mount_screw_d,
            h = cut_h + 0.8,
            center = false,
            $fn = 24
          );
      }
  }
}

module _dome_gimbal_pan_servo_cradle_body() {
  cut_h = dome_gimbal_pan_cradle_h
    + dome_gimbal_pan_cradle_guide_wall_h
    + dome_gimbal_servo_mount_pad_h
    + 1.0;

  difference() {
    union() {
      cylinder(
        d = dome_gimbal_pan_cradle_d,
        h = dome_gimbal_pan_cradle_h,
        center = false,
        $fn = 128
      );

      for (mx = [
        dome_gimbal_servo_mount_x_a,
        dome_gimbal_servo_mount_x_b
      ]) {
        for (my = [
          -dome_gimbal_servo_mount_y_abs,
          dome_gimbal_servo_mount_y_abs
        ]) {
          translate([mx, my, dome_gimbal_pan_cradle_h - 0.2])
            cylinder(
              d = dome_gimbal_servo_mount_pad_d,
              h = dome_gimbal_servo_mount_pad_h + 0.2,
              center = false,
              $fn = 48
            );
        }
      }

      for (sy = [-1, 1]) {
        translate([
          dome_gimbal_pan_servo_body_center_x(),
          sy * (
            dome_gimbal_servo_service_cutout_y / 2
            + dome_gimbal_pan_cradle_guide_wall_t / 2
          ),
          dome_gimbal_pan_cradle_h
            + dome_gimbal_pan_cradle_guide_wall_h / 2
            - 0.1
        ])
          cube([
            dome_gimbal_servo_service_cutout_x
              + 2 * dome_gimbal_pan_cradle_guide_wall_t,
            dome_gimbal_pan_cradle_guide_wall_t,
            dome_gimbal_pan_cradle_guide_wall_h + 0.2
          ], center = true);
      }
    }

    translate([
      dome_gimbal_pan_servo_body_center_x(),
      0,
      dome_gimbal_pan_cradle_h
        - dome_gimbal_pan_cradle_pocket_depth / 2
        + 0.02
    ])
      cube([
        dome_gimbal_servo_service_cutout_x,
        dome_gimbal_servo_service_cutout_y,
        dome_gimbal_pan_cradle_pocket_depth + 0.08
      ], center = true);

    translate([
      dome_gimbal_pan_servo_body_center_x(),
      -dome_gimbal_pan_cradle_wire_slot_d / 2,
      -0.4
    ])
      _dome_gimbal_obround_slot_y(
        dome_gimbal_pan_cradle_wire_slot_w,
        dome_gimbal_pan_cradle_wire_slot_d,
        cut_h
      );

    for (mx = [
      dome_gimbal_servo_mount_x_a,
      dome_gimbal_servo_mount_x_b
    ]) {
      for (my = [
        -dome_gimbal_servo_mount_y_abs,
        dome_gimbal_servo_mount_y_abs
      ]) {
        _dome_gimbal_servo_mount_hole_cut(mx, my, cut_h);
      }
    }
  }
}

module _dome_gimbal_pan_rotating_plate_body() {
  cut_h = dome_gimbal_pan_plate_h + dome_gimbal_pan_hard_stop_h + 1.0;

  difference() {
    union() {
      cylinder(
        d = dome_gimbal_pan_plate_d,
        h = dome_gimbal_pan_plate_h,
        center = false,
        $fn = 128
      );

      for (sx = [-1, 1]) {
        translate([
          sx * dome_gimbal_pan_plate_d / 4,
          dome_gimbal_pan_plate_radius()
            - dome_gimbal_pan_hard_stop_d / 2,
          dome_gimbal_pan_plate_h - 0.2
        ])
          cube([
            dome_gimbal_pan_hard_stop_w,
            dome_gimbal_pan_hard_stop_d,
            dome_gimbal_pan_hard_stop_h + 0.2
          ], center = true);
      }
    }

    _dome_gimbal_horn_receiver_cuts(cut_h);

    translate([
      0,
      -dome_gimbal_pan_plate_cable_slot_d / 2,
      -0.4
    ])
      _dome_gimbal_obround_slot_y(
        dome_gimbal_pan_plate_cable_slot_w,
        dome_gimbal_pan_plate_cable_slot_d,
        cut_h
      );

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _dome_gimbal_tilt_base_mount_cut(
          sx * dome_gimbal_tilt_base_mount_spacing_x / 2,
          sy * dome_gimbal_tilt_base_mount_spacing_y / 2,
          cut_h
        );
      }
    }
  }
}

module _dome_gimbal_tilt_yoke_body() {
  side_x_abs =
    dome_gimbal_tilt_yoke_outer_w / 2
    - dome_gimbal_tilt_yoke_side_t / 2;
  cut_h = dome_gimbal_tilt_yoke_side_t + 1.2;

  difference() {
    union() {
      _rounded_box(
        dome_gimbal_tilt_yoke_outer_w,
        dome_gimbal_tilt_yoke_base_d,
        dome_gimbal_tilt_yoke_base_h,
        min(4, dome_gimbal_tilt_yoke_base_d / 4)
      );

      for (sx = [-1, 1]) {
        translate([
          sx * side_x_abs,
          0,
          dome_gimbal_tilt_yoke_side_h / 2
        ])
          cube([
            dome_gimbal_tilt_yoke_side_t,
            dome_gimbal_tilt_yoke_side_d,
            dome_gimbal_tilt_yoke_side_h
          ], center = true);
      }

      for (sx = [-1, 1]) {
        translate([
          sx * side_x_abs,
          0,
          dome_gimbal_tilt_axis_z
        ])
          rotate([0, 90, 0])
            cylinder(
              d = dome_gimbal_tilt_passive_boss_d,
              h = dome_gimbal_tilt_yoke_side_t + 2.0,
              center = true,
              $fn = 48
            );
      }

      for (sy = [-1, 1]) {
        translate([
          dome_gimbal_tilt_servo_body_center_x(),
          sy * dome_gimbal_tilt_servo_support_rib_y,
          dome_gimbal_tilt_yoke_base_h
            + dome_gimbal_tilt_servo_support_rib_h / 2
            - 0.2
        ])
          cube([
            dome_gimbal_servo_body_x,
            dome_gimbal_tilt_servo_support_rib_w,
            dome_gimbal_tilt_servo_support_rib_h + 0.4
          ], center = true);
      }

      translate([
        0,
        -dome_gimbal_tilt_yoke_base_d / 2
          + minimum_structural_overlap / 2,
        dome_gimbal_tilt_yoke_base_h
      ])
        cube([
          dome_gimbal_tilt_yoke_outer_w
            - 2 * dome_gimbal_tilt_yoke_side_t,
          minimum_structural_overlap,
          minimum_structural_overlap
        ], center = true);
    }

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _dome_gimbal_tilt_base_mount_cut(
          sx * dome_gimbal_tilt_base_mount_spacing_x / 2,
          sy * dome_gimbal_tilt_base_mount_spacing_y / 2,
          dome_gimbal_tilt_yoke_base_h + 0.8
        );
      }
    }

    for (sx = [-1, 1]) {
      translate([
        sx * side_x_abs,
        0,
        dome_gimbal_tilt_axis_z
      ])
        rotate([0, 90, 0])
          cylinder(
            d = dome_gimbal_tilt_axis_clearance_d,
            h = cut_h,
            center = true,
            $fn = 48
          );
    }

    translate([
      0,
      -dome_gimbal_tilt_yoke_base_d / 2
        + dome_gimbal_pan_plate_cable_slot_w / 2,
      -0.4
    ])
      _dome_gimbal_obround_slot_y(
        dome_gimbal_pan_plate_cable_slot_w,
        dome_gimbal_tilt_yoke_base_d / 2,
        dome_gimbal_tilt_yoke_base_h + 0.8
      );
  }
}

module _dome_gimbal_camera_laser_carriage_body() {
  saddle_len = dome_gimbal_laser_len + dome_gimbal_laser_saddle_extra_len;
  saddle_center_y =
    dome_gimbal_camera_laser_carriage_plate_t / 2
    + saddle_len / 2;
  pivot_z = dome_gimbal_camera_laser_carriage_h / 2;

  difference() {
    union() {
      translate([
        0,
        0,
        dome_gimbal_camera_laser_carriage_h / 2
      ])
        cube([
          dome_gimbal_camera_laser_carriage_w,
          dome_gimbal_camera_laser_carriage_plate_t,
          dome_gimbal_camera_laser_carriage_h
        ], center = true);

      for (sx = [-1, 1]) {
        translate([
          sx * dome_gimbal_laser_center_x,
          saddle_center_y,
          pivot_z
        ])
          cube([
            dome_gimbal_laser_saddle_w,
            saddle_len,
            dome_gimbal_laser_saddle_h
          ], center = true);
      }

      for (sx = [-1, 1]) {
        translate([
          sx * dome_gimbal_camera_laser_carriage_w / 2,
          0,
          pivot_z
        ])
          rotate([0, 90, 0])
            cylinder(
              d = dome_gimbal_camera_laser_carriage_pivot_boss_d,
              h = dome_gimbal_camera_laser_carriage_pivot_boss_l,
              center = true,
              $fn = 48
            );
      }
    }

    translate([0, 0, pivot_z])
      rotate([90, 0, 0])
        cylinder(
          d = dome_gimbal_camera_lens_clearance_d,
          h = dome_gimbal_camera_laser_carriage_plate_t + 1.2,
          center = true,
          $fn = 48
        );

    for (sx = [-1, 1]) {
      for (sz = [-1, 1]) {
        translate([
          sx * dome_gimbal_camera_mount_spacing / 2,
          0,
          pivot_z + sz * dome_gimbal_camera_mount_spacing / 2
        ])
          rotate([90, 0, 0])
            cylinder(
              d = dome_gimbal_camera_mount_screw_clearance_d,
              h = dome_gimbal_camera_laser_carriage_plate_t + 1.2,
              center = true,
              $fn = 28
            );
      }
    }

    translate([0, 0, pivot_z - 12])
      cube([
        dome_gimbal_camera_laser_carriage_wire_slot_w,
        dome_gimbal_camera_laser_carriage_plate_t + 1.2,
        dome_gimbal_camera_laser_carriage_wire_slot_h
      ], center = true);

    for (sx = [-1, 1]) {
      translate([
        sx * dome_gimbal_laser_center_x,
        saddle_center_y,
        pivot_z
      ])
        rotate([90, 0, 0])
          cylinder(
            d = dome_gimbal_laser_saddle_clearance_d,
            h = saddle_len + 1.2,
            center = true,
            $fn = 48
          );

      translate([
        sx * dome_gimbal_laser_center_x,
        0,
        pivot_z
      ])
        rotate([90, 0, 0])
          cylinder(
            d = dome_gimbal_laser_saddle_clearance_d,
            h = dome_gimbal_camera_laser_carriage_plate_t + 1.2,
            center = true,
            $fn = 48
          );

      translate([
        sx * dome_gimbal_laser_center_x,
        saddle_center_y + saddle_len / 2 - 1.5,
        pivot_z - dome_gimbal_laser_saddle_h / 2
          + dome_gimbal_laser_wire_slot_h / 2
      ])
        cube([
          dome_gimbal_laser_wire_slot_w,
          4.0,
          dome_gimbal_laser_wire_slot_h
        ], center = true);

      translate([
        sx * dome_gimbal_laser_center_x,
        saddle_center_y,
        pivot_z + dome_gimbal_laser_saddle_h / 2
      ])
        cube([
          dome_gimbal_laser_saddle_w + 1.0,
          saddle_len + 1.0,
          dome_gimbal_laser_saddle_h
        ], center = true);
    }
  }
}

module _dome_gimbal_camera_board_proxy() {
  color([0.02, 0.02, 0.024, 1.0])
    translate([
      0,
      -dome_gimbal_camera_laser_carriage_plate_t / 2 - 0.8,
      dome_gimbal_camera_laser_carriage_h / 2
    ])
      cube([
        dome_gimbal_camera_board_w,
        dome_gimbal_camera_board_t,
        dome_gimbal_camera_board_h
      ], center = true);

  color([0.03, 0.03, 0.035, 1.0])
    translate([
      0,
      -dome_gimbal_camera_laser_carriage_plate_t / 2 - 2.2,
      dome_gimbal_camera_laser_carriage_h / 2
    ])
      rotate([90, 0, 0])
        cylinder(d = 14, h = 4, center = true, $fn = 40);
}

module _dome_gimbal_laser_proxies() {
  saddle_len = dome_gimbal_laser_len + dome_gimbal_laser_saddle_extra_len;
  laser_center_y =
    dome_gimbal_camera_laser_carriage_plate_t / 2
    + dome_gimbal_laser_len / 2;
  pivot_z = dome_gimbal_camera_laser_carriage_h / 2;

  for (sx = [-1, 1]) {
    color([0.55, 0.05, 0.04, 0.86])
      translate([
        sx * dome_gimbal_laser_center_x,
        laser_center_y,
        pivot_z
      ])
        rotate([90, 0, 0])
          cylinder(
            d = dome_gimbal_laser_d,
            h = dome_gimbal_laser_len,
            center = true,
            $fn = 40
          );

    color([0.02, 0.02, 0.02, 1.0])
      translate([
        sx * dome_gimbal_laser_center_x,
        dome_gimbal_camera_laser_carriage_plate_t / 2 + saddle_len,
        pivot_z - 2
      ])
        cube([3, 10, 2], center = true);
  }
}

module _dome_gimbal_pan_servo_proxy() {
  color([0.18, 0.18, 0.17, 0.72])
    translate([
      dome_gimbal_pan_servo_body_center_x(),
      0,
      dome_gimbal_servo_body_z / 2
    ])
      cube([
        dome_gimbal_servo_body_x,
        dome_gimbal_servo_body_y,
        dome_gimbal_servo_body_z
      ], center = true);

  color([0.72, 0.72, 0.66, 0.86])
    translate([0, 0, dome_gimbal_servo_body_z + 1.5])
      cylinder(d = 10, h = 3, center = true, $fn = 40);
}

module _dome_gimbal_tilt_servo_proxy() {
  color([0.18, 0.18, 0.17, 0.72])
    translate([
      dome_gimbal_tilt_servo_body_center_x(),
      0,
      dome_gimbal_tilt_yoke_base_h
        + dome_gimbal_servo_body_y / 2
    ])
      cube([
        dome_gimbal_servo_body_x,
        dome_gimbal_servo_body_y,
        dome_gimbal_servo_body_y
      ], center = true);

  color([0.72, 0.72, 0.66, 0.86])
    translate([
      dome_gimbal_tilt_yoke_half_w()
        - dome_gimbal_tilt_yoke_side_t / 2,
      0,
      dome_gimbal_tilt_axis_z
    ])
      rotate([0, 90, 0])
        cylinder(d = 10, h = 4, center = true, $fn = 40);
}

module _dome_gimbal_wire_route_proxy() {
  color([0.02, 0.02, 0.02, 1.0]) {
    translate([
      0,
      0,
      chamber_dome_bucket_passage_center_z()
    ])
      cube([
        dome_gimbal_camera_laser_carriage_wire_slot_w,
        chamber_dome_bucket_outer_d() / 2,
        3
      ], center = true);

    translate([
      chamber_dome_bucket_outer_d() / 4,
      0,
      chamber_dome_bucket_passage_center_z() + 3
    ])
      cube([
        chamber_dome_bucket_outer_d() / 2,
        4,
        3
      ], center = true);
  }
}

module _dome_gimbal_clearance_mockup_body() {
  color([0.12, 0.65, 0.64, 0.28])
    _dome_bucket_cutaway_body();

  color([0.58, 0.82, 0.98, 0.22])
    translate([0, 0, dome_gimbal_mock_dome_base_z()])
      _dome_shell_cutaway_body();

  translate([0, 0, dome_gimbal_mock_cradle_z()])
    color([0.10, 0.11, 0.105, 1.0])
      _dome_gimbal_pan_servo_cradle_body();

  translate([0, 0, dome_gimbal_mock_cradle_z() + dome_gimbal_pan_cradle_h])
    _dome_gimbal_pan_servo_proxy();

  rotate([0, 0, dome_gimbal_mockup_pan_angle]) {
    translate([0, 0, dome_gimbal_mock_pan_plate_z()])
      color([0.09, 0.12, 0.12, 1.0])
        _dome_gimbal_pan_rotating_plate_body();

    translate([0, 0, dome_gimbal_mock_yoke_z()])
      color([0.12, 0.18, 0.18, 1.0])
        _dome_gimbal_tilt_yoke_body();

    translate([0, 0, dome_gimbal_mock_yoke_z()])
      _dome_gimbal_tilt_servo_proxy();

    translate([0, 0, dome_gimbal_mock_tilt_axis_z()])
      rotate([dome_gimbal_mockup_tilt_angle, 0, 0])
        translate([
          0,
          0,
          -dome_gimbal_camera_laser_carriage_h / 2
        ]) {
          color([0.16, 0.20, 0.20, 1.0])
            _dome_gimbal_camera_laser_carriage_body();
          _dome_gimbal_camera_board_proxy();
          _dome_gimbal_laser_proxies();
        }
  }

  _dome_gimbal_wire_route_proxy();
}

module _right_chamber_tray_backplate_screw_cut_for_tray(sx, sz) {
  screw_z = sz < 0
    ? chamber_tray_backplate_screw_low_z()
    : chamber_tray_backplate_screw_high_z();

  translate([
    sx * chamber_tray_backplate_screw_x_abs(),
    chamber_tray_y_back() + chamber_tray_backplate_t / 2,
    screw_z
  ])
    rotate([90, 0, 0])
      cylinder(
        d = chamber_tray_backplate_screw_clearance_d,
        h = chamber_tray_backplate_t + 1.2,
        center = true,
        $fn = 32
      );
}

module _right_chamber_tray_opi_mount_cut(x, y, cut_h) {
  translate([x, y, chamber_tray_back_opening_z0 - 0.2])
    cylinder(
      d = chamber_tray_opi_mount_screw_clearance_d,
      h = cut_h,
      center = false,
      $fn = 36
    );

  translate([x, y, chamber_tray_back_opening_z0 - 0.2])
    cylinder(
      d = chamber_tray_opi_mount_screw_head_d,
      h = chamber_tray_opi_mount_screw_head_depth + 0.2,
      center = false,
      $fn = 40
    );
}

module _right_chamber_tray_exhaust_cut() {
  translate([
    chamber_tray_exhaust_center_x(),
    chamber_tray_y_back() + chamber_tray_backplate_t / 2,
    chamber_tray_exhaust_center_z()
  ])
    cube([
      chamber_tray_exhaust_w,
      chamber_tray_backplate_t + 1.2,
      chamber_tray_exhaust_h
    ], center = true);
}

module _right_chamber_tray_body() {
  tray_floor_z = chamber_tray_back_opening_z0;
  tray_floor_y_back = chamber_tray_floor_y_back();
  tray_floor_d = tray_floor_y_back - chamber_tray_y_front();
  stud_z = tray_floor_z + chamber_tray_wall - 0.2;

  difference() {
    union() {
      translate([
        -chamber_tray_w() / 2,
        chamber_tray_y_front(),
        tray_floor_z
      ])
        cube([
          chamber_tray_w(),
          tray_floor_d,
          chamber_tray_wall
        ], center = false);

      translate([
        -chamber_tray_backplate_w() / 2,
        chamber_tray_y_back(),
        chamber_tray_backplate_bottom_z()
      ])
        cube([
          chamber_tray_backplate_w(),
          chamber_tray_backplate_t,
          chamber_tray_backplate_body_h()
        ], center = false);

      for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
          translate([
            chamber_tray_opi_center_x()
              + sx * chamber_tray_opi_mount_x_spacing / 2,
            chamber_tray_opi_center_y_pos()
              + sy * chamber_tray_opi_mount_y_spacing / 2,
            stud_z
          ])
            cylinder(
              d = chamber_tray_opi_mount_pad_d,
              h = chamber_tray_opi_mount_stud_h + 0.2,
              center = false,
              $fn = 56
            );
        }
      }

    }

    for (sx = [-1, 1]) {
      for (sz = [-1, 1]) {
        _right_chamber_tray_backplate_screw_cut_for_tray(sx, sz);
      }
    }

    _right_chamber_tray_exhaust_cut();

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _right_chamber_tray_opi_mount_cut(
          chamber_tray_opi_center_x()
            + sx * chamber_tray_opi_mount_x_spacing / 2,
          chamber_tray_opi_center_y_pos()
            + sy * chamber_tray_opi_mount_y_spacing / 2,
          chamber_tray_wall
            + chamber_tray_opi_mount_stud_h
            + 1.0
        );
      }
    }

  }
}

module _right_chamber_rpi_side_tray_backplate_screw_cut(sy, sz) {
  screw_z =
    sz < 0
      ? chamber_rpi_side_tray_screw_low_z()
      : chamber_rpi_side_tray_screw_high_z();

  translate([
    chamber_rpi_side_tray_backplate_t / 2,
    sy * chamber_rpi_side_tray_screw_y_abs(),
    screw_z
  ])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_rpi_side_tray_backplate_screw_clearance_d,
        h = chamber_rpi_side_tray_backplate_t + 1.2,
        center = true,
        $fn = 32
      );
}

module _right_chamber_rpi_side_tray_mount_cut(x, y, cut_h) {
  translate([x, y, chamber_rpi_side_tray_opening_z0 - 0.2])
    cylinder(
      d = chamber_rpi_side_tray_mount_screw_clearance_d,
      h = cut_h,
      center = false,
      $fn = 36
    );

  translate([x, y, chamber_rpi_side_tray_opening_z0 - 0.2])
    cylinder(
      d = chamber_rpi_side_tray_mount_screw_head_d,
      h = chamber_rpi_side_tray_mount_screw_head_depth + 0.2,
      center = false,
      $fn = 40
    );
}

module _right_chamber_rpi_side_tray_body() {
  floor_z = chamber_rpi_side_tray_opening_z0;
  floor_xa = chamber_rpi_side_tray_floor_left_x();
  floor_xb = chamber_rpi_side_tray_floor_right_x();
  floor_y = chamber_rpi_side_tray_span_y();
  floor_x = floor_xb - floor_xa;
  stud_z = floor_z;

  difference() {
    union() {
      translate([
        floor_xa,
        -floor_y / 2,
        floor_z
      ])
        cube([
          floor_x,
          floor_y,
          chamber_rpi_side_tray_wall
        ], center = false);

      translate([
        0,
        -chamber_rpi_side_tray_backplate_y() / 2,
        chamber_rpi_side_tray_opening_z0
      ])
        cube([
          chamber_rpi_side_tray_backplate_t,
          chamber_rpi_side_tray_backplate_y(),
          chamber_rpi_side_tray_backplate_h
            - chamber_rpi_side_tray_opening_z0
        ], center = false);

      for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
          translate([
            chamber_rpi_side_tray_mount_x(sx),
            chamber_rpi_side_tray_mount_y(sy),
            stud_z
          ])
            cylinder(
              d = chamber_rpi_side_tray_mount_pad_d,
              h = chamber_rpi_side_tray_wall
                + chamber_rpi_side_tray_mount_stud_h,
              center = false,
              $fn = 48
            );
        }
      }
    }

    for (sy = [-1, 1]) {
      for (sz = [-1, 1]) {
        _right_chamber_rpi_side_tray_backplate_screw_cut(sy, sz);
      }
    }

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _right_chamber_rpi_side_tray_mount_cut(
          chamber_rpi_side_tray_mount_x(sx),
          chamber_rpi_side_tray_mount_y(sy),
          chamber_rpi_side_tray_wall
            + chamber_rpi_side_tray_mount_stud_h
            + 1.0
        );
      }
    }
  }
}

module _label(text_value, size = 7, h = 0.35) {
  linear_extrude(height = h, center = false, convexity = 2)
    text(
      text_value,
      size = size,
      font = chamber_label_font,
      halign = "center",
      valign = "center"
    );
}

module _handle_cylinder_x(xa, xb, y, z, d) {
  translate([(xa + xb) / 2, y, z])
    rotate([0, 90, 0])
      cylinder(d = d, h = xb - xa, center = true, $fn = 48);
}

module _handle_cylinder_y(x, ya, yb, z, d) {
  translate([x, (ya + yb) / 2, z])
    rotate([90, 0, 0])
      cylinder(d = d, h = yb - ya, center = true, $fn = 48);
}

module _handle_mount_plate(center_y) {
  difference() {
    translate([
      -handle_mount_plate_thickness / 2,
      center_y,
      handle_plate_center_z()
    ])
      cube([
        handle_mount_plate_thickness,
        handle_mount_plate_size,
        handle_mount_plate_size
      ], center = true);

    for (sy = [-1, 1]) {
      for (sz = [-1, 1]) {
        translate([
          -handle_mount_plate_thickness / 2,
          center_y + sy * handle_mount_screw_spacing / 2,
          handle_plate_center_z() + sz * handle_mount_screw_spacing / 2
        ])
          rotate([0, 90, 0])
            cylinder(
              d = handle_mount_screw_clearance_d,
              h = handle_mount_plate_thickness + 1.2,
              center = true,
              $fn = 32
            );
      }
    }
  }
}

module _handle_mount_bevel(center_y) {
  translate([handle_bevel_outer_x(), center_y, handle_plate_center_z()])
    rotate([0, 90, 0])
      cylinder(
        d1 = handle_bar_d,
        d2 = handle_mount_bevel_d,
        h = handle_mount_bevel_len + handle_mount_overlap,
        center = false,
        $fn = 64
      );
}

module _left_side_handle_body() {
  color([0.055, 0.055, 0.052, 1.0])
    for (center_y = [-handle_half_length(), handle_half_length()]) {
      _handle_mount_plate(center_y);
    }

  color([0.12, 0.12, 0.11, 1.0]) {
    _handle_cylinder_y(
      handle_grip_center_x(),
      -handle_half_length(),
      handle_half_length(),
      handle_plate_center_z(),
      handle_bar_d
    );

    for (center_y = [-handle_half_length(), handle_half_length()]) {
      _handle_cylinder_x(
        handle_grip_center_x(),
        handle_bevel_inner_x(),
        center_y,
        handle_plate_center_z(),
        handle_bar_d
      );
      translate([handle_grip_center_x(), center_y, handle_plate_center_z()])
        sphere(d = handle_bar_d, $fn = 48);
      _handle_mount_bevel(center_y);
    }
  }
}

module _case_body() {
  color([0.09, 0.095, 0.10, 0.62])
    _rounded_box(deck_x, deck_y, deck_h, deck_corner_r);

  color([0.18, 0.18, 0.17, 0.92])
    translate([0, 0, deck_top_z()])
      _rounded_box(deck_x - 8, deck_y - 8, top_panel_thickness, max(deck_corner_r - 4, 0));
}

module _front_exhaust() {
  color([0.02, 0.02, 0.018, 1.0])
    translate([opi_exhaust_center_x, opi_exhaust_center_y, deck_top_z() + top_panel_thickness + 0.15])
      cube([opi_exhaust_x, opi_exhaust_y, 0.7], center = true);

  color([0.72, 0.12, 0.08, 1.0])
    translate([opi_exhaust_center_x, opi_exhaust_center_y - opi_exhaust_y / 2 - 1.5, deck_top_z() + top_panel_thickness + 0.8])
      cube([opi_exhaust_x, 2.0, 1.0], center = true);

  for (i = [0 : opi_exhaust_slot_count - 1]) {
    slot_x =
      opi_exhaust_center_x
      - exhaust_total_x() / 2
      + opi_exhaust_slot_w / 2
      + i * exhaust_slot_pitch();
    color([0.0, 0.0, 0.0, 1.0])
      translate([slot_x, opi_exhaust_center_y, deck_top_z() + top_panel_thickness + 1.2])
        cube([opi_exhaust_slot_w, opi_exhaust_slot_y, 1.2], center = true);
  }
}

module _display_assembly() {
  rail_w = (display_rail_x - display_active_x) / 2;
  z0 = deck_top_z() + top_panel_thickness + 0.6;

  if (display_show_rack_rails) {
    color([0.02, 0.02, 0.024, 1.0])
      translate([display_center_x, display_center_y, z0])
        cube([display_active_x, display_active_y, display_raise_h], center = true);

    color([0.16, 0.16, 0.15, 1.0]) {
      translate([display_center_x - display_active_x / 2 - rail_w / 2, display_center_y, z0])
        cube([rail_w, display_rail_y, display_raise_h + 1.0], center = true);
      translate([display_center_x + display_active_x / 2 + rail_w / 2, display_center_y, z0])
        cube([rail_w, display_rail_y, display_raise_h + 1.0], center = true);
    }
  } else {
    color([0.02, 0.02, 0.024, 1.0])
      translate([display_center_x, display_center_y, z0])
        cube([display_visual_x(), display_visual_y(), display_raise_h + 1.0], center = true);
  }

  color([0.03, 0.45, 0.62, 1.0])
    translate([display_center_x, display_center_y, z0 + display_raise_h / 2 + 0.3])
      cube([display_active_x - 10, display_active_y - 10, 0.8], center = true);

  color([0.78, 0.78, 0.70, 1.0]) {
    bolt_span_x = display_show_rack_rails
      ? display_rail_x / 2 - display_bolt_inset_x
      : display_visual_x() / 2 - display_bolt_inset_x;
    bolt_span_y = display_show_rack_rails
      ? display_bolt_spacing_y / 2
      : display_visual_y() / 2 - display_bolt_inset_x;

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        translate([
          display_center_x + sx * bolt_span_x,
          display_center_y + sy * bolt_span_y,
          z0 + display_raise_h / 2 + 1.0
        ])
          cylinder(d = display_bolt_d, h = 1.4, center = true, $fn = 28);
      }
    }
  }
}

module _keyboard_mockup() {
  z0 = deck_top_z() + top_panel_thickness + keyboard_h / 2 + 0.8;

  color([0.035, 0.036, 0.034, 1.0])
    translate([keyboard_center_x, keyboard_center_y, z0])
      cube([keyboard_unfolded_x, keyboard_unfolded_y, keyboard_h], center = true);

  for (i = [1 : keyboard_fold_sections - 1]) {
    fold_x = keyboard_center_x - keyboard_unfolded_x / 2 + i * keyboard_unfolded_x / keyboard_fold_sections;
    color([0.28, 0.28, 0.25, 1.0])
      translate([fold_x, keyboard_center_y, z0 + keyboard_h / 2 + 0.4])
        cube([2.0, keyboard_unfolded_y, 0.8], center = true);
  }

  color([0.14, 0.14, 0.13, 1.0])
    translate([keyboard_center_x, keyboard_center_y, z0 + keyboard_h / 2 + 0.7])
      cube([keyboard_folded_x, keyboard_folded_y, 0.9], center = true);

  color([0.58, 0.58, 0.52, 1.0])
    translate([keyboard_center_x, keyboard_center_y + keyboard_unfolded_y / 2 - 7, z0 + keyboard_h / 2 + 1.1])
      _label("SAMSERS FOLDING KEYBOARD", 6, 0.35);
}

module _eye_internal_apparatus() {
  base_z = deck_top_z() + top_panel_thickness + eye_base_ring_h;

  color([0.10, 0.10, 0.105, 1.0])
    translate([eye_center_x, eye_center_y, deck_top_z() + top_panel_thickness + eye_base_ring_h / 2])
      cylinder(d = eye_dome_d - eye_base_ring_w * 2, h = eye_base_ring_h, center = true, $fn = 96);

  color([0.28, 0.28, 0.26, 1.0])
    translate([eye_center_x, eye_center_y, base_z + 10])
      cylinder(d = 24, h = 20, center = true, $fn = 40);

  color([0.22, 0.22, 0.22, 1.0])
    translate([eye_center_x, eye_center_y, base_z + 26])
      cube([44, 9, 18], center = true);

  color([0.04, 0.04, 0.045, 1.0])
    translate([eye_center_x, eye_center_y - 8, base_z + 26])
      cube([eye_camera_x, 8, eye_camera_z], center = true);

  color([0.02, 0.02, 0.025, 1.0])
    translate([eye_center_x, eye_center_y - 13, base_z + 26])
      cylinder(d = 15, h = 3, center = true, $fn = 36);

  color([0.86, 0.06, 0.04, 1.0])
    translate([eye_center_x + 24, eye_center_y - 7, base_z + 27])
      rotate([90, 0, 0])
        cylinder(d = eye_laser_d, h = eye_laser_len, center = true, $fn = 24);
}

module _eye_dome() {
  dome_z = deck_top_z() + top_panel_thickness + eye_base_ring_h;

  color([0.03, 0.03, 0.032, 1.0])
    translate([eye_center_x, eye_center_y, deck_top_z() + top_panel_thickness + eye_base_ring_h / 2])
      difference() {
        cylinder(d = eye_dome_d + eye_base_ring_w, h = eye_base_ring_h, center = true, $fn = 128);
        cylinder(d = eye_dome_d - eye_base_ring_w, h = eye_base_ring_h + 0.2, center = true, $fn = 128);
      }

  _eye_internal_apparatus();

  color([0.58, 0.82, 0.98, 0.30])
    translate([eye_center_x, eye_center_y, dome_z])
      intersection() {
        sphere(d = eye_dome_d, $fn = 128);
        translate([0, 0, eye_dome_d / 4])
          cube([eye_dome_d, eye_dome_d, eye_dome_d / 2], center = true);
      }
}

module _meshtastic_eink_window() {
  z0 = deck_top_z() + top_panel_thickness + eink_window_h / 2 + 0.8;

  color([0.025, 0.026, 0.024, 1.0])
    translate([eink_center_x, eink_center_y, z0])
      cube([eink_window_x + 10, eink_window_y + 10, eink_window_h], center = true);

  color([0.82, 0.82, 0.72, 1.0])
    translate([eink_center_x, eink_center_y, z0 + eink_window_h / 2 + 0.3])
      cube([eink_window_x, eink_window_y, 0.8], center = true);

  color([0.10, 0.10, 0.09, 1.0])
    translate([eink_center_x, eink_center_y - 2, z0 + eink_window_h / 2 + 0.8])
      _label("MESH", 8, 0.35);
}

module _toggle(label_text, i) {
  y0 = toggle_y(i);
  x0 = toggle_x(i);
  z0 = deck_top_z() + top_panel_thickness;

  color([0.045, 0.045, 0.042, 1.0])
    translate([x0, y0, z0 + toggle_plate_h / 2 + 0.5])
      cube([toggle_plate_x, toggle_plate_y, toggle_plate_h], center = true);

  color([0.80, 0.76, 0.62, 1.0])
    translate([x0, y0, z0 + toggle_plate_h + toggle_lever_h / 2])
      rotate([14, 0, 0])
        cylinder(d = toggle_lever_d, h = toggle_lever_h, center = true, $fn = 20);

  color([0.58, 0.58, 0.50, 1.0])
    translate([x0, y0 - toggle_plate_y / 2 - 3.4, z0 + toggle_plate_h + 0.4])
      _label(label_text, 4.1, 0.3);
}

module _power_toggle_bank() {
  _toggle("MESH", 0);
  _toggle("OPI", 1);
  _toggle("SCRN", 2);
  _toggle("AI", 3);
}

module _proxy_board(name_text, center_x, center_y, size_x, size_y, size_z, body_color) {
  color(body_color)
    translate([center_x, center_y, size_z / 2 + 4])
      cube([size_x, size_y, size_z], center = true);

  color([0.85, 0.85, 0.72, 1.0])
    translate([center_x, center_y, size_z + 4.4])
      _label(name_text, 7, 0.35);
}

module _cell18650_bank() {
  start_x = cell_bank_center_x - ((cell18650_count - 1) * cell_pitch()) / 2;

  for (i = [0 : cell18650_count - 1]) {
    color([0.12, 0.23, 0.18, 0.78])
      translate([start_x + i * cell_pitch(), cell_bank_center_y, cell18650_d / 2 + 4])
        rotate([90, 0, 0])
          cylinder(d = cell18650_d, h = cell18650_len, center = true, $fn = 36);
  }

}

module _internal_hardware_layout() {
  _proxy_board(
    "ORANGE PI 5+",
    opi_proxy_center_x,
    opi_proxy_center_y,
    opi_proxy_x,
    opi_proxy_y,
    opi_proxy_z,
    [0.90, 0.36, 0.12, 0.74]
  );

  _proxy_board(
    "AI CORE",
    rpi_stack_center_x,
    rpi_stack_center_y,
    rpi_stack_proxy_x,
    rpi_stack_proxy_y,
    rpi_stack_proxy_z,
    [0.22, 0.42, 0.90, 0.62]
  );

  _proxy_board(
    "HACKRF",
    hackrf_center_x,
    hackrf_center_y,
    hackrf_proxy_x,
    hackrf_proxy_y,
    hackrf_proxy_z,
    [0.45, 0.28, 0.62, 0.65]
  );

  _proxy_board(
    "MESH",
    meshtastic_center_x,
    meshtastic_center_y,
    meshtastic_proxy_x,
    meshtastic_proxy_y,
    meshtastic_proxy_z,
    [0.20, 0.50, 0.32, 0.62]
  );

  _proxy_board(
    "GPS",
    gps_center_x,
    gps_center_y,
    gps_proxy_x,
    gps_proxy_y,
    gps_proxy_z,
    [0.18, 0.35, 0.18, 0.62]
  );

  _cell18650_bank();
}

module cyberdeck_top_layout_mockup() {
  _assert_dims();
  _case_body();
  _front_exhaust();
  _display_assembly();
  _keyboard_mockup();
  _eye_dome();
  _meshtastic_eink_window();
  _power_toggle_bank();
}

module cyberdeck_internal_layout_mockup() {
  _assert_dims();
  color([0.09, 0.095, 0.10, 0.26])
    _rounded_box(deck_x, deck_y, deck_h, deck_corner_r);
  _front_exhaust();
  _internal_hardware_layout();
}

module cyberdeck_two_chamber_structure() {
  _assert_dims();
  cyberdeck_left_chamber_body(true);
  cyberdeck_right_chamber_body(true);
}

module cyberdeck_left_chamber_body(assembly_position = false) {
  _assert_dims();
  _chamber_body(-1, assembly_position, "LEFT CHAMBER");
}

module cyberdeck_right_chamber_body(assembly_position = false) {
  _assert_dims();
  _chamber_body(1, assembly_position, "RIGHT CHAMBER");
}

module cyberdeck_removable_panel_set() {
  _assert_dims();
  _chamber_lid_set_layout();
}

module cyberdeck_left_front_lid() {
  _assert_dims();
  _chamber_left_lid_panel();
}

module cyberdeck_center_left_lid() {
  _assert_dims();
  _chamber_lid_panel(
    chamber_center_lid_w(),
    chamber_main_lid_d(),
    "CENTER",
    false,
    true,
    false
  );
}

module cyberdeck_right_front_lid() {
  _assert_dims();
  _chamber_lid_panel(chamber_right_lid_w(), chamber_right_lid_d(), "RIGHT");
}

module cyberdeck_left_side_handle() {
  _assert_dims();
  _left_side_handle_body();
}

module cyberdeck_dome_bucket_insert() {
  _assert_dims();
  _dome_bucket_body();
}

module cyberdeck_right_chamber_tray() {
  _assert_dims();
  _right_chamber_tray_body();
}

module cyberdeck_right_chamber_rpi_side_tray() {
  _assert_dims();
  _right_chamber_rpi_side_tray_body();
}

module cyberdeck_dome_pan_servo_cradle() {
  _assert_dims();
  _dome_gimbal_pan_servo_cradle_body();
}

module cyberdeck_dome_pan_rotating_plate() {
  _assert_dims();
  _dome_gimbal_pan_rotating_plate_body();
}

module cyberdeck_dome_tilt_servo_yoke() {
  _assert_dims();
  _dome_gimbal_tilt_yoke_body();
}

module cyberdeck_dome_camera_laser_carriage() {
  _assert_dims();
  _dome_gimbal_camera_laser_carriage_body();
}

module cyberdeck_dome_gimbal_clearance_mockup() {
  _assert_dims();
  _dome_gimbal_clearance_mockup_body();
}

module cyberdeck_right_io_panel() {
  _assert_dims();
  rotate([0, 0, 45])
    _chamber_io_panel();
}

module cyberdeck_visual_mockup() {
  _assert_dims();
  cyberdeck_internal_layout_mockup();
  cyberdeck_top_layout_mockup();
}
