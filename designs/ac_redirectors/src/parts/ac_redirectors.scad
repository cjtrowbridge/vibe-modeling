function _arc_inner_point(theta) = [
  turn_inner_radius * sin(theta),
  wall_thickness
    + turn_inner_radius
    - turn_inner_radius * cos(theta)
];

function _arc_outer_point(theta) = [
  (turn_inner_radius + wall_thickness) * sin(theta),
  wall_thickness
    + turn_inner_radius
    - (turn_inner_radius + wall_thickness) * cos(theta)
];

function _turn_shell_profile() = concat(
  [
    for (theta = [0 : profile_arc_step : 90])
      _arc_inner_point(theta)
  ],
  [
    for (theta = [90 : -profile_arc_step : 0])
      _arc_outer_point(theta)
  ]
);

function _bed_duct_lower_start_x() =
  -piece_width / 2;

function _bed_duct_lower_x(index) =
  _bed_duct_lower_start_x() + index * bed_duct_width;

module _extrude_yz_profile(points, x_start, width) {
  translate([x_start, 0, 0])
    rotate([0, 90, 0])
      linear_extrude(height = width, convexity = 10)
        polygon(points = [
          for (point = points) [-point[1], point[0]]
        ]);
}

module _validate_redirector_parameters() {
  assert(
    minimum_structural_overlap >= minimum_wall_thickness,
    "Structural overlap must be at least the minimum wall thickness."
  );
  assert(
    minimum_internal_edge_width >= minimum_wall_thickness,
    "Internal material widths must meet the minimum wall thickness."
  );
  assert(
    wall_thickness >= minimum_wall_thickness,
    "Scoop and guide walls are below the structural minimum."
  );
  assert(
    end_wall_thickness >= minimum_internal_edge_width,
    "End walls are below the minimum internal edge width."
  );
  assert(
    scoop_end_wall_overlap >= minimum_structural_overlap,
    "Scoop-to-end-wall overlap is insufficient."
  );
  assert(
    end_wall_mounting_wall_overlap
      >= minimum_structural_overlap,
    "End-wall-to-mounting-wall overlap is insufficient."
  );
  assert(
    spine_mounting_wall_overlap
      >= minimum_structural_overlap,
    "Alignment-spine-to-mounting-wall overlap is insufficient."
  );
  assert(
    hook_spine_overlap >= minimum_structural_overlap,
    "Hook-to-spine overlap is insufficient."
  );
  assert(
    door_guide_scoop_overlap >= minimum_structural_overlap,
    "Door guide does not engage the scoop sufficiently."
  );
  assert(
    bed_root_scoop_overlap >= minimum_structural_overlap,
    "Bed guide root does not engage the scoop sufficiently."
  );
  assert(
    bed_vane_root_overlap >= minimum_structural_overlap,
    "Bed vane root is below the required engagement."
  );
  assert(
    bed_lower_end_wall_duct_overlap
      >= minimum_structural_overlap,
    "Bed duct side walls do not engage the lower end walls sufficiently."
  );
  assert(
    top_duct_corner_overlap >= minimum_structural_overlap,
    "Top-duct wall corner overlap is insufficient."
  );
  assert(
    top_duct_root_shell_overlap >= minimum_structural_overlap,
    "Top-duct root does not engulf the scoop terminal sufficiently."
  );
  assert(
    hook_band_width >= 2 * minimum_internal_edge_width,
    "Hook bands need adequate width around their joined end walls."
  );
  assert(
    hook_footprint_min_x + numeric_tolerance
        >= -piece_width / 2
      && hook_footprint_max_x
        <= piece_width / 2 + numeric_tolerance,
    "Hook bands must remain inside the main base footprint."
  );
  assert(
    hook_engagement >= minimum_structural_overlap,
    "Hook engagement is below the structural minimum."
  );
  assert(
    hook_usable_rail_depth >= rail_depth + hook_clearance,
    "Hook does not provide the requested rail depth and clearance."
  );
  assert(
    hook_total_rearward_reach
      >= rail_face_setback
        + rail_depth
        + rail_thickness
        + hook_clearance
        + wall_thickness,
    "Hook does not reach behind the measured rail location."
  );
  assert(
    hook_vertical_clearance + numeric_tolerance
      >= hook_clearance,
    "Hook bridge does not clear the rail top."
  );
  assert(
    hook_rear_clearance + numeric_tolerance
      >= hook_clearance,
    "Hook rear drop does not clear the reversed rail lip."
  );
  assert(
    ac_inlet_clear_height >= outlet_height,
    "Top-duct walls constrict the AC-facing inlet height."
  );
  assert(
    hook_top_above_ac_inlet >= minimum_internal_edge_width,
    "Hook top is too close vertically to the AC-facing inlet."
  );
  assert(
    door_hook_bridge_height >= minimum_internal_edge_width,
    "Door-side hook bridge is below the minimum material thickness."
  );
  assert(
    abs(door_hook_bridge_top_z - door_top_z) <= numeric_tolerance,
    "Door-side hook top must be flush with the duct top."
  );
  assert(
    hook_clearance > 0,
    "Hook fit clearance must be positive."
  );
  assert(
    profile_arc_step > 0 && 90 % profile_arc_step == 0,
    "profile_arc_step must divide the 90-degree turn."
  );
  assert(
    bed_duct_count >= 1,
    "At least one bed-side duct is required."
  );
  assert(
    bed_yaw_sign == -1 || bed_yaw_sign == 1,
    "bed_yaw_sign must be -1 or 1."
  );
  assert(
    bed_duct_width >= 2 * minimum_internal_edge_width,
    "Bed-side ducts are too narrow for their structural walls."
  );
  assert(
    bed_sweep_height > 0
      && bed_vertical_rise >= 0,
    "Bed-side vertical and swept rises must be nonnegative."
  );
  assert(
    abs(
      bed_duct_count * bed_duct_width
        - piece_width
    ) <= numeric_tolerance,
    "Bed-side ducts must cover the complete intake width."
  );
  assert(
    total_outlet_width
      >= 2 * piece_width + center_gap,
    "Piece widths and center gap exceed the measured outlet width."
  );
  assert(
    installed_size_x <= maximum_print_dimension
      && installed_size_y <= maximum_print_dimension
      && installed_size_z <= maximum_print_dimension,
    str(
      "Installed-orientation envelope exceeds build volume: ",
      installed_size_x, " x ",
      installed_size_y, " x ",
      installed_size_z
    )
  );
}

