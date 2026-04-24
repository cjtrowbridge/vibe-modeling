# Lovelace

A 3d-printed, modular, mechanical computer inspired by Babbage's Analytical Engine concepts.

## Status

- Phase: concept definition
- Geometry: not started yet
- Goal of this README: capture the agreed baseline and open decisions before we start OpenSCAD implementation

## Core Vision

Create a system of 3D-printed cubes that each contain mechanical logic functionality. Cubes should connect physically and functionally so simple units can be composed into larger logic chains.

## Baseline Requirements (From Current Discussion)

1. The project name is `lovelace`.
2. The system uses modular cubes as the primary building block.
3. Cubes contain mechanical logic-gate behavior (composable into complex logic).
4. A dedicated motor block starts each logic chain.
5. The motor block must support extensibility so additional synchronized chains can be added.
6. Cube corners need magnet insets to support attachment/alignment between cubes.
7. Each cube needs standardized input/output interfaces, including power transfer.
8. Input blocks must impart binary values (`0`/`1`) downstream to connected logic gates.
9. Output blocks must display the resulting binary computation value.
10. First gate set includes `NOT`, `AND`, and `OR` cubes (De Morgan-complete working basis).
11. Utility cubes must include:
    - blank power passthrough cubes
    - 90-degree turn cubes for synchronized power distribution
12. Composable cubes must be used to build and validate the full basic gate family from these primitives.
13. Frequently used multi-cube compositions (for example NAND and NAND-based memory) should be candidates for later single-cube miniaturization.
14. Every cube type must be explicitly versioned to support iterative improvements and compatibility tracking.
15. Every cube top face must include:
    - a logical diagram/symbol
    - text name and version printed toward the front-bottom area of the top face
16. Add a `manual_motor_block` variant where the user turns a wheel on the left side to drive the chain.
17. Both motor block variants must provide:
    - linked/synchronized power input on the top face
    - power outputs on the right and bottom faces
18. Motor blocks should support forking synchronized power into multiple downstream logic chains.
19. The long-term project goal is a complete, working 4-bit mechanical computer built from Lovelace cubes.
20. Final validation must include a working 4-bit Two's Complement negation-and-addition routine, implying all required ALU functions/features are operational.

## Architecture Notes (Draft)

- Mechanical clock/power should be treated as a first-class interface, not an afterthought.
- Every cube should expose consistent connection points so orientation and chaining are predictable.
- Synchronization should be explicit in the motor block design so parallel chains stay phase-aligned.
- Logic-carrying interfaces and power-carrying interfaces may be distinct, but both must be standardized.

## Long-Term Goal (Agreed)

The target system is a complete, working 4-bit mechanical computer.

Working definition:

1. Reliable clocked operation under manual or automatic motor drive.
2. Correct 4-bit data-path behavior validated against truth-table/expected-state tests.
3. Usable input/output cubes for entering and reading 4-bit values.
4. Reproducible assembly from documented, versioned cube primitives and variants.
5. Demonstrated 4-bit Two's Complement negation and addition routine execution.

Roadmap alignment:

1. Finish stable primitive interfaces.
2. Validate gate primitives and composed logic.
3. Build/register-test 1-bit slices.
4. Scale to 4-bit integrated machine and validate end-to-end programs/operations.

## Graph Semantics (Agreed)

- Each v1 Lovelace machine's logic-signal graph is a directed acyclic graph (DAG) within a single evaluation step.
- Zero-delay feedback loops are not allowed in combinational logic paths.
- If feedback/state is added later, loops must pass through explicit state/delay elements so each combinational slice remains a DAG.

## Canonical Top-View Direction Convention (Agreed)

Top-view face meaning for standard logic blocks (`input`, `output`, gates, routers):

- Right face: logical result output direction.
- Top face: gate parameter input channel.
- Bottom face: gate parameter input channel.
- Left face: upstream logic input side for `output_block`, reserved side for manual drive on `manual_motor_block`, and gate input side only for `gate_not`.

Block behavior under this convention:

- Combining gates (`AND`, `OR`, and similar) accept top and bottom chain inputs, where each input carries both `P` and `L`, and combine these into a right-side output (`P` + `L`).
- Combining gates do not accept gate input on the left face.
- `gate_not` is the gate exception: it accepts input from the left and outputs to the right (with synchronized `P` passthrough via the extender primitive).
- `input_block` emits its selected binary value to the right.
- `output_block` accepts logic input from the left and displays the resulting value.

Consistency guardrail:

- Keep power connectors and logic connectors as separate keyed interfaces.
- Power face mapping is primitive-specific and defined by the primitive cube family below.

Motor-block exception (both motor variants):

- Top face: linked/synchronized power input bus.
- Right face: synchronized power output.
- Bottom face: synchronized power output.
- `manual_motor_block` left face: user hand wheel input.

This allows multiple motors of either type to remain phase-aligned through top-link coupling while also providing right/bottom power fan-out.

## Candidate Module Types

- `primitive_power_extender`: straight-through primitive for `P` + passthrough `L`.
- `primitive_power_combiner`: top/bottom combine to right on synchronized `P`, with corresponding logic channel routing.
- `primitive_turn_90`: right-angle forwarding primitive for `P` + `L`.
- `primitive_input`: sets and emits a binary state.
- `primitive_output`: receives and displays a binary state.
- `primitive_manual_motor`: left-side hand wheel drive with linked sync coupling.
- `primitive_auto_motor`: attachable drive source that can feed chains or manual-motor input.
- `gate_not`: inversion variant built on `primitive_power_extender`.
- `gate_and`: AND variant built on `primitive_power_combiner`.
- `gate_or`: OR variant built on `primitive_power_combiner`.
- `router_block` (optional): routing/splitting/combining variant for complex layouts.

## Compound Cube Miniaturization Strategy (Agreed Direction)

- Start with transparent primitive composition (`NOT`, `AND`, `OR`, routing/power cubes) to prove behavior.
- After validation, identify recurring composite patterns worth compacting into a single cube footprint.
- Priority examples include:
  - `nand_block` (composed from `AND` + `NOT`)
  - NAND-based memory/register structures
- Miniaturized cubes must preserve externally visible interface behavior so they can replace equivalent multi-cube subgraphs without rewiring the surrounding machine.

## Cube Versioning Policy (Agreed)

- Treat each cube as a versioned component (for example `gate_and v1`, `gate_and v2`).
- Version bumps are required when fit, timing, interface geometry, or reliability behavior changes.
- Validation should be tracked per cube version so known-good combinations can be reproduced.
- Future design docs/configs should reference cube type plus version, not cube type alone.
- Primitive version bumps require downstream re-evaluation of all inheriting/derived cubes before they are considered compatible.

## Block Folder Hierarchy Standard (Agreed)

Use a per-block, per-version source layout (design and output):

`designs/lovelace/blocks/<block_name>/<version>/<block_name>_<version>.scad`

Example:

`designs/lovelace/blocks/xor/0.0.1/xor_0.0.1.scad`

## Primitive-First Revision Model (Agreed for v1.0.0)

Major releases are defined as versioned primitive cube sets. Specific blocks inherit/compose from those primitives and fill in variant logic.

OpenSCAD implementation note:

- Use module composition/inclusion to model "inheritance" (shared primitive modules + variant overlays).

Why primitive inheritance is mandatory:

- Shared primitives guarantee mating power/logic connectors keep matching geometry and phase assumptions across cube families.
- Gate-specific modifications should change logic internals while preserving primitive interface contracts.
- When a primitive is incremented, every inheriting block must be re-checked because inherited interface or timing behavior may have changed.
- Primitive upgrades are treated as compatibility events, not local edits.

### v1.0.0 primitive set

1. `primitive_power_extender_1.0.0`
   - simple straight-through primitive
   - forwards `P` and passthrough `L` from input side to output side
2. `primitive_power_combiner_1.0.0`
   - combines top and bottom `P` inputs to right `P` output on one synchronized cam path
   - carries corresponding top/bottom logic channels to right-side logic output path
3. `primitive_turn_90_1.0.0`
   - forwards `P` and `L` through a right-angle direction change
4. `primitive_input_1.0.0`
   - sets a binary value and outputs it to the right
5. `primitive_output_1.0.0`
   - accepts binary value from the left and displays it
6. `primitive_manual_motor_1.0.0`
   - user wheel on left drives synchronized power
   - top linked sync `P` input, right/bottom sync `P` outputs
7. `primitive_auto_motor_1.0.0`
   - attachable drive primitive
   - can couple into a logic chain directly or into the manual motor power input for synchronized forking

### v1.0.0 gate variants from primitives

1. `gate_and_1.0.0` and `gate_or_1.0.0`
   - inherit/compose from `primitive_power_combiner_1.0.0`
   - consume top and bottom chain inputs (`P` + `L`), combine them, and emit right-side output (`P` + `L`)
   - no left-side gate input
   - add logic orbitals driven by that inherited combiner
2. `gate_not_1.0.0`
   - inherit/compose from `primitive_power_extender_1.0.0`
   - left-side input to right-side output path
   - adds inversion orbital (no top/bottom power-combining stage)

