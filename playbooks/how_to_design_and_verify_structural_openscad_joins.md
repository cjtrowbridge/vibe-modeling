# Playbook: How to Design and Verify Structural OpenSCAD Joins

*Status: Stable*

## Objective

Prevent printable models from containing walls, rails, lips, rims, bosses, webs, or other intended structural elements that appear connected but lack sufficient positive-volume overlap.

## Mandatory Definitions

Every structural design must define:

```scad
minimum_wall_thickness = 3;
minimum_structural_overlap = minimum_wall_thickness;
minimum_internal_edge_width = minimum_wall_thickness;

assert(
    minimum_structural_overlap >= minimum_wall_thickness,
    "Structural overlap must be at least the minimum wall thickness."
);
assert(
    minimum_internal_edge_width >= minimum_wall_thickness,
    "Internal edges and material strips must be at least the minimum wall thickness."
);
```

The values may be larger when loads, print orientation, material, fasteners, or impact resistance require it. They must not be reduced merely to make geometry fit.

For a design with a `3 mm` minimum wall thickness, every intended structural join must therefore have at least `3 mm` of deliberate structural engagement.

Structural engagement depth is measured from the receiving member's near joining face toward its far face, normal to those faces. A terminating member joined to a `3 mm` receiving wall must therefore engage through the wall's full `3 mm` thickness. If the required overlap is greater than the receiving member's local thickness, thicken the receiving member at the join.

## Minimum Internal Edge Contract

No internal edge in the printed solid may be narrower than `minimum_wall_thickness`. This applies independently of whether the feature participates in a join.

In this contract, "edge width" means the width of the solid material ligament bordering a void, opening, recess, or neighboring feature. It does not mean the mathematical line where two faces meet.

An internal edge includes:

- Rims and lips around openings
- Lid-support rails and ledges
- Flanges and mounting lands
- Webs, ribs, and bridges
- Boss attachments and material surrounding fastener holes
- Material between a void and an exterior boundary
- Material between adjacent voids, recesses, slots, or holes
- Residual material left by chamfers, fillets, countersinks, counterbores, and other subtractions

Measure the edge width as the shortest path through solid material between the relevant boundaries in a cross-section normal to the feature. The minimum measured width at every point must satisfy:

```scad
assert(actual_internal_edge_width >= minimum_internal_edge_width);
assert(void_to_outer_edge_margin >= minimum_internal_edge_width);
assert(void_to_void_material_width >= minimum_internal_edge_width);
assert(fastener_hole_edge_margin >= minimum_internal_edge_width);
assert(post_cut_internal_edge_width >= minimum_internal_edge_width);
```

Nominal dimensions are insufficient if an angled intersection, nearby cutout, countersink, or later `difference()` creates a thinner local section. Review the final Boolean result, including the ends and corners of each feature.

## Structural Join Contract

An intended structural join is valid only when all of the following are true:

1. The joined solids have a positive-volume intersection.
2. Each terminating structural member penetrates or engages the joined material by at least `minimum_structural_overlap`.
3. The receiving member is locally at least `minimum_structural_overlap` thick at the join.
4. The overlap continues across the full intended seam, including its start and end.
5. The minimum remaining load path or throat is at least `minimum_wall_thickness`.
6. The required overlap remains present after every `difference()` and other downstream Boolean operation.
7. The final exported part contains the intended members in the same connected positive-volume material shell.

The following do not satisfy the contract:

- Objects that merely appear close in preview
- Shared points or edges
- Coplanar or coincident faces
- Tangent contact
- Zero-clearance placement
- Numerical epsilon overlaps such as `0.01 mm`, `0.05 mm`, or other render-workaround values
- A narrow bridge below `minimum_wall_thickness`
- An overlap that exists only along part of the intended seam
- An overlap that is later removed by a subtraction

Fit clearance, Boolean-rendering epsilon, and structural overlap are different quantities. Never count fit tolerance or rendering epsilon toward structural engagement.

## Required Side Profile

Inspect a cross-section normal to the seam. Two joined members must form one continuous filled region:

