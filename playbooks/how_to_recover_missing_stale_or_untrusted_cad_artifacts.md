# Playbook: Recover Missing, Stale, or Untrusted CAD Artifacts

*Status: Stable*

## Objective

Restore authoritative CAD outputs from committed source and configs without
mixing files, trusting revision-like names, or rewriting immutable history.

## Procedure

1. Classify the target as mutable `output/<design>/` or immutable
   `revisions/<design>/rev_000N/`.
2. Inventory files, expected manifest entries/counts, `build_manifest.json`, and
   config/source/manifest/artifact hashes. Do not delete or overlay anything yet.
3. Reject authority if files are missing, unexpected, stale, duplicated,
   hash-mismatched, or lack required provenance.
4. Confirm the committed config and source tree intended to produce the set.
5. For current output, perform a complete staged rebuild inside the design's
   output directory and promote it transactionally through `scad_build_all.py`.
6. Never patch selected artifacts into a complete set.
7. Do not rebuild into an existing immutable revision. Preserve the suspect set
   as evidence and either restore an exact verified backup with explicit approval
   or publish a new numbered revision.
8. Re-run `--audit-only` and record recovered counts and provenance.

## Verification

- Recovery originates from identified source/config/manifest inputs.
- The complete expected set and all hashes pass after recovery.
- No immutable revision was silently overwritten.
- The final summary distinguishes restored current output from new revision output.

## Plan Binding

The recovery plan must name the suspect destination, evidence-preservation step,
authoritative inputs, replacement method, and immutable-history decision.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
