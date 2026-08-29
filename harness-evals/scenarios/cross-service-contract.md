# Cross-service contract

## Prompt and Input State

Change a service API consumed by another service.

## Allowed Mutations

Contract, producer/consumer work packages, compatibility tests, and migration guidance.

## Prohibited Mutations

Uncoordinated breaking endpoint change or consumer assumptions without evidence.

## Minimum Lane

Assured.

## Durable Artifacts

Spec/Plan-level traceability for both sides and the contract.

## Approval Points

Explicit approval of compatibility/breaking-change policy before execution.

## Risk Controls

Versioning, fallback, rollout/rollback, ownership, and consumer impact assessment.

## Verification Evidence

Contract tests and producer/consumer integration evidence.

## Expected Stop Paths

Stop if ownership, compatibility policy, or rollout authority is absent.

## Objective Assertions

Both sides cite the same contract; breaking changes cannot be silently implemented.
