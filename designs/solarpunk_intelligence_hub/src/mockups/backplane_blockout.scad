// Solarpunk intelligence hub — backplane fit blockout (REFERENCE ONLY).
//
// Classification: reference mockup (mockups playbook). Never a printable
// export, never unioned into production STLs. Rendered manually for fit
// exploration only.
//
// Layout (per user direction, 2026-09-20, rev 5):
//   Row 1 (top, top-aligned):
//     * relay 1: short-side-up (52w × 73h, natural portrait)
//     * camera:  25 × 25
//     * relay 2: long-side-up (73w × 52h, rotated)
//   Row 2 (below row 1, each 3mm below the board above it):
//     * Pi: short-side-up (60w × 90h, rotated), under relay 1
//     * screen: long-side-up (100w × 62h, natural), under relay 2
//       (top relay board) — no longer dropped down to relay 1's bottom
//   Row 3:
//     * relay 3: long-side-up (73w × 52h, rotated), right-aligned under the
//       screen, 3mm below the screen's bottom edge; the board's bottom edge
//       is set by relay 3's position
//
// All component bodies and M3 patterns are user-provided (design README §2).
// M3 hole positions shown as Ø3.2 holes through the mockup boxes.

// --- Layout parameters (sweepable) ---------------------------------------
edge_margin = 3;    // mm, margin from board edge to any component body
gap         = 3;    // mm, gap between adjacent component bodies
velcro_gap  = 3;    // mm, gap between velcro holes and both the board edge and the parts below
plate_t     = 2;    // mm, blockout plate thickness (not a design value)
comp_h      = 15;   // mm, mockup component body height (not to scale)
m3_d        = 3.2;  // mm, M3 through-hole diameter
velcro_d    = 6.0;  // mm, velcro/zip-tie hole diameter (working proposal)
velcro_n    = 4;    // holes along the top edge

// --- Component bodies (W × H mm) and M3 patterns (center-to-center) ------
// Natural (upright) per design README §2.
relay_w = 52;  relay_h = 73;  relay_px = 45; relay_py = 65;
pi_w    = 90;  pi_h    = 60;  pi_px    = 58; pi_py    = 48;
cam_w   = 25;  cam_h   = 25;  cam_px   = 21; cam_py   = 12;
scr_w   = 100; scr_h   = 62;  scr_px   = 93; scr_py   = 54;

// Short-side-up relay (natural): 52 wide x 73 tall, holes 45 x 65
rly_ss_w = relay_w;   // 52
rly_ss_h = relay_h;   // 73
rly_ss_px = relay_px; // 45
rly_ss_py = relay_py; // 65

// Long-side-up relay (rotated): 73 wide x 52 tall, holes 65 x 45
rly_ls_w = relay_h;   // 73
rly_ls_h = relay_w;   // 52
rly_ls_px = relay_py; // 65
rly_ls_py = relay_px; // 45

// Short-side-up Pi (rotated): 60 wide x 90 tall, holes 48 x 58
pi_ss_w = pi_h;   // 60
pi_ss_h = pi_w;   // 90
pi_ss_px = pi_py; // 48
pi_ss_py = pi_px; // 58

// Long-side-up screen (natural): 100 wide x 62 tall, holes 93 x 54
scr_ls_w = scr_w;   // 100
scr_ls_h = scr_h;   // 62
scr_ls_px = scr_px; // 93
scr_ls_py = scr_py; // 54

// --- Derived envelope ------------------------------------------------------
// Row 1: relay_ss + gap + cam + gap + relay_ls
row1_w = rly_ss_w + gap + cam_w + gap + rly_ls_w;
// Row 2: pi_ss + gap + scr_ls
row2_w = pi_ss_w + gap + scr_ls_w;
// Row 3: relay_ls (right-aligned under screen)

