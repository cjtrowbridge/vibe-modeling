include <../lib/util.scad>;

function main_room_extra_x_safe() = max(0, main_room_extra_x);
function main_room_inner_x() = board_x + 2 * board_clearance_xy + main_room_extra_x_safe();
function drawer_outer_x() = main_room_inner_x();
function drawer_outer_y() = board_y + 2 * board_clearance_xy;
function drawer_side_wall_h() = max(floor_thickness + mount_stud_h + 1.5, floor_thickness + 4);
function drawer_divider_hole_z() = mount_stud_h + stud_to_board_standoff_z + board_thickness + divider_hole_z_from_board_top;
function divider_hole_front_extend_y_safe() = max(0, divider_hole_front_extend_y);
function divider_hole_effective_w() = divider_hole_w + divider_hole_front_extend_y_safe();
function divider_hole_effective_y_offset() = divider_hole_y_offset + divider_hole_front_extend_y_safe() / 2;
function drawer_outer_h() =
  max(
    drawer_side_wall_h(),
    (io_cutout_z0 - floor_thickness) + io_cutout_h + 1.0,
    drawer_divider_hole_z() + divider_hole_h / 2 + 1.0
  ) + max(0, drawer_end_wall_extra_h);
function board_center_x() = -(chimney_room_divider_t + chimney_room_x) / 2;
function main_room_right_x() = board_center_x() + main_room_inner_x() / 2;
function divider_center_x() = main_room_right_x() + chimney_room_divider_t / 2;
function chimney_room_center_x() = main_room_right_x() + chimney_room_divider_t + chimney_room_x / 2;
function chimney_center_x() = chimney_room_center_x() + chimney_x_offset_from_room_center;

function case_inner_x() = main_room_inner_x() + chimney_room_divider_t + chimney_room_x;
function case_inner_y() = drawer_outer_y() + 2 * drawer_slide_clearance;
function case_outer_x() = case_inner_x() + 2 * wall;
function case_outer_y() = case_inner_y() + 2 * wall;

function roof_surface_z(x, half_w, eave_h, peak_h) =
  eave_h + (peak_h - eave_h) * max(0, 1 - abs(x) / max(half_w, 0.001));

module arched_opening_2d(w, h) {
  _arch_r = w / 2;
  _rect_h = max(0.01, h - _arch_r);

  union() {
    translate([-w / 2, 0]) square([w, _rect_h], center = false);
    translate([0, _rect_h]) circle(r = _arch_r, $fn = 64);
  }
}

module arched_border_2d(w, h, border) {
  difference() {
    offset(delta = border) arched_opening_2d(w, h);
    arched_opening_2d(w, h);
  }
}

module rect_border_2d(w, h, border) {
  difference() {
    square([w + 2 * border, h + 2 * border], center = true);
    square([w, h], center = true);
  }
}

module roof_profile_2d(half_w, eave_h, peak_h) {
  polygon(points = [
    [-half_w, 0],
    [half_w, 0],
    [half_w, eave_h],
    [0, peak_h],
    [-half_w, eave_h]
  ]);
}

