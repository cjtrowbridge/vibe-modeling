// Parametric L-shaped replacement backplane for the Winegard GM-6000 Carryout G2+.
// This is a first-pass model based on hole spacing/offset measurements and margin assumptions.

module winegard_gm6000_logic_backplane() {
  hole_r = mount_hole_d / 2;
  base_hole_x = left_right_hole_spacing / 2;
  back_hole_x = base_hole_x + back_hole_outboard_offset;
  width = left_right_hole_spacing + mount_hole_d + 2 * side_edge_margin;
  base_depth_nominal = bottom_hole_from_back_edge + hole_r + front_edge_margin;
  base_depth = base_depth_nominal + box_depth_extension;
  back_height = back_hole_from_base_bottom + hole_r + top_edge_margin;
  // Replace the full back plate with a hole band that just covers the back holes
  // and fills the span between them.
  back_hole_band_w = 2 * (back_hole_x + hole_r + side_edge_margin);
  back_hole_band_h = mount_hole_d + 2 * top_edge_margin;
  back_hole_band_z0 = back_hole_from_base_bottom - hole_r - top_edge_margin;
  rib_t = inner_rib_thickness;
  rib_clear = inner_rib_hole_clearance;
  left_rib_face_x = -base_hole_x + hole_r + rib_clear;
  right_rib_face_x = base_hole_x - hole_r - rib_clear;
  left_rib_x = left_rib_face_x;
  right_rib_x = right_rib_face_x - rib_t;
  top_panel_x = left_rib_x + rib_t;
  top_panel_w = (right_rib_x) - top_panel_x;
  box_inner_left_x = top_panel_x;
  box_inner_right_x = right_rib_x;
  pi_patch_x0 = pi_mount_back_patch_on_user_right
    ? box_inner_left_x
    : (box_inner_right_x - pi_mount_back_patch_w);
  sma_r = sma_bulkhead_hole_d / 2;
  box_left_x = left_rib_x;
  box_right_x = right_rib_x + rib_t;
  // Preserve the pre-extension front-edge offset (the holes used to be centered front-to-back).
  sma_hole_front_offset = base_depth_nominal / 2;
  // Match user-facing left/right convention (mirrored relative to the model x-axis).
  top_hole_x = box_right_x - sma_top_hole_from_box_left;
  top_hole_y = base_depth - sma_hole_front_offset;
  right_side_hole_y = base_depth - sma_hole_front_offset;
  right_side_hole_z = back_height - sma_right_hole_from_box_top;
  eps = 0.1;

