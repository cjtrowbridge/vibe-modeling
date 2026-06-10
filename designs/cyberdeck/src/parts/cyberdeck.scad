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
function chamber_assembly_left_x() = -chamber_piece_x;
function chamber_assembly_right_x() = chamber_piece_x;
function chamber_display_wedge_right_x() = chamber_assembly_right_x();
function chamber_display_wedge_left_x() =
  chamber_display_wedge_right_x() - chamber_display_wedge_x;
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
  chamber_piece_y / 2 - chamber_profile_rear_slope_run;
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
  chamber_dome_roof_front_y();
function chamber_control_band_back_y() =
  chamber_profile_screen_foot_y();
function chamber_control_usb_c_center_y() =
  (chamber_control_band_front_y() + chamber_control_band_back_y()) / 2;
function chamber_control_usb_c_left_x() =
  chamber_display_wedge_center_x() - chamber_display_void_x / 2;
function chamber_control_usb_c_right_x() =
  chamber_display_wedge_center_x() + chamber_display_void_x / 2;
function chamber_control_usb_c_left_label_x() =
  chamber_control_usb_c_left_x()
  + chamber_control_usb_c_jack_d / 2
  + chamber_control_usb_c_label_gap;
function chamber_control_usb_c_right_label_x() =
  chamber_control_usb_c_right_x()
  - chamber_control_usb_c_jack_d / 2
  - chamber_control_usb_c_label_gap;
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
function chamber_profile_rear_slope_len() =
  sqrt(
    chamber_profile_rear_slope_run * chamber_profile_rear_slope_run
    + chamber_profile_rear_slope_drop * chamber_profile_rear_slope_drop
  );
function chamber_display_seam_rail_start_t() =
  chamber_display_seam_rail_bend_inset / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_end_t() =
  1 - chamber_display_seam_rail_start_t();
function chamber_display_seam_rail_y(t) =
  chamber_profile_peak_y() + t * chamber_profile_rear_slope_run;
function chamber_display_seam_rail_z(t) =
  chamber_profile_peak_z() - t * chamber_profile_rear_slope_drop;
function chamber_display_seam_rail_outward_offset() =
  max(chamber_display_seam_rail_d / 2 - chamber_display_seam_rail_embed, 0);
function chamber_display_seam_rail_outward_y() =
  chamber_display_seam_rail_outward_offset()
  * chamber_profile_rear_slope_drop / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_outward_z() =
  chamber_display_seam_rail_outward_offset()
  * chamber_profile_rear_slope_run / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_inner_y(t) =
  chamber_display_seam_rail_y(t)
  - chamber_display_seam_rail_embed
  * chamber_profile_rear_slope_drop / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_inner_z(t) =
  chamber_display_seam_rail_z(t)
  - chamber_display_seam_rail_embed
  * chamber_profile_rear_slope_run / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_outer_y(t) =
  chamber_display_seam_rail_y(t)
  + (chamber_display_seam_rail_d - chamber_display_seam_rail_embed)
  * chamber_profile_rear_slope_drop / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_outer_z(t) =
  chamber_display_seam_rail_z(t)
  + (chamber_display_seam_rail_d - chamber_display_seam_rail_embed)
  * chamber_profile_rear_slope_run / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_vertical_inner_y() =
  chamber_display_seam_rail_inner_y(1);
function chamber_display_seam_rail_vertical_outer_y() =
  chamber_display_seam_rail_outer_y(1);
function chamber_display_seam_rail_vertical_center_y() =
  (
    chamber_display_seam_rail_vertical_inner_y()
    + chamber_display_seam_rail_vertical_outer_y()
  ) / 2;
function chamber_display_seam_rail_vertical_screw_z(i) =
  chamber_display_seam_rail_vertical_screw_bottom_inset
  + i * chamber_display_seam_rail_vertical_screw_spacing;
function chamber_display_seam_rail_screw_count() =
  2 + chamber_display_seam_rail_vertical_screw_count;
function chamber_display_seam_rail_screw_y(i) =
  i < 2
    ? chamber_display_seam_rail_y(
        i == 0 ? chamber_display_seam_rail_start_t() : chamber_display_seam_rail_end_t()
      ) + chamber_display_seam_rail_outward_y()
    : chamber_display_seam_rail_vertical_center_y();
function chamber_display_seam_rail_screw_z(i) =
  i < 2
    ? chamber_display_seam_rail_z(
        i == 0 ? chamber_display_seam_rail_start_t() : chamber_display_seam_rail_end_t()
      ) + chamber_display_seam_rail_outward_z()
    : chamber_display_seam_rail_vertical_screw_z(i - 2);
function chamber_keyboard_lid_rail_top_z() =
  chamber_total_z() - chamber_keyboard_lid_inset;
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
function chamber_lid_set_w() =
  max(
    chamber_right_lid_w(),
    chamber_left_lid_w() + chamber_lid_layout_gap + chamber_center_lid_w()
  );
function chamber_lid_set_d() =
  chamber_main_lid_d() + chamber_lid_layout_gap + max(chamber_left_lid_d(), chamber_main_lid_d());
function chamber_dome_bucket_outer_d() =
  chamber_dome_roof_hole_d - 2 * chamber_dome_bucket_slide_clearance;
function chamber_dome_bucket_inner_d() =
  chamber_dome_bucket_outer_d() - 2 * chamber_dome_bucket_wall;
