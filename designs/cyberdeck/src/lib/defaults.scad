// Cyberdeck first-draft visual mockup defaults (all dimensions in mm).
//
// Coordinate convention:
// - x: left/right across the cyberdeck, positive to the right
// - y: front/back across the cyberdeck, positive toward the top/back edge
// - z: vertical from the bottom of the case
//
// This revision is a visual layout mockup. Board/module dimensions that are
// not yet measured are named as proxy values and should not be treated as
// final mechanical constraints.

// Repository structural minimums.
minimum_wall_thickness = 3.0;
minimum_structural_overlap = minimum_wall_thickness;
minimum_internal_edge_width = minimum_wall_thickness;

// Revision 0006 compact-body mode. Older configs retain the legacy envelope.
compact_body_enabled = false;

// Part selector
// 0 = full visual mockup
// 1 = top layout mockup
// 2 = internal hardware proxy layout
// 3 = two-piece open chamber structure
// 4 = left open chamber printable body
// 5 = right open chamber printable body
// 6 = four removable panel preview layout
// 7 = left-front inset lid
// 8 = center-left inset lid
// 9 = right-front inset lid
// 10 = left-side carrying handle
// 11 = dome bucket insert
// 12 = right chamber Orange Pi tray
// 13 = removable full-width rear-roof I/O panel
// 14 = right chamber Raspberry Pi side tray
// 15 = dome pan servo cradle
// 16 = dome pan rotating plate
// 17 = dome tilt servo yoke
// 18 = dome camera and dual-laser carriage
// 19 = dome gimbal clearance mockup
part_id = 3;

// Case envelope
deck_x = 480.0;
deck_y = 300.0;
deck_h = 42.0;
deck_corner_r = 12.0;
top_panel_thickness = 3.0;

// Two-piece printable chamber structure
print_volume_x = 220.0;
print_volume_y = 220.0;
print_volume_z = 220.0;
chamber_piece_y = 210.0;
// The flat lid rail is inset 2 mm below the deck top, so 72 mm yields the
// required 70 mm clear height from the interior floor to the lid underside.
chamber_internal_clearance_z = 72.0;
chamber_min_flat_lid_internal_clearance_z = 70.0;
chamber_wall = 3.0;
chamber_bottom = 3.0;
chamber_display_cutout_h = 85.0;
chamber_display_mount_margin = 5.0;
chamber_display_mount_face_len = chamber_display_cutout_h + 2 * chamber_display_mount_margin;
chamber_display_mount_width = 250.0;
chamber_display_mount_side_margin = 5.0;
chamber_display_wedge_x = 314.0;
chamber_display_void_x = 210.0;
chamber_display_void_h = 87.0;
chamber_display_void_depth = 25.4;
chamber_display_mount_screw_right_x = 115.0;
chamber_display_mount_screw_face_spacing = 76.2;
chamber_display_mount_screw_clearance_d = 3.4;
chamber_dome_outer_d = 115.0;
chamber_dome_mount_margin = 5.0;
chamber_dome_area_x = chamber_dome_outer_d + 2 * chamber_dome_mount_margin;
chamber_dome_area_y = chamber_dome_outer_d + 2 * chamber_dome_mount_margin;
chamber_dome_roof_hole_d = 96.0;
chamber_dome_mount_screw_radius = 56.0;
chamber_dome_mount_screw_clearance_d = 3.4;
chamber_piece_x = (chamber_display_wedge_x + chamber_dome_area_x) / 2;
chamber_profile_peak_rise = chamber_display_mount_face_len / sqrt(2);
chamber_rear_housing_depth = 51.2;
chamber_profile_screen_slope_run = chamber_display_mount_face_len / sqrt(2);
chamber_rear_fan_frame = 40.0;
chamber_rear_fan_hole_spacing = 32.0;
chamber_rear_fan_mount_hole_d = 4.2;
chamber_rear_fan_center_cutout_d = 28.0;
chamber_rear_fan_edge_margin = 3.0;
chamber_rear_fan_screw_head_d = 6.0;
chamber_rear_fan_spacer_projection = 2.0;
chamber_rear_fan_spacer_wall_overlap = chamber_wall;
chamber_rear_fan_spacer_outer_d =
  chamber_rear_fan_mount_hole_d + 2 * minimum_internal_edge_width + 0.2;