- The outer contour is continuous.
- The inner contour is continuous unless an intentional cavity is documented.
- There is no visible or mathematical gap between members.
- There is no point-only, edge-only, or face-only contact.
- The intersection contains at least `minimum_structural_overlap` of engagement.
- No neck in the load path is thinner than `minimum_wall_thickness`.

For two `3 mm` walls meeting at `45 degrees`, the side profile must not show two finished wall endpoints touching at the theoretical corner. The members must extend through the nominal meeting location and be unioned so the corner contains a continuous filled overlap with at least `3 mm` engagement. A miter that only shares a line or face is not compliant.

When two finite wall centerlines cross at angle `joint_angle`, a conservative symmetric construction can calculate the required centerline overrun for each terminating wall:

```scad
function required_join_overrun(
    other_wall_thickness,
    structural_overlap,
    joint_angle
) =
    (structural_overlap - other_wall_thickness / 2)
    / sin(joint_angle);

wall_thickness = 3;
joint_angle = 45;
join_overlap = 3;
boolean_overlap_epsilon = 0.01;

required_overrun = required_join_overrun(
    wall_thickness,
    join_overlap,
    joint_angle
); // approximately 2.121 mm

assert(join_overlap >= minimum_structural_overlap);
assert(wall_thickness >= join_overlap);
assert(actual_overrun >= required_overrun + boolean_overlap_epsilon);
```

This formula measures from the theoretical centerline intersection to the terminating endpoint. Engagement is measured normal to the receiving wall, beginning at its near face. With two `3 mm` walls and a required `3 mm` overlap, the terminating wall reaches through the receiving wall's full thickness. The separate epsilon carries it just beyond the far face for reliable Boolean union but does not count toward the required `3 mm`. A continuous member that passes through a T-junction does not terminate at the join; the terminating member must still penetrate it by the required overlap.

For complex corners, it is often safer to construct one continuous side-profile polygon and extrude it along the seam. If separate solids are used, intentionally overrun them, union them, and trim only the exterior contour afterward.

## Required Parameter Assertions

OpenSCAD cannot directly assert arbitrary intersection volume or inspect an exported STL's shell topology. Assertions must therefore guard the dimensions used to construct the geometry:

```scad
assert(wall_thickness >= minimum_wall_thickness);
assert(join_overlap >= minimum_structural_overlap);
assert(receiving_thickness_at_join >= join_overlap);
assert(join_seam_length >= required_seam_length);
assert(minimum_join_throat >= minimum_wall_thickness);
assert(post_cut_join_overlap >= minimum_structural_overlap);
assert(minimum_internal_edge_width >= minimum_wall_thickness);
assert(post_cut_internal_edge_width >= minimum_internal_edge_width);
```

Use explicit names such as:

- `wall_floor_overlap`
- `rail_wall_overlap`
- `boss_panel_overlap`
- `angled_wall_overrun`
- `post_cut_join_overlap`

Do not encode structural attachment as unexplained coordinate coincidences or magic epsilon values.

## Design Procedure

1. Inventory every intended structural interface.
   - Include floors, walls, roofs, angled faces, rails, lips, rims, bosses, webs, mounting pads, trays, and reinforcement features.
2. Classify each interface.
   - Continuous profile
   - T-junction
   - Angled junction
   - Lap joint
   - Boss or pad attachment
   - Rail or rim attachment
3. Assign a named overlap dimension to every interface.
4. Assert that each overlap is at least `minimum_structural_overlap`.
5. Construct positive-volume overlap across the complete seam.
6. Apply holes, recesses, and other subtractions.
7. Recalculate or assert the remaining overlap and throat after subtraction.
8. For each structural member containing multiple holes, recesses, slots, or voids, create a pairwise subtraction-clearance inventory. For every pair whose projected bounds can overlap or approach in that member, assert the shortest remaining ligament after all transforms and Boolean cuts. A cut-to-outer-edge assertion does not replace cut-to-cut assertions.
9. Inventory all internal edges and assert their narrowest remaining material width.
10. Inspect sections through each seam and internal edge at its start, midpoint, end, corner, and any nearby cutout.
11. Export the final STL and check for unexpected disconnected positive-volume shells.

