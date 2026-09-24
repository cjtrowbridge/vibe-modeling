// Solarpunk exhaust — shared parameter surface and derived layout.
//
// Provenance: plan V4 (2026-09-23, governing plan
// plans/current/2026-09-23-14-18-41_solarpunk-exhaust.md) and
// docs/solarpunk_series.md (series canonical source of truth). The
// original rev_0001 geometry (no airflow opening; velcro slots inside the
// fan footprint on opposite edges) was rejected — the plate must carry a
// 116 mm through-airflow opening and velcro slots on two ADJACENT edges
// outside the fan footprint (hub convention: gap between the velcro holes
// and both the board edge and the parts below). V5 addendum (2026-09-23,
// user): 8 recessed Ø6.1 x 2.0 neodymium-magnet recesses flank the
// station bores (1.0 mm membrane — documented sub-minimum). V6 addendum
// (2026-09-23, user): those recesses open on the FRONT face, and a 45
// degree full-through chamfer (20 mm legs) cuts the top-left corner for
// the bracket's corner margin.
//
// Commodity dimensions (120 mm fan, 116 mm airflow opening, 105 mm
// M4-class span, 25 mm depth, Ø110 intake notch) are PLACEHOLDERS pending
// physical measurement of the target fan. They are design intent, not
// measured values.
//
// Platform rule (cf. solarpunk_seed_tray): every output is a function of
// the config inputs; the derived layout below is the single source of
// truth, so part sources never hardcode size-derived constants.
//
// Layout frame: plate origin at bottom-left corner (0,0), +X right, +Y up
// (toward the top edge), plate normal +Z. The plate prints flat on the
// build plate; the raised M4-class collars define the front (fan-side)
// face at z = plate_t; the back face (z = 0) is the velcro side that
// mounts over the greenhouse ventilation screen.

// ---- Structural governance (AGENTS.md §10) ----
minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? 3.0 : minimum_structural_overlap;

// ---- Plate (printable part 1) ----
plate_t = is_undef(plate_t) ? 3.0 : plate_t;
// Right-edge strip: the ONLY slim margin in the layout (see plate_w()).
edge_margin = is_undef(edge_margin) ? 3.0 : edge_margin;
// Bottom-edge strip: solid fan-frame bearing + label zone.
fan_bottom_margin = is_undef(fan_bottom_margin) ? 10.0 : fan_bottom_margin;

// ---- Fan (commodity, placeholder dimensions) ----
fan_size = is_undef(fan_size) ? 120.0 : fan_size;
fan_depth = is_undef(fan_depth) ? 25.0 : fan_depth;
// Airflow through-opening centered on the fan (the user-specified 120 mm
// cutout): clears the ~110 mm blade assembly. The fan exhausts through it
// toward the ventilation screen.
fan_opening_d = is_undef(fan_opening_d) ? 116.0 : fan_opening_d;
// Context only: the intake is not geometry-designed in this revision
// (hose connection is user-supplied, out of scope).
fan_intake_d = is_undef(fan_intake_d) ? 110.0 : fan_intake_d;
// Mockup-only notch depth for the intake circle (not in the printable part).
fan_intake_notch_depth = is_undef(fan_intake_notch_depth) ? 5.0 : fan_intake_notch_depth;
// Fan corner-station span (placeholder pending fan measurement).
fan_mount_span = is_undef(fan_mount_span) ? 105.0 : fan_mount_span;
// M4-class through-bore (placeholder range 4.3-4.5 mm pending the actual
// fan hardware; 4.3 is the working default).
fan_bore_d = is_undef(fan_bore_d) ? 4.3 : fan_bore_d;
// Series standoff convention: raised collars on the front face.
standoff_h = is_undef(standoff_h) ? 3.0 : standoff_h;
standoff_od = is_undef(standoff_od) ? 10.3 : standoff_od;

