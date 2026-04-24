// Entry point for scripted exports.
// part_id map:
// 0 = base plate with studs
// 1 = Orange Pi Zero 2W board mockup
// 2 = assembly preview (plate + board)

include <lib/defaults.scad>;
include <parts/opi_zero_2w_carrier.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  opi_zero_2w_carrier();
} else if (_part_id == 1) {
  opi_zero_2w_board_mock();
} else if (_part_id == 2) {
  opi_zero_2w_carrier_assembly_preview();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
