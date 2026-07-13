// Entry point for scripted exports.
// part_id map:
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
// 20 = left chamber battery drawer
// 21 = left chamber Meshtastic drawer

include <lib/defaults.scad>;
include <parts/cyberdeck.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  cyberdeck_visual_mockup();
} else if (_part_id == 1) {
  cyberdeck_top_layout_mockup();
} else if (_part_id == 2) {
  cyberdeck_internal_layout_mockup();
} else if (_part_id == 3) {
  cyberdeck_two_chamber_structure();
} else if (_part_id == 4) {
  cyberdeck_left_chamber_body();
} else if (_part_id == 5) {
  cyberdeck_right_chamber_body();
} else if (_part_id == 6) {
  cyberdeck_removable_panel_set();
} else if (_part_id == 7) {
  cyberdeck_left_front_lid();
} else if (_part_id == 8) {
  cyberdeck_center_left_lid();
} else if (_part_id == 9) {
  cyberdeck_right_front_lid();
} else if (_part_id == 10) {
  cyberdeck_left_side_handle();
} else if (_part_id == 11) {
  cyberdeck_dome_bucket_insert();
} else if (_part_id == 12) {
  cyberdeck_right_chamber_tray();
} else if (_part_id == 13) {
  cyberdeck_right_io_panel();
} else if (_part_id == 14) {
  cyberdeck_right_chamber_rpi_side_tray();
} else if (_part_id == 15) {
  cyberdeck_dome_pan_servo_cradle();
} else if (_part_id == 16) {
  cyberdeck_dome_pan_rotating_plate();
} else if (_part_id == 17) {
  cyberdeck_dome_tilt_servo_yoke();
} else if (_part_id == 18) {
  cyberdeck_dome_camera_laser_carriage();
} else if (_part_id == 19) {
  cyberdeck_dome_gimbal_clearance_mockup();
} else if (_part_id == 20) {
  cyberdeck_left_battery_drawer();
} else if (_part_id == 21) {
  cyberdeck_left_meshtastic_drawer();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
