// Seeding tray (6-cell kit) — REFERENCE MOCKUP (non-printable).
//
// Classification: reference_only (mockups playbook). NOT in parts.json.
// Approximates the 6-cell kit's seeding tray / cove / base per marketing
// dimensions.
//
// Source: kit marketing figures recorded 2026-09-17 (journal + session notes):
//   seeding tray  6.9 x 5.3 x 2.2 in  (175 x 135 x 55 mm)
//   clear cove    7.25 x 5.8 x 3.9 in (185 x 145 x 100 mm)
//   base          7.25 x 5.7 x 2.3 in (185 x 145 x 56 mm)
// UNCERTAINTY: marketing/retail figures, not measured. Placeholder geometry
// only — do NOT treat as a functional interface.

seed_tray_6_l = is_undef(seed_tray_6_l) ? 175.0 : seed_tray_6_l;
seed_tray_6_w = is_undef(seed_tray_6_w) ? 135.0 : seed_tray_6_w;
seed_tray_6_h = is_undef(seed_tray_6_h) ? 55.0  : seed_tray_6_h;
seed_tray_6_wall = is_undef(seed_tray_6_wall) ? 3.0 : seed_tray_6_wall;
seed_tray_6_corner = is_undef(seed_tray_6_corner) ? 6.0 : seed_tray_6_corner;

module _rounded_box_6(L, W, H, r) {
    r = min(r, min(L, W) / 2);
    hull() {
        cylinder(h = H, r = r);
        translate([L - r, 0, 0]) cylinder(h = H, r = r);
        translate([L - r, W - r, 0]) cylinder(h = H, r = r);
        translate([0, W - r, 0]) cylinder(h = H, r = r);
    }
}

// Open-topped seeding tray (placeholder; 3 x 2 cell grid is implied, not modeled).
module plug_tray_6cell() {
    difference() {
        _rounded_box_6(seed_tray_6_l, seed_tray_6_w, seed_tray_6_h, seed_tray_6_corner);
        translate([seed_tray_6_wall, seed_tray_6_wall, seed_tray_6_wall])
            _rounded_box_6(
                seed_tray_6_l - 2 * seed_tray_6_wall,
                seed_tray_6_w - 2 * seed_tray_6_wall,
                seed_tray_6_h + 1,
                max(seed_tray_6_corner - seed_tray_6_wall, 0.1)
            );
    }
}

plug_tray_6cell();
