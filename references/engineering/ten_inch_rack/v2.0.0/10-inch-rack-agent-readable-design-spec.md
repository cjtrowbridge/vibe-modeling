---
doc_id: ten-inch-rack-m3-printed-design-spec
title: Agent-Readable Design Specification for 3D-Printed 10-Inch Racks
version: 2.0.0
status: design-baseline
supersedes:
  - 10-Inch Rack M3 Mounting Design Guide for 3D-Printed Structures
primary_audience:
  - CAD agents
  - OpenSCAD implementation agents
  - mechanical-design reviewers
  - human fabricators
units: millimetres
coordinate_system:
  x: left-to-right
  y: front-to-rear
  z: bottom-to-top
fastener_constraint: M3x0.5 screws with ISO 7089 M3 flat washers at every primary mounting interface
rack_depth_status: project-defined; no universal depth is assumed
---

# Agent-Readable Design Specification for 3D-Printed 10-Inch Racks

## 0. Document contract

### 0.1 Purpose

This document defines a reusable mechanical design baseline for a mostly 3D-printed, de facto 10-inch rack system whose user-facing mounting hardware is restricted to **M3×0.5 machine screws with ISO 7089 M3 flat washers**.

It expands the earlier mounting guide into a specification that can be consumed reliably by software agents. It does this by:

1. separating external standards, de facto conventions, project baselines, recommendations, and unresolved measurements;
2. giving every enforceable requirement a stable identifier;
3. defining a canonical coordinate system and vocabulary;
4. distinguishing full-depth, half-depth, partial-depth, and through-depth objects;
5. separating manufacturing tolerance, fit clearance, service clearance, structural overlap, and Boolean epsilon;
6. providing OpenSCAD constants, functions, and assertions;
7. defining expected outputs, validation artifacts, and failure behavior.

This document does **not** claim that all commercial products sold as “10-inch rack” equipment are mutually compatible. The width format is a de facto ecosystem convention rather than a single universally controlling mechanical standard.

### 0.2 Requirement keywords

Agents and human designers shall interpret keywords as follows:

| Keyword | Meaning |
|---|---|
| **MUST / SHALL** | Mandatory for conformance to this project specification. |
| **MUST NOT / SHALL NOT** | Prohibited for conformance. |
| **SHOULD** | Preferred unless a documented project-specific reason overrides it. |
| **SHOULD NOT** | Normally avoided unless a documented reason overrides it. |
| **MAY** | Optional. |
| **UNKNOWN** | A required project input that has not yet been measured or selected. |
| **DERIVED** | Computed from other authoritative values; do not edit independently. |

### 0.3 Evidence and authority labels

Every numerical rule should be interpreted according to its authority label:

| Label | Meaning | Precedence |
|---|---|---:|
| `NORMATIVE_EXTERNAL` | Taken from a formal standard or standardized hardware geometry. | 1 |
| `DE_FACTO_ECOSYSTEM` | Common 10-inch mini-rack convention, but not universally standardized. | 2 |
| `PROJECT_CONSTRAINT` | Explicit constraint of this rack project. | 3 |
| `DESIGN_BASELINE` | Chosen default for this implementation. | 4 |
| `RECOMMENDATION` | Conservative engineering starting point requiring validation. | 5 |
| `CALIBRATION_RESULT` | Measured value from the actual printer, material, and process. | Overrides generic print recommendations. |
| `MEASURED_COMPONENT` | Measurement of the real component being mounted. | Overrides nominal product descriptions. |
| `UNKNOWN` | Must be supplied before release. | Blocks release when used by geometry. |

When two values conflict, use the higher-precedence value, except that a verified `MEASURED_COMPONENT` or `CALIBRATION_RESULT` overrides a generic recommendation.

### 0.4 Agent reading order

An implementation agent SHOULD read sections in this order:

1. Section 1: scope and exclusions.
2. Section 2: canonical vocabulary and coordinates.
3. Section 3: rack geometry.
4. Section 4: M3 hardware.
5. Section 5: depth model.
6. Section 6: clearances and tolerances.
7. Section 7: structural rules.
8. Section 8: OpenSCAD contract.
9. Section 9: validation and outputs.
10. Section 12: requirement index.

An agent MUST NOT generate production geometry while a required parameter is `UNKNOWN`.

---

## 1. Scope, constraints, and exclusions

### 1.1 Included

This specification covers:

- front rail geometry and the repeating rack-unit hole pattern;
- 1U and multi-U printed rails, ears, shelves, trays, faceplates, and chassis modules;
- M3 clearance holes, washer seats, optional M3 inserts, captive M3 nuts, and compression limiters;
- FDM/FFF and SLA/DLP printed structural parts;
- front-only, full-depth, half-depth, partial-depth, and through-depth equipment or features;
- front and rear keepouts, insertion paths, cable/connector service zones, airflow zones, and tool access;
- OpenSCAD implementation and automated assertions;
- fit, structural, and fabrication validation.

### 1.2 Project constraints

- **RACK-SCOPE-001 — `PROJECT_CONSTRAINT`:** All primary user-facing rack mounting screws MUST be M3×0.5.
- **RACK-SCOPE-002 — `PROJECT_CONSTRAINT`:** Every primary mounting screw MUST bear through an ISO 7089 M3 flat washer.
- **RACK-SCOPE-003 — `PROJECT_CONSTRAINT`:** M4, M5, M6, 10-32, 12-24, and other primary rack screw systems are outside this design protocol.
- **RACK-SCOPE-004 — `PROJECT_CONSTRAINT`:** A metal M3 insert, captive M3 nut, or M3 threaded plate MAY provide the female thread behind the printed face without violating the M3-only user-facing constraint.
- **RACK-SCOPE-005 — `PROJECT_CONSTRAINT`:** Countersunk primary mounting screws MUST NOT be used because the required flat washer would not seat correctly.
- **RACK-SCOPE-006 — `PROJECT_CONSTRAINT`:** Rack depth is a project input. No universal rack depth is implied by the term “10-inch rack.”
- **RACK-SCOPE-007 — `PROJECT_CONSTRAINT`:** All canonical dimensions in code and machine-readable data MUST be stored in millimetres.

### 1.3 Excluded or separately specified

This report does not independently define:

- electrical grounding or protective-earth bonding;
- fire classification;
- shock or vibration qualification for a particular vehicle or industry;
- thermal performance of installed electronics;
- exact screw length for every assembly;
- a universal commercial 10-inch rear-rail position;
- component-specific connector dimensions;
- a universal printer compensation value.

Those values must be added by the project using this specification.

---

## 2. Canonical vocabulary and coordinate system

### 2.1 Coordinate system

- **X axis:** left to right when viewing the rack from the front.
- **Y axis:** front to rear.
- **Z axis:** bottom to top.
- **Front mounting plane:** `Y = 0`.
- **Rack centerline:** `X = 0`.
- **Bottom of the modeled rack volume:** `Z = 0`, unless a parent assembly establishes another datum.

All parts, keepouts, and inspection sections MUST use this coordinate system.

### 2.2 Canonical terms

