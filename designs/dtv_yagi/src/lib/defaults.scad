// Project defaults (all dimensions in mm)

// Part selector (set via -D part_id=0/1/2...)
// NOTE: OpenSCAD CLI `-D` string quoting on Windows is fragile; use numeric ids.
part_id = 0; // 0=dtv_yagi_insert_poc

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
