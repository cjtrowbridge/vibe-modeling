// ── Structural constants ────────────────────────────────────────────────
minimum_wall_thickness     = is_undef(minimum_wall_thickness)     ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? minimum_wall_thickness : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? minimum_wall_thickness : minimum_internal_edge_width;

// ── Thor unit ───────────────────────────────────────────────────────────
thor_w = is_undef(thor_w) ? 113.0 : thor_w;   // tangential (faces center)
thor_d = is_undef(thor_d) ? 57.0  : thor_d;   // radial   (thickness)
thor_h = is_undef(thor_h) ? 244.0 : thor_h;   // standing height

// ── Layout ──────────────────────────────────────────────────────────────
layout_inradius = is_undef(layout_inradius) ? 57.0 : layout_inradius;
thor_outer_r    = layout_inradius + thor_d;    // 114 mm

// ── Cylinder (user-supplied, reference) ─────────────────────────────────
cyl_id      = is_undef(cyl_id)   ? 290.0 : cyl_id;
cyl_od      = is_undef(cyl_od)   ? 300.0 : cyl_od;
cyl_h       = is_undef(cyl_h)    ? 300.0 : cyl_h;
cyl_inner_r = cyl_id  / 2;        // 145
cyl_outer_r = cyl_od  / 2;        // 150

// ── Base sectors (×3) ───────────────────────────────────────────────────
base_od           = is_undef(base_od)           ? 310.0 : base_od;
base_r_out        = base_od / 2;                // 155
base_center_bore_r = is_undef(base_center_bore_r) ? 60.0 : base_center_bore_r;
base_h            = is_undef(base_h)            ? 57.0  : base_h;
thor_recess_depth = is_undef(thor_recess_depth) ? 50.0  : thor_recess_depth;
anti_drop_lip     = is_undef(anti_drop_lip)     ? 3.0   : anti_drop_lip;
base_ring_inner_r = base_center_bore_r + minimum_wall_thickness;

// ── Top cap sectors (×3) ────────────────────────────────────────────────
cap_h          = is_undef(cap_h)          ? 30.0 : cap_h;
cap_r_in       = is_undef(cap_r_in)       ? 60.0 : cap_r_in;
cap_r_out      = is_undef(cap_r_out)      ? 155.0: cap_r_out;
cap_lip_w      = is_undef(cap_lip_w)      ? 3.0  : cap_lip_w;

// ── Exhaust fan ring ────────────────────────────────────────────────────
fan_od             = is_undef(fan_od)             ? 120.0 : fan_od;
exhaust_ring_r_in  = is_undef(exhaust_ring_r_in)  ? 60.0  : exhaust_ring_r_in;
exhaust_ring_r_out = is_undef(exhaust_ring_r_out) ? 70.0  : exhaust_ring_r_out;
exhaust_ring_h     = is_undef(exhaust_ring_h)     ? 30.0  : exhaust_ring_h;
fan_standoff       = is_undef(fan_standoff)       ? 30.0  : fan_standoff;

// ── Print bed ───────────────────────────────────────────────────────────
print_bed = is_undef(print_bed) ? 220.0 : print_bed;

// ── Sector span ─────────────────────────────────────────────────────────
sector_span = is_undef(sector_span) ? 120.0 : sector_span;

// ── M3 placeholder ──────────────────────────────────────────────────────
m3_hole_d = is_undef(m3_hole_d) ? 3.6 : m3_hole_d;

// ── Boolean epsilon ─────────────────────────────────────────────────────
boolean_epsilon = is_undef(boolean_epsilon) ? 0.02 : boolean_epsilon;

// ── Derived helpers ─────────────────────────────────────────────────────
function thor_outer_extent() = sqrt((thor_w / 2) ^ 2 + thor_outer_r ^ 2);
function sector_min_bbox_side() =
    base_r_out * (1 + sin(15));

// ── Contract assertions ─────────────────────────────────────────────────
module blockout_contract_assertions() {
    assert(minimum_wall_thickness >= 3.0,
        "Min wall thickness must be >= 3 mm");
    assert(minimum_structural_overlap >= minimum_wall_thickness,
        "Structural overlap must be >= min wall");
    assert(minimum_internal_edge_width >= minimum_wall_thickness,
        "Internal edge width must be >= min wall");

    assert(thor_outer_extent() <= cyl_inner_r,
        str("Thor outer extent ", thor_outer_extent(),
            " exceeds cylinder inner radius ", cyl_inner_r));

    assert(cyl_outer_r <= base_r_out,
        "Cylinder OD must fit inside base OD");

    assert(sector_min_bbox_side() <= print_bed,
        str("Sector min bbox ", sector_min_bbox_side(),
            " exceeds print bed ", print_bed));

    assert(thor_h + 10.0 <= cyl_h + fan_standoff,
        "Thor tops + 10 mm clearance must be below exhaust fan");

    assert(cap_r_in < cyl_outer_r,
        "Cap inner radius must be < cylinder OD for centering lip");

    assert(base_center_bore_r >= 60.0 - boolean_epsilon,
        "Center bore must be large enough for the 60 mm central column");
    assert(base_ring_inner_r + minimum_wall_thickness < base_r_out,
        "Center-bore support ring must remain well inside the base");

    assert(thor_recess_depth >= 50.0 - boolean_epsilon,
        "Thor recess depth must remain at least 50 mm");
    assert(base_h >= thor_recess_depth + anti_drop_lip,
        "Base support height must exceed recess depth plus anti-drop lip");

    assert(exhaust_ring_r_in >= thor_outer_extent() / 2,
        "Exhaust ring inner radius must clear Thor extent");
}
