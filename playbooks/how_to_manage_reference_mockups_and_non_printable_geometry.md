# Playbook: Manage Reference Mockups and Non-Printable Geometry

*Status: Stable*

## Objective

Keep hardware proxies, assembly previews, cutters, measurement mockups, and other
non-production geometry clearly separated from authoritative printable exports.

## Classification

- **Printable part:** intended standalone fabrication output; belongs in the
  manifest for a manifest-driven design.
- **Reference mockup:** dimensional context for fit or visualization; export only
  when the user intentionally wants a reference artifact.
- **Assembly preview:** multiple intended parts shown together; not one printable part.
- **Cutter/void:** subtraction tool; never an authoritative positive export unless
  the design itself intentionally produces a positive tool.
- **Probe/debug geometry:** temporary and restricted to `.tmp/scad/<design>/`.

## Procedure

1. Assign each dispatchable `part_id` one classification and document it.
2. Keep printable names stable and ensure the manifest matches the intended
   complete fabrication set.
3. Prevent preview/reference components from being unioned accidentally into
   printable output.
4. Use explicit display/debug flags and color/transparency only for previews;
   final export selection must not depend on preview modifiers.
5. Give dimensionally meaningful mockups source citations and uncertainty notes.
6. Verify each printable STL alone for expected shell count and bounds.

## Verification

- Every export has a documented classification.
- Complete-build counts include exactly the intended authoritative exports.
- Cutters, previews, and probes cannot contaminate production STLs.
- Intentional reference artifacts are labeled as non-printable or reference-only.

## Plan Binding

Any classification or manifest-membership change requires an approved before/after
part map and artifact-count delta.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
