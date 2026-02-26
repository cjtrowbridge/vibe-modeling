include <../lib/util.scad>;

// Mechanical proof-of-concept for a DirecTV-style replacement arm insert.
//
// Geometry:
// - Insert body: 45mm x 19mm x 15mm with beveled cross-section corners.
// - Outside pad: 50mm x 26mm x 3mm.
// - Screw hole: centered, vertical, 6mm diameter through insert section.
//
// Coordinate convention for this part:
// - Tube face is at z=0.
// - Insert extends into the tube toward negative z.
// - Outside pad extends toward positive z.

module beveled_rect_prism(w, h, d, b) {
  wb = w / 2;
  hb = h / 2;
  bb = min(b, min(w, h) / 2 - 0.01);

  linear_extrude(height = d, center = false)
    polygon(points = [
      [-wb + bb, -hb],
      [ wb - bb, -hb],
      [ wb, -hb + bb],
      [ wb,  hb - bb],
      [ wb - bb,  hb],
      [-wb + bb,  hb],
      [-wb,  hb - bb],
      [-wb, -hb + bb]
    ]);
}

module dtv_yagi_insert_with_custom_tab(tab_height = outer_height, tab_thickness = outer_thickness, tab_bottom_y = -outer_height / 2) {
  assert(tab_height > 0, "tab_height must be > 0");
  assert(tab_thickness > 0, "tab_thickness must be > 0");

  difference() {
    union() {
      // Insert segment that slides into the tube.
      translate([0, 0, -insert_depth])
        beveled_rect_prism(insert_width, insert_height, insert_depth, insert_corner_bevel);

      // Outside tab / pad for arm/card integration.
      translate([-outer_width / 2, tab_bottom_y, 0])
        cube([outer_width, tab_height, tab_thickness], center = false);
    }

    // Centered vertical mounting hole through the insert segment.
    translate([0, 0, -insert_depth / 2])
      rotate([90, 0, 0])
      centered_cylinder(screw_hole_d, max(insert_height, tab_height) + 2);
  }
}

module dtv_yagi_card_preview() {
  card_bottom_z = -mount_seat_to_focus + card_bottom_from_seat;

  director_z = -element_spacing;
  driven_z = 0;
  reflector_z = element_spacing;

  groove_center_y = card_thickness / 2 - groove_depth / 2;

  director_groove_len = director_len + 2 * element_end_margin;
  driven_groove_len = driven_len + 2 * element_end_margin;
  reflector_groove_len = reflector_len + 2 * element_end_margin;

  difference() {
    translate([-card_size_x / 2, -card_thickness / 2, card_bottom_z])
      cube([card_size_x, card_thickness, card_size], center = false);

    for (g = [
      [director_z, director_groove_len],
      [driven_z, driven_groove_len],
      [reflector_z, reflector_groove_len]
    ]) {
      translate([0, groove_center_y, g[0]])
        cube([g[1], groove_depth, groove_w], center = true);
    }

    translate([0, groove_center_y, driven_z])
      cube([dipole_gap, groove_depth, groove_w + 2], center = true);
  }
}

module place_yagi_card_at_focal_point() {
  slot_center_y = card_thickness / 2 - groove_depth / 2;
  focus_ref_y = is_undef(card_focus_ref_y) ? slot_center_y : card_focus_ref_y;
  pitch_deg = dish_toward_positive_z ? -card_elevation_deg : card_elevation_deg;
  z_flip_deg = dish_toward_positive_z ? 180 : 0;

  // The tab reference is the geometric centerline of the (possibly extended) outer tab.
  focus_x = 0;
  focus_y = focal_rise_above_tab;
  focus_z = focal_tab_thickness / 2;

  translate([focus_x, focus_y, focus_z])
    rotate([pitch_deg, 0, 0])
      rotate([0, z_flip_deg, 0])
        translate([0, -focus_ref_y, 0])
          children();
}

