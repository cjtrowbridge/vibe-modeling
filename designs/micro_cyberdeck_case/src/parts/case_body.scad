// Single-piece rectangular case with an open top and no front wall.
// The right (fan) wall carries its own thickness (fan_wall_thickness); the
// left wall and floor keep wall_thickness, except that the top band of the
// left wall above the micro-SD window extends into the cavity by
// top_band_cavity_extension (rev_0004 amend, when enabled).
function right_wall_inner_x() = wall_thickness + interior_width;
function case_outer_width() = right_wall_inner_x() + fan_wall_thickness;
function case_outer_depth() = interior_depth + 2 * wall_thickness;
function case_outer_height() = interior_height + floor_thickness;
function back_wall_y() = wall_thickness + interior_depth;
// Back-rail placement (rev_0004 R4): x = 8..65 (5 mm in from each internal
// side wall), z top 5 mm below the rim (band z = 37..40), ledge 3 mm deep in
// front of the back wall's internal face (y = 39..42), tenon through the full
// back wall (y = 42..45, flush with the rear outer face). The 3 mm section
// equals the declared minimum_internal_edge_width; no relaxation applies.
function rail_min_x() = wall_thickness + rail_x_inset;
function rail_max_x() = right_wall_inner_x() - rail_x_inset;
function rail_top_z() = case_outer_height() - rail_top_below_rim;
function rail_bottom_z() = rail_top_z() - rail_section;
function rail_front_y() = back_wall_y() - rail_section;
function rail_tenon_rear_y() = back_wall_y() + wall_thickness;
function microsd_center_y() = case_outer_depth() - microsd_center_from_back_outer_edge;
function microsd_center_z() = floor_thickness + microsd_center_above_internal_floor;
function microsd_min_y() = microsd_center_y() - microsd_opening_width / 2;
function microsd_max_y() = microsd_center_y() + microsd_opening_width / 2;
function microsd_min_z() = microsd_center_z() - microsd_opening_height / 2;
function microsd_max_z() = microsd_center_z() + microsd_opening_height / 2;
function microsd_front_margin() = microsd_min_y();
function microsd_back_margin() = case_outer_depth() - microsd_max_y();
function microsd_floor_ligament() = microsd_min_z() - floor_thickness;
function microsd_top_margin() = case_outer_height() - microsd_max_z();
// Left-wall top band above the micro-SD (upper) window (rev_0004 amend):
// the solid band z = microsd_max_z()..case_outer_height() crossing the top
// opening; top_band_cavity_extension grows its thickness into the cavity
// (internal face x = wall_thickness -> + top_band_cavity_extension).
function left_top_band_bottom_z() = microsd_max_z();
function left_top_band_top_z() = case_outer_height();
function divider_bottom_z() = floor_thickness + divider_gap_above_internal_floor;
function divider_top_z() = divider_bottom_z() + divider_thickness;
function divider_front_y() = wall_thickness;
function divider_back_y() = case_outer_depth();
function divider_depth() = divider_back_y() - divider_front_y();
function divider_cable_passage_x_max() = wall_thickness + divider_cable_passage_width;
function divider_cable_passage_y_max() = divider_front_y() + divider_cable_passage_depth;
function microsd_intersects_divider() =
  microsd_opening_enabled &&
  microsd_min_z() < divider_top_z() &&
  microsd_max_z() > divider_bottom_z();
function divider_post_cut_left_support_start_y() =
  microsd_intersects_divider()
    ? max(divider_cable_passage_y_max(), microsd_max_y())
    : divider_cable_passage_y_max();
function divider_post_cut_left_support_length() =
  divider_back_y() - divider_post_cut_left_support_start_y();