board_w = 2 * edge_margin + max(row1_w, row2_w);
// Top band: velcro holes keep velcro_gap from the board edge AND from the
// parts below it -> band = velcro_gap + velcro_d + velcro_gap (12mm).
velcro_band = velcro_gap + velcro_d + velcro_gap;
// Board height: velcro band + relay2 + gap + screen + gap + relay3 + bottom margin.
// (Left column: relay 1 + gap + Pi = 73+3+90 = 166 below the band, which fits
// inside the right column's 52+3+62+3+52 = 172 — assert below.)
board_h = velcro_band + rly_ls_h
        + gap + scr_ls_h + gap + rly_ls_h
        + edge_margin;
assert(rly_ss_h + gap + pi_ss_h <= rly_ls_h + gap + scr_ls_h + gap + rly_ls_h, "left column taller than right column");

$echo("board_w", board_w, "board_h", board_h, "row1_w", row1_w, "row2_w", row2_w);

// --- Mockup primitives ------------------------------------------------------
// comp_body(w, h, px, py, color):
//   box with 4 M3 holes at the (px, py) center-to-center pattern.
module comp_body(w, h, px, py, color) {
    difference() {
        color(color) cube([w, h, comp_h]);
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([w/2 + sx*px/2, h/2 + sy*py/2, -1])
                    cylinder(h = comp_h + 2, d = m3_d, $fn = 24);
    }
}

// --- Plate (with velcro/zip-tie holes along the TOP edge) ------------------
// The top edge is the intended hanging edge: ties pass through these holes
// and over a structural member, plate hanging horizontal below it.
// velcro_gap from the board's top edge, velcro_gap above the parts.
velcro_y = board_h - velcro_gap - velcro_d / 2;
difference() {
    color("gray80", [0.9, 0.9, 0.9, 0.85]) // translucent for context
        cube([board_w, board_h, plate_t]);
    for (i = [0:velcro_n-1])
        translate([edge_margin + i * (board_w - 2 * edge_margin) / (velcro_n - 1),
                   velcro_y, -1])
            cylinder(h = plate_t + 2, d = velcro_d, $fn = 32);
}

// --- ROW 1 (top, top-aligned) ----------------------------------------------
// Relay 1: short-side-up (52w × 73h, natural portrait), left edge.
rly1_x = edge_margin;
// Row 1 top line sits velcro_band below the board's top edge.
row1_top = board_h - velcro_band;

translate([rly1_x, row1_top - rly_ss_h, plate_t])
    comp_body(rly_ss_w, rly_ss_h, rly_ss_px, rly_ss_py, "steelblue");

// Camera: 25×25, between relay 1 and relay 2, top-aligned.
cam_x = rly1_x + rly_ss_w + gap;
translate([cam_x, row1_top - cam_h, plate_t])
    comp_body(cam_w, cam_h, cam_px, cam_py, "purple");

// Relay 2: long-side-up (73w × 52h, rotated), top-aligned.
rly2_x = cam_x + cam_w + gap;
translate([rly2_x, row1_top - rly_ls_h, plate_t])
    comp_body(rly_ls_w, rly_ls_h, rly_ls_px, rly_ls_py, "steelblue");

// --- ROW 2 (below row 1, each 3mm below the board above it) ---------------
// Pi: short-side-up (60w × 90h, rotated), `gap` below relay 1's bottom.
translate([edge_margin, row1_top - rly_ss_h - gap - pi_ss_h, plate_t])
    comp_body(pi_ss_w, pi_ss_h, pi_ss_px, pi_ss_py, "darkorange");

// Screen: long-side-up (100w × 62h, natural), `gap` below relay 2's bottom.
scr_x = edge_margin + pi_ss_w + gap;
translate([scr_x, row1_top - rly_ls_h - gap - scr_ls_h, plate_t])
    comp_body(scr_ls_w, scr_ls_h, scr_ls_px, scr_ls_py, "green");

// --- ROW 3 (bottom) --------------------------------------------------------
// Relay 3: long-side-up (73w × 52h, rotated), right-aligned under the screen,
// `gap` below the screen's bottom edge. The board's bottom margin falls out
// of this: board_h - (52+3+62+3+52) = edge_margin.
rly3_x = board_w - edge_margin - rly_ls_w;
translate([rly3_x, edge_margin, plate_t])
    comp_body(rly_ls_w, rly_ls_h, rly_ls_px, rly_ls_py, "steelblue");
