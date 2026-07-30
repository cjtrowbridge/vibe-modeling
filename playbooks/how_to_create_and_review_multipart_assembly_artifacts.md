# Playbook: Create and Review Multipart Assembly Artifacts

*Status: Stable*

## Objective

Make the assembled product, rather than isolated printable parts, a mandatory and
provenance-bound CAD verification artifact throughout iteration.

## Applicability

This playbook is mandatory for every new or geometry-modified design with more
than one printable part or logical subassembly. Untouched legacy designs follow
the adoption policy in the canonical-product-decomposition playbook.

## Assembly Contract

Create `designs/<design>/assembly.json` using the supported schema. It must
declare:

- the primary product assembly;
- nested logical subassemblies and printable leaves;
- `parts.json` dispatch IDs for every printable leaf;
- assembly transforms and local interface coordinate frames;
- interface ownership and split policies;
- independently classified reference proxies;
- required review views and sections;
- the OpenSCAD assembly-review dispatch.

Each review view carries both a readable `assembly_view` name and a stable
non-negative `assembly_view_id`. Pass the numeric ID to OpenSCAD for dispatch;
do not depend on quoted command-line strings surviving every host shell.

`parts.json` remains authoritative for printable exports. `assembly.json` is
authoritative for product identity, hierarchy, and assembled review.

## Mandatory Artifact-First Order

An assembly review supplements the normal build pipeline; it does not replace
it. At every blockout, detailed-geometry, and release milestone:

1. Build the complete `parts.json` manifest with `scad_build_all.py`.
2. Atomically install and audit `output/<design>/`.
3. Review the exact installed STL and PNG artifacts.
4. Generate the assembly review only after its manifest is bound to the current
   `build_manifest.json` hash and every authoritative installed STL hash.
5. Audit both manifests and then request milestone approval.

A source-only render, dry run, or pre-build assembly made before step 1 is diagnostic
only. It cannot pass a blockout, assembly, approval, or completion gate.

## Required Review Sets

The compact iteration set contains:

- printable-only front, rear, left, right, and isometric views;
- skeleton/chassis-only and removable-module-only views when applicable;
- isolation views for every affected logical subassembly;
- affected seam, receiver, and interface crops or sections.

The full milestone set additionally contains:

- top, bottom, exploded, and all remaining isolation views;
- both sides of every mounting interface;
- sections through seam starts, midpoints, ends, fasteners, openings, and
  structural-support endpoints;
- a separate translucent-proxy set when proxies clarify component fit.

Opaque proxies must never conceal printable geometry in the printable-only set.

## Iteration Procedure

1. Validate `parts.json` and `assembly.json` coverage and hierarchy.
2. Complete and audit the normal manifest build, then review its installed
   artifact set.
3. Render the artifact-bound compact assembly set before detailed work and after
   every affected change.
4. Review with proxies disabled first; review translucent proxies separately.
5. Record findings for component count, transforms, gaps, collisions, truncated
   features, unexplained holes, one-sided features, unsupported or dangling
   members, seam discontinuities, interface reach, symmetry, and assembly order.
6. Measure machine-verifiable claims from the installed STL artifacts independently of
   source declarations.
7. Render and review the full set at blockout, detailed-geometry, and mutable or
   immutable release milestones.
8. Write `output/<design>/assembly_review_manifest.json` with the current complete-build
   manifest hash, authoritative installed STL hashes, exact review artifact names
   and hashes, plus config, parts-manifest, assembly-contract, source-tree, Git,
   and artifact provenance.
9. Audit the manifest and reject missing, unexpected, duplicate, stale, or
   hash-mismatched evidence.

## Invalidation

Assembly approval becomes stale after any change to geometry, transforms,
interfaces, split ownership, source, config, `parts.json`, or `assembly.json`.
Regenerate and re-review the affected compact set before continuing. Milestone
approval requires the complete set.

## Independent Evidence

Do not accept Boolean fields such as `spans_seam: true` as evidence. When
machine-verifiable, derive actual bounds, mounting locations, contact or
engagement, clearances, collision state, and shell connectivity from exported
geometry and assembled transforms. Require construction assertions and exported
evidence to agree.

## Review Result

Record one of `PASS`, `FAIL`, or `BLOCKED_UNKNOWN` for:

- canonical product decomposition;
- printable-leaf coverage;
- transforms and assembly sequence;
- every declared interface;
- gaps and collisions;
- cross-seam continuity;
- structural supports;
- unexplained openings or geometry;
- source and artifact provenance.

Any `FAIL` blocks acceptance. Any required `BLOCKED_UNKNOWN` blocks fabrication
readiness and immutable publication.

## Verification

- The review manifest matches the exact reviewed inputs and files.
- Printable-only views expose all product geometry without proxy obstruction.
- Every logical subassembly is visible and coherent in isolation.
- No finding is dismissed because a render, STL, or build audit passed.
- The agent records findings before declaring the milestone complete.

## Plan Binding

The active plan must name the compact and full view sets, review invalidation
events, interface sections, independent geometry checks, approval gates, and
artifact destination in the same flat `output/<design>/` directory as the
printable artifacts.

## Lifecycle Compliance

Prompt -> Plan -> Blockout -> Complete build/audit -> Review real artifacts ->
Artifact-bound assembly review -> Request approval -> Iterate with compact
reviews -> Full milestone review -> Verify -> Document -> Commit.
