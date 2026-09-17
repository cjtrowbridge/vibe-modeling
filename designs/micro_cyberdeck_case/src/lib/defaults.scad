// Micro cyberdeck open-front case defaults, in millimeters.
// Coordinate datum: outer-front-left-bottom corner is [0, 0, 0].

part_id = is_undef(part_id) ? 0 : part_id;

interior_width = is_undef(interior_width) ? 67.0 : interior_width;
interior_depth = is_undef(interior_depth) ? 39.0 : interior_depth;
interior_height = is_undef(interior_height) ? 42.0 : interior_height;

wall_thickness = is_undef(wall_thickness) ? 3.0 : wall_thickness;
floor_thickness = is_undef(floor_thickness) ? 3.0 : floor_thickness;

microsd_opening_enabled = is_undef(microsd_opening_enabled) ? false : microsd_opening_enabled;
microsd_opening_width = is_undef(microsd_opening_width) ? 15.0 : microsd_opening_width;
microsd_opening_height = is_undef(microsd_opening_height) ? 10.0 : microsd_opening_height;
microsd_center_above_internal_floor = is_undef(microsd_center_above_internal_floor) ? 12.0 : microsd_center_above_internal_floor;
microsd_center_from_back_outer_edge = is_undef(microsd_center_from_back_outer_edge) ? 22.0 : microsd_center_from_back_outer_edge;
boolean_epsilon = is_undef(boolean_epsilon) ? 0.01 : boolean_epsilon;

battery_exit_enabled = is_undef(battery_exit_enabled) ? false : battery_exit_enabled;
battery_exit_width = is_undef(battery_exit_width) ? 37.0 : battery_exit_width;
battery_exit_height = is_undef(battery_exit_height) ? 12.0 : battery_exit_height;
battery_exit_center_above_internal_floor = is_undef(battery_exit_center_above_internal_floor) ? 6.0 : battery_exit_center_above_internal_floor;
battery_exit_center_from_back_outer_edge = is_undef(battery_exit_center_from_back_outer_edge) ? 21.5 : battery_exit_center_from_back_outer_edge;

fan_enabled = is_undef(fan_enabled) ? false : fan_enabled;
fan_air_opening_d = is_undef(fan_air_opening_d) ? 38.0 : fan_air_opening_d;
fan_hole_spacing = is_undef(fan_hole_spacing) ? 32.0 : fan_hole_spacing;
fan_mount_hole_d = is_undef(fan_mount_hole_d) ? 4.2 : fan_mount_hole_d;
fan_center_y = is_undef(fan_center_y) ? 22.5 : fan_center_y;
// Right (fan) wall thickness. The is_undef(wall_thickness) fallback keeps the
// older rev_0001/rev_0002 configs (no fan_wall_thickness key) at a 3 mm
// right wall; rev_0003 R3 sets it to 6.0 in the config.
fan_wall_thickness = is_undef(fan_wall_thickness) ? wall_thickness : fan_wall_thickness;
fan_screw_recess_d = is_undef(fan_screw_recess_d) ? 6.0 : fan_screw_recess_d;
fan_screw_recess_depth = is_undef(fan_screw_recess_depth) ? 3.0 : fan_screw_recess_depth;

lip_enabled = is_undef(lip_enabled) ? false : lip_enabled;
lip_width = is_undef(lip_width) ? 1.5 : lip_width;

divider_enabled = is_undef(divider_enabled) ? false : divider_enabled;
divider_thickness = is_undef(divider_thickness) ? 3.0 : divider_thickness;
divider_gap_above_internal_floor = is_undef(divider_gap_above_internal_floor) ? 12.0 : divider_gap_above_internal_floor;
divider_cable_passage_width = is_undef(divider_cable_passage_width) ? 5.0 : divider_cable_passage_width;
divider_cable_passage_depth = is_undef(divider_cable_passage_depth) ? 10.0 : divider_cable_passage_depth;

// Back-rail (rev_0004 R4): a horizontal 3 mm (y) x 3 mm (z) rail on the back
// wall's internal face, 5 mm below the rim, 5 mm in from each side wall, with
// a through-wall tenon (3 mm ledge + full back-wall thickness, flush with the
// rear outer face). The rail section equals the declared
// minimum_internal_edge_width, so no relaxation applies. The
// is_undef(rail_enabled) fallback keeps the older rev_0001..rev_0003 configs
// (no rail_enabled key) geometry unchanged.
rail_enabled = is_undef(rail_enabled) ? false : rail_enabled;
rail_x_inset = is_undef(rail_x_inset) ? 5.0 : rail_x_inset;
rail_section = is_undef(rail_section) ? 3.0 : rail_section;
rail_top_below_rim = is_undef(rail_top_below_rim) ? 5.0 : rail_top_below_rim;

// Top-band ledges on the left and right walls above the micro-SD (upper)
// window (rev_0004 amend, 2026-09-16): thicken the band
// z = microsd_max_z()..case_outer_height() into the cavity on both side
// walls; the left internal face moves x = wall_thickness ->
// x = wall_thickness + top_band_cavity_extension and the right internal
// face moves x = right_wall_inner_x() ->
// x = right_wall_inner_x() - top_band_cavity_extension. Flat retention
// ledges; at the configured 3 mm the shelf thickness meets
// minimum_internal_edge_width (no exception applies; asserted in
// case_body.scad). top_band_right_enabled defaults to false and the
// is_undef fallbacks keep the older rev_0001..rev_0003 configs rendering
// unchanged.
top_band_extension_enabled = is_undef(top_band_extension_enabled) ? false : top_band_extension_enabled;
top_band_cavity_extension = is_undef(top_band_cavity_extension) ? 1.0 : top_band_cavity_extension;
top_band_right_enabled = is_undef(top_band_right_enabled) ? false : top_band_right_enabled;

minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? minimum_wall_thickness : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? minimum_wall_thickness : minimum_internal_edge_width;

wall_floor_overlap = floor_thickness;
rear_corner_overlap = wall_thickness;
front_floor_apron_depth = wall_thickness;
divider_side_wall_overlap = wall_thickness;
divider_back_wall_overlap = wall_thickness;
