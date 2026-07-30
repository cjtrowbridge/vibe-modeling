// Design-owned resolved rack datums.
// Source: ten-inch-rack-m3-printed-design-spec v2.0.0
// Bundle manifest SHA-256:
// 330051136930b54f0abf91ff81ea217d0e6cad2dbe6503375ffb219e59e0210d

RACK_U_PITCH_V2 = 44.45;
RACK_HOLE_SEQUENCE_V2 = [15.875, 15.875, 12.700];
RACK_RAIL_COLUMN_SPACING_X_V2 = 236.525;
RACK_FRONT_WIDTH_V2 = 254.0;
RACK_CLEAR_OPENING_V2 = 222.25;
RACK_EQUIPMENT_WIDTH_MAX_V2 = 220.0;
M3_STACKUP_HOLE_D_V2 = 3.6;
M3_ISO_7089_WASHER_OD_V2 = 7.0;
M3_WASHER_SEAT_D_V2 = 8.25;
M3_INSERT_FINISHED_HOLE_D_V2 = 4.0;
M3_INSERT_NOMINAL_LENGTH_V2 = 5.7;

function rack_height_for_u(u_count) = u_count * RACK_U_PITCH_V2;
function rack_rail_column_x(side) = side * RACK_RAIL_COLUMN_SPACING_X_V2 / 2;
function rack_hole_z(index) =
  -rack_clear_height / 2 + rack_hole_bottom_margin
  + floor(index / 3) * RACK_U_PITCH_V2
  + (index % 3 == 0 ? 0 : index % 3 == 1 ? RACK_HOLE_SEQUENCE_V2[0]
                                           : RACK_HOLE_SEQUENCE_V2[0] + RACK_HOLE_SEQUENCE_V2[1]);

module resolved_rack_datum_assertions() {
  assert(abs(rack_front_width - RACK_FRONT_WIDTH_V2) < 0.001,
         "RACK: configured front width differs from selected v2.0.0 datum");
  assert(abs(rack_clear_opening_width - RACK_CLEAR_OPENING_V2) < 0.001,
         "RACK: configured clear opening differs from selected v2.0.0 datum");
  assert(abs(rack_equipment_width_max - RACK_EQUIPMENT_WIDTH_MAX_V2) < 0.001,
         "RACK: configured equipment width differs from selected v2.0.0 baseline");
  assert(abs(rack_u_pitch - RACK_U_PITCH_V2) < 0.001,
         "RACK: configured U pitch differs from selected v2.0.0 datum");
  assert(abs(rack_insert_finished_diameter - M3_INSERT_FINISHED_HOLE_D_V2) < 0.001,
         "FAST-M3: rack insert hole differs from selected provisional baseline");
  assert(abs(rack_insert_nominal_length - M3_INSERT_NOMINAL_LENGTH_V2) < 0.001,
         "FAST-M3: rack insert length differs from selected provisional baseline");
  assert(abs(rack_hole_z(3) - rack_hole_z(2) - RACK_HOLE_SEQUENCE_V2[2]) < 0.001,
         "RACK: inter-U hole gap must remain 12.700 mm");
  children();
}
