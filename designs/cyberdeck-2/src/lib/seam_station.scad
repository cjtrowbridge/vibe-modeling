// M3 captive-nut registration seam stations (shared module family).
//
// Reference contract:
//   references/engineering/fasteners/m3_captive_nut_registration_seam_stations.md
//   (module names per its implementation outline; hardware per its declaration)
//
// Hardware (canonical values in configs/rev_0001.json):
//   screw  M3 x 0.5 button head, head 8.25 dia x 3.0, 12.0 long (x14 rejected)
//   nut    captive hex, 5.9 across flats x 2.4 (pocket 6.816 = AF / cos 30)
//   washer ISO 7089, 7.0 dia x 0.5
// Stack at the axis (radial, exterior face -> opening edge):
//   recess 3.8 (head 3.0 + washer 0.5 + spare 0.3; head top 0.3 below face)
//   + tongue slab 3.0 + air gap 0.7 + receiver wall 5.575 + nut pocket 2.8
//   = 15.875 (the ring band, exact). Clamp path: head -> washer -> slab face
//   (tongue leaf) -> shank -> nut -> pocket floor (receiver leaf); reactions
//   land on opposite leaves.
//
// Layout (plan section 1.3, re-locked 2026-09-09, end-aligned to the case
// ends per user direction "the tabs should be touching top and bottom" -
// rear pairs flush against the rear face, front pairs pushed to the closest
// rail-safe window; the tb pairs already sit at the front and rear ends):
//   top_front    tb  pad y [0,18]   axis_y  9   receiver top_right
//   top_rear     tb  pad y [62,80]  axis_y 71   receiver top_right
//   bottom_front tb  pad y [0,18]   axis_y  9   receiver bottom_right
//   bottom_rear  tb  pad y [62,80]  axis_y 71   receiver bottom_right
//   left_front   lr  pad y [6,24]   axis_y 15   receiver top_left
//   left_rear    lr  pad y [62,80]  axis_y 71   receiver top_left
//   right_front  lr  pad y [6,24]   axis_y 15   receiver top_right
//   right_rear   lr  pad y [62,80]  axis_y 71   receiver top_right
// (tb = seam plane X = 0, radial along Z; lr = seam plane Z = 0, radial
//  along X; owner rule: receiver = leaf at the + side of its seam plane.)
//
// Coordinate sets
//   Local station frame (primitives below + coupon):
//     u = insertion, 0 at the receiver seam mouth face, + into the receiver
//     v = pad-depth (transverse), 0 at the pad front edge, span 18.0
//     w = radial (fastener axis), 0 at the exterior face, + toward the
//         clear-opening edge (w = 15.875 = ring_band at the opening edge)
//   Product frame (unrotated; ALL Boolean cuts run here, CGAL practice):
//     tb: product (x, y, z) = (u, v, q * (case_half - w)), q = +1 top band,
//         q = -1 bottom band
//     lr: product (x, y, z) = (sx * (case_half - w), v, u), sx = +1 right
//         band (face X = +127), sx = -1 left band (face X = -127)
//
// Per-station membership (plan 3.2):
//   master owns     8 pads + 8 receiver cut sets (pads_all / cuts_all)
//   tongue leaf owns slab + slab passage only (per-leaf slab modules,
//     unioned / cut after the quadrant intersection; the slab is NOT in
//     the master)
//   the slab spans its station's seam plane with a 3.0 positive-volume
//     fuse into the pad root on its own leaf's side (u -3..0) and a 11.0
//     reach into the socket on the receiver's side (u 0..11); the socket
//     IS the sliding channel for that reach (1.0 per side, 4.0 at the
//     tip, 0.7 ceiling = the air gap; floor flush with the slab bottom).
//     The slab's own-leaf portion and the receiver leaf's socket do not
//     interpenetrate - they only meet across the seam plane, and the
//     printed parts therefore only ever touch face-to-face.
//   all slab boxes stay inside the tongue leaf's own quadrants' offset
//   direction, so print placements are unchanged by the stations (plan 4.2)
//
// Cut-overhang scheme (plan 3.2): every stacked receiver cut nests 0.05 into
// its neighbour (recess top past the socket floor, passage ends past both
// floors) and the two face-boundary cuts overhang their faces by 0.05
// (recess past the exterior face, pocket past the chamber-side face); the
// overhangs are clipped away by the leaf quadrant intersections. Face planes
// must never lie exactly on a cut boundary (CGAL practice, plan section 2).
//
// OpenSCAD 2021.01 notes: no mod/div operators (% and floor() instead);
// compound expressions are not valid as array indices (plain variables
// only); assertion helpers must be MODULES (a bare user-function call as a
// statement is parsed as an unknown module and silently skipped).