// ---- Magnet recesses (V5 addendum; front face in V6, user 2026-09-23) ----
// 8 closed pockets, one per side line of the station square
// (magnet_offset from each bore toward the side midpoint — the literal
// midpoints sit inside the Ø116 opening, where there is no material).
// V5: on the back face, holding retention discs against the ventilation
// screen. V6 addendum (user: "the recesses are on the wrong side. they
// should be on the front, not the back."): the recesses open on the
// FRONT (fan) face, 2.0 deep from z = plate_t — the 1.0 mm membrane
// (z 0..1) is now on the back side, a documented, user-accepted
// sub-minimum (the back face is solid under every recess; the velcro
// bands carry all screen retention, and the membrane carries only fan
// static pressure). Seated Ø6 x 2 magnets sit flush with the front face
// under the fan frame (magnetic retention of the fan to the plate; the
// M4s carry the corner loads). Pockets are Ø6.1 (0.05 mm/side
// clearance).
magnet_pocket_d = is_undef(magnet_pocket_d) ? 6.1 : magnet_pocket_d;
magnet_recess_depth = is_undef(magnet_recess_depth) ? 2.0 : magnet_recess_depth;
magnet_offset = is_undef(magnet_offset) ? 11.5 : magnet_offset;

// ---- Top-left corner chamfer (V6, user 2026-09-23) ----
// 45-degree full-through cut of the corner between the two slotted
// (velcro-band) edges, to clear the bracket's corner margin where the
// two intake pipes come together into the fitting. leg = 20 mm along
// each edge; the face line x + (plate_h - y) = leg runs from
// (0, plate_h - leg) to (leg, plate_h). The face reaches the reference
// fan box's top-left corner at leg = 22, so leg = 20 leaves a documented
// 1.41 mm fan-box margin (reference part, not plate material — same
// class as the 2.0 mm opening plateau).
corner_chamfer_leg = is_undef(corner_chamfer_leg) ? 20.0 : corner_chamfer_leg;

// ---- Velcro slot bands (intelligence-hub slot language, adjacent edges) ----
// Closed 20 x 5 through-window slots on the LEFT and TOP plate edges
// (velcro_n windows per band, on the 1/4 and 3/4 lines of the respective
// PLATE edge with velcro_n = 2). The velcro tapes cross the windows and
// bond the plate back face to the greenhouse over the ventilation screen
// (a screen adhesive is recommended). Band edges carry the derived hub
// margin: velcro_gap (window to plate edge) + velcro_slot_h + velcro_gap
// (window to fan box edge) = 11 mm; the other two edges keep their slim
// margins. The slots are closed windows — they never open at the plate
// edge.
velcro_gap = is_undef(velcro_gap) ? 3.0 : velcro_gap;
velcro_slot_w = is_undef(velcro_slot_w) ? 20.0 : velcro_slot_w;
velcro_slot_h = is_undef(velcro_slot_h) ? 5.0 : velcro_slot_h;
velcro_n = is_undef(velcro_n) ? 2 : velcro_n;

// ---- Front-face label (hub pattern, bottom strip under the fan) ----
text_h = is_undef(text_h) ? 1.0 : text_h;
label_size = is_undef(label_size) ? 4.0 : label_size;
// OpenSCAD 2021.01 text() vertical centering correction factor.
label_y_off = 0.955 * label_size;

// ---- Build volume ----
maximum_print_dimension = is_undef(maximum_print_dimension) ? 300.0 : maximum_print_dimension;

// ---- Build pipeline plumbing (injected by scad_build*.py) ----
part_id = is_undef(part_id) ? 1 : part_id;

// ---- Boolean hygiene ----
boolean_epsilon = is_undef(boolean_epsilon) ? 0.001 : boolean_epsilon;

// ===== Derived layout (computed from the config inputs above) =====

// Band edges (left, top) carry the hub band margin (3 + 5 + 3 = 11 mm at
// config defaults).
function band_margin() = velcro_gap + velcro_slot_h + velcro_gap;

