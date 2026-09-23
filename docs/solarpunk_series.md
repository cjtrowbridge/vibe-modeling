# Solarpunk Series — Canonical Design Document

*Status: Active — canonical source of truth for all `solarpunk_*` designs.*

## 1. Authority

- All designs whose directory prefix is `solarpunk_` under `designs/` (and matching
  `output/` artifacts) are members of this series: solarpunk backyard greenhouse
  automation.
- This document is the single source of truth for series-level decisions and for
  the design details of every member: scope, architecture, current dimensions,
  materials, interfaces, recorded spec deviations, and open decisions.
- Where a design-scoped artifact (design README, config comments, journal notes)
  conflicts with this document, this document wins and the conflicting artifact
  must be corrected in the same task.
- Any change to the details of a `solarpunk_*` design must be reflected here in
  the same task (see `AGENTS.md` §2, item 6).
- Every solarpunk design README must link to this document.

## 2. Naming

- Design and output directories use `solarpunk_<short-name>`, e.g.
  `designs/solarpunk_seed_tray/`, `output/solarpunk_seed_tray/`.

## 3. Series Inventory

| Design | Status | Role |
|---|---|---|
| `solarpunk_intelligence_hub` | rev_0002 built and audited (2026-09-20) | Electrical/IoT mounting hub: single flat hanging plate carrying the series electronics on one standoff plane |
| `solarpunk_seed_tray` | scaffold complete; placeholder configs, Phase 1 measurement pending | Per-tray converter: TPU flood tray with integrated bell siphon |
| `solarpunk_exhaust` | scaffold complete (rev_0001, plan V4 + V5 magnet-pocket addendum, rebuilt + audited 2026-09-23); placeholder config pending fan measurement | 120 mm fan mounting plate over the ventilation screen: Ø116 airflow opening, adjacent-edge velcro bands, 8 back-face magnet pockets |
| `solarpunk_siphon_filter` | deferred | Siphon-based filtration stage between return manifold and reservoir |

## 4. Common System Architecture

```
RESERVOIR (commodity)
   │ pump (commodity)
   ▼
FEED MANIFOLD (commodity pipe/fittings)
   │ 1/4" feed per tray
   ▼
TRAY x N (solarpunk_seed_tray)
   │ ~1/2" drain per tray
   ▼
RETURN MANIFOLD (commodity pipe/fittings, continuous fall)
   ▼
SIPHON FILTER (solarpunk_siphon_filter)
   ▼
RESERVOIR

Ventilation / exhaust branch (air, passive stack):
GREENHOUSE TOP (warm air)
   ▼
HOSE (commodity aluminum dryer hose — out of scope, user-supplied)
   ▼
FAN (commodity 120 mm) intake
   ▼
FAN PLATE (solarpunk_exhaust) — velcroed over the ventilation screen
   ▼
GREENHOUSE VENTILATION SCREEN -> OUTSIDE
```

Rules:

- Feed (~1/4") and drain (~1/2") use different tube sizes; the drain must have
  substantially greater instantaneous capacity than the feed.
- The return path must be atmospheric (not pressurized) so one tray's siphon
  cannot pressurize another tray's outlet; the atmospheric stage is provided at
  the siphon-filter stage.
- Commodity, out-of-scope hardware: reservoir, pump, feed and return manifolds,
  all pipe/fittings, tubing, and the bottle used for the bell cap.

## 5. Design: `solarpunk_seed_tray`

### 5.1 Goal

