// First-draft cyberdeck visual mockup.
//
// This is intentionally a layout study, not a printable enclosure. It uses
// real dimensions where they are known from the design brief and clearly named
// proxy volumes where exact hardware drawings are still needed.

function deck_top_z() = deck_h;
function front_y() = -deck_y / 2;
function back_y() = deck_y / 2;
function left_x() = -deck_x / 2;
function right_x() = deck_x / 2;
function display_visual_x() =
  display_show_rack_rails ? display_rail_x : display_active_x + 2 * display_bezel_margin;
function display_visual_y() =
  display_show_rack_rails ? display_rail_y : display_active_y + 2 * display_bezel_margin;
function display_left_x() = display_center_x - display_visual_x() / 2;
function display_right_x() = display_center_x + display_visual_x() / 2;
function display_top_y() = display_center_y + display_visual_y() / 2;
function display_bottom_y() = display_center_y - display_visual_y() / 2;
function keyboard_top_y() = keyboard_center_y + keyboard_unfolded_y / 2;
function eye_dome_layout_d() = eye_dome_d + eye_base_ring_w;
function eye_dome_left_x() = eye_center_x - eye_dome_layout_d() / 2;
function eye_dome_right_x() = eye_center_x + eye_dome_layout_d() / 2;
function eye_dome_bottom_y() = eye_center_y - eye_dome_layout_d() / 2;
function toggle_col(i) = i % toggle_columns;
function toggle_row(i) = floor(i / toggle_columns);
function toggle_rows() = ceil(toggle_count / toggle_columns);
function toggle_x(i) =
  toggle_bank_center_x
  + (toggle_col(i) - (toggle_columns - 1) / 2) * toggle_spacing_x;
function toggle_y(i) =
  toggle_bank_center_y
  - (toggle_row(i) - (toggle_rows() - 1) / 2) * toggle_spacing_y;
function toggle_bank_top_y() =
  toggle_bank_center_y + (toggle_rows() - 1) * toggle_spacing_y / 2 + toggle_plate_y / 2;
function toggle_bank_bottom_y() =
  toggle_bank_center_y - (toggle_rows() - 1) * toggle_spacing_y / 2 - toggle_plate_y / 2 - 8;
function exhaust_slot_pitch() = opi_exhaust_slot_w + opi_exhaust_slot_gap;
function exhaust_total_x() =
  opi_exhaust_slot_count * opi_exhaust_slot_w
  + (opi_exhaust_slot_count - 1) * opi_exhaust_slot_gap;
function cell_pitch() = cell18650_d + 2.5;
function chamber_total_z() = chamber_bottom + chamber_internal_clearance_z;
function chamber_assembly_left_x() = -chamber_piece_x;
function chamber_assembly_right_x() = chamber_piece_x;
function chamber_display_wedge_right_x() = chamber_assembly_right_x();
function chamber_display_wedge_left_x() =
  chamber_display_wedge_right_x() - chamber_display_wedge_x;
function chamber_display_wedge_center_x() =
  (chamber_display_wedge_left_x() + chamber_display_wedge_right_x()) / 2;
function chamber_left_flat_area_x() =
  chamber_display_wedge_left_x() - chamber_assembly_left_x();
function chamber_dome_roof_left_x() = chamber_assembly_left_x();
function chamber_dome_roof_right_x() = chamber_display_wedge_left_x();
function chamber_dome_roof_back_y() = chamber_piece_y / 2;
function chamber_dome_roof_front_y() = chamber_dome_roof_back_y() - chamber_dome_area_y;
function chamber_dome_roof_center_x() =
  (chamber_dome_roof_left_x() + chamber_dome_roof_right_x()) / 2;
function chamber_dome_roof_center_y() =
  (chamber_dome_roof_front_y() + chamber_dome_roof_back_y()) / 2;
function chamber_dome_mount_screw_xy_offset() =
  chamber_dome_mount_screw_radius / sqrt(2);
function chamber_profile_peak_z() = chamber_total_z() + chamber_profile_peak_rise;
function chamber_profile_peak_y() =
  chamber_piece_y / 2 - chamber_profile_rear_slope_run;
function chamber_profile_screen_foot_y() =
  chamber_profile_peak_y() - chamber_profile_screen_slope_run;
function chamber_profile_screen_face_len() =
  sqrt(
    chamber_profile_peak_rise * chamber_profile_peak_rise
    + chamber_profile_screen_slope_run * chamber_profile_screen_slope_run
  );
function chamber_profile_screen_face_angle() =
  atan(chamber_profile_peak_rise / chamber_profile_screen_slope_run);
function chamber_display_void_center_y() =
  (chamber_profile_screen_foot_y() + chamber_profile_peak_y()) / 2;
function chamber_display_void_center_z() =
  (chamber_total_z() + chamber_profile_peak_z()) / 2;
function chamber_display_void_cut_overlap() = chamber_wall + 0.6;
function chamber_display_mount_screw_y(face_offset) =
  chamber_display_void_center_y()
  + face_offset * chamber_profile_screen_slope_run / chamber_profile_screen_face_len();
function chamber_display_mount_screw_z(face_offset) =
  chamber_display_void_center_z()
  + face_offset * chamber_profile_peak_rise / chamber_profile_screen_face_len();
function chamber_display_mount_rear_screw_y() =
  chamber_display_mount_screw_y(chamber_display_mount_screw_face_spacing / 2);
function chamber_profile_rear_slope_len() =
  sqrt(
    chamber_profile_rear_slope_run * chamber_profile_rear_slope_run
    + chamber_profile_rear_slope_drop * chamber_profile_rear_slope_drop
  );