// ---- Local station primitives (local u/v/w frame) ------------------------

// Station pad block: full 15.875 radial band. u0 < 0 marks the tongue-side
// root zone (seam_root_overlap 3.0) that fuses the pad to the tongue leaf;
// v is the 18.0 pad-depth span. (Product placements build their cubes
// directly; this local form is used by the coupon.)
module station_pad(u0, v0, u1, v1) {
  translate([u0, v0, 0.0])
    cube([u1 - u0, v1 - v0, ring_band], center = false);
}

// Registration tongue: the slab local primitive, 14.0 long. Default start
// u0 = -3.0: 3.0 of positive volume fuses it to the pad root on the
// tongue-leaf side (u -3..0, the structural anchor, reference-doc floor),
// the rest rides in the socket on the receiver side (u 0..11) where the
// washer annulus under the M3 head bears on its w = 3.8 top face.
module registration_tongue(u0, v_center = 9.0) {
  u0 = is_undef(u0) ? -seam_root_overlap : u0;
  translate([u0, v_center - tongue_seat_width / 2.0, station_recess_depth])
    cube([tongue_slab_len, tongue_seat_width, tongue_slab_t], center = false);
}

// Receiver socket: the deliberate single lateral insertion slot. Mouth
// exactly at u = 0 (the seam face - NO overhang on the mouth face), closed
// end at socket_len (15.0, a 3.0 ligament to the pad back face); w from the
// recess floor (3.8) up socket_axis_depth (3.7), leaving the 0.7 air gap
// between the slab top (6.8) and the socket ceiling (7.5).
module receiver_socket(u_mouth = 0.0, v_center = 9.0) {
  translate([u_mouth, v_center - socket_depth / 2.0, station_recess_depth])
    cube([socket_len, socket_depth, socket_axis_depth], center = false);
}

// M3 clearance bore, along w between w0 and w1.
module m3_through_passage(au, av, w0, w1, d = m3_clearance_d) {
  translate([au, av, (w0 + w1) / 2.0])
    cylinder(d = d, h = w1 - w0, center = true);
}

// Head/washer recess in the exterior face: 8.25 dia, floor at 3.8, modeled
// w -0.05..3.85 (face overhang 0.05, nested 0.05 past the socket floor).
module m3_head_recess(au, av) {
  translate([au, av, station_recess_depth / 2.0])
    cylinder(d = station_recess_d, h = station_recess_depth + 0.1, center = true);
}

// Captive hex-nut pocket: 6.816 dia, w 13.075..15.925 (mouth side at the
// nominal 13.075 stack stop, aperture 0.05 past the chamber-side opening-
// edge face; the nested passage side ends 0.05 into it).
module m3_captive_hex_nut_pocket(au, av) {
  translate([au, av,
             (station_recess_depth + tongue_slab_t + station_air_gap
              + station_receiver_wall)
             + (nut_pocket_depth + 0.05) / 2.0])
    cylinder(d = nut_pocket_d, h = nut_pocket_depth + 0.05, center = true);
}

// The complete receiver cut set for one station (local frame). All members
// sit at u >= 0 (receiver side of the station's own seam plane) - no
// receiver cut ever straddles a split plane, so the master can be
// quadrant-intersected per leaf with no cut split.
module seam_station_receiver_cut(au, av) {
  union() {
    receiver_socket(0.0, av);
    m3_head_recess(au, av);
    // Receiver passage: w 3.75..13.125 (0.05 nested into the recess floor,
    // 0.05 past the pocket mouth side).
    m3_through_passage(au, av,
                       station_recess_depth - 0.05,
                       station_recess_depth + tongue_slab_t + station_air_gap
                       + station_receiver_wall + 0.05);
    m3_captive_hex_nut_pocket(au, av);
  }
}

// Tongue slab passage (tongue-leaf cut): 3.6 dia through the slab layer,
// w 3.7..6.9 (0.1 overhang past each slab face). After assembly the slab
// bore and the receiver passage are the one through channel for the M3.
module seam_station_slab_cut(au, av) {
  m3_through_passage(au, av,
                     station_recess_depth - 0.1,
                     station_recess_depth + tongue_slab_t + 0.1);
}

