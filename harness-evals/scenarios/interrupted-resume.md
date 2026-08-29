# Interrupted resume

## Prompt and Input State

Resume a partially completed approved change after context loss.

## Allowed Mutations

Read current durable state, record restart facts, and continue only after revalidation.

## Prohibited Mutations

Continuation from conversation memory alone or unverified assumptions.

## Minimum Lane

The original lane.

## Durable Artifacts

Existing work package plus concise restart state where needed.

## Approval Points

Reuse approval only if scope/content/provenance remains current; otherwise request renewed approval.

## Risk Controls

Recheck status, scope, prior validation, and changed dependencies.

## Verification Evidence

Recorded restart point and rerun stale checks.

## Expected Stop Paths

Stop if source state changed or restart facts are insufficient.

## Objective Assertions

The resumed work identifies its exact restart point and never implements from stale state.
