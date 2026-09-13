// Scripted export entrypoint for the micro cyberdeck open-front case.
// part_id map: 0 = printable case body.

include <lib/defaults.scad>;
include <parts/case_body.scad>;

if (part_id == 0) {
  micro_cyberdeck_case_body();
} else {
  assert(false, str("Unknown part_id: ", part_id));
}
