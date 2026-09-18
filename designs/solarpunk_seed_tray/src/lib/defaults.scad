// Solarpunk seed tray — parametric surface and defaults (all dimensions in mm).
//
// Coordinate convention:
//   x: across the tray (cell columns)
//   y: front/back (cell rows); the rear wall (drain exit) is at +y
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

// --- Hydraulics --------------------------------------------------------------
// maximum_flood_height is the standpipe crest z (tower top / fill level). The
// tower rises ABOVE the deck so the commodity bell can cap it; the deck has a
// tower_access hole where it passes through.
maximum_flood_height   = is_undef(maximum_flood_height)   ? 42.0 : maximum_flood_height;
standpipe_inner_diameter = is_undef(standpipe_inner_diameter) ? 12.7 : standpipe_inner_diameter;
standpipe_wall         = is_undef(standpipe_wall)         ? 2.5 : standpipe_wall;
// Tower position: rear corner (open decision #1 lean), behind the edge cells.
tower_center_x         = is_undef(tower_center_x)         ? 110.0 : tower_center_x;
tower_center_y         = is_undef(tower_center_y)         ? 95.0 : tower_center_y;
drain_inner_diameter   = is_undef(drain_inner_diameter)   ? 12.7 : drain_inner_diameter;
drain_channel_wall     = is_undef(drain_channel_wall)     ? 2.5 : drain_channel_wall;
// Drain channel axis height: sits in the flood chamber, below the deck.
drain_channel_height   = is_undef(drain_channel_height)   ? 15.0 : drain_channel_height;
elbow_clearance        = is_undef(elbow_clearance)        ? 0.0 : elbow_clearance;
feed_port_diameter     = is_undef(feed_port_diameter)     ? 6.35 : feed_port_diameter;
feed_socket_wall       = is_undef(feed_socket_wall)       ? 2.5 : feed_socket_wall;
// Feed socket on the deck, front-left (diagonal to the rear drain).
feed_center_x          = is_undef(feed_center_x)          ? 20.0 : feed_center_x;
feed_center_y          = is_undef(feed_center_y)          ? 15.0 : feed_center_y;

// --- Support / platform ------------------------------------------------------
platform_clearance     = is_undef(platform_clearance)     ? 40.0 : platform_clearance;

// --- Reinforcement (count derived from size, never a fixed count) -----------
rib_width              = is_undef(rib_width)              ? 3.0 : rib_width;
rib_depth              = is_undef(rib_depth)              ? 2.0 : rib_depth;
rib_height_fraction    = is_undef(rib_height_fraction)    ? 0.5 : rib_height_fraction;
rib_pitch              = is_undef(rib_pitch)              ? 45.0 : rib_pitch;
