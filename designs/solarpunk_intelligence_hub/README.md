# solarpunk_intelligence_hub

Canonical source of truth for this design and the solarpunk series:
[`docs/solarpunk_series.md`](../../docs/solarpunk_series.md)

*Status: rev_0002 built, audited, and installed (2026-09-20). Complete manifest
build produced a flat 37-file artifact set in `output/solarpunk_intelligence_hub/`
(2 STL + 34 PNG + `build_manifest.json`); `scad_build_all.py --audit-only` passes
and the "Rebuild stale CAD designs" task lists the design `CURRENT`. Two parts:
the printable plate (part 1) and a non-printable block-diagram mockup
(part 2, reference geometry only).*

## 1. Role

The intelligence hub is the series' **electrical / IoT mounting backplane**. It is
a single flat, horizontal plate that hangs from a rack or wall. Every series
electronic component attaches through **one shared standoff plane** on the
plate's underside, so components are co-planar and the plate reads as a single
logical backboard. Raised 3 mm / 15 mm M3 standoff collars on the top face set
and register each device's standoff height. The plate prints flat and is used as
a mounting surface — it carries no electronics of its own and has no internal
structure. The top face is marked with 1 mm raised device outlines and labels so
the assembled stack is self-identifying.

## 2. Carried Components

| Component | Count | Body (w × h) | Orientation on plate | Mounting-hole pattern (w × h) |
|---|---|---|---|---|
| ESP32-Relay board | 3 | 52 × 73 | relay 1 landscape 73 × 52; relay 2 portrait 52 × 73; relay 3 landscape 73 × 52 (row-1 relays swapped and rotated 90° vs rev_0001, 2026-09-20) | 34 × 55 |
| Display screen | 1 | 100 × 62 | landscape | 82 × 44 |
| Camera module | 1 | 25 × 25 | — | 12 × 12 |
| Raspberry Pi (4B/5 footprint) | 1 | 90 × 60 | rotated 90° (60 × 90 footprint) | 42 × 72 |
| Meshtastic node | 1 | **open** | **open** | **open** |

- Hole patterns are the user-provided component mounting images, approved as the
  final patterns on 2026-09-20.
- The Pi's 42 × 72 pattern fits inside the rotated 60 × 90 footprint with a
  9 mm inset on every side.
- The row-1 relays were swapped and rotated 90° (2026-09-20): relay 2 is now
  at the left edge (portrait, 52 wide × 73 tall), relay 1 at the right edge
  (landscape, 73 wide × 52 tall); the camera sits centered between their
  nearest edges on the top-right relay's (relay 1's) center line. 34 × 55 is
  the pattern span in the board's natural orientation and rotates with the
  board (orientation disambiguated 2026-09-20).
- A later series member (1 × meshtastic node) still needs to land on this plane;
  its dimensions and mounting pattern are not yet known. Adding it will be a new
  revision (it will not invalidate the current component layout unless the user
  wants the placement re-flowed).
- Mounting holes are **bare Ø3.2 mm M3 through-holes on the mounting (bottom)
  side** — no captive nuts, no countersinks. The top face carries raised
  **Ø9.2 mm standoff collars** (Ø3.2 bore, 3.0 mm wall) that set each standoff
  height: 3 mm standard; **15 mm at the 4 screen holes and the camera's top two
  holes** — the camera's lower pair stays open (approved 2026-09-20), for
  clearance for electronics behind those devices. 22 collars at 24 holes; every
  hole stays fully drilled so standoffs / nuts pass through.
- All components share **one standoff plane** (the standoff height is set by the
  collars, not by the plate).
- **Top-face marking:** every footprint except the camera carries a 1 mm raised
  outline ring (3 mm wide, at the structural minimum), and every device carries
  a 1 mm raised centered label. The relay labels are **unnumbered** ("RELAY",
  approved 2026-09-20) because the row-1 rotation tied the numbering to physical
  relay sockets rather than to the boards; the camera gets a label but no ring
  (its standoffs would merge into the ring band). Vertical box centering of the
  labels compensates the OpenSCAD 2021.01 text baseline anchor with
  `label_y_off = 0.955 × label_size` (measured glyph-box height 3.82 mm at
  label_size 4 on the built STL); the measured residual offset on the final
  build is ≤ 0.25 mm (inherent font kerning asymmetry).

## 3. Hanging Interface

