---
plan_id: 2026-09-18-07-21-14_solarpunk-seed-tray-bell-bumpout
title: Solarpunk Seed Tray — Bell Bump-Out
summary: Move the siphon out of the tray footprint into a side bump-out sized for an ~8 cm bottle, with a center siphon exit, 8 support spines (~5 mm), and a drain outlet on the bump-out outer face; 12-cell (rev_0001) is the primary reference.
status: current
created_at: 2026-09-18-07-21-14
---

# Solarpunk Seed Tray — Bell Bump-Out

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Why this change

The committed scaffold (`rev_0001`/`rev_0002`) rises the standpipe tower from the
floor **inside** the tray footprint (`tower_center` ≈ (110,95) for the 12-cell) —
exactly where the commodity plug tray sits. The bell/siphon must instead be a
**bump-out** on the tray structure that does not intersect or interfere with the
tray, so trays can tessellate on the shelf. The bell is a ~8 cm (soda-bottle)
base; the bump-out must clear it with room to spare, keep the siphon exit in the
center, and add spines on the bottom of the bump-out so the bottle sits flat
without cutting off flow (the spines also set the siphon-break cutoff as low as
possible without restricting flow).

## Confirmed design decisions (from user)

- **Location:** bump-out on a **long side**, toward **one end**; trays tessellate
  on the shelf. Default end = **left (−x)** (exposed as a tunable parameter).
- **Bell bore:** **~90 mm ID** (8 cm bottle + clearance), **siphon exit in the
  center**.
- **Spines:** **8 radial spines, ~5 mm tall**, extending out from the riser so
  the bottle sits flat, flow stays open, and the cutoff level is set as low as
  possible without restricting flow.
- **Drain outlet:** on the **outer face** of the bump-out.
- **Primary reference:** **12-cell (rev_0001)**; the 6-cell (rev_0002) follows
  the same parameterization.

## Open / blockout decisions (resolve during implementation, document in
## `docs/solarpunk_series.md`)

- Exact bump-out center offset along the long side (x position from the left
  end) — must leave the plug-tray footprint and adjacent-cell zone clear.
- How far the bump-out projects beyond the long-side wall (bell radius + seat
  wall + margin) and the resulting **tessellation pitch** (required shelf
  spacing). Record the required spacing.
- Spine radial extent and exact height (5 mm stated; confirm the siphon-break
  level it sets at blockout).
- Whether the bell seat is a printed annular well or a friction collar; both are
  expressible from the parameter surface.

## Workstreams

- [ ] 1. Parametric source change (design-topology; `src/` only)
  - [ ] 1.1 `src/lib/defaults.scad`: remove reliance on the interior
        `tower_center_x/y` for the siphon; add the bump-out parameter surface —
        `bumpout_side` (long side, front/−y), `bumpout_end` (left/−x default),
        `bumpout_center_x/y`, `bell_bore_diameter` (~90), `bell_seat_wall`
        (≥ min), `bell_seat_height`, `siphon_exit_diameter` (= riser bore),
        `spine_count` (8), `spine_height` (~5), `spine_width`, `spine_root_r`,
        `drain_port_diameter`, bump-out projection, with `is_undef` fallbacks
        (12-cell placeholder). All size-derived values stay config-overridable
        (multi-size rule, §5.6).
  - [ ] 1.2 `src/parts/solarpunk_seed_tray.scad`: remove the interior `tower()`
        pedestal (it currently occupies the plug-tray zone). Add the bump-out:
        a collar/well projecting beyond the long-side wall toward the left end,
        with the ~90 mm bell bore (axis per the bell orientation) and the siphon
        riser/exits in the center.
  - [ ] 1.3 Add the 8 spines on the bottom of the bump-out extending out from
        the riser; the center (riser exit) stays open for flow. Spine count and
        placement are parameters, never hardcoded.
  - [ ] 1.4 Route the riser from the flood chamber up through the bump-out and
        expose the siphon exit in the center of the bell bore.
  - [ ] 1.5 Drain outlet on the **outer face** of the bump-out (was rear-wall
        port). Keep `drain_inner_diameter` uniform riser→bend→port; keep the
        drain light-blocking (closed top).
  - [ ] 1.6 Structural asserts (AGENTS.md §10) at any size: `bell_seat_wall`
        ≥ `minimum_wall_thickness`; spine width/extent ≥ min internal edge;
        bump-out positive-volume join into the shell wall (embed, not coplanar);
        siphon exit open at the center; drain-ID uniformity; no internal feature
        < `minimum_wall_thickness`; bump-out does not intersect the plug-tray
        footprint or the cell openings.
  - [ ] 1.7 Tessellation: assert/derive the bump-out projection + bell footprint
        and record the required shelf pitch (the bump-out must not collide with
        an adjacent tray at the tessellation pitch).
