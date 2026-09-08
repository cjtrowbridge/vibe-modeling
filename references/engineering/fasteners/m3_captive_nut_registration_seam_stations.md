# M3 Captive-Nut Registration Seam Stations

## Purpose

This reference defines a reusable seam option for splitting an oversized FDM
model into printable parts: an M3-clamped registration tongue and receiver with
a captive hex nut. It is intended for seams that need repeatable alignment,
shear transfer, recessed hardware, and serviceable reassembly.

The pattern was extracted from `cyberdeck-2`; its stated dimensions are a
starting profile, not a claim of physical validation. Select hardware and
validate a production-derived coupon before treating any profile as fit- or
load-verified.

The governing workflow for selecting a split and verifying the reassembled
product is `playbooks/how_to_design_split_print_parts_and_verify_reassembly.md`.
The structural requirements for the printed members are governed by
`playbooks/how_to_design_and_verify_structural_openscad_joins.md`.

## Name and Intent

Use the name **M3 captive-nut registration seam station**.

Do not call the registration tongue a *stud* unless it is actually a threaded
or cylindrical stud. Its normal job is keyed alignment and shear transfer; the
M3 screw supplies clamp force.

At each station:

- The **tongue part** owns a registration tongue, its root, and an M3 clearance
  passage.
- The **receiver part** owns the mating socket, an M3 clearance passage, the
  head-side circular recess, and the nut-side captive hex pocket.
- The fastener passes through both parts. The screw head seats at the declared
  head side; the nut is inserted into and retained by the declared nut side.

The registration geometry must not be counted as a structural union between
separate printable parts. It is a mechanical interface whose engagement,
fastener clamp path, and material margins must be verified in assembly.

## Applicability

Use this option when all of the following are true:

- The split exists because an assembled feature exceeds usable print-bed volume
  or needs separate fabrication.
- The seam needs more repeatable registration and shear resistance than a plain
  butt seam.
- Both head and nut can be recessed without violating material-width,
  cut-to-cut, and exterior-edge margins.
- The nut can be installed, held captive, and reached with the intended tool
  after adjacent parts are assembled.
- The tongue has a defined insertion path; it does not require forcing two
  interfering solids together.

Do not use it by default where the seam cannot house the full fastener and tool
envelopes, where a continuous hinge/sliding motion is required, or where the
joint load needs analysis beyond ordinary printed-enclosure clamping. Select a
different documented interface or create a design-specific joint contract.

## Required Hardware Declaration

Every design using this station shall declare:

- Exact screw type, nominal diameter, head form, and length.
- Exact nut type, across-flats dimension, thickness, and orientation.
- Screw installation direction: `head_side` and `nut_side`.
- Whether a washer is used, and its outer diameter and thickness.
- Driver type and a swept tool-access envelope, not merely a head recess.
- Material, nozzle, layer height, print orientation, and fit-clearance basis
  for any chosen production dimensions.

Never derive a recess from nominal "M3" alone: head diameters and nut thickness
vary by fastener style and supplier.

## Geometry Contract

The following quantities must be named in source/configuration rather than
embedded as unexplained coordinates:

```text
m3_clearance_diameter
head_recess_diameter
head_recess_depth
nut_across_flats
nut_pocket_circumscribed_diameter
nut_pocket_depth
tongue_insertion_depth
tongue_root_structural_overlap
receiver_closed_end_thickness
socket_side_clearance
socket_tip_clearance
minimum_wall_thickness
minimum_structural_overlap
minimum_internal_edge_width
```

Keep three quantities distinct:

- **Fit clearance** is deliberate space permitting insertion and assembly.
- **Structural engagement** is positive material overlap inside each printed
  part--for example, tongue root into its parent shell. It must meet the
  structural-joins playbook.
- **Boolean epsilon** only stabilizes CSG operations and never counts toward
  fit clearance, material thickness, or structural engagement.

