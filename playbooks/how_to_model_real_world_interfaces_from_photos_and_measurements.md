# Playbook: Model Real-World Interfaces From Photos and Measurements

*Status: Stable*

## Objective

Turn photos, diagrams, and partial measurements into explicit parametric interface
geometry without disguising estimates as measured facts.

## Procedure

1. Inventory sources with origin, view direction, perspective distortion, scale
   references, and confidence.
2. Establish a canonical coordinate system and physical datums that can be found
   on both the object and model.
3. Classify each dimension as measured, manufacturer-specified, derived, visually
   estimated, or provisional.
4. Correct perspective only when enough reference geometry exists; otherwise use
   ranges rather than false precision.
5. Build a simple interface mockup before decorative or downstream geometry.
6. Parameterize uncertain dimensions and keep fit clearance separate from the
   nominal measurement.
7. Check conflicting sources and document which one controls each feature.
8. Create a coupon for the highest-risk mating profile before a large print.
9. Update parameters from physical measurements through a new revision.

## Verification

- Every critical interface dimension has a source and confidence classification.
- Datum and orientation are documented in the design README.
- Estimated dimensions are not described as verified fit.
- A physical coupon or explicit `unverified` status covers uncertain interfaces.

## Plan Binding

The plan must list missing measurements and identify which uncertainties block
full geometry versus which can safely remain configurable.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