chamber_label_font = "Bahnschrift:style=SemiBold";
chamber_control_usb_c_jack_d = 23.0;
chamber_control_usb_c_label_gap = 3.0;
chamber_control_usb_c_label_size = 4.2;
chamber_control_usb_c_label_line_gap = 5.6;
chamber_control_usb_c_label_engrave_h = 0.55;
chamber_control_usb_c_left_label_line_1 = "Power";
chamber_control_usb_c_left_label_line_2 = "Cell";
chamber_control_usb_c_right_label_line_1 = "Neural";
chamber_control_usb_c_right_label_line_2 = "Jack";
chamber_power_cell_rear_label_size = 3.4;
chamber_power_cell_rear_label_line_gap = 4.4;
chamber_io_panel_d = 44.0;
chamber_io_panel_screen_border = 3.0;
chamber_io_panel_separator_d = 3.0;
chamber_io_panel_support_w = 6.0;
chamber_io_panel_frame_h = 5.0;
chamber_io_bulkhead_wall = 3.0;
chamber_io_bulkhead_bolt_count = 2;
chamber_io_bulkhead_bolt_clearance_d = 3.4;
chamber_io_bulkhead_front_bolt_offset_y = 18.0;
chamber_io_bulkhead_rear_bolt_offset_y = 36.0;
chamber_io_bulkhead_front_bolt_drop_z = 9.0;
chamber_io_bulkhead_rear_bolt_drop_z = 22.0;
chamber_arcade_button_mount_d = 28.0;
chamber_arcade_button_outer_d = 35.0;
chamber_arcade_button_mount_margin = 5.0;
chamber_display_left_arcade_button_x = 130.0;
chamber_display_screen_face_hardware_face_spacing = 40.0;
chamber_shell_wedge_tray_overlap = minimum_structural_overlap;
chamber_left_seam_counterbore_d = 7.0;
chamber_left_seam_counterbore_depth = 2.4;
chamber_left_seam_reinforcement_t = chamber_left_seam_counterbore_depth;
chamber_io_panel_usb_a_mount_d = 29.0;
chamber_io_panel_usb_a_outer_d = 31.75;
// Keep the complete USB-A flange envelope outside the physical 250 mm screen
// bracket, then let the compact wedge derive its outer edge from this datum.
chamber_display_screen_hardware_clearance = minimum_internal_edge_width;
chamber_display_right_screen_port_x =
  chamber_display_mount_width / 2
  + chamber_io_panel_usb_a_outer_d / 2
  + chamber_display_screen_hardware_clearance;
