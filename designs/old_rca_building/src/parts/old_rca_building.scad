// Geometry for old_rca_building simplified L-shape draft.
// Coordinate convention:
// - X: left/right (centered around 0 at tower center)
// - Y: front/back (centered around 0 at tower center)
// - Z: vertical

function _tower_x0() = -tower_x / 2;
function _tower_y0() = -tower_y / 2;
function _wing_x0() = -wing_x / 2;
function _wing_x1() = _wing_x0() + wing_x;
function _wing_y0() = wing_attach_side > 0
  ? (tower_y / 2 - wing_overlap_y)
  : (-tower_y / 2 + wing_overlap_y - wing_y);
function _wing_y1() = _wing_y0() + wing_y;
function _wing_plenum_top_z() = min(base_z, wing_z);
function _void_x0() = void_center_x - void_x / 2;
function _void_y0() = void_center_y - void_y / 2;
function _void_x1() = void_center_x + void_x / 2;
function _void_y1() = void_center_y + void_y / 2;
function _top_open_x() = void_x - 2 * rail_side_protrusion_x;
function _top_open_y() = void_y - 2 * rail_protrusion_y;
function _top_open_x0() = void_center_x - _top_open_x() / 2;
function _top_open_y0() = void_center_y - _top_open_y() / 2;
function _wing_link_x0() = max(_tower_x0() + wall, _wing_x0() + wall);
function _wing_link_x1() = min(-_tower_x0() - wall, _wing_x1() - wall);
function _tower_inner_ix0() = _tower_x0() + wall;
function _tower_inner_ix1() = -_tower_x0() - wall;
function _tower_inner_iy0() = _tower_y0() + wall;
function _tower_inner_iy1() = -_tower_y0() - wall;
function _wing_inner_ix0() = _wing_x0() + wall;
function _wing_inner_ix1() = _wing_x1() - wall;
function _wing_inner_iy0() = _wing_y0() + wall;
function _wing_inner_iy1() = _wing_y1() - wall;
function _wing_inner_center_x() = (_wing_inner_ix0() + _wing_inner_ix1()) / 2;
function _wing_inner_center_y() = (_wing_inner_iy0() + _wing_inner_iy1()) / 2;
function _wing_inner_x() = _wing_inner_ix1() - _wing_inner_ix0();
function _wing_inner_y() = _wing_inner_iy1() - _wing_inner_iy0();
function _wing_vault_radius() = wing_vault_radius > 0 ? wing_vault_radius : _wing_inner_x() / 2;
function _wing_vault_rise() = _wing_vault_radius() - sqrt(
  _wing_vault_radius() * _wing_vault_radius() - (_wing_inner_x() / 2) * (_wing_inner_x() / 2)
);
function _wing_vault_center_z() = wing_z - wall - _wing_vault_radius();
function _wing_vault_spring_z() = wing_z - wall - _wing_vault_rise();
function _roof_run_x_left() = _void_x0() - _tower_inner_ix0();
function _roof_run_x_right() = _tower_inner_ix1() - _void_x1();
function _roof_run_y_front() = _void_y0() - _tower_inner_iy0();
function _roof_run_y_back() = _tower_inner_iy1() - _void_y1();
function _roof_full_drop() = max(max(_roof_run_x_left(), _roof_run_x_right()),
  max(_roof_run_y_front(), _roof_run_y_back()));
function _roof_bevel_drop() = tower_inner_roof_bevel > 0 ? tower_inner_roof_bevel : _roof_full_drop();
function _cage_window_nominal_y0() = void_center_y - cable_window_y / 2;
function _cage_window_nominal_y1() = void_center_y + cable_window_y / 2;
function _cage_window_y0() = _cage_window_nominal_y0();
function _cage_window_y1() = _cage_window_nominal_y1();
function _cage_window_span_y() = _cage_window_y1() - _cage_window_y0();
function _cage_bump_strip_y0() = wing_attach_side > 0 ? _cage_window_nominal_y1() : _void_y0();
function _cage_bump_strip_y1() = wing_attach_side > 0 ? _void_y1() : _cage_window_nominal_y0();
function _cage_bump_strip_span_y() = _cage_bump_strip_y1() - _cage_bump_strip_y0();
// Wing-roof insert geometry:
// - cap plate seats on the wing top rim without overhanging the tower-side edge,
// - inset lips/tabs below the plate retain inside the inner opening,
// - fan-side short edge stays lip-free.
function _wing_insert_aperture_y0() = wing_attach_side > 0
  ? max(_wing_inner_iy0(), _tower_y1())
  : _wing_inner_iy0();
function _wing_insert_aperture_y1() = wing_attach_side > 0
  ? _wing_inner_iy1()
  : min(_wing_inner_iy1(), _tower_y0());
