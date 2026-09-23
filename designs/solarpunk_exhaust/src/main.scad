// Solarpunk exhaust — scripted export entry point.
//
// Part dispatch (scad_build.py / scad_build_all.py inject `part_id` + `part`):
//   part_id 1 -> solarpunk_exhaust (the printable 120 mm fan mounting plate)
//   part_id 2 -> fan_proxy (reference mockup, NOT printable; intelligence-hub
//                blockout precedent)
//   part_id 90 -> product-assembly review scene (assembly.json
//                review_dispatch_id); dispatched by scripts/scad_render_assembly_review.py
//
// All layout lives in lib/defaults.scad; parts never hardcode size-derived
// constants.

include <lib/defaults.scad>;
include <parts/solarpunk_exhaust.scad>;
include <parts/fan_proxy.scad>;
include <parts/assembly_review.scad>;

// Build contract: part_id 1 -> printable plate; part_id 2 -> fan proxy
// (reference only); part_id 90 -> product-assembly review view (matches
// assembly.json review_dispatch_id).
// Assembly review dispatch (matching assembly.json review_dispatch_id).
review_dispatch_id = 90;

_part_id = is_undef(part_id) ? 1 : part_id;
if (_part_id == 1) {
    solarpunk_exhaust();
} else if (_part_id == 2) {
    fan_proxy();
} else if (_part_id == review_dispatch_id) {
    assembly_review(0, true);
} else {
    assert(false, str("Unknown part_id: ", _part_id));
}