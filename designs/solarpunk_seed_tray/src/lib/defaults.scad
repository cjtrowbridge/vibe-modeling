// Solarpunk seed tray — parametric surface and defaults (all dimensions in mm).
//
// Coordinate convention:
//   x: across the tray (cell columns)
//   y: front/back (cell rows); the bell bump-out defaults to the front long
//      side (y = 0, projects -y) toward the left (-x) end, per bumpout_side/
//      bumpout_end (the drain exit is on the bump-out's outer face)
//   z: vertical, floor bottom at z = 0
//
// Multi-size rule (docs/solarpunk_series.md §5.6): no size-derived constant may
// live in the geometry source. Every dimension below has an is_undef fallback
// (the 12-cell placeholder kit) so the model is self-contained and always
// renders; a config file overrides the subset it needs. Adding a size must NOT
// require editing this or the part source.
//
// Structural minimums (AGENTS.md §10) are size-independent and fixed here.

// --- Repository structural minimums (size-independent) -----------------------
minimum_wall_thickness      = 2.4;   // tentative — confirm at blockout
minimum_structural_overlap  = minimum_wall_thickness;

// --- Tray shell --------------------------------------------------------------
tray_outer_length    = is_undef(tray_outer_length)    ? 172.0 : tray_outer_length;
tray_outer_width     = is_undef(tray_outer_width)     ? 130.0 : tray_outer_width;
tray_outer_height    = is_undef(tray_outer_height)    ? 70.0  : tray_outer_height;
wall_thickness       = is_undef(wall_thickness)       ? 3.0   : wall_thickness;
floor_thickness      = is_undef(floor_thickness)      ? 3.0   : floor_thickness;
mask_thickness       = is_undef(mask_thickness)       ? 3.0   : mask_thickness; // opaque top deck
floor_slope          = is_undef(floor_slope)          ? 0.0   : floor_slope; // optional 1..2 deg
corner_radius        = is_undef(corner_radius)        ? 6.0   : corner_radius;

// Lid-mating rim (reproduces measured original rim geometry at blockout).
rim_width            = is_undef(rim_width)            ? 3.0   : rim_width;
rim_height           = is_undef(rim_height)           ? 4.0   : rim_height;
rim_overhang         = is_undef(rim_overhang)         ? 4.0   : rim_overhang;

// --- Insert ledge (supports the commodity plug tray) -------------------------
// insert_length/insert_width are the plug-tray OUTER footprint (the part that
// rests on the ledge ring). ledge_support_overlap is how far the ledge ring
// reaches UNDER the plug-tray rim (positive structural overlap, AGENTS.md §10).
insert_length            = is_undef(insert_length)            ? 160.0 : insert_length;
insert_width             = is_undef(insert_width)             ? 118.0 : insert_width;
insert_support_height    = is_undef(insert_support_height)    ? 30.0  : insert_support_height;
ledge_support_overlap    = is_undef(ledge_support_overlap)    ? 4.0   : ledge_support_overlap;
ledge_thickness          = is_undef(ledge_thickness)          ? 3.0   : ledge_thickness;

// --- Cell grid (data model: 3x4 and 3x2 are config-only variants) -----------
cell_columns         = is_undef(cell_columns)         ? 3 : cell_columns;
cell_rows            = is_undef(cell_rows)            ? 4 : cell_rows;
cell_pitch_x         = is_undef(cell_pitch_x)         ? 40.0 : cell_pitch_x;
cell_pitch_y         = is_undef(cell_pitch_y)         ? 30.0 : cell_pitch_y;
cell_opening_width   = is_undef(cell_opening_width)   ? 32.0 : cell_opening_width;
cell_opening_length  = is_undef(cell_opening_length)  ? 26.0 : cell_opening_length;

// --- Hydraulics / siphon -----------------------------------------------------
// maximum_flood_height is the RISER crest z (siphon exit / fill level) — the
// top of the central riser in the bell bump-out, capped by the commodity bell.
// The siphon exit diameter IS the riser bore (standpipe_inner_diameter) — the
// exit is in the center of the bell bore by construction.
maximum_flood_height   = is_undef(maximum_flood_height)   ? 65.0 : maximum_flood_height;
standpipe_inner_diameter = is_undef(standpipe_inner_diameter) ? 12.7 : standpipe_inner_diameter;
standpipe_wall         = is_undef(standpipe_wall)         ? 2.5 : standpipe_wall;
// drain_channel_height: axis z of the drain channel / outer-face drain port
// (connects the riser to the chamber, below the deck; light-blocking).
drain_channel_height   = is_undef(drain_channel_height)   ? 15.0 : drain_channel_height;
// How far into the flood chamber the drain channel reaches (its inner end).
chamber_reach          = is_undef(chamber_reach)          ? 8.0  : chamber_reach;

