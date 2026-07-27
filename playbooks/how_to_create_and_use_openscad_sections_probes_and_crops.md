# Playbook: Create and Use OpenSCAD Sections, Probes, and Crops

*Status: Stable*

## Objective

Create reproducible temporary views and partial exports that expose hidden joins,
clearances, shell connectivity, and high-risk print regions.

## Procedure

1. State the question, exact source/config, coordinate frame, and target feature.
2. Place all temporary `.scad`, configs, images, and STLs under
   `.tmp/scad/<design>/`; never use `output/` or `revisions/`.
3. Derive probes from production modules and parameters rather than duplicating
   geometry or substituting guessed dimensions.
4. For a seam, inspect normal sections at the start, midpoint, end, corners, and
   nearby subtractions.
5. For fit, crop both mating envelopes in assembled coordinates and include the
   required clearance volume.
6. For shell checks, export each intended printable part alone and identify all
   positive-volume connected components.
7. Label view direction, section plane, crop bounds, and measured result.
8. Treat probe success as evidence only for the region and configuration tested.
9. Keep useful commands in revision notes; leave generated probe artifacts ignored.

## Verification

- Probe paths comply with artifact governance.
- Production geometry and config are the source of truth.
- Required section locations are covered and documented.
- Conclusions do not exceed the probe's spatial or configuration scope.

## Plan Binding

The active geometry-change plan should list required probes and their acceptance
criteria before final complete builds.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
