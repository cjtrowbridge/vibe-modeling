---
plan_id: 2026-09-17-16-59-53_solarpunk-seed-tray-parametric-scaffold
title: Solarpunk Seed Tray Parametric Scaffold
summary: Build the fully-parametric solarpunk_seed_tray OpenSCAD source, two placeholder configs (12-cell and 6-cell kits), reference mockups, and manifest/assembly governance so adding a size never requires editing src/.
status: current
created_at: 2026-09-17-16-59-53
---

# Solarpunk Seed Tray Parametric Scaffold

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [x] 1. Parametric OpenSCAD source (`designs/solarpunk_seed_tray/src/`)
  - [x] 1.1 Main entry `src/main.scad` driven entirely by the §5.6 parameter
        surface; no size-derived constant in source (multi-size rule,
        `docs/solarpunk_series.md` §5.6).
  - [x] 1.2 Tray shell: outer walls, floor, corner radii, lid-mating rim
        cross-section, internal insert ledge — all parameter-derived.
  - [x] 1.3 Opaque mask (Option A): closes everything except the cell openings;
        cell grid is a data model (`cell_pitch_x/y`, `cell_opening_width/length`,
        `cell_columns`, `cell_rows`) so 3×4 and 3×2 are config-only variants.
  - [x] 1.4 Standpipe tower with crest = fill/prime level
        (`standpipe_inner_diameter`, `standpipe_height`). Tower is a solid
        pedestal from z=0 to crest (positive floor join) + bell-seat collar.
  - [x] 1.5 Integrated light-blocking drain channel: block run at
        `drain_channel_height` routing to a rear-wall outlet port;
        `drain_inner_diameter` shared by standpipe, channel, and port; asserted
        closed-top (`drain_channel_height + drain_in_r() < deck_bottom()`);
        sealed at both plumbing penetrations.
  - [x] 1.6 Feed socket for the 1/4" fitting (`feed_port_diameter`).
  - [x] 1.7 Reinforcement: vertical ribs (embed into walls via `rib_embed()`
        for positive-volume join), reinforced corners, thickened rim —
        rib count/placement derived from tray size, not hardcoded.
  - [x] 1.8 Structural asserts in source that hold at any size:
        `minimum_wall_thickness` (2.4 mm) and `minimum_structural_overlap`
        (≥ wall) declared and asserted; `drain_inner_diameter` uniform
        standpipe→bend→port; no internal edge/rim/web narrower than
        `minimum_wall_thickness`; bell seat above `maximum_flood_height`.
  - [x] 1.9 `minimum_wall_thickness` and `minimum_structural_overlap` declared
        as named parameters (AGENTS.md §10), asserted at blockout.
- [x] 2. Reference (non-printable) mockups per
      `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md`
  - [x] 2.1 LED dome mockup parameterized per size (lid outer L/W/H, 3.94 in /
        ~100 mm tall for the 12-cell kit; 7.25×5.8×3.9 in for the 6-cell kit).
  - [x] 2.2 12-cell plug-tray mockup (6.79 in × ? × ? — width and height from
        Phase 1 measurement; cell grid matches config).
  - [x] 2.3 6-cell seeding-tray mockup (17.5 × 13.5 × 5.5 mm-scale cm:
        175 × 135 × 55 mm).
  - [x] 2.4 Bottle-base bell mockup with placeholder cut line and notch
        geometry (2 L bottle ~85–90 mm ID baseline), clearly marked
        reference-only.
  - [x] 2.5 Mockups never appear in `parts.json`, `assembly.json`, or the
        manifest; provenance recorded per the mockups playbook.
- [x] 3. Placeholder configs (marketing dimensions; refine after physical
      measurement of the two kits currently in transit)
  - [x] 3.1 `configs/rev_0001.json` — 12-cell (3×4) kit: outer footprint
        6.79 in (172.5 mm) long, lid 3.94 in (100.1 mm) tall, base tray 2.56 in
        (65.0 mm) tall; cell grid 3×4; placeholder values for rim cross-section,
        ledge height, cell pitch/openings, rear-edge clearance, corner radii.
        *Naming delta:* the build tooling requires `configs/rev_000N.json`
        (repo convention, cf. cyberdeck/cyberdeck-2), so the plan's
        `kit_12cell.json` is realized as `rev_0001.json`.
  - [x] 3.2 `configs/rev_0002.json` — 6-cell (3×2) kit: seeding tray
        175 × 135 × 55 mm, cove 185 × 145 × 100 mm, base 185 × 145 × 56 mm;
        cell grid 3×2; same placeholder set as 3.1. *Naming delta:*
        `kit_6cell.json` realized as `rev_0002.json`.
  - [x] 3.3 Both configs use the same structural defaults (TPU 95A opaque,
        walls 2.4–3.2 mm, floor 2–3 mm, 3–5 perimeters) per §5.7.
  - [x] 3.4 Configs marked `status: placeholder — pending Phase 1 physical
        measurement` in a top-level comment field.