// ---- Product-frame pads (all eight) --------------------------------------

module seam_station_pads_all() {
  // top ribbon (band Z 111.125..127.0, insertion = x, receiver at +x)
  // station_top_front: pad X [-3,18] y [0,18]
  translate([-seam_root_overlap, station_tb_y0, opening_edge])
    cube([seam_root_overlap + receiver_zone, station_tb_y1 - station_tb_y0,
          ring_band], center = false);
  // station_top_rear: pad X [-3,18] y [62,80]
  translate([-seam_root_overlap, station_tb_y0_rear, opening_edge])
    cube([seam_root_overlap + receiver_zone,
          station_tb_y1_rear - station_tb_y0_rear, ring_band], center = false);
  // bottom ribbon (band Z -127.0..-111.125)
  // station_bottom_front / bottom_rear (same x/y boxes, mirrored band)
  translate([-seam_root_overlap, station_tb_y0, -case_half])
    cube([seam_root_overlap + receiver_zone, station_tb_y1 - station_tb_y0,
          ring_band], center = false);
  translate([-seam_root_overlap, station_tb_y0_rear, -case_half])
    cube([seam_root_overlap + receiver_zone,
          station_tb_y1_rear - station_tb_y0_rear, ring_band], center = false);
  // left ribbon (band X -127.0..-111.125, insertion = z, receiver at +z)
  // station_left_front: pad X [-127,-111.125] y [6,24] z [-3,18] -
  // end-aligned layout 2026-09-09 (user: tabs flush to case ends): the front
  // Y window is pushed flush toward the front face as far as the rack hole
  // pockets allow (front socket face clears the 5.8 rack by 3.2, slab by
  // 4.2); the rear pairs sit flush against the rear face ([62,80]).
  translate([-case_half, station_lr_y0, -seam_root_overlap])
    cube([ring_band, station_lr_y1 - station_lr_y0,
          seam_root_overlap + receiver_zone], center = false);
  // station_left_rear: y [62,80] (flush against the rear face)
  translate([-case_half, station_lr_y0_rear, -seam_root_overlap])
    cube([ring_band, station_lr_y1_rear - station_lr_y0_rear,
          seam_root_overlap + receiver_zone], center = false);
  // right ribbon (band X 111.125..127.0)
  // station_right_front: pad X [111.125,127] y [6,24] z [-3,18] (mirror of
  // the left pair across the opening)
  translate([opening_edge, station_lr_y0, -seam_root_overlap])
    cube([ring_band, station_lr_y1 - station_lr_y0,
          seam_root_overlap + receiver_zone], center = false);
  // station_right_rear: y [62,80] (flush against the rear face)
  translate([opening_edge, station_lr_y0_rear, -seam_root_overlap])
    cube([ring_band, station_lr_y1_rear - station_lr_y0_rear,
          seam_root_overlap + receiver_zone], center = false);
}

// ---- Product-frame receiver cut sets (all eight) --------------------------

// One tb station's cuts (fastener axis along world Z at x = +8.0).
// q = +1 top band (face Z = +127.0), q = -1 bottom band (face Z = -127.0).
module seam_station_cuts_tb(q, axis_y, name) {
  if (q == 1) {
    // Socket: x [0,15] (mouth exactly at the seam face), y axis_y +- 6.0,
    // z 119.5..123.2 (w 3.8..7.5).
    translate([0.0, axis_y - socket_depth / 2.0,
               case_half - station_recess_depth - socket_axis_depth])
      cube([socket_len, socket_depth, socket_axis_depth], center = false);
    // Head recess: z 123.15..127.05.
    translate([seam_fastener_seam_offset, axis_y,
               case_half - station_recess_depth / 2.0])
      cylinder(d = station_recess_d, h = station_recess_depth + 0.1,
               center = true);
    // Receiver passage: z 113.875..123.25.
    translate([seam_fastener_seam_offset, axis_y,
               case_half
               - (station_recess_depth
                  + (tongue_slab_t + station_air_gap
                     + station_receiver_wall) / 2.0)])
      cylinder(d = m3_clearance_d,
               h = tongue_slab_t + station_air_gap + station_receiver_wall
                   + 0.1,
               center = true);
    // Nut pocket: z 111.075..113.925 (aperture 0.05 past the opening edge).
    translate([seam_fastener_seam_offset, axis_y,
               case_half - (ring_band - nut_pocket_depth / 2.0 + 0.025)])
      cylinder(d = nut_pocket_d, h = nut_pocket_depth + 0.05, center = true);
  } else {
    // Socket: x [0,15], y axis_y +- 6.0, z -123.2..-119.5.
    translate([0.0, axis_y - socket_depth / 2.0,
               -(case_half - station_recess_depth)])
      cube([socket_len, socket_depth, socket_axis_depth], center = false);
    // Head recess: z -127.05..-123.15.
    translate([seam_fastener_seam_offset, axis_y,
               -(case_half - station_recess_depth / 2.0)])
      cylinder(d = station_recess_d, h = station_recess_depth + 0.1,
               center = true);
    // Receiver passage: z -123.25..-113.875.
    translate([seam_fastener_seam_offset, axis_y,
               -(case_half
                 - (station_recess_depth
                    + (tongue_slab_t + station_air_gap
                       + station_receiver_wall) / 2.0))])
      cylinder(d = m3_clearance_d,
               h = tongue_slab_t + station_air_gap + station_receiver_wall
                   + 0.1,
               center = true);
    // Nut pocket: z -113.925..-111.075.
    translate([seam_fastener_seam_offset, axis_y,
               -(case_half - (ring_band - nut_pocket_depth / 2.0 + 0.025))])
      cylinder(d = nut_pocket_d, h = nut_pocket_depth + 0.05, center = true);
  }
}

