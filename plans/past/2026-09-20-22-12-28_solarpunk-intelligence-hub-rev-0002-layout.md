---
plan_id: 2026-09-20-22-12-28_solarpunk-intelligence-hub-rev-0002-layout
title: solarpunk_intelligence_hub layout changes (slots, relay swap, camera center) as rev_0002
summary: Apply the approved layout changes to solarpunk_intelligence_hub — mirrored top+bottom 20×5 mm hanging slot bands (8 slots), row-1 relay swap with 90° rotation and the camera centered on the top-right relay's center line, Pi seated on the bottom band (plate 169 × 194 × 3 mm), plus late-requested 1 mm raised outlines/labels (unnumbered RELAY), raised Ø9.2 M3 standoff collars (3 mm / 15 mm; camera top pair only), and the label vertical-centering fix (label_y_off 0.71 → 0.955) — as a new rev_0002 candidate built into installed output with audit, docs, and journal checkpoint (no commit, no push).
status: past
created_at: 2026-09-20-22-12-28
---

# solarpunk_intelligence_hub layout changes (slots, relay swap, camera center) as rev_0002

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Objective

Apply the user-approved rev_0002 layout changes to the solarpunk intelligence
hub, baked parametrically into a new candidate revision `rev_0002` installed
into the mutable `output/` directory (rev_0001 is still uncommitted WIP, so no
committed revision identity is invalidated; no `revisions/` snapshot is
created this task):