- [ ] 2. Mockups (reference-only, per the mockups playbook)
  - [ ] 2.1 Update `src/mockups/bottle_bell.scad` to the ~8 cm bottle base and
        the new bump-out seat position (reference-only, never in the build).
  - [ ] 2.2 Update the plug-tray mockups if the bump-out changes the required
        plug-tray footprint/clearance (record the new clearance).
- [ ] 3. Configs (new revision instances; do NOT amend the immutable
      `rev_0001`/`rev_0002`)
  - [ ] 3.1 New 12-cell bump-out config (primary) carrying the new parameters;
        keep `status: placeholder — pending Phase 1 physical measurement`.
  - [ ] 3.2 New 6-cell bump-out config carrying the same parameters at the 6-cell
        size (bell bore, spines, drain on the outer face; tessellation pitch for
        this size).
  - [ ] 3.3 Both configs keep the same structural defaults per §5.7.
- [ ] 4. Manifest and assembly governance
  - [ ] 4.1 Update `designs/solarpunk_seed_tray/assembly.json` interfaces to the
        bump-out siphon exit, bell seat, and outer-face drain port (product →
        tray → tray part; review_dispatch_id 90 unchanged).
  - [ ] 4.2 `scripts/validate_cad_assembly_contract.py` passes.
  - [ ] 4.3 Build the new 12-cell config; `--audit-only` passes (exact STL/PNG
        counts, flat output, no `.scad`/dirs).
  - [ ] 4.4 Build the new 6-cell config (proves the parameter surface at both
        sizes without `src/` edits); `--audit-only` passes.
  - [ ] 4.5 `scad_render_assembly_review.py --set full` installs a
        provenance-bound `assembly_review_manifest.json` for the installed state.
  - [ ] 4.6 Structural-joins verification per the structural-joins playbook:
        positive-volume bump-out/wall join, spine/riser/bell-seat joins,
        min-overlap holds, no coplanar-only contacts, no feature < min.
  - [ ] 4.7 Light-blocking + flow verification: section/section-check confirms
        the drain is closed-top, the siphon exit is open at the center, the
        spines leave the flow path open, and the bump-out does not block the
        cell openings (AGENTS.md §10, §5.3, §5.13 light-leak test).
- [ ] 5. Documentation and journal
  - [ ] 5.1 `designs/solarpunk_seed_tray/README.md`: describe the bump-out
        architecture (side bump-out, ~90 mm bell bore, center exit, 8 spines,
        outer-face drain), and keep the `docs/solarpunk_series.md` link.
  - [ ] 5.2 `docs/solarpunk_series.md`: rewrite §5.3 item 3 (standpipe tower)
        and item 4 (bell seat) to the bump-out architecture; update §5.4
        (bottle-base bell) for the ~8 cm bottle + spines + cutoff level; add the
        bump-out + spine + tessellation parameters to the §5.6 parametric
        surface and the concrete config-instance table (new 12-cell / 6-cell
        bump-out configs); note the tessellation pitch.
  - [ ] 5.3 Journal entry for today recording the bump-out change, both configs,
        the spine/bell-seat decisions, and the tessellation pitch.
  - [ ] 5.4 `python scripts/regenerate_plan_indexes.py --repo-root .` and
        `--check` passes.
  - [ ] 5.5 `git status -sb` before commit shows only the intended files.
- [ ] 6. Commit (pending explicit user approval)
  - [ ] 6.1 Suggested message: "Move solarpunk_seed_tray siphon to a side
        bell-bump-out with spines and outer-face drain".
  - [ ] 6.2 Request user approval before `git commit`.
  - [ ] 6.3 Push only if the user explicitly requests it.

## Out of scope (this plan)

- Physical measurement of the two kits in transit (Phase 1).
- The `solarpunk_siphon_filter` geometry (deferred).
- Any change that would make a size non-configurable (the multi-size rule).

## Verification approach

- Both new configs build, audit, and pass the assembly-contract validator
  without touching `src/` between them.
- Structural asserts fire at build time (bell-seat wall, spine width, drain-ID
  uniformity, min feature width, bump-out/tray non-intersection).
- The bump-out + bell footprint and required tessellation pitch are recorded.
- Section/flow check confirms the center siphon exit is open, the drain is
  closed-top, the spines leave the flow path open, and the cell openings are
  unblocked.
- The installed render shows the bump-out on the long side toward the left end,
  the ~90 mm bell seat, the 8 spines, and the outer-face drain port.
