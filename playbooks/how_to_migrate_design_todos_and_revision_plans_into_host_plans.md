# Playbook: Migrate Design TODOs and Revision Plans Into Host Plans

*Status: Stable*

## Objective

Move actionable future work into `plans/` while preserving design-local executed
plans, revision evidence, and explicitly user-only notes as historical records.

## Procedure

1. Inventory design TODOs, roadmaps, open questions, proposed plans, executed
   plans, revision notes, and user-only files.
2. Classify each item as active work, future work, completed history, superseded
   history, reference, or user-only text.
3. Never infer agent instructions from a file that says agents must ignore it.
4. Preserve executed revision plans and evidence under design docs; they explain
   exact geometry history and should not be moved into active host plans.
5. Create one host plan per coherent unfinished objective using the current plan
   schema. Copy user-authored task wording verbatim when identity matters.
6. Link the host plan back to source design documents and record migration
   traceability before removing or shortening roadmap text.
7. Ask the user about ambiguous status, ownership, or supersession rather than
   silently closing work.
8. Regenerate plan indexes and validate every link.

## Verification

- Every migrated item has a source-to-plan trace.
- Executed revision history remains in the design documentation.
- User-only files and wording retain their ownership and content.
- No item is both active in `plans/current/` and presented as an unclassified TODO.

## Plan Binding

The migration itself requires an approved plan listing source files, destination
plans, preserved history, and proposed closures.

## Lifecycle Compliance

Prompt -> Select/Create Plan -> Request approval -> Execute approved plan items -> Plan update -> Docs/journal update -> Verification.