module cottage_pi6_plus_base() {
  _inner_x = case_inner_x();
  _inner_y = case_inner_y();
  _outer_x = case_outer_x();
  _outer_y = case_outer_y();
  _body_h = body_wall_height;
  _min_body_h = floor_thickness + mount_stud_h + stud_to_board_standoff_z + board_thickness + cooler_envelope_z + top_clearance_z;
  _inner_fit_x = case_outer_x() + 2 * roof_fit_clearance;
  _inner_fit_y = case_outer_y() + 2 * roof_fit_clearance;
  _outer_roof_x = _inner_fit_x + 2 * roof_wall + 2 * roof_overhang;
  _half_outer = _outer_roof_x / 2;
  _half_inner = max(0.5, _half_outer - roof_wall);
  _eave_inner = max(0.5, roof_eave_h - roof_wall);
  // Keep positive ridge thickness; previous formula could collapse to ~0 at the peak.
  _peak_inner = max(_eave_inner + 0.8, roof_peak_h - 2 * roof_wall);
  _board_z0 = floor_thickness + mount_stud_h + stud_to_board_standoff_z;
  _board_top_z = _board_z0 + board_thickness;
  _board_cx = board_center_x();
  _divider_cx = divider_center_x();
  _divider_x0 = _divider_cx - chimney_room_divider_t / 2;
  _divider_x1 = _divider_cx + chimney_room_divider_t / 2;
  _divider_top_z_x0 = _body_h + roof_surface_z(_divider_x0, _half_inner, _eave_inner, _peak_inner) - divider_roof_seal_gap;
  _divider_top_z_x1 = _body_h + roof_surface_z(_divider_x1, _half_inner, _eave_inner, _peak_inner) - divider_roof_seal_gap;
  _divider_top_z_min = min(_divider_top_z_x0, _divider_top_z_x1);
  _divider_taper_eps = min(0.08, chimney_room_divider_t / 4);
  _divider_hole_z = _board_top_z + divider_hole_z_from_board_top;
  _divider_hole_w_eff = divider_hole_effective_w();
  _divider_hole_y_eff = divider_hole_effective_y_offset();
  _porch_top_z = porch_deck_z + porch_deck_t;
  _porch_post_y0 = _outer_y / 2 + porch_d - porch_post_d;
  _porch_roof_top_back_z = _body_h;
  _porch_roof_drop = tan(porch_roof_angle_deg) * porch_d;
  _porch_roof_top_front_z = _porch_roof_top_back_z - _porch_roof_drop;
  _porch_roof_bottom_front_z = _porch_roof_top_front_z - porch_awning_t;
  _porch_post_h = _porch_roof_bottom_front_z - _porch_top_z;
  _porch_edge_slice = max(0.4, porch_post_d / 2);
  _door_top_z = front_door_sill + front_door_h;
  _porch_top_feature_z = _porch_roof_top_back_z;
  _window_w = window_d * 0.92;
  _window_h = window_d * 1.18;
  _window_z = min(window_z, _body_h - _window_h / 2 - wall * 0.6);
  _facade_trim_depth = max(1.6, wall * 0.9);
  _door_trim_w = max(1.6, wall * 0.8);
  _window_trim_w = max(1.4, wall * 0.75);
  _drawer_entry_z0 = floor_thickness;
  _drawer_entry_h = drawer_outer_h() + drawer_slide_clearance;

