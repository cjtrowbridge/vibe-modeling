include <lib/defaults.scad>;
include <parts/cyberdeck.scad>;

color([0.78, 0.62, 0.08, 1])
  _chamber_keyboard_lid_support_rail(
    chamber_dome_roof_right_x(),
    0,
    chamber_keyboard_lid_front_edge_y(),
    chamber_keyboard_lid_back_edge_y,
    true
  );