module _quarter_turn_shell() {
  _extrude_yz_profile(
    _turn_shell_profile(),
    -piece_width / 2,
    piece_width
  );
}

module _end_wall(x_start, bridge_top_z = hook_bridge_top_z) {
  _extrude_yz_profile(
    [
      [0, 0],
      [turn_front_y, 0],
      [turn_front_y, side_wall_top_z],
      [0, bridge_top_z]
    ],
    x_start,
    end_wall_thickness
  );
}

module _lower_end_wall(x_start) {
  _extrude_yz_profile(
    [
      [0, 0],
      [turn_front_y, 0],
      [turn_front_y, turn_end_z],
      [0, turn_end_z]
    ],
    x_start,
    end_wall_thickness
  );
}

module _hook_band(x_start, bridge_top_z = hook_bridge_top_z) {
  bridge_y_size = hook_bridge_front_y - hook_back_y;

  union() {
    translate([
      x_start,
      hook_back_y,
      hook_bridge_bottom_z
    ])
      cube([
        hook_band_width,
        bridge_y_size,
        bridge_top_z - hook_bridge_bottom_z
      ]);

    translate([
      x_start,
      hook_back_y,
      hook_drop_bottom_z
    ])
      cube([
        hook_band_width,
        wall_thickness,
        bridge_top_z - hook_drop_bottom_z
      ]);
  }
}

module _mounting_structure(
  bridge_top_z = hook_bridge_top_z,
  include_alignment_spine = true,
  full_height_end_walls = true
) {
  // End walls deliberately overlap the full scoop cross-section within their
  // x bands. The hook bridges overlap those same walls by a full wall depth.
  if (full_height_end_walls) {
    _end_wall(-piece_width / 2, bridge_top_z);
    _end_wall(
      piece_width / 2 - end_wall_thickness,
      bridge_top_z
    );
  } else {
    // The bed-side ducts sweep laterally, so stationary upper end walls would
    // bisect the outer ducts. Seal only the quarter-turn foundation here; the
    // swept ducts' own side walls continue upward with the airflow.
    _lower_end_wall(-piece_width / 2);
    _lower_end_wall(
      piece_width / 2 - end_wall_thickness
    );
  }

  _hook_band(
    left_hook_x,
    bridge_top_z
  );
  _hook_band(
    right_hook_x,
    bridge_top_z
  );

  if (include_alignment_spine) {
    // The door-side spine merges into its continuous back wall. It is omitted
    // from the bed-side part so no isolated strip crosses the swept outlets.
    translate([
      -piece_width / 2,
      alignment_spine_back_y,
      hook_bridge_bottom_z
    ])
      cube([
        piece_width,
        alignment_spine_depth,
        wall_thickness
      ]);
  }
}

