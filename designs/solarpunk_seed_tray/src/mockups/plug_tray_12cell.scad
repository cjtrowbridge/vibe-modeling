// Plug tray (12-cell kit) — REFERENCE MOCKUP (non-printable).
//
// Classification: reference_only (mockups playbook). NOT in parts.json.
// Approximates the plug tray the seed tray nests under, per the 12-cell kit
// marketing dimensions.
//
// Source: kit marketing figures recorded 2026-09-17 (journal + session notes):
//   plug tray  6.79 in (172.5 mm) L x 5.12 in (130 mm) W x 2.56 in (65 mm) H
//   lid        3.94 in (100.1 mm) H
// UNCERTAINTY: marketing/retail figures, not measured. Placeholder geometry
// only — do NOT treat as a functional interface.

plug_tray_12_l = is_undef(plug_tray_12_l) ? 172.5 : plug_tray_12_l;
plug_tray_12_w = is_undef(plug_tray_12_w) ? 130.0 : plug_tray_12_w;
plug_tray_12_h = is_undef(plug_tray_12_h) ? 65.0  : plug_tray_12_h;
plug_tray_12_wall = is_undef(plug_tray_12_wall) ? 3.0 : plug_tray_12_wall;
plug_tray_12_corner = is_undef(plug_tray_12_corner) ? 6.0 : plug_tray_12_corner;

module _rounded_box_12(L, W, H, r) {
    r = min(r, min(L, W) / 2);
    hull() {
        cylinder(h = H, r = r);
        translate([L - r, 0, 0]) cylinder(h = H, r = r);
        translate([L - r, W - r, 0]) cylinder(h = H, r = r);
        translate([0, W - r, 0]) cylinder(h = H, r = r);
    }
}

// Open-topped plug tray (placeholder; 3 x 4 cell grid is implied, not modeled).
module plug_tray_12cell() {
    difference() {
        _rounded_box_12(plug_tray_12_l, plug_tray_12_w, plug_tray_12_h, plug_tray_12_corner);
        translate([plug_tray_12_wall, plug_tray_12_wall, plug_tray_12_wall])
            _rounded_box_12(
                plug_tray_12_l - 2 * plug_tray_12_wall,
                plug_tray_12_w - 2 * plug_tray_12_wall,
                plug_tray_12_h + 1,
                max(plug_tray_12_corner - plug_tray_12_wall, 0.1)
            );
    }
}

plug_tray_12cell();
