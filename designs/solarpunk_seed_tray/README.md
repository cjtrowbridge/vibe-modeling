# solarpunk_seed_tray

Per-tray flood-and-drain converter for commodity USB LED seed starters (TPU
flood tray with integrated bell siphon, bottle-base bell cap).

Canonical source of truth for this design and the solarpunk series:
[`docs/solarpunk_series.md`](../../docs/solarpunk_series.md)

Status: parametric scaffold complete with placeholder configs derived from
marketing imagery (Phase 1 measurement pending). The flood tray geometry is
functional and print-ready in principle, but every kit-specific dimension is a
placeholder awaiting physical measurement.

Layout:

- `src/main.scad` — build entry; dispatches `part_id == 1` to the flood tray.
- `src/lib/defaults.scad` — parametric defaults (all values `-D` overridable).
- `src/parts/solarpunk_seed_tray.scad` — the printable flood tray (shell, rim,
  opaque deck + cell openings, standpipe pedestal + bell-seat collar, rear-wall
  drain channel, front-left feed socket, exterior ribs, corner reinforcement).
- `src/mockups/` — reference-only mockups (LED dome, both plug trays, bottle
  bell); NOT part of the build, NOT included by `main.scad`.
- `configs/rev_0001.json` — 12-cell kit instance (placeholder: 172.5×130×70, 3×4).
- `configs/rev_0002.json` — 6-cell kit instance (placeholder: 175×135×55, 3×2).
- `parts.json` / `assembly.json` — authoritative single-part manifest and
  assembly contract (product → tray → tray part).