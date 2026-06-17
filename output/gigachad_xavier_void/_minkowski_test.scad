difference() {
  minkowski() {
    import("gigachad 2.stl", convexity=10);
    sphere(r=0.2, $fn=12);
  }
  translate([0,-30,40]) import("gigachad_xavier_simple_void.stl", convexity=10);
}