chamber_io_panel_usb_a_flange_gap = 3.0;
chamber_io_panel_usb_a_neural_jack_gap = 10.0;
chamber_io_panel_usb_a_left_x = -15.15;
chamber_io_panel_usb_a_right_x = 45.8;
chamber_io_panel_switch_mount_d = 20.0;
chamber_io_panel_switch_keyed_span_x = 20.8;
chamber_io_panel_switch_notch_w = 2.2;
chamber_io_panel_switch_outer_d = 23.2;
chamber_io_panel_switch_fans_x = -105.7;
chamber_io_panel_switch_uv_x = -79.4;
chamber_io_panel_switch_raspberry_x = -45.65;
chamber_io_panel_switch_orange_x = 15.325;
chamber_io_panel_switch_y = 0.0;
chamber_io_panel_switch_label_y = -16.3;
chamber_io_panel_switch_label_size = 3.3;
chamber_io_panel_switch_fans_label = "Fans";
chamber_io_panel_switch_uv_label = "Ultraviolet";
chamber_io_panel_switch_raspberry_label = "Raspberry";
chamber_io_panel_switch_orange_label = "Orange";
chamber_io_panel_switch_fans_width_per_size = 2.55;
chamber_io_panel_switch_uv_width_per_size = 6.94;
chamber_io_panel_switch_raspberry_width_per_size = 6.19847;
chamber_io_panel_switch_orange_width_per_size = 4.15;
chamber_io_panel_label_size = 5.48;
chamber_io_panel_label_line_gap = 6.2;
chamber_io_panel_label_edge_margin = 5.0;
chamber_io_panel_label_mount_margin = 5.0;
chamber_io_panel_raspberry_width_per_size = 6.19847;
chamber_io_panel_rotated_label_thickness_per_size = 1.280298;
chamber_io_panel_horizontal_label_height_per_size = 0.996159;
chamber_io_panel_neural_width_per_size = 3.96151;
chamber_center_lid_ptt_x = 0.0;
chamber_center_lid_ptt_y = 17.375;
chamber_center_lid_usb_a_x = 0.0;
chamber_center_lid_usb_a_y = -19.0;
chamber_center_lid_control_label_x = 23.8;
chamber_center_lid_control_label_y = -0.8125;
chamber_center_lid_control_label = "Push To Talk";
chamber_center_lid_control_label_width_per_size = 6.5;
chamber_center_lid_support_fit_clearance_d = 9.0;
chamber_io_panel_usb_a_left_label = "Raspberry";
chamber_io_panel_usb_a_right_label = "Orange";
handle_length = 100.0;
handle_standoff = 40.0;
handle_bar_d = 14.0;
handle_mount_plate_size = 40.0;
handle_mount_plate_thickness = 3.0;
handle_mount_screw_clearance_d = 3.4;
handle_mount_screw_spacing = 26.0;
handle_mount_bevel_d = 30.0;
handle_mount_bevel_len = 16.0;
handle_mount_overlap = 0.8;
chamber_keyboard_lid_inset = 2.0;
chamber_keyboard_lid_rail_w = 6.5;
chamber_keyboard_lid_rail_h = 3.0;
chamber_keyboard_lid_left_back_edge_y = chamber_piece_y / 2 - chamber_dome_area_y;
chamber_keyboard_lid_back_edge_y = chamber_keyboard_lid_left_back_edge_y;
chamber_lid_clearance = 0.6;
chamber_lid_thickness = 5.0;
chamber_lid_corner_r = 3.0;
chamber_lid_pull_slot_w = 28.0;
chamber_lid_pull_slot_d = 8.0;
chamber_lid_pull_slot_front_offset = 15.0;
chamber_lid_layout_gap = 12.0;
chamber_lid_mount_inset = 6.5;
chamber_lid_mount_pad_size = 13.4;
chamber_lid_mount_screw_clearance_d = 3.4;
chamber_lid_mount_screw_head_d = 7.0;
chamber_lid_mount_screw_head_depth = 2.4;
// Left-front lid auxiliary mounting/cable pattern.
// The 80 mm span is intentionally across X because the finished lid is only
// about 80.8 mm deep, which leaves no structural edge material for an
// 80 mm front/back pattern.
chamber_left_lid_center_hole_d = 30.0;
chamber_left_lid_m3_pattern_x = 80.0;
chamber_left_lid_m3_pattern_y = 40.0;
chamber_left_lid_m3_hole_d = chamber_lid_mount_screw_clearance_d;
chamber_dome_bucket_wall = 3.0;
chamber_dome_bucket_slide_clearance = 1.0;
chamber_dome_bucket_lip_h = 3.0;
chamber_dome_bucket_lip_screw_edge_margin = 3.0;
chamber_dome_bucket_floor_lift = 3.0;
chamber_dome_bucket_passage_w = 24.0;
chamber_dome_bucket_passage_h = 16.0;
chamber_dome_bucket_side_passage_angle = 0.0;