function chamber_display_seam_rail_start_t() =
  chamber_display_seam_rail_bend_inset / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_end_t() =
  1 - chamber_display_seam_rail_start_t();
function chamber_display_seam_rail_y(t) =
  chamber_profile_peak_y() + t * chamber_profile_rear_slope_run;
function chamber_display_seam_rail_z(t) =
  chamber_profile_peak_z() - t * chamber_profile_rear_slope_drop;
function chamber_display_seam_rail_outward_offset() =
  max(chamber_display_seam_rail_d / 2 - chamber_display_seam_rail_embed, 0);
function chamber_display_seam_rail_outward_y() =
  chamber_display_seam_rail_outward_offset()
  * chamber_profile_rear_slope_drop / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_outward_z() =
  chamber_display_seam_rail_outward_offset()
  * chamber_profile_rear_slope_run / chamber_profile_rear_slope_len();
function chamber_display_seam_rail_screw_y(i) =
  chamber_display_seam_rail_y(
    i == 0 ? chamber_display_seam_rail_start_t() : chamber_display_seam_rail_end_t()
  ) + chamber_display_seam_rail_outward_y();
function chamber_display_seam_rail_screw_z(i) =
  chamber_display_seam_rail_z(
    i == 0 ? chamber_display_seam_rail_start_t() : chamber_display_seam_rail_end_t()
  ) + chamber_display_seam_rail_outward_z();
function chamber_profile_back_wall_z() =
  chamber_profile_peak_z() - chamber_profile_rear_slope_drop;
function chamber_profile_back_wall_rise() =
  chamber_profile_back_wall_z() - chamber_total_z();
function chamber_angled_wall_vertical_offset() = chamber_wall * sqrt(2);
function chamber_joint_ring_outer_d() =
  chamber_joint_passthrough_d + 2 * chamber_joint_ring_wall;
function chamber_passthrough_y(i) =
  i == 0
    ? chamber_joint_passthrough_front_y
    : chamber_joint_passthrough_rear_y;
function chamber_bolt_low_z() = chamber_bottom + chamber_joint_bolt_edge_inset_z;
function chamber_bolt_high_z() = chamber_total_z() - chamber_joint_bolt_edge_inset_z;
function chamber_bolt_outer_y() =
  chamber_piece_y / 2 - chamber_joint_bolt_edge_inset_y;
function chamber_bolt_y(i) =
  i < 2 ? -chamber_bolt_outer_y()
    : i < 4 ? chamber_bolt_outer_y()
    : 0;
function chamber_bolt_z(i) =
  (i == 0 || i == 2 || i == 4) ? chamber_bolt_low_z() : chamber_bolt_high_z();

module _assert_dims() {
  assert(deck_x > 0 && deck_y > 0 && deck_h > 0,
    "deck dimensions must be > 0");
  assert(deck_corner_r >= 0 && deck_corner_r * 2 <= min(deck_x, deck_y),
    "deck_corner_r is out of range");

  assert(display_active_x > 0 && display_active_y > 0,
    "display active dimensions must be > 0");
  assert(display_rail_x >= display_active_x,
    "display_rail_x must be >= display_active_x");
  assert(display_rail_y >= display_active_y,
    "display_rail_y must be >= display_active_y");

  assert(keyboard_unfolded_x > 0 && keyboard_unfolded_y > 0,
    "keyboard unfolded dimensions must be > 0");
  assert(eye_dome_d > 0,
    "eye_dome_d must be > 0");
  assert(eye_dome_left_x() >= left_x() && eye_dome_right_x() <= right_x(),
    "eye dome exceeds chassis width");
  assert(display_left_x() > eye_dome_right_x(),
    "display visual envelope overlaps the eye dome in top view");
  assert(display_bottom_y() > keyboard_top_y(),
    "display visual envelope overlaps the keyboard footprint in top view");
  assert(display_left_x() >= left_x() && display_right_x() <= right_x(),
    "display visual envelope exceeds chassis width");
  assert(eink_window_x > 0 && eink_window_y > 0,
    "e-ink window dimensions must be > 0");
  assert(eink_center_y - (eink_window_y + 10) / 2 > display_top_y(),
    "e-ink window must sit above the display band");
  assert(eink_center_x - (eink_window_x + 10) / 2 > toggle_x(toggle_count - 1) + toggle_plate_x / 2,
    "e-ink window must sit to the right of the toggle row");
  assert(toggle_count == 4,
    "this mockup expects four independent hardware toggles");
  assert(toggle_columns > 0 && toggle_columns <= toggle_count,
    "toggle_columns must be between 1 and toggle_count");
  assert(toggle_bank_bottom_y() > display_top_y(),
    "toggle bank must sit above the display band");
  assert(keyboard_top_y() < display_bottom_y(),
    "keyboard must sit below the display band");
  assert(keyboard_center_x - keyboard_unfolded_x / 2 >= left_x()
    && keyboard_center_x + keyboard_unfolded_x / 2 <= right_x(),
    "keyboard footprint exceeds chassis width");
  assert(opi_exhaust_slot_count > 0,
    "opi_exhaust_slot_count must be > 0");