function battery_exit_center_y() = case_outer_depth() - battery_exit_center_from_back_outer_edge;
function battery_exit_center_z() = floor_thickness + battery_exit_center_above_internal_floor;
function battery_exit_min_y() = battery_exit_center_y() - battery_exit_width / 2;
function battery_exit_max_y() = battery_exit_center_y() + battery_exit_width / 2;
function battery_exit_min_z() = battery_exit_center_z() - battery_exit_height / 2;
function battery_exit_max_z() = battery_exit_center_z() + battery_exit_height / 2;
// fan_center_y is a config variable (defaults.scad) used directly; not a function.
function fan_center_z() = case_outer_height() / 2;
function fan_air_radius() = fan_air_opening_d / 2;
function fan_screw_offset() = fan_hole_spacing / 2;
function fan_air_front_margin() = fan_center_y - fan_air_radius();
function fan_air_back_margin() = case_outer_depth() - fan_center_y - fan_air_radius();
function fan_air_bottom_margin() = fan_center_z() - fan_air_radius();
function fan_air_top_margin() = case_outer_height() - fan_center_z() - fan_air_radius();
// Mount-hole margin to the back, bottom, and top edges (closed perimeter
// edges of the right wall); the open front edge is asserted separately.
function fan_screw_clearance_margin() = min(
  case_outer_depth() - fan_center_y - fan_screw_offset() - fan_mount_hole_d / 2,
  fan_center_z() - fan_screw_offset() - fan_mount_hole_d / 2,
  case_outer_height() - fan_center_z() - fan_screw_offset() - fan_mount_hole_d / 2);
function fan_corner_land() = sqrt(2) * fan_screw_offset() - fan_air_radius() - fan_mount_hole_d / 2;
function divider_fan_chord_half() = sqrt(fan_air_radius() ^ 2 - (fan_center_z() - divider_top_z()) ^ 2);
function divider_right_front_leg() = fan_center_y - divider_fan_chord_half() - divider_front_y();
function divider_right_back_leg() = divider_back_y() - fan_center_y - divider_fan_chord_half();

