// Small utilities to keep parts readable.

module centered_cylinder(d, h) {
  translate([0, 0, -h / 2]) cylinder(d = d, h = h, $fn = 96);
}

module bolt_hole_through(d, h) {
  cylinder(d = d, h = h, $fn = 48);
}