  assert(print_volume_x > 0 && print_volume_y > 0 && print_volume_z > 0,
    "print volume dimensions must be > 0");
  assert(chamber_piece_x <= print_volume_x,
    "each chamber must fit the print volume in X");
  assert(chamber_piece_y <= print_volume_y,
    "each chamber must fit the print volume in Y");
  assert(chamber_total_z() <= print_volume_z,
    "each chamber must fit the print volume in Z");
  assert(chamber_wall > 0 && chamber_bottom > 0,
    "chamber wall and bottom thickness must be > 0");
  assert(chamber_display_cutout_h > 0 && chamber_display_mount_margin >= 0,
    "display cutout height must be > 0 and margin must be >= 0");
  assert(chamber_display_mount_face_len >= chamber_display_cutout_h + 2 * chamber_display_mount_margin,
    "display mount face length must include the cutout and top/bottom margins");
  assert(chamber_display_mount_width > 0 && chamber_display_mount_side_margin >= 0,
    "display mount width must be > 0 and side margin must be >= 0");
  assert(chamber_display_wedge_x >= chamber_display_mount_width + 2 * chamber_display_mount_side_margin,
    "display wedge width must include the display width and side margins");
  assert(chamber_display_wedge_x <= 2 * chamber_piece_x,
    "display wedge width exceeds the assembled chamber width");
  assert(chamber_display_void_x > 0 && chamber_display_void_h > 0,
    "display void dimensions must be > 0");
  assert(chamber_display_void_x < chamber_display_wedge_x,
    "display void width must fit inside the display wedge");
  assert(chamber_display_void_h < chamber_profile_screen_face_len(),
    "display void height must fit inside the angled display face");
  assert(chamber_display_void_depth >= 25.4,
    "display void depth must be at least 25.4 mm");
  assert(chamber_display_mount_screw_x_offset > chamber_display_void_x / 2
    && chamber_display_mount_screw_x_offset < chamber_display_mount_width / 2,
    "display mount screws must land in the display side flanges");
  assert(chamber_display_mount_screw_face_spacing > 0
    && chamber_display_mount_screw_face_spacing < chamber_profile_screen_face_len(),
    "display mount screw spacing must fit on the angled display face");
  assert(chamber_display_mount_screw_clearance_d > 0,
    "display mount screw clearance must be > 0");
  assert(chamber_dome_outer_d > 0 && chamber_dome_mount_margin >= 0,
    "dome outer diameter must be > 0 and dome margin must be >= 0");
  assert(chamber_dome_area_x >= chamber_dome_outer_d + 2 * chamber_dome_mount_margin,
    "dome area width must include the dome diameter and side margins");
  assert(chamber_dome_area_y >= chamber_dome_outer_d + 2 * chamber_dome_mount_margin,
    "dome area depth must include the dome diameter and side margins");
  assert(chamber_dome_roof_hole_d > 0
    && chamber_dome_roof_hole_d < min(chamber_dome_area_x, chamber_dome_area_y),
    "dome roof hole must fit inside the dome roof area");
  assert(chamber_dome_mount_screw_clearance_d >= 3.0,
    "dome mount holes should clear M3 hardware");
  assert(chamber_dome_mount_screw_radius - chamber_dome_mount_screw_clearance_d / 2
    > chamber_dome_roof_hole_d / 2,
    "dome mount screws intersect the dome roof hole");
  assert(chamber_dome_mount_screw_xy_offset() + chamber_dome_mount_screw_clearance_d / 2
    <= min(chamber_dome_area_x, chamber_dome_area_y) / 2,
    "dome mount screws exceed the dome roof area");
  assert(chamber_left_flat_area_x() >= chamber_dome_area_x,
    "left flat dome area is too narrow for the acrylic dome");
  assert(chamber_dome_roof_front_y() >= -chamber_piece_y / 2,
    "dome roof area exceeds the chamber depth");
  assert(chamber_display_wedge_left_x() > chamber_assembly_left_x(),
    "display wedge leaves no flat left-side dome area");
  assert(chamber_display_wedge_left_x() < 0,
    "display wedge left structural web should land inside the left chamber");
  assert(chamber_piece_x > 2 * chamber_wall && chamber_piece_y > 2 * chamber_wall,
    "chamber walls are too thick for the selected footprint");
  assert(chamber_internal_clearance_z >= 50,
    "chamber internal clearance must be at least 50 mm");
  assert(chamber_profile_peak_rise > 0,
    "chamber profile peak rise must be > 0");
  assert(chamber_profile_rear_slope_run > 0,
    "chamber rear slope run must be > 0");
  assert(chamber_profile_rear_slope_drop > 0,
    "chamber rear slope drop must be > 0");
  assert(chamber_profile_screen_slope_run > 0,
    "chamber screen slope run must be > 0");
  assert(abs(chamber_profile_peak_rise - chamber_profile_screen_slope_run) < 0.02,
    "screen face must remain 45 degrees");
  assert(chamber_profile_screen_face_len() >= chamber_display_mount_face_len,
    "screen face length is too short for the display mounting face");
  assert(chamber_profile_peak_z() <= print_volume_z,
    "side profile peak exceeds print volume Z");
  assert(chamber_profile_back_wall_z() > chamber_total_z(),
    "hybrid back wall must remain raised above the flat keyboard deck");
  assert(chamber_profile_back_wall_z() < chamber_profile_peak_z(),
    "hybrid back wall must sit below the side-profile peak");
  assert(chamber_profile_peak_y() < chamber_piece_y / 2,
    "side profile peak must sit forward of the rear edge");
  assert(chamber_profile_screen_foot_y() > -chamber_piece_y / 2,
    "side profile screen slope must meet the flat deck inside the chamber depth");
  assert(chamber_profile_screen_foot_y() < chamber_profile_peak_y(),
    "side profile screen foot must be forward of the peak");
  assert(chamber_display_seam_rail_w > 0
    && chamber_display_seam_rail_d > chamber_display_seam_rail_screw_clearance_d,
    "display seam rail dimensions must clear the screw holes");
  assert(chamber_display_seam_rail_embed > 0
    && chamber_display_seam_rail_embed < chamber_wall,
    "display seam rail embed must stay below wall thickness so it does not protrude inside");
  assert(chamber_display_seam_rail_screw_clearance_d >= 3.0,
    "display seam rail screw holes should clear M3 hardware");
  assert(chamber_display_seam_rail_bend_inset >= chamber_display_seam_rail_d / 2 + chamber_wall,
    "display seam rail screw holes need edge clearance for screw heads and nuts");
  assert(chamber_display_seam_rail_bend_inset > chamber_display_seam_rail_screw_clearance_d
    && 2 * chamber_display_seam_rail_bend_inset < chamber_profile_rear_slope_len(),
    "display seam rail screw holes must stay between the rear-slope bends");
  assert(chamber_joint_passthrough_count == 2,
    "this chamber mockup expects two front/back passthroughs");
  assert(chamber_joint_passthrough_d > 0,
    "chamber passthrough diameter must be > 0");
  assert(chamber_joint_passthrough_spacing_y > 0,
    "chamber passthrough spacing must be > 0");
  assert(chamber_joint_passthrough_front_y < chamber_joint_passthrough_rear_y,
    "front passthrough must be forward of rear passthrough");
  assert(abs(chamber_joint_passthrough_rear_y - chamber_display_mount_rear_screw_y()) < 5,
    "rear passthrough should stay near the rear display screw row");
  assert(chamber_joint_center_z - chamber_joint_passthrough_d / 2 > chamber_bottom,
    "chamber passthrough intersects the chamber floor");
  assert(chamber_joint_center_z + chamber_joint_passthrough_d / 2 < chamber_total_z(),
    "chamber passthrough exceeds the open chamber height");
  for (i = [0 : chamber_joint_passthrough_count - 1]) {
    assert(abs(chamber_passthrough_y(i)) + chamber_joint_ring_outer_d() / 2 <= chamber_piece_y / 2,
      "chamber passthrough reinforcement exceeds chamber depth");
  }
  assert(chamber_joint_center_z - chamber_joint_ring_outer_d() / 2 >= chamber_bottom,
    "chamber passthrough reinforcement intersects the chamber floor");
  assert(chamber_joint_center_z + chamber_joint_ring_outer_d() / 2 <= chamber_total_z(),
    "chamber passthrough reinforcement exceeds the open chamber height");
  assert(chamber_joint_bolt_count == 6,
    "this chamber mockup expects six M3 bolts on the mating face");
  assert(chamber_joint_bolt_clearance_d >= 3.0,
    "M3 bolt clearance should be at least 3.0 mm");
  for (i = [0 : chamber_joint_bolt_count - 1]) {
    assert(abs(chamber_bolt_y(i)) + chamber_joint_bolt_boss_d / 2 <= chamber_piece_y / 2,
      "chamber bolt boss exceeds chamber depth");
    assert(chamber_bolt_z(i) - chamber_joint_bolt_boss_d / 2 >= chamber_bottom,
      "chamber bolt boss intersects the chamber floor");
    assert(chamber_bolt_z(i) + chamber_joint_bolt_boss_d / 2 <= chamber_total_z(),
      "chamber bolt boss exceeds the open chamber height");
  }
}

