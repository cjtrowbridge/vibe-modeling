---
plan_id: 2026-09-09-19-21-26_create-cyberdeck-2-5u-enclosure
title: Create cyberdeck-2 5U fully-enclosed rack case
summary: Build a new 5U ten-inch-rack case (254 x 254 x 80 mm), fully enclosed except the 222.25 x 222.25 mm rack opening, split into four printable quadrant leaves joined by four M3 captive-nut registration seam stations located in the ring band between the rack clear opening and the case edge.
status: current
created_at: 2026-09-09-19-21-26
---

# Create cyberdeck-2 5U fully-enclosed rack case

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

User requirement (verbatim intent): a 5U rack case, reference documents
governing rack geometry; fully enclosed on all sides except the rack opening;
split into several printable parts; seam-join tabs from the
engineering references folder ("M3 captive-nut registration seam station",
`references/engineering/fasteners/m3_captive_nut_registration_seam_stations.md`);
joins located in between the rack clearances and the edge of the case; overall
case 80 mm deep behind the rack.

This is a fresh lineage. The 2026-09-07 deletion plan
(`plans/past/2026-09-07-19-58-16_remove-cyberdeck-2.md`) removed the old
cyberdeck-2 design; this plan derives NO geometry, dimension, or mechanic from
the deleted design. All geometry derives solely from: the two reference
packages named in §0 (v2.0.0 rack spec; M3 captive-nut registration seam
station STARTING PROFILE, physically unverified) and the user constraints
recorded above (5U, fully enclosed except the rack opening, several printable
split pieces, in-band joins, 80 mm depth).

## 0. Precedence for the interpretations below

- Rack geometry: `references/engineering/ten_inch_rack/v2.0.0`
  (`ten-inch-rack-m3-printed-design-spec`, v2.0.0) via the
  `working_with_ten_inch_racks.md` playbook (copy/adapt SCAD, never import
  from `references/`; flatten scalars into config with `rack_spec_version`).
- Seam station: `m3_captive_nut_registration_seam_stations.md` starting profile.
- Structural, split-print, artifact, and assembly-review playbooks per
  `AGENTS.md`.

## 1. Locked geometry (approval gate)

### 1.1 Envelope (proposed; confirm at approval)

- Product face: `254.0 mm` (X) x `254.0 mm` (Z) square; depth `80.0 mm` (Y,
  front plane `Y = 0`, rear exterior face `Y = 80.0`).
- Interpretation A for "80 mm deep behind the rack" (proposed, default):
  total exterior depth 80.0 mm including the 3.0 mm rear wall; internal
  chamber depth 77.0 mm. Interpretation B (internal 80 / exterior 83) is
  rejected only if the user objects at approval.
- Interpretation A for total height (proposed, default): `254.0 mm` outer
  height giving a uniform `15.875 mm` ring on all four sides of the opening
  (top and bottom rings required so that seam stations exist in the band
  between the rack clear openings and the case edge on both seam planes).
- 5U face per v2.0.0: `rack_height_u = 5`, `u_pitch = 44.45`, clear opening
  `222.25 x 222.25 mm` (X x Z), centered on the rack centerline `X = 0`.
- Minimum wall / structural overlap / internal edge: `3.0` / `3.0` / `3.0`;
  `boolean_epsilon = 0.02`.
- `rack_internal_depth` is specification-level UNKNOWN; it is resolved here by
  the user-mandated 80 mm case depth and recorded as such in the design report.

### 1.2 Print-fit rationale (lock: four-leaf split)

- No axis > 220.0 mm printable (print bed 220, reserve 5 enforced in code).
- Any single- or double-way split of a 254 x 254 face yields a part > 127 mm
  spanning the opening plus ring; with the 15.875 mm ring, a two-way split
  still leaves 127 + station growth, but a Z-only or X-only split leaves one
  254 mm span -> unprintable. Therefore: four quadrant leaves via seam planes
  `X = 0` and `Z = 0`.
- Four leaf identities (printable leaves, one per quadrant):
  `leaf_bottom_left` (X<0, Z<0), `leaf_bottom_right` (X>0, Z<0),
  `leaf_top_right` (X>0, Z>0), `leaf_top_left` (X<0, Z>0).
- Each leaf nominal bounds: `127 x 80 x 127` mm (plus station pads, all
  interior/flush); each leaf prints flat on its `127 x 127` face, `80 mm`
  tall, seam faces vertical.
- Canonical decomposition (locked):
  - Product assembly: `product_assembly` = the complete cyberdeck-2 case.
  - Logical subassemblies: `enclosure_assembly` only (no other serviceable
    components are part of this design; the 10-inch rack and equipment are
    external to this product).
  - Printable leaves: the four quadrant leaves above.
  - Prohibited: no removable front port plate, no top plate, no second
    subassembly, unless added by a future approved plan.

### 1.3 Seam station layout (lock: 4 stations, one per seam, all in-band)

