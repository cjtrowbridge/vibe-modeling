# Playbook: Define and Verify Canonical Product Decomposition

*Status: Stable*

## Objective

Prevent a multipart product from being modeled as the wrong set of components,
even when its dimensions, renders, assertions, and artifacts are internally
consistent.

## Required Hierarchy

Before geometry work, declare three distinct levels when applicable:

1. **Product assembly** — the complete user-facing object.
2. **Logical subassemblies** — independently meaningful, removable, serviceable,
   or interface-bearing components.
3. **Printable leaves** — fabrication artifacts declared in `parts.json`.

A printer constraint may split one logical subassembly into multiple printable
leaves. It must not merge a logical subassembly into an unrelated component or
silently change product ownership.

## Procedure

1. Translate each user-facing component statement into one requirement row.
2. Declare the product assembly and every logical subassembly with stable IDs,
   role, parent, ownership boundary, interfaces, and allowed fabrication split.
3. Declare prohibited decompositions, including components that may not be
   absorbed into a chassis, shell, skeleton, or neighboring module.
4. Map every printable manifest part to exactly one printable leaf beneath one
   logical subassembly.
5. Declare every feature approaching a fabrication split as
   `continuous_across_seam`, `left_owned`, `right_owned`, `separate_bridge`, or
   `intentionally_terminated` with a reason.
6. Create a low-detail, color-distinct blockout of the complete hierarchy before
   adding holes, bosses, retainers, controls, or cosmetic detail. Build and audit
   its complete printable manifest and review those real artifacts before the
   supplementary artifact-bound assembly review.
7. Review product-only, exploded, subassembly-isolation, and printable-leaf
   isolation views. Confirm expected count, role, ownership, transforms, and
   interface reach.
8. Bind approval to the exact source, config, `parts.json`, and `assembly.json`
   hashes. Any affected change invalidates approval.
9. Stop and request approval before changing the logical hierarchy, absorbing a
   component, adding a fabrication split, or changing an interface owner.

## Evidence Rules

- A declaration is a requirement, not proof.
- OpenSCAD assertions may prove construction parameters but not user intent.
- Exported-geometry measurements and reviewed assembly artifacts must confirm
  machine-verifiable spatial claims independently.
- A build manifest proves which files were built; it does not prove the correct
  components were chosen.

## Legacy Adoption

- New multipart designs must comply immediately.
- A geometry- or interface-modified multipart design must comply in that task.
- Untouched legacy multipart designs must be labeled
  `legacy_assembly_unverified` until migrated through an approved plan.
- Do not enable a repository-wide blocking validator without accounting for all
  declared legacy designs.

## Verification

- The declared hierarchy matches the approved user-facing product.
- Every logical subassembly appears independently in isolation views.
- Every printable part maps to exactly one declared leaf.
- No logical subassembly has been silently absorbed into another.
- Assembly approval hashes match the reviewed source and manifests.

## Plan Binding

The active plan must name the hierarchy, prohibited decompositions, split
policies, blockout review, fabrication-decomposition decision, and approval
gates.

## Lifecycle Compliance

Prompt -> Plan -> Declare hierarchy -> Build/audit blockout artifacts -> Review
real artifacts -> Artifact-bound assembly review -> Request approval ->
Implement -> Rebuild/re-review -> Verify -> Document -> Commit.