module _assert_case_dimensions() {
  assert(interior_width > 0 && interior_depth > 0 && interior_height > 0,
    "Interior dimensions must be positive.");
  assert(wall_thickness >= minimum_wall_thickness,
    "Wall thickness is below the minimum wall thickness.");
  assert(floor_thickness >= minimum_wall_thickness,
    "Floor thickness is below the minimum wall thickness.");
  assert(minimum_structural_overlap >= minimum_wall_thickness,
    "Structural overlap must be at least the minimum wall thickness.");
  assert(minimum_internal_edge_width >= minimum_wall_thickness,
    "Internal edges and material strips must be at least the minimum wall thickness.");
  assert(wall_floor_overlap >= minimum_structural_overlap,
    "Walls do not engage the floor by the minimum structural overlap.");
  assert(rear_corner_overlap >= minimum_structural_overlap,
    "Rear wall corners do not have the minimum structural overlap.");
  assert(front_floor_apron_depth >= minimum_internal_edge_width,
    "The floor apron at the omitted front wall is too narrow.");
  assert(case_outer_width() > interior_width && case_outer_depth() > interior_depth,
    "Exterior dimensions must contain the nominal interior envelope.");
  assert(case_outer_height() > interior_height,
    "Exterior height must contain the nominal interior height above the floor.");
  assert(microsd_opening_width > 0 && microsd_opening_height > 0,
    "microSD opening dimensions must be positive.");
  assert(boolean_epsilon > 0 && boolean_epsilon < wall_thickness,
    "Boolean epsilon must be positive and smaller than the wall thickness.");
  assert(microsd_center_from_back_outer_edge > microsd_opening_width / 2,
    "microSD opening extends beyond the outer back edge.");
  assert(microsd_center_above_internal_floor > microsd_opening_height / 2,
    "microSD opening extends into the internal floor.");
  assert(microsd_front_margin() >= minimum_internal_edge_width,
    "microSD opening leaves too little material to the outer front edge.");
  assert(microsd_back_margin() >= minimum_internal_edge_width,
    "microSD opening leaves too little material to the outer back edge.");
  assert(microsd_floor_ligament() >= minimum_internal_edge_width,
    "microSD opening leaves too little wall material above the internal floor.");
  assert(microsd_top_margin() >= minimum_internal_edge_width,
    "microSD opening leaves too little wall material below the rim.");
  if (battery_exit_enabled) {
    assert(battery_exit_width > 0 && battery_exit_height > 0,
      "Battery exit dimensions must be positive.");
    assert(battery_exit_center_from_back_outer_edge > battery_exit_width / 2,
      "Battery exit extends beyond the outer back edge.");
    assert(battery_exit_center_above_internal_floor >= battery_exit_height / 2,
      "Battery exit extends below the internal floor top plane.");
    assert(battery_exit_min_y() >= minimum_internal_edge_width,
      "Battery exit leaves too little material to the outer front edge.");
    assert(case_outer_depth() - battery_exit_max_y() >= minimum_internal_edge_width,
      "Battery exit leaves too little material to the outer back edge.");
    assert(battery_exit_min_z() == floor_thickness,
      "Battery exit bottom must sit on the internal floor top plane.");
    assert(battery_exit_max_z() == divider_bottom_z(),
      "Battery exit top must align with the bottom of the divider.");
  }
  if (fan_enabled) {
    assert(fan_wall_thickness >= minimum_wall_thickness,
      "Right (fan) wall thickness is below the minimum wall thickness.");
    // Blind screw-head seats must leave solid material behind their seat
    // floors (rev_0003 R3: 6 mm wall, 3 mm seats -> 3 mm solid). The R2
    // fallback (fan_wall_thickness == wall_thickness ==
    // fan_screw_recess_depth) makes the seat floor flush with the outer face,
    // which is the through-seat case and is allowed.
    assert(fan_wall_thickness <= fan_screw_recess_depth ||
           fan_wall_thickness - fan_screw_recess_depth >= minimum_internal_edge_width,
      "Blind screw-head seats leave too little solid material behind the seat floor.");
    assert(fan_air_opening_d > 0 && fan_hole_spacing > 0 && fan_mount_hole_d > 0,
      "Fan air opening and mount hole dimensions must be positive.");
    assert(fan_center_z() == case_outer_height() / 2,
      "Fan must be centered on the outer right wall in z.");
    assert(fan_center_y == case_outer_depth() / 2,
      "Fan must be centered on the outer right wall in y.");
    assert(fan_center_y + fan_screw_offset() + fan_screw_recess_d / 2 <= case_outer_depth() - minimum_internal_edge_width,
      "Back fan screw seat leaves too little wall material to the outer back face.");
    assert(fan_center_y - fan_screw_offset() - fan_screw_recess_d / 2 >= minimum_internal_edge_width,
      "Front fan screw seat leaves too little wall material to the open front edge.");
    assert(min(fan_center_z() - fan_screw_offset() - fan_screw_recess_d / 2,
               case_outer_height() - fan_center_z() - fan_screw_offset() - fan_screw_recess_d / 2) >= minimum_internal_edge_width,
      "Fan screw head recesses leave too little right-wall material bottom to top.");
    // Documented relaxation (user decision 2026-09-14, R2): the d38 air bore
    // and the d6 head seats may overlap on the four station diagonals; the
    // ligament is 16*sqrt(2) - 19 - 3 = 0.63 mm. Every PERIMETER ring around
    // each screw station retains >= 3 mm of wall (front 4.4, back 4.4, top
    // 5.4, bottom 5.4 for the d4.2 holes; 3.5/3.5/4.5/4.5 for the d6 seats).
    assert(sqrt(2) * fan_screw_offset() - fan_air_radius() - fan_screw_recess_d / 2 >= 0.6,
      "Fan screw head seats over-lap the air opening diagonal ligament (documented 0.6 mm floor).");
    assert(fan_air_front_margin() >= minimum_internal_edge_width && fan_air_back_margin() >= minimum_internal_edge_width,
      "Fan air opening leaves too little right-wall material front to back.");
    assert(fan_air_bottom_margin() >= minimum_internal_edge_width && fan_air_top_margin() >= minimum_internal_edge_width,
      "Fan air opening leaves too little right-wall material bottom to top.");
    assert(fan_screw_clearance_margin() >= minimum_internal_edge_width,
      "Fan mount holes leave too little right-wall material to the back, bottom, and top edges.");
    assert(fan_center_y - fan_screw_offset() - fan_mount_hole_d / 2 >= minimum_internal_edge_width,
      "Front fan screw hole leaves too little wall material to the open front edge.");
    // Same documented relaxation: the bore-to-d4.2-hole corner land is
    // 16*sqrt(2) - 19 - 2.1 = 1.53 mm; the 0.63 mm d6-seat ligament above
    // is the governing (narrower) diagonal.
    assert(fan_corner_land() >= 0.6,
      "Fan mount holes intrude on the corner land around the air opening (documented 0.6 mm floor).");
    if (divider_enabled) {
      assert(fan_center_z() - fan_air_radius() < divider_bottom_z() && fan_center_z() + fan_air_radius() > divider_top_z(),
        "Fan air opening must span the divider band to form the shared air channel.");
      // Documented relaxation (R2, d38 bore): the divider's front right leg is
      // a 1.04 mm non-structural sliver left after the d38 air bore crosses the
      // right end within the divider band (worst case at z=18); the divider's
      // primary supports (left wall and back wall) remain at the minimum
      // structural overlap.
      assert(divider_right_front_leg() >= 1.0,
        "Divider front right-leg sliver (non-structural; d38 air bore crosses the right end) is too thin to print.");
      assert(divider_right_back_leg() >= minimum_internal_edge_width,
        "Fan cut leaves too little divider back leg at the right wall.");
    }
  }
  if (rail_enabled) {
    assert(rail_section > 0 && rail_x_inset > 0 && rail_top_below_rim > 0,
      "Rail dimensions must be positive.");
    // The through tenon fills the full back-wall thickness: continuous
    // structural engagement across the entire rail seam (rev_0004 R4).
    assert(rail_tenon_rear_y() - back_wall_y() == wall_thickness,
      "Rail tenon must span the full back-wall thickness.");
    assert(wall_thickness >= minimum_structural_overlap,
      "Rail tenon engagement is below the minimum structural overlap.");
    assert(rail_top_below_rim >= minimum_internal_edge_width,
      "Rail leaves too little material to the rim.");
    // The 3 x 3 mm rail section (user decision 2026-09-16) meets the
    // declared minimum_internal_edge_width directly; the earlier 2 mm
    // relaxation is retired.
    assert(rail_section >= minimum_internal_edge_width,
      "Rail section is below the minimum internal edge width.");
    assert(rail_min_x() > wall_thickness,
      "Rail start does not clear the left internal wall face.");
    assert(rail_max_x() < right_wall_inner_x(),
      "Rail end does not clear the right internal wall face.");
    assert(rail_max_x() - rail_min_x() > 2 * minimum_internal_edge_width,
      "Rail span is too short for the declared internal edge minimums.");
    assert(rail_front_y() > wall_thickness,
      "Rail ledge intrudes into the left wall band.");
    if (divider_enabled) {
      assert(rail_bottom_z() > divider_top_z(),
        "Rail ledge interferes with the divider.");
    }
  }
  if (lip_enabled) {
    assert(lip_width > 0 && lip_width < wall_thickness,
      "Retention lip tightening must be positive and stay inside the left wall face thickness.");
    if (microsd_opening_enabled) {
      assert(2 * lip_width < microsd_opening_width && 2 * lip_width < microsd_opening_height,
        "Lip tightening must leave a positive micro-SD opening.");
    }
    if (battery_exit_enabled) {
      assert(2 * lip_width < battery_exit_width && 2 * lip_width < battery_exit_height,
        "Lip tightening must leave a positive battery exit opening.");
    }
  }
  if (top_band_extension_enabled) {
    assert(top_band_cavity_extension > 0 &&
           top_band_cavity_extension <= wall_thickness,
      "Left top band cavity extension must be positive and stay inside the left wall thickness.");
    assert(left_top_band_bottom_z() < left_top_band_top_z(),
      "Left top band must be a positive-height band.");
    assert(top_band_cavity_extension >= minimum_internal_edge_width,
      "Left top band cavity extension is below the minimum internal edge width.");
  }
  if (top_band_right_enabled) {
    assert(top_band_cavity_extension > 0 &&
           top_band_cavity_extension <= fan_wall_thickness,
      "Right top band cavity extension must be positive and stay inside the fan wall thickness.");
    assert(left_top_band_bottom_z() < left_top_band_top_z(),
      "Right top band must be a positive-height band.");
    assert(top_band_cavity_extension >= minimum_internal_edge_width,
      "Right top band cavity extension is below the minimum internal edge width.");
  }
  if (divider_enabled) {
    assert(divider_thickness >= minimum_wall_thickness,
      "Divider thickness is below the minimum wall thickness.");
    assert(divider_gap_above_internal_floor > 0,
      "Divider must remain above the internal floor.");
    assert(divider_side_wall_overlap >= minimum_structural_overlap,
      "Divider does not engage each side wall by the minimum overlap.");
    assert(divider_back_wall_overlap >= minimum_structural_overlap,
      "Divider does not engage the back wall by the minimum overlap.");
    assert(divider_cable_passage_width > 0 && divider_cable_passage_depth > 0,
      "Divider cable pass-through dimensions must be positive.");
    assert(divider_cable_passage_x_max() > wall_thickness,
      "Divider cable pass-through does not clear the left wall inside face.");
    assert(divider_cable_passage_y_max() <= divider_back_y(),
      "Divider cable pass-through exceeds the divider depth.");
    assert(divider_post_cut_left_support_length() >= minimum_structural_overlap,
      "Divider retains too little post-cut left-wall support.");
    assert(divider_depth() >= minimum_structural_overlap,
      "Divider right-wall support seam is too short.");
    assert(case_outer_width() >= minimum_structural_overlap,
      "Divider back-wall support seam is too short.");
    assert(divider_top_z() < case_outer_height(),
      "Divider must remain below the case rim.");
    if (microsd_opening_enabled) {
      assert(microsd_min_z() == divider_top_z(),
        "microSD opening bottom must align with the top of the divider.");
    }
  }
}