| Term | Definition |
|---|---|
| `front_mounting_plane` | Plane against which the front face or rack ears register. |
| `rail_hole_column` | Vertical line through the centers of the mounting holes on one rail. |
| `rack_unit` or `U` | Vertical module of 44.45 mm. |
| `equipment_envelope` | Solid bounding volume occupied by the installed item, excluding declared flexible cables. |
| `service_envelope` | Equipment envelope plus connector, bend-radius, tool, airflow, and removal clearances. |
| `usable_depth_interval` | Closed Y interval in which ordinary equipment may occupy volume. |
| `depth_class` | Explicit semantic class: `front_only`, `half_front`, `half_rear`, `partial`, `full`, or `through_feature`. |
| `depth_anchor` | Reference used to place an item: `front`, `rear`, or `explicit`. |
| `support_mode` | How the item is supported: `front_ears`, `front_shelf`, `front_and_rear`, `side_rails`, `base`, or project-defined. |
| `manufacturing_tolerance` | Expected dimensional deviation of the made part from CAD. |
| `fit_clearance` | Intentional gap allowing two separately made parts to assemble. |
| `service_clearance` | Empty space needed for access, connectors, airflow, motion, or removal. |
| `structural_overlap` | Positive-volume material intersection intentionally joining structural solids. |
| `remaining_ligament` | Material left between a cutout and the nearest exterior or another cutout. |
| `Boolean epsilon` | Tiny computational overlap or extension used only to avoid coplanar rendering artifacts. |
| `keepout` | Volume that ordinary equipment or structure is prohibited from occupying. |

### 2.3 Critical semantic separation

- **VOCAB-001:** `fit_clearance` MUST NOT be counted as `structural_overlap`.
- **VOCAB-002:** `Boolean epsilon` MUST NOT be presented as a physical fit, tolerance, wall, or overlap dimension.
- **VOCAB-003:** An agent MUST NOT infer `depth_class` only from an item's numerical depth. The class MUST be declared.
- **VOCAB-004:** A declared `full` item may be manufactured shorter than the usable interval because of front and rear fit clearance; this does not change its logical class.
- **VOCAB-005:** `service_envelope` MUST be validated separately from the solid `equipment_envelope`.
- **VOCAB-006:** A subtraction is not automatically a keepout. Keepouts MUST be named and classified by purpose.

---

## 3. Rack geometry

### 3.1 Standards status

The vertical rack-unit system is inherited from the formal 19-inch rack ecosystem. The horizontal dimensions used by current 10-inch mini-rack designs are de facto conventions.

#### Canonical geometry table

| Parameter | Symbol / key | Value | Authority | Notes |
|---|---|---:|---|---|
| Rack unit height | `u_pitch` | 44.45 | `NORMATIVE_EXTERNAL` | 1.75 in. |
| First-to-second hole pitch within U | `u_hole_pitch_a` | 15.875 | `NORMATIVE_EXTERNAL` | Often rounded to 15.9. |
| Second-to-third hole pitch within U | `u_hole_pitch_b` | 15.875 | `NORMATIVE_EXTERNAL` | Often rounded to 15.9. |
| Third hole to next-U first hole | `u_hole_pitch_c` | 12.700 | `NORMATIVE_EXTERNAL` | Sometimes reported as 12.67 due to source rounding. |
| Left-to-right rail-hole column spacing | `rail_hole_spacing_x` | 236.525 | `DE_FACTO_ECOSYSTEM` | Primary horizontal interoperability datum. |
| Nominal front width | `rack_front_width_nominal` | 254.000 | `DE_FACTO_ECOSYSTEM` | Useful design envelope, not universal proof of compatibility. |
| Nominal clear opening | `rack_clear_opening_nominal` | 222.250 | `DE_FACTO_ECOSYSTEM` | Commercial frames vary. |
| Conservative maximum equipment body width | `equipment_width_max_baseline` | 220.000 | `DESIGN_BASELINE` | Leaves approximately 1.125 mm per side inside a 222.25 mm opening. |
| Typical top-to-bottom 1U ear-hole spacing | `ear_hole_spacing_z` | 31.750 | `DERIVED` | `15.875 + 15.875`. |
| Nominal rail-face width | `rail_face_width_nominal` | 15.875 | `DERIVED` | `(254.0 - 222.25) / 2`. |
| Hole center from nominal outside edge | `hole_center_from_outer_edge` | 8.7375 | `DERIVED` | `(254.0 - 236.525) / 2`. |
| Hole center from nominal inner rail edge | `hole_center_from_inner_edge` | 7.1375 | `DERIVED` | `15.875 - 8.7375`. |

### 3.2 Canonical vertical hole sequence

For each rail, use a repeating three-hole sequence:

```text
hole 0 at Z = U_origin + 0.000
hole 1 at Z = U_origin + 15.875
hole 2 at Z = U_origin + 31.750
next U hole 0 at Z = U_origin + 44.450
```

The 12.700 mm gap is between `hole 2` of one U and `hole 0` of the next.

- **RACK-GEO-001:** The U pitch MUST be 44.45 mm.
- **RACK-GEO-002:** Hole generation MUST use the repeating 15.875 / 15.875 / 12.700 mm sequence.
- **RACK-GEO-003:** An implementation MUST NOT generate holes by evenly dividing 44.45 mm into thirds.
- **RACK-GEO-004:** The left and right hole columns SHOULD be separated by 236.525 mm.
- **RACK-GEO-005:** Horizontal ecosystem compatibility SHOULD be provided by slots or calibrated assembly tolerance rather than by changing the nominal hole-column centers.
- **RACK-GEO-006:** The equipment body SHOULD remain within 220.0 mm width unless the actual rack opening has been measured and a project-specific envelope is declared.

### 3.3 Multi-U height

For a nominal `n_u` face:

```text
nominal_face_height = n_u * 44.45
```

A real removable faceplate SHOULD normally include a small top and bottom installation gap. That gap is a project fit decision and MUST NOT alter the hole sequence.

Recommended starting point:

```text
faceplate_height = n_u * 44.45 - faceplate_vertical_clearance_total
faceplate_vertical_clearance_total = 0.4 to 0.8 mm for calibrated FDM
```

This is a `RECOMMENDATION`, not a rack standard. The actual value must come from the printer/material calibration and from whether neighboring faces are printed, metal, or commercial.

### 3.4 Horizontal mounting slots

For custom printed equipment ears:

- One side MAY use round Ø3.4 or Ø3.6 mm holes as a datum.
- The opposite side SHOULD use horizontal slots when tolerance stack-up or vendor variation is expected.
- A useful starting slot is 3.6 mm wide by 5–6 mm long, centered on the nominal hole location.
- Washer-seat geometry MUST remain adequate across the full slot length.

- **RACK-GEO-007:** Slot length MUST NOT reduce the remaining ligament below the structural minimum.
- **RACK-GEO-008:** An M3 washer MUST remain fully supported at every permitted screw position in a slot.
- **RACK-GEO-009:** The slot's long axis SHOULD be horizontal unless the design is intentionally compensating for vertical manufacturing error.
- **RACK-GEO-010:** A slot MUST NOT be used to hide an incorrect U pitch.

---

## 4. M3 hardware and printed joint baseline

