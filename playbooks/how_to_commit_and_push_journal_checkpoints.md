# Playbook: Commit and Push Journal Checkpoints

*Status: Stable*

## Objective

Record approved conversation checkpoints in the journal while keeping Git scope
and user authorization explicit.

## Procedure

1. Review `git status -sb`, staged changes, and untracked files.
2. Summarize changed files, the active plan path, and checklist deltas.
3. Append the checkpoint to today's `journal/YYYY-MM-DD.md`; never invent text for
   user-only intentions or reflections.
4. Regenerate plan indexes when plan files changed.
5. For mixed code/docs/journal changes, request explicit commit and push approval.
6. For journal-only changes, a commit may proceed after presenting its exact scope;
   pushing still requires explicit approval.
7. Verify the resulting commit and repository status.

## Commit Message

Prefer `journal: checkpoint YYYY-MM-DD <short description>` for journal-only
snapshots. Use the general commit playbook for implementation checkpoints.