function chamber_dome_bucket_lip_outer_d() =
  chamber_dome_outer_d;
function chamber_dome_bucket_lip_inner_d() =
  chamber_dome_bucket_outer_d();
function chamber_dome_bucket_total_h() =
  chamber_total_z() + chamber_dome_bucket_lip_h;
function chamber_dome_bucket_floor_z() =
  chamber_dome_bucket_floor_lift;
function chamber_dome_bucket_passage_center_z() =
  chamber_dome_bucket_floor_lift
  + chamber_dome_bucket_wall
  + chamber_dome_bucket_passage_h / 2
  + 4;
function chamber_tray_opening_w() =
  chamber_piece_x - 2 * chamber_tray_back_opening_side_margin;
function chamber_tray_w() =
  chamber_tray_opening_w() - 2 * chamber_tray_slide_clearance;
function chamber_tray_d() =
  chamber_piece_y - chamber_wall - chamber_tray_front_clearance;
function chamber_tray_y_front() =
  -chamber_piece_y / 2 + chamber_tray_front_clearance;
function chamber_tray_y_back() =
  chamber_piece_y / 2;
function chamber_tray_backplate_w() =
  chamber_piece_x - 2 * chamber_tray_backplate_side_clearance;
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
function chamber_tray_opi_board_w() =
  opi_proxy_y;
function chamber_tray_opi_board_d() =
  opi_proxy_x;
function chamber_tray_opi_center_x() =
  -chamber_tray_w() / 2
  + chamber_tray_opi_left_margin
  + chamber_tray_opi_board_w() / 2;
function chamber_tray_opi_center_y_pos() =
  chamber_tray_y_back()
  - chamber_tray_wall
  - chamber_tray_opi_near_exhaust_offset
  - chamber_tray_opi_mount_y_spacing / 2;
function chamber_tray_opi_right_x() =
  chamber_tray_opi_center_x() + chamber_tray_opi_board_w() / 2;
function chamber_tray_rpi_board_w() =
  chamber_tray_rpi_board_y;
function chamber_tray_rpi_board_d() =
  chamber_tray_rpi_board_x;
function chamber_tray_rpi_left_x() =
  chamber_tray_opi_right_x() + chamber_tray_rpi_gap_from_opi;
function chamber_tray_rpi_right_x() =
  chamber_tray_rpi_left_x() + chamber_tray_rpi_board_w();
function chamber_tray_rpi_center_x() =
  (chamber_tray_rpi_left_x() + chamber_tray_rpi_right_x()) / 2;
function chamber_tray_rpi_back_y() =
  chamber_tray_y_back() - chamber_tray_wall - chamber_tray_rpi_near_back_offset;
function chamber_tray_rpi_front_y() =
  chamber_tray_rpi_back_y() - chamber_tray_rpi_board_d();
function chamber_tray_rpi_center_y() =
  (chamber_tray_rpi_front_y() + chamber_tray_rpi_back_y()) / 2;
function chamber_tray_rpi_hole_orig_x(i) =
  i == 0
    ? chamber_tray_rpi_mount_left_inset
    : chamber_tray_rpi_mount_left_inset + chamber_tray_rpi_mount_x_spacing;
function chamber_tray_rpi_hole_orig_y(i) =
  i == 0
    ? chamber_tray_rpi_mount_bottom_inset
    : chamber_tray_rpi_mount_bottom_inset + chamber_tray_rpi_mount_y_spacing;
function chamber_tray_rpi_mount_x(iy) =
  chamber_tray_rpi_left_x() + chamber_tray_rpi_hole_orig_y(iy);
function chamber_tray_rpi_mount_y(ix) =
  chamber_tray_rpi_front_y()
  + (chamber_tray_rpi_board_x - chamber_tray_rpi_hole_orig_x(ix));
function chamber_tray_rail_center_x(side) =
  side
  * (
    chamber_tray_w() / 2
    + chamber_tray_slide_clearance
    + chamber_tray_rail_w / 2
  );
function chamber_tray_rail_inner_x_abs() =
  chamber_tray_w() / 2 + chamber_tray_slide_clearance;
function chamber_display_seam_rail_vertical_bottom_z() =
  chamber_tray_backplate_h + 1;
function chamber_profile_back_wall_z() =
  chamber_profile_peak_z() - chamber_profile_rear_slope_drop;
function chamber_profile_back_wall_rise() =
  chamber_profile_back_wall_z() - chamber_total_z();
function chamber_angled_wall_vertical_offset() = chamber_wall * sqrt(2);
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
  (i == 0 || i == 2 || i == 4) ? chamber_bolt_low_z() : chamber_bolt_high_z();

