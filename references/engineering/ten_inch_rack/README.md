# Ten-Inch Rack Engineering Reference

This directory contains immutable versions of the agent-readable engineering
baseline for mostly 3D-printed, de facto ten-inch rack systems.

## Current Version

- `v2.0.0/`
- Document ID: `ten-inch-rack-m3-printed-design-spec`
- Normative semantics: `v2.0.0/10-inch-rack-agent-readable-design-spec.md`
- Machine-readable baseline: `v2.0.0/10-inch-rack-parameters.json`
- Reference OpenSCAD helpers: `v2.0.0/rack_constants_and_assertions.scad`
- Import provenance: `v2.0.0/bundle_manifest.json`

Version directories are immutable. Import a changed specification into a new
version directory rather than editing an existing package.

## Host Precedence

This repository's `AGENTS.md` and CAD playbooks override conflicting reference
defaults. In particular:

- The specification's `2.5 mm` minimum radial material around a primary M3 hole
  becomes `max(2.5 mm, minimum_wall_thickness)`; with the normal `3 mm` host
  minimum, at least `3 mm` is required.
- Host-generated artifacts use only `output/<design>/`,
  `revisions/<design>/rev_000N/`, and `.tmp/scad/<design>/`. The standalone
  layout suggested in specification section 8.1 is not used here.
- Required conformance matrices, keepout inventories, stack-up reports, and
  revision validation records belong under `designs/<design>/docs/`.
- The nested companion JSON is a reference baseline, not a direct
  `scad_build.py` config. Resolve and flatten required scalar values into the
  design revision config.
- Do not include the reference SCAD file directly from production geometry.
  Copy and adapt the applicable helpers under `designs/<design>/src/lib/` so
  source-tree provenance includes them, and record the source bundle version.

All required `UNKNOWN` values must be resolved before immutable publication.

## Known Source Errata

The imported v2.0.0 files are preserved byte-for-byte. Known metadata/document
limitations are therefore documented here rather than patched in place:

- JSON records schema version `1.0.0` but has no separate document-version key.
- SCAD has no embedded specification-version constant.
- `DERIVED` is used as an authority label but is absent from the Markdown label-definition table.
- External source families are named, but exact editions and source records are not embedded.

These limitations do not change the v2.0.0 source hashes. Future corrected source
material should be imported as a new version.

## Usage

Follow `playbooks/working_with_ten_inch_racks.md` and validate the package with:

```bash
python scripts/validate_ten_inch_rack_reference.py
```