### 4.1 Canonical hardware

| Item | Canonical value | Authority |
|---|---:|---|
| Thread | M3×0.5 | `NORMATIVE_EXTERNAL` |
| Typical external thread class | 6g | `NORMATIVE_EXTERNAL` |
| Typical internal thread class | 6H | `NORMATIVE_EXTERNAL` |
| ISO 273 close clearance | Ø3.2 | `NORMATIVE_EXTERNAL` |
| ISO 273 medium clearance | Ø3.4 | `NORMATIVE_EXTERNAL` |
| ISO 273 coarse clearance | Ø3.6 | `NORMATIVE_EXTERNAL` |
| Standard cut-tap finished pilot | Ø2.50 | `NORMATIVE_EXTERNAL` |
| ISO 7089 M3 washer ID | 3.2 | `NORMATIVE_EXTERNAL` |
| ISO 7089 M3 washer OD | 7.0 | `NORMATIVE_EXTERNAL` |
| ISO 7089 M3 washer thickness | 0.5 | `NORMATIVE_EXTERNAL` |
| Typical ISO 4762 M3 socket-head diameter | 5.5 | `NORMATIVE_EXTERNAL` |
| Typical ISO 4762 M3 socket-head height | 3.0 | `NORMATIVE_EXTERNAL` |
| Typical socket key size | 2.5 | `NORMATIVE_EXTERNAL` |
| Printed washer seat diameter | 8.0–8.5 | `RECOMMENDATION` |
| Primary bracket radial ligament from hole edge | ≥2.5 | `DESIGN_BASELINE` |
| Light-duty radial ligament from hole edge | ≥2.0 | `RECOMMENDATION` |

### 4.2 Clearance-hole selection

Use the **finished** hole diameter, not merely the CAD diameter, as the acceptance value.

| Use | Finished diameter | Rule |
|---|---:|---|
| Closely controlled, post-machined datum | 3.2 | Use sparingly. |
| Default single printed part | 3.4 | Preferred baseline. |
| Two printed parts or modular rail stack-up | 3.6 | Preferred for easy assembly. |
| Slot width | 3.6 minimum | Preserve washer support and structural ligament. |

- **FAST-M3-001:** Primary rack holes MUST be clearance holes unless an explicit M3 insert or M3 nut strategy is declared.
- **FAST-M3-002:** The default finished rack hole MUST be Ø3.4 mm.
- **FAST-M3-003:** Ø3.6 mm SHOULD be used where two independently printed members must align.
- **FAST-M3-004:** Ø3.2 mm SHOULD be used only where location is controlled and the finished hole is drilled or reamed.
- **FAST-M3-005:** Raw as-printed hole diameter MUST NOT be assumed to equal CAD diameter.
- **FAST-M3-006:** Each printer/material/profile combination MUST have a calibration result or post-machining plan before production release.

### 4.3 Washer seats

- The washer's 7.0 mm OD must sit on a continuous, flat, load-bearing surface.
- Recommended printed seat diameter is 8.0–8.5 mm.
- A shallow 0.2–0.4 mm printed recess MAY be used to create a flat seat, provided it does not reduce the underlying wall below the minimum.
- Layer ridges, embossed text, fillets, and nearby ribs MUST NOT prevent full washer contact.

- **FAST-M3-007:** Washer support MUST remain continuous through 360° around a round hole unless a validated edge-seat design is explicitly declared.
- **FAST-M3-008:** The washer-seat support area MUST be checked at both ends of every slot.
- **FAST-M3-009:** A counterbore for the screw head does not replace the washer seat.
- **FAST-M3-010:** Countersunk screw geometry MUST NOT be used for primary mounting.

### 4.4 Female-thread strategy

Preferred hierarchy:

1. M3 screw + washer + metal M3 nut or captured nut.
2. M3 screw + washer + heat-set insert in FDM thermoplastic.
3. M3 screw + washer + glue-in/press-in insert in suitable SLA/DLP resin.
4. Direct-tapped printed plastic only for low-load, low-cycle, non-primary joints.

For a common M3 thermoplastic insert starting geometry:

| Parameter | Starting value |
|---|---:|
| Finished insert hole | 4.00 |
| Printed pilot before finishing | 3.8–3.9 |
| Preferred insert length | about 5.7 |
| Preferred printed boss OD | 10.0–11.0 |
| Minimum washer seat | 8.0 |
| Boss depth behind face | insert length + 1.0–1.5 |
| Minimum hole depth rule | insert length + two thread pitches |
| Insert top | flush; no more than 0.13 mm proud where applicable |

The exact insert manufacturer's drawing overrides these starting values.

### 4.5 Screw length selection

An agent MUST derive screw length from the actual stack:

```text
required_threaded_length =
    washer_thickness
  + front_part_thickness
  + any spacer thickness
  + any compression_limiter length contribution
  + required_female_thread_engagement
```

Select the shortest standard M3 screw that provides the required engagement without bottoming out or entering a prohibited keepout.

- **FAST-M3-011:** Screw length MUST be computed from stack-up.
- **FAST-M3-012:** The screw MUST NOT bottom in a blind insert before the washer clamps the assembly.
- **FAST-M3-013:** Screw tip protrusion MUST be checked against electronics, cables, batteries, fans, and hands.
- **FAST-M3-014:** At least one tool-access volume for the selected head style MUST be modeled or declared.

---

## 5. Rack depth model

### 5.1 Why depth must be explicit

“10-inch rack” describes the front width ecosystem, not a universal front-to-rear depth. A design agent must therefore treat depth as a separate project-defined system.

Every mounted item MUST declare:

```yaml
depth_class: front_only | half_front | half_rear | partial | full | through_feature
depth_anchor: front | rear | explicit
support_mode: front_ears | front_shelf | front_and_rear | side_rails | base | custom
item_nominal_depth: number | auto
item_depth_offset: number | auto
front_fit_clearance: number
rear_fit_clearance: number
front_service_clearance: number
rear_service_clearance: number
rear_keepout: number
insertion_clearance: number
support_depth: number
```

### 5.2 Rack depth datums

The rack assembly MUST define:

| Parameter | Meaning |
|---|---|
| `rack_internal_depth` | Distance from the front internal datum to the rear internal obstruction plane. |
| `front_reserved_depth` | Structural or hardware volume immediately behind the front datum that ordinary equipment cannot occupy. |
| `rear_reserved_depth` | Structural or hardware volume immediately ahead of the rear obstruction plane. |
| `front_global_service_depth` | Global front access/insertion space reserved for all items. |
| `rear_global_service_depth` | Global rear connector/cable/tool zone reserved for all items. |
| `usable_depth_start` | First Y coordinate available to ordinary equipment. |
| `usable_depth_end` | Last Y coordinate available to ordinary equipment. |
| `usable_depth` | `usable_depth_end - usable_depth_start`. |

Canonical derivation:

```text
usable_depth_start =
    front_reserved_depth
  + front_global_service_depth

usable_depth_end =
    rack_internal_depth
  - rear_reserved_depth
  - rear_global_service_depth

usable_depth =
    usable_depth_end - usable_depth_start
```

