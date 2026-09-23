---
plan_id: "2026-09-22-21-27-00_solarpunk-intelligence-hub-rev-0003-hole-pattern-correction"
title: "solarpunk_intelligence_hub rev_0003 — correct mounting-hole patterns to user-provided spans"
summary: "rev_0001/rev_0002 built the four component hole patterns from a fabricated uniform-inset rule (body − 2×9 mm; camera − 2×6.5) that replaced the user-provided asymmetric layout at the manifest conversion. rev_0003 replaces the derived spans with the user-provided center-to-center spans recorded in the frozen mockup (relay 45×65, Pi 58×48, screen 93×54, camera 21×12), rebuilds, re-verifies, and corrects all carried documentation."
status: past
created_at: "2026-09-22-21-27-00"
---

# Context

**Root cause (established, verified against the installed STL):** the conversion
plan for rev_0001 (`plans/past/2026-09-20-18-39-00_...manifest-conversion.md`,
Design decisions items 1-2) replaced the user-provided hole layout with
single uniform-inset rules and documented those values as approved. The values
propagated into `defaults.scad` -> rev_0001 -> rev_0002 -> README -> series doc
-> journal -> installed STL. The frozen reference
`designs/solarpunk_intelligence_hub/src/mockups/backplane_blockout.scad` (frozen
2026-09-20, the surviving record of the user-provided blockout) holds the true
spans, in natural orientation: relay `relay_px=45 relay_py=65`, Pi `pi_px=58
pi_py=48`, camera `cam_px=21 cam_py=12`, screen `scr_px=93 scr_py=54`. All four
built patterns are wrong; the rotation/swap logic was correct all along.

**Correct spans by physical orientation** (from the above):

| Component | Orientation on plate | span_x | span_y |
|---|---|---|---|
| relays 1/3 | landscape 73×52 | 65 | 45 |
| relay 2 | portrait 52×73 | 45 | 65 |
| Pi (rotated) | 60×90 | 48 | 58 |
| screen | 100×62 (landscape) | 93 | 54 |
| camera | 25×25 | 21 | 12 |

**Invariants (unchanged by the fix):** plate envelope 169×194×3 bodies; all
component positions/bands/slots; `tightest_ligament()` = 11.8 (camera y-span 12
+ 3 gap − 3.2); `minimum_internal_edge_width = 11.8`; render Z extent 18 (15 mm
tall collars); 24 holes, 22 collars; both parts and audit structure (2 STL +
34 PNG + manifest, flat).

**New findings the fix must handle in code:**

1. Rim assert (`solarpunk_intelligence_hub.scad`): currently
   `assert(cam_hole_inset - 2*m3_d/2 + edge_margin >= minimum_wall_thickness)`
   subtracts a full Ø instead of a radius. With the corrected camera x-inset of
   2.0 mm the radius form is the correct physical check: hole edge to block end
   = 2.0 − 1.6 + 3.0 label zone = 3.4 ≥ 3.0 (the block is solid; the outline
   ring is camera-exempt).
2. Camera collar fit asserts: the true condition (hole-circle edge inside the
   camera block in x) fails by design: hole offset 10.5 + collar radius 4.6 =
   15.1 > block half-width 12.5, so the camera's **lower (open, y=+6) Ø9.2 collar
   pair overhangs the 25 mm camera body by 2.6 mm per side**. The collars stand
   on solid plate — purely cosmetic. **Decision (default, flagged to user):**
   keep Ø9.2 collars, accept the overhang as a documented design note (the
   hardware truth is the hole pattern; the collars are functional standoffs for
   the camera module whose real PCB footprint may differ from the 25 mm
   blockout). The two asserts are rewritten to verify what is actually true
   (collar outer edge within the plate, margin ≥ 3.0) with the overhang
   documented, instead of the previous check that verified the derived inset and
   masked the condition.
3. Config surface: `scripts/scad_build.py` injects every config key as a `-D`
   define, so rev_0003 renames `*_hole_inset` to the eight span keys; the
   retained production parameter names (`relay_ss_span_x` etc.) become
   explicit `is_undef` parameters so configs can override them.

