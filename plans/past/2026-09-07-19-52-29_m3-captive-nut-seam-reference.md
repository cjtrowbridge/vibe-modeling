---
plan_id: 2026-09-07-19-52-29_m3-captive-nut-seam-reference
title: Document M3 Captive-Nut Registration Seam Stations
summary: Establish a reusable engineering reference for the retained cyberdeck-2 M3 tongue-and-receiver seam pattern and link it from split-print guidance.
status: past
created_at: 2026-09-07-19-52-29
---

# Document M3 Captive-Nut Registration Seam Stations

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

- [x] 1. Establish the reusable seam-station standard.
  - [x] 1.1 Create an engineering reference defining ownership, M3 hardware envelopes, named parameters, structural constraints, and verification requirements for a captive-nut registration seam station.
- [x] 2. Integrate the standard into governed split-print workflow documentation.
  - [x] 2.1 Link the split-print playbook to the engineering reference and state when this option is appropriate.
  - [x] 2.2 Index the engineering reference in repository policy and user-facing documentation where relevant.
- [x] 3. Record and verify the documentation checkpoint.
  - [x] 3.1 Regenerate and verify plan indexes.
  - [x] 3.2 Add today's append-only journal checkpoint and review the intended diff.

## Approval

- User approved this bounded documentation change on 2026-09-07.
- No CAD geometry, generated artifact, or cyberdeck-2 deletion is in scope.

## Expected Files

- `references/engineering/fasteners/m3_captive_nut_registration_seam_stations.md`
- `playbooks/how_to_design_split_print_parts_and_verify_reassembly.md`
- `AGENTS.md`
- `README.md`
- `plans/past/2026-09-07-19-52-29_m3-captive-nut-seam-reference.md`
- generated plan indexes
- `journal/2026-09-07.md`

## Verification

- Confirmed the reference distinguishes fit clearance, structural engagement, and Boolean epsilon.
- Confirmed the split-print playbook links the seam standard without replacing its process role.
- Passed `python scripts/regenerate_plan_indexes.py --check --repo-root .` before archival; final index verification follows the archive move.