  assert(_inner_x > 0, "inner_x must be > 0");
  assert(_inner_y > 0, "inner_y must be > 0");
  assert(_body_h > floor_thickness, "body_wall_height must exceed floor_thickness");
  assert(_body_h >= _min_body_h, "body_wall_height must clear board + cooler + top_clearance_z");
  assert(front_door_h > 0, "front_door_h must be > 0");
  assert(front_door_w > 0, "front_door_w must be > 0");
  assert(front_door_sill >= 0, "front_door_sill must be >= 0");
  assert(front_door_sill + front_door_h <= _body_h, "front_door exceeds wall height");
  assert(front_door_w <= _outer_x - 2 * wall, "front_door_w exceeds front wall width");
  assert(window_d > 0, "window_d must be > 0");
  assert(_window_w > 0, "_window_w must be > 0");
  assert(_window_h > 0, "_window_h must be > 0");
  assert(_window_z - _window_h / 2 >= floor_thickness, "window extends below floor_thickness");
  assert(_window_z + _window_h / 2 <= _body_h, "window extends above wall height");
  assert(abs(window_x_offset) + _window_w / 2 <= _outer_x / 2 - wall, "window_x_offset places window outside front wall");
  assert(abs(window_x_offset) - _window_w / 2 >= front_door_w / 2, "window overlaps door profile");
  assert(_facade_trim_depth > 0, "facade trim depth must be > 0");
  assert(_door_trim_w > 0, "door trim width must be > 0");
  assert(_window_trim_w > 0, "window trim width must be > 0");
  assert(drawer_slide_clearance >= 0, "drawer_slide_clearance must be >= 0");
  assert(_drawer_entry_h > 0, "drawer entry opening height must be > 0");
  assert(main_room_inner_x() >= board_x + 2 * board_clearance_xy, "main room must fit board_x and clearance");
  assert(chimney_room_x > chimney_flue_d, "chimney_room_x should exceed chimney_flue_d for airflow wall margin");
  assert(divider_hole_w > 0, "divider_hole_w must be > 0");
  assert(divider_hole_front_extend_y >= 0, "divider_hole_front_extend_y must be >= 0");
  assert(_divider_hole_w_eff > 0, "effective divider hole width must be > 0");
  assert(divider_hole_h > 0, "divider_hole_h must be > 0");
  assert(_divider_hole_w_eff <= _inner_y - 2, "effective divider hole width exceeds divider wall span");
  assert(divider_roof_seal_gap >= 0, "divider_roof_seal_gap must be >= 0");
  assert(_divider_top_z_min > _body_h, "divider top must be above body wall height");
  assert(_divider_hole_z - divider_hole_h / 2 >= floor_thickness, "divider hole extends below floor_thickness");
  assert(_divider_hole_z + divider_hole_h / 2 <= _divider_top_z_min, "divider hole extends above divider top");
  assert(chimney_room_divider_t > _divider_taper_eps * 2, "chimney_room_divider_t is too small for divider bevel");
  assert(mount_stud_h >= 0, "mount_stud_h must be >= 0");
  assert(stud_to_board_standoff_z >= 0, "stud_to_board_standoff_z must be >= 0");
  assert(mount_hole_d > 0, "mount_hole_d must be > 0");
  assert(mount_head_recess_d > mount_hole_d, "mount_head_recess_d must exceed mount_hole_d");
  assert(mount_head_recess_h > 0, "mount_head_recess_h must be > 0");
  assert(mount_head_recess_h <= floor_thickness, "mount_head_recess_h must be <= floor_thickness");
  assert(mount_hole_d < corner_pad_d, "mount_hole_d must be less than corner_pad_d");
  assert(mount_head_recess_d <= corner_pad_d + 0.4, "mount_head_recess_d should fit inside stud diameter");
  assert(porch_w > 0, "porch_w must be > 0");
  assert(porch_d > 0, "porch_d must be > 0");
  assert(porch_deck_t > 0, "porch_deck_t must be > 0");
  assert(abs(porch_deck_z) < 0.001, "porch_deck_z should be 0 so porch base aligns with building bottom");
  assert(porch_post_w > 0 && porch_post_d > 0, "porch post dimensions must be > 0");
  assert(porch_roof_angle_deg > 0 && porch_roof_angle_deg < 45, "porch_roof_angle_deg must be between 0 and 45");
  assert(porch_w > 2 * porch_post_w, "porch_w too small for two corner posts");
  assert(_porch_roof_top_front_z > floor_thickness, "porch roof front edge is too low");
  assert(_porch_post_h > 0, "porch posts cannot reach the porch roof underside");
  assert(porch_awning_t > 0, "porch_awning_t must be > 0");
  assert(_porch_roof_top_back_z <= _body_h + 0.001, "porch roof top back must align with roof bottom");
  assert(_porch_top_feature_z > _door_top_z, "porch top must be above front door opening");

