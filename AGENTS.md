# Project Overview and Agent Guidelines

This repository is a reusable OpenSCAD modeling pipeline. Documentation, plans,
and playbooks are executable workflow policy.

## 1. Policy Layers and Precedence

This root `AGENTS.md` is the canonical host policy.

The `agents/` submodule supplies the reusable upstream framework baseline. Read
`agents/RULES.md` when working on agent workflow, but do not apply it blindly.
Resolve policy in this order:

1. This root `AGENTS.md` and explicit user instructions.
2. Host-managed `playbooks/`, `references/`, `templates/`, and `scripts/`.
3. Matching files under `agents/` only when the host has no applicable artifact.

Host policy overrides upstream policy on conflict. In particular, this repository
does not use kanban. Do not create kanban directories, files, templates,
references, playbooks, startup steps, or completion requirements unless the user
explicitly approves a future policy change.

Never edit files inside `agents/` as part of host work. Update its Git pointer and
synthesize affected host files through the submodule-update playbook.

## 2. Documentation Integrity

Any code, workflow, architecture, or repository-layout change must be reflected in
documentation in the same task. Review and update when relevant:

1. `README.md`: project structure, commands, and user-facing workflow.
2. `AGENTS.md`: canonical host rules and artifact indexes.
3. `playbooks/*.md`: repeatable execution workflows.
4. `references/*.md` and `templates/*.md`: shared operational guidance.
5. `journal/*.md`: approved repository-state checkpoints.
6. `downtime/*` and `docs/*`: maintenance and supplemental artifacts.

## 3. Plan-Governed Operational Protocol

Required cycle:

Prompt -> Select/Create Plan -> Request Approval -> Execute Approved Plan Items ->
Update Plan -> Update Docs -> Verify -> Journal Checkpoint -> Commit

1. Seek a relevant host playbook first, falling back to `agents/` only when no
   host artifact applies.
2. Check `plans/current/index.md` for an active governing plan.
3. Before substantial changes, create or refine an atomic plan, identify missing
   information, list expected files and verification, and request approval.
4. Promote a plan from `future` to `current` immediately before substantial edits.
5. Execute only approved checklist items. Stop and request a plan revision if
   evidence requires materially different work.
6. Mark completed items `[x]`, uncertain items `[?]`, and deliberately closed or
   de-scoped items `[-]`.
7. Archive a plan to `past` when no execution remains.
8. Regenerate indexes after plan changes:

   ```bash
   python scripts/regenerate_plan_indexes.py --repo-root .
   ```

9. Verify indexes with:

   ```bash
   python scripts/regenerate_plan_indexes.py --check --repo-root .
   ```

Small, read-only discovery does not require its own plan. A user's explicit
approval of a clearly presented atomic strategy may authorize its matching plan
items without a redundant approval prompt.

## 4. Journal and Downtime Policy

Repository-state changes must be recorded in today's `journal/YYYY-MM-DD.md`
before commit. Journal work logs are append-only unless the user asks otherwise.
`Today's Intentions` and `Notes / Reflections` are user-only; agents may insert
only verbatim user-provided text and otherwise leave `-`.

Downtime tasks are optional and report-only. They may create one recommendation
report under `downtime/reports/pending/` but may not directly implement findings.
Implementation requires an approved active plan. Before the final summary, list
any pending reports other than the directory README.

## 5. Git Checkpoints

When working in Git:

1. Check `git status -sb` before and after the task.
2. Do not assume unrelated or untracked files belong to the task.
3. Review the complete intended diff.
4. Update the active plan, documentation, and journal before commit.
5. Suggest a task-scoped imperative commit message.
6. Request explicit approval before committing or pushing unless the user already
   approved that exact action.
7. Commit each approved completed checkpoint. Push only when requested or approved.

## 6. Required Playbook Index

