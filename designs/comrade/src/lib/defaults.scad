// Comrade core base defaults, in millimeters.
// Coordinate datum: lower-left inner stack mounting-hole centre is [0, 0].
// x follows the 81 mm mounting spacing; y follows the 49 mm mounting spacing.

part_id = is_undef(part_id) ? 0 : part_id;

// Measured/provided electronics-stack mounting pattern.
inner_mount_spacing_x = is_undef(inner_mount_spacing_x) ? 81.0 : inner_mount_spacing_x;
inner_mount_spacing_y = is_undef(inner_mount_spacing_y) ? 49.0 : inner_mount_spacing_y;
electronics_stack_reference_height = 100.0;

// Printed base envelope.  The 15 mm extension supersedes the initial 10 mm
// request so the two recessed M3 systems retain the required material ligaments.
plate_extension = is_undef(plate_extension) ? 15.0 : plate_extension;
plate_thickness = is_undef(plate_thickness) ? 7.0 : plate_thickness;

// M3 socket-head hardware envelope.
m3_clearance_d = is_undef(m3_clearance_d) ? 3.4 : m3_clearance_d;
counterbore_d = is_undef(counterbore_d) ? 6.5 : counterbore_d;
counterbore_depth = is_undef(counterbore_depth) ? 3.2 : counterbore_depth;
outer_hole_inset = is_undef(outer_hole_inset) ? 7.0 : outer_hole_inset;

// Structural contracts.
minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? minimum_wall_thickness : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? minimum_wall_thickness : minimum_internal_edge_width;