module _rounded_rect_2d(w, d, r) {
  if (r <= 0) {
    square([w, d], center = true);
  } else {
    hull() {
      for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
          translate([sx * (w / 2 - r), sy * (d / 2 - r)])
            circle(r = r, $fn = 48);
        }
      }
    }
  }
}

module _rounded_box(w, d, h, r) {
  linear_extrude(height = h, center = false, convexity = 8)
    _rounded_rect_2d(w, d, r);
}

module _chamber_shell(side, center_x, assembly_position) {
  global_body_xa = side < 0 ? chamber_assembly_left_x() : 0;
  global_body_xb = side < 0 ? 0 : chamber_assembly_right_x();
  model_x_offset = assembly_position ? 0 : -side * chamber_piece_x / 2;
  wedge_xa = max(chamber_display_wedge_left_x(), global_body_xa) + model_x_offset;
  wedge_xb = min(chamber_display_wedge_right_x(), global_body_xb) + model_x_offset;
  wedge_global_xa = max(chamber_display_wedge_left_x(), global_body_xa);
  wedge_global_xb = min(chamber_display_wedge_right_x(), global_body_xb);
  keep_wedge_left_wall = abs(wedge_global_xa - chamber_display_wedge_left_x()) < 0.01;
  keep_wedge_right_wall = abs(wedge_global_xb - chamber_display_wedge_right_x()) < 0.01;
  roof_xa = max(chamber_dome_roof_left_x(), global_body_xa) + model_x_offset;
  roof_xb = min(chamber_dome_roof_right_x(), global_body_xb) + model_x_offset;

  union() {
    _chamber_flat_tray(
      center_x - chamber_piece_x / 2,
      center_x + chamber_piece_x / 2,
      -chamber_piece_y / 2,
      chamber_piece_y / 2
    );

    if (wedge_xb > wedge_xa) {
      _chamber_profile_shell(
        wedge_xa,
        wedge_xb,
        -chamber_piece_y / 2,
        chamber_piece_y / 2,
        keep_wedge_left_wall,
        keep_wedge_right_wall
      );
    }

    if (roof_xb > roof_xa) {
      _chamber_flat_roof(
        roof_xa,
        roof_xb,
        chamber_dome_roof_front_y(),
        chamber_dome_roof_back_y()
      );
    }
  }
}

module _chamber_flat_tray(xa, xb, y_front, y_back) {
  difference() {
    _chamber_flat_prism(xa, xb, y_front, y_back, 0, 0);
    _chamber_flat_prism(
      xa + chamber_wall,
      xb - chamber_wall,
      y_front + chamber_wall,
      y_back - chamber_wall,
      chamber_bottom,
      0.6
    );
  }
}