### v1.0.0 deliverables

1. Source SCAD for every primitive and every gate/input/output/motor variant under the block/version path standard.
2. Generated output artifact set for every primitive and every variant for verification and iteration.

## Top-Face Marking Standard (Agreed)

- Each cube top face must show a logic diagram/symbol for quick visual identification.
- Each cube top face must also include human-readable `name` + `version`.
- Placement rule: `name` + `version` text sits near the front edge, aligned toward the bottom of the top-face view convention.

## PLA Connection Strategy (Simple v0.0.1)

Use one simple interface pattern everywhere:

1. Corner magnets for hold/preload only.
2. Two hard alignment features per face (one round, one keyed) for shear + orientation.
3. One centered keyed power-cam connector per powered face.
4. One small binary logic connector per logic face.
5. No snap tabs or fragile flexure locks as primary couplers in v0.0.1.

## Printable Primitive Construction Pattern (Draft)

Use a serviceable 3-part pattern for early primitives:

1. `bottom_plate`: removable bottom with lower rotor holders/bearing seats.
2. `upper_shell`: cube walls + top with mirrored upper rotor holders/bearing seats.
3. `rotor_set`: shafts/cams/gears inserted between bottom and top holders.

Power-extender reference build:

1. Bottom plate positions and supports the power rotor from below.
2. Upper shell provides opposite supports from above.
3. Power rotor is a through-shaft with:
   - convex keyed/tapered output coupler on one side
   - concave keyed/tapered input coupler on the opposite side with insertion clearance
4. Left/right coupling faces include corner magnet recesses for retention/alignment preload.

Important constraint:

- Magnets assist alignment and retention only; torque transfer stays in keyed mechanical couplers.

## Procedural Rotor-Holder Placement Process (Required)

All holder geometry must be generated from one shared rotor registry so top and bottom always match.

Procedure:

1. Define each rotor/cam in a registry with centerline, axis, diameter, length, and required clearances.
2. Generate bottom holders directly from the registry.
3. Generate top holders by mirroring the same registry (never by manual duplicate modeling).
4. Generate shell cutouts/clearances from the same rotor data.
5. Validate per rotor:
   - fully captured between top and bottom holders
   - free rotation at intended clearance
   - no wall collisions
6. Add new gears/cams only by appending registry entries, then regenerate holders procedurally.

## Rotor Registry Schema (Proposed v0.0.1)

Use a single list entry per rotor/cam:

`[name, axis, center_xyz, diameter, span]`

Field definitions:

1. `name`: stable rotor id string.
2. `axis`: `"x"`, `"y"`, or `"z"` (v0.0.1 uses `"x"`).
3. `center_xyz`: centerline position in cube coordinates.
4. `diameter`: rotor outside diameter.
5. `span`: active shaft length inside the primitive.

v0.0.1 power-extender starter registry:

`["power_main", "x", [0, 0, cube_side/2], 6.0, cube_side - 2*cube_wall_t]`

Generation contract from the registry:

1. Bottom plate holders are generated from each entry.
2. Top holders are generated by mirrored use of the same entry.
3. Rotor passages/ports are generated from each entry.
4. Rotor solids (shaft/couplers) are generated from each entry.

This keeps holder placement, rotor geometry, and shell clearances synchronized by one source of truth.

## Wall And Holder Standards (v0.0.1 Draft)

Initial defaults for PLA + 0.4 mm nozzle:

1. `cube_wall_t = 2.4 mm`
2. `top_t = 2.4 mm`
3. `bottom_plate_t = 3.0 mm`
4. `holder_rib_t = 2.0 mm`
5. `holder_seat_t = 2.0 mm`
6. `rotor_radial_clearance = 0.25 mm`
7. `coupler_slip_clearance = 0.25 mm`
8. `coupler_axial_endplay = 0.20 mm`

These values are intentionally conservative for first-print reliability and can be version-bumped after measurement feedback.

## Power + Logic Port Architecture (Simple v0.0.1)

Each active face can expose two ports:

- `P` port: synchronized power cam/shaft.
- `L` port: binary logic signal (`0`/`1`) encoded by motion direction.

Rules:

1. Standard logic chain links carry both `P` and `L`.
2. Rotation convention:
   - `P` cam rotation = clockwise.
   - `L=true` rotation = clockwise.
   - `L=false` rotation = counter-clockwise.
