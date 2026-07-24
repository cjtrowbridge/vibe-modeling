// Scripted export entry point.
// part_id map:
// 0 = two-part assembly preview
// 1 = door-side redirector
// 2 = bed-side redirector
// 3 = measured AC vent-and-rail reference mockup

include <lib/defaults.scad>;
include <parts/ac_redirectors.scad>;
include <parts/ac_vent_rail_mockup.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  ac_redirectors_preview();
} else if (_part_id == 1) {
  door_side_redirector();
} else if (_part_id == 2) {
  bed_side_redirector();
} else if (_part_id == 3) {
  ac_vent_rail_mockup();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
