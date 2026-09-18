// Bottle bell — REFERENCE MOCKUP (non-printable commodity part, §5.4).
//
// Classification: reference_only (mockups playbook). The bell is a COMMODITY
// part, not a printed part (decided §5.4) — this mockup approximates a
// 2" bottle neck/bell that caps the standpipe tower crest and locates over it
// via the bell-seat collar.
//
// Source: docs/solarpunk_series.md §5.4 ("2\" bottle neck/bell as the standpipe
// bell"); tower crest interface (bell seat) is the tray's maximum_flood_height.
// UNCERTAINTY: actual bottle dimensions are a commodity choice (open decision
// #2 / #5) — placeholder geometry only.

bell_inner_diameter = is_undef(bell_inner_diameter) ? 40.0 : bell_inner_diameter;
bell_wall           = is_undef(bell_wall)           ? 3.0   : bell_wall;
bell_height         = is_undef(bell_height)         ? 20.0  : bell_height;
// Seat at the default tray crest; override with the built tray's value.
bell_seat_z         = is_undef(bell_seat_z)         ? 42.0  : bell_seat_z;

module bell() {
    // Hollow bell: neck sleeve + domed cap (approximation of a bottle mouth).
    difference() {
        union() {
            cylinder(h = bell_height, r = bell_inner_diameter / 2 + bell_wall, center = false);
            translate([0, 0, bell_height])
                sphere(r = bell_inner_diameter / 2 + bell_wall);
        }
        translate([0, 0, -1])
            cylinder(h = bell_height + bell_wall * 2 + 1, r = bell_inner_diameter / 2, center = false);
    }
}

// Position the bell over the default tower location for context.
translate([110, 95, bell_seat_z]) bell();