module _common_foundation(
  bridge_top_z = hook_bridge_top_z,
  include_alignment_spine = true,
  full_height_end_walls = true
) {
  union() {
    _quarter_turn_shell();
    _mounting_structure(
      bridge_top_z,
      include_alignment_spine,
      full_height_end_walls
    );
  }
}

module _top_duct_root() {
  // This block surrounds the quarter-turn's terminal radial wall, ensuring
  // that the top ducts have positive-volume structural engagement instead of
  // meeting the curved shell at a finished face.
  translate([
    -piece_width / 2,
    turn_inner_radius - top_duct_root_shell_overlap,
    turn_end_z - top_duct_root_shell_overlap
  ])
    cube([
      piece_width,
      wall_thickness + top_duct_root_shell_overlap,
      wall_thickness + top_duct_root_shell_overlap
    ]);
}

module _bed_continuous_mounting_wall() {
  root_z = turn_end_z - bed_root_scoop_overlap;

  // This AC-side wall fills the former gap below the alignment spine. It
  // overlaps the duct roots, both end walls, and the full hook spine so the
  // bed-side hooks and duct backs form one continuous structural wall.
  translate([
    -piece_width / 2,
    mounting_wall_back_y,
    root_z
  ])
    cube([
      piece_width,
      mounting_wall_depth,
      hook_bridge_top_z - root_z
    ]);
}

module _door_vertical_guide() {
  root_z = turn_end_z - door_guide_scoop_overlap;
  wall_height = top_duct_height + door_guide_scoop_overlap;

  union() {
    _top_duct_root();

    // Back and front walls enclose the full 50 mm-deep vertical flow path.
    translate([
      -piece_width / 2,
      mounting_wall_back_y,
      ac_inlet_top_z
    ])
      cube([
        piece_width,
        mounting_wall_depth,
        top_duct_height
      ]);

    translate([
      -piece_width / 2,
      turn_inner_radius,
      root_z
    ])
      cube([piece_width, wall_thickness, wall_height]);

    // Both side walls overlap the front and back walls at full thickness.
    translate([-piece_width / 2, 0, root_z])
      cube([
        wall_thickness,
        turn_front_y,
        wall_height
      ]);

    translate([
      piece_width / 2 - wall_thickness,
      0,
      root_z
    ])
      cube([
        wall_thickness,
        turn_front_y,
        wall_height
      ]);
  }
}

module _bed_swept_duct(index) {
  lower_x = _bed_duct_lower_x(index);
  upper_x = lower_x + bed_yaw_sign * bed_vane_shift;
  root_z = turn_end_z - bed_root_scoop_overlap;
  knee_z = root_z + bed_vertical_rise;
  upper_z = root_z + top_duct_height;
  duct_depth = turn_front_y;
  raw_upper_x =
    upper_x
    + bed_yaw_sign * bed_outlet_cut_extension;
  raw_upper_z =
    upper_z + bed_outlet_cut_extension;
  outlet_center_x = upper_x + bed_duct_width / 2;
  outlet_center_z = turn_end_z + top_duct_height;

