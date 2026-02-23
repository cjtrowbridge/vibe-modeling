# Playbook: How to Commit and Push Changes

*Status: Draft*

## Objective

Provide a repeatable workflow to summarize staged changes, propose a commit message, and push to `origin` after user approval.

## Prerequisites

- Git installed and available in your shell
- Access to the remote `origin` (if pushing)

## Step-by-Step Instructions

1. **Check Repository Status**
   - Run `git status -sb`
   - If nothing is staged, stage the intended files and re-check

2. **Confirm Docs/Playbooks Are Updated**
   - Ensure `README.md`, `AGENTS.md`, and relevant `playbooks/*.md` are consistent with the change

3. **Handle Untracked Files Explicitly**
   - List untracked files and ask the user whether to:
     - add specific files
     - ignore them
     - stop
   - Do not assume untracked files should be added

4. **Review the Staged Diff**
   - Run `git diff --staged` (and optionally `git diff --staged --stat`)

5. **Summarize Changes**
   - Provide a concise summary and a single commit message suggestion (imperative mood)

6. **Request Approval**
   - Ask for approval before committing

7. **Commit After Approval**
   - Run `git commit -m "<approved message>"`

8. **Push (if requested)**
   - Run `git push origin HEAD`

## Reminder

- Commit after each completed change (task-scoped commits).

## Verification

- `git log -1 --oneline` shows the new commit
- `git status -sb` is clean (or only expected untracked files remain)
- `git push origin HEAD` succeeds (if push requested)
