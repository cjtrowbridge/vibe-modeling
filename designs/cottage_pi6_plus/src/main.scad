// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl designs/cottage_pi6_plus/src/main.scad -D part_id=0 ...
//   part_id: 0=assembled preview, 1=base, 2=roof, 3=drawer

include <lib/defaults.scad>;
include <parts/cottage_pi6_plus.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  cottage_pi6_plus();
} else if (_part_id == 1) {
  cottage_pi6_plus_base();
} else if (_part_id == 2) {
  cottage_pi6_plus_roof();
} else if (_part_id == 3) {
  cottage_pi6_plus_drawer();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
