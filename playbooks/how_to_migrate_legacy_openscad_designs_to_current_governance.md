# Playbook: Migrate Legacy OpenSCAD Designs to Current Governance

*Status: Stable*

## Objective

Bring an older design into the current layout, documentation, structural, and
artifact contracts without claiming unperformed verification.

## Procedure

1. Preserve the legacy baseline and inventory source, entrypoints, configs,
   exports, generated artifacts, documentation, and known print history.
2. Map source into `src/main.scad`, `src/lib/`, and `src/parts/` without changing
   geometry unless separately approved.
3. Normalize committed configs to `configs/rev_000N.json`; document any historical
   variant configs that cannot yet be normalized.
4. Identify every printable part. Add `parts.json` when the design has multiple
   authoritative exports.
5. Add a design README covering purpose, part map, configs, dimensions, build
   commands, intentionally separate geometry, and verification status.
6. Add named wall, structural-overlap, and internal-edge parameters and assertions
   only when they truthfully describe the construction.
7. Mark unaudited joins and legacy artifact provenance `unverified`; do not infer
   passage from prior print success.
8. Dry-run all entrypoints, then perform the smallest safe build/audit.
9. Put structural remediation in later revisions rather than silently changing
   geometry during organizational migration.

## Verification

- Layout and documented commands match the repository conventions.
- Multi-part authoritative sets have a manifest.
- Structural status distinguishes passed, failed, and unverified regions.
- No legacy generated artifacts enter the source commit accidentally.

## Plan Binding

Separate organizational migration, structural audit, and geometry repair into
distinct approved checklist groups.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
