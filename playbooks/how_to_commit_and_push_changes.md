# Playbook: How to Commit and Push Changes

*Status: Draft*

## Objective

Provide a repeatable workflow to close an approved plan checkpoint, record it in
the journal, summarize staged changes, commit after approval, and push only when
explicitly approved.

## Prerequisites

- Git installed and available in your shell
- Access to the remote `origin` (if pushing)

## Step-by-Step Instructions

1. **Check Repository Status**
   - Run `git status -sb`
   - If nothing is staged, stage the intended files and re-check

2. **Confirm Plan, Docs, and Journal Are Updated**
   - Ensure the active plan reflects completed checklist items and lifecycle state.
   - Regenerate plan indexes when plan files changed.
   - Ensure `README.md`, `AGENTS.md`, and relevant `playbooks/*.md` are consistent with the change.
   - Append the repository checkpoint to today's journal without changing user-only fields.

3. **Handle Untracked Files Explicitly**
   - List untracked files and ask the user whether to:
     - add specific files
     - ignore them
     - stop
   - Do not assume untracked files should be added

4. **Review the Staged Diff**
   - Run `git diff --staged` (and optionally `git diff --staged --stat`)

5. **Summarize Changes**
   - Provide the active plan path, checklist deltas, concise change summary, and a single commit message suggestion (imperative mood)
   - Include a mandatory structural review block:
     - exact source revision/config reviewed, or `not applicable`
     - structural joins: `passed`, `failed`, `unverified`, or `not applicable`
     - minimum internal edge/material width: `passed`, `failed`, `unverified`, or `not applicable`
     - verification evidence or the reason verification remains incomplete
   - Never omit the block. For tasks that do not change CAD geometry, report both checks as `not applicable`.

6. **Request Approval**
   - Ask for approval before committing and separately confirm whether to push.

7. **Commit After Approval**
   - Run `git commit -m "<approved message>"`

8. **Push (only when approved)**
   - Run `git push origin HEAD`

## Reminder

- Commit after each completed change (task-scoped commits).

## Verification

- `git log -1 --oneline` shows the new commit
- `git status -sb` is clean (or only expected untracked files remain)
- `git push origin HEAD` succeeds (if push requested)
- `python scripts/regenerate_plan_indexes.py --check --repo-root .` passes when plans changed
