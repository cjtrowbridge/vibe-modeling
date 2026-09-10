// Structural core of the cyberdeck-2 enclosure (pre-split), in the unrotated
// product frame. Product frame: X right, Y back (depth, 0..80), Z up;
// front face at Y = 0.
//
// Body model (plan work item 2.1): six-wall box, 3.0 mm walls everywhere,
// fully enclosed on all sides except the 222.25 squared opening in the front
// plate. The enclosed chamber is X/Z +/-124, Y 3..77 (74.0 deep). The two
// rack rail columns at X = +/-118.2625 pierce the front plate; at each hole
// the wall is locally thickened to a 5.8-deep land (3.0 face + 2.8-deep
// 6.816 circumscribed dia chamber-open hex-nut pocket) so the capture nut is
// insertable from inside the chamber (plan section 1.5).
//
// All Boolean work stays in the unrotated frame; the print transform is
// applied only in the leaf *_print() wrappers, so small cylindrical cuts
// never run in a rotated coordinate frame (CGAL practice).

// Exterior 254 x 80 x 254 box (Y in [0, 80]).
module enclosure_outer_box() {
  translate([0, case_depth_exterior / 2.0, 0])
    cube([case_width, case_depth_exterior, case_width], center = true);
}

// Enclosed interior chamber (3.0 walls all around): X,Z +/-124; Y 3..77.
module interior_cavity() {
  translate([0, (front_wall_t + case_depth_exterior - rear_wall_t) / 2.0, 0])
    cube([case_width - 2.0 * minimum_wall_thickness,
          case_depth_exterior - front_wall_t - rear_wall_t,
          case_width - 2.0 * minimum_wall_thickness], center = true);
}

// 222.25 squared opening cut through the front plate only: Y from -0.05
// (past the exterior face) to 3.05 (0.05 past the chamber face), leaving the
// 15.875 ring band (the front rails/bezel) intact around it.
module opening_passage() {
  translate([0, (front_wall_t - 0.05) / 2.0, 0])
    cube([clear_opening, front_wall_t + 0.1, clear_opening], center = true);
}

// Two continuous equipment shelves (plan section 1.5), 3.0 thick, spanning
// the full exterior depth Y 0..80. The bottom shelf top face sits exactly on
// the equipment bottom datum Z = -111.125 (flush with the opening bottom
// edge plane); the top shelf is its mirror. Each shelf fuses 3.0 into the
// front plate (Y 0..3) and 3.0 into the rear plate (Y 77..80): two verified
// positive-volume supports per shelf (AGENTS.md section 10). The side ends
// at X = +/-111.125 face chamber space; the declared weight path is
// shelf -> front/rear plate fusions (side ends carry no declared load).
// Full 80.0 span (supersedes the plan's "Y in [0, 77]" wording, a
// coplanar-zero-volume contact with the rear plate that would fail the
// section 10 overlap rule).
module shelves() {
  union() {
    translate([0, case_depth_exterior / 2.0, (shelf_bottom_z0 + shelf_bottom_z1) / 2.0])
      cube([clear_opening, case_depth_exterior, shelf_thickness], center = true);
    translate([0, case_depth_exterior / 2.0, (shelf_top_z0 + shelf_top_z1) / 2.0])
      cube([clear_opening, case_depth_exterior, shelf_thickness], center = true);
  }
}

// Rack mounting hardware cut set: 30 stations, 15 per rail column at
// X = +/-118.2625 (RAIL_HOLE_SPACING_X = 236.525). Per station:
//   - 3.6-dia passage through the 3.0 front wall (coarse M3 clearance);
//   - 8.25-dia x 0.3 printed washer seat in the exterior face (v2.0.0
//     allowance 0.2..0.4; DECLARED PERMIT: 2.7 remaining behind the floor,
//     a shallow axially-loaded face feature, not a structural ligament);
//   - 6.816-dia x 2.8 chamber-open hex-nut pocket that DEEPENS the front
//     wall to a local 5.8 land; the M3x0.5 screw head seats on the ISO 7089
//     washer at the pocket floor (Y = 5.8). No countersinks (RACK-SCOPE-005).
// Cuts carry a 0.05-0.1 overhang so they never land exactly on a face plane.
module rack_hole_cuts() {
  for (col = [-1, 1]) {
    col_x = col * rail_x;
    for (i = [0:14]) {
      hz = HOLE_Z_5U[i];
      // Passage through the front wall (Y -0.05..3.05).
      translate([col_x, front_wall_t / 2.0, hz])
        rotate([90, 0, 0])
          cylinder(d = rack_passage_d, h = front_wall_t + 0.1, center = true);
      // Printed washer seat in the exterior face (Y -0.05..0.35).
      translate([col_x, rack_seat_depth / 2.0 - 0.05, hz])
        rotate([90, 0, 0])
          cylinder(d = rack_seat_d, h = rack_seat_depth + 0.1, center = true);
      // Nut pocket deepening the wall to the 5.8 land (Y 2.95..5.85).
      translate([col_x, (front_wall_t + rack_land_depth) / 2.0, hz])
        rotate([90, 0, 0])
          cylinder(d = rack_pocket_d, h = rack_pocket_depth + 0.1, center = true);
    }
  }
}

// Complete unsplit enclosure (plan work item 2.1): six-wall box minus
// chamber, minus front opening, minus rack hardware cuts, plus shelves.
module shell_body() {
  difference() {
    union() {
      enclosure_outer_box();
      shelves();
    }
    interior_cavity();
    opening_passage();
    rack_hole_cuts();
  }
}

// Unsplit product entry point. Ownership of the seam-station geometry
// (plan 3.2): this master union is the 8 pad blocks (root zone + receiver
// zone, both sides of each seam) minus the 8 receiver-side cut stacks
// (socket, head recess, through passage, nut pocket). The tongue slabs are
// NOT in the master: they are unioned into their owner leaves AFTER the
// leaf quadrant intersection, and the 8 slab bore cuts are subtracted
// per-owner inside the leaf bodies, so each printed part is one manifold
// piece and every structural join survives the split (see seam_station.scad).
module enclosure_final() {
  difference() {
    union() {
      shell_body();
      seam_station_pads_all();
    }
    seam_station_cuts_all();
  }
}