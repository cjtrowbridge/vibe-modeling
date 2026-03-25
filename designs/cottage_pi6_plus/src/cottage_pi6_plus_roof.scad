// Direct entrypoint for printing the cottage roof as a standalone part.
// Usage example:
//   openscad -o cottage_pi6_plus_roof.stl designs/cottage_pi6_plus/src/cottage_pi6_plus_roof.scad

include <lib/defaults.scad>;
include <parts/cottage_pi6_plus.scad>;

cottage_pi6_plus_roof();
