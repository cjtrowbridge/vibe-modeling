// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl designs/winegard_gm6000_logic_backplane/src/main.scad -D part_id=0 ...

include <lib/defaults.scad>;
include <parts/winegard_gm6000_logic_backplane.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  winegard_gm6000_logic_backplane();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
