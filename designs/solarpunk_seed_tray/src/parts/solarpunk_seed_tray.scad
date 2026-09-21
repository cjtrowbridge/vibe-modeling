// Solarpunk seed tray — printable geometry (single TPU part).
//
// All dimensions derive from lib/defaults.scad (config-overridable). No
// size-derived constant is hardcoded here. See docs/solarpunk_series.md §5.3
// for the feature list and AGENTS.md §10 for the structural rules the asserts
// below enforce.
//
// Frame: footprint spans [0..outer_L] x [0..outer_W], floor bottom at z = 0.
//   feed socket is on the front-left deck. The commodity plug tray rests on the
//   interior ledge; NOTHING siphon-related occupies the interior anymore.
//
// Vertical stack (bottom to top), tray body:
//   floor -> flood chamber (opaque) -> deck (mask with cell openings) -> rim.
//
// Siphon (NEW — bump-out topology): the bell/siphon is a BUMP-OUT on the long
//   side, projecting OUTSIDE the tray footprint toward one end (default left,
//   -x), so it does not intersect the plug tray and trays tessellate on the
//   shelf. It carries:
//   - a ~90 mm bell-seat bore (the commodity ~8 cm bottle base friction-fits);
//   - a CENTER siphon exit (riser crest / fill+prime level);
//   - 8 support SPINES on the bottom of the bump-out, out from the riser, so the
//     bottle sits flat, flow stays open under/around it, and this sets the
//     siphon-break cutoff as low as possible without restricting flow;
//   - the DRAIN outlet on the bump-out OUTER face (to the manifold);
//   - a RISER channel up from the flood chamber to the riser crest.

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
// --- Riser (central tube of the bump-out): bore + wall -----------------------
function riser_r_in() = standpipe_inner_diameter / 2;
function riser_r_out() = riser_r_in() + standpipe_wall;
function riser_crest_z() = maximum_flood_height;   // siphon exit / fill+prime level
// --- Bell seat / well --------------------------------------------------------
function bell_bore_r() = bell_bore_diameter / 2;
function well_outer_r() = bell_bore_r() + bell_seat_wall;
// Well surface at its outermost point (the bump-out face the drain port sits on).
function well_face_y() = (bumpout_side == 0)
    ? well_cy() - well_outer_r()
    : well_cy() + well_outer_r();
// How far the well intrudes PAST the long-side wall's inner face into the tray
// interior (0 = stays flush with the inner face). The plug tray and cell
// openings must clear this.
function well_intrusion_y() = (bumpout_side == 0)
    ? max(0, (well_cy() + well_outer_r()) - wall())
    : max(0, (outer_W() - wall()) - (well_cy() - well_outer_r()));
// Riser tube bottom: one drain-bore radius below the drain-channel axis so
// the riser bore always overlaps the channel bore (flow path) at any size.
function riser_base_z() = drain_channel_height - drain_in_r();
function well_cx() = (bumpout_end == 0)
    ? (well_end_margin + well_outer_r())
    : (outer_L() - well_end_margin - well_outer_r());
function well_cy() = (bumpout_side == 0)
    ? -(well_outer_r() - well_embed)                       // front, projects -y
    : (outer_W() + (well_outer_r() - well_embed));          // back, projects +y
// --- Drain port (outer face of the bump-out) --------------------------------
function drain_dir() = (bumpout_side == 0) ? -1 : 1;
function drain_in_r() = drain_inner_diameter / 2;
function drain_out_r() = drain_channel_wall + drain_in_r();
function drain_port_z() = well_floor_z + drain_z_offset;
// --- Riser/drain channel (bridges the well to the flood chamber) -----------
// channel_near_y: how far INSIDE the tray wall the drain channel ends.
function channel_near_y() = (bumpout_side == 0)
    ? (wall() + chamber_reach)
    : (outer_W() - wall() - chamber_reach);
// How far the bump-out projects past the long-side wall's OUTER face (the
// well center sits (R - embed) off the wall, so projection = (R - embed) + R).
// Tessellation: adjacent tray rows must keep this clearance on both sides.
function bumpout_projection() = (well_outer_r() - well_embed()) + well_outer_r();
function tessellation_row_pitch() = outer_W() + 2 * bumpout_projection();
// Inner y of the nearest cell opening to the bump-out side (clearance check).
function nearest_cell_edge_y() = (bumpout_side == 0)
    ? (cell_center_y(0) - cell_opening_length / 2)
    : (outer_W() - cell_center_y(cell_rows - 1) - cell_opening_length / 2);