- `playbooks/how_to_create_and_maintain_task_execution_plans.md` - Create, approve, execute, and archive atomic task plans.
- `playbooks/how_to_bootstrap_framework_submodule_into_host_repo.md` - Bootstrap the upstream framework without overwriting host policy.
- `playbooks/how_to_update_submodule_and_synthesize_host_overrides.md` - Update the submodule through three-way host synthesis.
- `playbooks/how_to_commit_and_push_changes.md` - Review, approve, commit, and optionally push changes.
- `playbooks/how_to_commit_and_push_journal_checkpoints.md` - Record and commit journal checkpoints.
- `playbooks/how_to_create_a_new_playbook.md` - Create a repeatable operational playbook.
- `playbooks/debugging_changes_that_lead_to_errors.md` - Diagnose failures through evidence and controlled experiments.
- `playbooks/how_to_use_downtime_to_improve_the_framework.md` - Produce report-only maintenance recommendations.
- `playbooks/how_to_iterate_openscad_designs.md` - Iterate, build, and revise OpenSCAD designs.
- `playbooks/how_to_add_a_new_cad_design.md` - Add a design using shared folder conventions.
- `playbooks/how_to_design_and_verify_structural_openscad_joins.md` - Verify structural overlap, connectivity, and material width.
- `playbooks/how_to_create_verify_and_publish_immutable_openscad_revisions.md` - Develop mutable candidates and publish verified immutable revisions.
- `playbooks/how_to_build_install_and_audit_manifest_driven_openscad_designs.md` - Build and audit complete manifest artifact sets.
- `playbooks/how_to_add_change_or_remove_parts_from_a_design_manifest.md` - Safely change authoritative part identities and counts.
- `playbooks/how_to_migrate_legacy_openscad_designs_to_current_governance.md` - Bring legacy designs into current layout and governance truthfully.
- `playbooks/how_to_review_cad_changes_for_risk_and_regression.md` - Review CAD diffs and downstream consumers for regressions.
- `playbooks/how_to_create_and_use_openscad_sections_probes_and_crops.md` - Produce governed temporary inspection geometry.
- `playbooks/how_to_record_cad_verification_and_artifact_provenance.md` - Record reproducible structural and artifact evidence.
- `playbooks/how_to_modify_and_regression_test_cad_build_automation.md` - Protect build-script CLI, safety, and provenance contracts.
- `playbooks/how_to_model_real_world_interfaces_from_photos_and_measurements.md` - Convert incomplete physical references into explicit parametric assumptions.
- `playbooks/how_to_design_and_validate_fit_clearances_and_tolerance_stacks.md` - Verify functional clearances independently from structure and epsilon.
- `playbooks/how_to_create_fit_test_coupons_and_partial_prints.md` - Validate risky interfaces with production-derived test prints.
- `playbooks/how_to_apply_physical_print_feedback_to_a_new_revision.md` - Turn measured print feedback into traceable new revisions.
- `playbooks/how_to_design_split_print_parts_and_verify_reassembly.md` - Split oversized parts while preserving alignment and load paths.
- `playbooks/how_to_design_and_verify_fasteners_mounting_bosses_and_recesses.md` - Verify complete hardware, boss, and tool envelopes.
- `playbooks/how_to_design_and_verify_mating_sliding_and_moving_parts.md` - Verify installation and swept envelopes for moving assemblies.
- `playbooks/how_to_verify_print_orientation_supports_and_build_volume.md` - Validate transformed bounds, orientation, supports, and layer behavior.
- `playbooks/troubleshooting_openscad_cli_render_and_export_failures.md` - Diagnose toolchain, CGAL, render, and export failures.
- `playbooks/how_to_recover_missing_stale_or_untrusted_cad_artifacts.md` - Rebuild governed outputs without mixing or rewriting revisions.
- `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md` - Classify printable, reference, preview, cutter, and probe geometry.
- `playbooks/how_to_migrate_design_todos_and_revision_plans_into_host_plans.md` - Move unfinished design work into the host plan lifecycle.

For any load-bearing, enclosure, mounting, rail, rim, lip, boss, or joined CAD
geometry, the structural-joins playbook is mandatory.

## 7. References and Templates Index

Operational references:

- `references/interaction_checkpoints_and_automation_boundaries.md` - Approval and automation boundaries.
- `references/verification_patterns_for_docs_and_policy.md` - Usability checks for policy artifacts.

Engineering domain references remain under `reference/` and are not upstream
framework overrides.

Templates:

- `templates/task_execution_plan.md` - Required plan shape and checklist syntax.
- `templates/change_plan.md` - Proposal and approval summary.
- `templates/submodule_update_synthesis_report.md` - Three-way framework update decisions.
- `templates/daily_journal_entry.md` - Journal ownership and checkpoint fields.
- `templates/downtime_report.md` - Report-only maintenance findings.

