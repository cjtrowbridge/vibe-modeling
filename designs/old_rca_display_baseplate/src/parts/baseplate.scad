// Geometry for a 4-tower old RCA display baseplate.
// The recessed shapes are full locator pockets for old_rca_building bases.

function _tower_x0() = -tower_x / 2;
function _tower_x1() = tower_x / 2;
function _tower_back_y() = wing_attach_side > 0 ? tower_y / 2 : -tower_y / 2;
function _tower_front_y() = -_tower_back_y();
function _wing_y0() = wing_attach_side > 0
  ? (tower_y / 2 - wing_overlap_y)
  : (-tower_y / 2 + wing_overlap_y - wing_y);
function _wing_y1() = _wing_y0() + wing_y;

function _front_primary_ext() = 4 * front_setback_step;
function _front_center_ext() = 4 * front_center_setback_step + front_center_extra_protrusion;
function _front_ext_max() = max(_front_primary_ext(), _front_center_ext());
function _footprint_front_y() = wing_attach_side > 0
  ? (_tower_front_y() - _front_ext_max())
  : (_tower_front_y() + _front_ext_max());

function _tier4_front_limit_y() = _tower_front_y() * side_tier4_center_to_front_frac;
function _side_y0() = min(_tower_back_y(), _tier4_front_limit_y());
function _side_y1() = max(_tower_back_y(), _tier4_front_limit_y());

function _front_center_x0() = _tower_x0() + tower_x * front_center_x_start_frac;
function _front_center_x1() = _tower_x0() + tower_x * front_center_x_end_frac;

function _footprint_min_x() = _tower_x0() - side_setback_step;
function _footprint_max_x() = _tower_x1() + side_setback_step;
function _footprint_min_y() = min(_footprint_front_y(), min(_wing_y0(), _wing_y1()));
function _footprint_max_y() = max(_tower_back_y(), max(_wing_y0(), _wing_y1()));
function _footprint_w() = _footprint_max_x() - _footprint_min_x();
function _footprint_d() = _footprint_max_y() - _footprint_min_y();

function _recess_outer_delta() = recess_clearance;
function _recess_outer_w() = _footprint_w() + 2 * _recess_outer_delta();
function _recess_outer_d() = _footprint_d() + 2 * _recess_outer_delta();
function _recess_outer_half_w() = _recess_outer_w() / 2;
function _recess_outer_max_y_local() = _footprint_max_y() + _recess_outer_delta();
function _plate_back_y() = baseplate_d / 2;
function _plate_front_y() = -baseplate_d / 2;
function _row_center_y() = _plate_back_y() - tower_row_back_margin - _recess_outer_max_y_local();
function _faceplate_slope_len() = sqrt(faceplate_run * faceplate_run + faceplate_h * faceplate_h);
function _faceplate_text_local_y() = _faceplate_slope_len() * faceplate_text_slope_frac;
function _model_max_z() = max(baseplate_h, faceplate_enable == 1 ? (faceplate_h + faceplate_text_relief) : baseplate_h);

function _row_centers_span_x() = baseplate_w - 2 * (tower_row_side_margin + _recess_outer_half_w());
function _row_pitch() = tower_count > 1 ? _row_centers_span_x() / (tower_count - 1) : 0;
function _row_first_center_x() = -baseplate_w / 2 + tower_row_side_margin + _recess_outer_half_w();

module _assert_dims() {
  assert(baseplate_w > 0 && baseplate_d > 0 && baseplate_h > 0,
    "baseplate dimensions must be > 0");
  assert(baseplate_corner_r >= 0 && baseplate_corner_r * 2 <= min(baseplate_w, baseplate_d),
    "baseplate_corner_r is out of range");
  assert(tower_count >= 1,
    "tower_count must be >= 1");
  assert(tower_row_side_margin >= 0 && tower_row_back_margin >= 0,
    "tower row margins must be >= 0");
  assert(recess_depth > 0 && recess_depth < baseplate_h,
    "recess_depth must be > 0 and < baseplate_h");
  assert(recess_clearance >= 0,
    "recess_clearance must be >= 0");
  assert(faceplate_enable == 0 || faceplate_enable == 1,
    "faceplate_enable must be 0 or 1");
  assert(faceplate_h > 0 && faceplate_run > 0,
    "faceplate_h and faceplate_run must be > 0");
  assert(faceplate_text_size > 0 && faceplate_text_relief >= 0,
    "faceplate_text_size must be > 0 and faceplate_text_relief must be >= 0");
  assert(faceplate_text_slope_frac >= 0 && faceplate_text_slope_frac <= 1,
    "faceplate_text_slope_frac must be in [0, 1]");
  assert(wing_attach_side == 1 || wing_attach_side == -1,
    "wing_attach_side must be 1 or -1");
  assert(side_setback_step >= 0,
    "side_setback_step must be >= 0");
  assert(side_tier4_center_to_front_frac >= 0 && side_tier4_center_to_front_frac <= 1,
    "side_tier4_center_to_front_frac must be in [0, 1]");
  assert(front_setback_step >= 0 && front_center_setback_step >= 0 && front_center_extra_protrusion >= 0,
    "front setback parameters must be >= 0");
  assert(front_center_x_start_frac >= 0 && front_center_x_end_frac <= 1 &&
      front_center_x_end_frac > front_center_x_start_frac,
    "front center X fractions are invalid");
  assert(_recess_outer_w() > 0 && _recess_outer_d() > 0,
    "recess outer dimensions must be positive");
  assert(_row_centers_span_x() >= 0,
    "baseplate width too small for tower count and side margins");
  assert(_row_pitch() >= _recess_outer_w() || tower_count == 1,
    "row pitch is smaller than recess width (recesses overlap)");
  assert(_row_center_y() + _recess_outer_max_y_local() <= baseplate_d / 2 + 0.001,
    "recess row extends past back edge");
  assert(_row_center_y() + (_footprint_min_y() - _recess_outer_delta()) >= -baseplate_d / 2 - 0.001,
    "recess row extends past front edge");
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

module _tower_base_footprint_2d() {
  union() {
    // Tower main rectangle.
    translate([_tower_x0(), min(_tower_front_y(), _tower_back_y())])
      square([tower_x, abs(_tower_back_y() - _tower_front_y())], center = false);

