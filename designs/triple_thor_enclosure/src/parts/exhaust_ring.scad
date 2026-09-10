module exhaust_ring_body() {
  difference() {
    rotate_extrude(angle = 120) {
      polygon([
        [exhaust_ring_r_in, 0],
        [exhaust_ring_r_out, 0],
        [exhaust_ring_r_out, exhaust_ring_h],
        [exhaust_ring_r_in, exhaust_ring_h]
      ]);
    }

    translate([0, 0, -0.1])
      rotate_extrude(angle = 120) {
        polygon([
          [0, 0],
          [fan_od / 2, 0],
          [fan_od / 2, exhaust_ring_h],
          [0, exhaust_ring_h]
        ]);
      }
  }
}

module exhaust_ring_print() {
  exhaust_ring_body();
}
