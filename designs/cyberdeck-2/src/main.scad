include <lib/rack_v2_0_0.scad>;
include <lib/defaults.scad>;
include <parts/enclosure_blockout.scad>;

part_id = is_undef(part_id) ? 90 : part_id;
assembly_view_id = is_undef(assembly_view_id) ? 0 : assembly_view_id;
show_proxies = is_undef(show_proxies) ? false : show_proxies;

blockout_contract_assertions()
resolved_rack_datum_assertions() {
  if (part_id == 1) {
    enclosure_left_print();
  } else if (part_id == 2) {
    enclosure_right_print();
  } else if (part_id == 3) {
    port_plate_left_print();
  } else if (part_id == 4) {
    port_plate_right_print();
  } else if (part_id == 90) {
    assembly_review(view_id = assembly_view_id, proxies = show_proxies);
  } else if (part_id == 91) {
    assembled_enclosure();
  } else {
    assert(false, str("Unknown part_id: ", part_id));
  }
}