- **8 × 20 × 5 mm hanging slots**, four per band, mirrored top and bottom
  (approved 2026-09-20; supersedes the rev_0001 top-only row of 4 × Ø3.2 M3
  hanging holes and the earlier Ø6 working proposal):
  - slot centers at x = 20 + i · 43 (i = 0..3) → 20, 63, 106, 149 mm — the
    slot edges are 10 mm from the plate's side edges;
  - top band slots span y = 186..191 (centers y = 188.5): slot top edge 3 mm
    from the plate's top edge; bottom band slots span y = 3..8 (centers
    y = 5.5): slot bottom edge 3 mm from the plate's bottom edge;
  - each band is an 11 mm zone: 3 mm gap + 5 mm slot + 3 mm gap.
- The bottom band moved the bottom equipment row (Pi / relay 3) up 8 mm: the
  plate grew 184.2 → **194 mm** tall and the Pi is no longer flush in the
  bottom-left corner (its bottom edge sits on the bottom band's top line,
  y = 11).
- The slots accept velcro-style hangers (slot dimensions approved as-is); the
  final hanging hardware is unspecified.

## 4. Confirmed Decisions

| Date | Decision |
|---|---|
| 2026-09-20 | Series membership: converts from a reference mockup to a manifest-driven design inside the solarpunk series (`docs/solarpunk_series.md`). |
| 2026-09-20 | Single shared standoff plane for all carried components. |
| 2026-09-20 | Plate thickness **3 mm** (supersedes the 2 mm working decision). |
| 2026-09-20 | All 24 component mounting holes are M3: Ø3.2 mm through (6 components × 4 holes). |
| 2026-09-20 | Per-component M3 patterns fixed from user-provided component images: relays 34 × 55 (natural orientation, rotates with the board), screen 82 × 44, Pi 42 × 72 (9 mm inset in the 60 × 90 rotated footprint), camera 12 × 12 (6.5 mm inset in the 25 × 25 body). |
| 2026-09-20 | Hanging interface: **8 × 20 × 5 mm slots, 4 per band, mirrored top and bottom** (supersedes the rev_0001 top-only Ø3.2 row); slot edges 10 mm from the side edges. |
| 2026-09-20 | Row-1 relays swapped and rotated 90° vs rev_0001 (relay 2 now portrait 52 × 73 at the left edge, relay 1 now landscape 73 × 52 at the right edge); the camera is centered between their nearest edges on the top-right relay's (relay 1's) center line. |
| 2026-09-20 | Top-face marking: 1 mm raised device outline ring + 1 mm raised centered label per footprint; **relay labels unnumbered** ("RELAY"); camera: label, no ring. |
| 2026-09-20 | Raised M3 standoff collars on the top face: Ø9.2 OD (3.0 mm wall), **3 mm** at the 16 relay/Pi holes and **15 mm** at the 4 screen holes and the camera's **top two** holes (camera lower pair open) — electronics-clearance driven. |
| 2026-09-20 | Final envelope fixed: **169 × 194 × 3 mm** plate (the bottom hanging band adds 8 mm to the rev_0001 169 × 184.2 envelope); the Pi / relay 3 row is seated on the bottom band's top line. |
| 2026-09-20 | Mounting-side bore spec: bare Ø3.2 M3 through-holes — no captive nuts, bosses, or countersinks; standoff heights come from the raised top-face collars. |

## 5. Open Decisions

1. **Meshtastic node dimensions and mounting pattern** — unknown. The 5th
   component cannot be plated until the node is chosen; when it lands it is a
   new revision.
2. **Material / print filament** — working proposal PETG; not confirmed.
3. **Cable management** — not specified; no cable channels, clips, or guides
   are modeled.
4. **Hanging hardware** — the 20 × 5 slot opening is fixed; the mating
   velcro / rail hardware is unspecified.

The placement layout, final plate size, plate thickness, and hanging-slot spec
were all resolved on 2026-09-20 and are recorded in §3–§4 instead.

## 6. Layout Envelope (final, rev_0002)

- Plate: **169 × 194 × 3 mm**, flat. Origin at the bottom-left corner.
- **3 mm edge margin** on the left and right sides and between component
  bodies / rows; the top and bottom edges are set by the two 11 mm hanging
  bands (3 mm gap + 5 mm slot + 3 mm gap).