// One lr station's cuts (fastener axis along world X at z = +8.0).
// sx = +1 right band (face X = +127.0), sx = -1 left band (face X = -127.0).
module seam_station_cuts_lr(sx, axis_y, name) {
  if (sx == 1) {
    // Socket: x 119.5..123.2, y axis_y +- 6.0, z [0,15] (mouth at seam face).
    translate([case_half - station_recess_depth - socket_axis_depth,
               axis_y - socket_depth / 2.0, 0.0])
      cube([socket_axis_depth, socket_depth, socket_len], center = false);
    // Head recess: x 123.15..127.05.
    translate([case_half - station_recess_depth / 2.0, axis_y,
               seam_fastener_seam_offset])
      rotate([0, 90, 0])
        cylinder(d = station_recess_d, h = station_recess_depth + 0.1,
                 center = true);
    // Receiver passage: x 113.875..123.25.
    translate([case_half
               - (station_recess_depth
                  + (tongue_slab_t + station_air_gap
                     + station_receiver_wall) / 2.0),
               axis_y, seam_fastener_seam_offset])
      rotate([0, 90, 0])
        cylinder(d = m3_clearance_d,
                 h = tongue_slab_t + station_air_gap + station_receiver_wall
                     + 0.1,
                 center = true);
    // Nut pocket: x 111.075..113.925.
    translate([case_half - (ring_band - nut_pocket_depth / 2.0 + 0.025),
               axis_y, seam_fastener_seam_offset])
      rotate([0, 90, 0])
        cylinder(d = nut_pocket_d, h = nut_pocket_depth + 0.05, center = true);
  } else {
    // Socket: x -123.2..-119.5, y axis_y +- 6.0, z [0,15].
    translate([-case_half + station_recess_depth,
               axis_y - socket_depth / 2.0, 0.0])
      cube([socket_axis_depth, socket_depth, socket_len], center = false);
    // Head recess: x -127.05..-123.15.
    translate([-(case_half - station_recess_depth / 2.0), axis_y,
               seam_fastener_seam_offset])
      rotate([0, 90, 0])
        cylinder(d = station_recess_d, h = station_recess_depth + 0.1,
                 center = true);
    // Receiver passage: x -123.25..-113.875.
    translate([-(case_half
                 - (station_recess_depth
                    + (tongue_slab_t + station_air_gap
                       + station_receiver_wall) / 2.0)),
               axis_y, seam_fastener_seam_offset])
      rotate([0, 90, 0])
        cylinder(d = m3_clearance_d,
                 h = tongue_slab_t + station_air_gap + station_receiver_wall
                     + 0.1,
                 center = true);
    // Nut pocket: x -113.925..-111.075.
    translate([-(case_half - (ring_band - nut_pocket_depth / 2.0 + 0.025)),
               axis_y, seam_fastener_seam_offset])
      rotate([0, 90, 0])
        cylinder(d = nut_pocket_d, h = nut_pocket_depth + 0.05, center = true);
  }
}

