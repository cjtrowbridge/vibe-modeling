# Playbook: Working With Ten-Inch Racks

*Status: Stable*

## Objective

Apply the versioned ten-inch rack engineering specification to a host design while
resolving project measurements, preserving host structural rules, and producing
traceable conformance evidence.

## Prerequisites

- Read `references/engineering/ten_inch_rack/README.md`.
- Read the complete normative specification for the selected version.
- Run `python scripts/validate_ten_inch_rack_reference.py`.
- Read the structural, fastener, tolerance-stack, section/probe, print-orientation,
  provenance, immutable-revision, and manifest-build playbooks as applicable.

## Procedure

1. **Select and record the reference version**
   - Record the bundle version and `bundle_manifest.json` hash in the active plan
     and design documentation.
   - Never silently switch an existing design to a newer reference version.
2. **Apply authority and host precedence**
   - Preserve the specification's authority labels and requirement IDs.
   - Apply `AGENTS.md` when it is stricter. Primary M3 radial material is at least
     `max(2.5 mm, minimum_wall_thickness)`.
3. **Resolve project inputs**
   - Measure or select rack depth, reserved zones, U count, fabrication process,
     calibration profile, component dimensions, support modes, and service zones.
   - Production geometry is blocked while a required input remains `UNKNOWN`.
4. **Create design-owned parameters and helpers**
   - The nested reference JSON is not a build config. Flatten resolved scalar
     parameters into `designs/<design>/configs/rev_000N.json` and record
     `rack_spec_version`.
   - Copy and adapt applicable SCAD helpers into `designs/<design>/src/lib/` so
     build provenance hashes them. Do not import production code from `references/`.
5. **Model semantic envelopes**
   - Use the canonical X/Y/Z datums, U hole sequence, explicit depth class,
     explicit support mode, equipment interval, service interval, named keepouts,
     insertion/removal paths, airflow, cable bends, and tool access.
6. **Apply mechanical contracts**
   - Use M3×0.5 primary hardware with ISO 7089 M3 washers.
   - Calculate screw stack-ups, washer support, hardware/tool envelopes, pairwise
     cut ligaments, full-seam overlap, and print-orientation effects.
7. **Produce design-owned evidence**
   - Store the resolved parameter manifest, applicable requirement matrix,
     keepout inventory, depth report, fastener stack-up, seam/ligament report, and
     validation log under `designs/<design>/docs/`.
   - Mark each applicable requirement `PASS`, `FAIL`, `NOT_APPLICABLE`, or
     `BLOCKED_UNKNOWN`; reasons are mandatory for the latter two.
8. **Map generated outputs to host governance**
   - Use `.tmp/scad/<design>/` for sections, crops, coupons, and probes.
   - Use governed current and immutable artifact destinations only.
   - Do not add validation reports to manifest-controlled output directories as
     unexpected artifacts.
9. **Calibrate and verify physically**
   - Print hole/slot/fit/washer/insert/ligament calibration artifacts and a rail-ear
     coupon before production release when fit depends on the fabrication process.
10. **Build, audit, and publish**
    - Run assertions and targeted views, review slicer layers, build/audit the
      complete manifest, record provenance, and only then publish an immutable
      revision.

## Verification

- The reference validator passes and the selected bundle version is recorded.
- All required unknowns are resolved or publication is blocked.
- Host structural minima and rack-specific requirements pass simultaneously.
- Depth, service, keepout, hardware, assembly, and removal envelopes are verified.
- Conformance evidence names the exact design revision/config and source bundle.

## Plan Binding

The active plan must identify the reference version, unresolved inputs, applicable
requirement groups, host overrides, physical tests, and publication gates.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
