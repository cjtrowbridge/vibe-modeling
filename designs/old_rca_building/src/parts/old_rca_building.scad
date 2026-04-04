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
function _cage_bump_bevel_top_z() = support_z - cage_bar_h;
function _cage_bump_bevel_inner_y() = void_center_y + wing_attach_side * cable_window_y / 2;
function _cage_bump_bevel_outer_y() = wing_attach_side > 0 ? _tower_inner_iy1() : _tower_inner_iy0();
function _cage_bump_bevel_span_y() = abs(_cage_bump_bevel_outer_y() - _cage_bump_bevel_inner_y());
function _cage_bump_bevel_wall_end_z() = _wing_plenum_top_z() - wall + 0.01;
function _cage_bump_bevel_max_run() = max(0, _cage_bump_bevel_top_z() - _cage_bump_bevel_wall_end_z());
function _cage_bump_bevel_reach_y() = min(_cage_bump_bevel_span_y(), _cage_bump_bevel_max_run());
function _cage_bump_bevel_top_inner_reached_y() =
  _cage_bump_bevel_outer_y() - wing_attach_side * _cage_bump_bevel_reach_y();
function _cage_bump_bevel_bottom_z() = _cage_bump_bevel_top_z() - _cage_bump_bevel_reach_y();
function _cage_window_nominal_y0() = void_center_y - cable_window_y / 2;
function _cage_window_nominal_y1() = void_center_y + cable_window_y / 2;
function _cage_window_y0() = wing_attach_side > 0
  ? _cage_window_nominal_y0()
  : _cage_bump_bevel_top_inner_reached_y();
function _cage_window_y1() = wing_attach_side > 0
  ? _cage_bump_bevel_top_inner_reached_y()
  : _cage_window_nominal_y1();
function _cage_window_span_y() = _cage_window_y1() - _cage_window_y0();
function _cage_bump_strip_y0() = wing_attach_side > 0 ? _cage_window_y1() : _void_y0();
function _cage_bump_strip_y1() = wing_attach_side > 0 ? _void_y1() : _cage_window_y0();
function _cage_bump_strip_span_y() = _cage_bump_strip_y1() - _cage_bump_strip_y0();
function _overall_height() = max(tower_z, wing_z);
function _void_enclosed_height() = tower_z - support_z;

module _assert_dims() {
  assert(wall > 0, "wall must be > 0");
  assert(floor > 0, "floor must be > 0");
  assert(debug_open_bottom == 0 || debug_open_bottom == 1,
    "debug_open_bottom must be 0 or 1");
  assert(tower_x > 0 && tower_y > 0 && tower_z > 0, "tower dims must be > 0");
  assert(base_z > 0 && base_z < tower_z, "base_z must be > 0 and < tower_z");
  assert(overall_height_max > 0, "overall_height_max must be > 0");
  assert(_overall_height() <= overall_height_max,
    "overall model height exceeds overall_height_max");
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
  assert(wing_x > 0 && wing_y > 0 && wing_z > 0, "wing dims must be > 0");
  assert(bump_margin >= 0, "bump_margin must be >= 0");
  assert(wing_overlap_y >= 0 && wing_overlap_y < tower_y, "wing_overlap_y out of range");
  assert(wing_attach_side == 1 || wing_attach_side == -1,
    "wing_attach_side must be 1 or -1");
  assert(_wing_plenum_top_z() > floor, "wing plenum top must be above floor");
  assert(_wing_plenum_top_z() > floor + wall,
    "wing plenum too short to keep a top wall");
  assert(support_z >= 70, "support_z must be >= 70");
  assert(support_z < tower_z, "support_z must be < tower_z");
  assert(tower_top_lip_h > 0 && tower_top_lip_h < tower_z - support_z,
    "tower_top_lip_h must be > 0 and less than void height");
  assert(_void_enclosed_height() > 0,
    "void enclosed height above support must be > 0");

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
  assert(_cage_bump_bevel_wall_end_z() < _cage_bump_bevel_top_z(),
    "bump-side wall end must be below platform underside for 45 deg buttress");
  assert(_cage_bump_bevel_bottom_z() > floor,
    "bump-side 45 deg cage bevel reaches below floor; reduce span or raise support_z");

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