module _chamber_flat_prism(xa, xb, y_front, y_back, z_bottom, top_extra) {
  multmatrix([
    [0, 0, 1, xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = xb - xa, center = false, convexity = 4)
      polygon(points = [
        [y_front, z_bottom],
        [y_back, z_bottom],
        [y_back, chamber_total_z() + top_extra],
        [y_front, chamber_total_z() + top_extra]
      ]);
}

module _chamber_flat_roof(xa, xb, y_front, y_back) {
  translate([
    (xa + xb) / 2,
    (y_front + y_back) / 2,
    chamber_total_z() - chamber_wall / 2
  ])
    cube([xb - xa + 0.05, y_back - y_front, chamber_wall], center = true);
}

module _chamber_profile_shell(
  xa,
  xb,
  y_front,
  y_back,
  keep_left_wall = true,
  keep_right_wall = true
) {
  difference() {
    _chamber_profile_prism(
      xa,
      xb,
      y_front,
      y_back,
      0,
      0,
      0,
      0,
      0
    );

    _chamber_profile_prism(
      keep_left_wall ? xa + chamber_wall : xa - 0.6,
      keep_right_wall ? xb - chamber_wall : xb + 0.6,
      y_front + chamber_wall,
      y_back - chamber_wall,
      chamber_bottom,
      0.6,
      -chamber_angled_wall_vertical_offset(),
      -chamber_angled_wall_vertical_offset(),
      -chamber_angled_wall_vertical_offset()
    );
  }
}

module _chamber_profile_prism(
  xa,
  xb,
  y_front,
  y_back,
  z_bottom,
  front_top_extra,
  back_slope_extra,
  screen_slope_extra,
  ridge_extra
) {
  z_flat = chamber_total_z();
  y_screen = chamber_profile_screen_foot_y();
  y_peak = chamber_profile_peak_y();
  z_peak = chamber_profile_peak_z();
  z_back = chamber_profile_back_wall_z();

  multmatrix([
    [0, 0, 1, xa],
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 0, 1]
  ])
    linear_extrude(height = xb - xa, center = false, convexity = 4)
      polygon(points = concat(
        [
          [y_front, z_bottom],
          [y_back, z_bottom],
          [y_back, z_back + back_slope_extra],
          [y_peak, z_peak + ridge_extra],
          [y_screen, z_flat + screen_slope_extra]
        ],
        front_top_extra == screen_slope_extra
          ? []
          : [[y_screen, z_flat + front_top_extra]],
        [[y_front, z_flat + front_top_extra]]
      ));
}

module _chamber_passthrough_cut(joint_face_x, i) {
  translate([joint_face_x, chamber_passthrough_y(i), chamber_joint_center_z])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_joint_passthrough_d,
        h = chamber_joint_boss_depth * 2 + chamber_wall * 4,
        center = true,
        $fn = 72
      );
}

module _chamber_dome_roof_cut(center_x, center_y) {
  translate([center_x, center_y, chamber_total_z() - chamber_wall / 2])
    cylinder(
      d = chamber_dome_roof_hole_d,
      h = chamber_wall + 1.2,
      center = true,
      $fn = 128
    );
}

module _chamber_dome_mount_screw_cut(center_x, center_y, sx, sy) {
  translate([
    center_x + sx * chamber_dome_mount_screw_xy_offset(),
    center_y + sy * chamber_dome_mount_screw_xy_offset(),
    chamber_total_z() - chamber_wall / 2
  ])
    cylinder(
      d = chamber_dome_mount_screw_clearance_d,
      h = chamber_wall + 1.2,
      center = true,
      $fn = 32
    );
}

module _chamber_dome_mount_screw_cuts(center_x, center_y) {
  for (sx = [-1, 1]) {
    for (sy = [-1, 1]) {
      _chamber_dome_mount_screw_cut(center_x, center_y, sx, sy);
    }
  }
}

module _chamber_display_void_cut(center_x) {
  translate([
    center_x,
    chamber_display_void_center_y(),
    chamber_display_void_center_z()
  ])
    rotate([chamber_profile_screen_face_angle() - 90, 0, 0])
      translate([
        0,
        (chamber_display_void_depth - chamber_display_void_cut_overlap()) / 2,
        0
      ])
        cube([
          chamber_display_void_x,
          chamber_display_void_depth + chamber_display_void_cut_overlap(),
          chamber_display_void_h
        ], center = true);
}

module _chamber_display_split_rail(side, seam_x) {
  rail_center_x = seam_x + side * chamber_display_seam_rail_w / 2;

  hull() {
    for (i = [0, 1]) {
      translate([
        rail_center_x,
        chamber_display_seam_rail_screw_y(i),
        chamber_display_seam_rail_screw_z(i)
      ])
        rotate([0, 90, 0])
          cylinder(
            d = chamber_display_seam_rail_d,
            h = chamber_display_seam_rail_w,
            center = true,
            $fn = 36
          );
    }
  }
}

module _chamber_display_split_rail_screw_cut(seam_x, i) {
  translate([
    seam_x,
    chamber_display_seam_rail_screw_y(i),
    chamber_display_seam_rail_screw_z(i)
  ])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_display_seam_rail_screw_clearance_d,
        h = 2 * chamber_display_seam_rail_w + 2 * chamber_wall,
        center = true,
        $fn = 32
      );
}

module _chamber_display_split_rail_screw_cuts(seam_x) {
  for (i = [0, 1]) {
    _chamber_display_split_rail_screw_cut(seam_x, i);
  }
}

