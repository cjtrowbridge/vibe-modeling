// Solarpunk seed tray — printable geometry (single TPU part).
//
// All dimensions derive from lib/defaults.scad (config-overridable). No
// size-derived constant is hardcoded here. See docs/solarpunk_series.md §5.3
// for the feature list and AGENTS.md §10 for the structural rules the asserts
// below enforce.
//
// Frame: footprint spans [0..outer_L] x [0..outer_W], floor bottom at z = 0.
//   rear wall (drain exit) is at +y; feed socket is on the front-left deck.
//
// Vertical stack (bottom to top):
//   floor -> flood chamber (opaque) -> deck (mask with cell openings) -> rim.
//   The standpipe tower rises from the floor ABOVE the deck (tower_access hole
//   in the deck); its crest is the fill/prime level that caps with the bell.
//   The drain channel runs in the chamber from the tower to the rear wall.

// --- Derived layout (all from the parameter surface) ------------------------
function outer_L() = tray_outer_length;
function outer_W() = tray_outer_width;
function outer_H() = tray_outer_height;
function wall() = wall_thickness;
function floor_top() = floor_thickness;
function inner_L() = outer_L() - 2 * wall();
function inner_W() = outer_W() - 2 * wall();
function corner_r() = corner_radius;
function deck_top() = insert_support_height;
function deck_bottom() = deck_top() - mask_thickness;
// Deck embeds into the walls by deck_margin -> positive structural overlap
// between deck and walls (AGENTS.md §10), not a coplanar seam.
function deck_margin() = ledge_support_overlap;
function deck_outer_L() = inner_L() + 2 * deck_margin();
function deck_outer_W() = inner_W() + 2 * deck_margin();
function deck_x0() = wall() - deck_margin();
function deck_y0() = wall() - deck_margin();
function tower_r_out() = standpipe_inner_diameter / 2 + standpipe_wall;
function tower_r_in() = standpipe_inner_diameter / 2;
function drain_out_r() = drain_inner_diameter / 2 + drain_channel_wall;
function drain_in_r() = drain_inner_diameter / 2;
function drain_axis_z() = drain_channel_height;
// Deck access hole over the tower (maintenance + siphon-region access, §5.14).
function tower_access_r() = tower_r_out() + 3.0;

// --- Structural asserts (size-independent rules, AGENTS.md §10) --------------
assert(wall() >= minimum_wall_thickness, "wall below minimum_wall_thickness");
assert(floor_top() >= minimum_wall_thickness, "floor below minimum_wall_thickness");
assert(mask_thickness >= minimum_wall_thickness, "mask below minimum_wall_thickness");
assert(standpipe_wall >= minimum_wall_thickness, "standpipe below minimum_wall_thickness");
assert(drain_channel_wall >= minimum_wall_thickness, "drain channel below minimum_wall_thickness");
assert(deck_margin() >= minimum_structural_overlap, "deck/wall overlap below minimum_structural_overlap");
assert(drain_inner_diameter > feed_port_diameter, "drain must be larger than feed");
assert(maximum_flood_height > deck_top(), "tower crest must rise above the deck");
assert(drain_channel_height > floor_top(), "drain channel must sit above the floor");
assert(drain_channel_height + drain_in_r() < deck_bottom(), "drain channel must fit below the deck");

// --- Helpers -----------------------------------------------------------------
// Rounded rectangle solid, footprint [0..L] x [0..W], height H from z=0.
module rounded_box(L, W, H, r) {
    r = min(r, min(L, W) / 2);
    hull() {
        cylinder(h = H, r = r, center = false);
        translate([L - r, 0, 0]) cylinder(h = H, r = r, center = false);
        translate([L - r, W - r, 0]) cylinder(h = H, r = r, center = false);
        translate([0, W - r, 0]) cylinder(h = H, r = r, center = false);
    }
}

function cell_center_x(c) = outer_L() / 2 + (c - (cell_columns - 1) / 2) * cell_pitch_x;
function cell_center_y(r) = outer_W() / 2 + (r - (cell_rows - 1) / 2) * cell_pitch_y;

module cell_holes() {
    for (c = [0 : cell_columns - 1])
        for (r = [0 : cell_rows - 1])
            translate([
                cell_center_x(c) - cell_opening_width / 2,
                cell_center_y(r) - cell_opening_length / 2,
                deck_bottom() - 1
            ])
            cube([cell_opening_width, cell_opening_length, mask_thickness + 2]);
}

module tower_access_hole() {
    translate([tower_center_x, tower_center_y, deck_bottom() - 1])
        cylinder(h = mask_thickness + 2, r = tower_access_r(), center = false);
}

