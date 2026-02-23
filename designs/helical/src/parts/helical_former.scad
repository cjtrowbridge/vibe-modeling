include <../lib/util.scad>;

// Helical former (prototype geometry):
// - Focus datum: z=0 (original plastic tube tip).
// - Mount seat: z=-mount_seat_to_focus (original metal post top).
//
// This replaces the old slip-over sleeve:
// instead of a 33mm ID bore, this part includes a short 33mm OD mount stub and
// transitions into a thin-walled larger-diameter former cylinder.

module helical_former() {
  seat_z = -mount_seat_to_focus;
  stub_top_z = seat_z + mount_stub_len;
  former_h = max(0, former_total_len - mount_stub_len);

  difference() {
    union() {
      // Mount stub (33mm OD) near the seat plane to mate with the dish mount.
      translate([0, 0, seat_z]) cylinder(d = mount_stub_od, h = mount_stub_len, $fn = 128);

      // Thin-walled former cylinder above the stub.
      translate([0, 0, stub_top_z]) cylinder(d = former_outer_d, h = former_h, $fn = 128);
    }

    // Hollow out the former (leave the mount stub solid except for the cable hole).
    inner_d = max(0.1, former_outer_d - 2 * former_wall);
    translate([0, 0, stub_top_z - 0.01])
      cylinder(d = inner_d, h = former_h + 0.02, $fn = 128);

    // Cable/pigtail path down into the metal shaft.
    translate([0, 0, seat_z - 1])
      cylinder(d = cable_hole_d, h = former_total_len + 2, $fn = 96);
  }
}

