# IMPLEMENTING.md

## Purpose

Implementing mode executes an approved Implementation Plan.
Default execution is one plan step at a time.

## Entry

Via CLI: `/execute-plan <plan-file>`
Via natural language: explicit instruction referencing an approved plan.

## Consumes

An Implementation Plan at status `approved` (`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`) whose included
Tasks are `ready` (`agent-harness/artifact-specs/TASKS.md`). Per `COR-03-090`, this file's Execution rules
trigger status changes on Task, Plan, Spec, and Use Case (`IMPL-03-030`, `IMPL-03-110`) — load
`agent-harness/artifact-specs/TASKS.md`, `IMPLEMENTATION-PLAN.md`, `SPECS.md`, and `USE-CASES.md` for those
artifacts' own status-transition rules; this file only says when to trigger the change, not what the change
requires.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPL-01-010 | Preconditions | An Implementation Plan MUST exist at status `approved`. |
| IMPL-01-020 | Preconditions | All included Tasks MUST be at status `ready`. |
| IMPL-01-030 | Preconditions | Safety and risk rules MUST be satisfied. |
| IMPL-02-010 | Gate-Attestation | MUST write a gate-check line to `harness-data/RUN-LOG.md` before the first file mutation of a plan step, recording the Plan ID, Plan status, and the Task's `allowed_paths`. |
| IMPL-03-010 | Execution | MUST follow the plan — do not deviate from approved scope. |
| IMPL-03-020 | Execution | SHOULD execute one plan step at a time by default. |
| IMPL-03-030 | Execution | MUST set Task status to `in-progress` when starting a Task, `done` when complete. |
| IMPL-03-040 | Execution | MUST set Plan status to `in-progress` when execution begins, `done` when all steps are complete. |
| IMPL-03-050 | Execution | MUST keep the diff focused on the current step. |
| IMPL-03-060 | Execution | MUST respect allowed and forbidden paths from Task frontmatter. |
| IMPL-03-070 | Execution | SHOULD NOT perform unrelated refactoring. |
| IMPL-03-080 | Execution | MUST run the planned validation after each step. |
| IMPL-03-090 | Execution | SHOULD follow the suggested commit boundaries defined in the plan. |
| IMPL-03-100 | Execution | MUST summarize results per Task or plan step. |
| IMPL-03-110 | Execution | MUST verify, before marking a plan step done, that every acceptance criterion in the Spec is covered by either (a) an entry in `test_refs` in the Spec frontmatter pointing to an existing test file, or (b) a validation command in the Task frontmatter that exercises that criterion. |
| IMPL-03-120 | Execution | MUST stop if validation fails outside the expected scope. |
| IMPL-03-130 | Execution | MUST stop if missing or contradictory requirements are discovered. |
| IMPL-03-140 | Execution | MUST stop if a high-risk area is encountered that was not covered by the plan. |
| IMPL-03-150 | Execution | MUST follow `IMPLEMENTATION-PLAN.md`'s own status-transition rules for CATALOG bookkeeping and the Spec/Use-Case status cascade when a Plan's status changes (`in-progress`, `done`), or when every Task derived from a Spec reaches `done`. |
| IMPL-04-010 | Batch | Batch implementation MAY proceed only when explicitly planned and approved. |
| IMPL-04-020 | Batch | High-risk tasks MUST remain separate unless explicitly approved. |
| IMPL-05-050 | Boundaries | MUST NOT continue past a failing validation without explicit approval. |
| IMPL-06-010 | Procedure | MUST load any relevant playbook or guide before substantive execution, when required by the task shape or local project context. See `COR-04-070` for what playbooks/guides may not do. |

## Output

Implementing does not produce a new artifact type of its own — it updates Task/Plan/Spec/Use Case status
(`IMPL-03-030`, `IMPL-03-040`, `IMPL-03-150`) and the code itself. When a durable record is needed (e.g. before a status
advance that should be citable later), it produces the product/requirements flavor of Review
(`agent-harness/artifact-specs/REVIEW.md`'s Two Flavors) — not required for every plan step, only when a formal
record is warranted.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/QUALITY.md` — always load when running validation after a plan step; defines the definition of done and technical quality standards
- `harness-data/reference/TOOLING.md` — always load when running validation commands; defines the actual commands to execute
- `harness-data/reference/ARCHITECTURE.md` — when verifying allowed paths or architectural boundaries during execution
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
