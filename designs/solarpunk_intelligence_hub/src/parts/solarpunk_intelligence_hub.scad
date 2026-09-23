// Solarpunk Intelligence Hub backplane — printable part (part_id 1).
//
// Single 169 x 194 x 3 mm flat plate carrying 24 M3 (Ø3.2) through-holes
// (6 components × 4 mounting holes) + 8 hanging slots each 20 x 5 mm (4 per
// band, mirrored top and bottom). Hole pattern spans per the user-provided
// layout: relay 45×65, screen 93×54, Pi (rotated) 48×58, camera 21×12.
// Camera centered between the row-1 relays on the top-right relay's center
// line; the Pi / relay 3 row seats on the bottom band's top line. Top
// surface: 1 mm raised device outlines and
// labels plus raised M3 standoff collars (3 mm; camera + screen 15 mm, and
// the camera carries only its top two collars) (rev_0002, 2026-09-20).
//
// Layout is shared with src/parts/backplane_blockout_mockup.scad through
// lib/defaults.scad. Structural governance: AGENTS.md section 10.

// ---- Structural / layout contracts (named dimensions + asserts) ------------

module solarpunk_intelligence_hub() {
    // Plate carries the structural minimums.
    assert(plate_t == minimum_wall_thickness,
           str("plate_t (", plate_t, ") must equal minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(minimum_structural_overlap >= minimum_wall_thickness,
           "minimum_structural_overlap must be >= minimum_wall_thickness");
    // Bottom-left Pi (bottom edge on the bottom hanging band) must still
    // clear relay 2 by at least the gap: Pi + gap + relay 2 <= the height
    // set by the right column (relay 3 + gap + screen + gap + relay 1).
    // 90 + 3 + 73 = 166 <= 172.
    assert(relay_ss_h + gap + pi_ss_h <= relay_ls_h + gap + scr_ls_h + gap + relay_ls_h,
           "left column taller than right column");
    // Board width is set by the wider row.
    assert(board_w() == 2 * edge_margin + max(row1_w(), row2_w()),
           "board_w derivation mismatch");
    // Governing internal minimum: tightest ligament between adjacent
    // mounting holes (camera 12 mm span: 12 + 3 - 3.2 = 11.8 mm).
    assert(tightest_ligament() >= minimum_internal_edge_width,
           str("tightest in-pattern ligament (", tightest_ligament(),
               " mm) is below minimum_internal_edge_width (", minimum_internal_edge_width, ")"));
    // Every M3 bore keeps at least minimum_wall_thickness of material to
    // the nearest plate edge (bore radius, not diameter, against the hole
    // edge). Edge-anchored bodies (relays, Pi, screen — each edge_margin
    // from a plate side in x): tightest rev_0003 case is relay 2's left
    // holes and the screen's right holes, 3.5 mm inset -> 3 + 3.5 - 1.6 =
    // 4.9 mm. The formula is conservative where a body is band-anchored
    // instead (underestimates the true margin, never overestimates it).
    assert(edge_margin + min([(relay_ss_w - relay_ss_span_x()) / 2,
                              (relay_ss_h - relay_ss_span_y()) / 2,
                              (pi_ss_w - pi_ss_span_x()) / 2,
                              (pi_ss_h - pi_ss_span_y()) / 2,
                              (scr_ls_w - scr_span_x()) / 2,
                              (scr_ls_h - scr_span_y()) / 2]) - m3_d / 2
           >= minimum_wall_thickness,
           "component hole bore to plate edge below minimum_wall_thickness");
    // The camera is surrounded by plate (not edge-anchored); its bores are
    // far from every edge — nearest is 31 mm to the top, minus radius.
    assert(min(cam_cx() - cam_span_x() / 2,
               board_w() - cam_cx() - cam_span_x() / 2,
               cam_cy() - cam_span_y() / 2,
               board_h() - cam_cy() - cam_span_y() / 2) - m3_d / 2
           >= minimum_wall_thickness,
           "camera hole bore to plate edge below minimum_wall_thickness");
    assert(edge_margin >= minimum_wall_thickness,
           "component body to plate edge below minimum_wall_thickness");
    // Hanging slots (rev_0002 approved 2026-09-20): 20 x 5, slot edges
    // velcro_edge_margin (10 mm) and velcro_gap (3 mm) from the plate edges,
    // centered in their band (eqdist top edge / row 1).
    assert(velcro_slot_w >= minimum_wall_thickness && velcro_slot_h >= minimum_wall_thickness,
           "hanging slot dimensions below minimum_wall_thickness");
    assert(velcro_edge_margin >= minimum_wall_thickness,
           "slot edge to plate side edge below minimum_wall_thickness");
    assert(velcro_gap >= minimum_wall_thickness,
           "slot edge to plate top/bottom edges and row 1 below minimum_wall_thickness");
    assert(abs(velcro_y() - (board_h() - velcro_gap - velcro_slot_h / 2)) <= boolean_epsilon,
           "hanging slot row not at velcro_gap below the plate top edge");
    assert(abs(velcro_y_bottom() - (velcro_gap + velcro_slot_h / 2)) <= boolean_epsilon,
           "bottom hanging slot row not at velcro_gap above the plate bottom edge");
    assert(pi_y() == velcro_band() && rly3_y() == velcro_band(),
           "Pi / relay 3 row not seated on the bottom hanging band");
    // Camera centered between the nearest relay edges, on the top-right
    // relay's (relay 1's) center line; both clearances must clear
    // minimum_wall_thickness.
    assert(abs(cam_clear_left() - cam_clear_right()) <= boolean_epsilon,
           "camera not equidistant from the relays' nearest edges");
    assert(cam_clear_left() >= minimum_wall_thickness,
           "camera to relay clearance below minimum_wall_thickness");
    assert(abs(cam_cy() - rly1_cy()) <= boolean_epsilon,
           "camera not on the top-right relay's center line");
    // Raised top-surface features (rev_0002, approved 2026-09-20). Ring and
    // standoff wall are internal rims and must meet minimum_wall_thickness.
    assert(outline_w >= minimum_wall_thickness,
           "outline ring width below minimum_wall_thickness");
    assert(standoff_od - m3_d >= 2 * minimum_wall_thickness - 2 * boolean_epsilon,
           str("standoff wall (", (standoff_od - m3_d) / 2,
               " mm) below minimum_wall_thickness"));
    assert(standoff_od_tall - m3_d >= 2 * minimum_wall_thickness - 2 * boolean_epsilon,
           str("tall standoff wall (", (standoff_od_tall - m3_d) / 2,
               " mm) below minimum_wall_thickness"));
    // Collar fit: the camera carries only its TOP-pair tall collars
    // (bottom-pair holes stay bare), standing on solid plate — the camera
    // has no outline ring band. The Ø9.2 tall-collar discs span
    // y [158.4, 167.6] = (cam_cy() + cam_span_y()/2) ± standoff_od_tall/2:
    // 13.9 mm above the camera block's bottom edge (assert below),
    // 1.9 mm inboard of its top edge. The nearest plate edge to any
    // camera collar is the plate top, 194 - 167.6 = 26.4 mm from the disc
    // edge (assert below). DOCUMENTED LIMITATION (rev_0003, approved
    // 2026-09-22): the user-provided camera x-span (21) is wider in x than
    // a Ø9.2 collar pair would allow inside the 25 mm blockout — each
    // collar overhangs the camera's outline edge by
    // cam_span_x()/2 + standoff_od/2 - cam_w/2 = 10.5 + 4.6 - 12.5 = 2.6 mm
    // (also visible on top in the frozen reference mockup). The overhang is
    // cosmetic; the mountable hardware truth is the hole pattern.
    assert(cam_cy() + cam_span_y() / 2 - standoff_od_tall / 2 - (cam_cy() - cam_h / 2)
           >= minimum_wall_thickness,
           "tall camera collar (top pair) closer to the camera block's bottom edge than minimum_wall_thickness");
    assert(min(cam_cx() - cam_span_x() / 2 - standoff_od / 2,
               board_w() - (cam_cx() + cam_span_x() / 2 + standoff_od / 2),
               cam_cy() - cam_span_y() / 2 - standoff_od_tall / 2,
               board_h() - (cam_cy() + cam_span_y() / 2 + standoff_od_tall / 2))
           >= minimum_wall_thickness,
           "camera collar exceeds the plate");
    // Label fit: text is centered (halign) and the build's default
    // uppercase render measures 16.3 mm wide for "CAMERA" at size 4
    // (revised STL top-face measurement, 2026-09-21); every other label
    // is at most 22.0 mm ("SCREEN"). Guard the tightest case, the 25 mm
    // camera body; every other body is at least 52 mm wide.
    assert(6 * label_size * 0.55 + 2 <= cam_w,
           str("CAMERA label (", 6 * label_size * 0.55, " mm at size ",
               label_size, ") overflows its ", cam_w, " mm footprint"));
    // Build volume.
    assert(board_w() <= maximum_print_dimension && board_h() <= maximum_print_dimension,
           str("plate (", board_w(), "x", board_h(), ") exceeds max print dimension (", maximum_print_dimension, ")"));

    // M3 hole cuts run through plate + the tallest standoff (camera/screen
    // tall collars govern; they overcut the 3 mm collars harmlessly).
    cut_h = plate_t + standoff_h_tall + 2 * boolean_epsilon;

    // ---- Geometry ----------------------------------------------------------

    difference() {
        union() {
            cube([board_w(), board_h(), plate_t]);
            // Row 1 (top): outline + label per footprint (no ring on the
            // camera); standoffs below at every M3 hole.
            translate([rly1_cx(), rly1_cy(), plate_t]) {
                device_outline(relay_ls_w, relay_ls_h);
                device_label("RELAY");
            }
            translate([cam_cx(), cam_cy(), plate_t])
                device_label("CAMERA");
            translate([rly2_cx(), rly2_cy(), plate_t]) {
                device_outline(relay_ss_w, relay_ss_h);
                device_label("RELAY");
            }
            // Row 2 (screen sits on tall standoffs: electronics behind it).
            translate([pi_cx(), pi_cy(), plate_t]) {
                device_outline(pi_ss_w, pi_ss_h);
                device_label("PI");
            }
            translate([scr_cx(), scr_cy(), plate_t]) {
                device_outline(scr_ls_w, scr_ls_h);
                device_label("SCREEN");
            }
            // Row 3.
            translate([rly3_cx(), rly3_cy(), plate_t]) {
                device_outline(relay_ls_w, relay_ls_h);
                device_label("RELAY");
            }
            // Standoff collars: 3 mm at 16 M3 holes, 15 mm (tall) at the
            // camera and screen (clearance for electronics behind those
            // devices). The camera carries only its TOP two collars (the
            // lower pair is open under it, approved 2026-09-20); every hole
            // stays drilled, so 22 collars at 24 holes.
            for (b = [[rly1_cx(), rly1_cy(), relay_ls_span_x(), relay_ls_span_y(), standoff_h, standoff_od, [-1, 1], [-1, 1]],
                      [cam_cx(), cam_cy(), cam_span_x(), cam_span_y(), standoff_h_tall, standoff_od_tall, [-1, 1], [1]],
                      [rly2_cx(), rly2_cy(), relay_ss_span_x(), relay_ss_span_y(), standoff_h, standoff_od, [-1, 1], [-1, 1]],
                      [pi_cx(), pi_cy(), pi_ss_span_x(), pi_ss_span_y(), standoff_h, standoff_od, [-1, 1], [-1, 1]],
                      [scr_cx(), scr_cy(), scr_span_x(), scr_span_y(), standoff_h_tall, standoff_od_tall, [-1, 1], [-1, 1]],
                      [rly3_cx(), rly3_cy(), relay_ls_span_x(), relay_ls_span_y(), standoff_h, standoff_od, [-1, 1], [-1, 1]]])
                for (sx = b[6])
                    for (sy = b[7])
                        translate([b[0] + sx * b[2] / 2,
                                   b[1] + sy * b[3] / 2, plate_t])
                            standoff_collar(h = b[4], od = b[5]);
        }
        // M3 through-holes (24), cut through plate + standoff.
        for (b = [[rly1_cx(), rly1_cy(), relay_ls_span_x(), relay_ls_span_y()],
                  [cam_cx(), cam_cy(), cam_span_x(), cam_span_y()],
                  [rly2_cx(), rly2_cy(), relay_ss_span_x(), relay_ss_span_y()],
                  [pi_cx(), pi_cy(), pi_ss_span_x(), pi_ss_span_y()],
                  [scr_cx(), scr_cy(), scr_span_x(), scr_span_y()],
                  [rly3_cx(), rly3_cy(), relay_ls_span_x(), relay_ls_span_y()]])
            for (sx = [-1, 1])
                for (sy = [-1, 1])
                    translate([b[0] + sx * b[2] / 2,
                               b[1] + sy * b[3] / 2, -boolean_epsilon])
                        cylinder(h = cut_h, d = m3_d, $fn = 32);
        // Hanging bands: 4x slots 20 x 5 on the top, mirrored on the bottom.
        for (yc = [velcro_y(), velcro_y_bottom()])
            for (i = [0:velcro_n - 1])
                translate([hanging_x(i) - velcro_slot_w / 2,
                           yc - velcro_slot_h / 2, -boolean_epsilon])
                    cube([velcro_slot_w, velcro_slot_h,
                          plate_t + 2 * boolean_epsilon]);
    }
}