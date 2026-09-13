// Micro cyberdeck open-front case defaults, in millimeters.
// Coordinate datum: outer-front-left-bottom corner is [0, 0, 0].

part_id = is_undef(part_id) ? 0 : part_id;

interior_width = is_undef(interior_width) ? 67.0 : interior_width;
interior_depth = is_undef(interior_depth) ? 37.0 : interior_depth;
interior_height = is_undef(interior_height) ? 37.0 : interior_height;

wall_thickness = is_undef(wall_thickness) ? 3.0 : wall_thickness;
floor_thickness = is_undef(floor_thickness) ? 3.0 : floor_thickness;

microsd_opening_enabled = is_undef(microsd_opening_enabled) ? false : microsd_opening_enabled;
microsd_opening_width = is_undef(microsd_opening_width) ? 15.0 : microsd_opening_width;
microsd_opening_height = is_undef(microsd_opening_height) ? 10.0 : microsd_opening_height;
microsd_center_above_internal_floor = is_undef(microsd_center_above_internal_floor) ? 12.0 : microsd_center_above_internal_floor;
microsd_center_from_back_outer_edge = is_undef(microsd_center_from_back_outer_edge) ? 22.0 : microsd_center_from_back_outer_edge;
boolean_epsilon = is_undef(boolean_epsilon) ? 0.01 : boolean_epsilon;

minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? minimum_wall_thickness : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? minimum_wall_thickness : minimum_internal_edge_width;

wall_floor_overlap = floor_thickness;
rear_corner_overlap = wall_thickness;
front_floor_apron_depth = wall_thickness;