function _wing_insert_aperture_local_y0() = _wing_insert_aperture_y0() - _wing_inner_center_y();
function _wing_insert_aperture_local_y1() = _wing_insert_aperture_y1() - _wing_inner_center_y();
function _wing_insert_plug_x() = _wing_inner_x() - 2 * roof_insert_clearance;
function _wing_insert_plug_y0() = _wing_insert_aperture_local_y0() + roof_insert_clearance;
function _wing_insert_plug_y1() = _wing_insert_aperture_local_y1() - roof_insert_clearance;
function _wing_insert_plug_y() = _wing_insert_plug_y1() - _wing_insert_plug_y0();
function _wing_insert_tower_lip_outer_y() = wing_attach_side > 0
  ? (_wing_insert_plug_y0() + roof_insert_lip_inset)
  : (_wing_insert_plug_y1() - roof_insert_lip_inset);
function _wing_insert_cap_tower_edge_y() = wing_attach_side > 0
  ? (_wing_insert_aperture_local_y0() + roof_insert_tower_backoff)
  : (_wing_insert_aperture_local_y1() - roof_insert_tower_backoff);
function _wing_insert_cap_x() = _wing_inner_x() + 2 * roof_insert_cap_overhang_x;
function _wing_insert_cap_y0() = wing_attach_side > 0
  ? _wing_insert_cap_tower_edge_y()
  : (_wing_insert_aperture_local_y0() - roof_insert_cap_overhang_fan_y);
function _wing_insert_cap_y1() = wing_attach_side > 0
  ? (_wing_insert_aperture_local_y1() + roof_insert_cap_overhang_fan_y)
  : _wing_insert_cap_tower_edge_y();
function _wing_insert_cap_y() = _wing_insert_cap_y1() - _wing_insert_cap_y0();
function _wing_insert_lip_span_x() = _wing_insert_plug_x() - 2 * roof_insert_lip_inset;
function _wing_insert_lip_span_y() = _wing_insert_plug_y() - 2 * roof_insert_lip_inset;
function _split_lower_piece_h() = split_z;
function _split_upper_piece_h() = _overall_height() - split_z;
function _overall_height() = max(tower_z, wing_z);
function _void_enclosed_height() = tower_z - support_z;
function _tower_x1() = -_tower_x0();
function _tower_y1() = -_tower_y0();
function _tower_back_y() = wing_attach_side > 0 ? _tower_y1() : _tower_y0();
function _tower_front_y() = wing_attach_side > 0 ? _tower_y0() : _tower_y1();
function _tier_front_limit_y(frac_center_to_front) = _tower_front_y() * frac_center_to_front;
function _tier_y0(frac_center_to_front) = min(_tower_back_y(), _tier_front_limit_y(frac_center_to_front));
function _tier_y_span(frac_center_to_front) = abs(_tower_back_y() - _tier_front_limit_y(frac_center_to_front));
function _top_tier_z_top() = tower_z - side_top_tier_top_gap;
function _front_setback_y0(ext) = wing_attach_side > 0 ? (_tower_front_y() - ext) : _tower_front_y();
function _front_center_x0() = _tower_x0() + tower_x * front_center_x_start_frac;
function _front_center_span_x() = tower_x * (front_center_x_end_frac - front_center_x_start_frac);
function _side_ext_max() = side_setback_enable == 1 ? side_setback_step : 0;
function _front_primary_ext_max() = front_setback_enable == 1 ? 4 * front_setback_step : 0;
function _front_center_ext_max() = front_center_setback_enable == 1
  ? (4 * front_center_setback_step + front_center_extra_protrusion)
  : 0;
function _front_ext_max() = max(_front_primary_ext_max(), _front_center_ext_max());
function _front_extreme_y() = _tower_front_y() + (wing_attach_side > 0 ? -_front_ext_max() : _front_ext_max());
function _model_min_x() = min(_wing_x0(), _tower_x0() - _side_ext_max());
function _model_max_x() = max(_wing_x1(), _tower_x1() + _side_ext_max());
function _model_min_y() = min(min(_tower_y0(), _wing_y0()), min(_wing_y1(), _front_extreme_y()));
function _model_max_y() = max(max(_tower_y1(), _wing_y0()), max(_wing_y1(), _front_extreme_y()));
function _split_clip_margin() = 2.0;
function _split_clip_x0() = _model_min_x() - _split_clip_margin();
function _split_clip_y0() = _model_min_y() - _split_clip_margin();
function _split_clip_x_span() = (_model_max_x() - _model_min_x()) + 2 * _split_clip_margin();
function _split_clip_y_span() = (_model_max_y() - _model_min_y()) + 2 * _split_clip_margin();
function _split_eps() = 0.02;

module _side_setback_segment(side, z0, z1, ext, y0 = _tower_y0(), y_span = tower_y) {
  if (z1 > z0 && ext > 0 && y_span > 0) {
    x0 = side < 0 ? (_tower_x0() - ext) : _tower_x1();
    translate([x0, y0, z0])
      cube([ext, y_span, z1 - z0], center = false);
  }
}

