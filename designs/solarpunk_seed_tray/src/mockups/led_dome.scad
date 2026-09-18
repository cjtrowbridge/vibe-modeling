// LED dome — REFERENCE MOCKUP (non-printable, §6.1 / §5.5).
//
// Classification: reference_only (mockups playbook). NOT in parts.json, NOT
// unioned into any printed output. It approximates the 10x10 LED-matrix dome
// that sits on the tray deck over the cell openings.
//
// Source: docs/solarpunk_series.md §5.5 ("10x10 LED matrix... dome");
//         §6.1 open decision #2 (dome material/commodity LED choice undecided).
//
// Dimensions are PLACEHOLDER (dome size undecided) — parameterized, and to be
// reconciled with Phase 1 LED-matrix measurements.

led_dome_width   = is_undef(led_dome_width)   ? 150.0 : led_dome_width;
led_dome_depth   = is_undef(led_dome_depth)   ? 110.0 : led_dome_depth;
led_dome_height  = is_undef(led_dome_height)  ? 24.0  : led_dome_height;
led_dome_margin  = is_undef(led_dome_margin)  ? 6.0   : led_dome_margin;
led_dome_sides   = is_undef(led_dome_sides)   ? 4     : led_dome_sides;

module led_dome() {
    // A rounded, slightly domed clear housing above the deck (approximation).
    translate([0, 0, 30.0]) {
        hull() {
            cube([led_dome_width, led_dome_depth, led_dome_height * 0.5]);
            scale([0.8, 0.8, 1.0])
                translate([led_dome_width * 0.1, led_dome_depth * 0.1, led_dome_height * 0.5])
                    cube([led_dome_width, led_dome_depth, led_dome_height * 0.7]);
        }
    }
}

led_dome();
