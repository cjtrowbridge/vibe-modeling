// Solarpunk exhaust mounting plate — printable part (part_id 1).
//
// Single 134 x 141 x 3 mm flat plate that mounts a commodity 120 mm fan
// over the greenhouse ventilation screen (series airflow context:
// greenhouse top -> hose [user-supplied, out of scope] -> fan intake ->
// exhaust through the screen -> outside).
//
// Front face (z = plate_t, +Z, greenhouse-interior side): a Ø116
// through-airflow opening centered on the fan (user 2026-09-23: 120 mm fan
// cutout; the ~110 mm blade assembly clears it) + 4 M4-class Ø4.3 station
// bores in a 105 mm square with raised Ø10.3 x 3 mm collars (series
// standoff convention) + a recessed "120MM FAN" label in the bottom strip
// under the fan. Back face (z = 0): the velcro side over the screen — 8
// closed 20 x 5 through-window slots (intelligence-hub slot language) in
// two bands on ADJACENT plate edges (left + top), 2 per band on the 1/4
// and 3/4 lines of the plate edge; every window is outside the fan box.
// Plus (V5 addendum, user 2026-09-23): 8 recessed Ø6.1 x 2.0
// neodymium-magnet pockets on the back face flanking the station bores,
// holding Ø6 x 2 mm retention discs against the ventilation screen —
// each leaves a 1.0 mm back membrane (documented, user-accepted
// sub-minimum).
//
// Geometry provenance: the original rev_0001 geometry (no opening; slots
// on opposite edges INSIDE the fan footprint) was rejected by the user;
// this is the V4 rework (plan 2026-09-23-14-18-41, Revision V4).
//
// Layout is shared with fan_proxy.scad (reference only) and
// assembly_review.scad through lib/defaults.scad. No size-derived
// constants are hardcoded — every position is a function of the config
// inputs (parametric rule, cf. solarpunk_seed_tray). Structural
// governance: AGENTS.md section 10.
//
// All commodity values (fan 120 / opening Ø116 / span 105 / Ø4.3 bores /
// Ø110 intake context) are placeholders pending physical measurement of
// the target fan (see the config "status" field).

// ---- Structural / layout contracts (named dimensions + asserts) ------------