- **DEPTH-001:** `rack_internal_depth` MUST be a project input or a measured value.
- **DEPTH-002:** `usable_depth` MUST be positive.
- **DEPTH-003:** Front and rear reserved zones MUST be modeled independently.
- **DEPTH-004:** Connector and cable service depth MUST NOT be silently included inside the solid equipment depth.
- **DEPTH-005:** An item MUST be validated against both the equipment interval and the service interval.

### 5.3 Depth classes

#### 5.3.1 `front_only`

Use for faceplates, ears, shallow control panels, cable pass-throughs, or devices whose body does not require classification as a shelf-depth item.

Required behavior:

- anchored at the front;
- supported at the front, front shelf, or base;
- explicit maximum rearward projection;
- rear support is not implied.

A `front_only` item MUST NOT be reclassified as `half_front` merely because it happens to be shallow.

#### 5.3.2 `half_front`

Use for an item allocated to the front half of the usable depth.

Default manufactured depth:

```text
half_front_depth =
    usable_depth / 2
  - half_depth_fit_clearance
```

Default offset:

```text
half_front_offset = front_fit_clearance
```

The fit clearance changes the manufactured length, not the logical classification.

#### 5.3.3 `half_rear`

Use for an item allocated to the rear half of the usable depth.

Default manufactured depth:

```text
half_rear_depth =
    usable_depth / 2
  - half_depth_fit_clearance
```

Default offset:

```text
half_rear_offset =
    usable_depth
  - rear_fit_clearance
  - half_rear_depth
```

This class is useful for rear-mounted power, networking, battery, cable-management, or compute modules that intentionally leave the front half available.

#### 5.3.4 `partial`

Use for any explicit depth and explicit location that is not governed by the half-depth or full-depth allocation rules.

Required fields:

```text
item_nominal_depth
item_depth_offset
```

A partial-depth item may be front-, rear-, or center-positioned. Its location must be explicit.

#### 5.3.5 `full`

Use for equipment intended to occupy the full usable equipment interval and, where applicable, engage both front and rear support regions.

Default manufactured depth:

```text
full_depth =
    usable_depth
  - front_fit_clearance
  - rear_fit_clearance
```

Default offset:

```text
full_depth_offset = front_fit_clearance
```

A full-depth item remains logically full-depth even though its actual solid is shorter than the usable interval.

A full-depth item SHOULD declare `support_mode: front_and_rear`, `side_rails`, `base`, or another support mode appropriate to its mass. `front_ears` alone is allowed only when the resulting cantilever is structurally validated.

#### 5.3.6 `through_feature`

Use for an intentional structural or functional feature that spans depth zones, such as:

- a continuous side rail;
- a wire chase;
- a drive shaft;
- a structural tie;
- an airflow duct;
- a light pipe;
- a cable conduit.

A through-depth feature is not ordinary equipment. It may enter reserved or service zones only when each crossed zone is explicitly allowed.

- **DEPTH-006:** Every item MUST declare exactly one `depth_class`.
- **DEPTH-007:** Every item MUST declare `support_mode`.
- **DEPTH-008:** `partial` items MUST provide explicit depth and offset.
- **DEPTH-009:** `full` items MUST resolve front and rear fit clearance separately.
- **DEPTH-010:** `half_front` and `half_rear` MUST be distinguishable in data and geometry.
- **DEPTH-011:** The solid interval and service interval MUST both remain inside their permitted envelopes.
- **DEPTH-012:** A `through_feature` MUST list every keepout or service zone it is permitted to cross.
- **DEPTH-013:** Depth class MUST NOT be inferred from support mode.
- **DEPTH-014:** Support mode MUST NOT be inferred from depth class.

### 5.4 Depth occupancy interval

For any item:

```text
occupied_start_y = usable_depth_start + item_depth_offset
occupied_end_y   = occupied_start_y + item_actual_depth
```

Service interval:

```text
service_start_y =
    occupied_start_y
  - item_front_service_clearance

service_end_y =
    occupied_end_y
  + item_rear_service_clearance
  + connector_projection
  + cable_bend_depth
```

Assertions:

```text
occupied_start_y >= usable_depth_start
occupied_end_y   <= usable_depth_end
service_start_y  >= allowed_service_start_y
service_end_y    <= allowed_service_end_y
```

These checks must use actual resolved dimensions, not only nominal metadata.

### 5.5 Coexistence of front and rear half-depth modules

Two half-depth modules may share one depth bay only when:

```text
front_item_occupied_end_y
+ inter_module_service_gap
<=
rear_item_occupied_start_y
```

The `inter_module_service_gap` must include:

- connector protrusions;
- cable bend radii;
- removal path;
- airflow requirement;
- tool access;
- motion or latch travel;
- manufacturing and frame tolerance.

- **DEPTH-015:** Solid non-interference alone is insufficient for paired half-depth modules.
- **DEPTH-016:** The two service envelopes MUST NOT overlap unless the overlap is explicitly shared and validated.
- **DEPTH-017:** A cable-sharing zone MUST be a named volume, not an accidental remaining gap.
- **DEPTH-018:** Removal of one module SHOULD NOT require destructive disassembly of the other unless declared.

### 5.6 Rear support and cantilever checks

A long item mounted only by front ears creates ear bending and rail-face loading. The design MUST record:

```yaml
item_mass:
center_of_mass_y:
front_support_y:
rear_support_y: null | number
support_span:
design_acceleration:
```

For agent review:

```text
cantilever_moment = item_weight_force * (center_of_mass_y - front_support_y)
```

This specification does not prescribe one universal permissible moment because material, print orientation, ear geometry, and load environment vary. Instead:

- front-only support for long or heavy equipment MUST be justified by analysis or test;
- full-depth mobile equipment SHOULD have rear, side-rail, or base support;
- rear support geometry MUST allow insertion and tolerance without forcing the chassis into bending.

---

## 6. Tolerances, fit, service clearance, and keepouts

### 6.1 Separate numerical categories

Every dimensional value used to create “extra space” MUST be assigned to one category:

| Category | Purpose | Counts as structure? |
|---|---|---|
| `manufacturing_tolerance` | Expected plus/minus production error. | No. |
| `fit_clearance` | Intentional assembly gap between separate parts. | No. |
| `service_clearance` | Empty space for use, access, airflow, connectors, cables, or motion. | No. |
| `structural_overlap` | Positive-volume union between structural solids. | Yes. |
| `boolean_epsilon` | Computational artifact prevention. | No. |
| `safety_margin` | Additional design reserve. | Only if embodied as real material or real empty space, as applicable. |

- **CLR-001:** Each clearance parameter MUST have a descriptive name including its purpose.
- **CLR-002:** Generic variables named only `clearance` SHOULD NOT be used in production code.
- **CLR-003:** A fit-clearance value MUST NOT be reused as Boolean epsilon.
- **CLR-004:** A structural-overlap value MUST NOT be reduced automatically because a neighboring fit clearance increased.
- **CLR-005:** Tolerance stack-up MUST be computed across independently manufactured parts.
- **CLR-006:** The agent MUST report the final worst-case gap and worst-case interference for critical fits.

### 6.2 Printer calibration

