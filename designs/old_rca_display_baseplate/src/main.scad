// Entry point for old_rca_display_baseplate exports.
// part_id map:
// 0 = full baseplate
// 1 = left half (lengthwise split)
// 2 = right half (lengthwise split)

include <lib/defaults.scad>;
include <parts/baseplate.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  old_rca_display_baseplate();
} else if (_part_id == 1) {
  old_rca_display_baseplate_left_half();
} else if (_part_id == 2) {
  old_rca_display_baseplate_right_half();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