module solarpunk_exhaust() {
    // ---- Plate / structural governance ----
    assert(plate_t == minimum_wall_thickness,
           str("plate_t (", plate_t, ") must equal minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(minimum_structural_overlap >= minimum_wall_thickness,
           "minimum_structural_overlap must be >= minimum_wall_thickness");
    // Locked blockout V4: the plate is the fan box plus its margins
    // (band edges left/top, slim margins right/bottom, 134 x 141).
    assert(plate_w() == band_margin() + fan_size + edge_margin,
           "plate_w derivation mismatch");
    assert(plate_h() == fan_bottom_margin + fan_size + band_margin(),
           "plate_h derivation mismatch");
    // The fan box keeps at least minimum wall to all four plate edges
    // (left 11 / bottom 10 / top 11 / right 3 — locked layout; the 3 mm
    // right strip IS the minimum).
    assert(band_margin() >= minimum_wall_thickness &&
           fan_bottom_margin >= minimum_wall_thickness &&
           edge_margin >= minimum_wall_thickness,
           "fan box to plate edge below minimum_wall_thickness");

    // ---- Airflow opening (Ø116, centered on the fan) ----
    // The opening is strictly inside the fan box: the 2.0 mm plateau
    // between the opening edge and the fan-box edge is bridged by the
    // fan's own frame rim at service — a POSITIVE clearance, deliberately
    // not claimed as plate material (asserted > 0, explicitly sub-minimum).
    assert(fan_opening_d < fan_size,
           str("airflow opening (Ø", fan_opening_d, ") must be inside the fan box (", fan_size, ")"));
    // Asserted explicitly per edge, mirroring the plate-edge pattern (all
    // four fan-box sides): the opening edge is fan_opening_d/2 from the
    // fan center, the box edge fan_size/2 — each side must stay positive
    // (left/bottom: opening edge inside box edge; right/top: box edge
    // inside opening edge — all (fan_size - fan_opening_d)/2 > 0).
    assert((fan_cx() - fan_opening_d / 2) - (fan_cx() - fan_size / 2) > 0 &&
           (fan_cx() + fan_size / 2) - (fan_cx() + fan_opening_d / 2) > 0 &&
           (fan_cy() - fan_opening_d / 2) - (fan_cy() - fan_size / 2) > 0 &&
           (fan_cy() + fan_size / 2) - (fan_cy() + fan_opening_d / 2) > 0,
           str("airflow opening crosses the fan box edge (clearance ",
               (fan_size - fan_opening_d) / 2, " mm)"));
    // The 4 corner-station bores sit on the station square's DIAGONALS at
    // radius station_radius(); nearest bore material to the opening edge:
    // sqrt(2)*station_offset() - fan_opening_d/2 - fan_bore_d/2 (14.1 at the
    // locked blockout). An axial check would understate this.
    assert(station_radius() - fan_opening_d / 2 - fan_bore_d / 2 >= minimum_wall_thickness,
           str("airflow opening to station bore edge (",
               station_radius() - fan_opening_d / 2 - fan_bore_d / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));

    // ---- Fan station cross ----
    // In-pattern hole ligament between adjacent station bores (105 - 4.3).
    assert(fan_mount_span - fan_bore_d >= minimum_wall_thickness,
           str("in-pattern station bore ligament (", fan_mount_span - fan_bore_d,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    // Every station bore keeps at least the minimum to the nearest plate
    // edge. The plate is side-asymmetric by design (11 mm left / 3 mm right
    // strip), so all four bores are checked explicitly (locked blockout:
    // right 8.35 / left 16.35 / top 16.35 / bottom 15.35).
    assert(fan_cx() + station_offset() + fan_bore_d / 2 <= plate_w() - minimum_wall_thickness,
           str("right-edge station bore to plate edge (",
               plate_w() - (fan_cx() + station_offset() + fan_bore_d / 2),
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(fan_cx() - station_offset() - fan_bore_d / 2 >= minimum_wall_thickness,
           str("left-edge station bore to plate edge (",
               fan_cx() - station_offset() - fan_bore_d / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(fan_cy() + station_offset() + fan_bore_d / 2 <= plate_h() - minimum_wall_thickness,
           str("top-edge station bore to plate edge (",
               plate_h() - (fan_cy() + station_offset() + fan_bore_d / 2),
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(fan_cy() - station_offset() - fan_bore_d / 2 >= minimum_wall_thickness,
           str("bottom-edge station bore to plate edge (",
               fan_cy() - station_offset() - fan_bore_d / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));

    // ---- Raised M4-class collars (front face) ----
    // Collar wall is an internal rim: (standoff_od - fan_bore_d) / 2 = 3.0.
    assert(standoff_od - fan_bore_d >= 2 * minimum_wall_thickness - 2 * boolean_epsilon,
           str("collar wall (", (standoff_od - fan_bore_d) / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    // Collars stay inside the plate (locked blockout: right 5.35 / left
    // 13.35 / top 13.35 / bottom 12.35). Collar bases sit on solid plate
    // material in the corner quadrants beyond the opening, and above the
    // velcro band strips (z > plate_t vs windows cut through plate_t) — no
    // shared plan material, no ligament.
    assert(fan_cx() + station_offset() + standoff_od / 2 <= plate_w() - minimum_wall_thickness,
           str("right-edge collar to plate edge (",
               plate_w() - (fan_cx() + station_offset() + standoff_od / 2),
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(fan_cx() - station_offset() - standoff_od / 2 >= minimum_wall_thickness,
           str("left-edge collar to plate edge (",
               fan_cx() - station_offset() - standoff_od / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(fan_cy() + station_offset() + standoff_od / 2 <= plate_h() - minimum_wall_thickness,
           str("top-edge collar to plate edge (",
               plate_h() - (fan_cy() + station_offset() + standoff_od / 2),
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(fan_cy() - station_offset() - standoff_od / 2 >= minimum_wall_thickness,
           str("bottom-edge collar to plate edge (",
               fan_cy() - station_offset() - standoff_od / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    // ---- Back-face magnet pockets (V5 addendum, user 2026-09-23) ----
    // 8 closed Ø6.1 x 2.0 pockets flank the station bores along the 4
    // side lines of the 105 mm station square (magnet_offset from each
    // bore toward the side midpoint — the literal midpoints sit inside
    // the Ø116 opening, where there is no material). Each leaves a
    // (plate_t - magnet_recess_depth) = 1.0 mm back membrane: the
    // documented, user-accepted sub-minimum (the magnetic force pulls
    // the magnet AWAY from it, toward the screen; it carries only fan
    // static pressure). Every other pocket-to-void separation is
    // asserted against minimum_wall_thickness.
    assert(magnet_recess_depth < plate_t,
           "magnet recess must stay closed on the back face");
    assert(plate_t - magnet_recess_depth >= 1.0 - boolean_epsilon,
           str("magnet back membrane (", plate_t - magnet_recess_depth,
               " mm) below the documented 1.0 mm sub-minimum (V5)"));
    // Void separations, identical by symmetry for all 8 pockets at the
    // locked blockout (offset 11.5): to the nearest station-bore edge
    // 6.30, to the nearest collar OD edge 3.30, to the airflow opening
    // edge 5.56 (pocket planar radius sqrt((52.5 - 11.5)^2 + 52.5^2) =
    // 66.6 from the fan center).
    assert(magnet_offset - magnet_pocket_d / 2 - fan_bore_d / 2 >= minimum_wall_thickness,
           str("magnet pocket to station bore edge (",
               magnet_offset - magnet_pocket_d / 2 - fan_bore_d / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(magnet_offset - magnet_pocket_d / 2 - standoff_od / 2 >= minimum_wall_thickness,
           str("magnet pocket to collar OD edge (",
               magnet_offset - magnet_pocket_d / 2 - standoff_od / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(sqrt(pow(station_offset() - magnet_offset, 2) + pow(station_offset(), 2))
           - magnet_pocket_d / 2 - fan_opening_d / 2 >= minimum_wall_thickness,
           str("magnet pocket to airflow opening edge (",
               sqrt(pow(station_offset() - magnet_offset, 2) + pow(station_offset(), 2))
               - magnet_pocket_d / 2 - fan_opening_d / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    // Per-pocket plan clearance to the nearest plate edge (tightest at
    // the locked blockout: 7.45 mm, the right-side pockets).
    for (pi = [0:7]) {
        _px = magnet_pocket_centers()[pi][0];
        _py = magnet_pocket_centers()[pi][1];
        assert(min(_px, plate_w() - _px, _py, plate_h() - _py)
               - magnet_pocket_d / 2 >= minimum_wall_thickness,
               str("magnet pocket ", pi, " to nearest plate edge (",
                   min(_px, plate_w() - _px, _py, plate_h() - _py)
                   - magnet_pocket_d / 2,
                   " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    }
    // Pocket-to-pocket ligaments: within one side line (82 mm centers,
    // 75.9 mm edges at the locked blockout) and across a corner (16.26
    // mm centers, 10.16 mm edges).
    assert(fan_mount_span - 2 * magnet_offset - magnet_pocket_d >= minimum_wall_thickness,
           str("same-side magnet pocket ligament (",
               fan_mount_span - 2 * magnet_offset - magnet_pocket_d,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(sqrt(2) * magnet_offset - magnet_pocket_d >= minimum_wall_thickness,
           str("corner magnet pocket ligament (",
               sqrt(2) * magnet_offset - magnet_pocket_d,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    // Pockets vs the 8 velcro windows (rectangular voids; nearest-point
    // distance from the pocket center minus the pocket radius IS the
    // void-to-void gap — tightest at the locked blockout: 7.45 mm, the
    // left/right-side pockets to their band strip).
    for (pi = [0:7]) {
        _mrx = magnet_pocket_centers()[pi][0];
        _mry = magnet_pocket_centers()[pi][1];
        for (i = [0:velcro_n - 1]) {
            // Left-band window i: x [velcro_slot_x_left(), +velcro_slot_h],
            // y [row - velcro_slot_w/2, row + velcro_slot_w/2].
            _wx1 = velcro_slot_x_left() + velcro_slot_h;
            _wy0 = velcro_slot_y_left(i) - velcro_slot_w / 2;
            _wy1 = velcro_slot_y_left(i) + velcro_slot_w / 2;
            _wgx = min(max(_mrx, velcro_slot_x_left()), _wx1) - _mrx;
            _wgy = min(max(_mry, _wy0), _wy1) - _mry;
            assert(sqrt(_wgx * _wgx + _wgy * _wgy) - magnet_pocket_d / 2 >= minimum_wall_thickness,
                   str("magnet pocket ", pi, " to left-band window ", i, " (",
                       sqrt(_wgx * _wgx + _wgy * _wgy) - magnet_pocket_d / 2,
                       " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
            // Top-band window i: x [row ± velcro_slot_w/2], y
            // [velcro_slot_y_top(), +velcro_slot_h].
            _ux0 = velcro_slot_x_top(i) - velcro_slot_w / 2;
            _ux1 = velcro_slot_x_top(i) + velcro_slot_w / 2;
            _uy1 = velcro_slot_y_top() + velcro_slot_h;
            _uxg = min(max(_mrx, _ux0), _ux1) - _mrx;
            _uyg = min(max(_mry, velcro_slot_y_top()), _uy1) - _mry;
            assert(sqrt(_uxg * _uxg + _uyg * _uyg) - magnet_pocket_d / 2 >= minimum_wall_thickness,
                   str("magnet pocket ", pi, " to top-band window ", i, " (",
                       sqrt(_uxg * _uxg + _uyg * _uyg) - magnet_pocket_d / 2,
                       " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
        }
    }
    // ---- Velcro slot bands (closed through-windows, adjacent edges) ----
    // Slot width/height, and velcro_gap is BOTH the window-to-plate-edge
    // ligament (a solid strip, shortest edge-to-edge path) and the
    // window-to-fan-box ligament in both bands — the hub rule that failed
    // the rejected geometry.
    assert(velcro_slot_w >= minimum_wall_thickness &&
           velcro_slot_h >= minimum_wall_thickness &&
           velcro_gap >= minimum_wall_thickness,
           "velcro slot dimension or window ligament below minimum_wall_thickness");
    // Band geometry: one window row per 1/4-plate segment puts each row on
    // the 1/4 and 3/4 lines of the plate edge by construction (locked
    // blockout: left rows y 35.25 / 105.75, top rows x 33.5 / 100.5);
    // these identity asserts catch config drift (velcro_n != 2).
    assert(abs(velcro_slot_y_left(0) - plate_h() / 4) <= boolean_epsilon &&
           abs(velcro_slot_y_left(velcro_n - 1) - 3 * plate_h() / 4) <= boolean_epsilon,
           str("left-band slot rows must sit on the 1/4 and 3/4 plate-height lines (",
               velcro_slot_y_left(0), " / ", velcro_slot_y_left(velcro_n - 1), ")"));
    assert(abs(velcro_slot_x_top(0) - plate_w() / 4) <= boolean_epsilon &&
           abs(velcro_slot_x_top(velcro_n - 1) - 3 * plate_w() / 4) <= boolean_epsilon,
           str("top-band slot rows must sit on the 1/4 and 3/4 plate-width lines (",
               velcro_slot_x_top(0), " / ", velcro_slot_x_top(velcro_n - 1), ")"));
    // Row-to-row ligament inside each band (50.5 / 47, locked blockout)
    // and end ligament at each outer band end (left 25.25 / top 23.5).
    assert(plate_h() / velcro_n - velcro_slot_w >= minimum_wall_thickness,
           str("left-band slot row-to-row ligament (", plate_h() / velcro_n - velcro_slot_w,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(plate_w() / velcro_n - velcro_slot_w >= minimum_wall_thickness,
           str("top-band slot row-to-row ligament (", plate_w() / velcro_n - velcro_slot_w,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(plate_h() / (2 * velcro_n) - velcro_slot_w / 2 >= minimum_wall_thickness,
           str("left-band row end to plate end ligament (",
               plate_h() / (2 * velcro_n) - velcro_slot_w / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    assert(plate_w() / (2 * velcro_n) - velcro_slot_w / 2 >= minimum_wall_thickness,
           str("top-band row end to plate end ligament (",
               plate_w() / (2 * velcro_n) - velcro_slot_w / 2,
               " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    // Every window lies entirely outside the fan box (the rejection point
    // this revision fixes), keeping exactly velcro_gap of solid material
    // between the window and the fan box — the hub rule.
    assert((fan_cx() - fan_size / 2) - (velcro_slot_x_left() + velcro_slot_h) == velcro_gap,
           str("left-band window to fan box ligament (",
               (fan_cx() - fan_size / 2) - (velcro_slot_x_left() + velcro_slot_h),
               " mm) != velcro_gap (", velcro_gap, ")"));
    assert(velcro_slot_y_top() - (fan_cy() + fan_size / 2) == velcro_gap,
           str("top-band window to fan box ligament (",
               velcro_slot_y_top() - (fan_cy() + fan_size / 2),
               " mm) != velcro_gap (", velcro_gap, ")"));
    // And each window keeps solid plate material to the airflow opening:
    // the window's minimum plan distance (clamped box corner to the
    // opening center) minus the opening radius >= minimum (locked
    // blockout minimum 7.95 mm, top-band row 2).
    for (i = [0:velcro_n - 1]) {
        // Left-band window i: x [velcro_slot_x_left(), +velcro_slot_h],
        // y [row - velcro_slot_w/2, row + velcro_slot_w/2].
        _lx1 = velcro_slot_x_left() + velcro_slot_h;
        _ly0 = velcro_slot_y_left(i) - velcro_slot_w / 2;
        _ly1 = velcro_slot_y_left(i) + velcro_slot_w / 2;
        _ldx = min(max(fan_cx(), velcro_slot_x_left()), _lx1) - fan_cx();
        _ldy = min(max(fan_cy(), _ly0), _ly1) - fan_cy();
        assert(sqrt(_ldx * _ldx + _ldy * _ldy) - fan_opening_d / 2 >= minimum_wall_thickness,
               str("left-band window ", i, " approaches the airflow opening (",
                   sqrt(_ldx * _ldx + _ldy * _ldy) - fan_opening_d / 2,
                   " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
        // Top-band window i: x [row - velcro_slot_w/2, row +
        // velcro_slot_w/2], y [velcro_slot_y_top(), +velcro_slot_h].
        _tx0 = velcro_slot_x_top(i) - velcro_slot_w / 2;
        _tx1 = velcro_slot_x_top(i) + velcro_slot_w / 2;
        _ty1 = velcro_slot_y_top() + velcro_slot_h;
        _tdx = min(max(fan_cx(), _tx0), _tx1) - fan_cx();
        _tdy = min(max(fan_cy(), velcro_slot_y_top()), _ty1) - fan_cy();
        assert(sqrt(_tdx * _tdx + _tdy * _tdy) - fan_opening_d / 2 >= minimum_wall_thickness,
               str("top-band window ", i, " approaches the airflow opening (",
                   sqrt(_tdx * _tdx + _tdy * _tdy) - fan_opening_d / 2,
                   " mm) below minimum_wall_thickness (", minimum_wall_thickness, ")"));
    }

    // ---- Front-face marking ----
    // "120MM FAN" = 9 glyphs; default-font width estimate 19.8 mm +
    // 2 mm margin. The label sits in the bottom strip (top edge at
    // label_cy() + label_size/2 = 7.0, 3 mm under the fan box) and only
    // spans the open y-range between the fan box and the bottom edge,
    // away from the station bores (bottom bores are centered y 17.5).
    assert(9 * label_size * 0.55 + 2 <= fan_size,
           str("label (", 9 * label_size * 0.55 + 2,
               " mm at size ", label_size, ") overflows the fan box"));
    assert(label_cy() + label_size / 2 <= fan_cy() - fan_size / 2 - 2 * boolean_epsilon,
           str("label top edge (", label_cy() + label_size / 2,
               " mm) exceeds the fan-box bottom (", fan_cy() - fan_size / 2, ")"));

    // ---- Build volume ----
    assert(plate_w() <= maximum_print_dimension && plate_h() <= maximum_print_dimension,
           str("plate (", plate_w(), "x", plate_h(),
               ") exceeds max print dimension (", maximum_print_dimension, ")"));

    // ---- Geometry ----------------------------------------------------------
    // Bore + opening cuts run through the plate and the collars (the
    // collars are the only raised feature, so their height governs the cut).
    cut_h = plate_t + standoff_h + 2 * boolean_epsilon;

    difference() {
        union() {
            cube([plate_w(), plate_h(), plate_t]);
            // Front-face marking: recessed "120MM FAN" label in the bottom
            // strip under the fan. (V4: the rev_0001 outline ring was
            // dropped — as a fan-face silhouette it would be a
            // (fan_size - fan_opening_d)/2 = 2.0 mm internal rim, below
            // the minimum wall; the opening edge IS the fan-frame line.)
            translate([label_cx(), label_cy(), plate_t])
                device_label("120MM FAN");
            // Raised M4-class collars (Ø10.3 x 3) at the 4 fan station bores.
            for (sx = [-1, 1])
                for (sy = [-1, 1])
                    translate([fan_cx() + sx * station_offset(),
                               fan_cy() + sy * station_offset(), plate_t])
                        standoff_collar();
        }
        // Ø116 airflow through-opening at the fan center (user 2026-09-23:
        // the 120 mm fan cutout). Cuts plate + collar relief; the opening
        // edge is 11 mm clear of every collar base (collar at radius 69.1
        // vs opening edge at 58).
        translate([fan_cx(), fan_cy(), -boolean_epsilon])
            cylinder(h = cut_h, d = fan_opening_d, $fn = 96);
        // 4 fan station through-bores (Ø4.3, M4-class — placeholder pending
        // the actual fan hardware), cut through plate + collars.
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([fan_cx() + sx * station_offset(),
                           fan_cy() + sy * station_offset(), -boolean_epsilon])
                    cylinder(h = cut_h, d = fan_bore_d, $fn = 32);
        // 8 back-face magnet pockets (V5, Ø6.1 x 2.0): closed recesses
        // holding the Ø6 x 2 mm retention magnets against the
        // ventilation screen. Confined to the back half (z 0..2) of the
        // plate; the 1.0 mm back membrane is the documented sub-minimum.
        for (pi = [0:7])
            translate([magnet_pocket_centers()[pi][0],
                       magnet_pocket_centers()[pi][1], -boolean_epsilon])
                cylinder(h = magnet_recess_depth + 2 * boolean_epsilon,
                         d = magnet_pocket_d, $fn = 32);
        // Left band: 2 closed 20 x 5 velcro through-windows on the 1/4 and
        // 3/4 plate-height lines (x 3..8, y-centered 35.25 / 105.75).
        // velcro_slot_w runs along the edge (Y), velcro_slot_h across it
        // (X); closed windows — never open at the plate edge.
        for (i = [0:velcro_n - 1])
            translate([velcro_slot_x_left(),
                       velcro_slot_y_left(i) - velcro_slot_w / 2,
                       -boolean_epsilon])
                cube([velcro_slot_h, velcro_slot_w,
                      plate_t + 2 * boolean_epsilon]);
        // Top band: 2 closed 20 x 5 velcro through-windows on the 1/4 and
        // 3/4 plate-width lines (y 133..138, x-centered 33.5 / 100.5).
        for (i = [0:velcro_n - 1])
            translate([velcro_slot_x_top(i) - velcro_slot_w / 2,
                       velcro_slot_y_top(), -boolean_epsilon])
                cube([velcro_slot_w, velcro_slot_h,
                      plate_t + 2 * boolean_epsilon]);
    }
}