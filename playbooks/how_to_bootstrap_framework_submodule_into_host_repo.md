# Playbook: Bootstrap the Agent Framework Submodule

*Status: Stable*

## Objective

Add Agentic Pipelines at `agentic-pipelines/` while preserving host policy and avoiding
blind replacement of project-specific workflows.

## Procedure

1. Add and initialize `https://github.com/cjtrowbridge/agentic-pipelines.git`
   at the host-authoritative `agentic-pipelines/` path. Translate upstream
   `./pipelines` examples before presenting them as host commands.
2. Record the pinned commit and inventory existing host policies, playbooks,
   references, templates, and scripts.
3. Create approved host operational directories. This repository deliberately
   excludes kanban artifacts.
4. Copy missing upstream artifacts only when they are relevant to this host.
5. Synthesize same-named artifacts, preserving host CAD and safety requirements.
6. Keep root `AGENTS.md` as the hybrid host authority; use
   `agentic-pipelines/AGENTS.md` as
   an upstream baseline and fallback, not an automatic host override.
7. Validate paths, indexes, documentation, and rollback before cutover.

## Verification

- `git submodule status --recursive` reports the intended commit.
- Host policy states precedence explicitly.
- No existing host artifact was overwritten without synthesis.
- Plan index validation passes.
