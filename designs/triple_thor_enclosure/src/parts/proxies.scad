module thor_proxy() {
  color("lightblue")
    translate([0, 0, 0])
      cube([thor_w, thor_d, thor_h], center = true);
}

module cylinder_proxy() {
  color("gray")
    translate([0, 0, cyl_h / 2])
      cylinder(h = cyl_h, r = cyl_outer_r, center = true);
}

module assembled_product(explode = 0, show_proxies = true) {
  if (show_proxies) {
    translate([0, 0, explode]) thor_proxy();
    translate([0, 0, explode * 0.5]) cylinder_proxy();
  }
}
