// Solarpunk Intelligence Hub backplane — block diagram (part_id 2).
//
// Classification: reference mockup (mockups playbook). Intentionally
// non-printable: a flat plate with 20 mm colored footprint blocks and the
// Ø3.2 hole pattern, for visual review of the layout. Exported by the build
// pipeline so it has rendered images and a (reference-only) STL alongside
// the printable part.
//
// Colors mirror the frozen reference src/mockups/backplane_blockout.scad.

function block_cx(cw, bx) = bx + cw / 2;
function block_cy(ch, by) = by + ch / 2;

module block_body(w, h, px, py, color) {
    difference() {
        color(color)
            cube([w, h, comp_h]);
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([w / 2 + sx * px / 2, h / 2 + sy * py / 2, -1])
                    cylinder(h = comp_h + 2, d = m3_d, $fn = 24);
    }
}

module backplane_blockout_mockup() {
    // Layout contracts (same coordinates as the printable part, by sharing
    // lib/defaults.scad).
    assert(board_w() == 169 && board_h() == 194.0,
           str("mockup envelope drifted: ", board_w(), "x", board_h(), " (expected 169x194.0)"));

    difference() {
        color("gray80", [0.9, 0.9, 0.9, 0.85])
            cube([board_w(), board_h(), plate_t]);
        // Hanging bands: 4x slots 20 x 5 on the top, mirrored on the bottom.
        for (yc = [velcro_y(), velcro_y_bottom()])
            for (i = [0:velcro_n - 1])
                translate([hanging_x(i) - velcro_slot_w / 2,
                           yc - velcro_slot_h / 2, -1])
                    cube([velcro_slot_w, velcro_slot_h, plate_t + 2]);
    }

    // Row 1 (top, top-aligned; both relays rotated).
    translate([rly1_x(), rly1_y(), plate_t])
        block_body(relay_ls_w, relay_ls_h, relay_ls_span_x(), relay_ls_span_y(), "steelblue");
    translate([cam_x(), cam_y(), plate_t])
        block_body(cam_w, cam_h, cam_span_x(), cam_span_y(), "purple");
    translate([rly2_x(), rly2_y(), plate_t])
        block_body(relay_ss_w, relay_ss_h, relay_ss_span_x(), relay_ss_span_y(), "steelblue");
    // Row 2.
    translate([edge_margin, pi_y(), plate_t])
        block_body(pi_ss_w, pi_ss_h, pi_ss_span_x(), pi_ss_span_y(), "darkorange");
    translate([scr_x(), scr_y(), plate_t])
        block_body(scr_ls_w, scr_ls_h, scr_span_x(), scr_span_y(), "green");
    // Row 3.
    translate([rly3_x(), rly3_y(), plate_t])
        block_body(relay_ls_w, relay_ls_h, relay_ls_span_x(), relay_ls_span_y(), "steelblue");
}