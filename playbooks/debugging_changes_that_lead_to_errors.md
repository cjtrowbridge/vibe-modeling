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
   - verification plan
   - docs/playbook updates required

### 7) Plan & Request Approval

Before implementing:

- present evidence summary
- list hypotheses tested and outcomes
- propose the minimal fix
- ask for approval

### 8) Execute the Fix

1. Apply the minimal change.
2. Add/adjust logging only if it improves future diagnosis.
3. Keep the change atomic.

### 9) Verify

1. Re-run the failing command/test.
2. Run the smallest relevant test/build suite.
3. Confirm the error is gone and the outcome matches expectations.

### 10) Prevent Recurrence

1. Update docs/playbooks where future-you will see them first.
2. Add a short "known failure mode" note if this is likely to recur.

### 11) Git Hygiene

Follow `playbooks/how_to_commit_and_push_changes.md`.

## Verification

- The original failure is no longer reproducible
- Evidence log explains why the fix works
- Documentation/playbooks were updated if the workflow changed

## Lifecycle Compliance

Prompt -> Plan (based on a known playbook) -> Request approval -> Execute -> Plan/playbook update -> Docs update -> Verification