// Sign for along-y extrusions toward the bump-out (+z rotated to -y/+y).
function bumpout_rot() = (bumpout_side == 0) ? 90 : -90;


// --- Structural asserts (size-independent rules, AGENTS.md §10) --------------
assert(wall() >= minimum_wall_thickness, "wall below minimum_wall_thickness");
assert(floor_top() >= minimum_wall_thickness, "floor below minimum_wall_thickness");
assert(mask_thickness >= minimum_wall_thickness, "mask below minimum_wall_thickness");
assert(standpipe_wall >= minimum_wall_thickness, "standpipe wall below minimum_wall_thickness");
assert(bell_seat_wall >= minimum_wall_thickness, "bell seat wall below minimum_wall_thickness");
assert(spine_width >= minimum_wall_thickness, "spine width below minimum internal edge");
assert(drain_channel_wall >= minimum_wall_thickness, "drain channel below minimum_wall_thickness");
assert(spine_count >= 3, "bottle spines need at least 3 legs");

assert(deck_margin() >= minimum_structural_overlap, "deck/wall overlap below minimum_structural_overlap");
assert(well_embed >= minimum_structural_overlap, "well embed below minimum_structural_overlap");
assert(well_embed <= wall(), "well embed must stay inside the shell wall");
assert(drain_inner_diameter > feed_port_diameter, "drain must be larger than feed");
assert(well_base_z >= 0, "well base must sit at or above the floor bottom");
assert(well_base_z < drain_channel_height - drain_out_r(), "well solid must reach below the drain channel (channel fuses into well)");
// Bump-out must not intersect the plug-tray footprint or the cell openings.
assert(well_intrusion_y() <= (inner_W() - insert_width) / 2, "well must stay clear of the plug-tray footprint");
assert(well_intrusion_y() <= nearest_cell_edge_y() - wall(), "well must stay clear of the cell openings");
assert(bell_bore_r() > well_intrusion_y(), "bell bore must clear the intrusion edge");
// Vertical package inside the well.
assert(well_floor_z < riser_crest_z(), "well floor must sit below the siphon crest");
assert(maximum_flood_height > well_floor_z + spine_height, "riser crest must clear the spine tips");
assert(riser_base_z() > floor_top(), "riser base must sit above the floor");
assert(drain_port_z() > well_floor_z, "drain port must sit above the well floor (open flow ring)");
assert(drain_port_z() + drain_out_r() < outer_H(), "drain port must stay under the well top");
// Drain-channel solid must stay at/above the part base (flat bottom face).
assert(drain_channel_height - drain_out_r() >= 0, "drain channel solid protrudes below the floor bottom");
// Flow path: spines radiate past the riser and leave the flow ring open.
assert(spine_tip_r > riser_r_out(), "spines must reach past the riser");
assert(spine_tip_r <= bell_bore_r() - minimum_wall_thickness, "bottle flow ring below minimum internal edge");
// Light-blocking drain channel: the BORE is sealed between floor and deck.
assert(drain_channel_height - drain_in_r() > floor_top(), "drain channel bore must clear the floor (sealed bottom, light-blocking)");
assert(drain_channel_height + drain_in_r() < deck_bottom(), "drain channel bore must fit below the deck (sealed top, light-blocking)");

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

module bumpout_well() {
    // Bell-seat well: solid plug (well_base_z..well_floor_z) + outer wall ring
    // (well_floor_z..outer_H), fused to the shell wall by its well_embed band
    // (POSITIVE-VOLUME join, AGENTS.md §10). The well_bore() cutter opens the
    // ~90 mm bell bore from well_floor_z to the top; the plug under the floor
    // also carries the drain port and the riser.
    translate([well_cx(), well_cy(), well_base_z])
        cylinder(h = outer_H() - well_base_z, r = well_outer_r(), center = false);
}