// All eight receiver cut sets, product frame (unrotated).
module seam_station_cuts_all() {
  seam_station_cuts_tb(1, station_tb_y_center, "top_front");
  seam_station_cuts_tb(1, station_tb_y_center_rear, "top_rear");
  seam_station_cuts_tb(-1, station_tb_y_center, "bottom_front");
  seam_station_cuts_tb(-1, station_tb_y_center_rear, "bottom_rear");
  seam_station_cuts_lr(1, station_lr_y_center, "right_front");
  seam_station_cuts_lr(1, station_lr_y_center_rear, "right_rear");
  seam_station_cuts_lr(-1, station_lr_y_center, "left_front");
  seam_station_cuts_lr(-1, station_lr_y_center_rear, "left_rear");
}

// ---- Tongue slabs, product frame (tongue-leaf geometry only) --------------
// Locked slab boxes (plan 1.3): radial 3.8..6.8 in each station's band;
// insertion -3..11 across its own seam plane (3.0 fused into the pad root
// on the tongue-leaf side, 11.0 riding in the receiver socket):
//   bottom_front  x [-3,11]   y [4,14]  z [-123.2,-120.2]  owner bottom_left
//   bottom_rear   x [-3,11]   y [66,76] z [-123.2,-120.2]  owner bottom_left
//   top_front     x [-3,11]   y [4,14]  z [120.2,123.2]    owner top_left
//   top_rear      x [-3,11]   y [66,76] z [120.2,123.2]    owner top_left
  // left_front    x [-123.2,-120.2] y [10,20] z [-3,11]    owner bottom_left
//   left_rear     x [-123.2,-120.2] y [66,76] z [-3,11]    owner bottom_left
//   right_front   x [120.2,123.2] y [10,20] z [-3,11]      owner bottom_right
//   right_rear    x [120.2,123.2] y [66,76] z [-3,11]      owner bottom_right
// (top_right owns none - all four of its stations are receivers.) The slab
// crosses its station's seam plane: the root fusion must NOT be subtracted
// by the leaf's quadrant intersection, so slabs are unioned into the leaf
// AFTER the quadrant cut (plan 3.2); the slab's receiver-side reach uses the
// + direction of its leaf's own datum half-spaces, so print placements are
// unchanged (plan 4.2).

module seam_station_slabs_bottom_left() {
  // station_bottom_front slab (X -3..11) - axis (x 8.0, y 9.0)
  translate([-seam_root_overlap, station_tb_y_center - tongue_seat_width / 2.0,
             -(case_half - station_recess_depth)])
    cube([tongue_slab_len, tongue_seat_width, tongue_slab_t], center = false);
  // station_bottom_rear slab (X -3..11) - axis (x 8.0, y 71.0)
  translate([-seam_root_overlap, station_tb_y_center_rear - tongue_seat_width / 2.0,
             -(case_half - station_recess_depth)])
    cube([tongue_slab_len, tongue_seat_width, tongue_slab_t], center = false);
  // station_left_front slab (Z -3..11) - axis (y 15.0, z 8.0)
  translate([-(case_half - station_recess_depth),
             station_lr_y_center - tongue_seat_width / 2.0, -seam_root_overlap])
    cube([tongue_slab_t, tongue_seat_width, tongue_slab_len], center = false);
  // station_left_rear slab (Z -3..11) - axis (y 71.0, z 8.0)
  translate([-(case_half - station_recess_depth),
             station_lr_y_center_rear - tongue_seat_width / 2.0, -seam_root_overlap])
    cube([tongue_slab_t, tongue_seat_width, tongue_slab_len], center = false);
}

module seam_station_slabs_top_left() {
  // station_top_front slab (X -3..11, Z 120.2..123.2) - axis (x 8.0, y 9.0)
  translate([-seam_root_overlap, station_tb_y_center - tongue_seat_width / 2.0,
             case_half - station_recess_depth - tongue_slab_t])
    cube([tongue_slab_len, tongue_seat_width, tongue_slab_t], center = false);
  // station_top_rear slab (X -3..11, Z 120.2..123.2) - axis (x 8.0, y 71.0)
  translate([-seam_root_overlap, station_tb_y_center_rear - tongue_seat_width / 2.0,
             case_half - station_recess_depth - tongue_slab_t])
    cube([tongue_slab_len, tongue_seat_width, tongue_slab_t], center = false);
}

