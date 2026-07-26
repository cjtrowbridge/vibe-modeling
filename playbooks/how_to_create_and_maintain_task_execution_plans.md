# Playbook: Create and Maintain Task Execution Plans

*Status: Stable*

## Objective

Create, approve, execute, revise, and archive task plans so substantial work is
traceable to atomic checklist items.

## Procedure

1. Check `plans/current/index.md` for a governing plan.
2. If none applies, create a future plan from `templates/task_execution_plan.md`.
3. Present its checklist items, affected files, and verification approach.
4. After approval, move it to `plans/current/` before the first substantial edit.
5. Execute only approved leaf checklist items.
6. If evidence requires new work, stop and request approval for a plan revision.
7. Mark results `[x]`, uncertain results `[?]`, and intentionally closed work `[-]`.
8. Move a finished plan to `plans/past/` when no follow-up execution remains.
9. After every create, edit, or move, run:

   ```bash
   python scripts/regenerate_plan_indexes.py --repo-root .
   ```

## Verification

- Plan filename, `plan_id`, status, and directory agree.
- Every implementation change maps to an approved checklist item.
- `python scripts/regenerate_plan_indexes.py --check --repo-root .` passes.
- The checkpoint summary identifies plan path and checklist deltas.
