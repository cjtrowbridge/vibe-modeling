include <../../designs/cyberdeck/src/lib/defaults.scad>;
include <../../designs/cyberdeck/src/parts/cyberdeck.scad>;

section_x = is_undef(section_x) ? chamber_display_wedge_center_x() : section_x;
section_width = 1.0;

intersection() {
  cyberdeck_two_chamber_structure();
  translate([
    section_x - section_width / 2,
    -chamber_piece_y / 2,
    chamber_total_z() - 2
  ])
    cube([
      section_width,
      chamber_piece_y,
      chamber_profile_peak_rise + 4
    ], center = false);
}
