---
plan_id: 2026-07-26-16-46-19_add-missing-cad-playbooks
title: Add Missing CAD Workflow Playbooks
summary: Add the approved CAD pipeline, physical-design, and operational playbooks and connect them to existing workflows.
status: past
created_at: 2026-07-26-16-46-19
---

# Add Missing CAD Workflow Playbooks

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [x] 1. Add pipeline-continuity playbooks.
  - [x] 1.1 Add immutable revision, manifest build, manifest editing, and legacy migration playbooks.
  - [x] 1.2 Add CAD review, probe/section, verification-record, and build-automation playbooks.
- [x] 2. Add physical CAD workflow playbooks.
  - [x] 2.1 Add reference modeling, tolerance-stack, coupon, and print-feedback playbooks.
  - [x] 2.2 Add split-print, fastener, moving-part, and print-orientation playbooks.
- [x] 3. Add operational cleanup playbooks.
  - [x] 3.1 Add OpenSCAD troubleshooting and artifact-recovery playbooks.
  - [x] 3.2 Add reference-geometry and design-plan migration playbooks.
- [x] 4. Integrate the expanded playbook set.
  - [x] 4.1 Correct immutable revision ordering in the iteration workflow.
  - [x] 4.2 Require early manifest decisions in the new-design workflow.
  - [x] 4.3 Update `AGENTS.md`, `README.md`, and the journal.
- [x] 5. Verify and close the checkpoint.
  - [x] 5.1 Validate playbook structure, index completeness, referenced paths, and no-kanban constraint.
  - [x] 5.2 Review the complete diff and archive the plan.

## Approved Scope

- User approved the twenty titled playbooks proposed on 2026-07-26.
- Update existing workflows only where needed to delegate to the new playbooks.
- Do not add kanban artifacts or change CAD geometry/configuration.
