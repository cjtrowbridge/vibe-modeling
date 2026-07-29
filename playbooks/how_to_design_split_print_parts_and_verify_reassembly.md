# Playbook: Design Split-Print Parts and Verify Reassembly

*Status: Stable*

## Objective

Split oversized geometry into printable parts with unambiguous material ownership,
repeatable alignment, adequate attachment, and verified assembled load paths.

## Procedure

1. Record printer build volume, safety margins, intended orientations, and the
   assembled load paths crossing candidate split planes.
2. Choose a split away from critical openings and thin ligaments when possible.
3. Classify every feature approaching or crossing the split as
   `continuous_across_seam`, `left_owned`, `right_owned`, `separate_bridge`, or
   `intentionally_terminated` with a documented reason.
4. Model continuous product features once in assembly coordinates before
   deriving fabrication pieces by intersection with strict ownership volumes.
5. Give each side strict material ownership; avoid overlapping final solids,
   coplanar slivers, or accidental missing layers.
6. Design registration, keys, sleeves, harnesses, fasteners, or adhesive lands
   with separate assembly clearance and structural engagement dimensions.
7. Verify every printable piece independently for bounds, connectivity, minimum
   walls, overhangs, and stable bed contact.
8. Verify the assembled model for alignment, exterior continuity, internal access,
   and full load-path transfer across the interface.
9. Compare recombined split geometry with the unsplit master and investigate
   every difference beyond declared clearance or intentionally removed material.
10. Check that registration and fastener cuts do not create sub-minimum ligaments.
11. Export split parts through the manifest or explicitly documented variant
   configs and use coupons for uncertain joints.

## Verification

- Every piece fits the declared build volume in its print transform.
- No material is unintentionally duplicated or omitted at the split.
- Every cross-seam feature has a declared policy, and recombination matches its
  unsplit master within the documented comparison tolerance.
- Reassembly features have verified fit and structural margins.
- Part identity and artifact completeness are documented and audited.

## Plan Binding

The plan must name split planes, ownership rules, joining method, print transforms,
and assembled verification gates.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