module seam_station_slabs_bottom_right() {
  // station_right_front slab (X 120.2..123.2, Z -3..11) - axis (y 15.0, z 8.0)
  translate([case_half - station_recess_depth - tongue_slab_t,
             station_lr_y_center - tongue_seat_width / 2.0, -seam_root_overlap])
    cube([tongue_slab_t, tongue_seat_width, tongue_slab_len], center = false);
  // station_right_rear slab (X 120.2..123.2, Z -3..11) - axis (y 71.0, z 8.0)
  translate([case_half - station_recess_depth - tongue_slab_t,
             station_lr_y_center_rear - tongue_seat_width / 2.0, -seam_root_overlap])
    cube([tongue_slab_t, tongue_seat_width, tongue_slab_len], center = false);
}

// (top_right owns no slabs - all four of its stations are receivers.)

// ---- Tongue slab passages, product frame (tongue-leaf cuts) ---------------
// 3.6 dia at each station axis, radial 3.7..6.9 (0.1 overhang past each
// slab face). Each cut meets ONLY its own slab: outside the slab the
// station region on the tongue leaf is empty (the receiver-side master
// material was never in this leaf's quadrant, and the radial span never
// reaches the tongue side of the seam).

module seam_station_slab_cuts_bottom_left() {
  // station_bottom_front
  translate([seam_fastener_seam_offset, station_tb_y_center,
             -(case_half - (station_recess_depth + tongue_slab_t / 2.0))])
    cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
  // station_bottom_rear
  translate([seam_fastener_seam_offset, station_tb_y_center_rear,
             -(case_half - (station_recess_depth + tongue_slab_t / 2.0))])
    cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
  // station_left_front
  translate([-(case_half - (station_recess_depth + tongue_slab_t / 2.0)),
             station_lr_y_center, seam_fastener_seam_offset])
    rotate([0, 90, 0])
      cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
  // station_left_rear
  translate([-(case_half - (station_recess_depth + tongue_slab_t / 2.0)),
             station_lr_y_center_rear, seam_fastener_seam_offset])
    rotate([0, 90, 0])
      cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
}

module seam_station_slab_cuts_top_left() {
  // station_top_front
  translate([seam_fastener_seam_offset, station_tb_y_center,
             case_half - (station_recess_depth + tongue_slab_t / 2.0)])
    cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
  // station_top_rear
  translate([seam_fastener_seam_offset, station_tb_y_center_rear,
             case_half - (station_recess_depth + tongue_slab_t / 2.0)])
    cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
}

module seam_station_slab_cuts_bottom_right() {
  // station_right_front
  translate([case_half - (station_recess_depth + tongue_slab_t / 2.0),
             station_lr_y_center, seam_fastener_seam_offset])
    rotate([0, 90, 0])
      cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
  // station_right_rear
  translate([case_half - (station_recess_depth + tongue_slab_t / 2.0),
             station_lr_y_center_rear, seam_fastener_seam_offset])
    rotate([0, 90, 0])
      cylinder(d = m3_clearance_d, h = tongue_slab_t + 0.2, center = true);
}

// ---- Station assertion guards (plan 3.3) -----------------------------------
// Binds the config to the locked fit numbers so any config drift fails
// the render before geometry is generated. Structural ligaments must be
// >= 3.0; fit clearances (4.0 socket tip, 2.0 channel side, 3.5 socket
// face margin, 0.7 air gap, 0.4 nut float) are float-tolerance compares
// of the exact declared values - not structural floors.
module station_asserts() {
  // Radial stack fills the 15.875 ring band exactly.
  assert(station_recess_depth + tongue_slab_t + station_air_gap
         + station_receiver_wall + nut_pocket_depth == ring_band,
         "station radial stack must equal the 15.875 ring band");

  // Socket geometry.
  assert(receiver_zone - socket_len == 3.0, "socket closed end 3.0");
  // Intended fit voids (float-tolerance compares): 1.0 slack past the
  // slab-tip plane, 4.0 from the slab tip to the socket's closed end
  // (slab spans u -3..11; its root -3..0 is outside the socket), 1.0 per
  // channel side (socket 12 vs slab 10), 3.0 socket margin to each pad
  // depth face (18 - 12).
  assert(socket_len - tongue_slab_len == 1.0, "socket tip clearance 1.0 (fit)");
  assert(abs(socket_len - (tongue_slab_len - seam_root_overlap) - 4.0) < 0.001,
         "slab tip 11.0 stops 4.0 short of the socket closed end (fit)");
  assert(abs((socket_depth - tongue_seat_width) / 2.0 - 1.0) < 0.001,
         "channel side clearance 1.0 (fit)");
  assert(abs((receiver_zone - socket_depth) / 2.0 - 3.0) < 0.001,
         "socket margin to pad depth faces 3.0");

