// Design configuration with -D overrides (every key in configs/rev_0001.json).
part = is_undef(part) ? "cyberdeck_leaf" : part;
revision = is_undef(revision) ? "rev_0001" : revision;
design_state = is_undef(design_state) ? "stations" : design_state;
rack_spec_version = is_undef(rack_spec_version) ? "ten-inch-rack-m3-printed-design-spec v2.0.0" : rack_spec_version;

case_width = is_undef(case_width) ? 254.0 : case_width;
case_depth_exterior = is_undef(case_depth_exterior) ? 80.0 : case_depth_exterior;
front_wall_t = is_undef(front_wall_t) ? 3.0 : front_wall_t;
rear_wall_t = is_undef(rear_wall_t) ? 3.0 : rear_wall_t;
clear_opening = is_undef(clear_opening) ? 222.25 : clear_opening;
ring_band = is_undef(ring_band) ? 15.875 : ring_band;
shelf_thickness = is_undef(shelf_thickness) ? 3.0 : shelf_thickness;

rack_height_u = is_undef(rack_height_u) ? 5 : rack_height_u;
u_pitch = is_undef(u_pitch) ? 44.45 : u_pitch;
rail_x = is_undef(rail_x) ? 118.2625 : rail_x;
equipment_width_max = is_undef(equipment_width_max) ? 220.0 : equipment_width_max;

rack_passage_d = is_undef(rack_passage_d) ? 3.6 : rack_passage_d;
rack_pocket_d = is_undef(rack_pocket_d) ? 6.816 : rack_pocket_d;
rack_pocket_depth = is_undef(rack_pocket_depth) ? 2.8 : rack_pocket_depth;
rack_land_depth = is_undef(rack_land_depth) ? 5.8 : rack_land_depth;
rack_seat_d = is_undef(rack_seat_d) ? 8.25 : rack_seat_d;
rack_seat_depth = is_undef(rack_seat_depth) ? 0.3 : rack_seat_depth;
washer_od = is_undef(washer_od) ? 7.0 : washer_od;
washer_t = is_undef(washer_t) ? 0.5 : washer_t;

station_recess_d = is_undef(station_recess_d) ? 8.25 : station_recess_d;
station_recess_depth = is_undef(station_recess_depth) ? 3.8 : station_recess_depth;
head_button_d = is_undef(head_button_d) ? 8.25 : head_button_d;
head_button_t = is_undef(head_button_t) ? 3.0 : head_button_t;
head_top_spare = is_undef(head_top_spare) ? 0.3 : head_top_spare;
tongue_slab_len = is_undef(tongue_slab_len) ? 14.0 : tongue_slab_len;
tongue_seat_width = is_undef(tongue_seat_width) ? 10.0 : tongue_seat_width;
tongue_slab_t = is_undef(tongue_slab_t) ? 3.0 : tongue_slab_t;
seam_root_overlap = is_undef(seam_root_overlap) ? 3.0 : seam_root_overlap;
receiver_zone = is_undef(receiver_zone) ? 18.0 : receiver_zone;
socket_len = is_undef(socket_len) ? 15.0 : socket_len;
socket_depth = is_undef(socket_depth) ? 12.0 : socket_depth;
socket_axis_depth = is_undef(socket_axis_depth) ? 3.7 : socket_axis_depth;
seam_fastener_seam_offset = is_undef(seam_fastener_seam_offset) ? 8.0 : seam_fastener_seam_offset;
station_air_gap = is_undef(station_air_gap) ? 0.7 : station_air_gap;
station_receiver_wall = is_undef(station_receiver_wall) ? 5.575 : station_receiver_wall;
nut_pocket_d = is_undef(nut_pocket_d) ? 6.816 : nut_pocket_d;
nut_pocket_depth = is_undef(nut_pocket_depth) ? 2.8 : nut_pocket_depth;
nut_across_flats = is_undef(nut_across_flats) ? 5.9 : nut_across_flats;
nut_thickness = is_undef(nut_thickness) ? 2.4 : nut_thickness;
m3_thread_d = is_undef(m3_thread_d) ? 3.0 : m3_thread_d;
m3_clearance_d = is_undef(m3_clearance_d) ? 3.6 : m3_clearance_d;
m3_screw_len = is_undef(m3_screw_len) ? 12.0 : m3_screw_len;
m3_screw_rejected_len = is_undef(m3_screw_rejected_len) ? 14.0 : m3_screw_rejected_len;

