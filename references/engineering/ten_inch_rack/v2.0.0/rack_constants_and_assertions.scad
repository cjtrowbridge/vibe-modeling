/*
Agent-readable 10-inch rack constants and assertions
Units: mm
This file is a companion to the expanded design specification.
*/

// ---------- Canonical rack geometry ----------
U_PITCH = 44.45;
U_HOLE_A = 15.875;
U_HOLE_B = 15.875;
U_HOLE_C = 12.700;

RACK_FRONT_WIDTH_NOMINAL = 254.000;
RAIL_HOLE_SPACING_X = 236.525;
RACK_CLEAR_OPENING_NOMINAL = 222.250;
EQUIPMENT_WIDTH_MAX_BASELINE = 220.000;

// ---------- M3 hardware ----------
M3_THREAD_D = 3.0;
M3_THREAD_PITCH = 0.5;
M3_CLEARANCE_CLOSE_D = 3.2;
M3_CLEARANCE_DEFAULT_D = 3.4;
M3_CLEARANCE_COARSE_D = 3.6;
M3_TAP_DRILL_D = 2.50;

M3_WASHER_ID = 3.2;
M3_WASHER_OD = 7.0;
M3_WASHER_T = 0.5;
M3_WASHER_SEAT_D = 8.25;

// ---------- Structural baseline ----------
MIN_STRUCTURAL_OVERLAP = 3.0;
MIN_REMAINING_LIGAMENT = 3.0;
MIN_PRIMARY_HOLE_RADIAL_MATERIAL = 2.5;

// Computational only. Never use as fit clearance or structure.
BOOLEAN_EPSILON = 0.02;

// ---------- Depth classes ----------
DEPTH_FRONT_ONLY = "front_only";
DEPTH_HALF_FRONT = "half_front";
DEPTH_HALF_REAR = "half_rear";
DEPTH_PARTIAL = "partial";
DEPTH_FULL = "full";
DEPTH_THROUGH_FEATURE = "through_feature";

ANCHOR_FRONT = "front";
ANCHOR_REAR = "rear";
ANCHOR_EXPLICIT = "explicit";

function resolved_usable_depth(
    rack_internal_depth,
    front_reserved_depth,
    rear_reserved_depth,
    front_global_service_depth,
    rear_global_service_depth
) =
    rack_internal_depth
    - front_reserved_depth
    - rear_reserved_depth
    - front_global_service_depth
    - rear_global_service_depth;

function resolved_item_depth(
    depth_class,
    usable_depth,
    partial_depth = undef,
    front_fit_clearance = 0.5,
    rear_fit_clearance = 0.5,
    half_depth_fit_clearance = 0.5,
    front_only_depth = undef
) =
    depth_class == DEPTH_FULL
        ? usable_depth - front_fit_clearance - rear_fit_clearance
    : depth_class == DEPTH_HALF_FRONT || depth_class == DEPTH_HALF_REAR
        ? usable_depth / 2 - half_depth_fit_clearance
    : depth_class == DEPTH_PARTIAL
        ? assert(!is_undef(partial_depth),
                 "DEPTH-PARTIAL requires partial_depth")
          partial_depth
    : depth_class == DEPTH_FRONT_ONLY
        ? assert(!is_undef(front_only_depth),
                 "DEPTH-FRONT-ONLY requires front_only_depth")
          front_only_depth
    : assert(depth_class == DEPTH_THROUGH_FEATURE,
             str("Unknown depth_class: ", depth_class))
      assert(!is_undef(partial_depth),
             "DEPTH-THROUGH-FEATURE requires explicit depth")
      partial_depth;

function resolved_item_offset(
    depth_class,
    usable_depth,
    item_depth,
    partial_offset = undef,
    front_fit_clearance = 0.5,
    rear_fit_clearance = 0.5
) =
    depth_class == DEPTH_FULL
        ? front_fit_clearance
    : depth_class == DEPTH_HALF_FRONT
        ? front_fit_clearance
    : depth_class == DEPTH_HALF_REAR
        ? usable_depth - rear_fit_clearance - item_depth
    : depth_class == DEPTH_FRONT_ONLY
        ? front_fit_clearance
    : assert(!is_undef(partial_offset),
             str(depth_class, " requires explicit offset"))
      partial_offset;