module _front_setback_segment(z0, z1, ext, x0 = _tower_x0(), span_x = tower_x) {
  if (z1 > z0 && ext > 0 && span_x > 0) {
    translate([x0, _front_setback_y0(ext), z0])
      cube([span_x, ext, z1 - z0], center = false);
  }
}

module _assert_dims() {
  assert(wall > 0, "wall must be > 0");
  assert(floor > 0, "floor must be > 0");
  assert(debug_open_bottom == 0 || debug_open_bottom == 1,
    "debug_open_bottom must be 0 or 1");
  assert(tower_x > 0 && tower_y > 0 && tower_z > 0, "tower dims must be > 0");
  assert(base_z > 0 && base_z < tower_z, "base_z must be > 0 and < tower_z");
  assert(overall_height_max > 0, "overall_height_max must be > 0");
  assert(max(_split_lower_piece_h(), _split_upper_piece_h()) <= overall_height_max,
    "split-piece height exceeds overall_height_max");
  assert(tower_inner_roof_bevel >= 0, "tower_inner_roof_bevel must be >= 0");
  assert(wing_vault_radius >= 0, "wing_vault_radius must be >= 0");
  assert(_roof_run_x_left() > 0 && _roof_run_x_right() > 0 &&
      _roof_run_y_front() > 0 && _roof_run_y_back() > 0,
    "void must stay inset from tower interior walls for full roof bevel");
  assert(abs(_roof_bevel_drop() - _roof_full_drop()) < 0.001,
    "tower_inner_roof_bevel must be 0 (auto) or exactly full roof drop");
  assert(base_z - _roof_bevel_drop() > floor,
    "roof bevel drop reaches below floor; reduce drop or raise base_z");
  assert(_wing_inner_x() > 0 && _wing_inner_y() > 0,
    "wing cavity must have positive X/Y spans");
  assert(_wing_vault_radius() >= _wing_inner_x() / 2,
    "wing_vault_radius must be >= half wing inner width");
  assert(_wing_vault_rise() > 0,
    "wing vault rise must be positive");
  assert(_wing_vault_spring_z() > floor,
    "wing vault springline reaches below floor; reduce radius or raise wing_z");
  assert(roof_insert_clearance >= 0,
    "roof_insert_clearance must be >= 0");
  assert(roof_insert_cap_overhang_x >= 0,
    "roof_insert_cap_overhang_x must be >= 0");
  assert(roof_insert_cap_overhang_fan_y >= 0,
    "roof_insert_cap_overhang_fan_y must be >= 0");
  assert(roof_insert_tower_backoff >= 0,
    "roof_insert_tower_backoff must be >= 0");
  assert(_wing_insert_cap_x() > 0 && _wing_insert_cap_y() > 0,
    "roof insert cap XY spans must be > 0");
  assert(_wing_insert_plug_x() > 2 * roof_insert_lip_t,
    "roof insert plug X span too small for lip thickness/clearance");
  assert(_wing_insert_plug_y() > 2 * roof_insert_lip_t,
    "roof insert plug Y span too small for lip thickness/clearance");
  assert(roof_insert_plate_h > 0,
    "roof_insert_plate_h must be > 0");
  assert(roof_insert_lip_t > 0,
    "roof_insert_lip_t must be > 0");
  assert(roof_insert_lip_h > 0,
    "roof_insert_lip_h must be > 0");
  assert(roof_insert_lip_inset >= 0,
    "roof_insert_lip_inset must be >= 0");
  assert(_wing_insert_lip_span_x() > 2 * roof_insert_lip_t,
    "roof insert lip inset too large for X span");
  assert(_wing_insert_lip_span_y() > 2 * roof_insert_lip_t,
    "roof insert lip inset too large for Y span");
  if (wing_attach_side > 0) {
    assert(_wing_insert_cap_y0() >= _wing_insert_aperture_local_y0(),
      "tower-side cap edge overhangs past top aperture boundary (Y- direction)");
  } else {
    assert(_wing_insert_cap_y1() <= _wing_insert_aperture_local_y1(),
      "tower-side cap edge overhangs past top aperture boundary (Y+ direction)");
  }
  assert(wing_x > 0 && wing_y > 0 && wing_z > 0, "wing dims must be > 0");
  assert(bump_margin >= 0, "bump_margin must be >= 0");
  assert(wing_overlap_y >= 0 && wing_overlap_y < tower_y, "wing_overlap_y out of range");
  assert(wing_attach_side == 1 || wing_attach_side == -1,
    "wing_attach_side must be 1 or -1");
  assert(side_setback_enable == 0 || side_setback_enable == 1,
    "side_setback_enable must be 0 or 1");
  assert(side_setback_step >= 0, "side_setback_step must be >= 0");
  assert(front_setback_enable == 0 || front_setback_enable == 1,
    "front_setback_enable must be 0 or 1");
  assert(front_setback_step >= 0, "front_setback_step must be >= 0");
  assert(front_center_setback_enable == 0 || front_center_setback_enable == 1,
    "front_center_setback_enable must be 0 or 1");
  assert(front_center_setback_step >= 0, "front_center_setback_step must be >= 0");
  assert(front_center_extra_protrusion >= 0,
    "front_center_extra_protrusion must be >= 0");
  assert(front_center_x_start_frac >= 0 && front_center_x_start_frac < 1,
    "front_center_x_start_frac must be in [0, 1)");
  assert(front_center_x_end_frac > front_center_x_start_frac && front_center_x_end_frac <= 1,
    "front_center_x_end_frac must be > start frac and <= 1");
  assert(_front_center_span_x() > 0,
    "front center tier band must have positive X span");
  assert(front_center_tier_height_boost >= 0,
    "front_center_tier_height_boost must be >= 0");
  assert(_top_tier_z_top() + front_center_tier_height_boost <= tower_z,
    "front center top-tier boost exceeds tower top");
  assert(side_top_tier_top_gap >= 0 && side_top_tier_top_gap < tower_z,
    "side_top_tier_top_gap must be >= 0 and < tower_z");
  assert(_top_tier_z_top() > 0,
    "top tier top height must be above z=0");
  assert(side_tier2_center_to_front_frac >= 0 && side_tier2_center_to_front_frac <= 1,
    "side_tier2_center_to_front_frac must be in [0, 1]");
  assert(side_tier3_center_to_front_frac >= 0 && side_tier3_center_to_front_frac <= 1,
    "side_tier3_center_to_front_frac must be in [0, 1]");
  assert(side_tier4_center_to_front_frac >= 0 && side_tier4_center_to_front_frac <= 1,
    "side_tier4_center_to_front_frac must be in [0, 1]");
  assert(side_tier2_center_to_front_frac <= side_tier3_center_to_front_frac &&
      side_tier3_center_to_front_frac <= side_tier4_center_to_front_frac,
    "tier front-reach fractions must be non-decreasing (tier2 <= tier3 <= tier4)");
  assert(side_left_tier0_z >= 0 && side_left_tier1_z > side_left_tier0_z &&
      side_left_tier2_z > side_left_tier1_z && side_left_tier3_z > side_left_tier2_z &&
      _top_tier_z_top() > side_left_tier3_z,
    "left side tier heights must ascend and stay below top tier cap");
  assert(abs(side_right_tier0_z - side_left_tier0_z) < 0.001 &&
      abs(side_right_tier1_z - side_left_tier1_z) < 0.001 &&
      abs(side_right_tier2_z - side_left_tier2_z) < 0.001 &&
      abs(side_right_tier3_z - side_left_tier3_z) < 0.001,
    "left/right tier Z breakpoints must match for mirrored side geometry");
  assert(abs(side_left_tier0_z) < 0.001 && abs(side_right_tier0_z) < 0.001,
    "tier bases must be at floor z=0");
  assert(_wing_plenum_top_z() > floor, "wing plenum top must be above floor");
  assert(_wing_plenum_top_z() > floor + wall,
    "wing plenum too short to keep a top wall");
  assert(support_z >= 70, "support_z must be >= 70");
  assert(support_z < tower_z, "support_z must be < tower_z");
  assert(split_z > 0 && split_z < _overall_height(),
    "split_z must be > 0 and within model height");
  assert(_split_eps() >= 0 && split_z - _split_eps() > 0,
    "split epsilon must keep lower split plane above z=0");
  assert(split_z + _split_eps() < _overall_height(),
    "split epsilon must keep upper split plane below overall height");
  assert(tower_top_lip_h >= 0 && tower_top_lip_h < tower_z - support_z,
    "tower_top_lip_h must be >= 0 and less than void height");
  assert(_void_enclosed_height() > 0,
    "void enclosed height above support must be > 0");
  assert(_void_enclosed_height() >= phone_h_max + top_clearance_min,
    "void enclosed height must fit tallest phone + top_clearance_min");

