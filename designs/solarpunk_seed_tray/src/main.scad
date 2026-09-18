// Solarpunk seed tray — dispatch entrypoint.
//
// Part dispatch (scad_build.py / scad_build_all.py inject `part_id` + `part`):
//   part_id 1  -> the printable tray (the only printable part)
//   part_id 90 -> product-assembly review view (assembly.json review_dispatch_id)
//
// Reference mockups live in src/mockups/ and are deliberately NOT included
// here (mockups playbook): they are reference-only and must never enter the
// dispatched build or the printed output.

include <lib/defaults.scad>;
include <parts/solarpunk_seed_tray.scad>;

// Build contract: part_id 1 -> printable tray; part_id 90 -> product-assembly
// review view (matches assembly.json review_dispatch_id).
review_dispatch_id = 90;

if (part_id == 1) {
    solarpunk_seed_tray();
} else if (part_id == review_dispatch_id) {
    // Product-assembly view: the tray as the primary assembly.
    solarpunk_seed_tray();
} else {
    assert(false, str("Unknown part_id: ", part_id));
}