Convert a commodity USB-LED 12-cell (3 × 4, ~1.5" cells) seed-starter kit into a
modular flood-and-drain hydroponic propagation tray for rockwool cubes,
modifying as little of the original product as possible.

### 5.2 Retained Commodity Components (not designed)

- Clear greenhouse LED dome — unmodified, must continue to fit.
- 12-cell perforated removable insert — unmodified, supported on an internal
  ledge; must remain removable for cleaning.
- Inlet/outlet fittings, tubing, feed/return manifolds, pump, reservoir.
- Bell: a cut plastic bottle base (see 5.4).

### 5.3 Printed Per-Tray Part (single TPU part)

One main printed opaque-TPU part per tray:

1. **Tray shell** — outer walls, lid-mating rim (reproduces measured original rim
   geometry), internal insert ledge, flood-chamber floor.
2. **Opaque mask** — integrated (Option A): closes everything except the twelve
   cell openings; the LEDs must not illuminate the nutrient solution.
3. **Standpipe tower** — rises from the floor; its crest sets the
   fill/prime level.
4. **Bell seat** — receives the commodity bottle-base cap.
5. **Drain path** — integrated ~90° swept bend routing to a rear-wall outlet
   port (~1/2" ID) accepting a commodity fitting. Rear-wall exit supersedes the
   original spec's bottom-exit proposal. The drain channel is **light-blocking**
   (closed top, opened to the bell only through the internal feed opening) so
   LED light cannot pass through the structure into the standing water, and the
   channel is sealed at both plumbing penetrations.
6. **Inlet** — socket for the 1/4" feed fitting.

Reinforcement: thickened rim, vertical ribs, reinforced corners (mitigates TPU
wall flex when flooded).

Forward-looking assumptions:

- **Roots will grow** down through the perforated cell bottoms toward the
  chamber. Ledge clearances, mask openings, and the bell/standpipe access all
  assume roots will eventually reach this space and must stay serviceable.
- **No inaccessible cavities** — the model must be constructible from named
  cuts only; do not create hidden internal voids that could collect organic
  material.

### 5.4 Bottle-Base Bell (commodity)

- The bell is a cut plastic bottle base fitted over the standpipe tower as its
  cap; the bottle is not printed.
- Notches cut in the base define the flow/air-break path. Notch geometry and the
  bottle cut height set the siphon-break level and are the primary empirical
  tuning knobs (phase 4).
- A typical 2 L bottle base is ~85–90 mm ID versus the original spec's ¾–1" bell
  baseline; the larger bell makes siphon initiation easier.
- The cut bottle base sits over the standpipe tower as a friction fit; the cut
  skirt must stay **above the maximum flood level** so the cap seal remains in
  the dry zone, and low enough that the notch openings pass the siphon-break
  air line below the standpipe crest. Skirt engagement and friction fit are
  open until the bottle is chosen.

### 5.5 Operating Cycle

1. 1/4" feed fills the chamber slowly.
2. Water rises in the standpipe to its crest; flow begins down the integrated
   drain.
3. The bottle-base cap primes the siphon.
4. The tray drains much faster than it fills.
5. Water level falls below the siphon-break level (set by the notch geometry);
   air enters and the siphon stops.
6. The tray refills; the cycle repeats.

### 5.6 Key Dimensions (current state — parametric)

| Parameter | Current value |
|---|---|
| Cell grid | 3 × 4 (12 cells) |
| Cell size | ~1.5" (measured per kit) |
| Flood chamber usable depth | 20–35 mm |
| Flood target | lower 1/3–1/2 of rockwool cube |
| Floor slope | optional 1–2° toward the siphon |
| Insert ledge clearance | 0.5–1.0 mm around the insert perimeter |
| Feed | 1/4" irrigation tubing |
| Drain path | ~1/2" ID throughout (standpipe → bend → rear port); never reduced to 1/4" |
| Standpipe | ~1/2" ID baseline |
| Bell (bottle base) | ~2 L bottle |
| Support/deck clearance | 30–50 mm baseline; may shrink (no downleg to house) |

The parametric surface (original spec §33, adapted to the integrated
architecture):

- **Tray:** `tray_outer_length`, `tray_outer_width`, `tray_outer_height`,
  `wall_thickness`, `floor_thickness`, `floor_slope`, corner radii, lid
  interface L/W/H (plus rim cross-section from the physical kit)
- **Insert:** `insert_length`, `insert_width`, `insert_support_height`,
  `insert_support_width`
- **Cells:** `cell_pitch_x`, `cell_pitch_y`, `cell_opening_width`,
  `cell_opening_length`, cell bottom height, perforation pattern
- **Hydraulics:** `flood_chamber_depth`, `maximum_flood_height`,
  `standpipe_inner_diameter`, `standpipe_height`, `feed_port_diameter`,
  `drain_inner_diameter` (standpipe, bend, and rear port all on this
  parameter), `elbow_clearance` (~0 — the 90° turn is inside the tray body)
- **Support:** `platform_clearance`

Multi-size requirement (2026-09-17):

- The series targets many different physical seed-tray sizes, so the design
  must be fully parameterized: **no hardcoded size-derived constant may appear
  in the OpenSCAD source.** Every dimension, feature placement, and derived
  layout (rim, ledge, cell grid, tower position, drain bend, ports, rib
  pattern) must compute from the parameter surface above.
- One config file = one concrete size/variant (repo convention, cf.
  `designs/cyberdeck/configs/`); each size is built, audited, and revised
  independently through the normal manifest pipeline.
- Parameters that must remain size-independent and stay in source: the
  structural minimums (`minimum_wall_thickness`, `minimum_structural_overlap`),
  tube standards (1/4" feed, ~1/2" drain), and material/print defaults.
- Adding a new size must not require editing `src/`; it must be expressible as
  a new config that passes the same structural asserts (wall, drain-ID
  uniformity, min feature width) at that size.

Concrete config instances (scaffold, 2026-09-17 — placeholder dimensions
derived from marketing imagery; **pending Phase 1 physical measurement**):

| Config | Kit | Placeholder tray (L×W×H) | Cell grid |
|---|---|---|---|
| `configs/rev_0001.json` | 12-cell | 172.5 × 130 × 70 mm | 3 × 4 |
| `configs/rev_0002.json` | 6-cell | 175 × 135 × 55 mm | 3 × 2 |

Both pass the same structural asserts at their respective sizes. The two
kits-in-transit are the initial targets; additional sizes add new
`configs/rev_000N.json` without source edits.

### 5.7 Print and Structural Parameters

- Material: TPU 95A, opaque (black preferred).
- Walls 2.4–3.2 mm; floor 2–3 mm; 3–5 perimeters.
- `minimum_wall_thickness`: 2.4 mm (tentative — confirm at blockout).
- `minimum_structural_overlap`: ≥ `minimum_wall_thickness` (declare at blockout).
- Dominant structural risk: wall flex when flooded — mitigated by ribs and
  reinforced corners.
- Avoid: fine printed threads, microscopic passages, rigid dimensional fits
  (TPU concerns).

### 5.8 Design Against (Failure Modes)

Adapted from the original spec; the listed causes act as design probes, not
verdicts.

- **Siphon does not start** — restricted drain bore; bell too large or too
  loosely seated; standpipe too small; feed rate too low; insufficient vertical
  drop from crest to outlet; downstream backpressure.
- **Siphon will not stop** — feed rate too high relative to drain; bell
  admits no air (notches blocked or too high); drain channel stays full after
  the bell break.
- **Tray overflows** — siphon clogged, roots in the siphon, wrong standpipe
  choice. An emergency overflow is a candidate for later iterations only.
- **Algae growth** — LED light reaching the standing nutrient solution;
  mitigated by the integrated opaque mask and the light-blocking drain
  channel (see 5.3 item 5). The siphon bell region and both plumbing
  penetrations are the features to keep dark.
- **Roots block siphon** — see the 5.3 root-growth assumption; the bell/standpipe
  access must remain serviceable.
- **Trays interact through the plumbing** — the return manifold is commodity;
  keep it continuous-fall and keep the atmospheric stage at the
  siphon-filter end so one tray's siphon cannot pressurize another's outlet.

### 5.9 Support / Platform

- Trays sit on a simple support that keeps the plumbing accessible behind/below
  them.
- The original 30–50 mm under-tray service space for a downleg and elbow is
  relaxed because the drain exits the rear wall of the tray.
- Printed vs. commodity support: open; the support is the simplest item in the
  design.

### 5.10 Open Decisions

1. Siphon/standpipe location within the tray (current lean: rear corner, aligned
   with the rear drain exit, behind the edge cells).
2. Bottle choice, cut line, and notch dimensions (phase-4 experimentation).
3. Root ingress control: the open bell default is exposed to roots/fibers.
   Candidates: placement + bell size alone; a printed ring shield around the
   tower below the bell rim (keeps the single-part print); accept and treat via
   routine maintenance.
4. Inlet location and fitting style (lean: undersized TPU socket flexing over a
   commodity 1/4" barb).
5. Printed vs. commodity rear outlet fitting.
6. Printed vs. commodity platform/support.
7. Mask Option A (integrated) is the v1 lean; final call at blockout.
8. Whether an emergency overflow is needed after phase-4 siphon testing
   (see 5.8).

### 5.11 Phase 1 Measurement List

- Original tray outer L/W/H.
- Rim cross-section: lid sits outside the walls, locates in a groove/lip, or
  engages tabs.
- Seed-cell insert outer L/W and ledge height.
- Cell pitch (X/Y), cell opening W × L, cell bottom height, drain perforation
  pattern.
- Internal clearance at the rear edge (tower + drain bend needs ~40 mm).
- Corner radii; locating tabs/recesses.
- Chosen bottle: base ID/OD at the intended cut line.

### 5.12 Recorded Deviations from the Original Specification (2026-09-17)

- §18 bottom-exit siphon → integrated **rear-wall** drain exit.
- §14–16 swappable printed standpipe/bell/guard cartridge → **integrated
  standpipe and drain** in the tray; **commodity bottle-base bell**; no printed
  root guard by default.
- §22 printed return manifold → **commodity pipe and fittings**.
- Platform height target relaxed (no downleg to house).

### 5.13 Development Sequence and Acceptance

Phases (per spec, adapted): 1. measure the physical tray (+ chosen bottle) →
2. print static tray, no siphon (lid fit, insert fit, water tightness, light
blocking) → 3. add inlet → 4. siphon: bottle-cap variants, notch experiments,
flood-height tuning → 5. support/platform clearance check → 6. multi-tray test
with commodity manifolds → 7. integrate with the siphon-filter stage.

A tray passes when: it fills predictably, reaches the target flood height, the
siphon starts and breaks reliably across repeated unattended cycles, other trays
on the manifold are not significantly affected, and it passes leak testing
(overfill + soak + flex) and light-leak testing. The light-leak test runs in
a dark room with the LED lid installed: inspect the flood chamber for light
around the cell openings, the tray rim, the siphon region, and **both plumbing
penetrations** (feed socket and rear drain port); the chamber should remain
essentially dark at all four features.

Design priorities (original spec §42, in order):

1. reliable bell-siphon behavior
2. water-tight tray
3. compatibility with the existing LED lid
4. compatibility with the existing cell insert
5. light exclusion (including the drain channel — see 5.3 item 5)
6. easy cleaning
7. modular plumbing
8. compact physical footprint
9. minimal additional hardware
10. low-cost printing

### 5.14 Maintenance and Service

Routine maintenance, no tools, in order:

1. Remove the clear LED lid.
2. Lift out the 12-cell insert (rockwool, roots, cleaning).
3. Access the siphon — the bell cap lifts off the standpipe tower; no
   disassembly required.
4. Flush the flood chamber and inspect the drain channel.
5. Disconnect feed and rear drain fittings.
6. Move the tray.

Related CAD constraint: the model must not create a cavity unreachable with
the insert lifted out (see the 5.3 no-inaccessible-cavities assumption).

## 6. Design: `solarpunk_intelligence_hub`

- **Status:** rev_0003 built, audited, and installed (2026-09-22); complete
  manifest in `output/solarpunk_intelligence_hub/` (2 STL + 34 PNG +
  `build_manifest.json`; `scad_build_all.py --audit-only` passes; the
  "Rebuild stale CAD designs" task lists the design `CURRENT`). rev_0003
  corrects the four component mounting-hole patterns to the user-provided
  spans (relay 45 × 65, Pi 58 × 48, screen 93 × 54, camera 21 × 12),
  replacing rev_0001's fabricated uniform-inset rule (relay 34 × 55, Pi
  42 × 72, screen 82 × 44, camera 12 × 12); the hole centers were
  numerically re-verified against the installed rev_0003 mesh.
- **Role:** the series' electrical/IoT mounting backplane — one flat hanging
  plate to which every series electronic attaches through a single shared M3
  standoff plane. Raised Ø9.2 mm standoff collars on the top face set each
  device's standoff height, and 1 mm raised device outlines and centered
  labels make the assembled stack self-identifying.
- **Layout decisions (rev_0002, 2026-09-20):** the row-1 relays were swapped
  and rotated 90° vs rev_0001 (relay 2 is now portrait 52 × 73 at the left
  edge, relay 1 is now landscape 73 × 52 at the right edge); the camera sits
  centered between their nearest edges on the top-right relay's (relay 1's)
  center line; the Pi sits with its bottom edge on the bottom hanging band's
  top line (no longer corner-flush); relay labels are unnumbered ("RELAY")
  because the swap and rotation would otherwise tie the numbering to physical
  relay sockets rather than to the boards.
- **Hole-pattern correction (rev_0003, 2026-09-22):** rev_0001's conversion of
  the user-provided blockout replaced the real (asymmetric) hole spans with a
  fabricated uniform-inset rule (body − 2×9 mm; camera − 2×6.5 mm), so the
  mounted components would not have reached their holes. rev_0003 restores
  the user-provided natural-orientation spans — relay 45 × 65 (rotates with
  the board), screen 93 × 54, Pi 58 × 48 (48 × 58 in the rotated footprint),
  camera 21 × 12 — keeping every other layout decision of rev_0002.
- **Carried components (commodity, not designed here):** 3 × ESP32-Relay
  boards (52 × 73), 1 × display screen (100 × 62), 1 × camera module (25 × 25),
  1 × Raspberry Pi (90 × 60, in a 60 × 90 rotated footprint), 1 × meshtastic
  node (dimensions/pattern **open** — will land as a new revision).
- **Geometry (rev_0003):** flat 169 × 194 × 3 mm plate; 24 Ø3.2 mm M3
  component through-holes (4 per component) + 8 × 20 × 5 mm hanging slots
  (4 per band, mirrored: top band y 186..191, bottom band y 3..8, slot
  centers at x 20/63/106/149 — slot edges 10 mm from the plate sides); each
  band is an 11 mm zone (3 mm gap + 5 mm slot + 3 mm gap). The bottom band
  grew the plate 184.2 → 194 mm tall and moved the Pi / relay 3 row up 8 mm
  onto the band's top line. Uniform 3 mm edge margin and 3 mm gaps.
  User-provided per-component hole spans (rev_0003 correction): relay
  45 × 65 (natural orientation, rotates with the board), screen 93 × 54,
  Pi 58 × 48 (48 × 58 in the 60 × 90 rotated footprint), camera 21 × 12;
  in-board insets relay 3.5 / 4.0 mm, screen 3.5 / 4.0 mm, Pi 6.0 / 16.0 mm,
  camera 2.0 / 6.5 mm (tightest hole edge to plate edge 4.9 mm). Raised
  Ø9.2 mm M3 standoff collars (Ø3.2 bore, 3.0 mm wall): 22 collars at 24
  holes — 16 × 3 mm (relays + Pi) and 6 × 15 mm (screen 4 + camera top 2;
  the camera's lower pair stays open) for electronics clearance. Documented
  limitation: the tall camera collar (top pair) overhangs the 25 × 25 camera
  outline by 2.6 mm in x (`10.5 + 4.6 − 12.5`), cosmetic. Top-face
  marking: a 1 mm raised outline ring per footprint (camera exempt — its
  standoffs would merge into the ring band) plus 1 mm raised centered
  labels; label vertical centering compensates the OpenSCAD 2021.01 text
  baseline anchor (`label_y_off = 0.955 × label_size`, measured residual
  ≤ 0.25 mm on the built STL). Mounting-side bores are bare holes — no
  captive nuts, bosses, or countersinks.
- **Structural minimums (asserted at render):** `minimum_wall_thickness =
  3.0`; governing internal minimum is `minimum_internal_edge_width = 11.8 mm`
  — the tightest in-pattern ligament (camera 12 + 3 − 3.2).
- **Mockup part:** part 2 `backplane_blockout_mockup` is non-printable
  reference geometry (20 mm footprint blocks with hole patterns on the same
  plate), managed per
  `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md`;
  the pre-conversion reference `src/mockups/backplane_blockout.scad` is frozen
  and is not part of the manifest.
- **Open:** meshtastic node dimensions/pattern; material (working proposal
  PETG); cable management (unspecified).
- **Assembly governance:** not applicable — a single printable part plus a
  reference mockup (no `assembly.json`); precedent: `ac_redirectors`.

## 7. Design: `solarpunk_exhaust`

- **Status:** scaffold complete (rev_0001, plan V4 + V5 magnet-pocket
  addendum, user 2026-09-23); rebuilt, audited, and installed 2026-09-23 in
  `output/solarpunk_exhaust/` (2 STL + 36 PNG + 2 manifests;
  `scad_build_all.py --audit-only` passes). The config is a placeholder
  pending measurement of the real 120 mm fan's mounting span / hole pattern /
  depth, and `rev_0001` remains the mutable scaffold config (no immutable
  revision published; the geometry was reworked in place from the rejected
  original to V4, then extended to V5 under the same scaffold name, still
  uncommitted at the time of this phase — the single planned commit for one
  scaffold carries the final V5 state).
- **Role:** the printed mounting plate for the greenhouse's exhaust fan — one
  120 mm commodity fan with a large airflow cutout, velcroed over the
  greenhouse's ventilation screen so the fan blows through the screen to the
  outside. The hose/duct upstream of the fan is out of scope (commodity
  aluminum dryer hose, user-supplied).
- **Parts:** part 1 `solarpunk_exhaust` is the single 134 × 141 × 3 mm
  printable plate. Part 2 `fan_proxy` is a non-printable reference mockup of a
  120 mm fan: a 120 × 120 × 25 mm block with a 1:1 Ø116 mm through-hole, an
  M4-class Ø4.3 mm mounting bore, and a Ø110 mm intake side-notch — managed as
  reference geometry per
  `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md`.
- **Design decisions (rev_0001, plan V4):**
  - Airflow opening: a Ø116 mm through-cut at the fan center — the 120 mm fan
    blows through it to the outside. This corrects the rejected original
    geometry, which had no opening and put the velcro bands on two *opposite*
    edges inside the fan footprint.
  - Adjacent-edge velcro bands: 8 closed 20 mm × 5 mm through-windows in two
    bands on the two *adjacent* edges (left + top), outside the fan footprint.
    Each band carries two windows centered on the 1/4 and 3/4 lines of its
    edge, kept 3 mm (`velcro_gap`) from both the plate edge and the fan box
    edge.
  - Fan mount: four M4-class Ø4.3 mm through-bores in a 105 mm square centered
    on the fan, plus four raised Ø10.3 mm × 3 mm standoff collars. Placeholder —
    the real fan model sets the spans/pattern.
  - Fan intake: a Ø110 mm intake side-notch, 5 mm deep (fan proxy).
  - Front-face label; the outline ring around the opening is dropped (it would
    be a 2.0 mm internal rim).
  - Magnet retention (V5 addendum): 8 closed recessed pockets Ø6.1 × 2.0 mm in
    the back face, one flanking each station bore along both of its adjacent
    sides (11.5 mm offset from the bore center along the 105 mm station line —
    refined from the user's provisional 11.0 mm so every pocket void keeps the
    3.0 mm minimum against the collar OD). They take Ø6 × 2 mm neodymium
    retention discs pressing the plate to the ventilation screen; retention
    only — the discs are pulled *away* from the 1.0 mm back membrane, so the
    membrane carries only fan static pressure. The 1.0 mm membrane is a
    documented, user-accepted (2026-09-23) structural sub-minimum, asserted.
    Real magnet size / grade remains open.
- **Geometry (rev_0001, placeholder):** plate 134 × 141 × 3 mm; the fan box sits
  at x 11..131, y 10..130, center (71, 70); the opening is Ø116 mm at the
  center; bores Ø4.3 mm in a 105 mm square at (18.5, 17.5), (123.5, 17.5),
  (18.5, 122.5), (123.5, 122.5); collars 10.3 mm OD × 3 mm tall. Left-band
  windows x 3..8, y centers 35.25 / 105.75; top-band windows y 133..138, x
  centers 33.5 / 100.5. Velcro gap 3 mm. Magnet pockets (V5): Ø6.1 × 2.0
  recesses in the back face at (30, 17.5), (112, 17.5), (30, 122.5),
  (112, 122.5), (18.5, 29), (18.5, 111), (123.5, 29), (123.5, 111) — 11.5 mm
  from each flanked bore center along the station line; nearest-void
  clearances: 3.30 mm (collar OD, tightest), bore 6.30, Ø116 opening 5.56,
  plate edge / windows ≥ 7.45; back membrane 1.0 mm (documented sub-minimum).
- **Structural minimums (asserted at render):** `minimum_wall_thickness = 3.0`;
  `minimum_structural_overlap = 3.0`. The governing internal minimum is the
  3.0 mm plate thickness. Documented sub-minimums (asserted positive, not
  claimed as plate ligaments): (1) the 2.0 mm plateau between the Ø116 mm
  opening and the 120 mm fan box, bridged by the fan's frame at service; (2)
  the 1.0 mm back membrane below the 8 magnet pockets (V5, user-accepted
  2026-09-23, retention-only — away from the membrane).
- **Assembly governance:** this design has an `assembly.json` (contrast
  `solarpunk_intelligence_hub`, which is standalone with no `assembly.json`):
  primary `exhaust_system`, subassembly `exhaust_mount_assembly`, 2 parts, 3
  interfaces, 2 views. The assembly review manifest is bound to the build
  manifest hash and both STL hashes.
- **Out of scope (this phase):** hose/duct intake (commodity aluminum dryer
  hose, user-supplied); the velcro hardware; the real fan model.
- **Open:** the real 120 mm fan model (mounting span / hole pattern / depth);
  material (working proposal PETG); the hose intake method (user-owned).

## 8. Design: `solarpunk_siphon_filter`

- **Status:** deferred — no geometry this phase.
- **Role:** siphon-based filtration stage handling the combined drainage from
  multiple trays before water returns to the reservoir; provides the
  atmospheric stage that keeps the upstream tray siphons unpressurized.
- **Interface contract (must hold from this phase):**
  - Inlet: accepts ~1/2"+ return-manifold drainage, oversized, continuous
    fall into the inlet.
  - Outlet: returns to the reservoir, which stays below tray platform height.
  - Pressure-neutral (atmospheric) operation.
- **Open:** full design deferred; tray-side work only needs to expose a clean
  connection point.

## 9. Cross-Design Contracts

- The tray drain port and the siphon-filter inlet must stay on the same ~1/2"
  commodity plumbing standard (see 5.6).
- Any change to the drain port size/location or the siphon-filter interfaces
  must be recorded here before its CAD is written.
- Reference (non-printable) geometry — commodity LED dome, cell insert, and
  bottle-base bell — is managed per
  `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md` and
  must never appear as print artifacts.

## 10. Maintenance

- Update this document in the same task as any detail change to a solarpunk
  design (dimensions, decisions, scope, deviations, open items).
- Close open decisions by editing them in place (moving the value into the
  relevant dimensions/architecture sections), not by deletion.