3. Clockwise/counter-clockwise are evaluated from the canonical top-view orientation when reading cube behavior.
4. No `L` motion during an expected cycle window is a fault state, not a third logic value.
5. `L` direction still follows block semantics (input/output mapping).
6. `P` stays phase-synchronized across connected cubes.
7. Motor blocks follow the agreed map:
   - top = linked sync `P` input bus
   - right = sync `P` output
   - bottom = sync `P` output
   - manual motor left = user hand wheel drive

## Power-Cam Synchronization and Load Sharing (Simple v0.0.1)

1. Every cube internally ties all exposed `P` ports to one shared phase-indexed cam/axle.
2. Each cube re-injects synchronized power downstream so load is distributed across chains.
3. Reconverging chains must join at matching phase index.
4. Orbital/ring power structures are allowed, but each ring-closing connection must include a small backlash/compliance allowance to prevent hard binding.

Gate-specific power rule:

- For gate cubes, the two gate-side `P` inputs (top and bottom) must be mechanically combined with the gate-side `P` output (right) on the same synchronized internal power cam/axle.
- `NOT` is the explicit exception: it uses the straight `primitive_power_extender` path and performs inversion without top/bottom power combining.
- Gate logic rule matches this: non-`NOT` gates combine top/bottom `L` inputs and emit right-side `L` output, with no left-side gate input.

Design constraints:

- Logic graph remains DAG-constrained.
- Power graph can branch/reconverge for load sharing when phase and backlash rules are satisfied.

## V1 Functional Scope (Draft)

1. Define one canonical cube envelope with shared attachment and connector standards.
2. Build the power network first:
   - `primitive_manual_motor` + `primitive_auto_motor`
   - `primitive_power_extender`
   - `primitive_turn_90`
   - optional branch coupler/routing variant
3. Build binary interaction blocks:
   - `primitive_input`
   - `primitive_output`
4. Build primitive gates:
   - `gate_not` (from extender)
   - `gate_and` (from combiner)
   - `gate_or` (from combiner)
5. Compose primitives to realize and verify additional basic gates and combinations.

## Validation Plan (Draft)

1. Define a repeatable test harness layout using standard cube interconnects.
2. Validate each primitive gate with full truth-table coverage.
3. Validate composed gates built from primitives (for example NAND, NOR, XOR, XNOR).
4. Validate synchronized power delivery across straight and turned chain paths.
5. Validate multi-motor synchronization through top-link coupling (manual + motor variants).
6. Validate end-to-end demonstrations:
   - input cube(s) drive gate chain
   - output cube displays expected result
7. Final system validation: run a 4-bit Two's Complement Negation + Addition routine end-to-end.
8. Treat step 7 as ALU completeness validation: all required ALU functions/features must be working for pass.

## Interface Categories To Define Next

1. Mechanical power input/output (shaft, gear, or coupler standard).
2. Mechanical logic signal input/output channels.
3. Synchronization link between motor block and downstream chains.
4. Physical attachment standard:
   - magnet inset size/depth/location at cube corners
   - anti-slip / anti-rotation alignment features
5. Face-level connector map details for the agreed orientation convention:
   - right = logic result output baseline
   - top/bottom = gate input channels
   - left = output-block logic input / manual motor hand-wheel side
6. Motor face-level connector map details:
   - top = linked synchronized power input
   - right/bottom = synchronized power outputs
   - left (manual motor only) = user wheel drive input

## Open Questions

1. What is the base cube size and tolerance target for FDM printing?
2. What magnet standard should we design around (diameter, thickness, fit style)?
3. Which physical mechanism should implement the directional `L` signal (bidirectional slider, rotary shuttle, rocker linkage, etc.) and fault sensing for no-motion?
4. Should power and logic share one connector geometry or use separate keyed interfaces?
5. How many connection faces and channels per face are required for v1?
6. Do we define a fixed clock speed/ratio envelope for reliable synchronization?
7. What output display mechanism should v1 use (flag, slider window, rotating indicator, click-stop wheel)?
8. Should the input block support manual toggling only, or also driven/programmatic input?
9. What hand-wheel diameter/torque leverage should `manual_motor_block` target for comfortable use?

## Immediate Next Step

Define a v1 mechanical interface spec (cube envelope + corner magnet spec + power/logic connector geometry), then scaffold the first block set in OpenSCAD:

1. `primitive_manual_motor_1.0.0`
2. `primitive_auto_motor_1.0.0`
3. `primitive_power_extender_1.0.0`
4. `primitive_power_combiner_1.0.0`
5. `primitive_turn_90_1.0.0`
6. `primitive_input_1.0.0`
7. `primitive_output_1.0.0`
8. `gate_not_1.0.0`
9. `gate_and_1.0.0`
10. `gate_or_1.0.0`