- Requirement mapping: "the joins should fit in between the rack clearances and
  the edge of the case" = every station lies radially INSIDE the 15.875 mm ring
  band between the clear-opening edge (+/-111.125) and the exterior case face
  (+/-127.0), flush with the 254 x 254 case silhouette (no raised bosses, no
  pads protruding from any exterior face).
- Radial (fastener-axis) stack per station, exterior face -> opening edge,
  total EXACTLY 15.875 (asserted in 2.1): head/washer recess 3.8 (button
  head 3.0 + ISO 7089 washer 0.5, head top 0.3 below the exterior face --
  the 0.3 spare; the washer bottom bears on the slab top face, which is
  flush with the recess floor at 3.8) + tongue slab 3.0 (the reference slab
  cross section, RETAINED), top face FLUSH with the recess floor at 3.8
  (washer annulus bears directly on the slab around the 3.6 passage -- the
  slab is FIXED here, not floating) + axial fit void 0.7 below the slab
  (deliberate printed clearance between slab bottom and socket bottom
  wall; fit tolerance, not structure) + receiver wall 5.575 (the 3.6
  passage bored through it) + captive nut pocket 2.8 (6.816 circumscribed
  dia for the 5.9 AF x 2.4 nut), OPEN at the band's opening-edge
  (chamber-side) face for nut insertion. 3.8 + 3.0 + 0.7 + 5.575 + 2.8 =
  15.875 EXACT. Every structural material layer is >= 3.0 (slab 3.0,
  receiver wall 5.575, all in-plane ligaments per verified fits below);
  the only sub-3.0 quantities anywhere in the station are declared fit
  clearances (0.3 head spare, 0.7 slab axial void, 0.4 nut axial float,
  1.0 socket side, 1.0 socket tip).
- CLAMP PATH (lock; corrects the reference profile's floating-slab clamp,
  where the slab sat 1.0 mm below the recess floor and the M3 head and nut
  both reacted against the receiver leaf): head -> washer -> slab top face
  (tongue leaf) ... screw shank through the slab's 3.6 passage ... nut
  (seated on the pocket floor, 0.4 axial float) -> pocket floor (receiver
  leaf). The two reaction faces lie on OPPOSITE leaves, so the fastener
  clamps leaf-to-leaf across the seam; the washer annulus (OD 7.0) seats
  fully on slab material (slab is 10.0 wide in the pad-depth direction,
  hole 3.6 -> solid rim 1.7..3.5 radially under the washer).
- DECLARED DEVIATION from the reference starting profile (locked here): the
  profile's 17.8 mm stack (6.8 head wall + 5.0 socket cavity + 6.0 nut wall,
  floating slab with 1.0/1.0 axial clearance) does not fit the 15.875 band
  under the user's in-band mandate, and its clamp reacted both fastener ends
  against the receiver leaf. This design's in-band variant fixes the slab at
  the recess floor (true cross-leaf clamp), keeps the pocket open at the
  chamber face, and retains every reference quantity that still fits:
  passage 3.6, head recess 8.25 x 3.8, nut 5.9 AF x 2.4, insertion 14.0,
  receiver width 18.0, root overlap 3.0, closed end 3.0, side clearance 1.0,
  tip clearance 1.0, minimums 3.0.
