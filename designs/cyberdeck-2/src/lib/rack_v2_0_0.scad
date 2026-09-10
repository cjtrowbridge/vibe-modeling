// Ten-inch rack M3 printed-design spec v2.0.0 - copied and adapted (provenance:
// references/engineering/ten_inch_rack/v2.0.0, bundle recorded in the plan and
// design docs). Production code is never imported from references/: this file is
// the design-owned, hash-covered copy. Spec IDs are preserved in comments.

U_PITCH = 44.45;                      // RACK-GEO-001
U_HOLE_A = 15.875;                    // RACK-GEO-002 (repeating sequence)
U_HOLE_B = 15.875;                    // RACK-GEO-002
U_HOLE_C = 12.700;                    // RACK-GEO-002
RACK_FRONT_WIDTH_NOMINAL = 254.000;   // 5U front face
RAIL_HOLE_SPACING_X = 236.525;        // RACK-GEO-004
RACK_CLEAR_OPENING_NOMINAL = 222.250; // 5 x 44.45
EQUIPMENT_WIDTH_MAX_BASELINE = 220.000; // RACK-GEO-006

M3_THREAD_D = 3.0;
M3_THREAD_PITCH = 0.5;
M3_CLEARANCE_COARSE_D = 3.6;
M3_WASHER_ID = 3.2;                   // ISO 7089 M3
M3_WASHER_OD = 7.0;
M3_WASHER_T = 0.5;
M3_WASHER_SEAT_D = 8.25;

MIN_STRUCTURAL_OVERLAP = 3.0;
MIN_REMAINING_LIGAMENT = 3.0;
MIN_PRIMARY_HOLE_RADIAL_MATERIAL = 2.5;
BOOLEAN_EPSILON = 0.02;

function interval_overlap(a0, a1, b0, b1) = min(a1, b1) - max(a0, b0);

// Positive-volume overlap assertion for a load-bearing join.
// NOTE: module form, not function form. In OpenSCAD 2021.01 a user-defined
// FUNCTION called as a bare statement in a module body is treated as an
// unknown module instantiation ("Ignoring unknown module ...") and is
// SILENTLY NOT EXECUTED (probe-verified); a user-defined MODULE called the
// same way parses and executes normally. Proven via failing-assert probes in
// %TEMP%.
module assert_min_overlap(a0, a1, b0, b1, required, label = "") {
  assert(
    interval_overlap(a0, a1, b0, b1) >= required - BOOLEAN_EPSILON,
    str(label, ": overlap ", interval_overlap(a0, a1, b0, b1),
        " below required ", required)
  );
}

// Remaining-material assertion between a cut edge and a free edge.
// Module form for the same 2021.01 bare-statement reason as assert_min_overlap.
module assert_min_ligament(measured, required, label = "") {
  assert(
    measured >= required - BOOLEAN_EPSILON,
    str(label, ": ligament ", measured, " below required ", required)
  );
}

// Radial material remaining around a finished hole edge.
// Module form for the same 2021.01 bare-statement reason as assert_min_overlap.
module assert_m3_hole_edge(center_to_free_edge, finished_hole_d, required, label = "") {
  assert(
    center_to_free_edge - finished_hole_d / 2.0 >= required - BOOLEAN_EPSILON,
    str(label, ": radial material ", center_to_free_edge - finished_hole_d / 2.0,
        " below required ", required)
  );
}

// Within-U hole offsets above each U bottom (RACK-GEO-002).
U_HOLE_OFFSET_WITHIN = [6.35, 22.225, 34.925];

// Locked 5U hole sequence. Holes start 6.35 above each U bottom; within-U gaps
// are 15.875 / 12.700, between-U gap 15.875 (RACK-GEO-002, never 44.45/3:
// RACK-GEO-003). Index 0..14, U0 bottom at Z = -111.125.
// Ternary form: OpenSCAD 2021.01 has no mod operator, rejects compound
// expressions as array indices, and function bodies cannot declare local
// variables.
function rack_hole_z(i) =
  -RACK_CLEAR_OPENING_NOMINAL / 2.0 + floor(i / 3) * U_PITCH +
  (i % 3 == 0 ? U_HOLE_OFFSET_WITHIN[0] : (i % 3 == 1 ? U_HOLE_OFFSET_WITHIN[1] : U_HOLE_OFFSET_WITHIN[2]));

module assert_rack_geometry() {
  assert(
    abs(U_HOLE_A + U_HOLE_B + U_HOLE_C - U_PITCH) < 0.001,
    str("RACK-GEO: vertical hole sequence must sum to one U, got ", U_HOLE_A + U_HOLE_B + U_HOLE_C)
  );
  assert(
    RAIL_HOLE_SPACING_X > EQUIPMENT_WIDTH_MAX_BASELINE,
    "RACK-GEO: rail columns must lie outside equipment body envelope"
  );
  assert(M3_WASHER_SEAT_D >= M3_WASHER_OD, "M3 washer seat must overhang the washer");
  assert(MIN_STRUCTURAL_OVERLAP > BOOLEAN_EPSILON, "structural overlap must exceed boolean epsilon");
  // Host structural rules are stricter than the spec baseline.
  assert(MIN_PRIMARY_HOLE_RADIAL_MATERIAL <= MIN_STRUCTURAL_OVERLAP,
         "host minimum must dominate spec radial minimum");
}

assert_rack_geometry();