Generic CAD compensation values are starting points only. Production values must be calibrated for:

- printer;
- nozzle or optical process;
- material/resin;
- layer height;
- orientation;
- slicer;
- wall count;
- cooling;
- cure;
- batch where necessary.

Recommended calibration artifact:

- 3.0–4.0 mm round-hole ladder;
- 3.2–3.8 mm slot-width ladder;
- male/female fit ladder from 0.10–0.60 mm per side;
- 8.0–8.5 mm washer-seat ladder;
- insert pilot ladder around the insert manufacturer's nominal;
- thin-wall and ligament coupons;
- X/Y and Z dimensional bars.

The resulting calibration record SHOULD be stored as machine-readable data.

### 6.3 Suggested starting fit values

These are not universal acceptance dimensions:

| Interface | FDM starting point | SLA/DLP starting point | Status |
|---|---:|---:|---|
| Sliding/removable planar fit, per side | 0.25–0.40 | 0.10–0.25 | `RECOMMENDATION` |
| Loose insertion fit, per side | 0.40–0.60 | 0.20–0.35 | `RECOMMENDATION` |
| Boolean epsilon | 0.01–0.05 | 0.01–0.03 | Computational only |
| Full-depth front fit | 0.5 | 0.25 | Starting value |
| Full-depth rear fit | 0.5 | 0.25 | Starting value |
| Half-depth fit deduction | 0.5 | 0.25 | Starting value |

An implementation SHOULD replace these with calibration values before release.

### 6.4 Service clearances

Service clearance must be decomposed by function:

```yaml
service_clearance:
  insertion:
  removal:
  screw_tool:
  connector_body:
  connector_mating:
  cable_bend:
  airflow_inlet:
  airflow_exhaust:
  fan_sweep:
  latch_motion:
  human_finger:
  label_visibility:
```

- **CLR-007:** Cable bend space MUST be based on the actual cable or a declared conservative envelope.
- **CLR-008:** Connector body depth and mating/unmating travel MUST be separate values.
- **CLR-009:** Airflow keepouts MUST be represented as volumes, not only notes.
- **CLR-010:** Tool-access checks MUST include the tool body and approach path.
- **CLR-011:** Removal paths MUST be checked as swept volumes when a module tilts, slides, or rotates during removal.

### 6.5 Keepout inventory

Each part or assembly SHOULD export a keepout inventory with:

| Field | Description |
|---|---|
| `keepout_id` | Stable identifier. |
| `purpose` | Cable, connector, airflow, tool, motion, electrical isolation, or structure. |
| `owner` | Component that requires the keepout. |
| `shape` | Box, cylinder, sweep, mesh, or compound. |
| `dimensions` | Canonical dimensions. |
| `coordinate_frame` | Datum and transform. |
| `allowed_intruders` | Explicit list; empty by default. |
| `verification` | Boolean intersection check, section review, or physical test. |

- **CLR-012:** Keepouts MUST default to exclusive.
- **CLR-013:** Shared keepouts MUST name every permitted owner.
- **CLR-014:** A subtraction-clearance inventory MUST be generated for all major cutouts.
- **CLR-015:** Pairwise spacing between neighboring cutouts MUST be checked where their remaining ligament can become critical.

---

## 7. Structural design rules for printed parts

### 7.1 Governing printed-joint failure modes

The primary risks are:

- local washer bearing and surface crushing;
- ear bending;
- hole-edge tear-out;
- boss splitting;
- insert pull-out or torque-out;
- direct-thread stripping;
- creep and preload loss;
- layer separation;
- notch-driven cracking;
- vibration loosening;
- reduced ligament after intersecting cutouts.

The steel M3 screw is often not the limiting component.

### 7.2 Minimum material rules

Project baseline:

| Feature | Minimum | Preferred |
|---|---:|---:|
| Primary wall thickness | 3.0 | 4.0–5.0 where practical |
| Structural overlap between fused solids | 3.0 | More for high load |
| Remaining ligament after cut | 3.0 | More near mounting holes |
| Radial material from M3 hole edge | 2.5 | 3.0+ |
| Washer seat diameter | 8.0 | 8.5 |
| Typical insert boss OD | 10.0 | 11.0+ if load permits |
| Fillet at loaded boss/wall junction | 0.8 | 1.5 or larger |

These are design baselines, not universal material allowables.

- **STRUCT-001:** Every structural join generated from separate primitives MUST have at least 3.0 mm of real positive-volume overlap unless a project-specific validated minimum is declared.
- **STRUCT-002:** Fit clearances and Boolean epsilon MUST NOT satisfy `STRUCT-001`.
- **STRUCT-003:** Every cutout MUST leave at least 3.0 mm remaining ligament where the remaining material is structural.
- **STRUCT-004:** Every primary M3 hole MUST preserve at least 2.5 mm radial material from finished hole edge to the nearest free edge, unless a validated local reinforcement is declared.
- **STRUCT-005:** A washer seat MUST not bridge an unsupported void.
- **STRUCT-006:** Structural overlap MUST be checked along the full intended seam, not only at one sample point.
- **STRUCT-007:** A long seam MUST report minimum overlap across its complete length.
- **STRUCT-008:** A cutout pair MUST report the minimum remaining throat between them.
- **STRUCT-009:** Text, labels, recesses, vents, and cosmetic grooves MUST participate in remaining-ligament checks when they remove material.
- **STRUCT-010:** Printed layer orientation MUST be declared for load-bearing parts.

### 7.3 Seam and overlap model

For a seam between bodies `A` and `B`, report:

```yaml
seam_id:
body_a:
body_b:
required_overlap:
measured_min_overlap:
seam_length:
samples_or_method:
status:
```

A passing seam must have continuous positive-volume intersection. Touching coplanar faces do not count.

For interval-based checks:

```text
overlap = min(a_max, b_max) - max(a_min, b_min)
```

Passing condition:

```text
overlap >= required_structural_overlap
```

### 7.4 Remaining throat

For a wall or bridge weakened by subtractive features:

```text
remaining_throat =
    original_structural_dimension
  - total_effective_cut_encroachment
```

The report must identify the location of the minimum throat, not only its value.

### 7.5 Compression limiters

Compression limiters or metal sleeves SHOULD be used when:

- the joint is repeatedly tightened;
- the rack is mobile or vibration-exposed;
- the polymer will be warm;
- clamp load must remain stable;
- a washer bears on a relatively thin printed wall.

The limiter should be dimensioned according to its manufacturer and should allow the plastic to be lightly compressed before the metal carries the higher clamp load. It MUST NOT be so long that the printed parts remain loose after screw tightening.

### 7.6 Print orientation

- Primary ears SHOULD be oriented so layer lines do not create an easy peel path from the chassis.
- Hole axes printed horizontally SHOULD normally use a self-supporting pilot and post-drilling.
- Insert bosses SHOULD be oriented and reinforced to resist splitting along layer planes.
- SLA/DLP parts SHOULD use generous fillets and avoid brittle resin at highly concentrated screw loads.

---

## 8. OpenSCAD implementation contract

### 8.1 Required file organization

Recommended repository layout:

