---
plan_id: 2026-07-29-19-44-02_unify-cad-artifacts-in-design-output
title: Unify CAD Artifacts in Each Design Output Directory
summary: Remove temporary artifact destinations, install multipart assembly exports beside printable artifacts, and audit one complete output set per design.
status: past
created_at: 2026-07-29-19-44-02
---

# Unify CAD Artifacts in Each Design Output Directory

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

The user approved this correction on 2026-07-29 after identifying that the
combined Cyberdeck-2 STL was hidden under `.tmp/scad/`. All current artifacts
must finish in the single canonical `output/<design>/` directory. No completed,
review, probe, section, partial-build, or staging artifact may remain under a
temporary artifact tree.

## 1. Correct Host Artifact Policy

- [x] 1.1 Make `output/<design>/` the sole mutable artifact tree, including
  printable parts, assembly exports, review renders, probes, sections, coupons,
  and transient staging while a build is running.
- [x] 1.2 Remove `.tmp/scad/` as an allowed artifact destination from host
  governance, playbooks, references, templates, and user-facing documentation.
- [x] 1.3 Require successful commands to remove internal staging directories and
  leave one flat, exact, audited current artifact set.

## 2. Unify the Build and Assembly Pipelines

- [x] 2.1 Move complete-build staging inside `output/<design>/`, preserve
  staging-before-promotion and rollback behavior, and remove staging on success
  or failure.
- [x] 2.2 Install declared assembly PNG/STL exports and
  `assembly_review_manifest.json` directly into `output/<design>/`.
- [x] 2.3 Make printable and assembly audits tolerate only the mutually declared
  files in the one output tree, reject undeclared files and directories, and
  validate hashes for both manifests.
- [x] 2.4 Preserve immutable revision behavior and clearly reject unsupported
  assembly installation outside the current design output.

## 3. Regression-Test the Contract

- [x] 3.1 Add tests for unified expected sets, missing/unexpected/hash-mismatched
  artifacts, stale manifests, and staging cleanup/rollback helpers.
- [x] 3.2 Verify Python syntax, CLI help, unit tests, path safety, dry runs,
  complete build audit, assembly audit, and plan indexes.
- [x] 3.3 Confirm no CAD artifact remains anywhere under `.tmp/scad/` after the
  successful build and review.

## 4. Rebuild and Review Cyberdeck-2

- [x] 4.1 Rebuild the complete printable manifest through the corrected normal
  pipeline into `output/cyberdeck-2/`.
- [x] 4.2 Render the full assembly set into the same directory, including
  `cyberdeck_2_assembled.stl`, then audit the unified exact set.
- [x] 4.3 Inspect the actual combined STL and representative installed views;
  record exact counts, bounds, and provenance.

## 5. Document and Close

- [x] 5.1 Update affected design validation/provenance records and the daily
  journal with the corrected output contract and rebuilt hashes.
- [x] 5.2 Archive this plan, regenerate/check indexes, review the complete diff,
  and commit all changes. Do not push unless requested.

## Planned Files

- `AGENTS.md`, `README.md`
- affected `playbooks/*.md`, `references/**/*.md`, and `templates/*.md`
- `scripts/scad_build.py`, `scripts/scad_build_all.py`,
  `scripts/scad_render_assembly_review.py`, and applicable wrappers
- `tests/test_scad_build_views.py`, `tests/test_cad_assembly_contract.py`, and
  focused new build-pipeline tests if needed
- `designs/cyberdeck-2/README.md` and `designs/cyberdeck-2/docs/*.md`
- this plan, plan indexes, and `journal/2026-07-29.md`

## Verification and Rollback

The current output remains authoritative until a newly rendered staged set
passes exact-name, byte-size, hash, source, config, manifest, assembly-contract,
and geometry-export checks. On failure, staging is removed and the prior current
artifacts remain untouched. Immutable `revisions/` are not modified.
