// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl designs/gigachad_xavier_void/src/main.scad -D part_id=0 ...

include <lib/defaults.scad>;
include <parts/gigachad_xavier_void.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  gigachad_xavier_void_positive();
} else if (_part_id == 1) {
  main_back_prism();
} else if (_part_id == 2) {
  top_shaft();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