## Verification Gates

A structural change is not complete until all gates pass:

1. **Parameter gate**
   - All wall, overlap, throat, and seam assertions pass.
2. **Section gate**
   - Side sections demonstrate continuous filled overlap at the seam start, midpoint, and end.
3. **Post-subtraction gate**
   - Holes, recesses, voids, and clearances have not reduced the join below its required overlap or thickness.
4. **Minimum-edge gate**
   - Every internal edge and material strip is at least `minimum_wall_thickness` wide at its narrowest point after all Boolean operations.
5. **Connectivity gate**
   - The exported part has no unexpected disconnected positive-volume shells.
6. **Slicer gate**
   - Layer preview shows continuous extrusion paths through each join in the intended print orientation.
7. **Documentation gate**
   - The design README records `minimum_wall_thickness`, `minimum_structural_overlap`, `minimum_internal_edge_width`, and any intentionally separate geometry.

OpenSCAD rendering success, `Simple: yes`, manifoldness, and slicer acceptance are necessary but insufficient. They do not prove the required overlap depth or load-path thickness.

## Fabrication Readiness

A design is structurally unverified until the verification gates are recorded for the exact source revision and config used to generate the STL. A later geometry or parameter change invalidates the affected join checks.

Do not describe a design as print-ready or fabrication-ready based only on:

- A successful OpenSCAD render
- `Simple: yes`
- A manifold STL
- A visually correct preview
- Slicer acceptance

For expensive, long-duration, or difficult-to-replace prints, also use one or more risk-reduction artifacts before the full print:

- A cropped test piece containing the highest-risk joins
- A full-scale joint coupon
- A partial-height slice that exposes rails, rims, or wall intersections
- A low-cost draft print in the final print orientation

Create these through `playbooks/how_to_create_fit_test_coupons_and_partial_prints.md`
and keep temporary source/artifacts under `.tmp/scad/<design>/`.

Record structural verification in the design README or revision notes:

```text
Structural verification record
- Source revision/config:
- Minimum wall thickness:
- Minimum structural overlap:
- Minimum internal edge width:
- Join inventory reviewed:
- Internal edge/material-strip inventory reviewed:
- Section locations reviewed:
- Post-subtraction checks:
- Unexpected positive-volume shells:
- Slicer layer-path review:
- Intentional disconnected geometry:
- Test coupon or draft print:
- Result: unverified | failed | passed
```

## Mandatory Post-Change Summary

After any repository change, the final summary must include:

```text
Structural review
- Source revision/config: <value or not applicable>
- Structural joins: passed | failed | unverified | not applicable
- Minimum internal edge/material width: passed | failed | unverified | not applicable
- Evidence: <assertions, sections, shell audit, slicer review, or reason incomplete>
```

For changes that do not alter CAD geometry, both checks are `not applicable`. For CAD changes, `unverified` or `failed` must be stated plainly and the design must not be described as print-ready or fabrication-ready.

## Exceptions

The following may remain separate only when explicitly documented:

- Separate printable parts
- Removable lids, trays, inserts, and mating hardware
- Decorative text or markers intentionally printed separately
- Fit interfaces that require clearance

An exception must identify the separate part and explain why structural union is not intended. Undocumented disconnected geometry is a verification failure.

## Failure Response

If a structural join fails:

1. Stop editing and preserve the failing revision.
2. Follow `playbooks/debugging_changes_that_lead_to_errors.md`.
3. Audit the source construction dimensions and final STL connectivity.
4. Identify whether the failure is zero-volume contact, insufficient overlap, a narrowed throat, partial seam coverage, or subtraction damage.
5. Propose a repair and regression verification plan before changing geometry.

## Verification

- Every design declares its minimum wall thickness and structural overlap.
- Every intended structural join has a named, asserted overlap.
- Every internal edge and material strip has a named or derived minimum-width check.
- Section views show continuous positive-volume material for the full seam.
- Section views show no internal edge narrower than `minimum_wall_thickness`.
- The final STL contains no unexpected disconnected positive-volume shells.
- Slicer layer preview shows continuous extrusion through the joins.
- The post-change summary records both required review results.

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification
