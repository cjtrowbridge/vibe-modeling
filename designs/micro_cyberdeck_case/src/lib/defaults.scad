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

minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? minimum_wall_thickness : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? minimum_wall_thickness : minimum_internal_edge_width;

wall_floor_overlap = floor_thickness;
rear_corner_overlap = wall_thickness;
front_floor_apron_depth = wall_thickness;
divider_side_wall_overlap = wall_thickness;
divider_back_wall_overlap = wall_thickness;
