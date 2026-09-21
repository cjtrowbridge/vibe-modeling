// Fan guard: a flat plate with a centered circular air opening, held
// standoff_height above the fan face by four M3-bored posts at the fan's four
// corner mounting stations (stud_pitch/2 on each axis).
//
// Coordinate frame (guard local, matching the case's fan interface):
//   - the fan face lies in the z = 0 plane, fan center at the origin in x/y;
//   - the posts run from z = 0 (fan face) up through the plate;
//   - the plate spans z = standoff_height .. standoff_height + plate_thickness;
//   - airflow passes axially through the center opening and radially through
//     the perimeter gap between the fan face (40 mm) and the plate (plate_size).
//
// The posts are kept OUTSIDE the blade circle (fan_blade_d) so the spinning
// tips can never contact the guard; see the blade-clearance asserts below.
// Each post is bored to stud_bore_d (== the case's fan_mount_hole_d) so the
// case's existing M3 fan screws pass through case hole -> fan hole -> post.

// Fan center is the origin in x/y.
function fan_center_x() = 0;
function fan_center_y() = 0;

// Post station offset from the fan center (half the 32 mm pitch).
function stud_offset() = stud_pitch / 2;
function stud_center_r() = sqrt(2) * stud_offset(); // radius of a station from center.
function stud_r_out() = stud_outer_d / 2;
function stud_r_in() = stud_bore_d / 2;
function cutout_r() = center_cutout_d / 2;
// Post outer edge vs the center opening edge (default: 19.6 - 3 - 19 = 0.6 mm).
function stud_opening_clearance() = stud_center_r() - stud_r_out() - cutout_r();

// Post vertical extent: from the fan face (z = 0) through the full plate
// thickness, so the embed into the plate equals plate_thickness and is a
// positive-volume join (asserted >= minimum_structural_overlap).
function stud_top_z() = standoff_height + plate_thickness;
function plate_bottom_z() = standoff_height;
function plate_top_z() = standoff_height + plate_thickness;

// Margin from a post's outer edge to the blade circle (must be positive).
function blade_clearance_actual() = stud_center_r() - stud_r_out() - fan_blade_d / 2;
// Radial clearance from the blade circle to the center opening edge.
function opening_blade_clearance() = (center_cutout_d - fan_blade_d) / 2;
// Material between the outer edge of a screw bore and the nearest plate edge.
function bore_edge_margin() = plate_size / 2 - stud_offset() - stud_r_in();
// Annulus of material around each M3 bore inside a post.
function stud_bore_annulus() = stud_r_out() - stud_r_in();
// Flat ring width between the center opening and the plate edge.
function guard_ring_width() = (plate_size - center_cutout_d) / 2;

module fan_guard() {
  // --- Structural asserts (AGENTS.md section 10) ---
  assert(minimum_structural_overlap >= minimum_wall_thickness,
    "Minimum structural overlap is below the minimum wall thickness.");
  assert(minimum_wall_thickness > 0 && minimum_internal_edge_width > 0,
    "Structural minima must be positive.");
  assert(standoff_height > 0, "Standoff height must be positive.");
  assert(plate_thickness >= minimum_structural_overlap,
    "Post embed (plate thickness) is below the minimum structural overlap.");
  assert(plate_size >= fan_face_d + 2 * minimum_internal_edge_width,
    "Plate does not leave a minimum-width flat ring beyond the fan face.");
  assert(guard_ring_width() >= minimum_internal_edge_width,
    "Guard ring between the center opening and the plate edge is too narrow.");
  // Center opening edge vs the blade circle: with center_cutout_d ==
  // fan_blade_d (38) the opening edge coincides with the blade circle. The
  // posts (outside the opening) and the perimeter ring are what protect the
  // tips, so this is a documented 0 floor.
  assert(opening_blade_clearance() >= 0,
    "Center opening intrudes on the blade circle.");
  // Post outer edge vs the blade circle (default: 19.63 - 3 - 19 = 0.63 mm).
  assert(blade_clearance_actual() >= 0.5,
    "A post touches the blade circle (documented 0.5 mm floor).");
  // Post outer edge vs the center opening edge (default: 19.63 - 3 - 19 = 0.63
  // mm): keeps a post off the opening rim.
  assert(stud_opening_clearance() >= 0.5,
    "A post touches the center opening rim (documented 0.5 mm floor).");
  assert(bore_edge_margin() >= minimum_internal_edge_width,
    "Screw bore leaves too little material to the plate edge.");
  // Documented relaxation (same pattern as the micro_cyberdeck_case fan-wall
  // ligament exceptions): the M3 bore annulus inside a post is constrained by
  // the blade circle; at 32 mm pitch a >= 3 mm annulus would put the post
  // inside the blade circle, so it is asserted at a documented 0.8 mm floor.
  assert(stud_bore_annulus() >= 0.8,
    "Post bore annulus is below the documented 0.8 mm floor for an M3 standoff.");
  assert(stud_bore_d > 0 && stud_outer_d > stud_bore_d,
    "Stud bore dimensions are invalid.");

  // --- Geometry ---
  difference() {
    union() {
      // Guard plate (flat air guard), centered on the fan. The x/y position is
      // set explicitly by translate (this OpenSCAD build ignores the vector
      // center=[...] form), spanning [-plate_size/2, plate_size/2] in x/y.
      translate([-plate_size / 2, -plate_size / 2, plate_bottom_z()])
        cube([plate_size, plate_size, plate_thickness]);
      // Four standoff posts at the fan corner stations, running from the fan
      // face through the full plate thickness (positive-volume join).
      for (px = [-1, 1])
        for (py = [-1, 1])
          translate([px * stud_offset(), py * stud_offset(), 0])
            cylinder(d = stud_outer_d, h = stud_top_z(), $fn = 48);
    }
    // Center air opening through the plate (and the post crescents it trims).
    translate([fan_center_x(), fan_center_y(), -boolean_epsilon])
      cylinder(d = center_cutout_d, h = stud_top_z() + 2 * boolean_epsilon, $fn = 96);
    // M3 screw bores through each post and the plate.
    for (px = [-1, 1])
      for (py = [-1, 1])
        translate([px * stud_offset(), py * stud_offset(), -boolean_epsilon])
          cylinder(d = stud_bore_d, h = stud_top_z() + 2 * boolean_epsilon, $fn = 36);
  }
}
