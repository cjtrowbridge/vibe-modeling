// Parameter defaults and shared layout for the Solarpunk Intelligence Hub.
// Overridable from a config file via scad_build_all.py. Both parts
// (printable plate + block diagram mockup) share this single layout so they
// cannot drift apart. The frozen reference
// src/mockups/backplane_blockout.scad is not modified; the layout has since
// been revised (rev_0002: 20 x 5 mm hanging slots, both top-row relays
// rotated in place (2026-09-20), camera centered between the relays on the
// top-right relay's (relay 1's) center line, plus 1 mm raised device outlines
// / labels and raised M3 standoffs (3 mm; camera + screen 15 mm, camera on
// its top two collars only). The hanging band is mirrored on the bottom:
// the Pi / relay 3 row seats on the band's top line (2026-09-20), plate
// 169 x 194). The hole pattern spans are the user-provided values recorded
// in the frozen reference (rev_0003, 2026-09-22: the rev_0001/0002
// uniform-inset rule had replaced the user's layout and was corrected).

// ---- Layout parameters ----------------------------------------------------

edge_margin = is_undef(edge_margin) ? 3.0 : edge_margin;
gap = is_undef(gap) ? 3.0 : gap;
velcro_gap = is_undef(velcro_gap) ? 3.0 : velcro_gap;

// Structural / fabrication minimums (AGENTS.md section 10). The plate is 3 mm
// thick, so the minimum structural overlap is capped by the plate thickness;
// the governing internal minimum is the 11.8 mm ligament between the camera's
// adjacent holes (tightest in-pattern, 12 + 3 - 3.2).
minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? 3.0 : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? 11.8 : minimum_internal_edge_width;

plate_t = is_undef(plate_t) ? 3.0 : plate_t;
comp_h = is_undef(comp_h) ? 20.0 : comp_h;

m3_d = is_undef(m3_d) ? 3.2 : m3_d;
// Hanging slots (approved 2026-09-20): 4 x 20 wide x 5 tall, slot edge
// velcro_edge_margin from the plate edge; replaces the rev_0001 Ø3.2 row.
velcro_slot_w = is_undef(velcro_slot_w) ? 20.0 : velcro_slot_w;
velcro_slot_h = is_undef(velcro_slot_h) ? 5.0 : velcro_slot_h;
velcro_edge_margin = is_undef(velcro_edge_margin) ? 10.0 : velcro_edge_margin;
velcro_n = is_undef(velcro_n) ? 4 : velcro_n;

// Raised top-surface features (approved 2026-09-20): 1 mm outline ring and
// 1 mm raised device label in every footprint, 3 mm raised M3 standoff
// collars. The ring and the standoff wall are internal rims, so each is
// floored at minimum_wall_thickness (3 mm). The camera gets no outline ring
// (its standoffs would merge into the ring band).
outline_h = is_undef(outline_h) ? 1.0 : outline_h;
outline_w = is_undef(outline_w) ? 3.0 : outline_w;
text_h = is_undef(text_h) ? 1.0 : text_h;
label_size = is_undef(label_size) ? 4.0 : label_size;
// Camera and screen sit on 15 mm standoffs (extra clearance for electronics
// behind them, approved 2026-09-20); all other holes get standoff_h.
standoff_h_tall = is_undef(standoff_h_tall) ? 15.0 : standoff_h_tall;
standoff_od_tall = is_undef(standoff_od_tall) ? m3_d + 2 * minimum_wall_thickness : standoff_od_tall;
// Font box-height offset: OpenSCAD 2021.01 anchors text on the 2-D baseline
// (valign does not vertically center single-line text, and bounding_box()
// is not supported by this build), so an uppercase label sits one glyph-box
// height above its baseline; shifting the baseline down by half the glyph
// box recentres the glyph block on the footprint center-line. Measured on
// the built STL with the default font: uppercase glyph box height =
// ~0.955 * label_size (3.82 mm at label_size 4).
label_y_off = is_undef(label_y_off) ? 0.955 * label_size : label_y_off;
standoff_h = is_undef(standoff_h) ? minimum_wall_thickness : standoff_h;
standoff_od = is_undef(standoff_od) ? m3_d + 2 * minimum_wall_thickness : standoff_od;

// Component bodies (W × H mm, natural orientation per design README §2).
relay_w = is_undef(relay_w) ? 52.0 : relay_w;
relay_h = is_undef(relay_h) ? 73.0 : relay_h;
pi_w = is_undef(pi_w) ? 90.0 : pi_w;
pi_h = is_undef(pi_h) ? 60.0 : pi_h;
cam_w = is_undef(cam_w) ? 25.0 : cam_w;
cam_h = is_undef(cam_h) ? 25.0 : cam_h;
scr_w = is_undef(scr_w) ? 100.0 : scr_w;
scr_h = is_undef(scr_h) ? 62.0 : scr_h;

