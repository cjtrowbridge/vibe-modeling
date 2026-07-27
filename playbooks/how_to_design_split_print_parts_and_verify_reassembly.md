# Playbook: Design Split-Print Parts and Verify Reassembly

*Status: Stable*

## Objective

Split oversized geometry into printable parts with unambiguous material ownership,
repeatable alignment, adequate attachment, and verified assembled load paths.

## Procedure

1. Record printer build volume, safety margins, intended orientations, and the
   assembled load paths crossing candidate split planes.
2. Choose a split away from critical openings and thin ligaments when possible.
3. Give each side strict material ownership; avoid overlapping final solids,
   coplanar slivers, or accidental missing layers.
4. Design registration, keys, sleeves, harnesses, fasteners, or adhesive lands
   with separate assembly clearance and structural engagement dimensions.
5. Verify every printable piece independently for bounds, connectivity, minimum
   walls, overhangs, and stable bed contact.
6. Verify the assembled model for alignment, exterior continuity, internal access,
   and full load-path transfer across the interface.
7. Check that registration and fastener cuts do not create sub-minimum ligaments.
8. Export split parts through the manifest or explicitly documented variant
   configs and use coupons for uncertain joints.

## Verification

- Every piece fits the declared build volume in its print transform.
- No material is unintentionally duplicated or omitted at the split.
- Reassembly features have verified fit and structural margins.
- Part identity and artifact completeness are documented and audited.

## Plan Binding

The plan must name split planes, ownership rules, joining method, print transforms,
and assembled verification gates.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