  difference() {
    union() {
      difference() {
        // Outer body
        translate([-_outer_x / 2, -_outer_y / 2, 0])
          cube([_outer_x, _outer_y, _body_h], center = false);

        // Hollow interior (top-open shell)
        translate([-_inner_x / 2, -_inner_y / 2, floor_thickness])
          cube([_inner_x, _inner_y, _body_h - floor_thickness + 0.05], center = false);
      }

      // Internal divider wall with a beveled top to follow roof/gable pitch.
      hull() {
        translate([_divider_x0, -_inner_y / 2, floor_thickness])
          cube([_divider_taper_eps, _inner_y, _divider_top_z_x0 - floor_thickness], center = false);
        translate([_divider_x1 - _divider_taper_eps, -_inner_y / 2, floor_thickness])
          cube([_divider_taper_eps, _inner_y, _divider_top_z_x1 - floor_thickness], center = false);
      }

      if (porch_enabled) {
        // Porch deck.
        translate([-porch_w / 2, _outer_y / 2, porch_deck_z])
          cube([porch_w, porch_d, porch_deck_t], center = false);

        // Porch posts.
        for (_sx = [-1, 1]) {
          translate([
            _sx > 0 ? (porch_w / 2 - porch_post_w) : (-porch_w / 2),
            _porch_post_y0,
            _porch_top_z
          ]) cube([porch_post_w, porch_post_d, _porch_post_h], center = false);
        }

        // Sloped porch roof (22 deg default), top back edge aligned to roof bottom.
        hull() {
          translate([-porch_w / 2, _outer_y / 2, _porch_roof_top_back_z - porch_awning_t])
            cube([porch_w, _porch_edge_slice, porch_awning_t], center = false);

          translate([-porch_w / 2, _outer_y / 2 + porch_d - _porch_edge_slice, _porch_roof_top_front_z - porch_awning_t])
            cube([porch_w, _porch_edge_slice, porch_awning_t], center = false);
        }
      }

      // Front/back gables are part of the wall assembly, not the roof shell.
      for (_sy = [-1, 1]) {
        _y0 = _sy > 0 ? _outer_y / 2 - wall : -_outer_y / 2;
        intersection() {
          translate([-_outer_x / 2, _y0, _body_h])
            cube([_outer_x, wall, roof_peak_h + 0.2], center = false);
          translate([0, _inner_fit_y / 2, _body_h])
            rotate([90, 0, 0])
            linear_extrude(height = _inner_fit_y)
            roof_profile_2d(_half_inner, _eave_inner, _peak_inner);
        }
      }

      // Front facade trim: decorative-only door and windows (no wall openings).
      translate([0, _outer_y / 2 + _facade_trim_depth, front_door_sill])
        rotate([90, 0, 0])
        linear_extrude(height = _facade_trim_depth)
        arched_border_2d(front_door_w, front_door_h, _door_trim_w);

      for (_sx = [-1, 1]) {
        translate([_sx * window_x_offset, _outer_y / 2 + _facade_trim_depth, _window_z])
          rotate([90, 0, 0])
          linear_extrude(height = _facade_trim_depth)
          rect_border_2d(_window_w, _window_h, _window_trim_w);
      }
    }

    // Large full-edge drawer entry opening on the left wall.
    translate([
      -_outer_x / 2 - 0.1,
      -_outer_y / 2 - 0.1,
      _drawer_entry_z0 - 0.1
    ]) cube([wall + 0.3, _outer_y + 0.2, _drawer_entry_h + 0.2], center = false);

    // Rectangular duct pass-through in the internal divider.
    translate([_divider_cx, _divider_hole_y_eff, _divider_hole_z])
      centered_cube([chimney_room_divider_t + 0.5, _divider_hole_w_eff, divider_hole_h]);
  }
}