module _chamber_display_mount_screw_cut(center_x, face_offset) {
  translate([
    center_x,
    chamber_display_void_center_y(),
    chamber_display_void_center_z()
  ])
    rotate([chamber_profile_screen_face_angle() - 90, 0, 0])
      translate([0, chamber_display_void_cut_overlap() / 2, face_offset])
        rotate([90, 0, 0])
          cylinder(
            d = chamber_display_mount_screw_clearance_d,
            h = chamber_display_void_cut_overlap() * 2,
            center = true,
            $fn = 36
          );
}

module _chamber_display_mount_screw_cuts(center_x) {
  for (sx = [-1, 1]) {
    for (sz = [-1, 1]) {
      _chamber_display_mount_screw_cut(
        center_x + sx * chamber_display_mount_screw_x_offset,
        sz * chamber_display_mount_screw_face_spacing / 2
      );
    }
  }
}

module _chamber_bolt_cut(joint_face_x, i) {
  translate([joint_face_x, chamber_bolt_y(i), chamber_bolt_z(i)])
    rotate([0, 90, 0])
      cylinder(
        d = chamber_joint_bolt_clearance_d,
        h = chamber_joint_boss_depth * 2 + chamber_wall * 4,
        center = true,
        $fn = 28
      );
}

module _chamber_joint_reinforcement(side, joint_face_x) {
  boss_center_x = joint_face_x + side * chamber_joint_boss_depth / 2;

  for (i = [0 : chamber_joint_passthrough_count - 1]) {
    translate([boss_center_x, chamber_passthrough_y(i), chamber_joint_center_z])
      rotate([0, 90, 0])
        difference() {
          cylinder(
            d = chamber_joint_ring_outer_d(),
            h = chamber_joint_boss_depth,
            center = true,
            $fn = 72
          );
          cylinder(
            d = chamber_joint_passthrough_d,
            h = chamber_joint_boss_depth + 0.4,
            center = true,
            $fn = 72
          );
        }
  }

  for (i = [0 : chamber_joint_bolt_count - 1]) {
    translate([boss_center_x, chamber_bolt_y(i), chamber_bolt_z(i)])
      rotate([0, 90, 0])
        cylinder(
          d = chamber_joint_bolt_boss_d,
          h = chamber_joint_boss_depth,
          center = true,
          $fn = 36
        );
  }
}

module _chamber_floor_label(center_x, label_text) {
  color([0.70, 0.70, 0.60, 1.0])
    translate([center_x, 0, chamber_bottom + 0.2])
      _label(label_text, 8, 0.35);
}

module _chamber_body(side, assembly_position, label_text) {
  center_x = assembly_position ? side * chamber_piece_x / 2 : 0;
  joint_face_x = assembly_position ? 0 : -side * chamber_piece_x / 2;
  model_x_offset = assembly_position ? 0 : -side * chamber_piece_x / 2;
  wedge_web_x = chamber_display_wedge_left_x() + model_x_offset;
  dome_roof_cut_x = chamber_dome_roof_center_x() + model_x_offset;
  display_void_cut_x = chamber_display_wedge_center_x() + model_x_offset;
  display_split_rail_x = model_x_offset;

  color(side < 0 ? [0.10, 0.105, 0.11, 0.88] : [0.12, 0.115, 0.10, 0.88])
    difference() {
      union() {
        _chamber_shell(side, center_x, assembly_position);
        _chamber_joint_reinforcement(side, joint_face_x);
        _chamber_display_split_rail(side, display_split_rail_x);
      }
      for (i = [0 : chamber_joint_passthrough_count - 1]) {
        _chamber_passthrough_cut(joint_face_x, i);
      }
      _chamber_display_void_cut(display_void_cut_x);
      _chamber_display_mount_screw_cuts(display_void_cut_x);
      _chamber_display_split_rail_screw_cuts(display_split_rail_x);
      if (side < 0) {
        for (i = [0 : chamber_joint_passthrough_count - 1]) {
          _chamber_passthrough_cut(wedge_web_x, i);
        }
        _chamber_dome_roof_cut(dome_roof_cut_x, chamber_dome_roof_center_y());
        _chamber_dome_mount_screw_cuts(dome_roof_cut_x, chamber_dome_roof_center_y());
      }
      for (i = [0 : chamber_joint_bolt_count - 1]) {
        _chamber_bolt_cut(joint_face_x, i);
      }
    }

  _chamber_floor_label(center_x, label_text);
}

module _label(text_value, size = 7, h = 0.35) {
  linear_extrude(height = h, center = false, convexity = 2)
    text(text_value, size = size, halign = "center", valign = "center");
}

module _case_body() {
  color([0.09, 0.095, 0.10, 0.62])
    _rounded_box(deck_x, deck_y, deck_h, deck_corner_r);

  color([0.18, 0.18, 0.17, 0.92])
    translate([0, 0, deck_top_z()])
      _rounded_box(deck_x - 8, deck_y - 8, top_panel_thickness, max(deck_corner_r - 4, 0));
}

module _front_exhaust() {
  color([0.02, 0.02, 0.018, 1.0])
    translate([opi_exhaust_center_x, opi_exhaust_center_y, deck_top_z() + top_panel_thickness + 0.15])
      cube([opi_exhaust_x, opi_exhaust_y, 0.7], center = true);

  color([0.72, 0.12, 0.08, 1.0])
    translate([opi_exhaust_center_x, opi_exhaust_center_y - opi_exhaust_y / 2 - 1.5, deck_top_z() + top_panel_thickness + 0.8])
      cube([opi_exhaust_x, 2.0, 1.0], center = true);

  for (i = [0 : opi_exhaust_slot_count - 1]) {
    slot_x =
      opi_exhaust_center_x
      - exhaust_total_x() / 2
      + opi_exhaust_slot_w / 2
      + i * exhaust_slot_pitch();
    color([0.0, 0.0, 0.0, 1.0])
      translate([slot_x, opi_exhaust_center_y, deck_top_z() + top_panel_thickness + 1.2])
        cube([opi_exhaust_slot_w, opi_exhaust_slot_y, 1.2], center = true);
  }
}

