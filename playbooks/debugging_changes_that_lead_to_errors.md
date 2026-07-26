# Playbook: Debugging Changes That Lead to Errors

*Status: Draft*

## Objective

Provide an evidence-first workflow for debugging failures caused by changes. The goal is to diagnose using diffs and reproducible experiments before editing more code.

## Prerequisites

- You can reproduce the failure (or describe exactly when/where it occurs)
- You can inspect `git status -sb`, `git diff`, and the full error output

## Step-by-Step Instructions

### 0) Stabilize the Scene (No Fixing Yet)

1. Do not edit files yet.
2. Record the exact failing command and full output.
3. Record expected outcome (one sentence).
4. Record actual outcome (one sentence).

### 1) Reflect on What Changed

1. Run `git status -sb`.
2. Run `git diff` (and `git diff --staged` if relevant).
3. Create an evidence list:
   - files changed
   - key functions/modules affected
   - config/build changes
4. Restate the original intention of the change.
5. Compare intention vs reality in 3-5 sentences.

### 2) Reproduce Reliably and Minimize Variables

1. Re-run the failing command exactly.
2. If intermittent, run it multiple times and compare outputs.
3. Find the smallest reproducible case (single module/config if possible).

### 3) Categorize the Failure

Pick the best match:

- Syntax / parse error
- Type / API contract error
- Logical error
- State / environment issue
- Integration mismatch
- Test expectation mismatch
- Structural connectivity / insufficient overlap
- Structural thinning / insufficient internal edge width

### 4) Generate Multiple Hypotheses (Before Fixing)

1. Produce at least 3 plausible hypotheses.
2. For each hypothesis, list:
   - supporting evidence
   - refuting evidence
   - cheapest experiment to test it

### 5) Run the Smallest Experiments

1. Execute the cheapest experiment for one hypothesis.
2. Record: experiment -> result -> conclusion
3. Repeat until a likely cause is identified.

### 6) Identify the Smallest Safe Fix

1. Propose the minimal change.
2. Explicitly list:
   - files to change
   - active-plan checklist items that authorize the fix
   - required plan revisions if the current scope is insufficient
   - verification plan
   - docs/playbook updates required

### 7) Plan & Request Approval

Before implementing:

- present evidence summary
- list hypotheses tested and outcomes
- propose the minimal fix
- identify the active plan path and checklist items
- ask for approval

### 8) Execute the Fix

1. Apply the minimal change.
2. Execute only the approved active-plan scope; pause if evidence requires expansion.
3. Add/adjust logging only if it improves future diagnosis.
4. Keep the change atomic.

### 9) Verify

1. Re-run the failing command/test.
2. Run the smallest relevant test/build suite.
3. Confirm the error is gone and the outcome matches expectations.

### 10) Prevent Recurrence

1. Update docs/playbooks where future-you will see them first.
2. Add a short "known failure mode" note if this is likely to recur.
3. For CAD connectivity failures, follow `playbooks/how_to_design_and_verify_structural_openscad_joins.md` and add named overlap assertions at the construction boundary.

### Known CAD Failure Mode: Near But Not Joined

OpenSCAD can render and export geometry that appears visually connected while an intended structural interface has only:

- a shared edge
- a coplanar face
- tangent contact
- a tiny epsilon-sized intersection
- an overlap removed by a later `difference()`

These are structural failures even when the STL is manifold or a slicer accepts it. Diagnose them by inspecting side sections at multiple positions along the seam, checking the named overlap dimensions, and auditing unexpected disconnected positive-volume shells. The minimum structural overlap must be at least the design's minimum wall thickness.

Also inspect every internal rim, rail, flange, web, bridge, fastener margin, and strip of material around or between voids. A join may be connected but still fail because a subtraction or angled intersection leaves a local material width below `minimum_wall_thickness`.

### Known Build Failure Mode: Ambiguous or Stale Artifact Directory

A directory can look like a revision while containing partial, stale, debug, or
mixed-source artifacts. A revision suffix in a directory or filename does not
establish provenance.

Required diagnosis:

1. Accept only `output/<design>/`, `revisions/<design>/rev_000N/`, or
   `.tmp/scad/<design>/`.
2. Reject `.scad` probes under `output/` and `revisions/`.
3. For manifest-driven designs, run `scad_build_all.py --audit-only`.
4. Compare exact artifact names and counts with `parts.json`.
5. Verify config, parts-manifest, source-tree, and artifact hashes from
   `build_manifest.json`.
6. If any check fails, treat the entire directory as non-authoritative. Rebuild
   into staging and replace the destination as one unit; do not copy selected
   files over the suspect directory.

### 11) Git Hygiene

Follow `playbooks/how_to_commit_and_push_changes.md`.
Update the active plan and today's journal before committing.

## Verification

- The original failure is no longer reproducible
- Evidence log explains why the fix works
- Documentation/playbooks were updated if the workflow changed
- Plan indexes pass validation when plan files changed

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification
