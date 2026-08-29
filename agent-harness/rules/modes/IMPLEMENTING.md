# IMPLEMENTING Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPL-01-010 | Preconditions | A Standard Change Spec or an Assured/v1 Implementation Plan MUST exist at status `ready`. |
| IMPL-01-020 | Preconditions | All included Tasks MUST be at status `ready` when the execution contract is an Assured/v1 Implementation Plan. |
| IMPL-01-021 | Preconditions | `IMPL-01-020`'s check MUST be re-verified per Task at the point Implementing starts that specific Task, not only once at the Plan's own start — since `systems/STATUS-TRANSITIONS.md`'s `STT-01-010` downward reset can reset an included Task to `draft` after the Plan was set `ready` without revoking the Plan's own `ready` status. A Task found off `ready` at that point blocks Implementing from acting on it regardless of the Plan's own status. |
| IMPL-01-030 | Preconditions | Safety and risk rules MUST be satisfied. |
| IMPL-02-010 | Gate-Attestation | MUST write a gate-check line to `harness-data/RUN-LOG.md` before the first file mutation of an execution step, recording the execution-contract ID, status, and allowed paths. |
| IMPL-02-011 | Gate-Attestation | If `harness-data/RUN-LOG.md` does not exist when the `IMPL-02-010` gate-check line is due, MUST create it in the same action, immediately before writing that line, keeping its temporary and minimal semantics; MUST NOT backfill earlier history into it. |
| IMPL-03-010 | Execution | MUST follow the plan — do not deviate from approved scope. |
| IMPL-03-020 | Execution | SHOULD execute one plan step at a time by default. |
| IMPL-03-050 | Execution | MUST keep the diff focused on the current step. |
| IMPL-03-060 | Execution | MUST respect allowed and forbidden paths from the current execution contract. |
| IMPL-03-070 | Execution | SHOULD NOT perform unrelated refactoring. |
| IMPL-03-080 | Execution | MUST run the planned validation after each step. |
| IMPL-03-090 | Execution | SHOULD follow the suggested commit boundaries defined in the plan. |
| IMPL-03-100 | Execution | MUST summarize results per Task or plan step. |
| IMPL-03-110 | Execution | MUST verify, before marking a plan step done, that every acceptance criterion in the Spec is covered by either (a) an entry in `test_refs` in the Spec frontmatter pointing to an existing test file, or (b) a validation command in the Task frontmatter that exercises that criterion. |
| IMPL-03-120 | Execution | MUST stop if validation fails outside the expected scope. |
| IMPL-03-130 | Execution | MUST stop if missing or contradictory requirements are discovered. |
| IMPL-03-140 | Execution | MUST stop if a high-risk area is encountered that was not covered by the plan. |
| IMPL-03-150 | Execution | MUST follow `systems/STATUS-TRANSITIONS.md`'s transition tables, and `IMPLEMENTATION-PLAN.md`'s own CATALOG bookkeeping rules (`IPL-05-020`), when a Plan's status changes or when every Task derived from a Spec reaches `done`. |
| IMPL-04-010 | Batch | Batch implementation MAY proceed only when explicitly planned and approved. |
| IMPL-04-020 | Batch | High-risk tasks MUST remain separate unless explicitly approved. |
| IMPL-05-050 | Boundaries | MUST NOT continue past a failing validation without explicit approval. |
| IMPL-06-010 | Procedure | MUST load any relevant playbook or guide before substantive execution, when required by the task shape or local project context. See `COR-04-070` for what playbooks/guides may not do. |