- [x] 4. Manifest and assembly governance
  - [x] 4.1 `designs/solarpunk_seed_tray/parts.json` declaring the single
        printable tray part and the reference mockups as non-printable.
  - [x] 4.2 `designs/solarpunk_seed_tray/assembly.json` product contract per
        `templates/assembly_contract.json` (single printable leaf = the tray;
        no subassemblies).
  - [x] 4.3 `scripts/validate_cad_assembly_contract.py` passes for the design.
  - [x] 4.4 `scripts/scad_build_all.py --design solarpunk_seed_tray --config
        configs/rev_0001.json` builds cleanly and installs to
        `output/solarpunk_seed_tray/`.
  - [x] 4.5 `scripts/scad_build_all.py --design solarpunk_seed_tray --config
        configs/rev_0002.json` builds cleanly (demonstrates the parametric
        surface works for both sizes without `src/` edits).
  - [x] 4.6 `scripts/scad_build_all.py --audit-only` passes for each config's
        installed output (exact STL/PNG counts, no unexpected files, no
        `.scad` or directories in the flat output).
  - [x] 4.7 `scripts/scad_render_assembly_review.py` produces a reviewed
        `output/solarpunk_seed_tray/assembly_review_manifest.json` per config,
        recording the current `build_manifest.json` hash and every STL hash.
  - [x] 4.8 Structural-joins verification per
        `playbooks/how_to_design_and_verify_structural_openscad_joins.md`:
        positive-volume intersection at every join (shell/ledge, shell/tower,
        shell/drain-channel, shell/ports), minimum overlap ≥ declared, no
        coplanar-only contacts, no internal feature < `minimum_wall_thickness`.
        All joins realized as positive-volume embeds (deck/ribs/tower into
        shell) with source asserts; render is manifold (Simple: yes).
  - [x] 4.9 Light-blocking verification: the drain channel is asserted
        closed-top (`drain_channel_height + drain_in_r() < deck_bottom()`) and
        the deck spans the full interior with only cell openings, the feed
        socket, and the tower access hole as penetrations; verified by source
        asserts plus installed-render review (iso + bottom views show closed
        shell). Formal section-view geometry was not separately generated;
        the asserts are the load-bearing check.
- [ ] 5. Documentation and journal
  - [x] 5.1 `designs/solarpunk_seed_tray/README.md` updated: status changed
        from "design phase" to "scaffold complete — placeholder configs,
        pending Phase 1 measurement"; links to `docs/solarpunk_series.md`
        (required by AGENTS.md §8).
  - [x] 5.2 `designs/solarpunk_siphon_filter/README.md` unchanged (deferred;
        interface contract in §6 of the series doc is sufficient).
  - [x] 5.3 `docs/solarpunk_series.md` §3 inventory updated to reflect scaffold
        status for `solarpunk_seed_tray` (no change to
        `solarpunk_siphon_filter`).
  - [x] 5.4 `docs/solarpunk_series.md` §5.6 parametric surface annotated with
        the two concrete config instances (rev_0001/rev_0002) and the
        placeholder dimensions they carry.
  - [x] 5.5 Journal entry for today recording the scaffold, both configs, the
        mockups, and the manifest/assembly governance.
  - [x] 5.6 `python scripts/regenerate_plan_indexes.py --repo-root .` run and
        `--check` passes (exit 0).
  - [x] 5.7 `git status -sb` before commit shows only the intended files (the
        unrelated untracked `output/micro_cyberdeck_case/micro-cyberdeck.3mf`
        is deliberately excluded from the commit).
- [ ] 6. Commit (pending explicit user approval)
  - [ ] 6.1 Suggested commit message: "Add parametric solarpunk_seed_tray
        scaffold with placeholder configs for two kits".
  - [ ] 6.2 Request user approval before `git commit`.
  - [ ] 6.3 Push only if user explicitly requests it.

## Out of scope (this plan)

- Physical measurement of the two kits currently in transit (Phase 1 per
  `docs/solarpunk_series.md` §5.11).
- Phase-2 print loop (static tray, lid/insert/leak fit, inlet, siphon tuning)
  per §5.13.
- Any `solarpunk_siphon_filter` geometry (deferred per §6).
- Any `src/` edits that would make a size non-configurable (the multi-size rule
  forbids this by design).

## Verification approach

- Both configs build, audit, and pass the assembly-contract validator without
  touching `src/` between them.
- Structural asserts fire correctly: a deliberately wrong config (wall < 2.4 mm
  or drain ID non-uniform) fails at build time, not at print time.
- Reference mockups are present in the design tree but absent from the manifest,
  `parts.json`, `assembly.json`, and the installed output.
- The light-blocking section views show a closed drain channel and a mask that
  closes everything except the cell openings.
- `git status -sb` after the commit shows a clean tree.