module _case_floor() {
  cube([case_outer_width(), case_outer_depth(), floor_thickness]);
}

module _left_wall() {
  cube([wall_thickness, case_outer_depth(), case_outer_height()]);
}

module _right_wall() {
  translate([right_wall_inner_x(), 0, 0])
    cube([fan_wall_thickness, case_outer_depth(), case_outer_height()]);
}

// Top-band ledges (rev_0004 amend, 2026-09-16): the band above the
// micro-SD (upper) window gains a shelf of top_band_cavity_extension into
// the cavity on each enabled side wall, over the full wall width
// y = 0..back_wall_y() (the y = back_wall_y()..case_outer_depth() portion
// is already back wall) and z = microsd_max_z()..case_outer_height().
// Flat retention ledges: each unites to its side wall over a
// back_wall_y() x band-depth face and overlaps the back wall (a
// top_band_cavity_extension x band-depth cross-section at y = 42..45);
// no load path is expected. At the configured 3 mm each shelf meets
// minimum_internal_edge_width; no exception applies.
module _left_wall_top_band_extension() {
  translate([wall_thickness, 0, left_top_band_bottom_z()])
    cube([
      top_band_cavity_extension,
      back_wall_y(),
      left_top_band_top_z() - left_top_band_bottom_z()
    ]);
}

