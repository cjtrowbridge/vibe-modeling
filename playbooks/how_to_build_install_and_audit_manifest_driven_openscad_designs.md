# Playbook: Build, Install, and Audit Manifest-Driven OpenSCAD Designs

*Status: Stable*

## Objective

Produce an authoritative complete artifact set from `parts.json` through staging,
exact-set validation, atomic installation, and provenance audit.

## Procedure

1. Validate `parts.json`: supported schema, unique numeric `part_id` values,
   unique stable names, and matching `main.scad` dispatch.
2. Confirm the config identifies one `rev_000N` and the intended source state.
3. Dry-run the complete build and review every generated part command.
4. Build with `scripts/scad_build_all.py`; never loop over `scad_build.py`
   manually to represent a complete design.
5. Require staging under `.tmp/scad/<design>/` and exact expected STL/PNG names.
6. Install only after all parts succeed. Replacement of `output/<design>/` must
   occur as one directory operation, never by overlay copy.
7. Run `--audit-only` against the installed destination.
8. Inspect `build_manifest.json` for config, parts-manifest, source-tree, Git,
   artifact hashes, revision, and expected counts.
9. For immutable publication, repeat with `--destination revision` only when the
   destination does not already exist.

## Failure Response

Reject the complete set if any artifact is missing, unexpected, duplicated,
stale, or hash-mismatched. Diagnose in staging and rebuild the entire set.

## Verification

- Expected and actual part, STL, PNG, and total counts agree.
- Both exact-name and hash audits pass.
- Current installation contains no files from an older build.
- The final report states scope, destination, counts, audit, and provenance.

## Plan Binding

The active plan must identify the manifest/config pair, destination, expected
counts, structural gates, and whether publication is mutable or immutable.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
