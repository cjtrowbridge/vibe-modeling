# Playbook: Review CAD Changes for Risk and Regression

*Status: Stable*

## Objective

Review OpenSCAD changes for geometry, fit, structure, variant, and artifact
regressions before accepting a revision.

## Review Procedure

1. Read the active plan, baseline config, changed diff, and design README.
2. Read and audit the current complete output build before the approved canonical
   product decomposition and artifact-bound assembly review manifest. Reject
   absent, stale, source-only, or pre-build assembly evidence.
3. Inventory affected modules, parameters, parts, configs, manifests, and derived
   variants. Trace shared helpers to every consumer.
4. Identify changed exterior bounds, cavities, interfaces, fastener envelopes,
   moving envelopes, structural seams, and subtraction neighborhoods.
5. Recalculate pairwise cut ligaments and outer-edge margins; do not rely only on
   assertions touched by the diff.
6. Compare printable-only assembly, subassembly-isolation, representative
   orthographic, isometric, underside, section, and crop
   views against the baseline.
7. Verify product hierarchy, component count, transforms, interface reach,
   unexplained holes, one-sided features, dangling members, and assembly order.
8. Verify print orientation and build-volume bounds for every affected part.
9. Run targeted parts first, then the complete manifest when shared geometry or
   authoritative outputs are affected.
10. Independently measure exported geometry for machine-verifiable assembly and
    interface claims rather than accepting source declarations as proof.
11. Audit final STL connectivity, artifact counts, and provenance.
12. Report findings by severity with file/feature evidence. Separate pre-existing
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
