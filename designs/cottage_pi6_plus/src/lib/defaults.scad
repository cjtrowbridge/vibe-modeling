// Project defaults (all dimensions in mm)
//
// Coordinate convention:
// - x: left/right across the board
// - y: front/back across the board
// - z: vertical from the bottom of the printed base

// Part selector (set via -D part_id=0/1/2...)
// NOTE: Numeric ids are safer than strings across shells/OSes.
part_id = 0; // 0=assembled preview, 1=base, 2=roof, 3=drawer

// Orange Pi 6 Plus board + cooling envelope (first-pass values)
board_x = 115;
board_y = 100;
board_thickness = 1.8;
cooler_envelope_z = 23.2;

// Internal fit and support
board_clearance_xy = 2.5;
drawer_slide_clearance = 0.8;
mount_stud_h = 3;
stud_to_board_standoff_z = 10;
top_clearance_z = 4;
corner_pad_d = 10;
corner_pad_inset = 9;
board_stop_size = 2.2;
board_stop_h = 1.1;
mount_hole_d = 3;
mount_head_recess_d = 6;
mount_head_recess_h = 2.2;
drawer_hole_set1_from_exhaust_wall = 3;
drawer_hole_set_spacing_x = 96;
drawer_hole_pair_spacing_y = 94;

// Side chimney room (internal partition)
chimney_room_x = 42;
chimney_room_divider_t = 2.2;
divider_hole_w = 69;
divider_hole_h = 24;
divider_hole_y_offset = 0;
divider_hole_z_from_board_top = 12;
divider_roof_seal_gap = 0.3;

// Main shell
wall = 2.4;
floor_thickness = 3;
// Target side wall profile is roughly 2:3 (height:width).
body_wall_height = (board_y + 2 * board_clearance_xy + 2 * wall) * (2 / 3) + stud_to_board_standoff_z;

// Broad service opening for uncertain I/O positioning (left wall)
io_cutout_span_y = 94;
io_cutout_z0 = floor_thickness + mount_stud_h + stud_to_board_standoff_z - 0.5;
io_cutout_h = 22;

// Cottage styling on the base
// Scaled to remain proportional as body_wall_height changes.
front_door_h = body_wall_height * 0.75;
front_door_w = front_door_h * 0.51;
front_door_sill = body_wall_height * 0.08;
window_d = front_door_w * 0.74;
window_z = body_wall_height * (2 / 3);
// Place decorative front windows symmetrically on both sides of the door.
window_x_offset = (
  front_door_w / 2 +
  ((board_x + 2 * board_clearance_xy + chimney_room_divider_t + chimney_room_x + 2 * wall) / 2 - wall)
) / 2;

// Front porch
porch_enabled = true;
porch_w = 56;
porch_d = 32;
porch_deck_z = 0;
porch_deck_t = 2.6;
porch_post_w = 3.2;
porch_post_d = 3.2;
porch_awning_t = 2.2;
porch_roof_angle_deg = 22;

// Roof shell
roof_overhang = 4;
roof_wall = 2.2;
roof_eave_h = 11;
roof_peak_h = 31;
roof_fit_clearance = 0.6;
roof_insert_clearance = 0.35;
roof_insert_depth = roof_wall;
gable_window_d = 9;
gable_window_z = 18;

// Chimney exhaust
chimney_x_offset_from_room_center = 0;
chimney_y = 0;
chimney_shaft_w = 32;
chimney_shaft_d = 32;
chimney_h = 24;
chimney_wall = 2;
chimney_flue_d = 28;
chimney_embed = 2;

// 40 mm fan interface on top of chimney
fan_frame = 40;
fan_hole_spacing = 32;
fan_mount_hole_d = 4.2;
fan_center_cutout_d = 28;
fan_mount_plate_t = 3;
fan_cutout_transition_h = 5;
fan_screw_hole_depth = 8;
