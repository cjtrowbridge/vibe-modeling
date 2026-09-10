// Assembly review views (review_dispatch_id 90).
//   0  assembled product            6  top seam-station section
//   1  exploded product             7  bottom seam-station section
//   2..5 leaf isolation             8  left seam-station section
//        (2 bottom_left, 3          9  right seam-station section
//         bottom_right, 4           10 rack rail section (right column,
//         top_right, 5 top_left)        30-hole front-wall pattern)
//                                11 bottom shelf section (shelf-to-wall
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
  } else if (view_id >= 6 && view_id <= 9) {
    // Band-shaped section boxes that slice each ring band through its station
    // zone (top/bottom: Z band, Y 0..18; left/right: X band, Y 10..28),
    // 0.03 overhang so no cut lands exactly on a face plane.
    color("darkorange")
      intersection() {
        assembled_product(0, false);
        if (view_id == 6) // top: Z in [111.0, 127.03]
          translate([-30.0, -0.03, 111.0])
            cube([60.0, station_tb_y1 + 0.06, 16.03], center = false);
        else if (view_id == 7) // bottom: Z in [-127.03, -111.0]
          translate([-30.0, -0.03, -127.03])
            cube([60.0, station_tb_y1 + 0.06, 16.03], center = false);
        else if (view_id == 8) // left: X in [-127.03, -111.0]
          translate([-127.03, -0.03, -30.0])
            cube([16.03, station_lr_y1 + 0.06, 60.0], center = false);
        else if (view_id == 9) // right: X in [111.0, 127.03]
          translate([111.0, -0.03, -30.0])
            cube([16.03, station_lr_y1 + 0.06, 60.0], center = false);
      }
  } else if (view_id == 10) {
    // Right rail: 3.5-thick slab through the X = +118.2625 column across the
    // full height, front face to the 5.8 land depth.
    color("darkorange")
      intersection() {
        assembled_product(0, false);
        translate([118.5, (rack_land_depth - 0.2) / 2.0, 0])
          cube([3.5, rack_land_depth + 0.2, case_width + 0.06], center = true);
      }
  } else if (view_id == 11) {
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