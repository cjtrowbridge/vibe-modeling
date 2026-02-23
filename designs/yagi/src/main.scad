// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl cad/designs/yagi/src/main.scad -D part_id=0 ...

include <lib/defaults.scad>;
include <parts/yagi_mount.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  yagi_mount();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}

