module assembly_review(view_id = 0, proxies = true) {
  if (view_id == 0) {
    assembled_product(0, proxies);
  } else if (view_id == 1) {
    rotate([90, 0, 0]) assembled_product(0, proxies);
  } else if (view_id == 2) {
    rotate([0, 90, 0]) assembled_product(0, proxies);
  } else {
    assert(false, str("Unknown assembly view: ", view_id));
  }
}
