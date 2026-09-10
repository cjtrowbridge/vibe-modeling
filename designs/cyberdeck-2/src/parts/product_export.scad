// Geometry export for the assembled product: union of the four leaf bodies
// at their identity product positions (unrotated). This is the assembled STL
// artifact (product_assembly.stl) expected by the assembly contract
// (minimum span 254 x 80 x 254).

module product_assembly_export() {
  union() {
    leaf_bottom_left_body();
    leaf_bottom_right_body();
    leaf_top_right_body();
    leaf_top_left_body();
  }
}