  intersection() {
    union() {
      // Extend the raw swept walls past the outlet datum. The final
      // intersection trims all four walls perpendicular to the duct axis.
      hull() {
        translate([lower_x, 0, root_z])
          cube([wall_thickness, duct_depth, wall_thickness]);
        translate([lower_x, 0, knee_z])
          cube([wall_thickness, duct_depth, wall_thickness]);
      }

      hull() {
        translate([lower_x, 0, knee_z])
          cube([wall_thickness, duct_depth, wall_thickness]);
        translate([raw_upper_x, 0, raw_upper_z])
          cube([wall_thickness, duct_depth, wall_thickness]);
      }

      hull() {
        translate([
          lower_x + bed_duct_width - wall_thickness,
          0,
          root_z
        ])
          cube([wall_thickness, duct_depth, wall_thickness]);
        translate([
          lower_x + bed_duct_width - wall_thickness,
          0,
          knee_z
        ])
          cube([wall_thickness, duct_depth, wall_thickness]);
      }

      hull() {
        translate([
          lower_x + bed_duct_width - wall_thickness,
          0,
          knee_z
        ])
          cube([wall_thickness, duct_depth, wall_thickness]);
        translate([
          raw_upper_x + bed_duct_width - wall_thickness,
          0,
          raw_upper_z
        ])
          cube([wall_thickness, duct_depth, wall_thickness]);
      }

      // Preserve the full 50 mm AC-facing inlet height.
      hull() {
        translate([lower_x, 0, ac_inlet_top_z])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
        translate([lower_x, 0, knee_z])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
      }

      hull() {
        translate([lower_x, 0, knee_z])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
        translate([
          raw_upper_x,
          0,
          raw_upper_z + bed_root_scoop_overlap
        ])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
      }

      hull() {
        translate([
          lower_x,
          duct_depth - wall_thickness,
          root_z
        ])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
        translate([
          lower_x,
          duct_depth - wall_thickness,
          knee_z
        ])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
      }

      hull() {
        translate([
          lower_x,
          duct_depth - wall_thickness,
          knee_z
        ])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
        translate([
          raw_upper_x,
          duct_depth - wall_thickness,
          raw_upper_z
        ])
          cube([bed_duct_width, wall_thickness, wall_thickness]);
      }
    }

    _bed_perpendicular_outlet_halfspace(
      outlet_center_x,
      outlet_center_z,
      duct_depth,
      lower_x,
      raw_upper_x,
      root_z
    );
  }
}

module _bed_perpendicular_outlet_halfspace(
  center_x,
  center_z,
  duct_depth,
  lower_x,
  raw_upper_x,
  root_z
) {
  min_x =
    min(lower_x, raw_upper_x)
    - 2 * bed_duct_width;
  max_x =
    max(
      lower_x + bed_duct_width,
      raw_upper_x + bed_duct_width
    )
    + 2 * bed_duct_width;
  min_z = root_z - wall_thickness;
  floor_intersection_x =
    center_x
    + (center_z - min_z) / bed_yaw_sign;
  min_x_plane_z =
    center_z
    - bed_yaw_sign * (min_x - center_x);
  max_x_plane_z =
    center_z
    - bed_yaw_sign * (max_x - center_x);

  // sign * (x - center_x) + (z - center_z) = 0 describes an
  // outlet plane normal to the swept duct centerline. The floor intersection
  // closes the clipping polygon before the plane drops below min_z; extending
  // a four-corner polygon past that crossing creates a self-intersection that
  // OpenCSG previews but CGAL drops during STL export.
  translate([0, duct_depth + 1, 0])
    rotate([90, 0, 0])
      linear_extrude(height = duct_depth + 2, convexity = 10)
        polygon(
          points =
            bed_yaw_sign < 0
              ? [
                  [floor_intersection_x, min_z],
                  [max_x, min_z],
                  [max_x, max_x_plane_z]
                ]
              : [
                  [min_x, min_z],
                  [floor_intersection_x, min_z],
                  [min_x, min_x_plane_z]
                ]
        );
}

module door_side_redirector() {
  _validate_redirector_parameters();

  union() {
    _common_foundation(door_hook_bridge_top_z);
    _door_vertical_guide();
  }
}

module bed_side_redirector() {
  _validate_redirector_parameters();

  union() {
    _common_foundation(
      hook_bridge_top_z,
      true,
      false
    );
    _top_duct_root();
    _bed_continuous_mounting_wall();

    for (index = [0 : bed_duct_count - 1]) {
      _bed_swept_duct(index);
    }
  }
}

module ac_redirectors_preview() {
  // Installed-coordinate fit preview against the measured reference mockup.
  color("gainsboro", 0.55)
    ac_vent_rail_mockup();

  color("lightsteelblue")
    translate([
      (piece_width + center_gap) / 2,
      0,
      0
    ])
      door_side_redirector();

  color("palegreen")
    translate([
      -(piece_width + center_gap) / 2,
      0,
      0
    ])
      bed_side_redirector();
}