module _assert_dims() {
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
  assert(chamber_piece_y <= print_volume_y,
    "each chamber must fit the print volume in Y");
  assert(chamber_total_z() <= print_volume_z,
    "each chamber must fit the print volume in Z");
  assert(chamber_wall > 0 && chamber_bottom > 0,
    "chamber wall and bottom thickness must be > 0");
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
  assert(chamber_display_mount_screw_clearance_d > 0,
    "display mount screw clearance must be > 0");
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
  assert(chamber_left_flat_area_x() >= chamber_dome_area_x,
    "left flat dome area is too narrow for the acrylic dome");
  assert(chamber_dome_roof_front_y() >= -chamber_piece_y / 2,
    "dome roof area exceeds the chamber depth");
  assert(chamber_display_wedge_left_x() > chamber_assembly_left_x(),
    "display wedge leaves no flat left-side dome area");
  assert(chamber_display_wedge_left_x() < 0,
    "display wedge left structural web should land inside the left chamber");
  assert(chamber_piece_x > 2 * chamber_wall && chamber_piece_y > 2 * chamber_wall,
    "chamber walls are too thick for the selected footprint");
  assert(chamber_internal_clearance_z >= 50,
    "chamber internal clearance must be at least 50 mm");
  assert(chamber_profile_peak_rise > 0,
    "chamber profile peak rise must be > 0");
  assert(chamber_profile_rear_slope_run > 0,
    "chamber rear slope run must be > 0");
  assert(chamber_profile_rear_slope_drop > 0,
    "chamber rear slope drop must be > 0");
  assert(chamber_profile_screen_slope_run > 0,
    "chamber screen slope run must be > 0");
  assert(abs(chamber_profile_peak_rise - chamber_profile_screen_slope_run) < 0.02,
    "screen face must remain 45 degrees");
  assert(chamber_profile_screen_face_len() >= chamber_display_mount_face_len,
    "screen face length is too short for the display mounting face");
  assert(chamber_profile_peak_z() <= print_volume_z,
    "side profile peak exceeds print volume Z");
  assert(chamber_profile_back_wall_z() > chamber_total_z(),
    "hybrid back wall must remain raised above the flat keyboard deck");
  assert(chamber_profile_back_wall_z() < chamber_profile_peak_z(),
    "hybrid back wall must sit below the side-profile peak");
  assert(chamber_profile_peak_y() < chamber_piece_y / 2,
    "side profile peak must sit forward of the rear edge");
  assert(chamber_profile_screen_foot_y() > -chamber_piece_y / 2,
    "side profile screen slope must meet the flat deck inside the chamber depth");
  assert(chamber_profile_screen_foot_y() < chamber_profile_peak_y(),
    "side profile screen foot must be forward of the peak");
  assert(chamber_display_seam_rail_w > 0
    && chamber_display_seam_rail_d > chamber_display_seam_rail_screw_clearance_d,
    "display seam rail dimensions must clear the screw holes");
  assert(chamber_display_seam_rail_embed > 0
    && chamber_display_seam_rail_embed < chamber_wall,
    "display seam rail embed must stay below wall thickness so it does not protrude inside");
  assert(chamber_display_seam_rail_screw_clearance_d >= 3.0,
    "display seam rail screw holes should clear M3 hardware");
  assert(chamber_display_seam_rail_bend_inset >= chamber_display_seam_rail_d / 2 + chamber_wall,
    "display seam rail screw holes need edge clearance for screw heads and nuts");
  assert(chamber_display_seam_rail_bend_inset > chamber_display_seam_rail_screw_clearance_d
    && 2 * chamber_display_seam_rail_bend_inset < chamber_profile_rear_slope_len(),
    "display seam rail screw holes must stay between the rear-slope bends");
  assert(chamber_display_seam_rail_outer_y(1) - (-chamber_piece_y / 2) <= print_volume_y,
    "display seam rail must fit inside print volume Y");
  assert(chamber_display_seam_rail_vertical_bottom_z() > chamber_tray_backplate_h,
    "rear seam ridge must start above the tray backplate");
  assert(chamber_display_seam_rail_vertical_screw_count >= 0
    && chamber_display_seam_rail_vertical_screw_count
      == floor(chamber_display_seam_rail_vertical_screw_count),
    "display seam rail vertical screw count must be a non-negative integer");
  assert(
    chamber_display_seam_rail_vertical_outer_y()
      - chamber_display_seam_rail_vertical_inner_y()
      > chamber_display_seam_rail_screw_clearance_d + 2 * chamber_wall,
    "display seam rail vertical extension must clear the screw holes");
  if (chamber_display_seam_rail_vertical_screw_count > 0) {
    assert(chamber_display_seam_rail_vertical_screw_bottom_inset
      > chamber_display_seam_rail_screw_clearance_d / 2 + chamber_wall,
      "display seam rail lower screw needs bottom edge clearance");
    let (
      top_screw_z =
        chamber_display_seam_rail_vertical_screw_z(
          chamber_display_seam_rail_vertical_screw_count - 1
        )
    )
      assert(top_screw_z + chamber_display_seam_rail_screw_clearance_d / 2
        < chamber_display_seam_rail_inner_z(1),
        "display seam rail vertical screws must fit below the angled cap");
    assert(chamber_display_seam_rail_vertical_screw_bottom_inset
      > chamber_display_seam_rail_vertical_bottom_z()
        + chamber_display_seam_rail_screw_clearance_d / 2,
      "display seam rail vertical screws must sit above the tray backplate");
  }
  assert(chamber_keyboard_lid_inset > 0
    && chamber_keyboard_lid_rail_top_z() < chamber_total_z(),
    "keyboard lid rail must sit below the flat deck top");
  assert(chamber_keyboard_lid_rail_w > 0 && chamber_keyboard_lid_rail_h > 0,
    "keyboard lid rail dimensions must be > 0");
  assert(chamber_keyboard_lid_rail_center_z() - chamber_keyboard_lid_rail_h / 2 > chamber_bottom,
    "keyboard lid rail must stay above the chamber floor");
  assert(chamber_keyboard_lid_back_edge_y > chamber_keyboard_lid_front_edge_y()
    + 2 * chamber_keyboard_lid_rail_w,
    "keyboard lid rail back edge must leave a usable front opening");
  assert(chamber_keyboard_lid_back_edge_y <= chamber_profile_screen_foot_y() + 0.1,
    "keyboard lid rail back edge must not extend into the screen slope");
  assert(abs(chamber_keyboard_lid_back_edge_y - chamber_keyboard_lid_left_back_edge_y) < 0.1,
    "all front lid rails must share the same rear edge");
  assert(chamber_keyboard_lid_left_back_edge_y > chamber_keyboard_lid_front_edge_y()
    + 2 * chamber_keyboard_lid_rail_w,
    "left keyboard lid rail back edge must leave a usable opening");
  assert(chamber_keyboard_lid_left_back_edge_y <= chamber_dome_roof_front_y() + 0.1,
    "left keyboard lid rail back edge must stay in front of the dome roof");
  assert(chamber_control_band_back_y() > chamber_control_band_front_y() + chamber_wall,
    "front control band must have usable depth");
  assert(chamber_control_usb_c_jack_d > 0,
    "USB-C jack cutout diameter must be > 0");
  assert(chamber_control_usb_c_center_y() - chamber_control_usb_c_jack_d / 2
      >= chamber_control_band_front_y() + chamber_wall
    && chamber_control_usb_c_center_y() + chamber_control_usb_c_jack_d / 2
      <= chamber_control_band_back_y() - chamber_wall,
    "USB-C jack cutouts need front/back material in the control band");
  assert(chamber_control_usb_c_left_x() - chamber_control_usb_c_jack_d / 2
      >= chamber_dome_roof_right_x() + chamber_wall
    && chamber_control_usb_c_right_x() + chamber_control_usb_c_jack_d / 2
      <= chamber_assembly_right_x() - chamber_wall,
    "USB-C jack cutouts need left/right material in the control band");
  assert(chamber_control_usb_c_label_gap >= 0
    && chamber_control_usb_c_label_size > 0
    && chamber_control_usb_c_label_line_gap > chamber_control_usb_c_label_size
    && chamber_control_usb_c_label_engrave_h > 0,
    "USB-C jack label dimensions must be valid");
  assert(chamber_control_usb_c_center_y() - chamber_control_usb_c_label_line_gap / 2
      - chamber_control_usb_c_label_size / 2 >= chamber_control_band_front_y()
    && chamber_control_usb_c_center_y() + chamber_control_usb_c_label_line_gap / 2
      + chamber_control_usb_c_label_size / 2 <= chamber_control_band_back_y(),
    "USB-C jack wrapped labels must fit inside the control band");
  assert(chamber_control_usb_c_left_label_x() > chamber_control_usb_c_left_x()
      + chamber_control_usb_c_jack_d / 2
    && chamber_control_usb_c_right_label_x() < chamber_control_usb_c_right_x()
      - chamber_control_usb_c_jack_d / 2,
    "USB-C jack labels must sit between the jack holes");
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
  assert(chamber_lid_mount_screw_clearance_d >= 3.0,
    "lid screw clearance holes should clear M3 hardware");
  assert(chamber_lid_mount_screw_head_d > chamber_lid_mount_screw_clearance_d
    && chamber_lid_mount_screw_head_depth > 0
    && chamber_lid_mount_screw_head_depth < chamber_lid_thickness,
    "lid screw counterbores must fit inside the lid thickness");
  assert(chamber_left_lid_w() > 2 * chamber_lid_corner_r
    && chamber_left_lid_d() > 2 * chamber_lid_corner_r,
    "left-front lid dimensions are invalid");
  assert(chamber_left_lid_w() > 2 * chamber_lid_mount_inset
    && chamber_left_lid_d() > 2 * chamber_lid_mount_inset
    && chamber_center_lid_w() > 2 * chamber_lid_mount_inset
    && chamber_main_lid_d() > 2 * chamber_lid_mount_inset
    && chamber_right_lid_w() > 2 * chamber_lid_mount_inset,
    "lid corner screw holes must fit inside each lid");
  assert(chamber_center_lid_w() > max(2 * chamber_lid_corner_r, chamber_lid_pull_slot_w)
    && chamber_main_lid_d() > 2 * chamber_lid_corner_r,
    "center-left lid dimensions are invalid");
  assert(chamber_right_lid_w() > chamber_lid_pull_slot_w
    && chamber_main_lid_d() > 2 * chamber_lid_corner_r,
    "right-front lid dimensions are invalid");
  assert(chamber_left_lid_w() <= print_volume_x
    && chamber_left_lid_d() <= print_volume_y
    && chamber_center_lid_w() <= print_volume_x
    && chamber_main_lid_d() <= print_volume_y
    && chamber_right_lid_w() <= print_volume_x
    && chamber_lid_thickness <= print_volume_z,
    "each individual lid must fit the print volume");
  assert(chamber_dome_bucket_wall == 3,
    "dome bucket walls and lip are intentionally fixed at 3 mm for this study");
  assert(chamber_dome_bucket_outer_d() > 2 * chamber_dome_bucket_wall
    && chamber_dome_bucket_outer_d() < chamber_dome_roof_hole_d,
    "dome bucket must slide into the dome roof hole with margin");
  assert(chamber_dome_bucket_lip_outer_d() == chamber_dome_outer_d,
    "dome bucket lip must match the 115 mm acrylic dome outer diameter");
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
  assert(chamber_tray_wall == 3,
    "right chamber tray is intentionally fixed at 3 mm wall thickness for this study");
  assert(chamber_tray_w() > chamber_tray_opi_board_w() + 2 * chamber_tray_opi_mount_pad_d,
    "right chamber tray is too narrow for the Orange Pi proxy mount");
  assert(chamber_tray_d() > chamber_tray_opi_board_d() + 2 * chamber_tray_wall,
    "right chamber tray is too shallow for the Orange Pi proxy mount");
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
      < chamber_tray_backplate_w() / 2
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
  assert(chamber_tray_opi_center_x() - chamber_tray_opi_board_w() / 2
      >= -chamber_tray_w() / 2 + chamber_tray_opi_left_margin - 0.01,
    "Orange Pi tray mount left offset is invalid");
  assert(chamber_tray_opi_center_x() + chamber_tray_opi_mount_x_spacing / 2
      + chamber_tray_opi_mount_pad_d / 2
      <= chamber_tray_w() / 2,
    "Orange Pi tray mount holes exceed tray width");
  assert(chamber_tray_opi_center_y_pos() - chamber_tray_opi_mount_y_spacing / 2
      - chamber_tray_opi_mount_pad_d / 2
      >= chamber_tray_y_front(),
    "Orange Pi tray mount holes exceed tray depth");
  assert(chamber_tray_opi_center_y_pos() + chamber_tray_opi_mount_y_spacing / 2
      <= chamber_tray_y_back() - chamber_tray_wall - chamber_tray_opi_near_exhaust_offset + 0.01,
    "rear Orange Pi stud pair must sit near the tray exhaust wall");
  assert(chamber_tray_opi_mount_y_spacing > chamber_tray_opi_mount_x_spacing,
    "Orange Pi tray mount long spacing should run front-to-back toward the exhaust");
  assert(abs(chamber_tray_rpi_left_x()
      - chamber_tray_opi_right_x()
      - chamber_tray_rpi_gap_from_opi) < 0.01,
    "Raspberry Pi tray mount must keep the requested gap from the Orange Pi");
  assert(chamber_tray_rpi_right_x() + chamber_tray_rpi_mount_pad_d / 2
      <= chamber_tray_w() / 2,
    "Raspberry Pi tray mount exceeds the right side of the tray");
  assert(chamber_tray_rpi_front_y() >= chamber_tray_y_front()
    && chamber_tray_rpi_back_y() <= chamber_tray_y_back() - chamber_tray_wall,
    "Raspberry Pi tray footprint exceeds tray depth");
  assert(chamber_tray_rpi_mount_x_spacing > 0
    && chamber_tray_rpi_mount_y_spacing > 0
    && chamber_tray_rpi_mount_left_inset
      + chamber_tray_rpi_mount_x_spacing < chamber_tray_rpi_board_x
    && chamber_tray_rpi_mount_bottom_inset
      + chamber_tray_rpi_mount_y_spacing < chamber_tray_rpi_board_y,
    "Raspberry Pi mounting diagram dimensions are invalid");
  assert(chamber_tray_rpi_mount_screw_clearance_d >= 2.75,
    "Raspberry Pi tray mount holes should clear M2.5 hardware");
  assert(chamber_tray_rpi_mount_screw_head_d > chamber_tray_rpi_mount_screw_clearance_d
    && chamber_tray_rpi_mount_screw_head_depth > 0
    && chamber_tray_rpi_mount_screw_head_depth <= chamber_tray_wall,
    "Raspberry Pi tray mount underside recess dimensions are invalid");
  assert(chamber_tray_rail_inner_x_abs()
      > chamber_piece_x / 2 - chamber_joint_boss_depth
      - chamber_joint_boss_depth,
    "right chamber tray rails must clear center-joint bolt bosses");
  assert(chamber_joint_passthrough_count == 2,
    "this chamber mockup expects two front/back passthroughs");
  assert(chamber_joint_passthrough_d > 0,
    "chamber passthrough diameter must be > 0");
  assert(chamber_joint_passthrough_spacing_y > 0,
    "chamber passthrough spacing must be > 0");
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
  for (i = [0 : chamber_joint_bolt_count - 1]) {
    assert(abs(chamber_bolt_y(i)) + chamber_joint_bolt_boss_d / 2 <= chamber_piece_y / 2,
      "chamber bolt boss exceeds chamber depth");
    assert(chamber_bolt_z(i) - chamber_joint_bolt_boss_d / 2 >= chamber_bottom,
      "chamber bolt boss intersects the chamber floor");
    assert(chamber_bolt_z(i) + chamber_joint_bolt_boss_d / 2 <= chamber_total_z(),
      "chamber bolt boss exceeds the open chamber height");
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
  global_body_xa = side < 0 ? chamber_assembly_left_x() : 0;
  global_body_xb = side < 0 ? 0 : chamber_assembly_right_x();
  model_x_offset = assembly_position ? 0 : -side * chamber_piece_x / 2;
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
      center_x - chamber_piece_x / 2,
      center_x + chamber_piece_x / 2,
      -chamber_piece_y / 2,
      chamber_piece_y / 2
    );

