# Playbook: Design and Validate Fit Clearances and Tolerance Stacks

*Status: Stable*

## Objective

Define and verify mating clearances across manufacturing variation, transforms,
assembly motion, and structural constraints.

## Procedure

1. Classify the interface: fixed clearance, slip, sliding, snap, press, fastener,
   removable cover, or captured moving part.
2. Name nominal component dimensions, manufacturing allowances, printer/process
   compensation, assembly clearance, motion clearance, and Boolean epsilon
   separately.
3. Calculate worst-case stacks from real mating surfaces, including rotation,
   taper, chamfers, and transformed hardware envelopes.
4. Assert both minimum clearance and maximum unwanted play where relevant.
5. Verify that adding clearance does not reduce structural edges or join throats
   below their independent minimums.
6. Inspect interface start, midpoint, end, corners, and insertion path.
7. Use a coupon when printer/material calibration controls the result.
8. Record the tested process and measurements; do not generalize one printer's
   calibration to every material/profile.

## Verification

- No epsilon is counted as functional or structural clearance.
- Worst-case interference and looseness are both evaluated.
- Mating and structural contracts pass simultaneously.
- Physical-fit claims identify their printer, material, profile, and evidence.

## Plan Binding

The active plan must identify interface type, target fit, controlling tolerances,
and coupon or inspection gate.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