  // Requested floorplan constraint: minimum width should not drop below fan width.
  assert(tower_x >= fan_frame, "tower_x must be >= fan_frame");
  assert(wing_y >= fan_frame, "wing_y must be >= fan_frame");

  // Rotated void fit checks.
  assert(void_x >= phone_t_max + 2 * face_gap_min,
    "void_x too small for phone thickness + face gaps");
  assert(void_y >= phone_w_max + 2 * side_gap_min,
    "void_y too small for phone width + side gaps");

  assert(void_x + 2 * wall <= tower_x, "void_x + walls must fit tower_x");
  assert(void_y + 2 * wall <= tower_y, "void_y + walls must fit tower_y");
  assert(_void_x0() >= _tower_x0() + wall && _void_x1() <= -_tower_x0() - wall,
    "void exceeds tower X wall margin");
  assert(_void_y0() >= _tower_y0() + wall && _void_y1() <= -_tower_y0() - wall,
    "void exceeds tower Y wall margin");

  assert(rail_width_x > 0 && rail_width_x <= void_x / 2,
    "rail_width_x must be > 0 and <= half void_x");
  assert(rail_protrusion_y > 0 && rail_protrusion_y <= void_y / 2,
    "rail_protrusion_y must be > 0 and <= half void_y");
  assert(rail_side_protrusion_x > 0 && rail_side_protrusion_x <= void_x / 2,
    "rail_side_protrusion_x must be > 0 and <= half void_x");
  assert(rail_side_span_y > 0 && rail_side_span_y <= void_y,
    "rail_side_span_y must be > 0 and <= void_y");