// Dome pan/tilt gimbal prototype
dome_gimbal_servo_model = "MG996R-compatible standard servo";
dome_gimbal_servo_profile = "mg996r_standard_servo_profile_v1";
dome_gimbal_servo_body_x = 40.7;
dome_gimbal_servo_body_y = 20.0;
dome_gimbal_servo_body_z = 40.7;
dome_gimbal_servo_service_cutout_x = 41.1;
dome_gimbal_servo_service_cutout_y = 20.8;
dome_gimbal_servo_mount_x_a = -36.0;
dome_gimbal_servo_mount_x_b = 14.0;
dome_gimbal_servo_mount_y_abs = 5.0;
dome_gimbal_servo_mount_screw_clearance_d = 3.3;
dome_gimbal_servo_mount_pad_d = 10.0;
dome_gimbal_servo_mount_pad_h = 3.0;
dome_gimbal_pan_cradle_d = 82.0;
dome_gimbal_pan_cradle_h = 3.0;
dome_gimbal_pan_cradle_pocket_depth = 1.2;
dome_gimbal_pan_cradle_guide_wall_t = 3.0;
dome_gimbal_pan_cradle_guide_wall_h = 8.0;
dome_gimbal_pan_cradle_wire_slot_w = 14.0;
dome_gimbal_pan_cradle_wire_slot_d = 22.0;
dome_gimbal_pan_plate_d = 80.0;
dome_gimbal_pan_plate_h = 4.0;
dome_gimbal_pan_plate_cable_slot_w = 14.0;
dome_gimbal_pan_plate_cable_slot_d = 32.0;
dome_gimbal_pan_hard_stop_w = 8.0;
dome_gimbal_pan_hard_stop_d = 10.0;
dome_gimbal_pan_hard_stop_h = 6.0;
dome_gimbal_horn_pocket_depth = 2.2;
dome_gimbal_horn_pocket_arm_w = 8.0;
dome_gimbal_horn_pocket_arm_l = 34.0;
dome_gimbal_horn_hub_clearance_d = 14.0;
dome_gimbal_horn_center_screw_access_d = 7.0;
dome_gimbal_horn_mount_screw_d = 2.4;
dome_gimbal_tilt_yoke_outer_w = 83.0;
dome_gimbal_tilt_yoke_base_d = 24.0;
dome_gimbal_tilt_yoke_base_h = 4.0;
dome_gimbal_tilt_yoke_side_t = 3.0;
dome_gimbal_tilt_yoke_side_d = 20.0;
dome_gimbal_tilt_yoke_side_h = 38.0;
dome_gimbal_tilt_axis_z = 19.0;
dome_gimbal_tilt_axis_clearance_d = 12.0;
dome_gimbal_tilt_passive_axle_d = 5.0;
dome_gimbal_tilt_passive_boss_d = 16.0;
dome_gimbal_tilt_base_mount_spacing_x = 46.0;
dome_gimbal_tilt_base_mount_spacing_y = 12.0;
dome_gimbal_tilt_base_mount_screw_clearance_d = 3.4;
dome_gimbal_tilt_servo_support_rib_w = 3.0;
dome_gimbal_tilt_servo_support_rib_h = 4.0;
dome_gimbal_tilt_servo_support_rib_y = 7.5;
dome_gimbal_camera_board_w = 32.0;
dome_gimbal_camera_board_h = 32.0;
dome_gimbal_camera_board_t = 2.0;
dome_gimbal_camera_lens_clearance_d = 18.0;
dome_gimbal_camera_mount_spacing = 26.0;
dome_gimbal_camera_mount_screw_clearance_d = 2.4;
dome_gimbal_laser_d = 12.0;
dome_gimbal_laser_len = 35.0;
dome_gimbal_laser_saddle_clearance_d = 12.8;
dome_gimbal_laser_center_x = 24.0;
dome_gimbal_laser_saddle_w = 19.0;
dome_gimbal_laser_saddle_h = 14.0;
dome_gimbal_laser_saddle_extra_len = 4.0;
dome_gimbal_laser_wire_slot_w = 5.0;
dome_gimbal_laser_wire_slot_h = 6.0;
dome_gimbal_camera_laser_carriage_w = 76.0;
dome_gimbal_camera_laser_carriage_h = 40.0;
dome_gimbal_camera_laser_carriage_plate_t = 3.0;
dome_gimbal_camera_laser_carriage_pivot_boss_d = 16.0;
dome_gimbal_camera_laser_carriage_pivot_boss_l = 6.0;
dome_gimbal_camera_laser_carriage_wire_slot_w = 16.0;
dome_gimbal_camera_laser_carriage_wire_slot_h = 8.0;
dome_gimbal_mockup_pan_angle = 25.0;
dome_gimbal_mockup_tilt_angle = -10.0;
chamber_tray_wall = 3.0;
chamber_tray_slide_clearance = 1.0;
chamber_tray_board_clearance_xy = 3.0;
chamber_tray_service_depth = 10.0;
chamber_tray_back_opening_z0 = chamber_bottom;
chamber_tray_back_opening_h = 44.0;
chamber_tray_backplate_t = 3.0;
chamber_tray_backplate_h = 55.0;
chamber_tray_backplate_screw_clearance_d = 3.4;
chamber_tray_backplate_screw_edge_margin = 3.0;
chamber_tray_backplate_screw_side_offset = 4.8;
chamber_tray_backplate_screw_z_offset = 8.0;
chamber_tray_backplate_single_row_z = 27.5;
chamber_tray_opi_board_x = 115.0;
chamber_tray_opi_board_y = 100.0;
chamber_tray_opi_board_thickness = 1.8;
chamber_tray_opi_mount_x_spacing = 94.0;
chamber_tray_opi_mount_y_spacing = 98.0;
chamber_tray_opi_rear_row_wall_inset = 3.0;
chamber_tray_opi_mount_pad_d = 10.0;
chamber_tray_opi_mount_stud_h = 3.0;
chamber_tray_opi_standoff_z = 10.0;
chamber_tray_opi_mount_screw_clearance_d = 3.0;
chamber_tray_opi_mount_screw_head_d = 6.0;
chamber_tray_opi_mount_screw_head_depth = 2.2;
chamber_tray_exhaust_w = 79.0;
chamber_tray_exhaust_h = 24.0;
chamber_tray_exhaust_x_offset = 5.0;
chamber_tray_exhaust_z_from_board_top = 12.0;
chamber_rpi_side_tray_wall = 3.0;
chamber_rpi_side_tray_slide_clearance = 1.0;
chamber_rpi_side_tray_board_clearance_x = 4.5;
chamber_rpi_side_tray_board_clearance_y = 4.0;
chamber_rpi_side_tray_opening_z0 = chamber_bottom;
chamber_rpi_side_tray_opening_h = 44.0;
chamber_rpi_side_tray_backplate_t = 3.0;
chamber_rpi_side_tray_backplate_h = 55.0;
chamber_rpi_side_tray_backplate_screw_clearance_d = 3.4;
chamber_rpi_side_tray_backplate_screw_edge_margin = 3.0;
chamber_rpi_side_tray_backplate_screw_side_offset = 4.8;
chamber_rpi_side_tray_backplate_screw_z_offset = 8.0;
chamber_rpi_side_tray_backplate_single_row_z = 27.5;
chamber_rpi_side_tray_board_x = 85.0;
chamber_rpi_side_tray_board_y = 56.0;
chamber_rpi_side_tray_board_center_y = -1.0;
chamber_rpi_side_tray_mount_edge_inset = 3.5;
chamber_rpi_side_tray_mount_x_spacing = 49.0;
chamber_rpi_side_tray_mount_y_spacing = 58.0;
chamber_rpi_side_tray_mount_pad_d = 9.0;
chamber_rpi_side_tray_mount_stud_h = 3.0;
chamber_rpi_side_tray_mount_screw_clearance_d = 2.75;
chamber_rpi_side_tray_mount_screw_head_d = 5.8;
chamber_rpi_side_tray_mount_screw_head_depth = 2.0;
chamber_left_drawer_wall = 3.0;
chamber_left_drawer_floor_t = chamber_left_drawer_wall;
chamber_left_drawer_slide_clearance = 1.0;
chamber_left_drawer_payload_w = 60.0;
chamber_left_drawer_payload_h = 60.0;
chamber_left_drawer_payload_d = 160.0;
chamber_left_drawer_fit_clearance = 1.0;
chamber_left_drawer_side_wall_h = 60.0;
chamber_left_drawer_divider_w = 5.0;
chamber_left_drawer_opening_z0 = chamber_bottom;
chamber_left_drawer_backplate_t = 3.0;
chamber_left_drawer_backplate_screw_clearance_d = 3.4;
chamber_left_drawer_backplate_screw_edge_margin = 5.0;
chamber_left_drawer_backplate_screw_z_offset = 8.0;
chamber_left_drawer_backplate_single_row_z = 33.0;
chamber_left_drawer_fastener_head_d = 7.0;
chamber_left_drawer_fastener_nut_flat_d = 5.5;
chamber_left_drawer_fastener_install_clearance = 3.0;
chamber_left_battery_display_window_front_offset = 80.0;
chamber_left_battery_display_window_rear_offset = 140.0;
chamber_left_battery_display_window_floor_bottom_offset = 15.0;
chamber_left_battery_display_window_floor_top_offset = 50.0;
chamber_joint_passthrough_count = 2;
chamber_joint_passthrough_d = 30.0;
chamber_joint_passthrough_front_y = -52.5;
chamber_joint_passthrough_rear_y = 47.15;
chamber_joint_passthrough_spacing_y =
  chamber_joint_passthrough_rear_y - chamber_joint_passthrough_front_y;