// Per-component M3 hole pattern spans (center-to-center distance of the 4
// mounting holes, natural component orientation), from the user-provided
// hole layout recorded in src/mockups/backplane_blockout.scad (frozen
// 2026-09-20). Corrected in rev_0003 (2026-09-22): rev_0001/0002 had
// replaced these with a uniform "body - 2 x inset" rule (relay/screen/Pi
// inset 9, camera inset 6.5) that did not match the user's pattern.
// Derivable edge insets (inset = (body - span) / 2): relay 3.5 / 4.0,
// screen 3.5 / 4.0, Pi 6.0 / 16.0, camera 2.0 / 6.5.
relay_span_nat_x = is_undef(relay_span_nat_x) ? 45.0 : relay_span_nat_x;
relay_span_nat_y = is_undef(relay_span_nat_y) ? 65.0 : relay_span_nat_y;
pi_span_nat_x = is_undef(pi_span_nat_x) ? 58.0 : pi_span_nat_x;
pi_span_nat_y = is_undef(pi_span_nat_y) ? 48.0 : pi_span_nat_y;
scr_span_nat_x = is_undef(scr_span_nat_x) ? 93.0 : scr_span_nat_x;
scr_span_nat_y = is_undef(scr_span_nat_y) ? 54.0 : scr_span_nat_y;
cam_span_nat_x = is_undef(cam_span_nat_x) ? 21.0 : cam_span_nat_x;
cam_span_nat_y = is_undef(cam_span_nat_y) ? 12.0 : cam_span_nat_y;

maximum_print_dimension = is_undef(maximum_print_dimension) ? 220.0 : maximum_print_dimension;

part_id = is_undef(part_id) ? 1 : part_id;

boolean_epsilon = is_undef(boolean_epsilon) ? 0.001 : boolean_epsilon;

// ---- Orientation-specific footprints (per the frozen blockout) ------------
// Short-side-up relay (natural): 52w × 73h
relay_ss_w = relay_w;
relay_ss_h = relay_h;
// Long-side-up relay (rotated): 73w × 52h
relay_ls_w = relay_h;
relay_ls_h = relay_w;
// Short-side-up Pi (rotated): 60w × 90h
pi_ss_w = pi_h;
pi_ss_h = pi_w;
// Long-side-up screen (natural): 100w × 62h
scr_ls_w = scr_w;
scr_ls_h = scr_h;

// ---- Derived envelope (169 x 194 mm) ---------------------------------------

// Hanging bands: gap + slot + gap, each 11 mm; the top band sits between
// the plate top and row 1, the bottom band is mirrored against the plate
// bottom (approved 2026-09-20).
function velcro_band() = velcro_gap + velcro_slot_h + velcro_gap;

// Row widths:
//   row 1: relay_ss + gap + camera + gap + relay_ls (both rotated 2026-09-20)
//   row 2: pi_ss + gap + scr_ls
function row1_w() = relay_ss_w + gap + cam_w + gap + relay_ls_w;
function row2_w() = pi_ss_w + gap + scr_ls_w;
function board_w() = 2 * edge_margin + max(row1_w(), row2_w());

// Board height: bottom hanging band + relay 3 + gap + screen + gap + row 1
// relay (52 mm-tall after the 2026-09-20 rotation) + top hanging band.
function board_h() =
    velcro_band() + relay_ls_h + gap + scr_ls_h + gap + relay_ls_h + velcro_band();

// ---- Hole pattern spans -----------------------------------------------------

// Span in each physical orientation, derived from the natural-orientation
// user-provided spans above (rotated footprints swap x/y, per the frozen
// mockup's orientation blocks).
function relay_ss_span_x() = relay_span_nat_x;   // 45
function relay_ss_span_y() = relay_span_nat_y;   // 65
function relay_ls_span_x() = relay_span_nat_y;   // 65 (rotated)
function relay_ls_span_y() = relay_span_nat_x;   // 45 (rotated)
function cam_span_x() = cam_span_nat_x;          // 21
function cam_span_y() = cam_span_nat_y;          // 12
function pi_ss_span_x() = pi_span_nat_y;         // 48 (rotated)
function pi_ss_span_y() = pi_span_nat_x;         // 58 (rotated)
function scr_span_x() = scr_span_nat_x;          // 93
function scr_span_y() = scr_span_nat_y;          // 54

// Ligament between adjacent mounting holes of a pattern: span + gap - d.
function pattern_ligament(span) = span + gap - m3_d;

// Tightest in-pattern ligament across all component patterns.
function tightest_ligament() =
    min([
        pattern_ligament(relay_ss_span_x()),
        pattern_ligament(relay_ss_span_y()),
        pattern_ligament(cam_span_x()),
        pattern_ligament(cam_span_y()),
        pattern_ligament(pi_ss_span_x()),
        pattern_ligament(pi_ss_span_y()),
        pattern_ligament(scr_span_x()),
        pattern_ligament(scr_span_y()),
    ]);