  // Keep at least the requested phone-to-rail slide margin.
  assert((void_y - 2 * rail_protrusion_y - phone_w_max) / 2 >= rail_phone_margin_min,
    "front/back rail protrusion leaves too little width margin to phone");
  assert((void_x - 2 * rail_side_protrusion_x - phone_t_max) / 2 >= rail_phone_margin_min,
    "wide-side rail protrusion leaves too little thickness margin to phone");
  assert(_top_open_x() > 0 && _top_open_y() > 0,
    "top opening must remain positive in X/Y");
  assert(_top_open_x() >= phone_t_max + 2 * rail_phone_margin_min,
    "tower top opening too tight in thickness axis");
  assert(_top_open_y() >= phone_w_max + 2 * rail_phone_margin_min,
    "tower top opening too tight in width axis");

  assert(cage_bar_h > 0, "cage_bar_h must be > 0");
  assert(cable_window_x > 0 && cable_window_x < void_x,
    "cable_window_x must be > 0 and < void_x");
  assert(cable_window_y > 0 && cable_window_y < void_y,
    "cable_window_y must be > 0 and < void_y");
  assert(_cage_window_span_y() > 0,
    "effective cage cable-window Y span must be > 0");
  assert(_cage_window_y0() >= _void_y0() && _cage_window_y1() <= _void_y1(),
    "effective cage cable-window Y extents must stay within void bounds");
  assert(_cage_bump_strip_span_y() > 0,
    "effective bump-side strip Y span must be > 0");
  assert(fan_hole_spacing > 0 && fan_hole_d > 0, "fan hole values must be > 0");
  assert(fan_square_opening > 0 && fan_square_opening <= fan_frame + 2,
    "fan_square_opening must be positive and near fan frame size");
  assert(fan_intake_d > 0 && fan_intake_d < fan_square_opening,
    "fan_intake_d must be > 0 and < fan_square_opening");
  assert(fan_center_x > _wing_x0() + wall && fan_center_x < _wing_x1() - wall,
    "fan_center_x must stay within wing X wall margins");
  assert(fan_center_z > wall && fan_center_z < wing_z - wall,
    "fan_center_z must stay within bump-out wall margins");
  assert(rear_cable_slot_center_x > _wing_x0() + wall && rear_cable_slot_center_x < _wing_x1() - wall,
    "rear_cable_slot_center_x must stay within wing X wall margins");
  assert(rear_cable_slot_center_z - rear_cable_slot_h / 2 >= 0 &&
      rear_cable_slot_center_z + rear_cable_slot_h / 2 <= wing_z,
    "rear cable slot must stay within bump-out height");
  assert(_wing_link_x1() > _wing_link_x0(),
    "wing/tower overlap too small for airflow link");
}

module old_rca_building_outer_mass() {
  _assert_dims();
  union() {
    // Tall tower section.
    translate([_tower_x0(), _tower_y0(), 0])
      cube([tower_x, tower_y, tower_z], center = false);

    if (side_setback_enable == 1 && side_setback_step > 0) {
      // Tiered extrusions on the wide tower faces:
      // uniform extension by side_setback_step on all four tiers.
      // Tier depth along Y is measured from the back wall toward the front:
      // top=0%, tier2=25%, tier3=50%, tier4=75% from center to front.
      top_tier_y0 = _tier_y0(0.0);
      top_tier_y_span = _tier_y_span(0.0);
      tier2_y0 = _tier_y0(side_tier2_center_to_front_frac);
      tier2_y_span = _tier_y_span(side_tier2_center_to_front_frac);
      tier3_y0 = _tier_y0(side_tier3_center_to_front_frac);
      tier3_y_span = _tier_y_span(side_tier3_center_to_front_frac);
      tier4_y0 = _tier_y0(side_tier4_center_to_front_frac);
      tier4_y_span = _tier_y_span(side_tier4_center_to_front_frac);
      z_top = _top_tier_z_top();

      // Left wide face (X-)
      _side_setback_segment(-1, side_left_tier0_z, z_top, side_setback_step,
        top_tier_y0, top_tier_y_span);
      _side_setback_segment(-1, side_left_tier0_z, side_left_tier3_z, side_setback_step,
        tier2_y0, tier2_y_span);
      _side_setback_segment(-1, side_left_tier0_z, side_left_tier2_z, side_setback_step,
        tier3_y0, tier3_y_span);
      _side_setback_segment(-1, side_left_tier0_z, side_left_tier1_z, side_setback_step,
        tier4_y0, tier4_y_span);

      // Right wide face (X+) mirrored to left side Z breaks.
      _side_setback_segment(1, side_left_tier0_z, z_top, side_setback_step,
        top_tier_y0, top_tier_y_span);
      _side_setback_segment(1, side_left_tier0_z, side_left_tier3_z, side_setback_step,
        tier2_y0, tier2_y_span);
      _side_setback_segment(1, side_left_tier0_z, side_left_tier2_z, side_setback_step,
        tier3_y0, tier3_y_span);
      _side_setback_segment(1, side_left_tier0_z, side_left_tier1_z, side_setback_step,
        tier4_y0, tier4_y_span);
    }

