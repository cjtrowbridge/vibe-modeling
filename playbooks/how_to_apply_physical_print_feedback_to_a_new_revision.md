# Playbook: Apply Physical Print Feedback to a New Revision

*Status: Stable*

## Objective

Convert physical observations into measured, traceable parameter or geometry
changes without overwriting the printed revision.

## Procedure

1. Identify the exact printed revision/config, artifact provenance, printer,
   material, profile, orientation, and any post-processing.
2. Record expected versus actual behavior and measure deviations at defined datums.
3. Separate model error, printer calibration, material behavior, slicing choice,
   assembly technique, and damage hypotheses.
4. Preserve photos and measurements in the design's documented reference location.
5. Prefer named parameter corrections over compensating coordinate edits.
6. Create a staged next revision; never change the config or artifacts that
   produced the physical part.
7. Recalculate tolerance stacks, structural margins, connected consumers, and
   derived part variants.
8. Use a follow-up coupon when uncertainty remains, then complete-build and audit
   the accepted revision.
9. Record what the print validated and what remains unverified.

## Verification

- Feedback is tied to exact source and print conditions.
- The causal hypothesis is supported by measurement or a controlled experiment.
- Corrective geometry receives full regression verification.
- The prior revision remains immutable and reproducible.

## Plan Binding

The corrective plan must include evidence, competing causes, proposed experiment,
new revision, and regression scope before edits.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