    if (side > 0) {
      _right_chamber_tray_guide_rails(
        global_body_xa + model_x_offset,
        global_body_xb + model_x_offset
      );
    }

    if (keyboard_rail_xb > keyboard_rail_xa) {
      _chamber_keyboard_lid_support_rail(
        keyboard_rail_xa,
        keyboard_rail_xb,
        chamber_keyboard_lid_back_edge_y
      );
    }

    if (left_keyboard_rail_xb > left_keyboard_rail_xa) {
      _chamber_keyboard_lid_support_rail(
        left_keyboard_rail_xa,
        left_keyboard_rail_xb,
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

module _right_chamber_tray_guide_rails(xa, xb) {
  chamber_center_x = (xa + xb) / 2;
  rail_len = chamber_tray_d() - chamber_tray_backplate_t;
  rail_center_y = chamber_tray_y_front() + rail_len / 2;

  for (side = [-1, 1]) {
    translate([
      chamber_center_x + chamber_tray_rail_center_x(side),
      rail_center_y,
      chamber_bottom + chamber_tray_rail_h / 2
    ])
      cube([
        chamber_tray_rail_w,
        rail_len,
        chamber_tray_rail_h
      ], center = true);
  }
}

module _right_chamber_tray_rear_opening_cut(xa, xb) {
  chamber_center_x = (xa + xb) / 2;

  translate([
    chamber_center_x,
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
  chamber_center_x = (xa + xb) / 2;
  screw_z = sz < 0
    ? chamber_tray_backplate_screw_low_z()
    : chamber_tray_backplate_screw_high_z();

  translate([
    chamber_center_x + sx * chamber_tray_backplate_screw_x_abs(),
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

module _chamber_keyboard_lid_support_rail(xa, xb, y_back) {
  attach_overlap = 0.4;
  outer_xa = xa + chamber_wall - attach_overlap;
  outer_xb = xb - chamber_wall + attach_overlap;
  y_front = chamber_keyboard_lid_front_edge_y();
  outer_y_front = y_front - attach_overlap;
  outer_y_back = y_back;
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
    }
  }
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
    _chamber_profile_prism(
      xa,
      xb,
      y_front,
      y_back,
      0,
      0,
      0,
      0,
      0
    );

    _chamber_profile_prism(
      keep_left_wall ? xa + chamber_wall : xa - 0.6,
      keep_right_wall ? xb - chamber_wall : xb + 0.6,
      y_front + chamber_wall,
      y_back - chamber_wall,
      chamber_bottom,
      0.6,
      -chamber_angled_wall_vertical_offset(),
      -chamber_angled_wall_vertical_offset(),
      -chamber_angled_wall_vertical_offset()
    );
  }
}

module _chamber_profile_prism(
  xa,
  xb,
  y_front,
  y_back,
  z_bottom,
  front_top_extra,
  back_slope_extra,
  screen_slope_extra,
  ridge_extra
) {
  z_flat = chamber_total_z();
  y_screen = chamber_profile_screen_foot_y();
  y_peak = chamber_profile_peak_y();
  z_peak = chamber_profile_peak_z();
  z_back = chamber_profile_back_wall_z();

  multmatrix([
    [0, 0, 1, xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = xb - xa, center = false, convexity = 4)
      polygon(points = concat(
        [
          [y_front, z_bottom],
          [y_back, z_bottom],
          [y_back, z_back + back_slope_extra],
          [y_peak, z_peak + ridge_extra],
          [y_screen, z_flat + screen_slope_extra]
        ],
        front_top_extra == screen_slope_extra
          ? []
          : [[y_screen, z_flat + front_top_extra]],
        [[y_front, z_flat + front_top_extra]]
      ));
}

module _chamber_passthrough_cut(joint_face_x, i) {
  translate([joint_face_x, chamber_passthrough_y(i), chamber_joint_center_z])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_joint_passthrough_d,
        h = chamber_joint_boss_depth * 2 + chamber_wall * 4,
        center = true,
        $fn = 72
      );
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

module _chamber_control_usb_c_jack_cut(center_x) {
  translate([
    center_x,
    chamber_control_usb_c_center_y(),
    chamber_total_z() - chamber_wall / 2
  ])
    cylinder(
      d = chamber_control_usb_c_jack_d,
      h = chamber_wall + 1.2,
      center = true,
      $fn = 72
    );
}

module _chamber_control_usb_c_label_line_cut(x, y, label_text, halign_value) {
  translate([
    x,
    y,
    chamber_total_z() - chamber_control_usb_c_label_engrave_h
  ])
    linear_extrude(
      height = chamber_control_usb_c_label_engrave_h + 0.25,
      center = false,
      convexity = 2
    )
      text(
        label_text,
        size = chamber_control_usb_c_label_size,
        font = chamber_label_font,
        halign = halign_value,
        valign = "center"
      );
}

module _chamber_control_usb_c_label_cut(x, line_1, line_2, halign_value) {
  _chamber_control_usb_c_label_line_cut(
    x,
    chamber_control_usb_c_center_y() + chamber_control_usb_c_label_line_gap / 2,
    line_1,
    halign_value
  );
  _chamber_control_usb_c_label_line_cut(
    x,
    chamber_control_usb_c_center_y() - chamber_control_usb_c_label_line_gap / 2,
    line_2,
    halign_value
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

module _chamber_display_split_rail(side, seam_x) {
  rail_xa = min(seam_x, seam_x + side * chamber_display_seam_rail_w);
  rail_xb = max(seam_x, seam_x + side * chamber_display_seam_rail_w);

  multmatrix([
    [0, 0, 1, rail_xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = rail_xb - rail_xa, center = false, convexity = 4)
      polygon(points = [
        [
          chamber_display_seam_rail_inner_y(0),
          chamber_display_seam_rail_inner_z(0)
        ],
        [
          chamber_display_seam_rail_inner_y(1),
          chamber_display_seam_rail_inner_z(1)
        ],
        [
          chamber_display_seam_rail_vertical_inner_y(),
          chamber_display_seam_rail_vertical_bottom_z()
        ],
        [
          chamber_display_seam_rail_vertical_outer_y(),
          chamber_display_seam_rail_vertical_bottom_z()
        ],
        [
          chamber_display_seam_rail_outer_y(1),
          chamber_display_seam_rail_outer_z(1)
        ],
        [
          chamber_display_seam_rail_outer_y(0),
          chamber_display_seam_rail_outer_z(0)
        ]
      ]);
}

module _chamber_display_split_rail_screw_cut(seam_x, i) {
  translate([
    seam_x,
    chamber_display_seam_rail_screw_y(i),
    chamber_display_seam_rail_screw_z(i)
  ])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_display_seam_rail_screw_clearance_d,
        h = 2 * chamber_display_seam_rail_w + 2 * chamber_wall,
        center = true,
        $fn = 32
      );
}

module _chamber_display_split_rail_screw_cuts(seam_x) {
  for (i = [0 : chamber_display_seam_rail_screw_count() - 1]) {
    _chamber_display_split_rail_screw_cut(seam_x, i);
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
        h = chamber_joint_boss_depth * 2 + chamber_wall * 4,
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

module _chamber_joint_reinforcement(side, joint_face_x) {
  boss_center_x = joint_face_x + side * chamber_joint_boss_depth / 2;

  for (i = [0 : chamber_joint_bolt_count - 1]) {
    translate([boss_center_x, chamber_bolt_y(i), chamber_bolt_z(i)])
      rotate([0, 90, 0])
        cylinder(
          d = chamber_joint_bolt_boss_d,
          h = chamber_joint_boss_depth,
          center = true,
          $fn = 36
        );
  }
}

module _chamber_floor_label(center_x, label_text) {
  color([0.70, 0.70, 0.60, 1.0])
    translate([center_x, 0, chamber_bottom + 0.2])
      _label(label_text, 8, 0.35);
}

module _chamber_body(side, assembly_position, label_text) {
  center_x = assembly_position ? side * chamber_piece_x / 2 : 0;
  global_body_xa = side < 0 ? chamber_assembly_left_x() : 0;
  global_body_xb = side < 0 ? 0 : chamber_assembly_right_x();
  joint_face_x = assembly_position ? 0 : -side * chamber_piece_x / 2;
  model_x_offset = assembly_position ? 0 : -side * chamber_piece_x / 2;
  outer_side_face_x =
    (side < 0 ? global_body_xa : global_body_xb) + model_x_offset;
  wedge_web_x = chamber_display_wedge_left_x() + model_x_offset;
  dome_roof_cut_x = chamber_dome_roof_center_x() + model_x_offset;
  display_void_cut_x = chamber_display_wedge_center_x() + model_x_offset;
  display_split_rail_x = model_x_offset;

  color(side < 0 ? [0.10, 0.105, 0.11, 0.88] : [0.12, 0.115, 0.10, 0.88])
    difference() {
      union() {
        _chamber_shell(side, center_x, assembly_position);
        _chamber_joint_reinforcement(side, joint_face_x);
        _chamber_display_split_rail(side, display_split_rail_x);
      }
      for (i = [0 : chamber_joint_passthrough_count - 1]) {
        _chamber_passthrough_cut(joint_face_x, i);
      }
      _chamber_display_void_cut(display_void_cut_x);
      _chamber_display_mount_screw_cuts(display_void_cut_x);
      _chamber_display_split_rail_screw_cuts(display_split_rail_x);
      if (side > 0) {
        _right_chamber_tray_rear_opening_cut(
          global_body_xa + model_x_offset,
          global_body_xb + model_x_offset
        );
        _right_chamber_tray_backplate_screw_cuts(
          global_body_xa + model_x_offset,
          global_body_xb + model_x_offset
        );
      }
      for (x = [chamber_control_usb_c_left_x(), chamber_control_usb_c_right_x()]) {
        _chamber_control_usb_c_jack_cut(x + model_x_offset);
      }
      _chamber_control_usb_c_label_cut(
        chamber_control_usb_c_left_label_x() + model_x_offset,
        chamber_control_usb_c_left_label_line_1,
        chamber_control_usb_c_left_label_line_2,
        "left"
      );
      _chamber_control_usb_c_label_cut(
        chamber_control_usb_c_right_label_x() + model_x_offset,
        chamber_control_usb_c_right_label_line_1,
        chamber_control_usb_c_right_label_line_2,
        "right"
      );
      if (side < 0) {
        for (i = [0 : chamber_joint_passthrough_count - 1]) {
          _chamber_passthrough_cut(wedge_web_x, i);
        }
        _chamber_dome_roof_cut(dome_roof_cut_x, chamber_dome_roof_center_y());
        _chamber_dome_mount_screw_cuts(dome_roof_cut_x, chamber_dome_roof_center_y());
      }
      _chamber_handle_mount_screw_cuts(outer_side_face_x);
      for (i = [0 : chamber_joint_bolt_count - 1]) {
        _chamber_bolt_cut(joint_face_x, i);
      }
    }

  _chamber_floor_label(center_x, label_text);
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

module _chamber_lid_panel(w, d, label_text) {
  label_size = min(8, max(4, w / 10));
  cut_h = chamber_lid_thickness + 0.8;

  difference() {
    _rounded_box(
      w,
      d,
      chamber_lid_thickness,
      min(chamber_lid_corner_r, min(w, d) / 4)
    );

    translate([
      0,
      -d / 2 + chamber_lid_pull_slot_front_offset,
      -0.4
    ])
      _lid_pull_slot(chamber_lid_pull_slot_w, chamber_lid_pull_slot_d, cut_h);

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        _lid_corner_mount_cut(
          sx * (w / 2 - chamber_lid_mount_inset),
          sy * (d / 2 - chamber_lid_mount_inset),
          cut_h
        );
      }
    }

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
  lower_row_w = chamber_left_lid_w() + chamber_lid_layout_gap + chamber_center_lid_w();
  lower_row_d = max(chamber_left_lid_d(), chamber_main_lid_d());
  upper_y = lower_row_d / 2 + chamber_lid_layout_gap / 2;
  lower_y = -chamber_main_lid_d() / 2 - chamber_lid_layout_gap / 2;
  left_x = -lower_row_w / 2 + chamber_left_lid_w() / 2;
  center_x = lower_row_w / 2 - chamber_center_lid_w() / 2;

  translate([0, upper_y, 0])
    _chamber_lid_panel(chamber_right_lid_w(), chamber_main_lid_d(), "RIGHT");

  translate([left_x, lower_y, 0])
    _chamber_lid_panel(chamber_left_lid_w(), chamber_left_lid_d(), "LEFT");

  translate([center_x, lower_y, 0])
    _chamber_lid_panel(chamber_center_lid_w(), chamber_main_lid_d(), "CENTER");
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
          h = chamber_total_z(),
          center = false,
          $fn = 128
        );
        translate([0, 0, -0.6])
          cylinder(
            d = chamber_dome_bucket_inner_d(),
            h = chamber_total_z() + 1.2,
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
              d = chamber_dome_bucket_lip_inner_d() - 2 * join_overlap,
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

module _right_chamber_tray_rpi_mount_cut(x, y, cut_h) {
  translate([x, y, chamber_tray_back_opening_z0 - 0.2])
    cylinder(
      d = chamber_tray_rpi_mount_screw_clearance_d,
      h = cut_h,
      center = false,
      $fn = 32
    );

  translate([x, y, chamber_tray_back_opening_z0 - 0.2])
    cylinder(
      d = chamber_tray_rpi_mount_screw_head_d,
      h = chamber_tray_rpi_mount_screw_head_depth + 0.2,
      center = false,
      $fn = 36
    );
}

module _right_chamber_tray_exhaust_cut() {
  translate([
    chamber_tray_opi_center_x(),
    chamber_tray_y_back() + chamber_tray_backplate_t / 2,
    chamber_tray_exhaust_center_z
  ])
    cube([
      chamber_tray_exhaust_w,
      chamber_tray_backplate_t + 1.2,
      chamber_tray_exhaust_h
    ], center = true);
}

module _right_chamber_tray_body() {
  tray_floor_z = chamber_tray_back_opening_z0;
  tray_floor_y_back = chamber_tray_y_back() + 0.6;
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

      for (side = [-1, 1]) {
        translate([
          side < 0 ? -chamber_tray_w() / 2 : chamber_tray_w() / 2 - chamber_tray_wall,
          chamber_tray_y_front(),
          tray_floor_z
        ])
          cube([
            chamber_tray_wall,
            tray_floor_d,
            chamber_tray_side_wall_h
          ], center = false);
      }

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

      for (ix = [0, 1]) {
        for (iy = [0, 1]) {
          translate([
            chamber_tray_rpi_mount_x(iy),
            chamber_tray_rpi_mount_y(ix),
            stud_z
          ])
            cylinder(
              d = chamber_tray_rpi_mount_pad_d,
              h = chamber_tray_rpi_mount_stud_h + 0.2,
              center = false,
              $fn = 48
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

    for (ix = [0, 1]) {
      for (iy = [0, 1]) {
        _right_chamber_tray_rpi_mount_cut(
          chamber_tray_rpi_mount_x(iy),
          chamber_tray_rpi_mount_y(ix),
          chamber_tray_wall
            + chamber_tray_rpi_mount_stud_h
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

module cyberdeck_three_lid_set() {
  _assert_dims();
  _chamber_lid_set_layout();
}

module cyberdeck_left_front_lid() {
  _assert_dims();
  _chamber_lid_panel(chamber_left_lid_w(), chamber_left_lid_d(), "LEFT");
}

module cyberdeck_center_left_lid() {
  _assert_dims();
  _chamber_lid_panel(chamber_center_lid_w(), chamber_main_lid_d(), "CENTER");
}

module cyberdeck_right_front_lid() {
  _assert_dims();
  _chamber_lid_panel(chamber_right_lid_w(), chamber_main_lid_d(), "RIGHT");
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

module cyberdeck_visual_mockup() {
  _assert_dims();
  cyberdeck_internal_layout_mockup();
  cyberdeck_top_layout_mockup();
}
