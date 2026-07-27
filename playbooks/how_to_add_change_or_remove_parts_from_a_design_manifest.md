# Playbook: Add, Change, or Remove Parts From a Design Manifest

*Status: Stable*

## Objective

Change a manifest-driven design's authoritative printable set without creating
orphan dispatch cases, stale artifacts, or ambiguous part identities.

## Procedure

1. Record the current `parts.json`, dispatch map, complete artifact names, and
   audit result.
2. Classify the change as add, rename, ID change, geometry-only change, or remove.
3. Preserve existing `part_id` and name pairs unless an explicit migration
   requires breaking compatibility. Never recycle a retired ID silently.
4. Update `parts.json`, `main.scad` dispatch, defaults/config dependencies, and
   design documentation in one checkpoint.
5. Decide whether mockups, cutters, and assembly previews are printable exports;
   apply the reference-geometry playbook before listing them.
6. Calculate the new exact STL and PNG counts from the manifest.
7. Dry-run every part, then perform and audit a complete build.
8. Confirm removed or renamed artifacts do not survive atomic installation.
9. Create a new immutable design revision for any exported-set or geometry change.

## Verification

- IDs and names are unique and stable.
- Every manifest entry dispatches one intended export.
- No dispatchable printable part is unintentionally absent from the manifest.
- Complete-build counts and hashes match the changed manifest.

## Plan Binding

The approved plan must show the before/after manifest mapping and expected count
delta before implementation.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
