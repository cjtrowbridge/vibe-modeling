# Playbook: Create Fit-Test Coupons and Partial Prints

*Status: Stable*

## Objective

Validate high-risk interfaces cheaply using production-derived crops before
committing to a full-duration print.

## Procedure

1. Identify the smallest geometry that preserves the controlling interface,
   surrounding stiffness, print orientation, and relevant support condition.
2. Derive the coupon from production modules and parameters; do not redraw it.
3. Include a short range of candidate clearances only when the variants remain
   unambiguous and printable in the same orientation.
4. Store generated coupon artifacts under `output/<design>/` unless the coupon
   becomes an intentional maintained design part.
5. Label each variant in geometry or a measurement map.
6. Slice and print with the intended material, nozzle, layer height, wall count,
   and orientation.
7. Measure fit, deformation, insertion force, retention, and failure location.
8. Feed the selected value into a new design revision and reverify surrounding
   structural margins.

## Verification

- Coupon geometry matches production datums and interface surfaces.
- Test conditions and measured results are recorded.
- The full design is not declared verified solely from a local coupon.
- No undeclared coupon or staging artifact remains after the governed output is
  accepted; retained coupons are included in its exact set.

## Plan Binding

The plan must state the question each coupon answers and the decision threshold
before printing it.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
