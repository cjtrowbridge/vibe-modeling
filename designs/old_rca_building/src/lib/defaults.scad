// old_rca_building defaults (all dimensions in mm).
// Revision target: maximum-simplification L-shape prototype.
//
// Coordinate convention:
// - X: left/right
// - Y: front/back
// - Z: vertical

// Part selector
// 0 = final model
// 1 = outer mass only
// 2 = negative cutters (debug)
// 3 = internal supports only
// 4 = lower split section (below split_z)
// 5 = upper split section (at/above split_z)
// 6 = removable wing-roof insert (print separately)
// 7 = glow harness spacer/lip between split lower+upper
part_id = 0;

// Printer/process assumptions
wall = 2.0;
floor = 2.0;
debug_open_bottom = 0; // 1 = temporary debug mode to remove bottom surfaces (open from below)

// Device envelope constraints
phone_h_max = 163.6;
phone_w_max = 78.1;
phone_t_max = 8.9;
side_gap_min = 3.5;
face_gap_min = 3.0;
top_clearance_min = 8.0;
overall_height_max = 215.0; // keep each split print piece <= 220 mm build limit with ~5 mm margin

// Fan interface (40 mm reference)
fan_frame = 40.0;
fan_hole_spacing = 32.0;
fan_hole_d = 3.6;
fan_square_opening = 40.5; // frame-clearance reference size used for compact bump-out envelope sizing
fan_intake_d = 38.0; // central airflow opening in the mounting plate (keeps corner screw-hole land)

// Cable slot below fan (sealable with hot glue)
rear_cable_slot_w = 12.0;
rear_cable_slot_h = 7.0;

// Tower + base-wing massing (simple L shape in plan)
tower_x = 44.5; // must remain >= fan_frame
tower_y = 96.0;
tower_z = 242.0; // support_z + phone_h_max + top_clearance_min, rounded

base_z = 88.0; // tower lower plenum height
tower_inner_roof_bevel = 0.0; // 0 = auto full-depth 45 deg inverse bevel from opening to walls
wing_vault_radius = 0.0; // legacy parameter; vault cut is disabled in current flat-roof bump-out
bump_margin = 2.0; // desired minimum envelope margin around fan/USB features
wing_x = fan_square_opening + 2 * bump_margin; // no extra side space beside fan opening
wing_y = 53.6; // gives exposed bump-out length of 48.0 with 5.6 overlap (tower:bump-out = 2:1)
wing_z = fan_square_opening + rear_cable_slot_h + 3 * bump_margin; // no extra above fan or below USB slot
wing_overlap_y = 5.6; // overlap in Y between tower and wing
wing_attach_side = 1; // +1 = +Y side, -1 = -Y side

// Simplified facade: side-only tiered setbacks (no window/ornament detail).
side_setback_enable = 1;
side_setback_step = 7.0; // uniform protrusion distance for each tier
front_setback_enable = 1;
front_setback_step = 3.0; // cumulative front-face protrusion by tier: 3, 6, 9, 12 mm
front_center_setback_enable = 1;
front_center_setback_step = 3.0; // cumulative center-front protrusion by tier: 3, 6, 9, 12 mm
front_center_extra_protrusion = 3.0; // extra protrusion beyond primary front tiers at each matching tier
front_center_x_start_frac = 1.0 / 3.0; // centered tier band starts at 1/3 facade width
front_center_x_end_frac = 2.0 / 3.0; // centered tier band ends at 2/3 facade width
front_center_tier_height_boost = 4.0; // each center-front tier top is this much higher than base front tier tops
side_top_tier_top_gap = 10.0; // keep top tier below tower top by this amount
side_tier2_center_to_front_frac = 0.25; // 25% from center toward front
side_tier3_center_to_front_frac = 0.50; // 50% from center toward front
side_tier4_center_to_front_frac = 0.75; // 75% from center toward front
side_left_tier0_z = 0.0; // tier base at model floor
side_left_tier1_z = 92.0;
side_left_tier2_z = 129.67; // normalized middle tier top
side_left_tier3_z = 167.33; // normalized middle tier top
side_right_tier0_z = 0.0; // mirrored to left, tier base at model floor
side_right_tier1_z = 92.0; // mirrored to left
side_right_tier2_z = 129.67; // mirrored to left
side_right_tier3_z = 167.33; // mirrored to left

// Phone void rotated 90 deg around Z from prior draft:
// - narrow axis in X (phone thickness + face gaps)
// - wide axis in Y (phone width + side gaps)
void_x = 18.0;
void_y = 88.0;
void_center_x = 0.0;
void_center_y = 0.0;
tower_top_lip_h = 0.0; // through-cut void to top; set 0 to avoid partial top-lip overhang
support_z = 70.0; // keep >= 70 and maximize enclosed phone depth under height cap

// Rails (2 on front wall + 2 on back wall + 1 on each wide-side wall)
rail_inset_from_x_ends = 2.2;
rail_width_x = 2.8;
rail_protrusion_y = 2.0;
rail_side_protrusion_x = 2.0;
rail_side_span_y = 18.0;
rail_phone_margin_min = 2.0;

// Bottom cage with center cable bend window
cage_bar_h = 4.0;
cable_window_x = 12.0;
cable_window_y = 40.0;
split_z = support_z - cage_bar_h; // horizontal split plane: upper section starts at phone-holder base floor

// Split-interface glow harness (external spacer/lip artifact).
harness_core_h = 2.0; // core spacer thickness (slice from bottom of split upper)
harness_lip_grip_h = 2.0; // nominal lip reach above and below the core
harness_lip_margin_z = 1.0; // extra requested fit margin in both vertical directions
harness_lip_clearance = 0.4; // radial clearance from tower exterior to harness inner lip wall
harness_lip_wall = 1.2; // lip wall thickness
harness_backoff_y = 0.2; // remove back-edge lip to keep front/sides-only retention
harness_inner_front_lip_clearance = 0.6; // inboard lead depth from front inner wall before stop shoulder
harness_inner_front_lip_t = 1.2; // front inner-wall lip thickness along Y
harness_inner_front_lip_inset_x = 1.0; // inset inner front lips from side walls and void edges
harness_front_lip_opposed_margin_min = 1.0; // minimum margin between opposing outside/inside front lips

// Removable wing-roof insert (for support-free wing cavity printing)
roof_insert_clearance = 0.30; // fit clearance to top-access aperture
roof_insert_plate_h = wall; // roof panel thickness
roof_insert_lip_t = 1.2; // lip thickness on non-fan edges
roof_insert_lip_h = 4.0; // lip depth into cavity
roof_insert_lip_inset = 0.15; // inset tabs from aperture walls for balanced retention/entry
roof_insert_cap_overhang_x = 2.0; // extend cap to outside X wall edges
roof_insert_cap_overhang_fan_y = 2.0; // extend cap to fan-side outside wall edge
roof_insert_tower_backoff = 0.3; // retract cap edge from tower-side aperture boundary

// Fan/cable placement derived from compact bump-out envelope rules.
fan_center_x = 0.0;
fan_center_z = rear_cable_slot_h + 1.5 * bump_margin + fan_square_opening / 2;

rear_cable_slot_center_x = fan_center_x;
rear_cable_slot_center_z = bump_margin + rear_cable_slot_h / 2;
