// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl designs/example_box/src/main.scad -D part_id=0 ...

include <lib/defaults.scad>;
include <parts/example_box.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  example_box();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
