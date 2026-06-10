// Entry point for scripted exports.
// part_id map:
// 0 = full visual mockup
// 1 = top layout mockup
// 2 = internal hardware proxy layout
// 3 = two-piece open chamber structure
// 4 = left open chamber printable body
// 5 = right open chamber printable body
// 6 = three inset lid preview layout
// 7 = left-front inset lid
// 8 = center-left inset lid
// 9 = right-front inset lid
// 10 = left-side carrying handle
// 11 = dome bucket insert
// 12 = right chamber Orange Pi tray

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
  cyberdeck_three_lid_set();
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
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