1. **Hanging interface**: the 4 × Ø3.2 top hanging holes become **8 slots,
   20 mm wide × 5 mm tall, 4 per band, mirrored top and bottom**. Slot
   centers at x = 20, 63, 106, 149 mm (10 mm slot-edge margin, 43 mm pitch —
   the Ø3.2 row's 3…166 spread cannot host a 20 mm slot). Each band is
   11 mm (3 mm gap + 5 mm slot + 3 mm gap). TOP band: slots y 186…191
   (center 188.5) — 3 mm to plate top and 3 mm to row 1's top line at 183.
   BOTTOM band: slots y 3…8 (center 5.5) — 3 mm to plate bottom (Option A,
   chosen over a bottom-only set and a no-bottom-band layout). The bottom
   band lifts the Pi / relay 3 row 8 mm onto its top line (y = 11), growing
   the plate 184.2 → **194 mm**.
2. **Row-1 relay swap + 90° rotation**: relay 2 ends at the LEFT edge
   portrait 52×73 (x 3–55, y 110–183); relay 1 ends at the RIGHT edge
   landscape 73×52 (x 93–166, y 131–183). (Rev_0001 had relay 1 portrait at
   the left and relay 2 landscape at the right — both edges and both
   orientations swapped.)
3. **Camera** centered between the relays' nearest edges on the top-right
   relay's (relay 1's) center line: x 61.5…86.5 (center x = 74; 6.5 mm
   clear each side — asserted equidistant), y 144.5…169.5 (center y = 157 =
   relay 1's center line; asserted `cam_cy() == rly1_cy()`).

Late requests folded in during execution (all user-approved, 2026-09-20):

4. **Top-face marking**: 1 mm raised device outlines (3 mm wide rings) +
   1 mm raised centered labels ("RELAY" ×3 UNNUMBERED — the swap/rotation
   would tie numbering to physical relay sockets, not boards; "CAMERA",
   "PI", "SCREEN"); the camera gets a label but no ring (its standoffs would
   merge into the ring band). Label vertical centering compensates the
   OpenSCAD 2021.01 text baseline anchor: `label_y_off = 0.955 × label_size`
   (measured glyph-box height 3.82 mm at label_size 4 — corrected from the
   0.71 cap-height estimate); the final build measures all six labels at y
   offset exactly 0.00 mm (x residuals ≤ 0.25 mm = font kerning asymmetry).
5. **Raised Ø9.2 mm M3 standoff collars** (Ø3.2 bore, 3.0 mm wall) on the
   top face: **3 mm** at the 16 relay/Pi holes, **15 mm** at the screen
   (4) and the camera's **top two** holes — the camera's lower pair stays
   open (22 collars at 24 holes; every hole fully drilled).
   Electronics-clearance driven, consistent with the bare-bottom spec (no
   nuts/countersinks).

Consequences (verified): **board size 169 × 194 × 3 mm** (≤ 220 mm print
limit). `row1_top() = 183`; rly2 (y 110…183, portrait), rly1 (y 131…183,
landscape), camera (74, 157); screen (x 66…166, y 66…128); Pi (rotated,
60×90 at x 3…63, y 11…101) and rly3 (x 93…166, y 11…63) seated on the
bottom band's top line (y = 11). **rly3 stays bottom-right under the
screen** (bottom-left would overlap the Pi's footprint — rejected
alternative).

Structural minimums: wall 3.0, overlap 3.0 (N/A — single flat plate),
tightest ligament `minimum_internal_edge_width = 11.8` (camera 12 + 3 −
3.2, governs). Checks that hold: slot dims (20 × 5) and slot edge margin
(10.0) ≥ minimum_wall_thickness; slot-to-row clearance 3.0 (band gap);
band-to-edge 3.0; camera-to-relay clearance 6.5 ≥ 3 (equidistant) and
`cam_cy() == rly1_cy()`; tall-collar wall/fits (camera: 6.5 + 4.6 = 11.1 ≤
12.5); camera-hole rim 7.9 ≥ 3.0; ring/collar wall 3.0 ≥ 3.0.

## Information (approved decisions, 2026-09-20)

- Hanging interface: **8 × 20 mm (wide) × 5 mm (tall) slots, 4 per band,
  mirrored top and bottom**, centers at x = 20 + i · 43 mm (20, 63, 106,
  149; 10 mm slot-edge margin, 43 mm pitch), centered in 11.0 mm bands
  (3 + 5 + 3): top y 186…191, bottom y 3…8. Supersedes the 4 × Ø3.2
  hanging holes of rev_0001.
- Top-row order: **rly2 (portrait 52×73) left, camera center, rly1
  (landscape 73×52) right** (swapped and rotated 90° vs rev_0001's left
  portrait rly1 / right landscape rly2).
- Camera alignment: equidistant from the two relays' nearest edges (6.5 mm
  clear on each side of the 25 mm camera, x = 74) and on the top-right
  relay's (**relay 1's**) center line (y = 157; user-confirmed the top
  relay's center line).
- Pi: rotated so its 90 mm side is vertical, 60×90 footprint seated on the
  bottom band's top line (y 11), x 3…63; plate height grows 184.2 →
  **194 mm** (within 220 mm).
- Revision handling: new candidate config `rev_0002`, built with
  `--destination current` into `output/solarpunk_intelligence_hub/`
  (same-recipe pattern as `solarpunk_seed_tray`, which iterates its
  configs in-place on uncommitted WIP). No `revisions/` publication this
  task — publication happens at the governed commit, which this task does
  not make.

## Constraints

- Geometry only under `designs/solarpunk_intelligence_hub/`; shared layout
  stays in `src/lib/defaults.scad` so the printable plate and the reference
  mockup part cannot drift.
- Component mounting-hole spans are unchanged (relay 34×55, screen 82×44,
  Pi 42×72, camera 12×12); only positions and the hanging slots change.
- Frozen reference `src/mockups/backplane_blockout.scad` is NOT edited.
- No `assembly.json` (single printable part + reference mockup;
  `ac_redirectors` precedent).
- The final installed output must be flat, exactly 2 STL + 34 PNG +
  `build_manifest.json` (37 files), with staging removed; `--audit-only`
  must pass on the installed set.
- Do not touch pre-existing unrelated WIP (seed tray, fan guard, root
  README.md, etc.).
- Commit policy: **no commit, no push** — stop at verified artifacts + docs
  and report; commit only on explicit user approval (task-scoped paths only).

## Expected Files (created/modified by this plan)

- `plans/future|current|past/2026-09-20-22-12-28_solarpunk-intelligence-hub-rev_0002-layout.md` (this plan)
- `designs/solarpunk_intelligence_hub/src/lib/defaults.scad`
- `designs/solarpunk_intelligence_hub/src/parts/solarpunk_intelligence_hub.scad`
- `designs/solarpunk_intelligence_hub/src/parts/backplane_blockout_mockup.scad`
- `designs/solarpunk_intelligence_hub/configs/rev_0002.json`
- `designs/solarpunk_intelligence_hub/README.md`
- `docs/solarpunk_series.md` (§3 inventory row + §6 design section)
- `journal/2026-09-20.md`
- `plans/{future,current,past}/index.md` (regenerated)
- `output/solarpunk_intelligence_hub/*` (rebuilt flat artifact set, rev_0002)

## Checklist

- [x] 1. Author plan, request approval, promote to `plans/current/`
  - [x] 1.1 Strategy confirmed with user (slot count/spread, relay swap,
        plate height) — answers received 2026-09-20.
  - [x] 1.2 Promote plan file to `plans/current/` (user "continue" =
        approval of the presented strategy).
- [x] 2. Layout source changes (`src/lib/defaults.scad`)
  - [x] 2.1 Replace circular hanging-hole parameter surface with slot
        surface (mirrored top+bottom bands): `velcro_slot_w = 20.0`,
        `velcro_slot_h = 5.0`, `velcro_edge_margin = 10.0` (removes
        `velcro_d`); `velcro_gap = 3.0`, `velcro_n = 4`; band = 3 + 5 +
        3 = 11.0; top-band slot-center y = `board_h() - velcro_gap -
        velcro_slot_h / 2` = 188.5 (span 186…191), bottom band
        `velcro_y_bottom() = velcro_gap + velcro_slot_h / 2` = 5.5
        (span 3…8); `hanging_x(i)` = 20 + i · 43 (20, 63, 106, 149), pitch
        derived from
        `(board_w() - 2 * (velcro_edge_margin + velcro_slot_w / 2)) /
        (velcro_n - 1)` = 43.
  - [x] 2.2 Swap row-1 positions (swapped and rotated 90° vs rev_0001):
        `rly2_x() = edge_margin` (left, portrait 52×73, y 110…183),
        `rly1_x() = board_w() - edge_margin - relay_ls_w` (right,
        landscape 73×52, y 131…183); camera
        `cam_cx() = (rly2 right edge + rly1 left edge) / 2 = 74`,
        `cam_cy() = rly1_cy() = 157` (user-confirmed top relay's center
        line). `row1_w()` = `relay_ss_w + 2*gap + cam_w + relay_ls_w`
        (still 156).
  - [x] 2.3 Row 2/3 re-anchor on the bottom band: `row2top() =
        velcro_y() + velcro_band()` = 11 (bottom band's top line);
        `rly3_y() = row2top()` (y 11…63), `scr_y() = row2top() +
        relay_ls_h + gap` (66), Pi rotated 90° so its 90 mm side is
        vertical: `pi_w() = pi_ss_h` (60), `pi_h() = pi_ss_w` (90),
        `pi_x() = edge_margin`, `pi_y() = row2top()` (y 11…101, x 3…63).
        `board_h() = edge_margin + relay_ls_h + gap + scr_ls_h + gap +
        relay_ss_h + velcro_band()` = 3 + 52 + 3 + 62 + 3 + 73 + 11 =
     x] 2.4 Assert helpers: camera equidistance to nearest relay edges
        (both = 6.5 ≥ minimum_wall_thickness) and `cam_cy() == rly1_cy()`;
        slot dims (20 × 5) and slot-edge margin (10.0) ≥
        minimum_wall_thickness; slot-to-row gap = velcro_gap (3.0) on both
        bands; band-to-edge = velcro_gap (3.0); hanging slot spread
        (20/63/106/149, symmetric about board center);
        `minimum_internal_edge_width = 11.8` (camera 12 + 3 − 3.2
        governs); camera-hole rim (6.5 − 1.6 + 3 = 7.9) ≥ 3.0;
        ring/collar wall 3.0 ≥ 3.0; tall-collar fits (camera: 6.5 + 4.6 =
        11.1 ≤ 12.5; Pi: 11.5 ≤ 21); plate ≤
       _wall_thickness; slot-to-row-1 gap = velcro_gap (3.0);
        hanging slot spread (20/63/106/149, symmetric about board center);
        plate ≤ maximum_print_dimension (220).
- [x] 3. Printable part (`src/parts/solarpunk_intelligence_hub.scad`)
  - [x] 3.1 Hanging geometry: 8 rectangular slots (20 wide × 5 tall boxes,
        4 per band, mirrored top and bottom) through the 3 mm plate instead
        of 4 Ø3.2 cylinders; 1 mm raised device outlines + labels (unnumbered
        RELAY ×3, CAMERA, PI, SCREEN) + 22 raised Ø9.2 M3 standoff collars
        (3 mm ×16, 15 mm ×6) added; part header comment updated (24
        component holes + 8 slots; 169 × 194 × 3).
  - [x] 3.2 Update header/structural asserts to the new slot surface
        (mirrored bands, minimum_internal_edge_width 11.8, collar fits);
        component-hole block unchanged (24 holes, spans unchanged).
- [x] 4. Mockup part (`src/parts/backplane_blockout_mockup.scad`)
  - [x] 4.1 Envelope assert → 169 × 194; hanging geometry → 20 × 5 slots
        mirrored top and bottom (same math as the printable part via
     x] 5.1 `part: "solarpunk_intelligence_hub_rev_0002"`, `part_id: 1`,
        slot params (`velcro_slot_w: 20.0`, `velcro_slot_h: 5.0`,
        `velcro_edge_margin: 10.0`, no `velcro_d`), plus top-face marking
        params (outline 1.0/3.0, text 1.0, label_size 4.0) and standoff
        collar params (3.0/15.0 tall, Ø9.2); rev_0001.json retained
        uneditedslot_w: 20.0`, `velcro_slot_h: 5.0`,
        `velcro_edge_margin: 10.0`, no `velcro_d`), all other params
        identical to rev_0001.
- [x] 6. Build installed artifacts for rev_0002
  - [x] 6.1 `python scripts/scad_build_all.py --design solarpunk_intelligence_hub
        --config designs/solarpunk_intelligence_hub/configs/rev_0002.json
        --destination current` → flat install, staging removed.
  - [x] 6.2 Inspect installed artifacts: plate STL bbox 169.00 × 194.00 ×
        3.00 (outer 169 × 194 × 18 incl. 15 mm collars), single shell,
        12568 tris / 8028 verts; 8 slots 20×5 at top band y 186…191 /
        bottom band y 3…8, x = 20/63/106/149 (ground-truth STL vertices
        confirmed); 24 component holes at the new positions (rly2 left,
        rly1 right, camera near (74, 157)); all six labels measured at y
        residual exactly 0.00 mm (x ≤ 0.25 mm kerning).
- [x] 7. Audit + pipeline pickup
  - [ ] 7.1 `scad_build_all.py ... rev_0002.json --audit-only` passes
        (2 parts, 2 STL, 34 PNG).
  - [ ] 7.2 VS Code task "Rebuild stale CAD designs" (`--all`) reports
        `CURRENT solarpunk_intelligence_hub: ...rev_0002.json`.
- [x] 8. Documentation
  - [x] 8.1 `designs/solarpunk_intelligence_hub/README.md` fully rewritten
        to the final rev_0002 state: §2 orientation column (rly2 left
        portrait, rly1 right landscape, swapped and rotated 90° vs
        rev_0001; unnumbered RELAY labels), §3 hanging interface (8 × 20×5
        slots, mirrored bands, x = 20 + i·43, 184.2 → 194), §4 confirmed
        decisions rows, §5 open items, §6 layout envelope (169 × 194 × 3,
        camera at (74, 157) on rly1's center line, Pi seated on the bottom
        band, 22/24 collars, structural minimums incl. 11.8), status line
        (rev_0002 built, audited, installed, CURRENT).
  - [ ] 8.2 `docs/solarpunk_series.md`: §3 inventory status → rev_0002;
   x] 9. Journal checkpoint `journal/2026-09-20.md` (appended 4 work-log
  entries at 23:02 local + Plan Checkpoint Linkage updated
        mm).
- [ ] 9. Journal checkpoint `journal/2026-09-20.md` (append work-log entries)
- [x] 10. Plan closure
  - [x] 10.1 Mark completed items `[x]`, status `past`, move plan to
        `plans/past/`.
  - [x] 10.2 Regenerate plan indexes + `--check` silent (clean).
- [x] 11. Report (no commit, no push)
  - [x] 11.1 `git status -sb`; report AGENTS.md §12 completion summary;
        propose task-scoped commit message only.

## Verification

- `scad_build_all.py --audit-only` on rev_0002 → `Audit passed: 2 parts,
  2 STL, 34 PNG, 36 artifacts`.
- Installed `output/solarpunk_intelligence_hub/` is flat (0 directories,
  no `.scad`), exactly 37 files, manifest records rev_0002.
- Plate STL bbox = 169.00 × 194.00 × 3.00 (outer 169 × 194 × 18 incl.
  15 mm collars); 1 shell; 8 slots 20×5 at top band y 186…191 / bottom
  band y 3…8, x = 20/63/106/149; 22 collar stacks (16 × 3 mm, 6 × 15 mm);
  all six labels centered (y residual 0.00 mm, x ≤ 0.25 mm kerning)
  measured on the installed STL.
- All named asserts pass at render (OpenSCAD compiles part 1 and part 2
  without assert failures).
- `plans/**/index.md` regenerated; `--check` silent.
- Docs grep: no stale `184.2` / `179.6` / `Ø3.2`-hanging references remain
  in the hub README or series doc §6.

## Risks

- Slot + swap change the plate silhouette; a wrong row1 width would hide
  behind the row-2 width — mitigated by asserting `board_w() == 169` and
  re-deriving in the mockup envelope assert (194).
- "the top relay's center line" naming ambiguity — resolved: after the
  swap relay 1 is the top-RIGHT landscape relay, so the camera sits on
  relay 1's center line, `cam_cy() == rly1_cy() = 157` (asserted);
  relay 2's center line (146.5) was not chosen.
- rly2 (left, x 3…55, y 110…183) and the screen (x 66…166, y 66…128)
  overlap in y but are separated in x — no collision; the "24 mm gap"
  concern applied only to the pre-final 207 mm draft layout and no longer
  applies to the shipped 194 mm layout.
- Uncommitted rev_0001: superseded in-place per the repo's WIP pattern
  (seed tray); no immutable revision is touched, so no revision identity
  is rewritten.