// lovelace primitive power extender v0.0.1
// Registry-driven starter implementation:
// - removable bottom plate with lower holders
// - upper shell with mirrored upper holders
// - rotor set generated from the same registry

$fn = 48;

eps = 0.01;

// Envelope + printability defaults (aligned with README draft).
cube_side = 40.0;
cube_wall_t = 2.4;
top_t = 2.4;
bottom_plate_t = 3.0;
holder_rib_t = 2.0;
holder_seat_t = 2.0;
rotor_radial_clearance = 0.25;
coupler_slip_clearance = 0.25;

// Coupler and magnet defaults.
coupler_len = 6.0;
coupler_outer_d = 9.0;
magnet_d = 4.2;           // hole diameter for nominal 4 mm magnets (+clearance)
magnet_depth = 2.0;
magnet_corner_offset_y = 5.0;
magnet_corner_offset_z = 5.0;

// Rotor registry entry indexes.
IDX_NAME = 0;
IDX_AXIS = 1;
IDX_CENTER = 2;
IDX_DIAMETER = 3;
IDX_SPAN = 4;

// v0.0.1 starter registry: single power rotor crossing left-right.
rotor_registry = [
    ["power_main", "x", [0, 0, cube_side / 2], 6.0, cube_side - 2 * cube_wall_t]
];

function rotor_name(r) = r[IDX_NAME];
function rotor_axis(r) = r[IDX_AXIS];
function rotor_center(r) = r[IDX_CENTER];
function rotor_diameter(r) = r[IDX_DIAMETER];
function rotor_span(r) = r[IDX_SPAN];

function holder_tunnel_d(r) = rotor_diameter(r) + 2 * rotor_radial_clearance;
function coupler_base_r(r) = rotor_diameter(r) / 2 + 0.8;
function coupler_tip_r(r) = max(1.6, coupler_base_r(r) - 1.2);

module primitive_power_extender_0_0_1(show_bottom = true, show_shell = true, show_rotors = true) {
    if (show_bottom) {
        color([0.82, 0.84, 0.88]) bottom_plate(rotor_registry);
    }

    if (show_shell) {
        color([0.92, 0.92, 0.95]) upper_shell(rotor_registry);
    }

    if (show_rotors) {
        color([0.75, 0.57, 0.35]) rotor_set(rotor_registry);
    }
}

module bottom_plate(registry) {
    union() {
        translate([-cube_side / 2, -cube_side / 2, 0])
            cube([cube_side, cube_side, bottom_plate_t]);

        for (r = registry) {
            lower_holder_from_rotor(r);
        }
    }
}

module upper_shell(registry) {
    union() {
        difference() {
            outer_shell_body();
            inner_cavity_cutout();

            for (r = registry) {
                rotor_passage_cutout(r);
                coupler_face_port_cutout(r);
            }

            side_face_magnet_recesses();
        }

        for (r = registry) {
            upper_holder_from_rotor(r);
        }
    }
}

module outer_shell_body() {
    translate([-cube_side / 2, -cube_side / 2, bottom_plate_t])
        cube([cube_side, cube_side, cube_side - bottom_plate_t]);
}

module inner_cavity_cutout() {
    inner_side = cube_side - 2 * cube_wall_t;
    cavity_h = cube_side - bottom_plate_t - top_t + eps;

    translate([-inner_side / 2, -inner_side / 2, bottom_plate_t])
        cube([inner_side, inner_side, cavity_h]);
}

module rotor_passage_cutout(r) {
    c = rotor_center(r);

    if (rotor_axis(r) == "x") {
        translate(c)
            rotate([0, 90, 0])
                cylinder(h = cube_side + 2 * eps, d = holder_tunnel_d(r) + 0.6, center = true);
    }
}

module coupler_face_port_cutout(r) {
    c = rotor_center(r);

