---
plan_id: 2026-08-13-17-44-00_restore-angled-screen-2u-rails
title: Restore Distinct Angled-Screen 2U Rails
summary: Separate the angled-screen rail, hardware-back, and exterior-closure owners so the screen presents two clear 2U rail columns rather than solid end-wall blocks.
status: current
created_at: 2026-08-13-17-44-00
---

# Restore Distinct Angled-Screen 2U Rails

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Evidence and Constraints

- Baseline: `a3af066` introduced the full-height end-wall wedge that fuses with
  the angled-screen rail columns. The current uncommitted rename preserves the
  same geometry and therefore cannot fix the visible block regression.
- Preserve the exact `222.25 x 88.90 mm` angled 2U aperture, six canonical M3
  stations per side, 45-degree screen transform, 50.8 mm rear clearance, and
  3 mm minimum wall, overlap, and internal material width.
- Do not use a broad hardware-envelope subtraction to compensate for a wall
  that occupies the rail volume. Rail face, rear nut land/back, and upper
  exterior closure require distinct owners.

## Checklist

- [ ] 1. Restore the visible angled-screen 2U rail topology.
  - [ ] 1.1 Remove the full-height `angled_screen_side_infill()` wedge from
    the shell union; do not replace it with a renamed or geometrically
    equivalent end-wall prism.
  - [ ] 1.2 Retain the two face-local `3 mm x 88.90 mm` rail columns, their
    six M3 passages, and their local rear nut lands as the only owners within
    the screen aperture and rear-hardware envelope.
  - [ ] 1.3 Retain or refine only a bounded upper exterior side-wall profile
    that joins the roof and rear wall without entering the 2U face, rail rear,
    nut pocket, or driver envelope.

- [ ] 2. Prove structure and feature separation.
  - [ ] 2.1 Add named assertions for each rail's support overlap, lower-chassis
    overlap, local nut-back depth, hardware-to-closure clearance, and every
    post-cut ligament; each structural value must be at least 3 mm.
  - [ ] 2.2 Add left/right face and rear-hardware crops or sections that show
    the clear aperture, two distinct rail columns, all six M3 stations, and
    no unexpected block or disconnected shell.

- [ ] 3. Reconcile the governing record and current workflow documentation.
  - [ ] 3.1 Mark the contradicted V and Z history in the earlier active plan as
    superseded/closed with an accurate explanation; retain AA/AB history.
  - [ ] 3.2 Correct the validation-record claim that the stale rebuild hook
    runs full assembly review, and replace the stale end-wall module name in
    the fastener report.
  - [ ] 3.3 Append an evidence-based journal checkpoint without editing
    user-owned fields, then regenerate and verify plan indexes.

- [ ] 4. Build and review the exact candidate.
  - [ ] 4.1 Validate the assembly contract, build the complete printable
    manifest, audit installed output, and inspect the affected installed leaf
    STL/PNG views.
  - [ ] 4.2 Run and audit the full provenance-bound assembly review after the
    printable audit; inspect rail-face, rear-hardware, side, and joint evidence
    from the installed artifacts.
  - [ ] 4.3 Record actual results, remaining physical-fit limits, and structural
    status in the plan, design records, and journal before the final commit.