module _right_wall_top_band_extension() {
  translate([right_wall_inner_x() - top_band_cavity_extension, 0, left_top_band_bottom_z()])
    cube([
      top_band_cavity_extension,
      back_wall_y(),
      left_top_band_top_z() - left_top_band_bottom_z()
    ]);
}

module _back_wall() {
  translate([0, back_wall_y(), 0])
    cube([case_outer_width(), wall_thickness, case_outer_height()]);
}

module _divider_slab() {
  translate([0, divider_front_y(), divider_bottom_z()])
    cube([case_outer_width(), divider_depth(), divider_thickness]);
}

module _divider_cable_passage_cut() {
  translate([
    -boolean_epsilon,
    divider_front_y() - boolean_epsilon,
    divider_bottom_z() - boolean_epsilon
  ])
    cube([
      divider_cable_passage_x_max() + boolean_epsilon,
      divider_cable_passage_depth + boolean_epsilon,
      divider_thickness + 2 * boolean_epsilon
    ]);
}

module _battery_sbc_divider() {
  difference() {
    _divider_slab();
    _divider_cable_passage_cut();
  }
}

module _back_rail() {
  translate([rail_min_x(), rail_front_y(), rail_bottom_z()])
    cube([
      rail_max_x() - rail_min_x(),
      rail_tenon_rear_y() - rail_front_y(),
      rail_top_z() - rail_bottom_z()
    ]);
}
    if (top_band_right_enabled) {
      _right_wall_top_band_extension();
    }

