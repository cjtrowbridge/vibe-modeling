---
plan_id: 2026-07-26-17-29-44_integrate-ten-inch-rack-references
title: Integrate Ten-Inch Rack Engineering References
summary: Unify engineering references, import the versioned rack specification bundle, and add its workflow and validator.
status: past
created_at: 2026-07-26-17-29-44
---

# Integrate Ten-Inch Rack Engineering References

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [x] 1. Unify engineering references under `references/engineering/`.
  - [x] 1.1 Move servo references and update consumers.
  - [x] 1.2 Move the rack bundle byte-for-byte into a versioned package.
- [x] 2. Add rack package governance and tooling.
  - [x] 2.1 Add package authority, host precedence, provenance, and errata documentation.
  - [x] 2.2 Add a bundle synchronization validator.
- [x] 3. Add and connect `working_with_ten_inch_racks.md`.
  - [x] 3.1 Define reference consumption, design-local vendoring, conformance, and verification workflow.
  - [x] 3.2 Update `AGENTS.md` and `README.md` indexes and structure guidance.
- [x] 4. Verify and close the checkpoint.
  - [x] 4.1 Validate hashes, companion values, requirement IDs, paths, references, and no-kanban policy.
  - [x] 4.2 Review the diff, update the journal, and archive the plan.

## Approved Scope

- Use the unified plural `references/` tree.
- Name the playbook `playbooks/working_with_ten_inch_racks.md`.
- Preserve source bundle files byte-for-byte and record their original hashes.
- Do not modify CAD design geometry or generated artifacts.

## Completion Evidence

- Rack reference validator: passed four preserved source hashes, 80 requirement
  IDs, 20 synchronized OpenSCAD/JSON constants, and required rack-depth state.
- Cross-platform preservation: `.gitattributes` disables line-ending conversion
  for the four immutable source companions.
- Reference migration: no stale singular-reference links or directories.
- Host governance: 32 playbook files indexed exactly; zero host kanban paths.
- Plan indexes: regenerated and passed deterministic `--check` validation.
- Git whitespace check: passed.