station_tb_y0 = is_undef(station_tb_y0) ? 0.0 : station_tb_y0;
station_tb_y1 = is_undef(station_tb_y1) ? 18.0 : station_tb_y1;
station_tb_y_center = is_undef(station_tb_y_center) ? 9.0 : station_tb_y_center;
station_tb_y0_rear = is_undef(station_tb_y0_rear) ? 62.0 : station_tb_y0_rear;
station_tb_y1_rear = is_undef(station_tb_y1_rear) ? 80.0 : station_tb_y1_rear;
station_tb_y_center_rear = is_undef(station_tb_y_center_rear) ? 71.0 : station_tb_y_center_rear;
station_lr_y0 = is_undef(station_lr_y0) ? 6.0 : station_lr_y0;
station_lr_y1 = is_undef(station_lr_y1) ? 24.0 : station_lr_y1;
station_lr_y_center = is_undef(station_lr_y_center) ? 15.0 : station_lr_y_center;
station_lr_y0_rear = is_undef(station_lr_y0_rear) ? 62.0 : station_lr_y0_rear;
station_lr_y1_rear = is_undef(station_lr_y1_rear) ? 80.0 : station_lr_y1_rear;
station_lr_y_center_rear = is_undef(station_lr_y_center_rear) ? 71.0 : station_lr_y_center_rear;

minimum_wall_thickness = is_undef(minimum_wall_thickness) ? 3.0 : minimum_wall_thickness;
minimum_structural_overlap = is_undef(minimum_structural_overlap) ? 3.0 : minimum_structural_overlap;
minimum_internal_edge_width = is_undef(minimum_internal_edge_width) ? 3.0 : minimum_internal_edge_width;
boolean_epsilon = is_undef(boolean_epsilon) ? 0.02 : boolean_epsilon;
print_bed = is_undef(print_bed) ? 220.0 : print_bed;
print_reserve = is_undef(print_reserve) ? 5.0 : print_reserve;

// Derived datums (product frame: X right, Y back (depth), Z up; front face Y=0).
opening_edge = clear_opening / 2.0;            // 111.125
case_half = case_width / 2.0;                  // 127.0

// Locked five-U hole sequence (one entry per Z position, index 0..14),
// mirrored from the spec copy.
HOLE_Z_5U = [
  -104.775, -88.900, -76.200, -60.325, -44.450, -31.750, -15.875,
  0.000,
  12.700, 28.575, 44.450, 57.150, 73.025, 88.900, 101.600
];

// Shelf band top faces sit exactly on the clear-opening bottom/top edge planes.
shelf_bottom_z1 = -opening_edge;               // -111.125 (top face)
shelf_bottom_z0 = -opening_edge - shelf_thickness; // -114.125
shelf_top_z0 = opening_edge;                   // +111.125 (bottom face)
shelf_top_z1 = opening_edge + shelf_thickness; // +114.125

module blockout_contract_assertions() {
  // Structural floor (host AGENTS.md section 10).
  assert(minimum_wall_thickness >= 3.0, "wall floor 3.0");
  assert(minimum_structural_overlap >= minimum_wall_thickness, "overlap >= wall");
  assert(minimum_internal_edge_width >= minimum_wall_thickness, "edge >= wall");

  // Envelope (interpretation A: 80 mm total exterior depth: 3 + 74 + 3).
  assert(abs(case_depth_exterior - (front_wall_t + 74.0 + rear_wall_t)) < 1e-9,
         "exterior depth must be front + chamber + rear");
  assert(abs(front_wall_t - minimum_wall_thickness) < 1e-9, "front wall at floor");
  assert(abs(rear_wall_t - minimum_wall_thickness) < 1e-9, "rear wall at floor");
  assert(abs(case_width - 254.0) < 1e-9, "5U front width 254.0");

