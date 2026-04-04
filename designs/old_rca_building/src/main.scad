// Entry point for scripted exports.
// Usage:
//   openscad -o out.stl designs/old_rca_building/src/main.scad -D part_id=0 ...

include <lib/defaults.scad>;
include <parts/old_rca_building.scad>;

_part_id = is_undef(part_id) ? 0 : part_id;

if (_part_id == 0) {
  old_rca_building_model();
} else if (_part_id == 1) {
  old_rca_building_outer_mass();
} else if (_part_id == 2) {
  old_rca_building_negative_cuts();
} else if (_part_id == 3) {
  old_rca_building_internal_supports();
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
