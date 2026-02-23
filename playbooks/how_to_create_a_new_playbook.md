# Playbook: How to Create a New Agent Playbook

*Status: Stable*

## Objective

Define a repeatable process for creating a new playbook that documents a multi-step workflow, troubleshooting pattern, or operational sequence for this repository.

## Prerequisites & Context Gathering

Before writing a new playbook:

1. Read `README.md` (project purpose + architecture)
2. Read `AGENTS.md` (agent policy + playbook index)
3. Check `playbooks/` to avoid duplicating an existing workflow

## When to Create a Playbook

Create a new playbook when:

- a task has more than 3 distinct steps
- a workflow is repeated frequently
- a debugging pattern should be preserved
- a new feature introduces a required build/test/deploy sequence

## Drafting the Playbook

### Filename Convention

- Use descriptive snake_case filenames
- Name it as a sentence fragment answering "What is this for?"

Examples:

- `how_to_run_release_builds.md`
- `troubleshooting_openscad_path_resolution.md`

### File Structure (Template)

```markdown
# Playbook: [Title]

*Status: [Draft | Stable | Deprecated]*

## Objective
[1-sentence summary]

## Prerequisites
- Tools
- Access

## Step-by-Step Instructions
1. [Step]
   - Command
   - Expected outcome
   - Failure handling

## Verification
[How to confirm success]

## Lifecycle Compliance
Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification
```

## Writing Guidelines

- Be specific (exact commands, paths, and working directory)
- Anticipate common failure modes
- Prefer repo scripts over long manual commands when available
- Keep workflows idempotent when possible

## Finalizing

1. Save the file under `playbooks/`
2. Update `AGENTS.md` playbook index if added/removed/renamed
3. If in a git repo, review status/diff and suggest a commit message
