// Orange Pi Zero 2W carrier defaults (all dimensions in mm).
//
// Coordinate convention:
// - x: board length axis (65 mm nominal)
// - y: board width axis (30 mm nominal)
// - z: vertical from printed carrier bottom
//
// Geometry values are based on the supplied DXF/PDF:
// - board body: 65 x 30 x 1.2
// - mounting-hole pattern: 58 x 23, 3.5 mm edge inset

// Part selector
// 0 = base plate with studs
// 1 = board mockup
// 2 = assembly preview
part_id = 0;

// Orange Pi Zero 2W board body
board_x = 65.0;
board_y = 30.0;
board_thickness = 1.2;
board_corner_r = 2.0;

// Rectangular base plate (requested 2.0 mm)
base_margin_x = 6.0;
base_margin_y = 6.0;
base_corner_r = 0.0;
base_thickness = 2.0;

// Board mounting-hole pattern (Raspberry Pi Zero compatible)
mount_hole_inset_x = 3.5;
mount_hole_inset_y = 3.5;

// Stud + screw interface
stud_d = 8.0;
stud_h = 3.2;
m3_clearance_d = 3.2;

// Underside screw-head recess (counterbore) for flush base underside
head_recess_d = 6.4;
head_recess_h = 2.6;
