# CHANGE-SPEC Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| CHG-01-010 | Scope | MUST use a Change Spec as the default durable execution contract for Standard work. |
| CHG-01-020 | Content | MUST record expected and preserved behavior, scope, non-goals, paths, steps, approval provenance, and acceptance-to-evidence mapping. |
| CHG-01-030 | Approval | MUST NOT move a Change Spec to `ready` without explicit approval tied to current content hash/blob. |
| CHG-01-040 | Lifecycle | MUST stale approval and return to `draft` when `LAN-01-050` material inputs change. |
| CHG-01-050 | Readiness | MUST identify requirements and acceptance criteria with stable local IDs and map every acceptance criterion to planned verification evidence before moving to `ready`. |
| CHG-01-060 | Execution | MUST record execution progress and closeout evidence in the Change Spec; a clean routine self-review MUST be recorded there rather than creating a Review. |
| CHG-01-070 | Conditional Artifacts | MUST reference a separately created Use Case, Task, Plan, Transcript, Idea, or Review only when that artifact satisfies its own conditional-creation rule. |
