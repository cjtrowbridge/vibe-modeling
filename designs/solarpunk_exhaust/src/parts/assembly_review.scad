// Product-assembly review scene for solarpunk_exhaust (part_id 90,
// review_dispatch_id in main.scad). Internal render-only scene: not in
// parts.json, never exported as a standalone part, no geometry_exports.
//
// Both declared views (assembly.json: front, isometric; show_proxies =
// true) share this single scene (view 0):
//
//   front face (o (0,0,0,90,0,0))  plate face-on: 120 mm fan box seated in
//     the 4 collars, station bores aligned 1:1, the 8 velcro
//     through-windows visible behind the box in the two side bands.
//   isometric (p)  same seat: box on the front face with its +Z exhaust
//     disc facing the screen side, 8 velcro windows on the back.
//
// main.scad dispatches to this scene unconditionally
// (assembly_review(0, true)); placement is contractual (product ==
// subassembly): part 1 at [0, 0, 0], part 2 at
// translate([fan_cx(), fan_cy(), fan_z()]) — the raw member transforms
// from assembly.json applied here.

module assembly_review(view_id = 0, show_proxies = true) {
    if (view_id != 0 || !show_proxies) {
        assert(false,
               str("unexpected review dispatch (", view_id, ",",
                   show_proxies, "); assembly.json declares one product view"));
    }
    union() {
        // part 1: mounting plate (printable)
        solarpunk_exhaust();
        // part 2: fan proxy (reference only), seated on the front face
        fan_proxy();
    }
}