  assert(plate_thickness > 0, "plate_thickness must be > 0");
  assert(mount_hole_d > 0, "mount_hole_d must be > 0");
  assert(left_right_hole_spacing >= 0, "left_right_hole_spacing must be >= 0");
  assert(back_hole_outboard_offset >= 0, "back_hole_outboard_offset must be >= 0");
  assert(box_depth_extension >= 0, "box_depth_extension must be >= 0");
  assert(bottom_hole_from_back_edge > hole_r, "bottom_hole_from_back_edge must exceed hole radius");
  assert(back_hole_from_base_bottom > hole_r, "back_hole_from_base_bottom must exceed hole radius");
  assert(side_edge_margin >= 0, "side_edge_margin must be >= 0");
  assert(front_edge_margin >= 0, "front_edge_margin must be >= 0");
  assert(top_edge_margin >= 0, "top_edge_margin must be >= 0");
  assert(rib_t > 0, "inner_rib_thickness must be > 0");
  assert(rib_clear >= 0, "inner_rib_hole_clearance must be >= 0");
  assert(sma_bulkhead_hole_d > 0, "sma_bulkhead_hole_d must be > 0");
  assert(sma_top_hole_from_box_left >= 0, "sma_top_hole_from_box_left must be >= 0");
  assert(sma_right_hole_from_box_top >= 0, "sma_right_hole_from_box_top must be >= 0");
  assert(pi_mount_back_patch_w > 0, "pi_mount_back_patch_w must be > 0");
  assert(pi_mount_back_patch_h > 0, "pi_mount_back_patch_h must be > 0");
  assert(pi_mount_back_patch_z0 >= 0, "pi_mount_back_patch_z0 must be >= 0");
  assert(width > 0, "Derived width must be > 0");
  assert(base_depth > 0, "Derived base_depth must be > 0");
  assert(back_height > 0, "Derived back_height must be > 0");
  assert(back_hole_band_w > 0, "Derived back_hole_band_w must be > 0");
  assert(back_hole_band_h > 0, "Derived back_hole_band_h must be > 0");
  assert(back_hole_band_z0 >= 0, "Back-hole band falls below z=0");
  assert(base_hole_x + hole_r <= width / 2, "Base hole columns exceed part width");
  assert(back_hole_x + hole_r <= back_hole_band_w / 2, "Back-wall hole columns exceed back-hole band width");
  assert(left_rib_x >= -width / 2, "Left rib falls outside the part width");
  assert(right_rib_x + rib_t <= width / 2, "Right rib falls outside the part width");
  assert(top_panel_w > 0, "Ribs overlap; reduce inner_rib_thickness/clearance");
  assert(pi_patch_x0 >= box_inner_left_x, "Pi mount patch exceeds left interior bound");
  assert(pi_patch_x0 + pi_mount_back_patch_w <= box_inner_right_x, "Pi mount patch exceeds right interior bound");
  assert(pi_mount_back_patch_z0 + pi_mount_back_patch_h <= back_height, "Pi mount patch exceeds back height");
  assert(top_hole_x - sma_r >= top_panel_x, "Top SMA hole exceeds left edge of top panel");
  assert(top_hole_x + sma_r <= top_panel_x + top_panel_w, "Top SMA hole exceeds right edge of top panel");
  assert(top_hole_y - sma_r >= 0, "Top SMA hole exceeds back edge of top panel");
  assert(top_hole_y + sma_r <= base_depth, "Top SMA hole exceeds front edge of top panel");
  assert(right_side_hole_y - sma_r >= 0, "Right SMA hole exceeds back edge of side wall");
  assert(right_side_hole_y + sma_r <= base_depth, "Right SMA hole exceeds front edge of side wall");
  assert(right_side_hole_z - sma_r >= 0, "Right SMA hole exceeds bottom edge of side wall");
  assert(right_side_hole_z + sma_r <= back_height, "Right SMA hole exceeds top edge of side wall");
  assert(box_right_x > box_left_x, "Derived box width must be > 0");

  difference() {
    union() {
      // Horizontal base plate (extends away from the back wall in +y)
      translate([-width / 2, 0, 0]) cube([width, base_depth, plate_thickness], center = false);

      // Vertical back-hole band (rises at y=0, leaving most of the back open).
      translate([-back_hole_band_w / 2, 0, back_hole_band_z0])
        cube([back_hole_band_w, plate_thickness, back_hole_band_h], center = false);

      // Restored lower back patch for Raspberry Pi mounting area (inside the box).
      if (show_pi_mount_back_patch)
        translate([pi_patch_x0, 0, pi_mount_back_patch_z0])
          cube([pi_mount_back_patch_w, plate_thickness, pi_mount_back_patch_h], center = false);

      // Left/right internal side walls to create an open-front box section.
      translate([left_rib_x, 0, 0]) cube([rib_t, base_depth, back_height], center = false);
      translate([right_rib_x, 0, 0]) cube([rib_t, base_depth, back_height], center = false);

      // Top panel spanning between the ribs (front remains open).
      translate([top_panel_x, 0, back_height - plate_thickness])
        cube([top_panel_w, base_depth, plate_thickness], center = false);
    }

    for (x = [-base_hole_x, base_hole_x]) {
      // Base mounting holes (drill through z)
      translate([x, bottom_hole_from_back_edge, -eps])
        cylinder(d = mount_hole_d, h = plate_thickness + 2 * eps, $fn = hole_fn);
    }

    for (x = [-back_hole_x, back_hole_x]) {
      // Back-wall mounting holes (drill through y)
      translate([x, plate_thickness + eps, back_hole_from_base_bottom])
        rotate([90, 0, 0])
          cylinder(d = mount_hole_d, h = plate_thickness + 2 * eps, $fn = hole_fn);
    }

    // SMA bulkhead hole through the top panel (keeps original front-edge offset if box depth is extended).
    translate([top_hole_x, top_hole_y, back_height - plate_thickness - eps])
      cylinder(d = sma_bulkhead_hole_d, h = plate_thickness + 2 * eps, $fn = hole_fn);

    // SMA bulkhead hole through the user-facing right-side wall (same Y as top SMA hole).
    // This maps to the opposite x wall in the model coordinate frame.
    translate([left_rib_x - eps, right_side_hole_y, right_side_hole_z])
      rotate([0, 90, 0])
        cylinder(d = sma_bulkhead_hole_d, h = rib_t + 2 * eps, $fn = hole_fn);
  }
}
