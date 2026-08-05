// Scripted export entrypoint for the Comrade robot base.
// part_id map: 0 = printable core base plate.

include <lib/defaults.scad>;
include <parts/core_base.scad>;

if (part_id == 0) {
  comrade_core_base();
} else {
  assert(false, str("Unknown part_id: ", part_id));
}