The receiver must leave a single deliberate tongue insertion path and retain a
closed end that prevents over-insertion. Socket side and tip clearances must be
declared separately, since they control different failure modes.

## Starting Profile: M3 Low-Profile Button-Head With Captive Nut

The following values were used as a cyberdeck-2 starting profile. They are
useful for initial sizing only and remain physically unverified until a design
prints and measures its own coupon.

| Parameter | Starting value |
| --- | ---: |
| M3 clearance passage | 3.6 mm |
| Head recess diameter | 8.25 mm |
| Head recess depth | 3.8 mm |
| Nut pocket across flats | 5.9 mm |
| Nut pocket depth | 2.8 mm |
| Tongue insertion depth | 14.0 mm |
| Receiver width | 18.0 mm |
| Tongue root structural overlap | 3.0 mm minimum |
| Receiver closed-end thickness | 3.0 mm minimum |
| Socket side clearance | 1.0 mm |
| Socket tip clearance | 1.0 mm |
| Minimum wall / internal material width | 3.0 mm minimum |

The circumdiameter for a hexagonal nut pocket is derived, not guessed:

```text
nut_pocket_circumscribed_diameter = nut_across_flats / cos(30 degrees)
```

The head recess, nut pocket, screw passage, washer if used, and driver access
each require their own complete envelope review. A circular head recess must be
fully contained in the receiver part; an assembled preview must not hide a
recess that crosses a part boundary.

## Structural and Material Rules

- The tongue root and receiver attachment must each have positive-volume
  structural engagement of at least `minimum_structural_overlap` with their
  respective parent parts after all cuts.
- Every remaining ligament between a fastener cut and an exterior edge, socket
  cavity, other fastener cut, opening, or void must be at least
  `minimum_internal_edge_width` along its shortest path through solid material.
- Inspect the final Boolean result. Nominal pad dimensions are insufficient if
  a recess, chamfer, angled wall, or neighboring cut narrows a local throat.
- State the load path. The tongue normally carries registration/shear while the
  M3 screw clamps; do not assume either feature alone makes a high-load seam
  adequate.
- Inventory every station and its role. Station count and spacing are
  design-specific and must not be copied as a universal pattern.

## Required Verification

Before calling a design using this station fabrication-ready, record:

1. The production source revision/config and complete hardware declaration.
2. Sections normal to the seam through every distinct station type, showing the
   tongue root, receiver walls, head recess, nut pocket, screw passage, and
   remaining material.
3. Head-side, nut-side, and assembly views showing the complete recesses and
   declared installation/tool paths.
4. Pairwise cut-to-cut and cut-to-edge ligament checks after all subtractions.
5. Independent printable-part bounds, connectivity, orientation, and
   reassembled load-path checks through the normal manifest workflow.
6. A production-derived coupon printed in the intended material, orientation,
   nozzle, layer height, and wall count. Measure insertion force, actual
   clearance, nut retention, head seating, driver access, clamp behavior, and
   failure location before selecting final tolerance values.

A render, manifold STL, or successful assembly preview does not validate M3
hardware fit, captive-nut retention, torque resistance, or service access.

## Implementation Outline

Use one shared parameterized module family per design or common library:

```text
registration_tongue(...)
receiver_socket(...)
m3_through_passage(...)
m3_head_recess(...)
m3_captive_hex_nut_pocket(...)
seam_station_coupon(...)
```

Model the master assembly in common coordinates, then assign strict printable
part ownership. Keep structural solids and subtractive hardware geometry
separate until the final Boolean stage so post-cut margins can be asserted and
reviewed.

## Variants

The following are separate options, not silent substitutions:

- **M3 through-nut registration seam station:** same tongue/receiver pattern,
  but no captive nut; requires a defined wrench or nut-retention method.
- **M3 heat-set-insert registration seam station:** requires insert-vendor
  dimensions, thermal installation access, pull-out/torque considerations, and
  an insert-specific boss contract.

Do not treat a heat-set insert, a loose nut, and a captive nut as equivalent
because all accept an M3 screw.