  // Clear opening is exactly 222.25 squared (5 x 44.45).
  assert(abs(clear_opening - 222.25) < 1e-9, "clear opening 222.25");
  assert(abs(opening_edge - 111.125) < 1e-9, "opening half 111.125");

  // Uniform 15.875 ring band on all four sides.
  assert(abs(ring_band - 15.875) < 1e-9, "ring band 15.875");
  assert(abs(case_half - (opening_edge + ring_band)) < 1e-9, "band fills to exterior face");
  assert(abs(case_half - (opening_edge + (station_recess_depth + tongue_slab_t + station_air_gap
         + station_receiver_wall + nut_pocket_depth))) < 1e-9,
         "station radial stack exactly fills the 15.875 band");

  // Split leaves and print bounds (220 mm bed with 5 mm reserve). The slab
  // feet stick out 14.0 past the seam faces they ride: worst-case leaf
  // footprint corner = 127.0 + 14.0 = 141.0 (bottom_left, both axes).
  assert(abs(case_half - 127.0) < 1e-9, "leaf footprint edge 127.0");
  assert(case_half + tongue_slab_len <= print_bed - print_reserve,
         "slab-aware leaf footprint within usable bed (141.0 <= 215.0)");
  assert(case_depth_exterior <= print_bed - print_reserve, "leaf depth within usable bed");

  // M3 hardware fit at the seam stations (head recess 8.25 dia).
  assert(abs(head_button_d - (washer_od + 1.25)) < 1e-9, "head recess overhang 0.625/side");
  assert(abs(station_recess_depth - (head_button_t + washer_t + head_top_spare)) < 1e-9,
         "recess depth = head + washer + spare (3.0 + 0.5 + 0.3 = 3.8)");
  // The screw head base sits on the washer top face at radial 3.3 from the
  // exterior face; the tip is measured axially from there: M3x12 tip = 15.3
  // (0.575 in-band); M3x14 tip = 17.3 (1.425 past the band) -> rejected.
  head_base_radial = station_recess_depth - washer_t; // 3.3
  assert(head_base_radial + m3_screw_len <= ring_band + 1e-9,
         str("M3x", m3_screw_len, " tip stops in-band (15.3 <= 15.875)"));
  assert(head_base_radial + m3_screw_rejected_len > ring_band,
         str("M3x", m3_screw_rejected_len, " rejected (tip exits the 15.875 band)"));

  // Per-hole rack radial material uses the spec helper against the host floor.
  assert_m3_hole_edge(rail_x - opening_edge, rack_pocket_d, minimum_structural_overlap,
                      "rail pocket -> opening edge radial");
  assert_m3_hole_edge(case_half - rail_x, rack_passage_d, minimum_structural_overlap,
                      "rail passage -> exterior face radial");

  // Washer seat: shallower axially loaded face feature; the 2.7 mm remaining
  // behind the 0.3-deep seat is a DECLARED PERMIT, not a structural ligament.
  assert(abs(rack_seat_d - 8.25) < 1e-9, "seat dia (spec M3_WASHER_SEAT_D)");
  assert(abs(rack_seat_depth - 0.3) < 1e-9, "seat depth within v2.0.0 0.2..0.4");
  assert(rack_seat_d >= washer_od, "seat overhangs the ISO 7089 washer");
  assert(abs((front_wall_t - rack_seat_depth) - 2.7) < 1e-9,
         "declared permit: 2.7 behind seat floor");

  // Land is deepened exactly to seat the 2.8-deep chamber-open pocket.
  assert(abs(rack_land_depth - (front_wall_t + rack_pocket_depth)) < 1e-9,
         "land depth 5.8 = face wall + pocket depth");
  assert(rack_land_depth >= rack_pocket_depth + minimum_structural_overlap - 1e-9,
         "land depth >= pocket depth + wall floor (5.8 >= 5.8)");
  assert(abs(rack_pocket_d - nut_pocket_d) < 1e-6, "rack pocket and nut pocket share dia");
  assert(abs(rack_pocket_d - (nut_across_flats / cos(30))) < 5e-3,
         "pocket dia = AF / cos(30) (5.9 -> 6.8147, spec 6.816)");