    // Rear wing/bump-out.
    translate([_tower_x0(), min(_wing_y0(), _wing_y1())])
      square([tower_x, abs(_wing_y1() - _wing_y0())], center = false);

    // Side setbacks active at floor.
    translate([_tower_x0() - side_setback_step, _side_y0()])
      square([side_setback_step, _side_y1() - _side_y0()], center = false);
    translate([_tower_x1(), _side_y0()])
      square([side_setback_step, _side_y1() - _side_y0()], center = false);

    // Primary front setbacks.
    if (_front_primary_ext() > 0) {
      if (wing_attach_side > 0) {
        translate([_tower_x0(), _tower_front_y() - _front_primary_ext()])
          square([tower_x, _front_primary_ext()], center = false);
      } else {
        translate([_tower_x0(), _tower_front_y()])
          square([tower_x, _front_primary_ext()], center = false);
      }
    }

    // Centered front setback extension.
    if (_front_center_ext() > _front_primary_ext()) {
      extra = _front_center_ext() - _front_primary_ext();
      if (wing_attach_side > 0) {
        translate([_front_center_x0(), _tower_front_y() - _front_primary_ext() - extra])
          square([_front_center_x1() - _front_center_x0(), _front_primary_ext() + extra], center = false);
      } else {
        translate([_front_center_x0(), _tower_front_y()])
          square([_front_center_x1() - _front_center_x0(), _front_primary_ext() + extra], center = false);
      }
    }
  }
}

module _tower_recess_pocket_2d() {
  offset(delta = _recess_outer_delta())
    _tower_base_footprint_2d();
}

module _all_recess_pockets_2d() {
  for (i = [0 : tower_count - 1]) {
    x = _row_first_center_x() + i * _row_pitch();
    translate([x, _row_center_y()])
      _tower_recess_pocket_2d();
  }
}

module _baseplate_body() {
  linear_extrude(height = baseplate_h, center = false, convexity = 8)
    _rounded_rect_2d(baseplate_w, baseplate_d, baseplate_corner_r);
}

module _faceplate_body() {
  if (faceplate_enable == 1) {
    // Build a full-width triangular prism in YZ, then extrude along X.
    // Side view: right triangle with run=faceplate_run and rise=faceplate_h.
    translate([-baseplate_w / 2, 0, 0])
      rotate([0, 90, 0])
        rotate([0, 0, 90])
          linear_extrude(height = baseplate_w, center = false, convexity = 8)
            polygon(points = [
              [_plate_front_y(), 0],
              [_plate_front_y() + faceplate_run, 0],
              [_plate_front_y() + faceplate_run, faceplate_h]
            ]);
  }
}

module _faceplate_text() {
  if (faceplate_enable == 1 && faceplate_text_relief > 0) {
    // Place text on the 45-degree face and extrude outward for paintable relief.
    translate([0, _plate_front_y(), 0])
      rotate([45, 0, 0])
        translate([0, _faceplate_text_local_y(), 0])
        linear_extrude(height = faceplate_text_relief, center = false, convexity = 8)
          text(faceplate_text, size = faceplate_text_size, halign = "center", valign = "center");
  }
}

module old_rca_display_baseplate() {
  _assert_dims();
  union() {
    difference() {
      _baseplate_body();
      translate([0, 0, baseplate_h - recess_depth])
        linear_extrude(height = recess_depth + 0.02, center = false, convexity = 10)
          _all_recess_pockets_2d();
    }
    _faceplate_body();
    _faceplate_text();
  }
}

module old_rca_display_baseplate_left_half() {
  _assert_dims();
  intersection() {
    old_rca_display_baseplate();
    translate([-baseplate_w / 2 - split_eps, -baseplate_d - split_eps, -split_eps])
      cube([baseplate_w / 2 + split_eps + split_x, 2 * baseplate_d + 2 * split_eps, _model_max_z() + 2 * split_eps],
        center = false);
  }
}

module old_rca_display_baseplate_right_half() {
  _assert_dims();
  intersection() {
    old_rca_display_baseplate();
    translate([split_x, -baseplate_d - split_eps, -split_eps])
      cube([baseplate_w / 2 + split_eps, 2 * baseplate_d + 2 * split_eps, _model_max_z() + 2 * split_eps],
        center = false);
  }
}
