// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl cad/designs/helical/src/main.scad -D part_id=0 -D post_od=45 ...

include <lib/defaults.scad>;
include <parts/feed_mount.scad>;
include <parts/helical_former.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  feed_mount();
} else if (_part_id == 1) {
  helical_former();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
