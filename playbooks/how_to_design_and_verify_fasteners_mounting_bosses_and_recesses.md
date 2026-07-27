# Playbook: Design and Verify Fasteners, Mounting Bosses, and Recesses

*Status: Stable*

## Objective

Model fastener systems using complete hardware and tool envelopes while preserving
boss attachment, edge margins, neighboring ligaments, and assembly access.

## Procedure

1. Specify fastener standard, nominal/clearance/threaded diameter, head/nut/washer
   envelope, insertion direction, engagement, and installation tool envelope.
2. Model through-holes, counterbores, countersinks, nut traps, and access paths as
   distinct named dimensions.
3. Attach every boss or mounting land with the required positive-volume structural
   overlap; a tangent cylinder is not attached.
4. Assert radial material around holes and shortest margins to exterior edges,
   cavities, seams, and every nearby cut.
5. Evaluate transformed and angled hardware in the correct face plane, not only
   axis-aligned source coordinates.
6. Check head/nut seating depth, breakout risk, driver access, insertion sequence,
   and removable-part clearance.
7. Inspect sections through the narrowest ligament and boss attachment.
8. Use a coupon for threaded inserts, captive nuts, press fits, or uncertain holes.

## Verification

- Full hardware and tool envelopes fit without unintended intersection.
- Boss joins and all residual ligaments meet structural minima.
- Fasteners can actually be inserted, tightened, and removed as intended.
- Hole-fit evidence identifies the print process or remains unverified.

## Plan Binding

The plan must inventory each hardware family, envelope, nearby cuts, and assembly
access before implementation.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
