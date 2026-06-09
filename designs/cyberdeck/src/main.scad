// Entry point for scripted exports.
// part_id map:
// 0 = full visual mockup
// 1 = top layout mockup
// 2 = internal hardware proxy layout

include <lib/defaults.scad>;
include <parts/cyberdeck.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  cyberdeck_visual_mockup();
} else if (_part_id == 1) {
  cyberdeck_top_layout_mockup();
} else if (_part_id == 2) {
  cyberdeck_internal_layout_mockup();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