  // Shelves span the full exterior depth Y in [0, 80] and fuse 3.0 into each
  // wall (two positive-volume supports per shelf). Side butts at
  // X = +/-111.125 are coplanar fuses with the side band (documented
  // non-load-bearing; the wall fusions carry the load path).
  assert(abs(shelf_thickness - minimum_wall_thickness) < 1e-9, "shelf at wall floor");
  assert_min_overlap(0, case_depth_exterior, 0, front_wall_t, minimum_structural_overlap,
                     "shelf -> front wall (3.0)");
  assert_min_overlap(0, case_depth_exterior, case_depth_exterior - rear_wall_t, case_depth_exterior,
                     minimum_structural_overlap, "shelf -> rear wall (3.0)");
  assert(abs((shelf_top_z0 - shelf_bottom_z1) - clear_opening) < 1e-9,
         "shelf inner faces meet the clear-opening edges exactly (222.25)");

  // Five-U hole sequence: cross-check the locked literal list against the
  // spec formula (RACK-GEO-002): Z = -111.125 + (i div 3)*44.45 +
  // U_HOLE_OFFSET_WITHIN[i mod 3], index 0..14 (never 44.45/3: GEO-003).
  // OpenSCAD 2021.01 has no mod/div operators: div -> floor(x / y),
  // mod -> %. The array index must also be a plain variable.
  assert(len(HOLE_Z_5U) == rack_height_u * 3, "30 holes for 5U (15 Z positions x 2 columns)");
  for (i = [0:14]) {
    u_idx = i % 3;
    expected_z = -opening_edge + floor(i / 3) * u_pitch + U_HOLE_OFFSET_WITHIN[u_idx];
    assert(abs(HOLE_Z_5U[i] - expected_z) < 1e-6,
           str("locked hole Z mismatch at index ", i, ": ", HOLE_Z_5U[i], " vs ", expected_z));
  }
  assert(abs(HOLE_Z_5U[7]) < 1e-9, "center hole of center U sits on the Z=0 split plane (straddle)");
  for (i = [0:14]) assert(abs(HOLE_Z_5U[i]) > boolean_epsilon || i == 7,
                          "only the Z=0 hole may be bisected by the split plane");

  // Solid transverse front bands: no hole edge may enter them (solid bands
  // at Z in [111.125, 127.0] and mirror; nearest hole edge clears by > 4.5).
  assert(opening_edge - (abs(HOLE_Z_5U[0]) + rack_passage_d / 2.0) >= minimum_internal_edge_width - 1e-9,
         "lowest hole edge clears the transverse band (4.55 >= 3.0)");
  assert(opening_edge - (abs(HOLE_Z_5U[14]) + rack_passage_d / 2.0) >= minimum_internal_edge_width - 1e-9,
         "highest hole edge clears the transverse band (7.725 >= 3.0)");
}

// Separation of the bottom-row nut pocket from the bottom shelf band. The
// shelf is SOLID material (not a void), so the inter-void ligament floor does
// not apply through it; the gaps are asserted positive (no contact) and the
// X-direction gap additionally meets the structural margin.
bottom_row_pocket_z_low = HOLE_Z_5U[0] - rack_pocket_d / 2.0;   // -108.183
land_x_low_edge = rail_x - rack_pocket_d / 2.0;                 // 114.8545

module shelf_land_separation_assertions() {
  assert(land_x_low_edge - opening_edge >= minimum_structural_overlap - 1e-9,
         str("land X edge clears shelf end (", land_x_low_edge - opening_edge, " >= 3.0)"));
  assert(bottom_row_pocket_z_low - shelf_bottom_z1 > boolean_epsilon,
         str("bottom-row pocket clears shelf band in Z (",
             bottom_row_pocket_z_low - shelf_bottom_z1, ")"));
}

blockout_contract_assertions();
shelf_land_separation_assertions();