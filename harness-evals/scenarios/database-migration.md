# Database migration

## Prompt and Input State

Change persisted schema or data semantics.

## Allowed Mutations

Migration design, schema code, tests, rollout/rollback evidence, and approved execution plan.

## Prohibited Mutations

Unapproved migration execution, destructive data action, or schema change without rollback analysis.

## Minimum Lane

Assured.

## Durable Artifacts

Detailed Spec/Plan and migration evidence.

## Approval Points

Explicit high-risk approval before migration implementation or execution.

## Risk Controls

Compatibility, backup/recovery, lock/performance, validation, and rollback strategy.

## Verification Evidence

Migration tests, schema checks, and documented rollback exercise.

## Expected Stop Paths

Stop when rollback, ownership, or environment authority is missing.

## Objective Assertions

No schema/data mutation occurs before high-risk authorization and evidence coverage.
