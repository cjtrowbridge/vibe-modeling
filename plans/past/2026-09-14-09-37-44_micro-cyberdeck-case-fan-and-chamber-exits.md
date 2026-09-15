---
plan_id: 2026-09-14-09-37-44_micro-cyberdeck-case-fan-and-chamber-exits
title: Add 40 mm Fan, Dual-Window Left Exits, and Retention Lips to Micro Cyberdeck Case
summary: Right-wall 40 mm fan (center y=18, Ø28 air, 4x Ø4.2 mounts, Ø6x3 screw-head recesses on the interior face) and dual left-wall exhaust windows (34 x 24 and 34 x 12 mm, with flush 1.5 mm retention lips enforced by tightened cuts), all in-place on the rev_0003 candidate.
status: past
created_at: 2026-09-14-09-37-44
revised: 2026-09-14 (post-inspection revision R1: flush lips, fan forward, screw-head recesses)
---

# Add 40 mm Fan, Dual-Window Left Exits, and Retention Lips to Micro Cyberdeck Case

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Locked scope and assumptions

- Baseline: in-place amendment of the unpublished mutable `rev_0003` candidate (`configs/rev_0003.json`, `case_body.scad`); `rev_0001`/`rev_0002` configs remain untouched and independently rebuildable.
- Datum unchanged: outer front-left-bottom = [0,0,0]; y=0 front, y=43 back outer face; x width 73; z up; rim z=45; floor top z=3; divider z=15..18, x=0..73, y=3..43.
- Left wall (x=0..3) gains two windows, both spanning y=3..40 (center y=21.5, the wall midpoint; `microsd_center_from_back_outer_edge` retargeted 27 -> 21.5):
  - Top/SBC window (the expanded `microsd` opening): `y=3..40`, `z=18..42` (width 37, height 24, center z=30 = 27 mm above internal floor). Bottom edge flush with the divider top (z=18), asserted.
  - Bottom/battery window: `y=3..40`, `z=3..15` (width 37, height 12, center z=9 = 6 mm above internal floor). Bottom edge at the floor top plane (z=3) and top edge flush with the divider bottom (z=15), both asserted.
  - Resulting left-wall wireframe (all bands solid, all >= 3 mm): front strip y=0..3, back strip y=40..43, bottom band z=0..3 (3 mm, the wall/floor thickness), divider band z=15..18 (3 mm), top band z=42..45 (3 mm). Both windows are expanded to the maximum size allowed by the 3 mm border.
- Right wall (x=70..73) gains one 40 mm fan mount. [REVISED R1] Centered at y=18 (shifted 3.5 mm forward from the wall midpoint 21.5), z=22.5 (wall midpoint in z, derived, asserted):
  - 28 mm circular air opening through the wall (cyberdeck 40 mm standard: `fan_air_opening_d=28`).
  - Four 4.2 mm screw holes at 32 mm spacing on the y/z center axes (screws at y=2 and y=34).
  - [REVISION] Four M3-capable screw-head recesses (d6 x 3 mm, `fan_screw_recess_d`/`fan_screw_recess_depth`) in the internal right-wall face plane (x=70), facing the interior, at the four screw stations so screw heads clear the wall instead of intruding into the SBC/hat chamber.
  - The forward shift buys 9 mm from the back-screw station to the back outer face so the rear head recess keeps >= 3 mm margin to the back wall internal face (asserted, `fan_center_y + 16 + 3 <= 40`).
  - Wall-margin checks (asserted): air opening edges >= 3 mm within the wall footprint; each screw hole >= 3 mm from the back, bottom, and top edges; front screw holes breach the open (unwall-ed) front edge by <= 0.5 mm - a documented cosmetic limit because no wall exists at y<0; corner land assert.
  - Documented relaxations: the 28 mm circle intersects the divider band (z=15..18) within x=70..73, removing the divider's right-end region at y approx 4.7..31.3 (worst case at z=18); the front right leg is a 1.74 mm non-structural sliver (asserted >= 1.5 mm), the back right leg is 11.74 mm (asserted >= 3 mm). Divider left-wall and back-wall support remain continuous and unchanged; the divider still has two verified support families (left wall + back wall).
- [REVISION R1] Retention lips are NOT added geometry: each left-wall window cut is tightened by `lip_width` (1.5 mm) on its leading and trailing edges (front/back y), leaving a 1.5 mm shelf of material flush with the outer left face (x=0). Effective exhaust holes: top 34 x 24 mm, bottom 34 x 12 mm (total 1176 mm sq, still larger than the fan intake area approx 615 mm sq). The top/bottom window edges remain unwired and flush in the divider/floor bands. Envelope stays 73 x 43 x 45 mm; the old `lip_projection` key and `_retention_lip()` ring-union are removed.
- Airflow intent (documented, unverified per airflow/thermal analysis): right-wall 40 mm fan intake; the fan bore cuts a through-channel across the divider's right end (chord 23.7..26.5 mm across the 3 mm band; remaining divider end y=31.3..43, 11.74 mm) mixing flow between chambers; exhaust through both left windows.
- Expected mutable output: one rev_0003 STL and 17 PNGs in `output/micro_cyberdeck_case/` (flat), replacing the current set. No `output/` or `revisions/` files committed.
- Publication gate: candidate only; no immutable revision snapshot, commit, or push without separate approval.

## Approved strategy (user, 2026-09-14)