module cottage_pi6_plus_drawer() {
  _drawer_x = drawer_outer_x();
  _drawer_y = drawer_outer_y();
  _drawer_floor_t = floor_thickness;
  _drawer_wall_t = wall;
  _drawer_side_wall_h = drawer_side_wall_h();
  _io_cutout_z0_drawer = io_cutout_z0 - floor_thickness;
  _divider_hole_z_drawer = drawer_divider_hole_z();
  _drawer_end_wall_h = drawer_outer_h();
  _drawer_cover_t = wall;
  _drawer_cover_y = case_outer_y();
  _drawer_cover_z0 = 0;
  _drawer_cover_h = _drawer_end_wall_h + drawer_slide_clearance;
  _drawer_inner_x_max = _drawer_x / 2 - _drawer_wall_t;
  _hole_set1_x = _drawer_inner_x_max - drawer_hole_set1_from_exhaust_wall;
  _hole_set2_x = _hole_set1_x - drawer_hole_set_spacing_x;
  _hole_y_half_span = drawer_hole_pair_spacing_y / 2;
  _divider_hole_w_eff = divider_hole_effective_w();
  _divider_hole_y_eff = divider_hole_effective_y_offset();

  assert(_drawer_x > 0, "drawer_x must be > 0");
  assert(_drawer_y > 0, "drawer_y must be > 0");
  assert(_drawer_wall_t > 0, "drawer wall thickness must be > 0");
  assert(_drawer_side_wall_h > _drawer_floor_t, "drawer side wall height must exceed drawer floor thickness");
  assert(_drawer_end_wall_h >= _drawer_side_wall_h, "drawer end walls must be >= side wall height");
  assert(drawer_slide_clearance >= 0, "drawer_slide_clearance must be >= 0");
  assert(_drawer_cover_t > 0, "drawer cover thickness must be > 0");
  assert(_drawer_cover_y >= _drawer_y, "drawer cover y span must be >= drawer y span");
  assert(_drawer_cover_h > 0, "drawer cover height must be > 0");
  assert(corner_pad_d > 0, "corner_pad_d must be > 0");
  assert(mount_stud_h >= 0, "mount_stud_h must be >= 0");
  assert(mount_hole_d > 0, "mount_hole_d must be > 0");
  assert(mount_head_recess_d > mount_hole_d, "mount_head_recess_d must exceed mount_hole_d");
  assert(mount_head_recess_h > 0, "mount_head_recess_h must be > 0");
  assert(mount_head_recess_h <= _drawer_floor_t, "mount_head_recess_h must be <= drawer floor thickness");
  assert(drawer_hole_set1_from_exhaust_wall >= 0, "drawer_hole_set1_from_exhaust_wall must be >= 0");
  assert(drawer_hole_set_spacing_x > 0, "drawer_hole_set_spacing_x must be > 0");
  assert(drawer_hole_pair_spacing_y > 0, "drawer_hole_pair_spacing_y must be > 0");
  assert(drawer_end_wall_extra_h >= 0, "drawer_end_wall_extra_h must be >= 0");
  assert(_hole_set1_x + corner_pad_d / 2 <= _drawer_x / 2, "set1 hole centers exceed drawer +x edge");
  assert(_hole_set2_x - corner_pad_d / 2 >= -_drawer_x / 2, "set2 hole centers exceed drawer -x edge");
  assert(_hole_y_half_span + corner_pad_d / 2 <= _drawer_y / 2, "drawer_hole_pair_spacing_y exceeds drawer y span");
  assert(io_cutout_span_y > 0 && io_cutout_span_y <= _drawer_y, "io_cutout_span_y must fit drawer short-end wall");
  assert(divider_hole_front_extend_y >= 0, "divider_hole_front_extend_y must be >= 0");
  assert(_divider_hole_w_eff > 0 && _divider_hole_w_eff <= _drawer_y, "effective divider hole width must fit drawer short-end wall");
  assert(_io_cutout_z0_drawer >= _drawer_floor_t, "drawer I/O opening starts below drawer floor");
  assert(_divider_hole_z_drawer - divider_hole_h / 2 >= _drawer_floor_t, "drawer divider opening starts below drawer floor");

