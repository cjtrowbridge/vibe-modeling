// Single-piece rectangular case with an open top and no front wall.

function case_outer_width() = interior_width + 2 * wall_thickness;
function case_outer_depth() = interior_depth + 2 * wall_thickness;
function case_outer_height() = interior_height + floor_thickness;
function back_wall_y() = wall_thickness + interior_depth;
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
  translate([case_outer_width() - wall_thickness, 0, 0])
    cube([wall_thickness, case_outer_depth(), case_outer_height()]);
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

module _case_positive() {
  union() {
    _case_floor();
    _left_wall();
    _right_wall();
    _back_wall();
    if (divider_enabled) {
      _battery_sbc_divider();
    }
  }
}

module _microsd_opening_cut() {
  translate([-boolean_epsilon, microsd_min_y(), microsd_min_z()])
    cube([
      wall_thickness + 2 * boolean_epsilon,
      microsd_opening_width,
      microsd_opening_height
    ]);
}

module micro_cyberdeck_case_body() {
  _assert_case_dimensions();
  difference() {
    _case_positive();
    if (microsd_opening_enabled) {
      _microsd_opening_cut();
    }
  }
}
