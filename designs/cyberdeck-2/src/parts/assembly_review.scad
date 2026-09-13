// Assembly review views (review_dispatch_id 90).
//   0  assembled product            6  top-front seam-station section
//   1  exploded product             7  bottom-front seam-station section
//   2..5 leaf isolation             8  left-front seam-station section
//        (2 bottom_left, 3          9  right-front seam-station section
//         bottom_right, 4           10 top-rear seam-station section
//         top_right, 5 top_left)    11 bottom-rear seam-station section
//                                12 left-rear seam-station section
//                                13 right-rear seam-station section
//                                14 rack rail section (right column,
//                                       30-hole front-wall pattern)
//                                15 bottom shelf section (shelf-to-wall
//                                       fusion)

module assembly_review(view_id = 0, proxies = true) {
  if (view_id == 0) {
    assembled_product(0, proxies);
  } else if (view_id == 1) {
    assembled_product(30, proxies);
  } else if (view_id >= 2 && view_id <= 5) {
    if (view_id == 2) leaf_bottom_left_body();
    else if (view_id == 3) leaf_bottom_right_body();
    else if (view_id == 4) leaf_top_right_body();
    else if (view_id == 5) leaf_top_left_body();
    if (proxies)
      color("lightblue")
        equipment_proxy();
  } else if (view_id >= 6 && view_id <= 13) {
    // Band-shaped section boxes that slice each ring band through its
    // station zone, front (tb Y 0..18, lr Y 6..24) and rear (both Y 62..80)
    // pads per ribbon, 0.03 overhang so no cut lands exactly on a face
    // plane.
    // top/bottom: Z band; left/right: X band.
    color("darkorange")
      intersection() {
        assembled_product(0, false);
        if (view_id == 6) // top front: Z in [111.0, 127.03], Y 0..18
          translate([-30.0, -0.03, 111.0])
            cube([60.0, station_tb_y1 + 0.06, 16.03], center = false);
        else if (view_id == 7) // bottom front: Z in [-127.03, -111.0], Y 0..18
          translate([-30.0, -0.03, -127.03])
            cube([60.0, station_tb_y1 + 0.06, 16.03], center = false);
        else if (view_id == 8) // left front: X in [-127.03, -111.0], Y 6..24
          translate([-127.03, station_lr_y0 - 0.03, -30.0])
            cube([16.03, station_lr_y1 - station_lr_y0 + 0.06, 60.0], center = false);
        else if (view_id == 9) // right front: X in [111.0, 127.03], Y 6..24
          translate([111.0, station_lr_y0 - 0.03, -30.0])
            cube([16.03, station_lr_y1 - station_lr_y0 + 0.06, 60.0], center = false);
        else if (view_id == 10) // top rear: Z in [111.0, 127.03], Y 62..80
          translate([-30.0, station_tb_y0_rear - 0.03, 111.0])
            cube([60.0, station_tb_y1_rear - station_tb_y0_rear + 0.06, 16.03], center = false);
        else if (view_id == 11) // bottom rear: Z in [-127.03, -111.0], Y 62..80
          translate([-30.0, station_tb_y0_rear - 0.03, -127.03])
            cube([60.0, station_tb_y1_rear - station_tb_y0_rear + 0.06, 16.03], center = false);
        else if (view_id == 12) // left rear: X in [-127.03, -111.0], Y 62..80
          translate([-127.03, station_lr_y0_rear - 0.03, -30.0])
            cube([16.03, station_lr_y1_rear - station_lr_y0_rear + 0.06, 60.0], center = false);
        else if (view_id == 13) // right rear: X in [111.0, 127.03], Y 62..80
          translate([111.0, station_lr_y0_rear - 0.03, -30.0])
            cube([16.03, station_lr_y1_rear - station_lr_y0_rear + 0.06, 60.0], center = false);
      }
  } else if (view_id == 14) {
    // Right rail: 3.5-thick slab through the X = +118.2625 column across the
    // full height, front face to the 5.8 land depth.
    color("darkorange")
      intersection() {
        assembled_product(0, false);
        translate([118.5, (rack_land_depth - 0.2) / 2.0, 0])
          cube([3.5, rack_land_depth + 0.2, case_width + 0.06], center = true);
      }
  } else if (view_id == 15) {
    // Bottom shelf band: full-width slab through Z [-114.125, -111.125],
    // showing the shelf-to-wall fusions at front and rear.
    color("darkorange")
      intersection() {
        assembled_product(0, false);
        translate([0, case_depth_exterior / 2.0, (shelf_bottom_z0 + shelf_bottom_z1) / 2.0])
          cube([case_width + 0.06, case_depth_exterior + 0.06, shelf_thickness + 0.06], center = true);
      }
  } else {
    assert(false, str("Unknown assembly view: ", view_id));
  }
}