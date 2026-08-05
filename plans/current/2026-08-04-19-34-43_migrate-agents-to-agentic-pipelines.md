---
plan_id: 2026-08-04-19-34-43_migrate-agents-to-agentic-pipelines
title: Migrate the Agent Framework to Agentic Pipelines
summary: Replace the agents submodule with agentic-pipelines at ./agentic-pipelines while preserving and validating host-owned CAD governance.
status: current
created_at: 2026-08-04-19-34-43
---

# Migrate the Agent Framework to Agentic Pipelines

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

The host path is deliberately `./agentic-pipelines`. This is an explicit host
override of the upstream framework's documented `./pipelines` convention. Every
adopted command, policy route, template, and playbook must use the host path;
untranslated upstream examples must not be presented as executable host commands.

This migration mounts and governs the framework only. Activating a model-backed
host pipeline, creating `pipeline.yaml`, configuring local inference, or adding
runtime state/artifact/thread/report storage is outside this plan unless the user
approves a revision.

- [x] 1. Establish an auditable migration baseline.
  - [x] 1.1 Record the clean/dirty status and exact commit of the existing
    `agents` submodule, currently observed at `e723231c3ad8a72439a98eff6be0fd6f07e00bb4`.
  - [x] 1.2 Fetch and record the exact approved `agentic-pipelines` commit to
    pin, rather than relying on a floating branch; the discovery-time `main`
    commit was `89d3b3e47fd43ff9fb94d7f35e05b17f5a21ca89`.
  - [x] 1.3 Inventory host-owned `AGENTS.md`, README, playbooks, references,
    templates, scripts, VS Code entrypoints, plans, journals, and ignore rules
    that overlap or refer to the old framework.
  - [x] 1.4 Verify that no uncommitted work exists inside `agents/`. Stop before
    deinitialization if submodule-local work would be lost.
- [x] 2. Create the required three-way policy synthesis.
  - [x] 2.1 Compare the old pinned framework, the new pinned framework, and the
    current host artifacts using
    `templates/submodule_update_synthesis_report.md`.
  - [x] 2.2 Preserve root `AGENTS.md` as canonical authority, including CAD
    plans, structural joins, manifests, artifact review order, journal rules,
    ten-inch-rack policy, and the host prohibition on kanban.
  - [x] 2.3 Adopt applicable Agentic Pipelines routing and deterministic-first
    rules without copying unrelated pipeline runtime policy into CAD workflows.
  - [x] 2.4 Document every rejected, deferred, or host-overridden upstream rule,
    especially `./pipelines`, runtime directory conventions, `TODO.md`
    ownership, and VS Code primary-entrypoint requirements.
- [x] 3. Replace the submodule as one reversible Git change.
  - [x] 3.1 Deinitialize and remove only the tracked `agents` submodule after
    resolving and verifying its absolute path and clean state.
  - [x] 3.2 Add `https://github.com/cjtrowbridge/agentic-pipelines.git` as a
    submodule at the exact host path `agentic-pipelines/` and pin the approved
    commit.
  - [x] 3.3 Update `.gitmodules` and verify recursive submodule initialization,
    status, URL, path, and pinned commit.
  - [x] 3.4 Confirm rollback can restore the prior `.gitmodules`, `agents/`
    pointer, and host routes without moving or deleting host-owned content.
- [x] 4. Migrate host routes and documentation to the new path.
  - [x] 4.1 Replace host references to `agents/`, `agents/RULES.md`, and
    `cjtrowbridge/agents` with the appropriate `agentic-pipelines/` route.
  - [x] 4.2 Update root `AGENTS.md` to route pipeline-specific work to
    `agentic-pipelines/AGENTS.md` while retaining explicit host precedence.
  - [x] 4.3 Update README framework identity, repository URL, local path,
    initialization commands, and operator expectations.
  - [x] 4.4 Update the bootstrap, framework-update, and playbook-authoring
    playbooks so their executable examples use `./agentic-pipelines`.
  - [x] 4.5 Search the entire host outside the submodule for stale executable
    `agents/` or `pipelines/` path assumptions and resolve each occurrence.
- [x] 5. Reconcile host entrypoints without activating a pipeline runtime.
  - [x] 5.1 Preserve the existing stale-CAD VS Code task and launch behavior
    unless a concrete conflict is demonstrated and approved.
  - [x] 5.2 Document that future Agentic Pipelines operator entrypoints must use
    host-owned commands and the `./agentic-pipelines` path override.
  - [-] 5.3 Defer `pipeline.yaml`, `api.yaml`, local model bootstrap,
    requirements, prompts, and runtime evidence directories; mark them `[-]`
    only after confirming this framework-only scope during execution.
- [x] 6. Validate the migrated host.
  - [x] 6.1 Run `git submodule status --recursive` and verify the exact new path,
    URL, and commit with no remaining tracked `agents` gitlink.
  - [x] 6.2 Regenerate and check plan indexes.
  - [x] 6.3 Run repository documentation/path checks and the new framework's
    applicable deterministic validators or tests that do not require local
    inference or credentials.
  - [x] 6.4 Verify root CAD governance remains intact and no kanban, credential,
    runtime state, generated report, or pipeline artifact was introduced.
  - [x] 6.5 Verify existing CAD build commands and VS Code stale-build hook are
    unchanged and syntactically valid.
- [?] 7. Record and checkpoint the migration.
  - [x] 7.1 Update this plan with evidence, unresolved findings, and the exact
    pinned commit; do not mark deferred runtime integration as completed work.
  - [x] 7.2 Append the migration outcome and verification evidence to today's
    journal without changing user-owned journal fields.
  - [ ] 7.3 Review the complete intended diff, confirm generated artifacts are
    excluded, and request approval for the task-scoped migration commit and any
    requested push.

## Expected Files

- `.gitmodules`
- `AGENTS.md`
- `README.md`
- `playbooks/how_to_bootstrap_framework_submodule_into_host_repo.md`
- `playbooks/how_to_update_submodule_and_synthesize_host_overrides.md`
- `playbooks/how_to_create_a_new_playbook.md`
- `plans/current/2026-08-04-19-34-43_migrate-agents-to-agentic-pipelines.md`
- `plans/current/index.md`
- `journal/YYYY-MM-DD.md`
- one synthesis report instantiated from
  `templates/submodule_update_synthesis_report.md`
- the `agents` gitlink removed and the `agentic-pipelines` gitlink added

## Acceptance Boundary

The migration is complete only when the host uses `./agentic-pipelines`
consistently, the submodule is pinned and reproducible, root host governance
still wins on conflict, applicable validation passes, and rollback is documented.
The presence of the new submodule alone is not acceptance.