## 8. Project Organization

Keep the documented repository layout synchronized with `README.md`:

- `agents/`: pinned upstream agent-framework submodule.
- `plans/future|current|past/`: host-owned task plans and indexes.
- `journal/`: host-owned daily checkpoint records.
- `downtime/reports/pending|reviewed/`: optional maintenance reports.
- `playbooks/`, `references/`, `templates/`: host-managed agent workflows.
- `reference/`: project engineering reference material.
- `scripts/`: automation, including CAD tools.
- `designs/`: committed OpenSCAD source and configs.
- `output/`: generated current/scratch outputs.
- `revisions/`: generated numbered snapshots.
- `.tmp/scad/`: generated probes, sections, staging, and partial builds.

Artifact directory names are fixed:

- `output/<design>/` is the only current/scratch destination.
- `revisions/<design>/rev_000N/` is the only numbered revision destination.
- `.tmp/scad/<design>/` is the only probe, section, partial-build, or staging destination.
- Never create `output/<design>_rev_000N/` or another ad hoc artifact directory.
- Never place `.scad` source or probe files in `output/` or `revisions/`.
- Generated `output/` and `revisions/` files must not be committed.

For multi-part designs with `designs/<design>/parts.json`, use
`scripts/scad_build_all.py`. A directory is not a complete/current build unless
its `build_manifest.json` passes `--audit-only`.

## 9. Logging and Debugging

Favor scripts that print explicit executable paths, inputs, and outputs. New
automation must emit enough context to diagnose path, config, and artifact issues.

## 10. Structural CAD Governance

These rules apply unless a design documents stricter requirements:

- Define `minimum_wall_thickness` explicitly.
- Define `minimum_structural_overlap` explicitly and require it to be at least
  `minimum_wall_thickness`.
- Every structural join needs positive-volume intersection with at least the
  named minimum overlap. Coplanar faces, shared edges, tangent contact, visual
  proximity, and numerical epsilon overlaps are not structural joins.
- Structural overlap must continue across the full seam and survive subsequent
  `difference()` operations.
- The remaining load path or throat at a join must not be thinner than
  `minimum_wall_thickness`.
- No internal edge, rim, rail, flange, web, bridge, land, or material strip may
  be narrower than `minimum_wall_thickness`.
- Material between a void and an exterior edge, or between two voids, must meet
  the minimum thickness by the shortest path through solid material.
- Fastener holes, recesses, chamfers, and other subtractions must preserve the
  minimum internal edge margin.
- For multiple cuts in one structural member, inventory every pair whose projected
  bounds approach or overlap and assert each post-subtraction ligament. Outer-edge
  checks alone are insufficient.
- Use named dimensions and `assert()` statements. Do not rely on coordinates that
  merely appear to meet.
- A successful render or manifold STL does not prove structural overlap. Perform
  required sectional and connectivity checks.
- Identify intentionally separate parts and decorative disconnected geometry.
  Unexpected disconnected shells fail verification.
- Do not call a design print-ready or fabrication-ready until verification is
  documented for the exact revision/config.
- Treat pre-governance designs as structurally unverified until audited.

## 11. Artifact Governance

- A part manifest is authoritative for exported part names and completeness.
- Complete builds render into `.tmp/scad/<design>/` first.
- Validate the exact expected set before replacing `output/<design>/` as one unit.
- Reject missing, unexpected, duplicate, stale, or hash-mismatched artifacts.
- Record config, parts-manifest, OpenSCAD source-tree, Git, and artifact hashes in
  `build_manifest.json`.
- Numbered revisions are immutable; geometry or config changes require a new one.
- Revision-like filenames are not provenance. A passing manifest audit is.
- Single-part builds are partial and must not be represented as complete outputs.

## 12. Completion Summary Requirements

Every final task summary must include:

- Active plan path and checklist/lifecycle changes, or `not applicable`.
- Structural joins: `passed`, `failed`, `unverified`, or `not applicable`.
- Minimum internal edge/material width: the same status vocabulary.
- Exact revision/config reviewed when CAD geometry changed.

When CAD artifacts were built, also report:

- Build scope: single part or complete manifest.
- Exact destination.
- Expected and actual STL/PNG counts.
- Artifact audit result.
- Config and source provenance result.
