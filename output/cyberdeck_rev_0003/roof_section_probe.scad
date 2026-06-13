include <../../designs/cyberdeck/src/lib/defaults.scad>;
include <../../designs/cyberdeck/src/parts/cyberdeck.scad>;

section_y = is_undef(section_y) ? 55.3 : section_y;
section_depth = 1.0;

intersection() {
  cyberdeck_two_chamber_structure();
  translate([
    -chamber_piece_x,
    section_y - section_depth / 2,
    chamber_io_panel_frame_bottom_z() - 1
  ])
    cube([
      2 * chamber_piece_x,
      section_depth,
      chamber_io_panel_frame_h + 3
    ], center = false);
}
