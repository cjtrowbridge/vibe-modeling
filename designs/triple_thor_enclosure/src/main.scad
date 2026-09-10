include <lib/defaults.scad>;
include <parts/base_sector.scad>;
include <parts/column.scad>;
include <parts/cap_sector.scad>;
include <parts/exhaust_ring.scad>;
include <parts/proxies.scad>;
include <parts/assembly_review.scad>;

_part_id = is_undef(part_id) ? 1 : part_id;

blockout_contract_assertions();

if (_part_id == 1) {
  base_sector_print();
} else if (_part_id == 2) {
  column_print();
} else if (_part_id == 3) {
  cap_sector_print();
} else if (_part_id == 4) {
  exhaust_ring_print();
} else if (_part_id == 90) {
  assembly_review(0, true);
} else {
  assert(false, str("Unknown part_id: ", _part_id));
}