chamber_joint_center_y = 0.0;
chamber_joint_center_z = 22.0;
chamber_joint_bolt_count = 6;
chamber_joint_bolt_edge_inset_y = 14.0;
chamber_joint_bolt_edge_inset_z = 10.0;
chamber_joint_center_upper_bolt_z = 38.0;
chamber_joint_bolt_clearance_d = 3.4;
chamber_front_led_strip_passage_d = 15.0;

// Secondary display and rack rails
display_active_x = 208.0;
display_active_y = 85.0;
display_rail_x = 250.0;
display_rail_y = 89.0;
display_show_rack_rails = true;
display_bezel_margin = 6.0;
display_center_x = 70.0;
display_center_y = 48.0;
display_raise_h = 4.0;
display_bolt_d = 5.0;
display_bolt_inset_x = 8.0;
display_bolt_spacing_y = 65.0;

// Samsers foldable keyboard
keyboard_unfolded_x = 342.9;
keyboard_unfolded_y = 114.3;
keyboard_folded_x = 180.0;
keyboard_folded_y = 115.0;
keyboard_center_x = 50.0;
keyboard_center_y = -60.0;
keyboard_h = 8.0;
keyboard_fold_sections = 3;

// Acrylic eye module
eye_dome_d = 101.6;
eye_center_x = -175.0;
eye_center_y = 61.0;
eye_base_ring_h = 5.0;
eye_base_ring_w = 7.0;
eye_camera_x = 32.0;
eye_camera_y = 32.0;
eye_camera_z = 18.0;
eye_laser_d = 5.0;
eye_laser_len = 34.0;