    if (front_setback_enable == 1 && front_setback_step > 0) {
      // Front-face tiers on the skinny front wall:
      // same Z bands as side tiers, cumulative protrusion by front_setback_step.
      z_top = _top_tier_z_top();
      _front_setback_segment(side_left_tier0_z, z_top, front_setback_step);
      _front_setback_segment(side_left_tier0_z, side_left_tier3_z, 2 * front_setback_step);
      _front_setback_segment(side_left_tier0_z, side_left_tier2_z, 3 * front_setback_step);
      _front_setback_segment(side_left_tier0_z, side_left_tier1_z, 4 * front_setback_step);
    }

    if (front_center_setback_enable == 1 && front_center_setback_step > 0) {
      // Additional centered front tiers (middle third of front width),
      // with tier tops raised slightly above the primary front-tier tops
      // and an additional protrusion beyond the primary front tiers.
      x0 = _front_center_x0();
      span_x = _front_center_span_x();
      z_top = _top_tier_z_top() + front_center_tier_height_boost;
      ext1 = front_center_setback_step + front_center_extra_protrusion;
      ext2 = 2 * front_center_setback_step + front_center_extra_protrusion;
      ext3 = 3 * front_center_setback_step + front_center_extra_protrusion;
      ext4 = 4 * front_center_setback_step + front_center_extra_protrusion;
      _front_setback_segment(side_left_tier0_z, z_top, ext1, x0, span_x);
      _front_setback_segment(side_left_tier0_z,
        side_left_tier3_z + front_center_tier_height_boost,
        ext2, x0, span_x);
      _front_setback_segment(side_left_tier0_z,
        side_left_tier2_z + front_center_tier_height_boost,
        ext3, x0, span_x);
      _front_setback_segment(side_left_tier0_z,
        side_left_tier1_z + front_center_tier_height_boost,
        ext4, x0, span_x);
    }

    // Low rear-side wing to form a simple L plan.
    translate([_wing_x0(), _wing_y0(), 0])
      cube([wing_x, wing_y, wing_z], center = false);
  }
}

module _phone_void_cut() {
  // Full-height phone void through-cut to eliminate partial top-lip overhang.
  through_void_h = tower_z - support_z + 0.52;
  translate([_void_x0(), _void_y0(), support_z])
    cube([void_x, void_y, through_void_h], center = false);
}

module _tower_base_cavity_cut() {
  // Open lower tower interior so airflow can rise around phone void.
  cavity_z0 = debug_open_bottom ? -0.01 : floor;
  cavity_h = base_z - _roof_bevel_drop() - cavity_z0 + 0.01;
  translate([_tower_x0() + wall, _tower_y0() + wall, cavity_z0])
    cube([tower_x - 2 * wall, tower_y - 2 * wall, cavity_h], center = false);
}

module _tower_inner_roof_bevel_cuts() {
  // Full 45 degree inverse bevel from the void opening to all inner tower walls.
  // This removes the flat chamber ceiling that otherwise needs internal supports.
  drop = _roof_bevel_drop();
  z_top = base_z - 0.01;
  z_bot = base_z - drop - 0.01;
  top_t = 0.02;

  hull() {
    // Lower profile at full inner-wall footprint of the chamber.
    translate([_tower_inner_ix0(), _tower_inner_iy0(), z_bot])
      cube([tower_x - 2 * wall, tower_y - 2 * wall, top_t], center = false);

    // Upper profile at chamber roof opening around the phone void.
    translate([_void_x0(), _void_y0(), z_top])
      cube([void_x, void_y, top_t], center = false);
  }
}

module _wing_cavity_cut() {
  // Open interior of the L-base wing (fan plenum).
  cavity_z0 = debug_open_bottom ? -0.01 : floor;
  // Through-cut to top: roof is provided by separate insert piece.
  cavity_h = wing_z - cavity_z0 + 0.02;
  translate([_wing_x0() + wall, _wing_y0() + wall, cavity_z0])
    cube([wing_x - 2 * wall, wing_y - 2 * wall, cavity_h], center = false);
}