```text
rack_spec/
  README.md
  schema/
    rack_parameters.schema.json
  data/
    rack_defaults.json
    printer_calibration.json
    component_profiles/
  scad/
    rack_constants.scad
    rack_assertions.scad
    rack_geometry.scad
    rack_keepouts.scad
    rack_debug.scad
  configs/
    rev_0001.json
  output/
    rev_0001/
      stl/
      renders/
      sections/
      metadata/
      validation/
```

### 8.2 Parameter naming

Use explicit names:

```scad
rack_front_width_nominal
rail_hole_spacing_x
u_pitch
m3_clearance_d_default
washer_seat_d
rack_internal_depth
front_reserved_depth
rear_reserved_depth
front_global_service_depth
rear_global_service_depth
item_depth_class
item_depth_anchor
item_partial_depth
item_partial_offset
item_front_fit_clearance
item_rear_fit_clearance
item_front_service_clearance
item_rear_service_clearance
minimum_structural_overlap
minimum_remaining_ligament
boolean_epsilon
```

Avoid:

```scad
w
d
clr
tol
gap
magic
fix
```

unless they are tightly scoped local variables with an unambiguous comment.

### 8.3 Canonical constants

```scad
// Units: mm
U_PITCH = 44.45;
U_HOLE_A = 15.875;
U_HOLE_B = 15.875;
U_HOLE_C = 12.700;

RACK_FRONT_WIDTH_NOMINAL = 254.000;
RAIL_HOLE_SPACING_X = 236.525;
RACK_CLEAR_OPENING_NOMINAL = 222.250;
EQUIPMENT_WIDTH_MAX_BASELINE = 220.000;

M3_THREAD_D = 3.0;
M3_THREAD_PITCH = 0.5;
M3_CLEARANCE_CLOSE_D = 3.2;
M3_CLEARANCE_DEFAULT_D = 3.4;
M3_CLEARANCE_COARSE_D = 3.6;
M3_TAP_DRILL_D = 2.50;

M3_WASHER_ID = 3.2;
M3_WASHER_OD = 7.0;
M3_WASHER_T = 0.5;
M3_WASHER_SEAT_D = 8.25;

MIN_STRUCTURAL_OVERLAP = 3.0;
MIN_REMAINING_LIGAMENT = 3.0;
MIN_PRIMARY_HOLE_RADIAL_MATERIAL = 2.5;

// Computational only. Never use as fit clearance or structure.
BOOLEAN_EPSILON = 0.02;
```

### 8.4 Depth enums

Use explicit strings:

```scad
DEPTH_FRONT_ONLY = "front_only";
DEPTH_HALF_FRONT = "half_front";
DEPTH_HALF_REAR = "half_rear";
DEPTH_PARTIAL = "partial";
DEPTH_FULL = "full";
DEPTH_THROUGH_FEATURE = "through_feature";

ANCHOR_FRONT = "front";
ANCHOR_REAR = "rear";
ANCHOR_EXPLICIT = "explicit";
```

### 8.5 Depth resolution functions

```scad
function resolved_usable_depth(
    rack_internal_depth,
    front_reserved_depth,
    rear_reserved_depth,
    front_global_service_depth,
    rear_global_service_depth
) =
    rack_internal_depth
    - front_reserved_depth
    - rear_reserved_depth
    - front_global_service_depth
    - rear_global_service_depth;

function resolved_item_depth(
    depth_class,
    usable_depth,
    partial_depth = undef,
    front_fit_clearance = 0.5,
    rear_fit_clearance = 0.5,
    half_depth_fit_clearance = 0.5,
    front_only_depth = undef
) =
    depth_class == DEPTH_FULL
        ? usable_depth - front_fit_clearance - rear_fit_clearance
    : depth_class == DEPTH_HALF_FRONT || depth_class == DEPTH_HALF_REAR
        ? usable_depth / 2 - half_depth_fit_clearance
    : depth_class == DEPTH_PARTIAL
        ? assert(!is_undef(partial_depth),
                 "DEPTH-PARTIAL requires partial_depth")
          partial_depth
    : depth_class == DEPTH_FRONT_ONLY
        ? assert(!is_undef(front_only_depth),
                 "DEPTH-FRONT-ONLY requires front_only_depth")
          front_only_depth
    : assert(depth_class == DEPTH_THROUGH_FEATURE,
             str("Unknown depth_class: ", depth_class))
      assert(!is_undef(partial_depth),
             "DEPTH-THROUGH-FEATURE requires explicit depth")
      partial_depth;

function resolved_item_offset(
    depth_class,
    usable_depth,
    item_depth,
    partial_offset = undef,
    front_fit_clearance = 0.5,
    rear_fit_clearance = 0.5
) =
    depth_class == DEPTH_FULL
        ? front_fit_clearance
    : depth_class == DEPTH_HALF_FRONT
        ? front_fit_clearance
    : depth_class == DEPTH_HALF_REAR
        ? usable_depth - rear_fit_clearance - item_depth
    : depth_class == DEPTH_FRONT_ONLY
        ? front_fit_clearance
    : assert(!is_undef(partial_offset),
             str(depth_class, " requires explicit offset"))
      partial_offset;
```

### 8.6 Required assertions

```scad
module assert_rack_geometry() {
    assert(abs((U_HOLE_A + U_HOLE_B + U_HOLE_C) - U_PITCH) < 0.001,
           "RACK-GEO: vertical hole sequence must sum to one U");

    assert(RAIL_HOLE_SPACING_X > EQUIPMENT_WIDTH_MAX_BASELINE,
           "RACK-GEO: rail columns must lie outside equipment body envelope");

    assert(M3_WASHER_SEAT_D >= M3_WASHER_OD,
           "FAST-M3: washer seat smaller than washer OD");

    assert(MIN_STRUCTURAL_OVERLAP > BOOLEAN_EPSILON,
           "STRUCT: structural overlap cannot be Boolean epsilon");
}

module assert_depth_envelope(
    depth_class,
    usable_depth_start,
    usable_depth_end,
    item_depth,
    item_offset,
    front_service_clearance = 0,
    rear_service_clearance = 0,
    connector_projection = 0,
    cable_bend_depth = 0,
    allowed_service_start_y = undef,
    allowed_service_end_y = undef
) {
    usable_depth = usable_depth_end - usable_depth_start;
    occupied_start_y = usable_depth_start + item_offset;
    occupied_end_y = occupied_start_y + item_depth;

    service_start_y =
        occupied_start_y - front_service_clearance;

    service_end_y =
        occupied_end_y
        + rear_service_clearance
        + connector_projection
        + cable_bend_depth;

    resolved_service_start =
        is_undef(allowed_service_start_y)
        ? usable_depth_start
        : allowed_service_start_y;

    resolved_service_end =
        is_undef(allowed_service_end_y)
        ? usable_depth_end
        : allowed_service_end_y;

    assert(usable_depth > 0,
           "DEPTH: usable depth must be positive");

    assert(item_depth > 0,
           "DEPTH: item depth must be positive");

    assert(occupied_start_y >= usable_depth_start,
           str("DEPTH: item begins before usable interval; class=", depth_class));

    assert(occupied_end_y <= usable_depth_end,
           str("DEPTH: item ends after usable interval; class=", depth_class));

    assert(service_start_y >= resolved_service_start,
           "DEPTH: front service envelope violates allowed interval");

    assert(service_end_y <= resolved_service_end,
           "DEPTH: rear service envelope violates allowed interval");
}

function interval_overlap(a0, a1, b0, b1) =
    min(a1, b1) - max(a0, b0);

module assert_min_overlap(
    a0, a1, b0, b1,
    required_overlap = MIN_STRUCTURAL_OVERLAP,
    label = "unnamed seam"
) {
    measured_overlap = interval_overlap(a0, a1, b0, b1);
    assert(measured_overlap >= required_overlap,
           str("STRUCT: ", label,
               " overlap=", measured_overlap,
               " required=", required_overlap));
}

module assert_min_ligament(
    measured_ligament,
    required_ligament = MIN_REMAINING_LIGAMENT,
    label = "unnamed ligament"
) {
    assert(measured_ligament >= required_ligament,
           str("STRUCT: ", label,
               " ligament=", measured_ligament,
               " required=", required_ligament));
}

module assert_m3_hole_edge(
    center_to_free_edge,
    finished_hole_d = M3_CLEARANCE_DEFAULT_D,
    required_radial_material = MIN_PRIMARY_HOLE_RADIAL_MATERIAL,
    label = "M3 hole"
) {
    radial_material = center_to_free_edge - finished_hole_d / 2;
    assert(radial_material >= required_radial_material,
           str("FAST-M3: ", label,
               " radial material=", radial_material,
               " required=", required_radial_material));
}

module assert_half_depth_pair(
    front_item_end_y,
    rear_item_start_y,
    required_inter_module_service_gap,
    label = "half-depth pair"
) {
    actual_gap = rear_item_start_y - front_item_end_y;
    assert(actual_gap >= required_inter_module_service_gap,
           str("DEPTH: ", label,
               " gap=", actual_gap,
               " required=", required_inter_module_service_gap));
}
```