- Channels and insertion path (lock; derived from reference rules + band
  budget only):
  - M3 fastener channel: 3.6 dia, straight along the fastener axis, from the
    recess floor at 3.8 through the slab's own 3.6 passage, the 0.7 axial
    void, and the 5.575 receiver wall, into the 2.8 nut pocket (6.816
    aperture). Screw engagement is derived from the head seat (section 1.4):
    head base at 3.3 = 0.3 (head-top spare below the exterior face)
    + 3.0 (button head) + 0.5 (washer), so an M3 x 12 tip lands at
    15.3 -- inside the pocket
    (pocket spans 13.075..15.875), 0.575 short of the opening-edge face,
    no protrusion into the rack opening; the seated nut (t 2.4 in the 2.8
    pocket) engages ~1.8 mm of thread (~1.8 turns). An M3 x 14 would run to
    17.3 = 1.425 mm INTO the chamber: REJECTED (asserted in section 2.1).
  - Tongue insertion: LATERAL, along the station's own seam face, through the
    open slot mouth on the receiver leaf's seam face. Single fused solid on
    the tongue leaf: slab 14.0 long (the reference `tongue_insertion_depth`)
    + 3.0 root fused into the owning leaf's band material at the seam face =
    17.0 total; slab 14.0 (insertion) x 10.0 (pad-depth, named
    `tongue_seat_width`: washer OD 7.0 + 1.5 solid margin each side so the
    washer seats entirely on the tongue leaf) x 3.0 (fastener-axis). The slab
    rides on the recess floor (top face flush at 3.8) and fits the socket
    15.0 (insertion) x 12.0 (pad-depth) x 3.7 (fastener-axis) with 1.0 tip,
    1.0 each pad-depth side, and 0.7 axial-below clearance. There is NO
    through-band axial channel: the band stays solid except the socket slot
    and the 3.6 fastener channel. The lateral path is the reference's "single
    deliberate tongue insertion path": it crosses only the station's own seam
    plane, so no leaf hands a socket mouth to a non-mate leaf; the closed end
    stops over-insertion, and with the M3 fastener withdrawn the slab can be
    removed for service (serviceable reassembly per the reference purpose).
  - Fastener axis position (two named IN-PLANE coordinates; the radial
    position is fixed by the stack, not an independent parameter):
    - Seam-plane direction: OFFSET 8.0 INTO THE RECEIVER HALF from the
      station's seam plane (`seam_fastener_seam_offset = 8.0`). Required by
      the reference containment rule ("a circular head recess must be fully
      contained in the receiver part"): an axis on the seam plane would put
      half of the 8.25 dia recess in the tongue leaf. At offset 8.0 the
      recess spans 3.875..12.125 from the seam plane, fully inside the
      receiver half of the pad.
    - Pad-depth direction: PAD-DEPTH CENTER, 9.0 in from the pad front
      edge (`station_top`/`station_bottom` at Y = 9.0;
      `station_left`/`station_right` at Y = 19.0).
    - Radial (fastener-axis) position: FIXED BY THE STACK -- recess floor
      at 3.8, slab 3.8..6.8, axial void 6.8..7.5, receiver wall
      7.5..13.075, pocket 13.075..15.875, measured inward from the
      exterior face. Example cross-check: `station_top`'s slab faces lie
      at Z = 127.0 - (3.8..6.8) = 120.2..123.2.
- Every structural material layer in the station is >= 3.0 mm (the AGENTS.md
  section 10 floor); the only sub-3.0 quantities in the whole station are
  declared fit clearances, not structure: 0.3 head spare, 0.4 nut axial
  float (t 2.4 in the 2.8 pocket), 0.7 slab axial void, 1.0 socket side
  clearance, 1.0 socket tip clearance.
- No countersinks anywhere (rack spec v2.0.0 prohibits countersunk primary
  rack screws; the station uses a flat button head + flat washer seat, fully
  compliant).
- Station pads (locked in-plane extents; pad radial extent is the FULL
  15.875 band, opening-edge face to exterior face; the pad is solid added
  band material at the station, flush within the 254 x 254 silhouette):
  - Insertion direction (across the station's seam plane), 21.0 total:
    3.0 root zone (tongue-leaf side, `seam_root_overlap`) + 18.0 receiver
    zone (reference "receiver width"; slot 15.0 = insertion 14.0 + tip
    clearance 1.0, then closed end 3.0).
  - Pad depth (the other in-plane axis), 18.0, fastener axis at its center:
    - top/bottom stations: `Y in [0.0, 18.0]` (flush at the case front face).
    - left/right stations: `Y in [10.0, 28.0]` (see rationale below).
  - Four stations (receiver-side deep in WHICH leaf is finalized at 4.1;
    below assumes receiver in the +half, tongue in the -half):
    - `station_top` (seam plane X = 0, top band Z in [111.125, 127.0];
      fastener axis Z, head in face Z = +127.0): pad
      `X in [-3.0, +18.0]` or `X in [-18.0, +3.0]` per 4.1
      (3.0 root zone in the tongue leaf + 18.0 receiver zone in the
      receiver leaf), `Y in [0.0, 18.0]`, `Z in [111.125, 127.0]`.
    - `station_bottom` (seam plane X = 0, bottom band Z in
      [-127.0, -111.125]; fastener axis Z, head in face Z = -127.0): pad
      `X in [-3.0, +18.0]` or `X in [-18.0, +3.0]` per 4.1,
      `Y in [0.0, 18.0]`, mirrored in Z.
    - `station_left` (seam plane Z = 0, left band X in [-127.0, -111.125];
      fastener axis X, head in face X = -127.0): pad
      `Z in [-3.0, +18.0]` or `Z in [-18.0, +3.0]` per 4.1,
      `Y in [10.0, 28.0]`, `X in [-127.0, -111.125]`.
    - `station_right` (seam plane Z = 0, right band X in [111.125, 127.0];
      fastener axis X, head in face X = +127.0): pad
      `Z in [-3.0, +18.0]` or `Z in [-18.0, +3.0]` per 4.1,
      `Y in [10.0, 28.0]`, `X in [111.125, 127.0]`.
- Why the left/right pads are at `Y in [10.0, 28.0]`, not at the front face:
  the left/right bands at `Y 0..10` carry the rack rail columns -- 30 holes
  (15 per column at `X = +/-118.2625` on the face, 3.6 dia passages) including
  the hole centered at `Z = 0.0` on the seam plane and holes at
  `Z = +12.7` and `Z = -15.875`. Row pitch 15.875 leaves no hole-free 18 mm
  window at the front for an 18 mm pad. Moving the pad back to `Y in
  [10.0, 28.0]` (directly behind the 10.0-deep front rail, welded into the 3.0
  side wall) clears: equipment-plane Y boundary (pad starts at Y = 10.0,
  equipment occupies Y > 0; pad inner face at |X| = 111.125 vs equipment
  half-width 110.0 -> 1.125 mm lateral clear, pad does not touch the 220.0
  envelope), all 30 hole passages (only the `Z = 0.0` hole's Y-range is even
  near the pad, and the pad is 10 mm behind the face), and the 222.25
  clear-opening plane. This is the one stated departure from front placement;
  it is asserted in code (section 3.3).
- Receiver leaf owns, per station (receiver zone = the 18.0 of the pad on
  the receiver side of the seam plane):
  - registration socket: slot 15.0 long in the insertion direction from the
    seam face (insertion 14.0 + tip clearance 1.0) x 12.0 wide in the
    pad-depth direction (slab 10.0 + 2 x 1.0 side clearance) x 3.7 deep in
    the fastener-axis direction (slab 3.0 + 0.7 axial void); closed end 3.0
    solid at the pad's rear (18.0 - 15.0 = 3.0, exact); the slot MOUTH is
    the open cut at the station's seam face = the single deliberate lateral
    insertion path; slot pad-depth margins to the pad front and back faces
    are exactly 3.0 (12.0 centered in 18.0);
  - head/washer recess: 8.25 dia x 3.8 deep in the exterior case face,
    centered on the fastener axis (offset 8.0 into the receiver half, so
    the whole recess is in the receiver leaf per the containment rule);
    button head 3.0 + ISO 7089 washer OD 7.0 x 0.5 seated in the same
    recess (3.5 of 3.8 used, 0.3 spare); this is a seam-station fastener,
    NOT a primary rack screw -- the v2.0.0 counter-sink prohibition does
    not apply to it, and no counter-sink is cut anyway;
  - the M3 passage (3.6) from recess floor to nut pocket, bored straight
    through the 5.575 receiver wall;
  - the captive hex nut pocket: 6.816 circumscribed x 2.8 deep, aperture at
    the band's opening-edge face (chamber side), centered on the fastener
    axis. In-plane ligaments (asserted per-station at 3.3; receiver pad is
    18.0 in the insertion direction and 18.0 in the pad-depth direction,
    axis at 8.0 from the seam plane and 9.0/19.0 in the pad-depth center):
    recess (r 4.125) 3.875 to the seam face / 5.875 to the pad rear / 4.875
    to each pad-depth face; pocket (r 3.408) 4.592 to the seam face / 6.592
    to the pad rear / 5.592 to each pad-depth face -- all >= 3.0. Nut M3 x
    0.5 hex, AF 5.9, t 2.4, corner-captive (pocket circumscribed 6.816 vs
    flats 5.9), inserted through the aperture before final leaf closure
    (aperture remains accessible from the opening side while any leaf is
    out); the loaded nut seats against the pocket floor (chamber-side face)
    with 0.4 axial float.
- Tongue leaf owns, per station:
  - the registration tongue, ONE fused solid: bearing slab 14.0 long
    (insertion depth) x 3.0 (fastener-axis direction) x 10.0 (pad-depth,
    `tongue_seat_width`) + a 3.0-deep root zone (the pad's full 18.0 x
    15.875 cross section, on the tongue side of the seam plane) behind the
    seam face, the slab passing continuously through the seam face out of
    it -- the fused tongue solid joins the leaf body through the
    pad/wall overlap volume (positive volume meeting
    minimum_structural_overlap, asserted at 3.3); total 17.0
    insertion-direction span (root 3.0 + slab 14.0). The slab rides the
    recess floor (bearing slab, NOT the socket) and fits the socket with
    1.0 pad-depth side clearance each side, 1.0 tip clearance, and 0.7
    axial-below void (all fit clearances, asserted at 3.3);
  - the M3 passage (3.6) through slab and root, aligned with the
    receiver's passage (the two passages form the one through-channel
    only after assembly).
- Verified fits (asserted in code at section 3.3, per station; the four
  stations are congruent under rotation about Y so one assertion set covers
  all four):
  - Radial stack: 3.8 + 3.0 + 0.7 + 5.575 + 2.8 = 15.875 EXACT, equal to
    the band depth (opening edge 111.125 to exterior face 127.0).
  - Head recess (r 4.125, axis at 8.0 from the seam plane and 9.0/19.0 in
    the pad-depth direction): 3.875 to the seam face and 5.875 to the
    closed end in the insertion direction (8.0 + 4.125 = 12.125 recess
    edge vs the 18.0 receiver zone rear); 4.875 to each pad-depth face
    (9.0 - 4.125). All >= 3.0; recess fully inside the receiver leaf
    (containment rule).
  - Nut pocket (r 3.408, same axis): 4.592 to the seam face and 6.592 to
    the closed-end side in the insertion direction (8.0 + 3.408 = 11.408
    edge vs 18.0); 5.592 to each pad-depth face (9.0 - 3.408). All >= 3.0.
  - Socket slot: 3.0 closed end (18.0 - 15.0), 1.0 tip (15.0 - 14.0), 1.0
    pad-depth side each way (12.0 in 18.0), 3.0 margin to each
    pad-depth pad face, radial void 0.7 below the slab (fit).
  - Every structural material layer in the station >= 3.0 mm (slab 3.0,
    receiver wall 5.575, all in-plane ligaments above); the only sub-3.0
    quantities in the whole station are the declared fit clearances
    (0.3/0.7/0.4/1.0/1.0).
  - M3 x 12 tip at 15.3 < 15.875 (0.575 clear of the opening-edge face;
    M3 x 14 rejected).
  - Pad footprints are disjoint from: the 222.25 x 222.25 clear opening
    (the pad radial zone IS the band [111.125, 127.0], outside the opening
    edge by definition; no pad intrudes into the opening), the rack
    columns at +/-118.2625 (left/right pads sit at Y in [10.0, 28.0],
    behind the 10.0-deep front rail, so the column hole passages at the
    front face are untouched; top/bottom pads span Y in [0.0, 18.0] in
    the |Z|/|X| bands past 111.125 where no column hole pierces), and the
    220.0 equipment envelope (left/right pad inner face at |X| = 111.125
    vs equipment half-width 110.0 -> 1.125 mm clear; top/bottom pads are
    outside the equipment's |Z| / |X| extent).
- Leaf ownership (locked): each station is split on its OWN seam plane only
  (X = 0 for top/bottom, Z = 0 for left/right). One leaf owns the receiver
  half (socket, head recess, nut pocket, receiver passage) and the other leaf
  owns the tongue (slab + root + tongue passage). The tongue insertion path
  is LATERAL: it lies in the station's own seam plane (e.g. the Z = 0 plane
  for left/right stations, along the Z axis, with the slab sliding from its
  tongue-leaf side through the open slot mouth into the receiver leaf). It
  crosses the station's own seam plane BY DESIGN (that is the insertion) and
  no other seam plane -- never X = 0 for left/right stations, never Z = 0 for
  top/bottom stations, never the Y = 0 front face -- so no leaf must hand a
  socket mouth to a non-mate leaf. The exact receiver/tongue quadrant pairing
  (which side of the seam receives) is finalized at section 4.1 with the
  rule: the tongue root zone must stay in its owning leaf (root does not
  cross the seam plane; only the slab crosses, with clearance).
- Structural floor: the 3.0 mm baseline (AGENTS.md section 10) holds for
  ALL shell and station geometry with NO exceptions -- every material
  layer in the 15.875 stack is >= 3.0, and every in-plane ligament
  computed at "Verified fits" is >= 3.0. Every 1.0 / 0.7 / 0.5 / 0.3
  value above is a declared fit clearance, not structure. The reference's
  structural claim is still physically UNVERIFIED: a production
  `seam_station_coupon` (reference module, printed from the same stack
  geometry) is required before any fabrication claim, per the reference's
  verification list; coupon evidence is recorded in the design docs.

- Leaf-ownership table (locked after 4.1 finalizes which side of each seam
  plane receives the socket -- this table is the rule, exact quadrants per
  4.1):
  - `station_top`: receiver in the leaf at `-X` OR `+X` side of X = 0 in the
    top band (top-left OR top-right leaf); tongue in the other top leaf.
    The pad spans 21.0 in the insertion direction: 3.0 root zone in the
    tongue leaf + 18.0 receiver zone in the receiver leaf, e.g.
    `X in [-3.0, +18.0]` for receiver in the `+X` leaf (2.1). The closed
    end of the slot (pad rear, 15.0..18.0 from the seam face) is in the
    receiver leaf.
  - `station_bottom`: same rule, bottom band, X = 0 seam.
  - `station_left`: receiver in the `-Z` OR `+Z` half at Z = 0 in the left
    band (bottom-left OR top-left leaf); tongue in the other left leaf.
    Pad `Z in [-3.0, +18.0]` or `Z in [-18.0, +3.0]` per the 4.1 choice.
  - `station_right`: same rule, right band, Z = 0.

### 1.4 Fastener hardware declaration (starting profile, physically UNVERIFIED)

- Seam screws: M3 x 0.5 button head x 12 mm (head top 0.3 mm below the
  exterior face; the 3.0 head + 0.5 washer + 0.3 spare fill the 8.25 dia
  x 3.8-deep recess; ISO 7089 washer OD 7.0 x 0.5, annulus bearing on
  the tongue slab top face). Tip check:
  head base at 3.3 -> tip 3.3 + 12 = 15.3 < 15.875 (0.575 short of the
  opening-edge face, no protrusion); M3 x 14 would reach 17.3 = 1.425 into
  the chamber -> REJECTED (asserted in section 2.1).
- Seam nuts: M3 captive hex, AF 5.9, thickness 2.4, pocket 6.816 x 2.8,
  corner-captive (pocket circumscribed 6.816 vs nut flats 5.9).
- Installation: screw driven axially from the exterior face; nut inserted
  through the chamber-side pocket opening before final leaf closure.
- Driver: M3 hex; swept tool access envelope is axial through the recess
  (verified by head-side views, not assumed).
- Basis: FDM, 0.4 nozzle, 0.2 mm layer, 3 wall loops (declared; coupon
  evidence required before fabricating).

### 1.5 Front rack interface (5U)

- Front plane `Y = 0` with a 3.0 mm wall; the 222.25 x 222.25 mm opening
  leaves the two ring bands `|X| in [111.125, 127.0]` (Z full) and
  `|Z| in [111.125, 127.0]` (X within the opening) as the front face
  structure.
- Rack mount rails: the front 3.0 mm walls of the ring bands (the vertical
  `|X| in [111.125, 127.0]` bands' front walls Y in [0,3], full Z) carry all
  30 rack holes: two columns at `X = +/-118.2625`, 15 holes per column at
  `rack_hole_z(i)`. The horizontal front bands (top/bottom,
  `|Z| in [111.125, 127.0]`) are solid 3.0 mm faces with NO holes: verified
  against the 5U Z list, the transverse bands `Z in [-127,-111.125] U
  [111.125,127]` contain no hole (nearest hole Z = -104.775, edge -106.575
  -> 5.45 mm clear of the -111.125 band edge). Per primary-hole station
  (v2.0.0 RACK-SCOPE-005 applies -- these ARE the primary rack screws):
  - 3.6 dia through-passage (3.0 long) through the front face;
  - local thickened land, hole-centered, 5.8 mm deep overall: 3.0 face
    wall (Y in [0,3]) + 2.8 deep, 6.816 circumscribed dia chamber-open
    hex-nut pocket (Y in [3,5.8]); land edge-to-opening-edge ligament
    118.2625 - 3.408 - 111.125 = 3.7295 >= 3.0, land edge-to-exterior-face
    ligament 127.0 - (118.2625 + 3.408) = 5.3295 >= 3.0 (asserted 2.1);
  - shallow printed washer seat: 8.25 dia x 0.3 deep recess in the EXTERIOR
    front face per the v2.0.0 allowance ("a shallow 0.2-0.4 mm printed
    recess MAY be used to create a flat seat"), hole-centered; the ISO 7089
    washer bears flat on the seat floor. The seat (8.25 dia) is wider than
    the land (6.816 dia), so its floor reaches
    118.2625 + 4.125 = 122.3875, i.e. 2.86 mm outside the land edge
    (118.2625 + 3.408 = 121.6703), onto the plain 3.0 face wall; the wall
    behind the seat floor is 3.0 - 0.3 = 2.7 mm -- DECLARED PERMIT: a
    shallow face feature loaded axially through the screw, not a structural
    ligament; the structural floor is carried by the 3.6-passage ligaments
    (118.2625 - 1.8 - 111.125 = 5.3375 to the opening edge, 5.3375 to the
    exterior face, all >= 3.0). Asserted at 2.1.
  - NO countersink anywhere (v2.0.0 prohibition on countersunk primary
    mounting screws); the screw head seats in the chamber at the pocket
    floor (the pocket opens at Y = 5.8), washer clamped on the exterior
    seat face.
  - SHELF INTERACTION: the land reaches Y = 5.8; the bottom-row lands
    (Z = -104.775, -101.6) sit above the equipment shelf (see below); the
    shelf therefore starts at Y = 6.0 (0.2 back from the deepest land
    face), clearing every land passage.
  - THE STRADDLE EXCEPTION (the only split-plane-bisected rack feature,
    asserted at 2.1 and 3.4.1): the two holes centered at `Z = 0.0`
    (X = -118.2625 and X = +118.2625) sit exactly on the Z = 0 split
    plane, i.e. the top/bottom front-face seam. Each bisected hole is
    split into a 1.8 half-passage + half-land (half pocket, half seat) per
    leaf; in the assembled product the hole is a complete 3.6 passage, a
    complete 5.8 land, and a continuous flat 8.25 x 0.3 washer seat (the
    seam line crosses the seat; washer contact remains flat-solid 360 deg).
    The Z = 0 split plane cuts the hole lands only (no other cut pair
    straddles it; full cut-pair inventory at 2.1 per structural-joins
    playbook).
- v2.0.0 hole pattern (RACK-GEO-001/002): U pitch 44.45, U boundaries at
  `Z = -111.125 / -66.675 / -22.225 / +22.225 / +66.675 / +111.125`; 3
  holes per U at U-bottom offsets 6.35 / 22.225 / 34.925 (intra-U gaps
  15.875 / 12.700; the repeating 15.875 / 15.875 / 12.700 sequence
  continues across U boundaries); 15 per column, 30 total, `rack_hole_z(i)`
  from the copied SCAD. Full list: Z = -104.775, -88.9, -76.2, -60.325,
  -44.45, -31.75, -15.875, 0.0, 12.7, 28.575, 44.45, 57.15, 73.025, 88.9,
  101.6. The Z = 0.0 hole is the middle hole of the center U (U3).
- Equipment support: two continuous shelves (bottom and top), each
  3.0 mm thick: bottom shelf top surface exactly at `Z = -111.125`
  (equipment bottom datum, flush with the opening's bottom edge plane;
  occupies `Z in [-114.125, -111.125]`); top shelf mirrored (bottom
  surface `Z = +111.125`, occupies `Z in [111.125, 114.125]`). Each shelf
  spans the full interior width `X in [-111.125, 111.125]` and full
  interior depth `Y in [0, 77]`, fusing into the front wall (Y [0,3])
  and the rear wall (Y [77,80]) with a 3.0 overlap at each: two verified
  supports per shelf, each 3.0 = minimum_structural_overlap (AGENTS.md
  section 10). Side ends at |X| = 111.125 are coplanar butt joints with
  the side-band inner faces, documented as non-load-bearing seams
  (equipment weight path: shelf -> wall overlaps; side edges carry no
  declared load). No collision with any rack feature: lands sit in the
  |X| >= 114.8545 band (entirely outside the shelves' X range) and the
  bottom-row land Z range (low edge -104.775 - 3.408 = -108.183) never
  reaches the shelf Z band [-114.125, -111.125] -- double separation in
  X and Z, asserted at 2.1. Shelves are a datum for shorter equipment;
  gap between the two shelves: 222.25 - 6.0 = 216.25.

## 2. Verification gates (approval gate)

- Structural: `assert()` named-dimension guards for wall, ring, station
  ligaments (fastener-to-opening edge, fastener-to-exterior edge, station-to-
  station, cut-to-cut), tongue root overlap, socket closed-end, post-cut
  ligaments per structural-joins playbook; no unexpected disconnected shells;
  full seam coverage (no open seam between station regions).
- Fit vs structural vs epsilon kept distinct per the reference.
- Print verification: per-leaf bounds <= 215 mm per axis (220 - 5 reserve);
  flat footprint orientation; no unprintable overhang > 45 deg in the
  declared orientation (sections) -- or a declared support plan.
- Station and rack asserts (named, at 2.3/3.3/4.3): band budget
  `3.8 + 3.0 + 0.7 + 5.575 + 2.8 == 15.875` EXACT; M3 x 12 tip at
  3.3 + 12 = 15.3 <= 15.875 (0.575 clear of the opening-edge face) and
  M3 x 14 (tip 17.3) rejected; rack land ligaments: opening-edge
  118.2625 - 3.408 - 111.125 = 3.7295, exterior-face
  127.0 - (118.2625 + 3.408) = 5.3295, passage ligaments
  118.2625 - 1.8 - 111.125 = 5.3375 -- all >= 3.0; Z = 0.0 straddle: each
  of the two front-face holes contributes a 1.8 half-passage + half-land
  (half pocket, half seat) per leaf, complete features when assembled, and
  the Z = 0 split plane cuts the hole lands only (full cut-pair inventory
  per structural-joins playbook); shelves: two 3.0 wall-overlap supports
  each + side coplanar butts documented non-load-bearing.
- Process lesson (toolchain): every small-cylinder cut is performed in the
  unrotated product/local frame; rotated print frames are only ever
  unioned, never cut with tiny bores (avoids degenerate booleans in the
  OpenSCAD CGAL kernel).
- Artifact gates (per AGENTS.md §11): complete `scad_build_all.py` build into
  `output/cyberdeck-2/`, `--audit-only` pass, review of installed STL/PNGs,
  then assembly review bound to the installed `build_manifest.json` hash.
- Assembly contract: `assembly.json` passes
  `scripts/validate_cad_assembly_contract.py`; `assembly_review_manifest.json`
  produced and reviewed.
- Coupon: `seam_station_coupon` geometry declared in the design docs as a
  required production evidence item (not printed in this plan unless
  approved).

## 3. Work items

- [ ] 1. Scaffold design directory (governed layout).
  - [ ] 1.1 Create `designs/cyberdeck-2/` with `src/main.scad`,
    `src/lib/defaults.scad`, `src/lib/rack_v2_0_0.scad` (copied/adapted from
    v2.0.0 package, no imports from `references/`), `src/parts/`,
    `configs/rev_0001.json`, `docs/`.
  - [ ] 1.2 Write `configs/rev_0001.json` with all §1 constants flattened
    (`rack_spec_version: "ten-inch-rack-m3-printed-design-spec v2.0.0"`,
    geometry, station, hardware, print limits).
  - [ ] 1.3 Write `designs/cyberdeck-2/parts.json` (4 leaves, schema_version 1).
  - [ ] 1.4 Write `designs/cyberdeck-2/assembly.json` (product_assembly ->
    enclosure_assembly -> 4 leaves; 2 seam interfaces with their 2 stations
    each; views for assembly/exploded/leaf isolation/station sections/rack
    section/shelf section; geometry_exports with one entry: name
    "product_assembly", integer dispatch_id whose `main.scad` case prints
    the in-place union of the four leaves, minimum_span [254, 80, 254],
    producing the assembled STL artifact).
  - [ ] 1.5 Run `scripts/validate_cad_assembly_contract.py` on the contract.
- [ ] 2. Implement shell and chamber geometry.
  - [ ] 2.1 `src/parts/shell.scad`: six-wall box (3.0) with 222.25 x 222.25
    front opening; full-height front rails at +/-118.2625 with per-hole nut
    lands; two bottom shelves (§1.5); rear wall 3.0 at Y 77..80.
  - [ ] 2.2 Rack hole cuts: 30 through passages 3.6 (3.0 long), 30 printed
    washer seats 8.25 dia x 0.3 deep in the exterior front face (v2.0.0
    0.2-0.4 allowance), 30 chamber-open nut pockets 6.816 x 2.8 -- all in
    the unrotated product frame; no 3.8-deep rack head recesses; no
    countersinks.
  - [ ] 2.3 `assert()` guards: wall/ring widths, rail-to-hole alignment
    (hole center in rail), land depth >= pocket depth + 3.0, shelf overlap
    3.0, opening exactly 222.25 x 222.25, 5U hole positions per v2.0.0
    sequence.
  - [ ] 2.4 Mid-plan gate (per canonical-decomposition playbook): build and
    audit the four-leaf shell blockout (no stations, no hardware) through the
    complete manifest pipeline, review the installed blockout artifacts, and
    pause for user confirmation of the decomposition before station
    (section 3) work. Any user change to the split or envelope re-locks
    section 1/3.
- [ ] 3. Implement seam stations (shared module family).
  - [ ] 3.1 `src/lib/seam_station.scad`: `registration_tongue`,
    `receiver_socket`, `m3_through_passage`, `m3_head_recess`,
    `m3_captive_hex_nut_pocket`, `seam_station_coupon` per the reference
    implementation outline, parameterized by fastener axis + band position.
  - [ ] 3.2 Instantiate 4 stations (§1.3) with strict leaf ownership; pads
    unioned into the owning leaf, hardware cuts applied post-union in the
    unrotated leaf frame.
  - [ ] 3.3 `assert()` guards per reference: ligament from every fastener cut
    to opening edge / exterior edge / neighbor cut >= 3.0; tongue root
    overlap >= 3.0; socket closed end >= 3.0; socket side/tip clearance 1.0;
    head recess fully contained in receiver leaf; station pads do not
    intersect the clear opening, rail columns, or equipment envelope.
- [ ] 4. Implement split + print orientation.
  - [ ] 4.1 Cut the master assembly on `X = 0` and `Z = 0` into the four
    leaves; each leaf = (shell half) union (owned station geometry) minus
    (owned hardware cuts); no leaf may own an open socket mouth facing wrong,
    and no cut may straddle a split plane except: (a) its own station
    passage, and (b) the two Z = 0.0 front-face rack holes that straddle
    the Z = 0 plane by design (1.8 half-passage + half-land + half-seat per
    leaf; complete when assembled).
  - [ ] 4.2 `src/main.scad` part dispatch (1..4 leaves, review dispatch id)
    plus per-leaf print transform (flat 127 x 127 footprint, seam face
    vertical) applied only at export, after all Boolean work.
  - [ ] 4.3 `assert()` per-leaf print bounds <= 215.0 mm on all axes and
    footprint stability check (lowest face planar).
- [ ] 5. Build, audit, and review artifacts.
  - [ ] 5.1 Complete build: `scripts/scad_build_all.py --design cyberdeck-2
    --config configs/rev_0001.json --destination current` (4 leaf STLs +
    assembled product_assembly STL via geometry_exports + assembly PNGs).
  - [ ] 5.2 `--audit-only` pass on installed output; output flat (no
    directories/staging).
  - [ ] 5.3 Review installed STL/PNG artifacts (assembled, exploded, 4 leaf
    isolations, 4 station sections, rack section, shelf section).
  - [ ] 5.4 Generated assembly review into `output/cyberdeck-2/` bound to the
    installed `build_manifest.json` + STL hashes; the assembled
    `product_assembly.stl` and `assembly_review_manifest.json` appear in the
    unified expected-artifact set and pass the exact-set audit;
    `assembly_review_manifest.json` reviewed and recorded.
- [ ] 6. Documentation.
  - [ ] 6.1 `designs/cyberdeck-2/README.md`: requirement traceability, split
    strategy, station map, hardware declaration, print orientation, KNOWN
    unknowns (rack_internal_depth resolved by 80 mm mandate; coupon pending).
  - [ ] 6.2 `designs/cyberdeck-2/docs/rack_and_depth_report.md`: v2.0.0
    requirement matrix, depth budget, station band budget, structural
    assertion summary.
  - [ ] 6.3 Host docs: `AGENTS.md` design index entry, `README.md` repository
    structure, plan index regeneration
    (`scripts/regenerate_plan_indexes.py --check`).
- [ ] 7. Checkpoint.
  - [ ] 7.1 Journal entry `journal/2026-09-09.md` (work log; user-only fields
    untouched).
  - [ ] 7.2 Propose task-scoped commit(s); commit only on explicit user
    approval; no push unless requested.

## Authoring Rules

- Use `YYYY-MM-DD-HH-mm-ss_slug.md` with a lowercase, hyphenated slug.
- Make `plan_id` match the filename stem exactly.
- Use only the required front matter keys shown above.
- Decompose work until each leaf item has one clear completion condition.
- Use `[-]` only for intentionally closed or de-scoped work.
- Keep file location aligned to `future`, `current`, or `past` status.