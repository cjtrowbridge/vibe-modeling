// Project defaults (all dimensions in mm)

// Part selector (set via -D part_id=0/1/2...)
// NOTE: OpenSCAD CLI `-D` string quoting on Windows is fragile; use numeric ids.
part_id = 0; // 0=dtv_yagi_insert_poc, 1=dtv_yagi_focal_alignment_poc

// Insert section (fits inside the square tube)
insert_width = 45;
insert_height = 19;
insert_depth = 15;
insert_corner_bevel = 2;

// Outside mounting pad (in front of the tube)
outer_width = 50;
outer_height = 26;
outer_thickness = 3;

// Centered vertical screw hole through the insert section
screw_hole_d = 6;

// Focal alignment POC for carrying the yagi card
// "Above" is +Y in this model. The focal point is measured from the center of the
// outside pad ("tab"), using the pad volume center as the reference point.
focal_rise_above_tab = 105;
card_elevation_deg = 25;

// Dish direction convention for this model:
// The insert / screw-hole hardware protrudes from the tab along -Z, so default dish
// direction is -Z. The yagi_card's director is at local -Z, so this preserves
// "short element toward dish" without mirroring when false.
dish_toward_positive_z = false;

// Integrated focal tab extension (part_id=1)
// Extends the existing outer tab upward (along +Y) and thickens it (along +Z)
// instead of adding a separate support prism.
focal_tab_thickness = 10;   // Z thickness for the extended tab in part_id=1
focal_tab_top_margin = 0;   // extra height above the focal point

// Optional focal marker (included in STL) for alignment debugging
show_focus_marker = true;
focus_marker_d = 4;
focus_marker_h = 4;

// Relief notch in the integrated tab so it does not intrude into the driven-element groove.
clear_driven_groove_in_tab = true;
driven_groove_keepout_margin = 1;

// Yagi card placement preview/model
// Set preview_card_as_background=true to ghost it in PNG and exclude it from STL.
show_card_preview = true;
preview_card_as_background = false;

// Align the focal point to the center of the driven-element center slot.
// If you want RF wire centerline alignment instead, set this to 0.
card_focus_ref_y = undef;

// Yagi card geometry (mirrors designs/yagi_card defaults for placement preview)
mount_seat_to_focus = 33;
card_bottom_from_seat = 6;

card_size = 60;
card_size_x = 95;
card_thickness = 6;

element_spacing = 22;
groove_w = 3;
groove_depth = 4.382;
element_end_margin = 1;
dipole_gap = 6;

director_len = 66;
driven_len = 83;
reflector_len = 87;
