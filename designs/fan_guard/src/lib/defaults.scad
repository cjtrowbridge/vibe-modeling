// Fan guard defaults, in millimeters.
// Coordinate datum: the guard plate's bottom face lies in the z = 0 plane,
// centered on the origin in x/y. The plate is the air guard; the studs hang
// below it toward the fan (negative z) and carry M3-bore standoffs at the
// four corner stations of a 40 mm fan.

part_id = is_undef(part_id) ? 1 : part_id;

// Structural minima (AGENTS.md section 10).
minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? minimum_wall_thickness : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? minimum_wall_thickness : minimum_internal_edge_width;

// Guard plate. plate_size 46 with a Ø38 center opening leaves a 4 mm flat ring
// (>= 3 mm minimum wall) and the four Ø6 posts at the 32 mm corner stations
// clear both the opening (0.6 mm) and the plate edge (4 mm).
plate_size = is_undef(plate_size) ? 46.0 : plate_size;
plate_thickness = is_undef(plate_thickness) ? 3.0 : plate_thickness;
center_cutout_d = is_undef(center_cutout_d) ? 38.0 : center_cutout_d;

// Standoff studs (one at each of the four fan corner stations).
standoff_height = is_undef(standoff_height) ? 3.0 : standoff_height;
stud_outer_d = is_undef(stud_outer_d) ? 6.0 : stud_outer_d;
stud_bore_d = is_undef(stud_bore_d) ? 4.2 : stud_bore_d; // matches case fan_mount_hole_d (M3).
stud_pitch = is_undef(stud_pitch) ? 32.0 : stud_pitch;   // matches case fan_hole_spacing.

// Reference fan envelope used only by asserts (not geometry).
fan_face_d = is_undef(fan_face_d) ? 40.0 : fan_face_d;
fan_blade_d = is_undef(fan_blade_d) ? 38.0 : fan_blade_d;

boolean_epsilon = is_undef(boolean_epsilon) ? 0.01 : boolean_epsilon;
