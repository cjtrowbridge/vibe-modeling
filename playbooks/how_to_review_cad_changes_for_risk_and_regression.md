# Playbook: Review CAD Changes for Risk and Regression

*Status: Stable*

## Objective

Review OpenSCAD changes for geometry, fit, structure, variant, and artifact
regressions before accepting a revision.

## Review Procedure

1. Read the active plan, baseline config, changed diff, and design README.
2. Inventory affected modules, parameters, parts, configs, manifests, and derived
   variants. Trace shared helpers to every consumer.
3. Identify changed exterior bounds, cavities, interfaces, fastener envelopes,
   moving envelopes, structural seams, and subtraction neighborhoods.
4. Recalculate pairwise cut ligaments and outer-edge margins; do not rely only on
   assertions touched by the diff.
5. Compare representative orthographic, isometric, underside, section, and crop
   views against the baseline.
6. Verify print orientation and build-volume bounds for every affected part.
7. Run targeted parts first, then the complete manifest when shared geometry or
   authoritative outputs are affected.
8. Audit final STL connectivity, artifact counts, and provenance.
9. Report findings by severity with file/feature evidence. Separate pre-existing
   unverified geometry from regressions introduced by the change.

## Verification

- Every changed source/config has a mapped downstream consumer set.
- Structural, fit, printability, and artifact results are stated independently.
- No finding is dismissed solely because rendering or manifold checks passed.

## Plan Binding

Review may be read-only, but proposed fixes require approved plan items. Do not
silently repair unrelated findings during review.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