  difference() {
    union() {
      // Drawer floor plate.
      translate([-_drawer_x / 2, -_drawer_y / 2, 0])
        cube([_drawer_x, _drawer_y, _drawer_floor_t], center = false);

      // Long side rails (low walls).
      translate([-_drawer_x / 2, -_drawer_y / 2, 0])
        cube([_drawer_x, _drawer_wall_t, _drawer_side_wall_h], center = false);
      translate([-_drawer_x / 2, _drawer_y / 2 - _drawer_wall_t, 0])
        cube([_drawer_x, _drawer_wall_t, _drawer_side_wall_h], center = false);

      // Short-end walls (taller) so they can carry the two functional openings.
      translate([-_drawer_x / 2, -_drawer_y / 2, 0])
        cube([_drawer_wall_t, _drawer_y, _drawer_end_wall_h], center = false);
      translate([_drawer_x / 2 - _drawer_wall_t, -_drawer_y / 2, 0])
        cube([_drawer_wall_t, _drawer_y, _drawer_end_wall_h], center = false);

      // Exterior closure section that restores the removed base side wall when drawer is inserted.
      // This intentionally leaves only the I/O opening area open.
      translate([
        -_drawer_x / 2 - _drawer_cover_t,
        -_drawer_cover_y / 2,
        _drawer_cover_z0
      ]) cube([_drawer_cover_t, _drawer_cover_y, _drawer_cover_h], center = false);

      // Board mounting studs moved from base to drawer.
      // Set 1 is near the exhaust wall; set 2 is offset in -x.
      for (_sx = [_hole_set1_x, _hole_set2_x]) {
        for (_sy = [-_hole_y_half_span, _hole_y_half_span]) {
          translate([
            _sx,
            _sy,
            _drawer_floor_t
          ])
            cylinder(d = corner_pad_d, h = mount_stud_h, $fn = 64);
        }
      }
    }

    // M2.5 through-holes and underside head recesses in drawer studs.
    for (_stud_x = [_hole_set1_x, _hole_set2_x]) {
      for (_stud_y = [-_hole_y_half_span, _hole_y_half_span]) {

        translate([_stud_x, _stud_y, -0.1])
          cylinder(d = mount_hole_d, h = _drawer_floor_t + mount_stud_h + 0.3, $fn = 48);

        translate([_stud_x, _stud_y, -0.1])
          cylinder(d = mount_head_recess_d, h = mount_head_recess_h + 0.2, $fn = 48);
      }
    }

    // Drawer pass-through for the broad I/O side opening.
    translate([
      -_drawer_x / 2 - _drawer_cover_t - 0.1,
      -io_cutout_span_y / 2,
      _io_cutout_z0_drawer
    ]) cube([_drawer_cover_t + _drawer_wall_t + 0.3, io_cutout_span_y, io_cutout_h], center = false);

    // Drawer pass-through aligned to the divider/exhaust opening.
    translate([
      _drawer_x / 2 - _drawer_wall_t - 0.1,
      _divider_hole_y_eff - _divider_hole_w_eff / 2,
      _divider_hole_z_drawer - divider_hole_h / 2
    ]) cube([_drawer_wall_t + 0.3, _divider_hole_w_eff, divider_hole_h], center = false);
  }
}

module cottage_pi6_plus_roof() {
  _inner_fit_x = case_outer_x() + 2 * roof_fit_clearance;
  _inner_fit_y = case_outer_y() + 2 * roof_fit_clearance;
  _roof_insert_x = case_outer_x() + 2 * roof_insert_clearance;
  _roof_insert_y = case_outer_y() + 2 * roof_insert_clearance;
  _roof_socket_depth = max(roof_insert_depth, roof_wall);
  _outer_roof_x = _inner_fit_x + 2 * roof_wall + 2 * roof_overhang;
  _outer_roof_y = _inner_fit_y + 2 * roof_wall + 2 * roof_overhang;
  _half_outer = _outer_roof_x / 2;
  _half_inner = max(0.5, _half_outer - roof_wall);
  _eave_inner = max(0.5, roof_eave_h - roof_wall);
  // Keep positive ridge thickness; previous formula could collapse to ~0 at the peak.
  _peak_inner = max(_eave_inner + 0.8, roof_peak_h - 2 * roof_wall);
  _chimney_x = chimney_center_x();
  _chimney_od = min(chimney_shaft_w, chimney_shaft_d);
  _roof_slope_abs = abs(roof_peak_h - roof_eave_h) / max(_half_outer, 0.001);
  _chimney_embed_eff = max(chimney_embed, _chimney_od / 2 * _roof_slope_abs + 0.4);
  _chimney_z0 = max(0, roof_surface_z(_chimney_x, _half_outer, roof_eave_h, roof_peak_h) - _chimney_embed_eff);
  _max_flue_d = min(chimney_shaft_w, chimney_shaft_d) - 2 * chimney_wall;
  _chimney_transition_h = max(0.1, fan_cutout_transition_h);
  _chimney_adapter_od = fan_center_cutout_d + 2 * chimney_wall;

