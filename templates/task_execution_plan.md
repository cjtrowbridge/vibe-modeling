---
plan_id: YYYY-MM-DD-HH-mm-ss_slug
title: Plan Title
summary: One-sentence summary of what this plan accomplishes.
status: future
created_at: YYYY-MM-DD-HH-mm-ss
---

# Plan Title

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [ ] 1. Abstract objective.
  - [ ] 1.1 Workstream.
    - [ ] 1.1.1 Atomic executable task.
- [ ] 2. Verification objective.
  - [ ] 2.1 Atomic validation task.

## Authoring Rules

- Use `YYYY-MM-DD-HH-mm-ss_slug.md` with a lowercase, hyphenated slug.
- Make `plan_id` match the filename stem exactly.
- Use only the required front matter keys shown above.
- Decompose work until each leaf item has one clear completion condition.
- Use `[-]` only for intentionally closed or de-scoped work.
- Keep file location aligned to `future`, `current`, or `past` status.
