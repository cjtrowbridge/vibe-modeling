# Playbook: Update the Agent Submodule and Synthesize Host Overrides

*Status: Stable*

## Objective

Update the `agents/` pin through an auditable three-way synthesis that retains
host-specific CAD policy.

## Procedure

1. Create and approve an active update plan.
2. Record the old submodule commit and current host-managed artifact inventory.
3. Update the submodule and record the new commit.
4. For every affected host-managed file, compare old upstream, new upstream, and
   current host content using `templates/submodule_update_synthesis_report.md`.
5. Preserve host behavior and integrate applicable upstream hardening.
6. Present unresolved merge decisions for user approval before writing them.
7. Apply approved resolutions and update documentation.
8. Validate paths, plan schema, script interfaces, indexes, and CAD workflow rules.

## Verification and Rollback

- Run `python scripts/regenerate_plan_indexes.py --check --repo-root .`.
- Check for stale paths and forbidden kanban artifacts.
- Confirm `AGENTS.md` still contains structural and artifact-governance rules.
- Roll back both the submodule pointer and synthesized host files if validation fails.