// Meshtastic e-ink visibility window
eink_window_x = 54.0;
eink_window_y = 32.0;
eink_center_x = 105.0;
eink_center_y = 116.0;
eink_window_h = 2.0;

// Independent hardware power toggles
toggle_count = 4;
toggle_bank_center_x = -22.0;
toggle_bank_center_y = 116.0;
toggle_columns = 4;
toggle_spacing_x = 28.0;
toggle_spacing_y = 27.0;
toggle_plate_x = 22.0;
toggle_plate_y = 18.0;
toggle_plate_h = 2.0;
toggle_lever_d = 4.0;
toggle_lever_h = 14.0;

// Front/top Orange Pi exhaust path
opi_exhaust_x = 100.0;
opi_exhaust_y = 18.0;
opi_exhaust_center_x = -24.0;
opi_exhaust_center_y = -deck_y / 2 + 8.0;
opi_exhaust_slot_count = 8;
opi_exhaust_slot_w = 7.0;
opi_exhaust_slot_gap = 5.0;
opi_exhaust_slot_y = 13.0;

// Internal proxy hardware volumes
opi_proxy_x = 100.0;
opi_proxy_y = 70.0;
opi_proxy_z = 18.0;
opi_proxy_center_x = opi_exhaust_center_x;
opi_proxy_center_y = -108.0;

rpi_stack_proxy_x = 95.0;
rpi_stack_proxy_y = 68.0;
rpi_stack_proxy_z = 28.0;
rpi_stack_center_x = -70.0;
rpi_stack_center_y = 8.0;

hackrf_proxy_x = 125.0;
hackrf_proxy_y = 45.0;
hackrf_proxy_z = 14.0;
hackrf_center_x = 98.0;
hackrf_center_y = -28.0;

meshtastic_proxy_x = 58.0;
meshtastic_proxy_y = 36.0;
meshtastic_proxy_z = 10.0;
meshtastic_center_x = eink_center_x;
meshtastic_center_y = eink_center_y;

gps_proxy_x = 28.0;
gps_proxy_y = 28.0;
gps_proxy_z = 7.0;
gps_center_x = -150.0;
gps_center_y = 8.0;

cell18650_d = 18.6;
cell18650_len = 65.0;
cell18650_count = 4;
cell_bank_center_x = 120.0;
cell_bank_center_y = 112.0;