**Out of scope:** no position/envelope changes; no `assembly.json` (N/A
precedent); frozen mockup untouched; meshtastic node stays open; no
revisions/ snapshot in this task (possible follow-up, not approved).

# Checklist

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [x] Root-cause investigation completed and reported; user approved the fix
      ("ok fix it", 2026-09-22) — including the default camera-collar decision
      in Context item 2
- [x] `defaults.scad`: replace `relay/pi/cam/scr_hole_inset` with the eight
      user-provided span parameters (natural orientation, `is_undef`
      overridable: `relay_span_nat_x/y = 45/65`, `pi_span_nat_x/y = 58/48`,
      `scr_span_nat_x/y = 93/54`, `cam_span_nat_x/y = 21/12`) with a comment
      citing the frozen mockup as source of truth; span functions become
      explicit `is_undef` parameters (relay_ss 45×65, relay_ls 65×45, pi_ss
      48×58, scr 93×54, cam 21×12); update the blockout-decisions comment
      block (lines ~76-78) and provenance (lines ~36-44)
- [x] `solarpunk_intelligence_hub.scad`: header comment spans -> 45×65 / 93×54 /
      48×58 / 21×12; rim assert -> radius form (expected 3.4 ≥ 3.0) with
      updated explanatory comment; camera collar-fit asserts rewritten to the
      true conditions (collar within plate; documented 2.6 mm x overhang note);
      ligament comment (cam_y 12 governs) verified/updated
- [x] `backplane_blockout_mockup.scad`: confirmed no code changes needed (it
      consumes the shared span functions; its 169×194 envelope assert still
      holds) — record verification of rendered output in step [rebuild]
- [x] `main.scad`: stale header comment ("169 x 187 x 3 mm, 22x M3 holes")
      corrected to the current 169 × 194 × 3 mm / 24 holes
- [x] `configs/rev_0003.json`: copy of rev_0002 with `part` =
      `solarpunk_intelligence_hub_rev_0003` and the four `*_hole_inset` keys
      replaced by the eight span keys (45/65, 58/48, 93/54, 21/12)
- [x] Build rev_0003 through the governed pipeline: explicit
      `scripts/scad_build_all.py --design solarpunk_intelligence_hub --config
      designs/solarpunk_intelligence_hub/configs/rev_0003.json` (first build
      must be explicit — the rebuild task follows the installed manifest's
      `config.path`), then `--audit-only` passes
- [x] Numeric STL verification: 24 holes at the corrected centers (relay-ls
      ±32.5/±22.5, relay-ss ±22.5/±32.5, Pi ±24/±29, screen ±46.5/±27, camera
      ±10.5/±6) with 0% residual at the old positions; bounds 0..169 × 0..194 ×
      18; 37 flat files
- [x] "Rebuild stale CAD designs" reports this design CURRENT (installed
      manifest's `config.path` = rev_0003)
- [x] README.md: correction note (rev_0003 supersedes 0001/0002 hole patterns;
      root cause one-liner); table pattern column (45×65 / 93×54 / 21×12 /
      48×58); inset wording + ligament note in §6 layout; camera collar x
      overhang documented; status line; config list (rev_0003 active, rev_0002
      retained)
- [x] `docs/solarpunk_series.md` hub section: status line; geometry paragraph
      span sentence (lines ~352-354) + ligament note (unchanged 11.8) + camera
      collar overhang note; layout-decisions row gains a rev_0003 correction
      row
- [x] `journal/2026-09-22.md` created (template shape; Intentions/Notes `-`):
      work log for this correction + Plan Checkpoint Linkage
- [x] Scratch verification script removed (none left in repo)
- [x] `git status -sb` clean apart from this task's files and the 9 unrelated
      stale plans in `plans/current/` (not touched)
- [x] Plan finalized (checklist reconciled) and archived to `plans/past/`
- [x] Plan indexes regenerated (`regenerate_plan_indexes.py --repo-root .`) and
      verified (`--check`)
- [x] Final §12 completion summary with proposed commit message; **commit only
      on explicit user approval**