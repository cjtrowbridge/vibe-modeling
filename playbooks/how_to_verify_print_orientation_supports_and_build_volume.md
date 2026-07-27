# Playbook: Verify Print Orientation, Supports, and Build Volume

*Status: Stable*

## Objective

Verify that each exported part fits the target printer and has an intentional
orientation compatible with strength, support, surface, and assembly needs.

## Procedure

1. Record usable build volume, process/material, nozzle, layer height, and safety
   margins rather than relying only on nominal printer dimensions.
2. Calculate final transformed STL bounds for each candidate orientation.
3. Identify bed-contact area, center of mass, tall/slender instability, bridges,
   unsupported overhangs, trapped support, and inaccessible cavities.
4. Align layer direction with primary loads, fastener forces, snap flex, rails,
   and split-joint behavior.
5. Prioritize critical mating and visible surfaces when selecting support contact.
6. Confirm brim/raft/support structures also fit the usable volume.
7. Review slicer layers at first layers, structural seams, roofs/bridges, holes,
   and the final layers.
8. Split or reorient only through an approved geometry change and reverify all
   resulting parts and assembly interfaces.

## Verification

- Every part plus required adhesion/support margin fits the usable build volume.
- Orientation and support assumptions are recorded per part.
- Layer preview preserves continuous paths through structural joins.
- Risks such as trapped support or weak layer direction are resolved or explicit.

## Plan Binding

The plan must name the target printer/process and per-part orientation gate before
fabrication-readiness claims.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