- "the fan opening can stretch across both chambers. it fits nicely that way."
- "i want to make sure there is a small lip around the new openings on the left side so things don't fall out, but air can still flow easily."
- [REVISED R1, rendered-inspection feedback] "the 'lips' should be flush with the left wall. it's not a new structure; its a constraint on the openings (they need to be a little tighter to prevent things from falling out; this is the correct 'lip')... it also looks like the voids have a zero width fill that renders as crazy. are we including screw head recesses in the inside of the chamber wall so that mounting screws can extend through the fan without blocking the sbc/hat? it looks like the placement of the fan is too far back, so that there wont be enough clearance around the screw holes for the recess and for the head to fit around the hole with the proximity of the back wall."
- R1 resolved by: (a) lips = tighter window cuts, flush, no projection; (b) zero-width-fill artifact removed with the ring-union geometry; (c) d6 x 3 internal head recesses at all four fan screw stations; (d) fan center shifted to y=18 (worst-case 6 mm recess leaves >= 3 mm to the back internal face and >= 3 mm bottom/top ligaments; 7 mm would fail).

## Checklist

- [x] 1. Extend `designs/micro_cyberdeck_case/configs/rev_0003.json`.
  - [x] 1.1 Retarget `microsd_opening_width/height`, `microsd_center_above_internal_floor`, `microsd_center_from_back_outer_edge` to 37 / 24 / 27.0 / 21.5 (top window y=3..40, z=18..42).
  - [x] 1.2 Add `battery_exit_enabled=true`, `battery_exit_width=37`, `battery_exit_height=12`, `battery_exit_center_above_internal_floor=6.0`, `battery_exit_center_from_back_outer_edge=21.5` (bottom window y=3..40, z=3..15).
  - [x] 1.3 Add `fan_enabled=true`, `fan_air_opening_d=28`, `fan_hole_spacing=32`, `fan_mount_hole_d=4.2`.
  - [x] 1.4 Add `lip_enabled=true`, `lip_width=1.5` (R1: `lip_projection` removed; the lip is a constraint on the openings, not added geometry).
- [x] 2. Extend `designs/micro_cyberdeck_case/src/lib/defaults.scad` with is_undef fallbacks for every key (new features disabled by default); R1: `fan_center_y` 18.0, `fan_screw_recess_d` 6.0, `fan_screw_recess_depth` 3.0; `lip_projection` removed.
- [x] 3. Extend `designs/micro_cyberdeck_case/src/parts/case_body.scad`.
  - [x] 3.1 Named functions and asserts for both window bounds (window/divider and window/floor alignment asserted).
  - [x] 3.2 Left-wall wireframe band asserts (front, back, bottom, divider, top) at `minimum_internal_edge_width`.
  - [x] 3.3 Right-wall fan cut: 28 mm circle + four 4.2 mm holes at 32 mm spacing (R1: center y=18 via `fan_center_y` config); wall-margin asserts vs back/bottom/top edges, document front-edge cosmetic limit.
  - [x] 3.4 Named divider right-end leg functions (R1: front leg asserted >= 1.5 mm documented relaxation, back leg >= 3 mm); left/back support asserts unchanged.
  - [x] 3.5 Retention lips: R1 removed the external ring-union and replaced it with tightened window cuts (1.5 mm shelf flush with x=0); ring-extent asserts superseded by the tightening asserts (`2*lip_width` < window dimensions). Zero-width-fill render artifact removed with the degenerate ring geometry.
  - [x] 3.6 Window cuts (top + bottom) and fan cut (air + mount holes + R1 head recesses: 4 x d6 x 3 internal-face cylinders at the screw stations) applied in the shared difference; recess margin asserts (>= 3 mm to back internal face and bottom/top ligaments, recess-to-air-opening land).
- [x] 4. Build and verify installed artifacts.
  - [x] 4.1 Rebuild with `python scripts/scad_build.py --design micro_cyberdeck_case --config designs/micro_cyberdeck_case/configs/rev_0003.json`; all asserts pass; STL simple.
  - [x] 4.2 Numerical verification on the installed STL: bounds 73 x 43 x 45, signed volume vs hand calculation (case volume minus windows/fan/recesses; lips cost no material outside the window envelope), cross-section sampling of window/fan/recess patterns; export report recorded as-is (known accepted Volumes:2 quirk, not chased).
  - [x] 4.3 Section renders (temporary probes under `output/micro_cyberdeck_case/`, deleted before success): left face (windows + flush lip shelves + divider band), internal right-wall face (fan + four head recesses), divider plan (notch + right-end channel).
  - [x] 4.4 Confirm final `output/micro_cyberdeck_case/` is flat: exactly 1 STL + 17 PNGs, no directories, no `.scad`; remove the 4 stale probe artifacts from the pre-revision build.
- [x] 5. Update documentation.
  - [x] 5.1 Design README rev_0003 section: final left/right opening geometry, fan spec (y=18), recess spec, flush-lip spec, divider channel, documented relaxations, thermal-unverified disclaimer, verification record with fresh SHA-256 of config, defaults, case body, installed STL; build command.
  - [x] 5.2 Root README: envelope stays 73 x 43 x 45 mm (R1 removed the lip projection); fan/exhaust note with dual left windows + right-wall fan and head recesses.
  - [x] 5.3 Append today's journal work-log entries (agent-managed fields only).
- [x] 6. Close the governed checkpoint.
  - [x] 6.1 Mark completed checklist items, evaluate `[?]` items, mark the prior `2026-09-13-12-09-39` plan's remaining verification and docs items `[-]` (superseded by this plan's 4.x/5.x, which document the final state), and archive both plans to `plans/past/` when no execution remains.
  - [x] 6.2 Regenerate and check plan indexes (`python scripts/regenerate_plan_indexes.py --repo-root .`, then `--check`).
  - [x] 6.3 Report results per AGENTS.md section 12 and propose a task-scoped commit message; no commit or push without explicit approval.