// --- Bell bump-out (siphon housing OUTSIDE the tray footprint) ---------------
// The siphon is a bump-out on a long side, toward one end, so it does not
// intersect the plug tray and trays tessellate on the shelf.
//   bumpout_side: 0 = front long side (y=0, projects -y), 1 = back (y=W, +y).
//   bumpout_end:  0 = left (-x, default), 1 = right (+x).
bumpout_side           = is_undef(bumpout_side)           ? 0 : bumpout_side;
bumpout_end            = is_undef(bumpout_end)            ? 0 : bumpout_end;
// Bore clearance for the ~8 cm bottle (bore slightly larger than the bottle).
bell_bore_diameter     = is_undef(bell_bore_diameter)     ? 90.0 : bell_bore_diameter;
bell_seat_wall         = is_undef(bell_seat_wall)         ? 3.0 : bell_seat_wall; // >= min
// Bell-seat (well) floor height; the riser passes through its center.
well_floor_z           = is_undef(well_floor_z)           ? 40.0 : well_floor_z;
// Support spines on the well floor, radiating out from the riser; the bottle
// base rests on the spine tips, leaving the flow ring open and setting the
// siphon-break cutoff as low as possible without restricting flow.
spine_count            = is_undef(spine_count)            ? 8 : spine_count;
spine_height           = is_undef(spine_height)           ? 5.0 : spine_height;
spine_width            = is_undef(spine_width)            ? 4.0 : spine_width; // >= min
spine_tip_r            = is_undef(spine_tip_r)            ? 38.0 : spine_tip_r;
// How far the well embeds into the tray wall (positive-volume join, AGENTS.md
// §10). Must be <= wall_thickness so the well stays outside the footprint.
well_embed             = is_undef(well_embed)             ? 3.0 : well_embed;
// How far the well center is from the chosen end (toward that end).
well_end_margin        = is_undef(well_end_margin)        ? 3.0 : well_end_margin;
// Well bottom elevation: the well solid spans to the base so the sub-deck
// drain channel and drain stub fuse into it with positive volume (AGENTS.md
// §10). The bell-seat floor is at well_floor_z (above the deck); the solid
// below it plugs the chamber-side join and carries the channel/stub.
well_base_z            = is_undef(well_base_z)            ? 0.0 : well_base_z;

// Drain outlet on the bump-out outer face (to the manifold).
drain_inner_diameter   = is_undef(drain_inner_diameter)   ? 12.7 : drain_inner_diameter;
drain_channel_wall     = is_undef(drain_channel_wall)     ? 2.5 : drain_channel_wall;
// Drain port height above the well floor (in the open flow ring).
drain_z_offset         = is_undef(drain_z_offset)         ? 3.0 : drain_z_offset;
// How far the drain port solid tube (and its bore) extends past the bump-out
// outer face (bore extends 1 mm further to cut a clean outlet).
drain_port_extend      = is_undef(drain_port_extend)      ? 1.0 : drain_port_extend;
elbow_clearance        = is_undef(elbow_clearance)        ? 0.0 : elbow_clearance;
feed_port_diameter     = is_undef(feed_port_diameter)     ? 6.35 : feed_port_diameter;
feed_socket_wall       = is_undef(feed_socket_wall)       ? 2.5 : feed_socket_wall;
// Feed socket on the deck, front-left.
feed_center_x          = is_undef(feed_center_x)          ? 20.0 : feed_center_x;
feed_center_y          = is_undef(feed_center_y)          ? 15.0 : feed_center_y;

// --- Support / platform ------------------------------------------------------
platform_clearance     = is_undef(platform_clearance)     ? 40.0 : platform_clearance;

// --- Reinforcement (count derived from size, never a fixed count) -----------
rib_width              = is_undef(rib_width)              ? 3.0 : rib_width;
rib_depth              = is_undef(rib_depth)              ? 2.0 : rib_depth;
rib_height_fraction    = is_undef(rib_height_fraction)    ? 0.5 : rib_height_fraction;
rib_pitch              = is_undef(rib_pitch)              ? 45.0 : rib_pitch;