  // Fastener-axis containment: axis 8.0 from each seam face; pad-depth
  // centers 9.0 (tb) / 15.0 front, 71.0 rear (lr); recess r 4.125, pocket
  // r 3.408. The lr asserts below use the FRONT center (the smaller of the
  // two, so the tighter clearances are the front ones).
  assert(seam_fastener_seam_offset - station_recess_d / 2.0 >= 3.0,
         "recess -> seam face ligament 3.875");
  assert(station_tb_y_center - station_recess_d / 2.0 >= 3.0,
         "tb recess -> pad-depth face ligament 4.875");
  assert(receiver_zone - seam_fastener_seam_offset - station_recess_d / 2.0
         >= 3.0, "recess -> pad back-face ligament 5.875");
  assert(seam_fastener_seam_offset - nut_pocket_d / 2.0 >= 3.0,
         "pocket -> seam face ligament 4.592");
  assert(station_tb_y_center - nut_pocket_d / 2.0 >= 3.0,
         "tb pocket -> pad-depth face ligament 5.592");
  assert(receiver_zone - seam_fastener_seam_offset - nut_pocket_d / 2.0
         >= 3.0, "pocket -> pad back-face ligament 6.592");
  assert(station_lr_y_center - station_recess_d / 2.0 >= 3.0,
         "lr recess -> pad-depth face ligament 4.875 (center 15, end-aligned)");
  assert(station_lr_y_center - nut_pocket_d / 2.0 >= 3.0,
         "lr pocket -> pad-depth face ligament 5.592 (center 15, end-aligned)");

  // Radial stack stops.
  assert(station_recess_depth == 3.8,
         "recess depth 3.8 = head 3.0 + washer 0.5 + spare 0.3");
  assert(station_recess_depth + tongue_slab_t == 6.8,
         "slab top 6.8 = recess floor 3.8 + slab 3.0");
  assert(6.8 + station_air_gap == 7.5, "air gap 0.7 below slab (fit)");
  assert(abs(7.5 + station_receiver_wall - 13.075) < 0.001,
         "receiver wall 5.575 (void stop 13.075)");
  assert(abs(13.075 + nut_pocket_depth - 15.875) < 0.001,
         "nut pocket 2.8 closes at the opening edge");
  // The 2.4 nut floats 0.4 inside the 2.8-deep pocket, which is open at
  // the chamber-side face (insertion path stays through the seam face).
  assert(abs(nut_pocket_depth - nut_thickness - 0.4) < 0.001,
         "nut axial float 0.4 (fit)");

  // Head 3.0 + washer 0.5 seat in the 3.8 recess with 0.3 spare above the
  // head top; M3x12 tip stays in-band, M3x14 would exit it.
  assert(station_recess_depth - 0.5 + m3_screw_len <= ring_band,
         "M3x12 tip 15.3 stops in-band");
  assert(station_recess_depth - 0.5 + m3_screw_rejected_len > ring_band,
         "M3x14 rejected (17.3 exits the band)");

  // Pads: inner face flush with the opening edge (no opening intrusion),
  // 21.0 insertion span (3.0 root + 18.0 receiver), 18.0 depth, inside the
  // 254 x 254 silhouette.
  assert(case_half - ring_band == opening_edge,
         "pad inner face = opening edge 111.125");
  assert(seam_root_overlap + receiver_zone == 21.0,
         "pad insertion span 21.0 (root 3.0 + receiver 18.0)");
  assert(station_tb_y1 - station_tb_y0 == 18.0, "tb pad depth 18.0");
  assert(station_tb_y1_rear - station_tb_y0_rear == 18.0,
         "tb rear pad depth 18.0");
  assert(station_lr_y1 - station_lr_y0 == 18.0, "lr pad depth 18.0");
  assert(station_lr_y1_rear - station_lr_y0_rear == 18.0,
         "lr rear pad depth 18.0");

