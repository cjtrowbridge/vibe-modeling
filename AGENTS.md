# Project Overview & Agent Guidelines

This repository is a reusable OpenSCAD modeling pipeline. Agents should treat the playbooks as executable workflow policy.

## 1. Documentation Integrity

Any code or workflow change should be reflected in docs in the same task.

Review/update these files when relevant:

1. `README.md` (root): project overview, structure, usage, commands
2. `AGENTS.md`: operating rules / playbook index
3. `playbooks/*.md`: workflow instructions

## 2. Operational Protocol

1. Seek a relevant playbook in `playbooks/` first.
2. Before making substantial changes:
   - form an atomic plan
   - identify missing info
   - ask for approval when the repo workflow requires it
3. Execute the approved plan.
4. Verify results (commands/tests/builds) and report outcomes.
5. Update docs/playbooks when the workflow changes.

## 3. Self-Evolving Workflow

Required cycle:

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Docs/playbook update -> Verification

If working in git:

- Check `git status -sb`
- Review diffs
- Suggest a task-scoped commit message
- Commit after a completed change

## 4. Agent Playbooks (Required Index)

Current playbooks:

- `playbooks/how_to_create_a_new_playbook.md` - Create a new operational playbook for repeatable tasks.
- `playbooks/how_to_commit_and_push_changes.md` - Safely summarize, approve, commit, and push changes.
- `playbooks/debugging_changes_that_lead_to_errors.md` - Evidence-first debugging workflow.
- `playbooks/how_to_iterate_openscad_designs.md` - Cross-platform OpenSCAD iteration/build/revision workflow.
- `playbooks/how_to_add_a_new_cad_design.md` - Add a new OpenSCAD design using the shared folder conventions.

## 5. Project Organization

Keep the repository layout documented in `README.md`.

The intended source-of-truth structure is:

- `scripts/` for automation
- `designs/` for committed OpenSCAD source and configs
- `output/` for scratch outputs (generated)
- `revisions/` for numbered snapshots (generated)
- `playbooks/` for repeatable workflows

## 6. Logging & Debugging Standards

- Favor scripts that print explicit command paths, inputs, and outputs.
- When adding new automation, include enough logging to diagnose path/config issues quickly.
