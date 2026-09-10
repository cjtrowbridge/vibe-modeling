// Dispatch entry point for the cyberdeck-2 5U enclosure.
//
// Build contract (one render per part, main.scad is the source for every
// part): part_id 1..4 -> print-transformed leaf in place (already dropped
// into print [0,127]x[0,127]x[0,80]; no extra build transforms); 90 ->
// assembly review view (part_id 90 defines: assembly_view, assembly_view_id,
// show_proxies); 91 -> assembled product export span 254 x 80 x 254.

// rack_v2_0_0.scad first: it defines the spec constants and the assert
// helper functions that defaults.scad's contract assertions call, and
// defines U_HOLE_OFFSET_WITHIN used by the spec formula cross-check.
include <lib/rack_v2_0_0.scad>
include <lib/defaults.scad>
include <lib/seam_station.scad>
include <parts/shell.scad>
include <parts/leaf_bottom_left.scad>
include <parts/leaf_bottom_right.scad>
include <parts/leaf_top_right.scad>
include <parts/leaf_top_left.scad>
include <parts/product_export.scad>
include <parts/proxies.scad>
include <parts/assembly_review.scad>

review_dispatch_id = 90;
export_dispatch_id = 91;

if (part_id == 1) {
  leaf_bottom_left_print();
} else if (part_id == 2) {
  leaf_bottom_right_print();
} else if (part_id == 3) {
  leaf_top_right_print();
} else if (part_id == 4) {
  leaf_top_left_print();
} else if (part_id == review_dispatch_id) {
  assembly_review(assembly_view_id, show_proxies);
} else if (part_id == export_dispatch_id) {
  product_assembly_export();
} else {
  assert(false, str("Unknown part_id: ", part_id));
}