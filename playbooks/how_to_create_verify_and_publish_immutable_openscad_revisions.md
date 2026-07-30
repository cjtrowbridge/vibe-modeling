# Playbook: Create, Verify, and Publish Immutable OpenSCAD Revisions

*Status: Stable*

## Objective

Develop a revision in mutable staging, verify it, and publish its config and
artifacts exactly once without modifying an existing numbered revision.

## Procedure

1. Inventory committed configs and generated revision directories; select the
   next unused `rev_000N` across both locations.
2. Put the proposed config at `designs/<design>/configs/rev_000N.json`. Do not create
   `revisions/<design>/rev_000N/` yet.
3. Make source and staged-config changes, then build `output/<design>/` while the
   revision remains mutable.
4. Apply structural, fit, print-volume, and manifest verification playbooks.
5. Record expected part names and artifact counts before publication.
6. After all gates pass, run `scad_new_revision.py` with the staged config as
   `--base-config`. Confirm it selects the expected unused number.
7. For manifest designs, rebuild current output once from the newly published
   host config path so its manifest no longer points at the temporary candidate path, then
   require passing audits of both `output/<design>/` and
   `revisions/<design>/rev_000N/`.
8. Compare config, source-tree, parts-manifest, and artifact hashes between the
   verified current build and immutable revision.
9. Commit the new `designs/<design>/configs/rev_000N.json`, source, and revision
   notes. Generated revision artifacts remain ignored.

Never edit or rebuild into an existing numbered revision. If publication is
wrong, preserve the evidence and create the next revision.

## Verification

- The published config equals the approved staged config.
- The revision destination did not exist before publication.
- Required structural and minimum-edge reviews are recorded for the exact config.
- Manifest audits and provenance hashes pass where applicable.

## Plan Binding

The active plan must name the baseline, proposed revision number, publication
gate, expected artifacts, and rollback response before source changes begin.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
