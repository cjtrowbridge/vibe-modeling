# Agentic Pipelines Migration Synthesis

## Scope

- Host repository: `cjtrowbridge/vibe-modeling`
- Prior submodule: `cjtrowbridge/agents` at
  `e723231c3ad8a72439a98eff6be0fd6f07e00bb4`, mounted at `./agents`
- New submodule: `cjtrowbridge/agentic-pipelines` at
  `89d3b3e47fd43ff9fb94d7f35e05b17f5a21ca89`, mounted at
  `./agentic-pipelines`
- Report date: 2026-08-04

## Decisions

| Area | Host behavior preserved | Upstream behavior adopted | Resolution |
|---|---|---|---|
| authority | root `AGENTS.md` and explicit user instructions remain canonical | pipeline-specific routing may fall back to the submodule | synthesized host precedence |
| mount path | user-selected `./agentic-pipelines` | framework repository and pinned runtime are adopted | upstream `./pipelines` examples must be translated |
| CAD governance | plans, structural checks, manifest builds, artifact review order, rack policy, and journals remain unchanged | deterministic-first execution and bounded pipeline rules apply to future pipeline work | preserve host CAD policy |
| kanban | forbidden without a future approved host policy change | none required by the new framework | preserve host prohibition |
| runtime activation | no model-backed host pipeline exists in this scope | runtime remains available in the submodule | defer `pipeline.yaml`, API config, prompts, and runtime evidence directories |
| VS Code | existing stale-CAD task and primary play action remain host-owned | future pipeline entrypoints must be visible and bootstrap through host scripts | defer until a concrete host pipeline is approved |
| host content | plans, journal, TODO files, prompts, configs, and artifacts remain host-owned | upstream assets are fallback/reference inputs | never overwrite host files during updates |

## Path and Interface Migration

- `.gitmodules` now tracks `agentic-pipelines/` and the new repository URL.
- Host documentation routes to `agentic-pipelines/AGENTS.md`.
- Executable host commands use `./agentic-pipelines`; raw upstream
  `./pipelines` commands are not valid host commands until translated.
- The existing CAD build, artifact, and VS Code interfaces are not changed by
  this framework-only migration.

## Deferred Runtime Integration

No `pipeline.yaml`, `api.yaml`, model endpoint, pipeline prompt, requirements
file, or runtime state/artifact/thread/report directory is created. Those items
require a concrete pipeline goal and a separately approved plan.

## Rollback

Revert the migration commit to restore the former `.gitmodules`, `agents`
gitlink, root routes, and host documentation. Then run
`git submodule update --init --recursive agents` and revalidate plan indexes.
No host-owned CAD source or generated artifact is moved by this migration.
