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
| `solarpunk_seed_tray` | design phase; no geometry yet | Per-tray converter: TPU flood tray with integrated bell siphon |
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
   original spec's bottom-exit proposal.
6. **Inlet** — socket for the 1/4" feed fitting.

Reinforcement: thickened rim, vertical ribs, reinforced corners (mitigates TPU
wall flex when flooded).

### 5.4 Bottle-Base Bell (commodity)

- The bell is a cut plastic bottle base fitted over the standpipe tower as its
  cap; the bottle is not printed.
- Notches cut in the base define the flow/air-break path. Notch geometry and the
  bottle cut height set the siphon-break level and are the primary empirical
  tuning knobs (phase 4).
- A typical 2 L bottle base is ~85–90 mm ID versus the original spec's ¾–1" bell
  baseline; the larger bell makes siphon initiation easier.
- Exact bottle interface (diameter, skirt height, notch dimensions) is open
  until phase-4 experimentation.

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

### 5.7 Print and Structural Parameters

- Material: TPU 95A, opaque (black preferred).
- Walls 2.4–3.2 mm; floor 2–3 mm; 3–5 perimeters.
- `minimum_wall_thickness`: 2.4 mm (tentative — confirm at blockout).
- `minimum_structural_overlap`: ≥ `minimum_wall_thickness` (declare at blockout).
- Dominant structural risk: wall flex when flooded — mitigated by ribs and
  reinforced corners.
- Avoid: fine printed threads, microscopic passages, rigid dimensional fits
  (TPU concerns).

### 5.8 Support / Platform

- Trays sit on a simple support that keeps the plumbing accessible behind/below
  them.
- The original 30–50 mm under-tray service space for a downleg and elbow is
  relaxed because the drain exits the rear wall of the tray.
- Printed vs. commodity support: open; the support is the simplest item in the
  design.

### 5.9 Open Decisions

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

### 5.10 Phase 1 Measurement List

- Original tray outer L/W/H.
- Rim cross-section: lid sits outside the walls, locates in a groove/lip, or
  engages tabs.
- Seed-cell insert outer L/W and ledge height.
- Cell pitch (X/Y), cell opening W × L, cell bottom height, drain perforation
  pattern.
- Internal clearance at the rear edge (tower + drain bend needs ~40 mm).
- Corner radii; locating tabs/recesses.
- Chosen bottle: base ID/OD at the intended cut line.

### 5.11 Recorded Deviations from the Original Specification (2026-09-17)

- §18 bottom-exit siphon → integrated **rear-wall** drain exit.
- §14–16 swappable printed standpipe/bell/guard cartridge → **integrated
  standpipe and drain** in the tray; **commodity bottle-base bell**; no printed
  root guard by default.
- §22 printed return manifold → **commodity pipe and fittings**.
- Platform height target relaxed (no downleg to house).

### 5.12 Development Sequence and Acceptance

Phases (per spec, adapted): 1. measure the physical tray (+ chosen bottle) →
2. print static tray, no siphon (lid fit, insert fit, water tightness, light
blocking) → 3. add inlet → 4. siphon: bottle-cap variants, notch experiments,
flood-height tuning → 5. support/platform clearance check → 6. multi-tray test
with commodity manifolds → 7. integrate with the siphon-filter stage.

A tray passes when: it fills predictably, reaches the target flood height, the
siphon starts and breaks reliably across repeated unattended cycles, other trays
on the manifold are not significantly affected, and it passes leak testing
(overfill + soak + flex) and light-leak testing (dark room, LEDs on, chamber
essentially dark around cell openings, rim, and the siphon area).

## 6. Design: `solarpunk_siphon_filter`

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

## 7. Cross-Design Contracts

- The tray drain port and the siphon-filter inlet must stay on the same ~1/2"
  commodity plumbing standard (see 5.6).
- Any change to the drain port size/location or the siphon-filter interfaces
  must be recorded here before its CAD is written.
- Reference (non-printable) geometry — commodity LED dome, cell insert, and
  bottle-base bell — is managed per
  `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md` and
  must never appear as print artifacts.

## 8. Maintenance

- Update this document in the same task as any detail change to a solarpunk
  design (dimensions, decisions, scope, deviations, open items).
- Close open decisions by editing them in place (moving the value into the
  relevant dimensions/architecture sections), not by deletion.