  // Rear pairs are flush against the rear exterior face. The tb rear pair
  // mirrors the tb front pair exactly about Y = 40.0 ([0,18] -> [62,80]);
  // the lr front pair is rail-limited (not a mirror), the lr rear pair is
  // flush (end-aligned layout 2026-09-09).
  assert(case_depth_exterior - station_tb_y0 == station_tb_y1_rear
         && case_depth_exterior - station_tb_y1 == station_tb_y0_rear,
         "tb rear pad mirrors tb front about Y=40 ([0,18] -> [62,80])");
  assert(abs(station_lr_y1_rear - case_depth_exterior) < 1e-9,
         "lr rear pads flush against the rear face (y1_rear = 80.0)");
  assert(station_tb_y_center + station_tb_y_center_rear
         == case_depth_exterior, "tb axis mirror 9.0 / 71.0");
  // NOTE: the lr center SUM is intentionally NOT a mirror assert - the front
  // axis (15.0) is rail-limited, the rear axis (71.0) is end-flush; only the
  // REAR FLUSH is asserted (above). The lr rear pad window DOES mirror the
  // lr front pad window about Y = 40.0 in its 18.0 depth (checked by the
  // pad depth asserts above).

  // lr FRONT pads clear the rack hole voids: the station's socket and slab
  // faces must stay clear of the front wall's hole pockets by the wall floor
  // (the rack 30-hole pattern is locked - no new joints there). Flush to
  // the front face is rejected by this: socket face would merge with the
  // z=0 and z=12.7 rack rows' 6.816 pockets (Y 2.95..5.85).
  assert(station_lr_y_center - socket_depth / 2.0 - rack_land_depth >= 3.0 - 0.001,
         "lr socket face clears rack hole pockets by >= 3.0 (15-6-5.8 = 3.2)");
  assert(station_lr_y_center - tongue_seat_width / 2.0 - rack_land_depth >= 3.0 - 0.001,
         "lr slab face clears rack hole pockets by >= 3.0 (15-5-5.8 = 4.2)");
  assert(station_lr_y0 >= 0.0 && station_lr_y1_rear <= case_depth_exterior,
         "lr pads inside the case depth (end-aligned)");
  assert(opening_edge - equipment_width_max / 2.0 >= 1.125 - 1e-9,
         "lr pad inner face clears equipment half-width by 1.125");

  // Slab fits its socket (fit clearances); slab and root zone at structural
  // floors.
  assert(tongue_slab_len < socket_len && tongue_seat_width < socket_depth,
         "slab smaller than socket in every in-plane axis");
  assert(tongue_slab_t >= minimum_wall_thickness, "slab at wall floor 3.0");
  assert(seam_root_overlap >= minimum_structural_overlap,
         "pad root zone 3.0 (structural overlap floor)");
}

// ---- Fit-test coupon (plan 3.1) -------------------------------------------
// One full station as a single fused solid (reference module family's
// coupon): the full pad block (root + receiver, u -3..18) with its receiver
// cuts, the slab registered in its socket, the slab bore through, plus a
// temporary 3.0 x 2.0 bridge strip at u -3..0 welding the slab to the
// block so the coupon prints as one manifold piece. The slab/socket fit
// voids remain inside as the printed-fit test volumes (4.0 tip, 1.0 per
// side, 0.7 ceiling); the fastener channel is through from the face
// recess to the
// chamber-side pocket aperture.
//
// This is geometry only. The production-derived coupon required by the
// reference document (print in production material; measure insertion force,
// clearance, nut retention, head seating, driver access, clamp, and failure
// location) is a documented pending verification step and NOT part of this
// config's build manifest.
//
// Render (manual, out of pipeline):
//   openscad -o coupon.stl <(openscad data)  - or drop into a scratch file:
//   include "../src/main.scad" won't work standalone; intended use:
//   a scratch .scad that sets the -D keys and does `seam_station_coupon();`
// Print orientation: w (radial) vertical, root edge against the bed.
module seam_station_coupon() {
  difference() {
    union() {
      difference() {
        station_pad(-seam_root_overlap, 0.0, receiver_zone, 18.0);
        seam_station_receiver_cut(seam_fastener_seam_offset, 9.0);
      }
      registration_tongue(0.0, 9.0);
      // Temporary print bridge (coupon-only; not production geometry):
      // welds the slab to the root zone across the seam face.
      translate([-seam_root_overlap, 9.0 - 1.0, station_recess_depth])
        cube([seam_root_overlap, 2.0, tongue_slab_t], center = false);
    }
    seam_station_slab_cut(seam_fastener_seam_offset, 9.0);
  }
}

// Top-level: run the station guards with the active config so any violation
// aborts the render before geometry is generated.
station_asserts();