// Top-left corner chamfer leg (V6): face line x + (plate_h() - y) = leg.
function corner_cut_d() = corner_chamfer_leg;

// Plate footprint: band_margin() on the left + top edges, the 120 mm fan
// box, fan_bottom_margin below it, edge_margin (3 mm) beyond it on the
// right. Locked blockout V4: 134 x 141.
function plate_w() = band_margin() + fan_size + edge_margin;
function plate_h() = fan_bottom_margin + fan_size + band_margin();

// Fan box center (plate frame). Locked blockout V4: (71, 70).
function fan_cx() = band_margin() + fan_size / 2;
function fan_cy() = fan_bottom_margin + fan_size / 2;
// Fan bottom face sits on the plate front face.
function fan_z() = plate_t;

// Fan corner stations (offset from the fan center); at span 105 the bores
// sit on the station square's diagonals, at radius station_radius().
function station_offset() = fan_mount_span / 2;
function station_radius() = sqrt(2) * station_offset();

// Magnet recess centers (V5; on the front face in the V6 addendum):
// one per side line of the station square, magnet_offset from each of
// its 4 corner bores toward that side's
// midpoint. Locked blockout: (30/112, 17.5/122.5) and (18.5/123.5,
// 29/111); planar radius sqrt((span/2 - offset)^2 + (span/2)^2) ≈ 66.6
// from the fan center for all 8.
function magnet_pocket_centers() = [
  [fan_cx() - station_offset() + magnet_offset, fan_cy() - station_offset()],
  [fan_cx() + station_offset() - magnet_offset, fan_cy() - station_offset()],
  [fan_cx() - station_offset() + magnet_offset, fan_cy() + station_offset()],
  [fan_cx() + station_offset() - magnet_offset, fan_cy() + station_offset()],
  [fan_cx() - station_offset(), fan_cy() - station_offset() + magnet_offset],
  [fan_cx() - station_offset(), fan_cy() + station_offset() - magnet_offset],
  [fan_cx() + station_offset(), fan_cy() - station_offset() + magnet_offset],
  [fan_cx() + station_offset(), fan_cy() + station_offset() - magnet_offset],
];

// Velcro band layout (on the PLATE edges, outside the fan footprint):
//   left band  x = velcro_gap .. velcro_gap + velcro_slot_h (3..8), rows
//              on the 1/4 and 3/4 PLATE-HEIGHT lines (35.25 / 105.75);
//   top band   y = plate_h() - velcro_gap - velcro_slot_h .. plate_h()
//               - velcro_gap (133..138), rows on the 1/4 and 3/4
//              PLATE-WIDTH lines (33.5 / 100.5).
// velcro_slot_w runs ALONG the edge, velcro_slot_h ACROSS it.
function velcro_slot_x_left() = velcro_gap;
function velcro_slot_y_top() = plate_h() - velcro_gap - velcro_slot_h;
function velcro_slot_y_left(i) = (i + 0.5) * plate_h() / velcro_n;
function velcro_slot_x_top(i) = (i + 0.5) * plate_w() / velcro_n;

// Front-face label center (bottom strip, under the fan box).
function label_cx() = fan_cx();
function label_cy() = fan_bottom_margin / 2;

// ===== Shared helper modules (hub pattern) =====

// Recessed text label, centered on the local origin (OpenSCAD 2021.01
// text baseline quirk: label_y_off corrects the vertical centering).
module device_label(str) {
    linear_extrude(height = text_h)
        translate([0, -label_y_off / 2, 0])
            text(str, size = label_size, halign = "center");
}

// Raised M3 collar: standalone cylinder with the fan bore through it.
// Hole diameter is fan_bore_d (adapted from the hub's m3_d convention).
module standoff_collar(h = standoff_h, od = standoff_od) {
    difference() {
        cylinder(h = h, d = od, $fn = 48);
        cylinder(h = h + 2, d = fan_bore_d, $fn = 48);
    }
}