module _wing_to_tower_plenum_link_cut() {
  // Ensure base wing cavity is explicitly connected to tower lower cavity.
  // Match the open-top wing cavity height.
  link_z0 = debug_open_bottom ? -0.01 : floor;
  link_h = wing_z - link_z0 + 0.02;
  link_y0 = wing_attach_side > 0
    ? (tower_y / 2 - wall - 0.01)
    : (-tower_y / 2 - 0.01);
  translate([_wing_link_x0(), link_y0, link_z0])
    cube([_wing_link_x1() - _wing_link_x0(), wall + 0.02, link_h], center = false);
}

module _fan_interface_cuts() {
  end_y = wing_attach_side > 0 ? _wing_y1() : _wing_y0();
  face_y0 = wing_attach_side > 0 ? (end_y - wall - 0.01) : (end_y - 0.01);

  // Main fan opening on the outer end face of the Y-side bump-out.
  translate([
    fan_center_x,
    face_y0,
    fan_center_z
  ])
    rotate([-90, 0, 0])
      cylinder(d = fan_intake_d, h = wall + 0.02, center = false, $fn = 96);

  // 32 mm hole spacing pattern.
  for (sx = [-1, 1]) {
    for (sz = [-1, 1]) {
      translate([
        fan_center_x + sx * fan_hole_spacing / 2,
        face_y0,
        fan_center_z + sz * fan_hole_spacing / 2
      ])
        rotate([-90, 0, 0])
          cylinder(d = fan_hole_d, h = wall + 0.02, center = false, $fn = 36);
    }
  }

  // USB cable exit below fan on the same end face.
  translate([
    rear_cable_slot_center_x - rear_cable_slot_w / 2,
    face_y0,
    rear_cable_slot_center_z - rear_cable_slot_h / 2
  ])
    cube([rear_cable_slot_w, wall + 0.02, rear_cable_slot_h], center = false);
}

module old_rca_building_negative_cuts() {
  _phone_void_cut();
  _tower_base_cavity_cut();
  _tower_inner_roof_bevel_cuts();
  _wing_cavity_cut();
  _wing_to_tower_plenum_link_cut();
  _fan_interface_cuts();
}

module _rails() {
  // Rails start at the phone-void floor and do not extend below it.
  rail_z0 = support_z;
  rail_h = tower_z - rail_z0 + 0.5;
  left_rail_x = _void_x0() + rail_inset_from_x_ends;
  right_rail_x = _void_x1() - rail_inset_from_x_ends - rail_width_x;
  front_wall_y = _void_y0();
  back_wall_y = _void_y1() - rail_protrusion_y;
  side_rail_y0 = void_center_y - rail_side_span_y / 2;
  left_wall_x = _void_x0();
  right_wall_x = _void_x1() - rail_side_protrusion_x;

  // Front wall pair.
  translate([left_rail_x, front_wall_y, rail_z0])
    cube([rail_width_x, rail_protrusion_y, rail_h], center = false);
  translate([right_rail_x, front_wall_y, rail_z0])
    cube([rail_width_x, rail_protrusion_y, rail_h], center = false);

  // Back wall pair.
  translate([left_rail_x, back_wall_y, rail_z0])
    cube([rail_width_x, rail_protrusion_y, rail_h], center = false);
  translate([right_rail_x, back_wall_y, rail_z0])
    cube([rail_width_x, rail_protrusion_y, rail_h], center = false);

  // One rail on each wide-side wall.
  translate([left_wall_x, side_rail_y0, rail_z0])
    cube([rail_side_protrusion_x, rail_side_span_y, rail_h], center = false);
  translate([right_wall_x, side_rail_y0, rail_z0])
    cube([rail_side_protrusion_x, rail_side_span_y, rail_h], center = false);
}

module _bottom_cage() {
  // Perimeter support ring with center opening for cable bend.
  // Uses a nominal centered cable window; no wedge-derived endpoint geometry.
  support_z0 = support_z - cage_bar_h;
  difference() {
    translate([_void_x0(), _void_y0(), support_z0])
      cube([void_x, void_y, cage_bar_h], center = false);

    translate([
      void_center_x - cable_window_x / 2,
      _cage_window_y0(),
      support_z0 - 0.01
    ])
      cube([cable_window_x, _cage_window_span_y(), cage_bar_h + 0.02], center = false);
  }
}

module _bottom_cage_floor_extensions() {
  // Extend the remaining unsupported catch-platform underside down to the floor.
  // Keep the bump-side strip open for intake airflow from the fan plenum.
  support_z0 = support_z - cage_bar_h;
  z0 = floor;
  h = support_z0 - z0 + 0.01;

