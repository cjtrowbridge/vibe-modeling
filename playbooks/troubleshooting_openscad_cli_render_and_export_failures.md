# Playbook: Troubleshoot OpenSCAD CLI, Render, and Export Failures

*Status: Stable*

## Objective

Diagnose OpenSCAD discovery, invocation, parsing, assertion, CGAL, rendering, and
artifact failures from reproducible evidence before changing geometry or scripts.

## Procedure

1. Capture the exact command, working directory, resolved executable, config,
   source entrypoint, stdout/stderr, exit code, and expected output paths.
2. Re-run with the smallest applicable command: executable version, build
   `--dry-run`, one part, one STL render, then one preview.
3. Classify the failure:
   - executable/path/permission;
   - shell quoting or `-D` define parsing;
   - missing include/use/file;
   - OpenSCAD syntax or assertion;
   - CGAL/non-manifold/degenerate geometry;
   - timeout/resource exhaustion;
   - camera/PNG generation;
   - staging, naming, count, hash, or installation failure.
4. Compare the printed command with a known passing design/config.
5. Test at least three plausible causes with the cheapest read-only or temporary
   experiment under `.tmp/scad/<design>/`.
6. If geometry is implicated, use sections/probes and the structural playbook.
7. If automation is implicated, use the build-automation playbook and test failure
   paths before applying an approved fix.
8. Preserve the original error and evidence in the plan or revision note.

## Verification

- The original command either passes or fails for a newly understood reason.
- The minimal reproduction and causal experiment are documented.
- A fix does not suppress assertions, skip artifacts, or bypass audit gates.

## Plan Binding

Diagnosis may remain read-only. Implementation requires an approved fix item with
files, cause, regression tests, and documentation updates.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
