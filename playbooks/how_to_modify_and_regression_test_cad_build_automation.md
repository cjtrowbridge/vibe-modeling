# Playbook: Modify and Regression-Test CAD Build Automation

*Status: Stable*

## Objective

Change CAD build/revision scripts without weakening path safety, artifact
completeness, immutability, provenance, or cross-platform behavior.

## Procedure

1. Record current CLI help, supported destinations, expected views, manifest
   schema, and representative dry-run/audit results.
2. Map the change across `scad_build.py`, `scad_build_all.py`,
   `scad_new_revision.py`, wrappers, README examples, and calling playbooks.
3. Preserve explicit executable/input/output logging and non-zero failure exits.
4. Keep all generated paths within `output/<design>/`,
   `revisions/<design>/rev_000N/`, or `.tmp/scad/<design>/`.
5. Preserve staging-before-install, exact-set rejection, atomic replacement,
   immutable revision refusal, and provenance hashing.
6. Test paths containing spaces and both explicit OpenSCAD paths and PATH lookup.
7. Exercise single-part dry-run, complete manifest dry-run, passing audit, and
   deliberately failing missing/unexpected/hash-mismatch cases.
8. Verify wrapper arguments and help text remain synchronized.
9. Update documentation and any artifact-schema compatibility notes.

## Verification

- Python scripts parse and each `--help` command succeeds.
- Representative safe paths pass and boundary violations fail closed.
- Complete builds cannot install partial or stale sets.
- Existing manifests remain readable or have an explicit migration path.

## Plan Binding

The plan must enumerate affected CLI contracts, fixtures/designs, failure cases,
and rollback behavior before implementation.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