  assert(roof_peak_h > roof_eave_h, "roof_peak_h must be greater than roof_eave_h");
  assert(roof_insert_clearance >= 0, "roof_insert_clearance must be >= 0");
  assert(roof_insert_depth > 0, "roof_insert_depth must be > 0");
  assert(_roof_insert_x <= _inner_fit_x, "roof_insert_x should be <= inner fit width");
  assert(_roof_insert_y <= _inner_fit_y, "roof_insert_y should be <= inner fit depth");
  assert(_outer_roof_x > 0, "outer roof width must be > 0");
  assert(_outer_roof_y > 0, "outer roof depth must be > 0");
  assert(_chimney_x > 0, "side-style chimney should be on +x side");
  assert(chimney_shaft_w > 0, "chimney_shaft_w must be > 0");
  assert(chimney_shaft_d > 0, "chimney_shaft_d must be > 0");
  assert(abs(chimney_shaft_w - chimney_shaft_d) < 0.001, "chimney_shaft_w and chimney_shaft_d must match for circular chimney");
  assert(fan_frame > 0, "fan_frame must be > 0");
  assert(fan_hole_spacing > 0, "fan_hole_spacing must be > 0");
  assert(fan_mount_hole_d > 0, "fan_mount_hole_d must be > 0");
  assert(fan_center_cutout_d > 0, "fan_center_cutout_d must be > 0");
  assert(fan_mount_plate_t > 0, "fan_mount_plate_t must be > 0");
  assert(fan_screw_hole_depth > 0, "fan_screw_hole_depth must be > 0");
  assert(fan_screw_hole_depth <= chimney_h, "fan_screw_hole_depth cannot exceed chimney_h");
  assert(fan_hole_spacing + fan_mount_hole_d <= fan_frame, "fan_hole_spacing/hole_d do not fit fan_frame");
  assert(fan_center_cutout_d < fan_frame, "fan_center_cutout_d must be less than fan_frame");
  assert(chimney_flue_d > 0, "chimney_flue_d must be > 0");
  assert(_max_flue_d > 0, "chimney_wall too thick for chimney_shaft_w/chimney_shaft_d");
  assert(chimney_flue_d <= _max_flue_d, "chimney_flue_d exceeds available chimney wall thickness");
  assert(chimney_shaft_w <= fan_frame, "chimney_shaft_w should not exceed fan_frame");
  assert(chimney_shaft_d <= fan_frame, "chimney_shaft_d should not exceed fan_frame");
  assert(fan_center_cutout_d >= chimney_flue_d, "fan_center_cutout_d should be >= chimney_flue_d");
  assert(_chimney_adapter_od <= fan_frame, "chimney adapter exceeds fan frame footprint");
  assert(_chimney_adapter_od >= _chimney_od, "chimney adapter must be at least as wide as chimney shaft");