// Exterior vertical ribs; count is derived from the span, never a fixed number.
// Ribs EMBED into the shell wall by rib_embed (positive-volume join, AGENTS.md
// §10) rather than sitting coplanar against it.
function rib_embed() = min(rib_depth / 2, wall() / 2);
function rib_count(span) = max(0, floor(span / rib_pitch));
module ribs() {
    // Ribs on the front (y near 0) and back (y near outer_W) walls.
    for (i = [0 : rib_count(outer_L()) - 1]) {
        x = rib_pitch / 2 + i * rib_pitch;
        if (x > 0 && x < outer_L()) {
            translate([-rib_depth / 2 + rib_embed(), x - rib_width / 2, 0])
                cube([rib_depth, rib_width, rib_height_fraction * outer_H()]);
            translate([outer_L() + rib_depth / 2 - rib_depth - rib_embed(), x - rib_width / 2, 0])
                cube([rib_depth, rib_width, rib_height_fraction * outer_H()]);
        }
    }
    // Ribs on the left (x near 0) and right (x near outer_L) walls.
    for (i = [0 : rib_count(outer_W()) - 1]) {
        y = rib_pitch / 2 + i * rib_pitch;
        if (y > 0 && y < outer_W()) {
            translate([-rib_depth / 2 + rib_embed(), y - rib_width / 2, 0])
                cube([rib_depth, rib_width, rib_height_fraction * outer_H()]);
            translate([outer_L() + rib_depth / 2 - rib_depth - rib_embed(), y - rib_width / 2, 0])
                cube([rib_depth, rib_width, rib_height_fraction * outer_H()]);
        }
    }
}

module corner_reinforcement() {
    s = wall() + rib_depth;
    translate([-rib_depth / 2, -rib_depth / 2, 0]) cube([s, s, outer_H()]);
    translate([outer_L() - s + rib_depth / 2, -rib_depth / 2, 0]) cube([s, s, outer_H()]);
    translate([outer_L() - s + rib_depth / 2, outer_W() - s + rib_depth / 2, 0]) cube([s, s, outer_H()]);
    translate([-rib_depth / 2, outer_W() - s + rib_depth / 2, 0]) cube([s, s, outer_H()]);
}

module shell() {
    difference() {
        rounded_box(outer_L(), outer_W(), outer_H(), corner_r());
        translate([wall(), wall(), floor_top()])
            rounded_box(inner_L(), inner_W(), outer_H() - floor_top() + 1,
                        max(corner_r() - wall(), 0.1));
    }
}

module rim() {
    // Lid-mating ring at the very top; spans the outer footprint + overhang.
    translate([-(rim_overhang), -(rim_overhang), outer_H() - rim_height])
    difference() {
        rounded_box(outer_L() + 2 * rim_overhang, outer_W() + 2 * rim_overhang,
                    rim_height, corner_r());
        translate([wall(), wall(), -0.5])
            rounded_box(outer_L() - 2 * wall(), outer_W() - 2 * wall(),
                        rim_height + 1, max(corner_r() - wall(), 0.1));
    }
}

module deck() {
    // Opaque mask + insert support; spans the interior and embeds into walls.
    translate([deck_x0(), deck_y0(), deck_bottom()])
        rounded_box(deck_outer_L(), deck_outer_W(), mask_thickness,
                    max(corner_r() - wall(), 0.1));
}

module tower() {
    // Standpipe tube: solid pedestal from the floor bottom to the crest so the
    // tower has a POSITIVE-VOLUME join into the floor (AGENTS.md §10); the bore
    // below floor_top() leaves a solid pedestal. Crest is fill/prime + bell seat.
    translate([tower_center_x, tower_center_y, 0])
        cylinder(h = maximum_flood_height, r = tower_r_out(), center = false);
    // Bell-seat collar locating the commodity bottle base.
    translate([tower_center_x, tower_center_y, maximum_flood_height])
        cylinder(h = 4, r = tower_r_out() + 2, center = false);
}

module drain_run() {
    // Horizontal channel from the tower to (and through) the rear wall.
    translate([
        tower_center_x - drain_out_r(),
        tower_center_y,
        drain_axis_z() - drain_out_r()
    ])
    cube([2 * drain_out_r(), outer_W() - tower_center_y + drain_out_r(), 2 * drain_out_r()]);
}

module feed_sleeve() {
    // Socket on the deck for the 1/4" feed fitting.
    translate([
        feed_center_x - feed_socket_wall - feed_port_diameter / 2,
        feed_center_y - feed_socket_wall - feed_port_diameter / 2,
        deck_bottom() - 1
    ])
    cube([
        feed_port_diameter + 2 * feed_socket_wall,
        feed_port_diameter + 2 * feed_socket_wall,
        mask_thickness + 2 + 3
    ]);
}

// --- Bore cutters (subtracted from the union) -------------------------------
module tower_bore() {
    // Full standpipe bore (hollow tower interior), floor to crest.
    translate([tower_center_x, tower_center_y, floor_top() - 1])
        cylinder(h = maximum_flood_height - floor_top() + 2, r = tower_r_in(), center = false);
}

module drain_bore() {
    // Horizontal bore from the tower interior through to the rear-wall port.
    translate([
        tower_center_x - drain_in_r(),
        tower_center_y,
        drain_axis_z() - drain_in_r()
    ])
    cube([2 * drain_in_r(), outer_W() - tower_center_y + drain_in_r() + 3, 2 * drain_in_r()]);
}

module feed_bore() {
    translate([feed_center_x, feed_center_y, deck_bottom() - 2])
        cylinder(h = mask_thickness + 6, r = feed_port_diameter / 2, center = false);
}

// --- The printable part ------------------------------------------------------
module solarpunk_seed_tray() {
    difference() {
        union() {
            shell();
            rim();
            deck();
            tower();
            drain_run();
            feed_sleeve();
            ribs();
            corner_reinforcement();
        }
        union() {
            cell_holes();
            tower_access_hole();
            tower_bore();
            drain_bore();
            feed_bore();
        }
    }
}