module _display_assembly() {
  rail_w = (display_rail_x - display_active_x) / 2;
  z0 = deck_top_z() + top_panel_thickness + 0.6;

  if (display_show_rack_rails) {
    color([0.02, 0.02, 0.024, 1.0])
      translate([display_center_x, display_center_y, z0])
        cube([display_active_x, display_active_y, display_raise_h], center = true);

    color([0.16, 0.16, 0.15, 1.0]) {
      translate([display_center_x - display_active_x / 2 - rail_w / 2, display_center_y, z0])
        cube([rail_w, display_rail_y, display_raise_h + 1.0], center = true);
      translate([display_center_x + display_active_x / 2 + rail_w / 2, display_center_y, z0])
        cube([rail_w, display_rail_y, display_raise_h + 1.0], center = true);
    }
  } else {
    color([0.02, 0.02, 0.024, 1.0])
      translate([display_center_x, display_center_y, z0])
        cube([display_visual_x(), display_visual_y(), display_raise_h + 1.0], center = true);
  }

  color([0.03, 0.45, 0.62, 1.0])
    translate([display_center_x, display_center_y, z0 + display_raise_h / 2 + 0.3])
      cube([display_active_x - 10, display_active_y - 10, 0.8], center = true);

  color([0.78, 0.78, 0.70, 1.0]) {
    bolt_span_x = display_show_rack_rails
      ? display_rail_x / 2 - display_bolt_inset_x
      : display_visual_x() / 2 - display_bolt_inset_x;
    bolt_span_y = display_show_rack_rails
      ? display_bolt_spacing_y / 2
      : display_visual_y() / 2 - display_bolt_inset_x;

    for (sx = [-1, 1]) {
      for (sy = [-1, 1]) {
        translate([
          display_center_x + sx * bolt_span_x,
          display_center_y + sy * bolt_span_y,
          z0 + display_raise_h / 2 + 1.0
        ])
          cylinder(d = display_bolt_d, h = 1.4, center = true, $fn = 28);
      }
    }
  }
}

module _keyboard_mockup() {
  z0 = deck_top_z() + top_panel_thickness + keyboard_h / 2 + 0.8;

  color([0.035, 0.036, 0.034, 1.0])
    translate([keyboard_center_x, keyboard_center_y, z0])
      cube([keyboard_unfolded_x, keyboard_unfolded_y, keyboard_h], center = true);

  for (i = [1 : keyboard_fold_sections - 1]) {
    fold_x = keyboard_center_x - keyboard_unfolded_x / 2 + i * keyboard_unfolded_x / keyboard_fold_sections;
    color([0.28, 0.28, 0.25, 1.0])
      translate([fold_x, keyboard_center_y, z0 + keyboard_h / 2 + 0.4])
        cube([2.0, keyboard_unfolded_y, 0.8], center = true);
  }

  color([0.14, 0.14, 0.13, 1.0])
    translate([keyboard_center_x, keyboard_center_y, z0 + keyboard_h / 2 + 0.7])
      cube([keyboard_folded_x, keyboard_folded_y, 0.9], center = true);

  color([0.58, 0.58, 0.52, 1.0])
    translate([keyboard_center_x, keyboard_center_y + keyboard_unfolded_y / 2 - 7, z0 + keyboard_h / 2 + 1.1])
      _label("SAMSERS FOLDING KEYBOARD", 6, 0.35);
}

module _eye_internal_apparatus() {
  base_z = deck_top_z() + top_panel_thickness + eye_base_ring_h;

  color([0.10, 0.10, 0.105, 1.0])
    translate([eye_center_x, eye_center_y, deck_top_z() + top_panel_thickness + eye_base_ring_h / 2])
      cylinder(d = eye_dome_d - eye_base_ring_w * 2, h = eye_base_ring_h, center = true, $fn = 96);

  color([0.28, 0.28, 0.26, 1.0])
    translate([eye_center_x, eye_center_y, base_z + 10])
      cylinder(d = 24, h = 20, center = true, $fn = 40);

  color([0.22, 0.22, 0.22, 1.0])
    translate([eye_center_x, eye_center_y, base_z + 26])
      cube([44, 9, 18], center = true);

  color([0.04, 0.04, 0.045, 1.0])
    translate([eye_center_x, eye_center_y - 8, base_z + 26])
      cube([eye_camera_x, 8, eye_camera_z], center = true);

  color([0.02, 0.02, 0.025, 1.0])
    translate([eye_center_x, eye_center_y - 13, base_z + 26])
      cylinder(d = 15, h = 3, center = true, $fn = 36);

  color([0.86, 0.06, 0.04, 1.0])
    translate([eye_center_x + 24, eye_center_y - 7, base_z + 27])
      rotate([90, 0, 0])
        cylinder(d = eye_laser_d, h = eye_laser_len, center = true, $fn = 24);
}

module _eye_dome() {
  dome_z = deck_top_z() + top_panel_thickness + eye_base_ring_h;

  color([0.03, 0.03, 0.032, 1.0])
    translate([eye_center_x, eye_center_y, deck_top_z() + top_panel_thickness + eye_base_ring_h / 2])
      difference() {
        cylinder(d = eye_dome_d + eye_base_ring_w, h = eye_base_ring_h, center = true, $fn = 128);
        cylinder(d = eye_dome_d - eye_base_ring_w, h = eye_base_ring_h + 0.2, center = true, $fn = 128);
      }

  _eye_internal_apparatus();

