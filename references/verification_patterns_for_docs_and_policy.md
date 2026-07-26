# Reference: Verification Patterns for Docs and Policy

## Core Principle

Existence does not prove usability. Documentation and policy must be structured,
connected to valid paths, actionable, and aligned with the repository.

## Verification Levels

1. **Exists**: the referenced artifact is present.
2. **Structured**: required sections and fields are present.
3. **Connected**: links, paths, and indexes match the repository.
4. **Actionable**: steps, prerequisites, approval gates, and expected outcomes are clear.
5. **Aligned**: the artifact does not contradict `AGENTS.md` or applicable playbooks.

## Artifact Checks

### Playbooks

- State a specific objective and realistic prerequisites.
- Provide ordered, executable steps and a verification section.
- Bind implementation to approved active-plan checklist items.
- Preserve CAD structural and artifact checks where applicable.

### Templates

- Distinguish required fields from optional placeholders.
- Use the same vocabulary as their governing playbooks.
- Capture active plan paths and checklist deltas when applicable.

### Indexes and organization docs

- Match actual filenames and directory layout.
- Remove stale entries when files move or are deliberately excluded.
- Verify commands from the documented working directory.

## Minimal Verification Log

```md
- Checked: `path/to/file.md`
- Result: pass | fail | partial
- Evidence: [specific section/path/reference]
- Next action: [none or specific fix]
```
