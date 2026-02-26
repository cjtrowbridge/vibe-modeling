// Project defaults (all dimensions in mm)
//
// Coordinate convention for this part:
// - x: left/right across the two hole pairs
// - y: base depth, extending away from the back wall
// - z: height, measured from the bottom of the base
//
// The back wall begins at y=0 and the base extends in +y.
// Base thickness is modeled from z=0..plate_thickness.

// Part selector (set via -D part_id=0/1/2...)
// NOTE: Numeric ids are safer than strings across shells/OSes.
part_id = 0; // 0=winegard_gm6000_logic_backplane

// Core geometry
plate_thickness = 2;
mount_hole_d = 4;

// Hole pattern
left_right_hole_spacing = 195;      // center-to-center, left to right
bottom_hole_from_back_edge = 15;    // base hole center from bend/back edge (y=0)
back_hole_from_base_bottom = 143;   // back hole center from bottom of base (z=0)
back_hole_outboard_offset = 5;      // shift each back-wall hole outward (+x/-x) relative to base-hole columns

// Outer edge extents beyond hole edges (first-pass assumptions)
side_edge_margin = 5;   // left/right beyond hole outer edges
front_edge_margin = 5;  // base front edge beyond base-hole outer edge
top_edge_margin = 5;    // back top edge beyond back-hole outer edge
box_depth_extension = 5; // extend the box/base depth further from the back without re-centering SMA holes

// Internal box-section reinforcement (open front)
// Ribs are placed inboard of the left/right hole columns; the nearest rib face
// is offset from the hole edge by this clearance (defaults to the side margin).
inner_rib_thickness = 2;
inner_rib_hole_clearance = 5;

// SMA bulkhead pass-through holes (typical clearance; adjust for actual hardware)
sma_bulkhead_hole_d = 6.5;
sma_top_hole_from_box_left = 50;       // top-panel hole center from left box wall outer face
sma_right_hole_from_box_top = 20;      // right-side hole center down from top edge

// Restored backplane area for Raspberry Pi mounting (vertical patch on the back face at y=0)
show_pi_mount_back_patch = true;
pi_mount_back_patch_w = 90;
pi_mount_back_patch_h = 60;
pi_mount_back_patch_z0 = 0;                 // bottom of patch from base bottom
pi_mount_back_patch_on_user_right = true;   // user-facing right (mirrored in model x-axis)

// Rendering quality for round holes
hole_fn = 64;
