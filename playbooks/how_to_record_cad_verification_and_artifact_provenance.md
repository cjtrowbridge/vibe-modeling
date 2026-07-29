# Playbook: Record CAD Verification and Artifact Provenance

*Status: Stable*

## Objective

Create a durable design or revision record that ties verification claims to exact
source, config, manifest, artifacts, measurements, and known limitations.

## Required Record

1. Design, revision, config path, Git commit or working-tree state.
2. Part scope and manifest hash when applicable.
3. Minimum wall thickness, structural overlap, and internal-edge width.
4. Changed join and subtraction-neighborhood inventories.
5. Assertion, section, post-subtraction, connectivity, slicer, fit, and
   build-volume results, each marked passed, failed, unverified, or not applicable.
6. Intentional disconnected geometry and non-printable reference exports.
7. Build destination and expected/actual STL, PNG, and total counts.
8. `build_manifest.json` audit and config/source/artifact provenance results.
9. For multipart designs, canonical hierarchy result, `assembly.json` hash,
   `assembly_review_manifest.json` audit, expected/actual review artifacts,
   agent findings, and exact assembly approval state.
10. Physical coupon or print evidence, including material, printer/profile, and
   measured deviations when used.
11. Residual risks and the exact scope not reviewed.

Record intent/assembly, interface, structural, printability, and artifact results
independently. A passing later category cannot replace a failed or missing
earlier category.

Store design-wide facts in the design README and revision-specific evidence in a
revision note under `designs/<design>/docs/`. Do not put source notes in generated
revision directories.

## Verification

- Every readiness claim names the exact revision/config.
- Evidence is reproducible from documented commands and paths.
- Unverified legacy regions remain explicit.
- Artifact count and provenance statements agree with the manifest audit.

## Plan Binding

The active plan must include this record as a completion deliverable whenever CAD
geometry or authoritative artifacts change.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
