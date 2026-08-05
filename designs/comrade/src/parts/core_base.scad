// Single-piece Comrade core base plate.
// Inner holes receive upward-installed M3 screws from the underside.
// Outer holes receive downward-installed M3 screws from the top side.

function plate_x() = inner_mount_spacing_x + 2 * plate_extension;
function plate_y() = inner_mount_spacing_y + 2 * plate_extension;
function inner_mount_points() = [
  [0, 0],
  [inner_mount_spacing_x, 0],
  [0, inner_mount_spacing_y],
  [inner_mount_spacing_x, inner_mount_spacing_y]
];
function outer_mount_points() = [
  [outer_hole_inset - plate_extension, outer_hole_inset - plate_extension],
  [inner_mount_spacing_x + plate_extension - outer_hole_inset, outer_hole_inset - plate_extension],
  [outer_hole_inset - plate_extension, inner_mount_spacing_y + plate_extension - outer_hole_inset],
  [inner_mount_spacing_x + plate_extension - outer_hole_inset, inner_mount_spacing_y + plate_extension - outer_hole_inset]
];

function point_distance(a, b) = sqrt(pow(a[0] - b[0], 2) + pow(a[1] - b[1], 2));
function inner_to_outer_corner_distance() = point_distance(inner_mount_points()[0], outer_mount_points()[0]);
function outer_counterbore_edge_margin() = outer_hole_inset - counterbore_d / 2;
function opposing_counterbore_projected_ligament() = inner_to_outer_corner_distance() - counterbore_d;
function counterbore_remaining_floor() = plate_thickness - counterbore_depth;

module _assert_dimensions() {
  assert(inner_mount_spacing_x > 0 && inner_mount_spacing_y > 0,
    "Inner mounting spacing must be positive.");
  assert(plate_extension > 0 && plate_thickness > 0,
    "Plate extension and thickness must be positive.");
  assert(m3_clearance_d > 3.0 && counterbore_d > m3_clearance_d,
    "M3 clearance and counterbore diameters are invalid.");
  assert(counterbore_depth > 0 && counterbore_depth < plate_thickness,
    "Counterbore depth must leave a floor in the base.");
  assert(minimum_structural_overlap >= minimum_wall_thickness,
    "Structural overlap must be at least the minimum wall thickness.");
  assert(minimum_internal_edge_width >= minimum_wall_thickness,
    "Internal edges and material strips must be at least the minimum wall thickness.");
  assert(counterbore_remaining_floor() >= minimum_wall_thickness,
    "Counterbores leave less than the required remaining floor thickness.");
  assert(outer_counterbore_edge_margin() >= minimum_internal_edge_width,
    "Outer counterbores leave too little material to the plate edge.");
  assert(opposing_counterbore_projected_ligament() >= minimum_internal_edge_width,
    "Opposing-side inner and outer counterbores leave too little projected ligament.");
}

module _plate_positive() {
  translate([-plate_extension, -plate_extension, 0])
    cube([plate_x(), plate_y(), plate_thickness]);
}

module _inner_mount_cuts() {
  for (p = inner_mount_points()) {
    translate([p[0], p[1], -0.01])
      cylinder(d = m3_clearance_d, h = plate_thickness + 0.02, $fn = 48);
    // Recess faces downward for screws installed upward into stack standoffs.
    translate([p[0], p[1], -0.01])
      cylinder(d = counterbore_d, h = counterbore_depth + 0.01, $fn = 64);
  }
}

module _outer_mount_cuts() {
  for (p = outer_mount_points()) {
    translate([p[0], p[1], -0.01])
      cylinder(d = m3_clearance_d, h = plate_thickness + 0.02, $fn = 48);
    // Recess faces upward for future attachments installed downward.
    translate([p[0], p[1], plate_thickness - counterbore_depth])
      cylinder(d = counterbore_d, h = counterbore_depth + 0.01, $fn = 64);
  }
}

module comrade_core_base() {
  _assert_dimensions();
  difference() {
    _plate_positive();
    _inner_mount_cuts();
    _outer_mount_cuts();
  }
}
