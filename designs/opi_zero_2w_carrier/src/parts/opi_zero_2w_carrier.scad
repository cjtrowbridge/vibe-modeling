// Minimal Orange Pi Zero 2W carrier:
// - 2 mm thick rectangular base plate
// - 4 studs at board mounting-hole locations
// - M3 clearance holes through base + studs
// - underside counterbores for flush screw heads

function base_x() = board_x + 2 * base_margin_x;
function base_y() = board_y + 2 * base_margin_y;
function hole_x() = board_x / 2 - mount_hole_inset_x;
function hole_y() = board_y / 2 - mount_hole_inset_y;
function board_z0() = base_thickness + stud_h;

module _assert_dims() {
  assert(board_x > 0 && board_y > 0 && board_thickness > 0,
    "board_x, board_y, and board_thickness must be > 0");
  assert(board_corner_r >= 0 && board_corner_r * 2 <= min(board_x, board_y),
    "board_corner_r is out of range");

  assert(base_margin_x >= 0 && base_margin_y >= 0,
    "base margins must be >= 0");
  assert(base_x() > 0 && base_y() > 0,
    "derived base_x/base_y must be > 0");
  assert(base_corner_r >= 0 && base_corner_r * 2 <= min(base_x(), base_y()),
    "base_corner_r is out of range");
  assert(base_thickness > 0,
    "base_thickness must be > 0");

  assert(mount_hole_inset_x > 0 && mount_hole_inset_y > 0,
    "mount hole insets must be > 0");
  assert(hole_x() > 0 && hole_y() > 0,
    "mount hole insets are too large for board size");
  assert(hole_x() <= base_x() / 2 && hole_y() <= base_y() / 2,
    "hole locations fall outside base");

  assert(stud_d > 0 && stud_h > 0,
    "stud_d and stud_h must be > 0");
  assert(m3_clearance_d > 0,
    "m3_clearance_d must be > 0");
  assert(m3_clearance_d < stud_d,
    "m3_clearance_d must be < stud_d");

  assert(head_recess_d > m3_clearance_d,
    "head_recess_d must be > m3_clearance_d");
  assert(head_recess_d <= stud_d + 0.2,
    "head_recess_d should fit within stud diameter");
  assert(head_recess_h > 0,
    "head_recess_h must be > 0");
  assert(head_recess_h <= base_thickness + stud_h,
    "head_recess_h is deeper than the available base+stud thickness");
}

module _rounded_rect_2d(w, d, r) {
  if (r <= 0) {
    square([w, d], center = true);
  } else {
    hull() {
      for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
          translate([sx * (w / 2 - r), sy * (d / 2 - r)])
            circle(r = r, $fn = 48);
        }
      }
    }
  }
}

module _base_plate() {
  linear_extrude(height = base_thickness, center = false, convexity = 8)
    _rounded_rect_2d(base_x(), base_y(), base_corner_r);
}

module _studs() {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      translate([sx * hole_x(), sy * hole_y(), base_thickness])
        cylinder(d = stud_d, h = stud_h, $fn = 56);
    }
  }
}

module _m3_through_holes() {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      translate([sx * hole_x(), sy * hole_y(), -0.1])
        cylinder(d = m3_clearance_d, h = base_thickness + stud_h + 0.2, $fn = 40);
    }
  }
}

module _head_recesses_underside() {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      translate([sx * hole_x(), sy * hole_y(), -0.1])
        cylinder(d = head_recess_d, h = head_recess_h + 0.1, $fn = 40);
    }
  }
}

module _board_mount_holes_negative() {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      translate([sx * hole_x(), sy * hole_y(), -0.1])
        cylinder(d = m3_clearance_d, h = board_thickness + 0.2, $fn = 32);
    }
  }
}

module opi_zero_2w_carrier() {
  _assert_dims();
  difference() {
    union() {
      _base_plate();
      _studs();
    }
    _m3_through_holes();
    _head_recesses_underside();
  }
}

module opi_zero_2w_board_mock() {
  _assert_dims();
  difference() {
    linear_extrude(height = board_thickness, center = false, convexity = 8)
      _rounded_rect_2d(board_x, board_y, board_corner_r);
    _board_mount_holes_negative();
  }
}

module opi_zero_2w_carrier_assembly_preview() {
  _assert_dims();
  opi_zero_2w_carrier();
  color([0.10, 0.34, 0.18, 0.55])
    translate([0, 0, board_z0()])
      opi_zero_2w_board_mock();
}