// ---- Component positions (plate corner at 0,0) -----------------------------

// Row 1 (top, top-aligned). Row 1 top line sits velcro_band below the top.
// Both relays rotated 90 degrees in place (approved 2026-09-20): relay 2
// (now portrait) stays at the left edge, relay 1 (now landscape) stays at
// the right edge; the camera is centered between their nearest edges and
// sits on the top-right relay's (relay 1's) center line.
function row1_top() = board_h() - velcro_band();
function rly2_x() = edge_margin;
function rly2_y() = row1_top() - relay_ss_h;
function rly1_x() = board_w() - edge_margin - relay_ls_w;
function rly1_y() = row1_top() - relay_ls_h;
// Camera x-center = midpoint of the two relays' nearest edges.
function cam_mid_x() = (rly2_x() + relay_ss_w + rly1_x()) / 2;
function cam_x() = cam_mid_x() - cam_w / 2;
// Camera on the top-right relay's (relay 1's) center line.
function cam_y() = rly1_cy() - cam_h / 2;

// Row 2. Pi: anchored at the left edge, bottom edge on the bottom hanging
// band's top line (the band replaced corner-flush placement, 2026-09-20).
// Screen: gap above relay 3 — the right column is anchored bottom-up
// (relay 3 -> screen -> relay 1).
function pi_x() = edge_margin;
function pi_y() = velcro_band();
function scr_x() = edge_margin + pi_ss_w + gap;
function scr_y() = rly3_y() + relay_ls_h + gap;

// Row 3: relay 3, right-aligned under the screen, seated on the bottom band.
function rly3_x() = board_w() - edge_margin - relay_ls_w;
function rly3_y() = velcro_band();

// Component centers.
function rly1_cx() = rly1_x() + relay_ls_w / 2;
function rly1_cy() = rly1_y() + relay_ls_h / 2;
function cam_cx() = cam_x() + cam_w / 2;
function cam_cy() = cam_y() + cam_h / 2;
function rly2_cx() = rly2_x() + relay_ss_w / 2;
function rly2_cy() = rly2_y() + relay_ss_h / 2;
function pi_cx() = pi_x() + pi_ss_w / 2;
function pi_cy() = pi_y() + pi_ss_h / 2;
function scr_cx() = scr_x() + scr_ls_w / 2;
function scr_cy() = scr_y() + scr_ls_h / 2;
function rly3_cx() = rly3_x() + relay_ls_w / 2;
function rly3_cy() = rly3_y() + relay_ls_h / 2;

// Hanging slot centers: slot edge velcro_edge_margin from the plate edge,
// y at velcro_gap in from the top / bottom plate edges.
function velcro_y() = board_h() - velcro_gap - velcro_slot_h / 2;
function velcro_y_bottom() = velcro_gap + velcro_slot_h / 2;
function hanging_x(i) =
    velcro_edge_margin + velcro_slot_w / 2
    + i * (board_w() - 2 * (velcro_edge_margin + velcro_slot_w / 2)) / (velcro_n - 1);

// Camera clearance to the nearest relay edge on each side.
function cam_clear_left() = cam_x() - (rly2_x() + relay_ss_w);
function cam_clear_right() = rly1_x() - (cam_x() + cam_w);

// ---- Raised top-surface feature helpers (rev_0002) ------------------------

// Outline ring: outline_w wide (asserted >= minimum_wall_thickness in the
// part), outline_h tall, outer edge on the footprint edge — it traces each
// device's footprint from above. Centered at the origin; (w, h) = size.
module device_outline(w, h) {
    difference() {
        translate([-w / 2, -h / 2, 0])
            cube([w, h, outline_h]);
        translate([-w / 2 + outline_w, -h / 2 + outline_w, 0])
            cube([w - 2 * outline_w, h - 2 * outline_w, outline_h + 1]);
    }
}

// Raised device label: text_h tall, centered at the origin (x/y).
// X: halign = "center". Y: OpenSCAD 2021.01 anchors text at the baseline
// (valign does not centre a single line), so the baseline is shifted down by
// half the cap height to recentre the glyph block on the origin.
module device_label(str) {
    linear_extrude(height = text_h)
        translate([0, -label_y_off / 2, 0])
            text(str, size = label_size, halign = "center");
}

// Standoff collar at an M3 hole: through-hole d = m3_d, outer diameter
// m3_d + 2 * minimum_wall_thickness (wall = minimum_wall_thickness),
// standoff_h tall above the plate top by default; (h, od) overridable for
// the taller camera/screen collars (standoff_h_tall / standoff_od_tall).
// Centered at the origin; the part's hole cut runs through it.
module standoff_collar(h = standoff_h, od = standoff_od) {
    difference() {
        cylinder(h = h, d = od, $fn = 48);
        cylinder(h = h + 2, d = m3_d, $fn = 48);
    }
}