  color([0.58, 0.82, 0.98, 0.30])
    translate([eye_center_x, eye_center_y, dome_z])
      intersection() {
        sphere(d = eye_dome_d, $fn = 128);
        translate([0, 0, eye_dome_d / 4])
          cube([eye_dome_d, eye_dome_d, eye_dome_d / 2], center = true);
      }
}

module _meshtastic_eink_window() {
  z0 = deck_top_z() + top_panel_thickness + eink_window_h / 2 + 0.8;

  color([0.025, 0.026, 0.024, 1.0])
    translate([eink_center_x, eink_center_y, z0])
      cube([eink_window_x + 10, eink_window_y + 10, eink_window_h], center = true);

  color([0.82, 0.82, 0.72, 1.0])
    translate([eink_center_x, eink_center_y, z0 + eink_window_h / 2 + 0.3])
      cube([eink_window_x, eink_window_y, 0.8], center = true);

  color([0.10, 0.10, 0.09, 1.0])
    translate([eink_center_x, eink_center_y - 2, z0 + eink_window_h / 2 + 0.8])
      _label("MESH", 8, 0.35);
}

module _toggle(label_text, i) {
  y0 = toggle_y(i);
  x0 = toggle_x(i);
  z0 = deck_top_z() + top_panel_thickness;

  color([0.045, 0.045, 0.042, 1.0])
    translate([x0, y0, z0 + toggle_plate_h / 2 + 0.5])
      cube([toggle_plate_x, toggle_plate_y, toggle_plate_h], center = true);

  color([0.80, 0.76, 0.62, 1.0])
    translate([x0, y0, z0 + toggle_plate_h + toggle_lever_h / 2])
      rotate([14, 0, 0])
        cylinder(d = toggle_lever_d, h = toggle_lever_h, center = true, $fn = 20);

  color([0.58, 0.58, 0.50, 1.0])
    translate([x0, y0 - toggle_plate_y / 2 - 3.4, z0 + toggle_plate_h + 0.4])
      _label(label_text, 4.1, 0.3);
}

module _power_toggle_bank() {
  _toggle("MESH", 0);
  _toggle("OPI", 1);
  _toggle("SCRN", 2);
  _toggle("AI", 3);
}

module _proxy_board(name_text, center_x, center_y, size_x, size_y, size_z, body_color) {
  color(body_color)
    translate([center_x, center_y, size_z / 2 + 4])
      cube([size_x, size_y, size_z], center = true);

  color([0.85, 0.85, 0.72, 1.0])
    translate([center_x, center_y, size_z + 4.4])
      _label(name_text, 7, 0.35);
}

module _cell18650_bank() {
  start_x = cell_bank_center_x - ((cell18650_count - 1) * cell_pitch()) / 2;

  for (i = [0 : cell18650_count - 1]) {
    color([0.12, 0.23, 0.18, 0.78])
      translate([start_x + i * cell_pitch(), cell_bank_center_y, cell18650_d / 2 + 4])
        rotate([90, 0, 0])
          cylinder(d = cell18650_d, h = cell18650_len, center = true, $fn = 36);
  }

}

module _internal_hardware_layout() {
  _proxy_board(
    "ORANGE PI 5+",
    opi_proxy_center_x,
    opi_proxy_center_y,
    opi_proxy_x,
    opi_proxy_y,
    opi_proxy_z,
    [0.90, 0.36, 0.12, 0.74]
  );

  _proxy_board(
    "AI CORE",
    rpi_stack_center_x,
    rpi_stack_center_y,
    rpi_stack_proxy_x,
    rpi_stack_proxy_y,
    rpi_stack_proxy_z,
    [0.22, 0.42, 0.90, 0.62]
  );

  _proxy_board(
    "HACKRF",
    hackrf_center_x,
    hackrf_center_y,
    hackrf_proxy_x,
    hackrf_proxy_y,
    hackrf_proxy_z,
    [0.45, 0.28, 0.62, 0.65]
  );

  _proxy_board(
    "MESH",
    meshtastic_center_x,
    meshtastic_center_y,
    meshtastic_proxy_x,
    meshtastic_proxy_y,
    meshtastic_proxy_z,
    [0.20, 0.50, 0.32, 0.62]
  );

  _proxy_board(
    "GPS",
    gps_center_x,
    gps_center_y,
    gps_proxy_x,
    gps_proxy_y,
    gps_proxy_z,
    [0.18, 0.35, 0.18, 0.62]
  );

  _cell18650_bank();
}

module cyberdeck_top_layout_mockup() {
  _assert_dims();
  _case_body();
  _front_exhaust();
  _display_assembly();
  _keyboard_mockup();
  _eye_dome();
  _meshtastic_eink_window();
  _power_toggle_bank();
}

module cyberdeck_internal_layout_mockup() {
  _assert_dims();
  color([0.09, 0.095, 0.10, 0.26])
    _rounded_box(deck_x, deck_y, deck_h, deck_corner_r);
  _front_exhaust();
  _internal_hardware_layout();
}

module cyberdeck_two_chamber_structure() {
  _assert_dims();
  cyberdeck_left_chamber_body(true);
  cyberdeck_right_chamber_body(true);
}

module cyberdeck_left_chamber_body(assembly_position = false) {
  _assert_dims();
  _chamber_body(-1, assembly_position, "LEFT CHAMBER");
}

module cyberdeck_right_chamber_body(assembly_position = false) {
  _assert_dims();
  _chamber_body(1, assembly_position, "RIGHT CHAMBER");
}

module cyberdeck_visual_mockup() {
  _assert_dims();
  cyberdeck_internal_layout_mockup();
  cyberdeck_top_layout_mockup();
}
