# Overlapping work

## Prompt and Input State

Two requested changes touch the same code paths or shared contract.

## Allowed Mutations

Conflict assessment, dependency ordering, or explicit user coordination.

## Prohibited Mutations

Parallel conflicting implementation or hidden overlap.

## Minimum Lane

Standard; Assured if shared contract or high-risk surface is involved.

## Durable Artifacts

Work packages with declared conflict/ordering evidence.

## Approval Points

Explicit user resolution before concurrent conflicting execution.

## Risk Controls

Path, dependency, ownership, and merge/rollback analysis.

## Verification Evidence

Conflict check and final combined test evidence.

## Expected Stop Paths

Stop when overlap cannot be safely ordered.

## Objective Assertions

No conflicting work becomes executable without a recorded resolution.
