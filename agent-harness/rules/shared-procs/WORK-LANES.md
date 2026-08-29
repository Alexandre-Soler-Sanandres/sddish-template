# Work Lanes Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LAN-01-010 | Classification | MUST classify each new material work scope as Fast, Standard, or Assured before planning or execution. |
| LAN-01-020 | Hard-Floor | MUST classify database/schema or destructive-data work, deployment/infrastructure/CI-CD, public API/data-contract work, security/secrets/auth, payment/financial execution, domain-critical logic, and major architecture changes as Assured. |
| LAN-01-030 | Fast | MUST NOT use Fast unless scope is local, reversible, bounded, unambiguous, has evident verification, and has no hard-floor risk. |
| LAN-01-040 | Approval | MUST record a stated micro-plan before Fast mutation; Standard and Assured MUST record explicit approval with approver, time, and current content hash/blob before implementation. |
| LAN-01-050 | Reclassification | MUST invalidate classification and Standard/Assured approval when intended behavior, non-goals, owner/service/public contract, persistence, deployment, reversibility, allowed paths, or identified risk changes materially; MUST stop, reclassify, and obtain fresh approval before further work. |
| LAN-01-060 | Compatibility | MUST preserve the recorded v1 contract for an active v1 UC/Spec/Task/Plan chain until it is reopened or explicitly migrated. |