### 8.7 Assertion behavior

- Assertions MUST run before production geometry is emitted.
- Assertions MUST include the requirement category and the relevant feature identifier.
- A failed assertion MUST stop the build.
- An agent MUST NOT “fix” a failed assertion by reducing the declared minimum unless the design requirement itself is intentionally revised and documented.
- Assertions SHOULD report measured and required values.
- Assertions MUST evaluate the resolved manufactured geometry.
- Debug geometry MAY visualize violations, but visual inspection does not replace assertions.

### 8.8 Section and debug outputs

Every revision SHOULD produce:

- front elevation with rail datums;
- left/right side elevation showing depth intervals;
- top view with equipment and service envelopes;
- X, Y, and Z orthographic renders;
- centerline section;
- section through each primary M3 joint type;
- section through minimum remaining throat;
- section through front and rear half-depth coexistence boundary;
- transparent or cutaway view of keepouts;
- exploded assembly view;
- interference visualization.

Use named colors only in debug renders; production solids should remain material-neutral.

---

## 9. Validation, acceptance, and deliverables

### 9.1 Required design outputs

A conforming agent-generated revision MUST include:

```text
1. Source CAD/OpenSCAD.
2. Machine-readable config.
3. Resolved parameter manifest.
4. STL or other fabrication meshes for every printed part.
5. Assembly render.
6. Orthographic renders.
7. Required section views.
8. Keepout inventory.
9. Seam/overlap report.
10. Remaining-ligament report.
11. Fastener stack-up report.
12. Depth-class report.
13. Validation log with pass/fail status.
14. README describing assembly and open measurements.
```

### 9.2 Depth-class report

For each item:

| Field | Required |
|---|---|
| `item_id` | Yes |
| `depth_class` | Yes |
| `depth_anchor` | Yes |
| `support_mode` | Yes |
| `usable_depth_start/end` | Yes |
| `item_actual_depth` | Yes |
| `item_offset` | Yes |
| `occupied_start/end` | Yes |
| `service_start/end` | Yes |
| `front/rear fit clearance` | Yes |
| `connector projection` | When present |
| `cable bend depth` | When present |
| `rear keepout` | When present |
| `assertion status` | Yes |

### 9.3 Fit and joint test sequence

Minimum prototype sequence:

1. Print calibration artifact.
2. Measure hole, slot, male/female fit, and washer-seat results.
3. Update calibration data.
4. Print one rail-ear coupon.
5. Verify rail-hole spacing and 1U pattern.
6. Install with M3 screws and washers.
7. Perform tighten-to-service-torque test.
8. Hold preload for 24 hours.
9. Inspect for washer sink, whitening, cracking, or looseness.
10. Perform pull-out or torque-out test on separate coupons.
11. Test a representative mounted mass.
12. For mobile use, perform representative vibration testing.
13. Reinspect after 168 hours where creep is important.

### 9.4 Acceptance criteria

A revision passes only when:

- all required dimensions are resolved;
- no required parameter remains `UNKNOWN`;
- all OpenSCAD assertions pass;
- required parts build without non-manifold errors;
- rack rail holes fit the intended M3 hardware;
- washers seat fully;
- equipment installs without forced bending;
- service envelopes do not violate keepouts;
- full-depth and half-depth objects match their declared classes;
- paired half-depth service envelopes are compatible;
- all structural overlaps meet their declared minimums;
- all remaining ligaments meet their declared minimums;
- screw tips and tools clear internal components;
- assembly and removal paths are demonstrated;
- the revision manifest and renders correspond to the same configuration.

### 9.5 Failure policy for agents

When a requirement fails, an agent MUST:

1. identify the failing requirement ID;
2. report actual versus required values;
3. identify the controlling input parameters;
4. revise geometry or explicitly elevate an unresolved design decision;
5. rerun all dependent assertions;
6. regenerate affected validation artifacts.

An agent MUST NOT:

- suppress an assertion;
- replace a physical clearance with Boolean epsilon;
- reduce minimum wall/overlap silently;
- change the 1U pattern to make a local feature fit;
- alter rail-hole center spacing without documenting loss of interoperability;
- classify a partial item as full merely to pass a branch;
- ignore connector or cable service volume.

---

## 10. Material/process guidance

### 10.1 FDM/FFF baseline

| Material | Use |
|---|---|
| PLA | Prototype or stable indoor low-heat use; not preferred for warm, highly preloaded, or mobile structures. |
| PETG | Strong general indoor baseline; low warp and good toughness. |
| ABS | Higher heat capability; requires warp control and post-finishing of critical holes. |
| ASA | Similar to ABS with better outdoor/UV suitability; still requires warp control. |
| Nylon | Tough and mechanically capable; requires drying, calibration, and attention to shrinkage. |

For critical holes, print undersize and drill/ream to finished size.

### 10.2 SLA/DLP baseline

- Use tough/durable engineering resin for loaded screw interfaces.
- Avoid treating thermoset resin like thermoplastic for heat-set inserts.
- Use glue-in inserts, captured M3 nuts, or through-fastened M3 joints.
- Use larger fillets and conservative ligaments around holes.
- Verify post-cure dimensional change.

### 10.3 Mobile or warm service