    // Low rear-side wing to form a simple L plan.
    translate([_wing_x0(), _wing_y0(), 0])
      cube([wing_x, wing_y, wing_z], center = false);
  }
}

module _phone_void_cut() {
  lower_void_h = tower_z - support_z - tower_top_lip_h + 0.01;

  // Main internal void up to underside of tower top lip.
  translate([_void_x0(), _void_y0(), support_z])
    cube([void_x, void_y, lower_void_h], center = false);

  // Top insertion opening through the lip; sized to preserve phone + margin.
  translate([_top_open_x0(), _top_open_y0(), tower_z - tower_top_lip_h - 0.01])
    cube([_top_open_x(), _top_open_y(), tower_top_lip_h + 0.52], center = false);
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
  cavity_h = _wing_vault_spring_z() - cavity_z0 + 0.01;
  translate([_wing_x0() + wall, _wing_y0() + wall, cavity_z0])
    cube([wing_x - 2 * wall, wing_y - 2 * wall, cavity_h], center = false);
}

module _wing_inner_roof_vault_cut() {
  // Circular barrel-vault underside for bump-out roof.
  // This supports the roof without blocking the fan airflow path.
  r = _wing_vault_radius();
  zc = _wing_vault_center_z();
  y0 = _wing_inner_iy0() - 0.01;
  h = _wing_inner_y() + 0.02;
  z0 = _wing_vault_spring_z();
  z_h = _wing_vault_rise() + 0.03;

  intersection() {
    translate([_wing_inner_center_x(), y0, zc])
      rotate([-90, 0, 0])
        cylinder(r = r, h = h, center = false, $fn = 96);

    translate([_wing_inner_ix0(), y0, z0])
      cube([_wing_inner_x(), h, z_h], center = false);
  }
}

module _wing_to_tower_plenum_link_cut() {
  // Ensure base wing cavity is explicitly connected to tower lower cavity.
  // Keep the rectangular link only up to the vault springline so the
  // half-pipe profile reaches the inner wall without a flat unsupported ledge.
  link_z0 = debug_open_bottom ? -0.01 : floor;
  link_h = _wing_vault_spring_z() - link_z0 + 0.01;
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
  _wing_inner_roof_vault_cut();
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
  // The bump-side end of the opening is extended to the bevel top endpoint.
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
  // The bump-side strip is excluded because it is already handled by the 45 deg buttress.
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

    // Remove bump-side strip volume; this side is supported by the dedicated 45 deg buttress.
    translate([_void_x0(), _cage_bump_strip_y0(), z0 - 0.01])
      cube([void_x, _cage_bump_strip_span_y(), h + 0.02], center = false);
  }
}

module _bottom_cage_bump_side_bevel() {
  // Add a single 45 deg buttress under the catch platform on the bump-out side.
  // This reaches inward as far as possible from the bump-side tower inner wall
  // without extending below the lower end of that wall.
  eps = 0.02;
  x0 = _void_x0();
  x_span = void_x;
  z_top = _cage_bump_bevel_top_z();
  y_outer = _cage_bump_bevel_outer_y();
  y_inner = _cage_bump_bevel_top_inner_reached_y();
  y_span = _cage_bump_bevel_reach_y();
  y_min = min(y_inner, y_outer);
  y_line = wing_attach_side > 0 ? (y_outer - eps) : y_outer;
  z_bot = _cage_bump_bevel_bottom_z();

  if (y_span > eps) {
    hull() {
      // Contact face under the bump-side platform strip.
      translate([x0, y_min, z_top - eps])
        cube([x_span, y_span, eps], center = false);

      // Lower outer edge at 45 deg relative to the top strip.
      translate([x0, y_line, z_bot - eps])
        cube([x_span, eps, eps], center = false);
    }
  }
}

module old_rca_building_internal_supports() {
  _rails();
  _bottom_cage();
  _bottom_cage_floor_extensions();
  _bottom_cage_bump_side_bevel();
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