  difference() {
    union() {
      difference() {
        // Pitched roof shell.
        translate([0, _outer_roof_y / 2, 0])
          rotate([90, 0, 0])
          linear_extrude(height = _outer_roof_y)
          roof_profile_2d(_half_outer, roof_eave_h, roof_peak_h);

        // Inner cavity.
        translate([0, (_outer_roof_y - 2 * roof_wall) / 2, roof_wall])
          rotate([90, 0, 0])
          linear_extrude(height = _outer_roof_y - 2 * roof_wall)
          roof_profile_2d(_half_inner, _eave_inner, _peak_inner);

        // Bottom insert recess so roof edges slide onto the wall top.
        // Depth is clamped to at least roof_wall so no internal floor remains.
        translate([-_roof_insert_x / 2, -_roof_insert_y / 2, -0.1])
          cube([_roof_insert_x, _roof_insert_y, _roof_socket_depth + 0.2], center = false);
      }

      // Chimney body.
      translate([_chimney_x, chimney_y, _chimney_z0])
        cylinder(d = _chimney_od, h = chimney_h, $fn = 96);

      // Solid transition collar keeps the thin chimney shaft connected to the 40 mm mount.
      translate([_chimney_x, chimney_y, _chimney_z0 + chimney_h - fan_mount_plate_t - _chimney_transition_h])
        cylinder(d1 = _chimney_od, d2 = _chimney_adapter_od, h = _chimney_transition_h, $fn = 96);

      // 40 mm fan mounting top.
      translate([_chimney_x - fan_frame / 2, chimney_y - fan_frame / 2, _chimney_z0 + chimney_h - fan_mount_plate_t])
        cube([fan_frame, fan_frame, fan_mount_plate_t], center = false);
    }

    // Main flue through roof into case cavity.
    translate([_chimney_x, chimney_y, -0.5])
      cylinder(d = chimney_flue_d, h = roof_peak_h + chimney_h + 10, $fn = 64);

    // Fan-side larger cutout near chimney top.
    translate([_chimney_x, chimney_y, _chimney_z0 + chimney_h - fan_mount_plate_t - 0.05])
      cylinder(d = fan_center_cutout_d, h = fan_mount_plate_t + 0.2, $fn = 96);

    // Transition from fan cutout to narrower flue.
    translate([_chimney_x, chimney_y, _chimney_z0 + chimney_h - fan_mount_plate_t - _chimney_transition_h])
      cylinder(d1 = chimney_flue_d, d2 = fan_center_cutout_d, h = _chimney_transition_h + 0.1, $fn = 96);

    // 40 mm fan mounting holes (32 mm square pattern).
    for (_sx = [-1, 1]) {
      for (_sy = [-1, 1]) {
        translate([
          _chimney_x + _sx * fan_hole_spacing / 2,
          chimney_y + _sy * fan_hole_spacing / 2,
          _chimney_z0 + chimney_h - fan_screw_hole_depth
        ])
          cylinder(d = fan_mount_hole_d, h = fan_screw_hole_depth + 0.2, $fn = 36);
      }
    }

  }
}

module cottage_pi6_plus() {
  _drawer_insert_x = board_center_x();
  _drawer_insert_z = floor_thickness;
  _drawer_exhaust_face_x = _drawer_insert_x + drawer_outer_x() / 2;
  _divider_main_room_face_x = divider_center_x() - chimney_room_divider_t / 2;
  _drawer_exhaust_center_z = _drawer_insert_z + drawer_divider_hole_z();
  _divider_exhaust_center_z = floor_thickness + mount_stud_h + stud_to_board_standoff_z + board_thickness + divider_hole_z_from_board_top;

  assert(abs(_drawer_exhaust_face_x - _divider_main_room_face_x) < 0.001, "drawer exhaust face must align with divider face when inserted");
  assert(abs(_drawer_exhaust_center_z - _divider_exhaust_center_z) < 0.001, "drawer exhaust opening must align with divider opening in Z");

  cottage_pi6_plus_base();
  translate([_drawer_insert_x, 0, _drawer_insert_z]) cottage_pi6_plus_drawer();
  translate([0, 0, body_wall_height]) cottage_pi6_plus_roof();
}
