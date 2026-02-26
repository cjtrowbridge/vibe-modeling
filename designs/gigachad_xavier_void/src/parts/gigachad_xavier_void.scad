module _assert_dims() {
  assert(main_x > 0, "main_x must be > 0");
  assert(main_y > 0, "main_y must be > 0");
  assert(main_z > 0, "main_z must be > 0");
  assert(shaft_x > 0, "shaft_x must be > 0");
  assert(shaft_y > 0, "shaft_y must be > 0");
  assert(shaft_z > 0, "shaft_z must be > 0");
  assert(shaft_margin_x >= 0, "shaft_margin_x must be >= 0");
  assert(shaft_margin_end >= 0, "shaft_margin_end must be >= 0");
  assert(shaft_x + 2 * shaft_margin_x <= main_x,
    "shaft_x + 2*shaft_margin_x must fit within main_x");
  assert(shaft_y + shaft_margin_end <= main_y,
    "shaft_y + shaft_margin_end must fit within main_y");

  if (fan_mount_enabled) {
    hole_margin_x = (fan_mount_pad_x - fan_hole_spacing) / 2;
    hole_margin_y = (fan_mount_pad_y - fan_hole_spacing) / 2;
    plate_y0 = (fan_mount_pad_offset_y + fan_mount_pad_y / 2) - fan_mount_plate_y / 2;

    assert(fan_mount_pad_x > 0, "fan_mount_pad_x must be > 0");
    assert(fan_mount_pad_y > 0, "fan_mount_pad_y must be > 0");
    assert(fan_mount_pad_x <= shaft_x, "fan_mount_pad_x must fit within shaft_x");
    assert(fan_mount_pad_y <= shaft_y, "fan_mount_pad_y must fit within shaft_y");
    assert(fan_mount_pad_offset_y >= 0, "fan_mount_pad_offset_y must be >= 0");
    assert(fan_mount_pad_offset_y + fan_mount_pad_y <= shaft_y,
      "fan_mount_pad_offset_y + fan_mount_pad_y must fit within shaft_y");

    assert(fan_mount_plate_x > 0, "fan_mount_plate_x must be > 0");
    assert(fan_mount_plate_y > 0, "fan_mount_plate_y must be > 0");
    assert(fan_mount_plate_x <= shaft_x, "fan_mount_plate_x must fit within shaft_x");
    assert(fan_mount_plate_y <= shaft_y, "fan_mount_plate_y must fit within shaft_y");
    assert(plate_y0 >= 0, "fan mount plate extends below shaft Y min");
    assert(plate_y0 + fan_mount_plate_y <= shaft_y, "fan mount plate extends beyond shaft Y max");
    assert(fan_mount_plate_thickness > 0, "fan_mount_plate_thickness must be > 0");
    assert(fan_mount_plate_thickness <= shaft_z,
      "fan_mount_plate_thickness must be <= shaft_z");
    assert(fan_duct_hole_d > 0, "fan_duct_hole_d must be > 0");
    assert(fan_duct_hole_d <= fan_mount_plate_x && fan_duct_hole_d <= fan_mount_plate_y,
      "fan_duct_hole_d must fit within fan mount plate footprint");

    assert(fan_hole_spacing > 0, "fan_hole_spacing must be > 0");
    assert(fan_hole_d > 0, "fan_hole_d must be > 0");
    assert(fan_hole_pin_height > 0, "fan_hole_pin_height must be > 0");
    assert(fan_hole_pin_height <= shaft_z,
      "fan_hole_pin_height must be <= shaft_z");
    assert(fan_hole_spacing <= fan_mount_pad_x && fan_hole_spacing <= fan_mount_pad_y,
      "fan_hole_spacing must fit within fan mount pad");
    assert(hole_margin_x - fan_hole_d / 2 >= 0,
      "fan holes exceed shaft edge in X");
    assert(hole_margin_y - fan_hole_d / 2 >= 0,
      "fan holes exceed shaft edge in Y");
  }
}

function _shaft_x0() = -main_x / 2 + shaft_margin_x;
function _shaft_y0() = shaft_from_back_end
  ? (-main_y + shaft_margin_end)
  : (-shaft_margin_end - shaft_y);

module main_back_prism() {
  _assert_dims();
  translate([-main_x / 2, -main_y, 0])
    cube([main_x, main_y, main_z], center = false);
}

module top_shaft() {
  _assert_dims();
  translate([_shaft_x0(), _shaft_y0(), main_z])
    union() {
      difference() {
        cube([shaft_x, shaft_y, shaft_z], center = false);
        if (fan_mount_enabled) {
          _fan_mount_plate_relief_local();
        }
      }

      if (fan_mount_enabled) {
        _fan_hole_pins_local();
      }
    }
}

module gigachad_xavier_void_positive() {
  _assert_dims();
  union() {
    main_back_prism();
    top_shaft();
  }
}

function _fan_mount_pad_x0() = (shaft_x - fan_mount_pad_x) / 2;
function _fan_mount_pad_y0() = fan_mount_pad_offset_y;
function _fan_hole_center_x() = _fan_mount_pad_x0() + fan_mount_pad_x / 2;
function _fan_hole_center_y() = _fan_mount_pad_y0() + fan_mount_pad_y / 2;
function _fan_mount_plate_x0() = _fan_hole_center_x() - fan_mount_plate_x / 2;
function _fan_mount_plate_y0() = _fan_hole_center_y() - fan_mount_plate_y / 2;
function _fan_hole_margin_x() = (fan_mount_pad_x - fan_hole_spacing) / 2;
function _fan_hole_margin_y() = (fan_mount_pad_y - fan_hole_spacing) / 2;

module _fan_mount_plate_relief_local() {
  // Negative relief in the cutter that leaves a positive fan-mount plate in the final part.
  // The circular opening is excluded so the duct remains open after subtraction.
  difference() {
    translate([_fan_mount_plate_x0(), _fan_mount_plate_y0(), 0])
      cube([fan_mount_plate_x, fan_mount_plate_y, fan_mount_plate_thickness], center = false);

    translate([_fan_hole_center_x(), _fan_hole_center_y(), -0.01])
      cylinder(d = fan_duct_hole_d, h = fan_mount_plate_thickness + 0.02, center = false, $fn = 96);
  }
}

module _fan_hole_pins_local() {
  // Positive pins on the cutter create actual mounting holes in the final part after subtraction.
  for (x = [
    _fan_mount_pad_x0() + _fan_hole_margin_x(),
    _fan_mount_pad_x0() + fan_mount_pad_x - _fan_hole_margin_x()
  ]) {
    for (y = [
      _fan_mount_pad_y0() + _fan_hole_margin_y(),
      _fan_mount_pad_y0() + fan_mount_pad_y - _fan_hole_margin_y()
    ]) {
      translate([x, y, 0])
        cylinder(d = fan_hole_d, h = fan_hole_pin_height, center = false, $fn = 48);
    }
  }
}
