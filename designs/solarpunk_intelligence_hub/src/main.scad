// Scripted export entry point for the Solarpunk Intelligence Hub.
// part_id map:
// 1 = printable backplane plate (169 x 187 x 3 mm, 22x M3 holes)
// 2 = block diagram mockup (reference only, NOT printable)

include <lib/defaults.scad>;
include <parts/solarpunk_intelligence_hub.scad>;
include <parts/backplane_blockout_mockup.scad>;

_part_id = is_undef(part_id) ? 1 : part_id;

if (_part_id == 1) {
    solarpunk_intelligence_hub();
} else if (_part_id == 2) {
    backplane_blockout_mockup();
} else {
    assert(false, str("Unknown part_id: ", _part_id));
}