module spines() {
    // Bottle support spines: radial arms from the riser out to spine_tip_r on
    // the well floor. The bottle base rests on the spine tips; the center
    // (riser exit) and the ring past the tips stay open for flow.
    translate([well_cx(), well_cy(), 0]) {
        for (i = [0 : spine_count - 1]) {
            rotate([0, 0, i * 360 / spine_count])
                translate([0, 0, well_floor_z])
                    cube([spine_tip_r, spine_width, spine_height],
                         center = [false, true, false]);
        }
    }
}

module riser() {
    // Central siphon column: SOLID tube from riser_base_z() to the crest
    // (riser_crest_z() = siphon exit / priming level). Its base embeds in the
    // well plug (positive-volume join: riser_base < well_base) and the
    // riser_bore() cutter opens it from floor to crest — a sealed siphon
    // column whose water level defines the break point. The lower wall ring
    // also fuses with the drain channel and channel wall.
    translate([well_cx(), well_cy(), riser_base_z()])
        cylinder(h = riser_crest_z() - riser_base_z(), r = riser_r_out(), center = false);
}

module drain_channel() {
    // Light-blocking horizontal channel from the flood chamber (inlet at
    // channel_near_y) to the riser base; buried under the deck (asserted), so
    // the chamber stays opaque. Fuses into the riser solid at the well center.
    translate([well_cx(), channel_near_y(), drain_channel_height])
        rotate([bumpout_rot(), 0, 0])
            cylinder(h = abs(well_cy() - channel_near_y()), r = drain_out_r(), center = false);
}

module drain_port() {
    // Drain stub on the bump-out OUTER face (does not cross the bell seat):
    // short solid tube at the face centerline, z = drain_port_z() (open flow
    // ring above the well floor), embedded 2*bell_seat_wall into the well wall
    // ring and protruding drain_port_extend past the face. Positive-volume
    // join into the wall ring (AGENTS.md §10). The inner end is tangent to the
    // bell-bore face so the stub NEVER shortens the bottle clearance; the
    // drain_port_bore() leaves a closed-top tube open on the outer face and
    // 0.5 mm into the bell-seat interior (bottle rim clears, asserted).
    translate([well_cx(), (bumpout_side == 0)
            ? well_cy() - bell_bore_r()
            : well_cy() + bell_bore_r(),
        drain_port_z()])
        rotate([bumpout_rot(), 0, 0])
            cylinder(h = bell_seat_wall + drain_port_extend,
                     r = drain_out_r(), center = false);
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
module well_bore() {
    // Bell seat: ~90 mm bore from the well floor to the top (open top).
    translate([well_cx(), well_cy(), well_floor_z])
        cylinder(h = outer_H() - well_floor_z + 1, r = bell_bore_r(), center = false);
}

module riser_bore() {
    // Riser bore: open at the crest (siphon exit, in the center of the bell
    // bore) and open at the base; overlaps the drain channel bore
    // (perpendicular, positive-volume flow path from chamber to column).
    translate([well_cx(), well_cy(), riser_base_z() - 1])
        cylinder(h = riser_crest_z() - riser_base_z() + 3, r = riser_r_in(), center = false);
}

module drain_channel_bore() {
    // Uniform-bore horizontal channel (inlet open in the chamber).
    translate([well_cx(), channel_near_y(), drain_channel_height])
        rotate([bumpout_rot(), 0, 0])
            cylinder(h = abs(well_cy() - channel_near_y()) + 2, r = drain_in_r(), center = false);
}

module drain_port_bore() {
    // Drain outlet: uniform bore open drain_port_extend past the outer face,
    // through the stub and wall ring, opening 0.5 mm into the bell-seat
    // interior — clear of the bottle rim (bottle radius + 0.5 < bell_bore_r).
    translate([well_cx(), (bumpout_side == 0)
            ? well_cy() - bell_bore_r() + 0.5
            : well_cy() + bell_bore_r() - 0.5,
        drain_port_z()])
        rotate([bumpout_rot(), 0, 0])
            cylinder(h = bell_seat_wall + drain_port_extend + 0.5,
                     r = drain_in_r(), center = false);
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
            bumpout_well();
            spines();
            riser();
            drain_channel();
            drain_port();
            feed_sleeve();
            ribs();
            corner_reinforcement();
        }
        union() {
            cell_holes();
            well_bore();
            riser_bore();
            drain_channel_bore();
            drain_port_bore();
            feed_bore();
        }
    }
}