For vehicle, portable-lab, stage, outdoor, or elevated-temperature service:

- prefer PETG, ABS, ASA, Nylon, or a suitable engineering resin over PLA;
- use metal female threads;
- use washers at every primary screw;
- use compression limiters where clamp retention matters;
- support long/full-depth equipment at the rear, sides, or base;
- use a larger validation safety margin;
- perform representative vibration and thermal testing.

---

## 11. Worked depth examples

### 11.1 Example rack

Assume:

```yaml
rack_internal_depth: 300.0
front_reserved_depth: 8.0
rear_reserved_depth: 12.0
front_global_service_depth: 2.0
rear_global_service_depth: 20.0
```

Then:

```text
usable_depth_start = 8 + 2 = 10
usable_depth_end   = 300 - 12 - 20 = 268
usable_depth       = 258
```

These values are examples only.

### 11.2 Full-depth tray

```yaml
depth_class: full
front_fit_clearance: 0.5
rear_fit_clearance: 0.5
support_mode: front_and_rear
```

Resolved:

```text
item_depth = 258 - 0.5 - 0.5 = 257
item_offset = 0.5
occupied interval = Y 10.5 to 267.5
```

This is still `full`, not `partial`.

### 11.3 Front half-depth compute module

```yaml
depth_class: half_front
half_depth_fit_clearance: 0.5
front_fit_clearance: 0.5
rear_service_clearance: 15
support_mode: front_shelf
```

Resolved:

```text
item_depth = 258 / 2 - 0.5 = 128.5
item_offset = 0.5
occupied interval = Y 10.5 to 139.0
service end = Y 154.0
```

### 11.4 Rear half-depth power module

```yaml
depth_class: half_rear
half_depth_fit_clearance: 0.5
rear_fit_clearance: 0.5
front_service_clearance: 10
support_mode: rear_or_base_custom
```

Resolved:

```text
item_depth = 128.5
item_offset = 258 - 0.5 - 128.5 = 129.0
occupied interval = Y 139.0 to 267.5
service start = Y 129.0
```

The solid equipment envelopes merely touch at Y=139.0, but the service envelopes overlap from Y=129.0 to Y=154.0. This pair therefore **fails** unless a shared cable/service zone is intentionally designed and validated. This example illustrates why solid non-interference is not enough.

### 11.5 Partial-depth radio shelf

```yaml
depth_class: partial
depth_anchor: explicit
item_nominal_depth: 85
item_depth_offset: 25
front_service_clearance: 5
rear_service_clearance: 10
support_mode: base
```

The item is placed explicitly and is neither half-depth nor full-depth.

---

## 12. Requirement index

### Rack and standards

- `RACK-SCOPE-001` through `RACK-SCOPE-007`
- `RACK-GEO-001` through `RACK-GEO-010`

### Vocabulary and data semantics

- `VOCAB-001` through `VOCAB-006`

### M3 hardware

- `FAST-M3-001` through `FAST-M3-014`

### Depth and support

- `DEPTH-001` through `DEPTH-018`

### Clearances and keepouts

- `CLR-001` through `CLR-015`

### Structure

- `STRUCT-001` through `STRUCT-010`

An agent SHOULD emit a conformance matrix listing each applicable requirement ID and one of:

```text
PASS
FAIL
NOT_APPLICABLE
BLOCKED_UNKNOWN
```

`NOT_APPLICABLE` requires a reason. `BLOCKED_UNKNOWN` requires the missing parameter name.

---

## 13. Machine-readable minimum input contract

```yaml
rack:
  rack_front_width_nominal: 254.0
  rail_hole_spacing_x: 236.525
  rack_clear_opening_nominal: 222.25
  equipment_width_max_baseline: 220.0
  rack_internal_depth: UNKNOWN
  front_reserved_depth: UNKNOWN
  rear_reserved_depth: UNKNOWN
  front_global_service_depth: 0.0
  rear_global_service_depth: UNKNOWN
  u_count: UNKNOWN

fabrication:
  process: UNKNOWN
  material: UNKNOWN
  printer_profile_id: UNKNOWN
  calibration_profile_id: UNKNOWN
  minimum_structural_overlap: 3.0
  minimum_remaining_ligament: 3.0
  boolean_epsilon: 0.02

fastener:
  thread: M3x0.5
  washer_standard: ISO_7089_M3
  finished_clearance_hole_default: 3.4
  finished_clearance_hole_stackup: 3.6
  washer_seat_diameter: 8.25
  screw_head_style: socket_cap_or_pan_or_button

items:
  - item_id: UNKNOWN
    depth_class: UNKNOWN
    depth_anchor: UNKNOWN
    support_mode: UNKNOWN
    item_nominal_depth: UNKNOWN
    item_depth_offset: UNKNOWN
    front_fit_clearance: UNKNOWN
    rear_fit_clearance: UNKNOWN
    front_service_clearance: UNKNOWN
    rear_service_clearance: UNKNOWN
    connector_projection: UNKNOWN
    cable_bend_depth: UNKNOWN
    mass: UNKNOWN
    center_of_mass_y: UNKNOWN
```

---

## 14. Source basis and provenance

This specification expands the prior report titled **“10-Inch Rack M3 Mounting Design Guide for 3D-Printed Structures.”** That report distinguished the formal 19-inch rack vertical pattern from the de facto 10-inch width ecosystem and compiled the M3 clearance-hole, washer, printed-hole, insert, process, load, and validation guidance used here.

Primary source families inherited from that report include:

- IEC 60297 and EIA-310-aligned rack documentation for the 19-inch vertical system;
- Project MINI RACK for de facto 10-inch horizontal conventions;
- ISO 273 for clearance holes;
- ISO 965 for thread tolerance notation;
- ISO 4762 and related screw geometry;
- ISO 7089 for plain washers;
- SPIROL guidance for inserts and compression limiters;
- Stratasys, Ultimaker, Prusa, and Formlabs guidance for additive-manufacturing behavior and post-processing.

Values labeled `RECOMMENDATION` or `DESIGN_BASELINE` remain subject to calibration and physical validation.

---

## 15. Release checklist

```text
[ ] Rack depth measured or selected.
[ ] Front and rear structural reserved depths defined.
[ ] Rear connector/cable service depth defined.
[ ] Every item has explicit depth_class.
[ ] Every item has explicit support_mode.
[ ] Every partial item has explicit depth and offset.
[ ] Full-depth items resolve front and rear fit separately.
[ ] Front/rear half-depth pair service envelopes checked.
[ ] Printer/material calibration profile attached.
[ ] Finished M3 hole strategy selected.
[ ] Washer seat supported everywhere.
[ ] Screw lengths resolved from stack-up.
[ ] Screw-tip keepouts checked.
[ ] Tool-access volumes checked.
[ ] All major subtractive features inventoried.
[ ] Minimum throat and ligament reports generated.
[ ] Continuous structural seam overlap verified.
[ ] Fit clearance excluded from structural overlap.
[ ] Boolean epsilon excluded from physical dimensions.
[ ] Orthographic, cutaway, and section renders generated.
[ ] Physical rail-ear coupon tested.
[ ] Validation log passes.
[ ] Revision manifest frozen.
```
