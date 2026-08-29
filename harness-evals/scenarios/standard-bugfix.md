# Standard bugfix

## Prompt and Input State

Fix a bounded defect in one service with a reproducible test and no public-contract change.

## Allowed Mutations

One Change Spec, affected source/tests, and a bounded implementation plan.

## Prohibited Mutations

Schema, auth, deployment, public contract, and unrelated refactors.

## Minimum Lane

Standard.

## Durable Artifacts

One Change Spec with scope, non-goals, acceptance evidence, and approval record.

## Approval Points

Explicit approval before implementation.

## Risk Controls

State regression behavior and abort/reclassify if scope expands.

## Verification Evidence

Focused failing-then-passing test and relevant static checks.

## Expected Stop Paths

Stop for ambiguity, missing reproduction, conflicting requirements, or broader risk.

## Objective Assertions

No code precedes approval; changed paths match scope; test evidence proves the defect and preservation claim.