function interval_overlap(a0, a1, b0, b1) =
    min(a1, b1) - max(a0, b0);

module assert_rack_geometry() {
    assert(abs((U_HOLE_A + U_HOLE_B + U_HOLE_C) - U_PITCH) < 0.001,
           "RACK-GEO: vertical hole sequence must sum to one U");

    assert(RAIL_HOLE_SPACING_X > EQUIPMENT_WIDTH_MAX_BASELINE,
           "RACK-GEO: rail columns must lie outside equipment body envelope");

    assert(M3_WASHER_SEAT_D >= M3_WASHER_OD,
           "FAST-M3: washer seat smaller than washer OD");

    assert(MIN_STRUCTURAL_OVERLAP > BOOLEAN_EPSILON,
           "STRUCT: structural overlap cannot be Boolean epsilon");
}

module assert_depth_envelope(
    depth_class,
    usable_depth_start,
    usable_depth_end,
    item_depth,
    item_offset,
    front_service_clearance = 0,
    rear_service_clearance = 0,
    connector_projection = 0,
    cable_bend_depth = 0,
    allowed_service_start_y = undef,
    allowed_service_end_y = undef
) {
    usable_depth = usable_depth_end - usable_depth_start;
    occupied_start_y = usable_depth_start + item_offset;
    occupied_end_y = occupied_start_y + item_depth;

    service_start_y =
        occupied_start_y - front_service_clearance;

    service_end_y =
        occupied_end_y
        + rear_service_clearance
        + connector_projection
        + cable_bend_depth;

    resolved_service_start =
        is_undef(allowed_service_start_y)
        ? usable_depth_start
        : allowed_service_start_y;

    resolved_service_end =
        is_undef(allowed_service_end_y)
        ? usable_depth_end
        : allowed_service_end_y;

    assert(usable_depth > 0,
           "DEPTH: usable depth must be positive");

    assert(item_depth > 0,
           "DEPTH: item depth must be positive");

    assert(occupied_start_y >= usable_depth_start,
           str("DEPTH: item begins before usable interval; class=", depth_class));

    assert(occupied_end_y <= usable_depth_end,
           str("DEPTH: item ends after usable interval; class=", depth_class));

    assert(service_start_y >= resolved_service_start,
           "DEPTH: front service envelope violates allowed interval");

    assert(service_end_y <= resolved_service_end,
           "DEPTH: rear service envelope violates allowed interval");
}

module assert_min_overlap(
    a0, a1, b0, b1,
    required_overlap = MIN_STRUCTURAL_OVERLAP,
    label = "unnamed seam"
) {
    measured_overlap = interval_overlap(a0, a1, b0, b1);
    assert(measured_overlap >= required_overlap,
           str("STRUCT: ", label,
               " overlap=", measured_overlap,
               " required=", required_overlap));
}

module assert_min_ligament(
    measured_ligament,
    required_ligament = MIN_REMAINING_LIGAMENT,
    label = "unnamed ligament"
) {
    assert(measured_ligament >= required_ligament,
           str("STRUCT: ", label,
               " ligament=", measured_ligament,
               " required=", required_ligament));
}

module assert_m3_hole_edge(
    center_to_free_edge,
    finished_hole_d = M3_CLEARANCE_DEFAULT_D,
    required_radial_material = MIN_PRIMARY_HOLE_RADIAL_MATERIAL,
    label = "M3 hole"
) {
    radial_material = center_to_free_edge - finished_hole_d / 2;
    assert(radial_material >= required_radial_material,
           str("FAST-M3: ", label,
               " radial material=", radial_material,
               " required=", required_radial_material));
}

module assert_half_depth_pair(
    front_item_end_y,
    rear_item_start_y,
    required_inter_module_service_gap,
    label = "half-depth pair"
) {
    actual_gap = rear_item_start_y - front_item_end_y;
    assert(actual_gap >= required_inter_module_service_gap,
           str("DEPTH: ", label,
               " gap=", actual_gap,
               " required=", required_inter_module_service_gap));
}

// Run baseline assertions when included directly.
assert_rack_geometry();
