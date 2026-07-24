// AC redirector prototype defaults, revision 0001 (all dimensions in mm).
//
// Installed coordinate convention:
// - x: across the AC outlet; positive x is the provisional bedward yaw direction
// - y: forward, away from the AC face
// - z: upward from the bottom tangent of the scoop

minimum_wall_thickness = 3.0;
minimum_structural_overlap = minimum_wall_thickness;
minimum_internal_edge_width = minimum_wall_thickness;
numeric_tolerance = 0.001;

part_id = 0;

total_outlet_width = 406.0;
piece_width = 198.0;
center_gap = 10.0;
outlet_height = 50.0;

wall_thickness = 3.0;
end_wall_thickness = 3.0;
turn_inner_radius = outlet_height;
profile_arc_step = 5.0;

// Provisional rail profile. Confirm with a fit coupon before fabrication.
rail_thickness = 3.0;
rail_depth = 10.0;
rail_face_setback = 56.0;
hook_clearance = 0.6;
hook_engagement = 12.0;
hook_band_width = 11.0;
left_hook_x = -piece_width / 2;
right_hook_x = piece_width / 2 - hook_band_width;
// Photo-derived provisional installation datums. The close-up caliper photos
// indicate approximately 64 mm from the lower vent datum to the AC top /
// flange base, followed by approximately 34 mm of vertical flange rise.
ac_inlet_lower_datum_to_rail_base = 64.0;
rail_flange_height = 34.0;
rail_top_z = ac_inlet_lower_datum_to_rail_base + rail_flange_height;

// Reference mockup dimensions. Clear outlet height and total width came from
// the original measured prompt; housing/rail datums are read from the photos.
mockup_vent_width = total_outlet_width;
mockup_clear_outlet_height = outlet_height;
mockup_vent_face_to_rail_front = rail_face_setback;
mockup_casing_skin = wall_thickness;
mockup_outlet_recess_depth = 8.0;
mockup_rail_lip_depth = rail_depth;

side_wall_outlet_rise = 20.0;
top_duct_height = turn_inner_radius;

bed_yaw_degrees = 45.0;
bed_yaw_sign = -1;
bed_duct_count = 5;

maximum_print_dimension = 220.0;

// Named structural engagement dimensions.
scoop_end_wall_overlap = end_wall_thickness;
end_wall_mounting_wall_overlap = wall_thickness;
hook_spine_overlap = wall_thickness;
spine_mounting_wall_overlap = wall_thickness;
door_guide_scoop_overlap = minimum_structural_overlap;
bed_root_scoop_overlap = minimum_structural_overlap;
bed_vane_root_overlap = wall_thickness;
bed_lower_end_wall_duct_overlap = bed_root_scoop_overlap;
top_duct_corner_overlap = wall_thickness;
top_duct_root_shell_overlap = minimum_structural_overlap;

// Derived installed envelope.
hook_back_y =
  -(
    rail_face_setback
    + rail_depth
    + rail_thickness
    + hook_clearance
    + wall_thickness
  );
turn_front_y = turn_inner_radius + wall_thickness;
turn_end_z = turn_inner_radius + wall_thickness;
hook_bridge_bottom_z = rail_top_z + hook_clearance;
hook_bridge_top_z = hook_bridge_bottom_z + wall_thickness;
hook_drop_bottom_z = hook_bridge_bottom_z - hook_engagement;
hook_bridge_front_y = 0;
mounting_wall_back_y = 0;
mounting_wall_depth = wall_thickness;
alignment_spine_back_y = -wall_thickness;
alignment_spine_depth = 2 * wall_thickness;
rail_front_y = -rail_face_setback;
rail_rear_y =
  rail_front_y - rail_depth - rail_thickness;
hook_rear_drop_front_y = hook_back_y + wall_thickness;
hook_vertical_clearance =
  hook_bridge_bottom_z - rail_top_z;
hook_rear_clearance =
  rail_rear_y - hook_rear_drop_front_y;
hook_usable_rail_depth = rail_depth + hook_clearance;
hook_total_rearward_reach =
  -hook_back_y;
hook_footprint_min_x = left_hook_x;
hook_footprint_max_x = right_hook_x + hook_band_width;
ac_inlet_bottom_z = wall_thickness;
ac_inlet_top_z = turn_end_z;
ac_inlet_clear_height =
  ac_inlet_top_z - ac_inlet_bottom_z;
hook_top_above_ac_inlet =
  hook_bridge_top_z - ac_inlet_top_z;
side_wall_top_z = turn_end_z + side_wall_outlet_rise;
bed_sweep_height =
  min(
    top_duct_height,
    (maximum_print_dimension - piece_width)
      / tan(bed_yaw_degrees)
  );
bed_vane_shift =
  bed_sweep_height * tan(bed_yaw_degrees);
bed_vertical_rise =
  top_duct_height - bed_sweep_height;
bed_duct_collective_span = piece_width;
bed_duct_width =
  bed_duct_collective_span / bed_duct_count;
bed_outlet_cut_extension = bed_duct_width;
bed_top_z =
  turn_end_z - bed_root_scoop_overlap
  + top_duct_height
  + wall_thickness;
door_top_z = bed_top_z;
door_hook_bridge_top_z = door_top_z;
door_hook_bridge_height =
  door_hook_bridge_top_z - hook_bridge_bottom_z;

installed_size_x = piece_width + abs(bed_vane_shift);
installed_size_y = turn_front_y - hook_back_y;
installed_size_z = max(
  door_top_z,
  bed_top_z,
  side_wall_top_z,
  hook_bridge_top_z,
  door_hook_bridge_top_z
);