- Placement (from the parametric layout in `src/lib/defaults.scad`, origin at
  the plate's bottom-left corner):
  - Top band: slots at y 186..191; row 1 top line at y = 183.
  - Row 1 (top, directly under the top band): relay 2 portrait 52 × 73 at
    x 3..55, y 110..183; camera 25 × 25 at x 61.5..86.5, y 144.5..169.5
    (center 74, 157 — on the top-right relay's center line, 3 mm clearance to
    each relay); relay 1 landscape 73 × 52 at x 93..166, y 131..183.
  - Row 2: Pi (rotated) 60 × 90 at x 3..63, y 11..101; screen 100 × 62 at
    x 66..166, y 66..128.
  - Row 3: relay 3 landscape 73 × 52 at x 93..166, y 11..63, right-aligned
    under the screen. The Pi / relay 3 bottom edges sit on the bottom band's
    top line (y = 11); bottom band slots at y 3..8.
  - Row widths 156 (row 1) / 163 (row 2) give the plate width:
    169 = 2 · 3 + 163.
- **24 Ø3.2 mm M3 through-holes** (4 per component, 9 mm inset per the approved
  patterns; camera inset 6.5 mm) + **8 × 20 × 5 mm hanging slots** (4 top,
  4 bottom).
- Raised top-face features per §2: 5 outline rings (3 mm wide, 1 mm tall), 6
  centered labels, 22 standoff collars at 24 holes (16 × Ø9.2 × 3 mm +
  6 × Ø9.2 × 15 mm — screen four + camera top pair).
- **Structural minimums (asserted at render):** `minimum_wall_thickness = 3.0`,
  `minimum_structural_overlap = 3.0` (not applicable — no joins),
  `minimum_internal_edge_width = 11.8 mm`, governed by the tightest in-pattern
  ligament: the camera's 12 mm hole span, i.e. `12 + 3 − 3.2 = 11.8`. Rim /
  width checks: component-hole edge to plate edge — tightest is the camera
  (smallest inset 6.5 mm) → `6.5 − 3.2/2 + 3 = 7.9 ≥ 3.0`; slot edge to plate
  side edge `velcro_edge_margin = 10 ≥ 3.0`; slot edge to plate
  top/bottom edge and to row 1 / bottom row `velcro_gap = 3 ≥ 3.0`; outline
  ring width and every standoff collar wall `= 3.0 ≥ 3.0`; the tall camera
  collar fits its 25 mm body (`6.5 + 9.2/2 = 11.1 ≤ 12.5`). The Pi at
  x 3..63 clears slot 1 (x 10..30, y 3..8) and the camera's column by far more
  than the minimum; the tightest slot-related clearances asserted above are the
  3 mm band edges. Exact asserts are in
  `src/parts/solarpunk_intelligence_hub.scad`.
- **Frozen reference:** `src/mockups/backplane_blockout.scad` (169 × 187
  envelope with its own top parameters: 2 mm plate, 15 mm component blocks,
  Ø6 hanging holes) is retained unedited as the design-origin reference only;
  it is not in the manifest, not rendered by `scad_build_all.py`, and must not
  be treated as current geometry.

## Layout

- `parts.json` — parts manifest: part 1 `solarpunk_intelligence_hub` (the
  printable plate), part 2 `backplane_blockout_mockup` (non-printable
  reference geometry).
- `configs/rev_0002.json` — active configuration (3 mm plate, Ø3.2 M3
  component holes, 8 × 20 × 5 hanging slots, 1 mm outlines / labels, 3 mm /
  15 mm standoffs, 3 mm margins/gaps, max print 220 mm).
- `configs/rev_0001.json` — retained working configuration from the
  rev_0001 working cycle (no `revisions/` publication of rev_0001).
- `src/main.scad` — top-level dispatch on `part_id` (1 → printable plate,
  2 → block-diagram mockup); `part` and `part_id` are injected by
  `scad_build_all.py`.
- `src/lib/defaults.scad` — parametric defaults and layout math shared by both
  parts: envelope 169 × 194, the two mirrored hanging bands, row widths,
  component positions, hole-inset constants (9 / 9 / 6.5 / 9), slot centers,
  standoff heights (3 mm / 15 mm), label box-centering, and the
  structural-assertion helpers (`tightest_ligament()` → 11.8, rim-margin
  check).
- `src/parts/solarpunk_intelligence_hub.scad` — the printable plate: 169 ×
  194 × 3 mm with 24 Ø3.2 through-holes, 8 hanging slots, 1 mm raised
  outlines / labels, 22 raised M3 standoff collars (3 mm / 15 mm), and the
  structural asserts.
- `src/parts/backplane_blockout_mockup.scad` — non-printable reference block
  diagram: same 169 × 194 plate + 20 mm component blocks with per-component M3
  holes and both slot bands, for visual review (colored; the `gray80` color
  warning is benign).
- `src/mockups/` — frozen pre-conversion reference (see §6); not in the
  manifest, not built.
- Artifacts: `output/solarpunk_intelligence_hub/` — flat, complete set
  (2 STL + 34 PNG + `build_manifest.json`, 37 files); provenance recorded in
  `build_manifest.json`; audited by `scad_build_all.py --audit-only`.
- Assembly governance (assembly.json / assembly review) does **not** apply: a
  single printable part plus a reference mockup (precedent: `ac_redirectors`).