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

module cyberdeck_visual_mockup() {
  _assert_dims();
  cyberdeck_internal_layout_mockup();
  cyberdeck_top_layout_mockup();
}