  difference() {
    // Full prism under the catch platform.
    translate([_void_x0(), _void_y0(), z0])
      cube([void_x, void_y, h], center = false);

    // Preserve the cable bend opening through this support extension.
    translate([
      void_center_x - cable_window_x / 2,
      _cage_window_y0(),
      z0 - 0.01
    ])
      cube([cable_window_x, _cage_window_span_y(), h + 0.02], center = false);

    // Remove bump-side strip volume to preserve a more direct airflow path.
    translate([_void_x0(), _cage_bump_strip_y0(), z0 - 0.01])
      cube([void_x, _cage_bump_strip_span_y(), h + 0.02], center = false);
  }
}

module old_rca_building_internal_supports() {
  _rails();
  _bottom_cage();
  _bottom_cage_floor_extensions();
}

module old_rca_building_model() {
  _assert_dims();
  union() {
    difference() {
      old_rca_building_outer_mass();
      old_rca_building_negative_cuts();
    }
    old_rca_building_internal_supports();
  }
}

module old_rca_building_split_lower() {
  _assert_dims();
  intersection() {
    old_rca_building_model();
    // Keep geometry below the split plane with a tight XY clip box
    // so OpenSCAD view framing remains usable.
    // Keep the lower export strictly below split_z to avoid coplanar artifacts.
    // Use XY margin only; do not add positive Z overlap across the split.
    translate([_split_clip_x0(), _split_clip_y0(), -_split_clip_margin()])
      cube([
        _split_clip_x_span(),
        _split_clip_y_span(),
        (split_z - _split_eps()) + _split_clip_margin()
      ], center = false);
  }
}

module old_rca_building_split_upper() {
  _assert_dims();
  union() {
    intersection() {
      old_rca_building_model();
      // Keep geometry at and above the split plane with a tight XY clip box
      // so OpenSCAD view framing remains usable.
      // Keep the upper export strictly above split_z to avoid coplanar artifacts
      // and thin residual slivers at the phone-floor split.
      // Use XY margin only; do not pull the clip below split_z.
      translate([_split_clip_x0(), _split_clip_y0(), split_z + _split_eps()])
        cube([
          _split_clip_x_span(),
          _split_clip_y_span(),
          _overall_height() - (split_z + _split_eps()) + _split_clip_margin()
        ], center = false);
    }

    // Upper-part-only ties: connect the phone-base ring ends to front/back
    // inner tower walls without changing the lower split artifact.
    tie_z0 = max(support_z - cage_bar_h, split_z + _split_eps());
    tie_h = support_z - tie_z0;
    if (tie_h > 0) {
      front_tie_y = _void_y0() - _tower_inner_iy0();
      back_tie_y = _tower_inner_iy1() - _void_y1();

      if (front_tie_y > 0) {
        translate([_void_x0(), _tower_inner_iy0(), tie_z0])
          cube([void_x, front_tie_y, tie_h], center = false);
      }
      if (back_tie_y > 0) {
        translate([_void_x0(), _void_y1(), tie_z0])
          cube([void_x, back_tie_y, tie_h], center = false);
      }
    }
  }
}

module old_rca_building_wing_roof_insert() {
  _assert_dims();

  cap_x = _wing_insert_cap_x();
  cap_y = _wing_insert_cap_y();
  cap_y0 = _wing_insert_cap_y0();
  plug_x = _wing_insert_plug_x();
  plug_y = _wing_insert_plug_y();
  plug_y0 = _wing_insert_plug_y0();
  plug_y1 = _wing_insert_plug_y1();
  ph = roof_insert_plate_h;
  lt = roof_insert_lip_t;
  lh = roof_insert_lip_h;
  li = roof_insert_lip_inset;
  lip_x_span = _wing_insert_lip_span_x();
  lip_y_span = _wing_insert_lip_span_y();
  plug_x0 = -plug_x / 2;

  // Print orientation: flat panel on bed, lips upward.
  // In assembly, flip and press-fit into the wing opening.
  union() {
    // Cap plate seats on the top rim; tower-side edge is flush (no overhang)
    // so it can install next to the tower wall without interference.
    translate([-cap_x / 2, cap_y0, 0])
      cube([cap_x, cap_y, ph], center = false);

    // X-side retaining lips inside opening (inset from lip_inset).
    translate([plug_x0 + li, plug_y0 + li, ph])
      cube([lt, lip_y_span, lh], center = false);
    translate([plug_x0 + plug_x - li - lt, plug_y0 + li, ph])
      cube([lt, lip_y_span, lh], center = false);

    // Tower-side short-edge lip only; fan-side edge remains lip-free.
    if (wing_attach_side > 0) {
      // Fan is +Y, so place short-edge lip at -Y (tower side).
      translate([plug_x0 + li, plug_y0 + li, ph])
        cube([lip_x_span, lt, lh], center = false);
    } else {
      // Fan is -Y, so place short-edge lip at +Y (tower side).
      translate([plug_x0 + li, plug_y1 - li - lt, ph])
        cube([lip_x_span, lt, lh], center = false);
    }
  }
}