    if (rotor_axis(r) == "x") {
        for (x_sign = [-1, 1]) {
            translate([x_sign * (cube_side / 2 - cube_wall_t / 2), c[1], c[2]])
                rotate([0, 90, 0])
                    cylinder(
                        h = cube_wall_t + 2 * eps,
                        d = coupler_outer_d + 2 * coupler_slip_clearance,
                        center = true
                    );
        }
    }
}

module side_face_magnet_recesses() {
    for (x_sign = [-1, 1]) {
        for (y_sign = [-1, 1]) {
            for (z_sign = [-1, 1]) {
                translate([
                    x_sign * (cube_side / 2 - magnet_depth / 2),
                    y_sign * (cube_side / 2 - magnet_corner_offset_y),
                    z_sign * (cube_side / 2 - magnet_corner_offset_z)
                ])
                    rotate([0, 90, 0])
                        cylinder(h = magnet_depth + eps, d = magnet_d, center = true);
            }
        }
    }
}

module lower_holder_from_rotor(r) {
    c = rotor_center(r);

    if (rotor_axis(r) == "x") {
        holder_len = rotor_span(r);
        holder_w = holder_tunnel_d(r) + 2 * holder_rib_t;
        holder_h = max(holder_seat_t * 2, c[2] - bottom_plate_t + holder_seat_t);

        translate([c[0], c[1], bottom_plate_t + holder_h / 2])
            difference() {
                cube([holder_len, holder_w, holder_h], center = true);

                translate([0, 0, c[2] - (bottom_plate_t + holder_h / 2)])
                    rotate([0, 90, 0])
                        cylinder(h = holder_len + 2 * eps, d = holder_tunnel_d(r), center = true);
            }
    }
}

module upper_holder_from_rotor(r) {
    c = rotor_center(r);
    z_top_inner = cube_side - top_t;

    if (rotor_axis(r) == "x") {
        holder_len = rotor_span(r);
        holder_w = holder_tunnel_d(r) + 2 * holder_rib_t;
        holder_h = max(holder_seat_t * 2, z_top_inner - c[2] + holder_seat_t);

        translate([c[0], c[1], z_top_inner - holder_h / 2])
            difference() {
                cube([holder_len, holder_w, holder_h], center = true);

                translate([0, 0, c[2] - (z_top_inner - holder_h / 2)])
                    rotate([0, 90, 0])
                        cylinder(h = holder_len + 2 * eps, d = holder_tunnel_d(r), center = true);
            }
    }
}

module rotor_set(registry) {
    for (r = registry) {
        rotor_from_registry(r);
    }
}

module rotor_from_registry(r) {
    c = rotor_center(r);

    if (rotor_axis(r) == "x") {
        // Main through-shaft.
        translate(c)
            rotate([0, 90, 0])
                cylinder(h = rotor_span(r), d = rotor_diameter(r), center = true);

        // Right-side convex keyed coupler (output).
        translate([c[0] + rotor_span(r) / 2, c[1], c[2]])
            rotate([0, 90, 0])
                keyed_male_coupler(coupler_len, coupler_base_r(r), coupler_tip_r(r));

        // Left-side concave keyed coupler (input).
        translate([c[0] - rotor_span(r) / 2, c[1], c[2]])
            rotate([0, -90, 0])
                keyed_female_coupler(coupler_len, coupler_outer_d / 2, coupler_base_r(r), coupler_tip_r(r), coupler_slip_clearance);
    }
}

module keyed_male_coupler(len, r_base, r_tip) {
    // Hex/frustum profile approximates a printable keyed "toothed cone".
    cylinder(h = len, r1 = r_base, r2 = r_tip, center = false, $fn = 6);
}

module keyed_female_coupler(len, outer_r, male_r_base, male_r_tip, slip_clearance) {
    difference() {
        cylinder(h = len, r = outer_r, center = false, $fn = 32);
        translate([0, 0, -eps])
            cylinder(
                h = len + 2 * eps,
                r1 = male_r_tip + slip_clearance,
                r2 = male_r_base + slip_clearance,
                center = false,
                $fn = 6
            );
    }
}

// Default preview.
primitive_power_extender_0_0_1();
