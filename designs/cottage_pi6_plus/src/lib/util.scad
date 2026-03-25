// Small utilities to keep parts readable.

module centered_cube(size_vec) {
  translate([-size_vec[0] / 2, -size_vec[1] / 2, -size_vec[2] / 2]) cube(size_vec, center = false);
}
