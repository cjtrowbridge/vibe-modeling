# Playbook: Build, Install, and Audit Manifest-Driven OpenSCAD Designs

*Status: Stable*

## Objective

Produce an authoritative complete artifact set from `parts.json` through staging,
exact-set validation, atomic installation, and provenance audit.

## Procedure

1. Validate `parts.json`: supported schema, unique numeric `part_id` values,
   unique stable names, and matching `main.scad` dispatch.
   For a new or geometry-modified multipart design, also validate `assembly.json`
   coverage. Do not require or accept an assembly review before the complete
   printable build exists.
2. Confirm the config identifies one `rev_000N` and the intended source state.
3. Dry-run the complete build and review every generated part command.
4. Build with `scripts/scad_build_all.py`; never loop over `scad_build.py`
   manually to represent a complete design.
5. Require managed staging inside `output/<design>/` and exact expected
   printable and assembly artifact names. Remove staging before success.
6. Install only after all parts succeed. Replacement of `output/<design>/` must
   occur as one directory operation, never by overlay copy.
7. Run `--audit-only` against the installed destination.
8. Inspect `build_manifest.json` for config, parts-manifest, source-tree, Git,
   artifact hashes, revision, and expected counts.
9. Review the exact installed STL and PNG artifacts, not source previews or a
   pre-build diagnostic render. A present but blank, clipped, stale, or otherwise
   unusable view fails the artifact review; a replacement render elsewhere does
   not cure that failure.
10. For multipart designs, render and audit the supplementary assembly review
   into the same `output/<design>/` directory only after it is bound to this
   exact build-manifest hash and authoritative STL hashes.
11. For immutable publication, repeat with `--destination revision` only when the
   destination does not already exist.

The printable complete-build manifest and assembly-review manifest have distinct
responsibilities but one artifact destination. The complete printable build is
authoritative and must exist first; the combined assembly STL, assembly views,
and assembly manifest are then added to `output/<design>/`. The final exact-set
audit covers the union declared by both manifests.

## Failure Response

Reject the complete set if any artifact is missing, unexpected, duplicated,
stale, or hash-mismatched. Diagnose in staging and rebuild the entire set.

## Verification

- Expected and actual part, STL, PNG, and total counts agree.
- Both exact-name and hash audits pass.
- Current installation contains no files from an older build.
- The final report states scope, destination, counts, audit, and provenance.
- Multipart completion also states expected/actual assembly-review counts,
  unified output audit result, and matching input hashes.

## Plan Binding

The active plan must identify the manifest/config pair, destination, expected
counts, structural gates, and whether publication is mutable or immutable.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
