---
plan_id: 2026-08-31-12-58-00_triple-thor-geometry-blockout
title: Triple Thor Enclosure Geometry Blockout
summary: Scaffold parametric OpenSCAD blockout geometry, parts manifest, assembly contract, and config for the triple_thor_enclosure at locked R=57mm layout.
status: current
created_at: 2026-08-31-12-58-00
---

# Triple Thor Enclosure Geometry Blockout

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

Locked dimensions (from README and user decisions):

- Thor footprint `113 x 57` mm, standing height `244` mm.
- Layout inradius **`R = 57` mm** (one Thor thickness).
- Cylinder ID `290` mm / OD `300` mm / height `300` mm, closed top / open bottom.
- Base OD `310` mm (r=155); `3 x 120-degree` sectors; center bore `r=60` (open bottom).
- Base sector height `57` mm (full Thor recess depth).
- Top cap: `3 x 120-degree` annular sectors, `r_in=60`, `r_out=155`, `30` mm tall, centering lip on `300` OD cylinder.
- Exhaust fan ring: `r_out=70`, `30` mm tall, `120` mm fan bore, mounted on top of cap, posts at `r=72`.
- Minimum wall `3` mm; minimum structural overlap `>= 3` mm.
- Print bed `220` mm; each sector fits at ~`45-degree` rotation (bbox ~`189 x 189` mm).

## Checklist

- [ ] 1. Scaffolding: `src/lib/defaults.scad` with all named dimension constants and required structural assertions.
  - [ ] 1.1 Define minimum wall/overlap/internal-edge constants and assert their relationships.
  - [ ] 1.2 Assert layout invariants (cylinder clearance, base fit, exhaust standoff, base sector bed fit).
- [ ] 2. Printable blockout geometry in `src/parts/`:
  - [ ] 2.1 `base_sector.scad` - 120-degree pie slice `r=155`, center bore `r=60`, Thor recess `57` mm deep, anti-drop lip `2` mm, cylinder receiving lip `r=150` to `r=155`, M3 seam/column/lip holes.
  - [ ] 2.2 `column.scad` - tube `r_out=60`, `r_in=55`, `300` mm tall, floor `3` mm, M3 post holes.
  - [ ] 2.3 `cap_sector.scad` - 120-degree annular sector `r_in=60` to `r_out=155`, `30` mm tall, centering lip on `300` OD, fan-mount post sockets.
  - [ ] 2.4 `exhaust_ring.scad` - ring `r_in=66`, `r_out=70`, `30` mm tall, `120` mm fan bore, 4 M3 posts at `r=72`.
  - [ ] 2.5 `src/parts/proxies.scad` - Thor reference box and cylinder reference cylinder (non-printable, review only).
  - [ ] 2.6 `src/parts/assembly_review.scad` - `assembled_product(explode, proxies)` module and `assembly_review(view_id, proxies)` dispatcher.
- [ ] 3. `src/main.scad` dispatch entrypoint: `part_id` 1-4 for printable parts, `90` for assembly review.
- [ ] 4. `parts.json` with `part_id` 1-4 and stable names.
- [ ] 5. `assembly.json` with product assembly, 4 subassemblies (base_trio, column, cap_trio, exhaust), 6 interfaces, required views (`compact` and `full`), and geometry export.
- [ ] 6. `configs/rev_0001.json` with all named parameters.
- [ ] 7. Verification:
  - [ ] 7.1 Dry-run build with `scad_build_all.py --dry-run` succeeds for all 4 parts.
  - [ ] 7.2 `validate_cad_assembly_contract.py` passes.
  - [ ] 7.3 `regenerate_plan_indexes.py --check` passes.
  - [ ] 7.4 Full `scad_build_all.py` build of all 4 parts into `output/triple_thor_enclosure/`, `--audit-only` passes, and the artifact-bound assembly review renders and is audited (OpenSCAD 2021.01 at `C:\Program Files (x86)\OpenSCAD\openscad.exe`).
- [ ] 8. Docs:
  - [ ] 8.1 Update `designs/triple_thor_enclosure/README.md` with locked base/top/exhaust dimensions and folder layout.
  - [ ] 8.2 Append `journal/2026-08-31.md` work-log entry.
  - [ ] 8.3 Propose commit message; request approval.

## Notes

- OpenSCAD 2021.01 is installed at `C:\Program Files (x86)\OpenSCAD\openscad.exe` and `scad_build.py` resolves it; full build and artifact-bound assembly review are viable.
- The blockout uses exact locked dimensions from the README and user decisions; no speculative parameters.
- M3 nut holders are intentionally deferred; placeholder M3 clearance holes only.
- The reference mockup at `src/triangle_layout_mockup.scad` is non-printable and excluded from the manifest.
