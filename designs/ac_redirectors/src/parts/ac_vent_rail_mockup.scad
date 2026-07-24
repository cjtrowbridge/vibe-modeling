// Reference-only mockup of the measured AC vent, top ledge, and mounting rail.
// This artifact is an interface/checking aid, not a replacement appliance part.

module _validate_ac_mockup_parameters() {
  assert(
    mockup_vent_width > 0,
    "Mockup vent width must be positive."
  );
  assert(
    mockup_clear_outlet_height > 0
      && mockup_clear_outlet_height
        < ac_inlet_lower_datum_to_rail_base,
    "Clear outlet must fit below the measured AC top datum."
  );
  assert(
    mockup_vent_face_to_rail_front
      >= mockup_outlet_recess_depth + rail_depth,
    "Measured ledge depth cannot contain the outlet recess and rail."
  );
  assert(
    mockup_casing_skin >= minimum_wall_thickness,
    "Mockup casing skin is below the structural modeling minimum."
  );
  assert(
    rail_thickness >= minimum_wall_thickness,
    "Mockup rail thickness is below the structural modeling minimum."
  );
}

module _mockup_casing() {
  lower_datum_z = 0;
  outlet_bottom_z = wall_thickness;
  outlet_top_z =
    outlet_bottom_z + mockup_clear_outlet_height;
  casing_top_z = ac_inlet_lower_datum_to_rail_base;
  back_y =
    -mockup_vent_face_to_rail_front
    - rail_thickness;

  difference() {
    // The sloped upper face approximates the photographed molded outlet hood.
    rotate([0, -90, 0])
      linear_extrude(
        height = mockup_vent_width,
        center = true,
        convexity = 10
      )
        polygon(points = [
          [lower_datum_z, back_y],
          [lower_datum_z, 0],
          [outlet_top_z, 0],
          [casing_top_z, -10],
          [casing_top_z, back_y]
        ]);

    // Shallow open-front recess marks the measured 406 x 50 mm airflow area.
    translate([
      -mockup_vent_width / 2 - 1,
      -mockup_outlet_recess_depth,
      outlet_bottom_z
    ])
      cube([
        mockup_vent_width + 2,
        mockup_outlet_recess_depth + 1,
        mockup_clear_outlet_height
      ]);
  }
}

module _mockup_rail() {
  rail_front_y = -mockup_vent_face_to_rail_front;
  rail_base_z = ac_inlet_lower_datum_to_rail_base;

  union() {
    // Vertical flange.
    translate([
      -mockup_vent_width / 2,
      rail_front_y - rail_thickness,
      rail_base_z
    ])
      cube([
        mockup_vent_width,
        rail_thickness,
        rail_flange_height
      ]);

    // Lower mounting foot and upper rolled-lip envelope extend rearward,
    // toward the wood side of the installation. The 10 mm depths are
    // assumptions retained from the original prompt, not direct photo reads.
    translate([
      -mockup_vent_width / 2,
      rail_front_y
        - mockup_rail_lip_depth
        - rail_thickness,
      rail_base_z - rail_thickness
    ])
      cube([
        mockup_vent_width,
        mockup_rail_lip_depth + rail_thickness,
        2 * rail_thickness
      ]);

    translate([
      -mockup_vent_width / 2,
      rail_front_y
        - mockup_rail_lip_depth
        - rail_thickness,
      rail_top_z - rail_thickness
    ])
      cube([
        mockup_vent_width,
        mockup_rail_lip_depth + rail_thickness,
        rail_thickness
      ]);
  }
}

module ac_vent_rail_mockup() {
  _validate_ac_mockup_parameters();

  union() {
    _mockup_casing();
    _mockup_rail();
  }
}
