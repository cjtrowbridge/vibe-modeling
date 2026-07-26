---
plan_id: 2026-07-26-16-17-47_migrate-agent-framework
title: Migrate Agent Framework Into Vibe Modeling
summary: Adopt selected upstream plan-governance workflows while preserving CAD policy and excluding kanban.
status: past
created_at: 2026-07-26-16-17-47
---

# Migrate Agent Framework Into Vibe Modeling

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [x] 1. Establish host-owned framework foundations.
  - [x] 1.1 Add plan lifecycle directories, deterministic host index tooling, indexes, and reusable plan templates.
  - [x] 1.2 Add journal and downtime scaffolding without kanban artifacts.
  - [x] 1.3 Add selected operational references and playbooks.
- [x] 2. Synthesize host policy and workflows.
  - [x] 2.1 Replace the advisory-only root policy with a hybrid `AGENTS.md`.
  - [x] 2.2 Merge upstream plan/journal controls into colliding host playbooks while retaining CAD checks.
  - [x] 2.3 Update `README.md` to document the adopted ownership and workflow model.
- [x] 3. Verify and close the migration checkpoint.
  - [x] 3.1 Validate plan indexes, policy paths, playbook inventory, and absence of kanban artifacts.
  - [x] 3.2 Review Git diff and archive this completed plan.

## Approved Constraints

- The user's 2026-07-26 approval authorizes this migration checkpoint.
- Do not add kanban directories, files, templates, references, playbooks, or requirements.
- Preserve all existing structural CAD and artifact-governance requirements.
- Do not modify the `agents` submodule contents.

## Verification Note

The upstream index script was synthesized into `scripts/regenerate_plan_indexes.py`
because its filesystem-mtime index fields drift after a fresh checkout. The host
version uses tracked `created_at` metadata for deterministic output.
