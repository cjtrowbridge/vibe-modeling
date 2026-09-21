// Scripted export entrypoint for the fan guard.
// part_id map: 1 = printable fan guard (plate + four M3-bored standoff posts).

include <lib/defaults.scad>;
include <parts/fan_guard.scad>;

if (part_id == 1) {
  fan_guard();
} else {
  assert(false, str("Unknown part_id: ", part_id));
}
