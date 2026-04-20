// old_rca_display_baseplate defaults (mm).

// Part selector
// 0 = full baseplate
// 1 = left half (lengthwise split)
// 2 = right half (lengthwise split)
part_id = 0;

// IKEA Kallax-friendly envelope
baseplate_w = 325.0;
baseplate_d = 210.0;
baseplate_h = 4.0;
baseplate_corner_r = 2.5;

// Tower row layout
tower_count = 4;
tower_row_side_margin = 8.0;
tower_row_back_margin = 2.0; // keep pockets as far back as practical

// Recessed tower locator pockets
recess_depth = 2.0;
recess_clearance = 0.5; // applied per side

// Front faceplate (nameplate wall)
faceplate_enable = 1;
faceplate_h = 20.0;
faceplate_run = 20.0;
faceplate_text = "\"Those things are the old RCA building.\" -Neuromancer";
faceplate_text_size = 8.0;
faceplate_text_relief = 0.5;
faceplate_text_slope_frac = 0.5; // 0=start at bottom-front edge, 1=top-back edge

// Split controls (for part_id 1/2)
split_x = 0.0;
split_eps = 0.02;

// old_rca_building rev_0002 floor footprint parameters
tower_x = 44.5;
tower_y = 96.0;
wing_y = 53.6;
wing_overlap_y = 5.6;
wing_attach_side = 1; // +1: front is -Y, back is +Y

side_setback_step = 7.0;
side_tier4_center_to_front_frac = 0.75;

front_setback_step = 3.0;
front_center_setback_step = 3.0;
front_center_extra_protrusion = 3.0;
front_center_x_start_frac = 1.0 / 3.0;
front_center_x_end_frac = 2.0 / 3.0;
