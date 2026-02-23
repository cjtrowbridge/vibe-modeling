// Project defaults (all dimensions in mm)

// Part selector (set via -D part_id=0/1/2...)
// NOTE: OpenSCAD CLI `-D` string quoting on Windows is fragile; use numeric ids.
part_id = 0; // 0=yagi_card

// Mechanical datum convention (shared across designs):
//   z=0 is the original plastic tube tip (focus reference).
//   The mount seat plane (metal post top) is at z=-mount_seat_to_focus.
mount_seat_to_focus = 33;

// Backplane/boom ("card") geometry
// NOTE: This design omits the 33mm mount stub entirely. `card_bottom_from_seat`
// is retained so the card-only print can share the same z placement as `yagi_mount`
// when mounted via a separate plug/stub.
card_bottom_from_seat = 6; // matches yagi_mount's mount_stub_len

card_size = 60;        // length along Z (dish axis)
card_size_x = 95;      // width along X (element direction)
card_thickness = 6;    // thickness along Y

// Yagi geometry (center-to-center spacing along dish axis)
element_spacing = 22;  // director <-> driven <-> reflector spacing

// Element material and retention
// NOTE: The element wire lengths are RF-critical. Do not change them without re-deriving.
//
// The groove dimensions are chosen so the element wire is fully recessed and its centerline
// aligns to the card midplane (y=0). With the card centered about y=0 and grooves cut from
// the top face (y=+card_thickness/2), this means the groove bottom should land at
// y=-wire_d/2. For 6mm^2 solid copper wire (~2.764mm dia) and card_thickness=6mm:
//   groove_depth = card_thickness/2 + wire_d/2 ~= 4.382mm
groove_w = 3;          // groove width along Z (3mm target for ~6mm^2 wire)
groove_depth = 4.382;  // groove depth from the top face (must be < card_thickness)
element_end_margin = 1; // extra groove margin on each element end (wire length remains RF-critical)
dipole_gap = 6;        // cutout at the driven element center for feedpoint separation

// Element lengths (for documentation; copper elements are not printed)
director_len = 66;
driven_len = 83;
reflector_len = 87;