module driven_groove_tab_keepout() {
  groove_center_y = card_thickness / 2 - groove_depth / 2;
  focus_ref_y = is_undef(card_focus_ref_y) ? groove_center_y : card_focus_ref_y;
  driven_groove_len = driven_len + 2 * element_end_margin;
  keepout_margin = driven_groove_keepout_margin;

  assert(keepout_margin >= 0, "driven_groove_keepout_margin must be >= 0");

  place_yagi_card_at_focal_point()
    translate([0, groove_center_y - focus_ref_y, 0])
      cube([
        driven_groove_len + 2 * keepout_margin,
        groove_depth + 2 * keepout_margin,
        groove_w + 2 * keepout_margin
      ], center = true);
}

module dtv_yagi_insert_poc() {
  assert(insert_width > 0, "insert_width must be > 0");
  assert(insert_height > 0, "insert_height must be > 0");
  assert(insert_depth > 0, "insert_depth must be > 0");
  assert(outer_width > 0, "outer_width must be > 0");
  assert(outer_height > 0, "outer_height must be > 0");
  assert(outer_thickness > 0, "outer_thickness must be > 0");
  assert(screw_hole_d > 0, "screw_hole_d must be > 0");
  assert(insert_corner_bevel >= 0, "insert_corner_bevel must be >= 0");
  assert(insert_corner_bevel < min(insert_width, insert_height) / 2,
    "insert_corner_bevel must be less than half of insert width/height");

  dtv_yagi_insert_with_custom_tab();
}

module dtv_yagi_focal_alignment_poc() {
  groove_slot_center_y = card_thickness / 2 - groove_depth / 2;
  focal_tab_bottom_y = -outer_height / 2;
  focal_tab_top_y = focal_rise_above_tab + focal_tab_top_margin;
  focal_tab_height = focal_tab_top_y - focal_tab_bottom_y;

  assert(focal_rise_above_tab > 0, "focal_rise_above_tab must be > 0");
  assert(card_elevation_deg >= -90 && card_elevation_deg <= 90, "card_elevation_deg must be between -90 and 90");
  assert(focus_marker_d > 0, "focus_marker_d must be > 0");
  assert(focus_marker_h >= 0, "focus_marker_h must be >= 0");
  assert(focal_tab_thickness > 0, "focal_tab_thickness must be > 0");
  assert(focal_tab_height > 0, "Extended focal tab height must be > 0");
  assert(driven_groove_keepout_margin >= 0, "driven_groove_keepout_margin must be >= 0");
  assert(card_thickness > 0, "card_thickness must be > 0");
  assert(card_size_x > 0, "card_size_x must be > 0");
  assert(card_size > 0, "card_size must be > 0");
  assert(groove_depth > 0 && groove_depth < card_thickness, "groove_depth must be > 0 and < card_thickness");
  assert(groove_w > 0, "groove_w must be > 0");
  assert(element_spacing >= 0, "element_spacing must be >= 0");
  assert(director_len > 0 && driven_len > 0 && reflector_len > 0, "Yagi element lengths must be > 0");
  assert((is_undef(card_focus_ref_y) ? groove_slot_center_y : card_focus_ref_y) <= card_thickness / 2,
    "card_focus_ref_y must fit within card thickness");
  assert((is_undef(card_focus_ref_y) ? groove_slot_center_y : card_focus_ref_y) >= -card_thickness / 2,
    "card_focus_ref_y must fit within card thickness");

  union() {
    difference() {
      dtv_yagi_insert_with_custom_tab(
        tab_height = focal_tab_height,
        tab_thickness = focal_tab_thickness,
        tab_bottom_y = focal_tab_bottom_y
      );

      if (clear_driven_groove_in_tab)
        driven_groove_tab_keepout();
    }

    if (show_focus_marker)
      translate([0, focal_rise_above_tab, focal_tab_thickness / 2])
        rotate([90, 0, 0])
          centered_cylinder(focus_marker_d, focus_marker_h);

    if (show_card_preview) {
      if (preview_card_as_background) {
        %place_yagi_card_at_focal_point() dtv_yagi_card_preview();
      } else {
        place_yagi_card_at_focal_point() dtv_yagi_card_preview();
      }
    }
  }
}