module _case_positive() {
  union() {
    _case_floor();
    _left_wall();
    if (top_band_extension_enabled) {
      _left_wall_top_band_extension();
    }
    _right_wall();
    _back_wall();
    if (rail_enabled) {
      _back_rail();
    }
    if (divider_enabled) {
      _battery_sbc_divider();
    }
  }
}

// The retention lip is not added geometry: the window cut is tightened by
// lip_width on its leading and trailing edges, so the remaining material forms
// a flush shelf (the lip) in the outer left face plane. No projection.
module _microsd_opening_cut() {
  translate([-boolean_epsilon, microsd_min_y() + (lip_enabled ? lip_width : 0), microsd_min_z()])
    cube([
      wall_thickness + 2 * boolean_epsilon,
      microsd_opening_width - 2 * (lip_enabled ? lip_width : 0),
      microsd_opening_height
    ]);
}

module _battery_exit_cut() {
  translate([-boolean_epsilon, battery_exit_min_y() + (lip_enabled ? lip_width : 0), battery_exit_min_z()])
    cube([
      wall_thickness + 2 * boolean_epsilon,
      battery_exit_width - 2 * (lip_enabled ? lip_width : 0),
      battery_exit_height
    ]);
}

module _fan_air_cut() {
  // Through-bore across the full fan wall (x: right_wall_inner_x()-eps -> case_outer_width()+eps).
  translate([right_wall_inner_x() - boolean_epsilon, fan_center_y, fan_center_z()])
    rotate([0, 90, 0])
      cylinder(d = fan_air_opening_d, h = fan_wall_thickness + 2 * boolean_epsilon, $fn = 96);
}

module _fan_mount_cut() {
  for (hole_y = [fan_center_y - fan_screw_offset(), fan_center_y + fan_screw_offset()])
    for (hole_z = [fan_center_z() - fan_screw_offset(), fan_center_z() + fan_screw_offset()])
      translate([right_wall_inner_x() - boolean_epsilon, hole_y, hole_z])
        rotate([0, 90, 0])
          cylinder(d = fan_mount_hole_d, h = fan_wall_thickness + 2 * boolean_epsilon, $fn = 36);
}

// M3-capable (d6 x 3) BLIND screw-head seats, cut INTO the right wall from the
// internal face (x = right_wall_inner_x()) toward +x, at each of the four fan
// screw positions. Each seat is fan_screw_recess_depth deep, leaving
// (fan_wall_thickness - fan_screw_recess_depth) of solid wall behind the seat
// floor; the d4.2 through-holes (not the seats) carry the screw shanks out
// the outer face to clamp the fan.
module _fan_screw_recess_cut() {
  for (hole_y = [fan_center_y - fan_screw_offset(), fan_center_y + fan_screw_offset()])
    for (hole_z = [fan_center_z() - fan_screw_offset(), fan_center_z() + fan_screw_offset()])
      translate([right_wall_inner_x() - boolean_epsilon, hole_y, hole_z])
        rotate([0, 90, 0])
          cylinder(d = fan_screw_recess_d, h = fan_screw_recess_depth + 2 * boolean_epsilon, $fn = 48);
}

module _fan_interface_cut() {
  union() {
    _fan_air_cut();
    _fan_mount_cut();
    _fan_screw_recess_cut();
  }
}

module micro_cyberdeck_case_body() {
  _assert_case_dimensions();
  difference() {
    _case_positive();
    if (microsd_opening_enabled) {
      _microsd_opening_cut();
    }
    if (battery_exit_enabled) {
      _battery_exit_cut();
    }
    if (fan_enabled) {
      _fan_interface_cut();
    }
  }
}
