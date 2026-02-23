// Project defaults (all dimensions in mm)

// Part selector (set via -D part_id=0/1/2...)
// NOTE: OpenSCAD CLI `-D` string quoting on Windows is fragile; use numeric ids.
part_id = 0; // 0=feed_mount (legacy), 1=helical_former

// Known / assumed dish + packaging values
dish_diameter = 330;          // 13 in approx.
focus_length = 114;           // 4.5 in approx.
radome_headroom = 38;         // ~1.5 in nominal assumption (1â€“2 in range)

// Mechanical datum convention (all z positions are measured relative to this):
//   z=0 is the original plastic tube tip (focus reference).
//   The mount seat plane (metal post top) is at z=-mount_seat_to_focus.
mount_seat_to_focus = 33;

// Legacy measured values from the original Ku feed stack (still useful for reference):
tube_od = 33;                 // plastic tube OD (measured)
tube_length = 33;             // metal post top -> tube tip (measured) == mount_seat_to_focus

// Replacement mount interface: a short 33mm OD "stub" near the mount seat.
// This replaces the old slip-over fit (the helical former now carries the 33mm interface).
mount_stub_od = 33;
mount_stub_len = 6;

// Legacy / optional: clamp to metal post/tube (used by feed_mount prototype)
post_od = 45;                 // metal post/tube OD guess; adjustable clamp target
post_clearance = 0.8;         // extra clearance inside clamp

// Clamp geometry
clamp_wall = 4;
clamp_height = 25;
clamp_gap = 3;                // slit width for clamp
clamp_boss_d = 10;            // screw boss diameter
clamp_screw_d = 3.5;          // M3 clearance
clamp_screw_head_d = 7;       // button head clearance
clamp_screw_head_h = 3;

// Cable routing
cable_hole_d = 8;             // enough for a small SMA pigtail/coax
fillet_r = 0;                 // placeholder (OpenSCAD fillets are non-trivial; keep 0 by default)

// Helical former "clearance cylinder" (no grooves yet)
former_total_len = 66;        // overall height; driven/focus datum at z=0, mount seat at z=-33
former_outer_d = 60;          // packaging check; approximate helix former OD
former_wall = 2;              // thin shell wall thickness
