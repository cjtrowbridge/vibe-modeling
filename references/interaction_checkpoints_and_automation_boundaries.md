# Reference: Interaction Checkpoints and Automation Boundaries

## Purpose

Define when an agent should continue autonomously, ask for information, request
approval, or stop because execution would require guessing.

## Default Decision Rule

Before asking the user, check:

1. Can the answer be discovered locally?
2. Is it specified by policy or the active plan?
3. Is the action reversible and low risk?
4. Would guessing materially reduce correctness?

Continue when the answer is knowable and the action is authorized. Ask the
smallest useful question when missing information changes the result.

## Boundaries

### Execution approval

Present the active plan items, affected files, and verification method before
implementation when policy requires approval. Committing and pushing require
their own approval unless the user already granted it explicitly.

### Information gap

Ask only for information that cannot be discovered in the repository or prompt.
Offer concrete choices when they make the tradeoff easier to evaluate.

### Plan divergence

Stop when required work is outside the approved active plan. Propose the smallest
plan revision and request approval before expanding implementation.

### Safety or permission

Explain the purpose of elevated or destructive operations and request the
narrowest permission that permits the work.

## Anti-Patterns

- Asking for approval after making the change.
- Treating every minor command as a checkpoint.
- Continuing through material ambiguity.
- Asking the user to perform safe, automatable discovery.
