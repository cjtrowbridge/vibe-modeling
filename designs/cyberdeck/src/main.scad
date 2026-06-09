// Entry point for scripted exports.
// part_id map:
// 0 = full visual mockup
// 1 = top layout mockup
// 2 = internal hardware proxy layout
// 3 = two-piece open chamber structure
// 4 = left open chamber printable body
// 5 = right open chamber printable body

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
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
