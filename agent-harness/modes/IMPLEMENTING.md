# IMPLEMENTING.md

## Purpose

Implementing mode executes an approved Implementation Plan.
Default execution is one plan step at a time.

## Entry

Via CLI: `/execute-plan <plan-file>`
Via natural language: explicit instruction referencing an approved plan.

## Consumes

An Implementation Plan at status `approved` (`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`) whose included
Tasks are `ready`/`planned` (`agent-harness/artifact-specs/TASKS.md`). Per `COR-03-090`, this file's Execution rules
trigger status changes on Task, Plan, Spec, and Use Case (`IMPL-03-030`, `IMPL-03-110`) — load
`agent-harness/artifact-specs/TASKS.md`, `IMPLEMENTATION-PLAN.md`, `SPECS.md`, and `USE-CASES.md` for those
artifacts' own status-transition rules; this file only says when to trigger the change, not what the change
requires.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPL-01-010 | Preconditions | An Implementation Plan exists with status `approved`. |
| IMPL-01-020 | Preconditions | All included Tasks are at status `ready` or `planned`. |
| IMPL-01-030 | Preconditions | Safety and risk rules are satisfied. |
| IMPL-02-010 | Gate-Attestation | Before the first file mutation of a plan step, write a gate-check line to `harness-data/RUN-LOG.md` recording the Plan ID, Plan status, and the Task's `allowed_paths`. Do not proceed to mutation without this line. |
| IMPL-03-010 | Execution | Follow the plan — do not deviate from approved scope. |
| IMPL-03-020 | Execution | Execute one plan step at a time by default. |
| IMPL-03-030 | Execution | Set Task status to `in-progress` when starting a Task, `done` when complete. |
| IMPL-03-040 | Execution | Set Plan status to `in-progress` when execution begins, `done` when all steps are complete. |
| IMPL-03-050 | Execution | Keep the diff focused on the current step. |
| IMPL-03-060 | Execution | Respect allowed and forbidden paths from Task frontmatter. |
| IMPL-03-070 | Execution | Avoid unrelated refactoring. |
| IMPL-03-080 | Execution | Run the planned validation after each step. |
| IMPL-03-090 | Execution | Follow the suggested commit boundaries defined in the plan. |
| IMPL-03-100 | Execution | Summarize results per Task or plan step. |
| IMPL-03-110 | Execution | Before marking a plan step done, verify that every acceptance criterion in the Spec is covered by either: (a) an entry in `test_refs` in the Spec frontmatter pointing to an existing test file, or (b) a validation command in the Task frontmatter that exercises that criterion. A plan step is not done until this is satisfied. |
| IMPL-03-120 | Execution | Stop if validation fails outside the expected scope. |
| IMPL-03-130 | Execution | Stop if missing or contradictory requirements are discovered. |
| IMPL-03-140 | Execution | Stop if a high-risk area is encountered that was not covered by the plan. |
| IMPL-03-150 | Execution | When a Plan's status changes (`in-progress`, `done`), or when every Task derived from a Spec reaches `done`, follow `IMPLEMENTATION-PLAN.md`'s own status-transition rules for CATALOG bookkeeping and the Spec/Use-Case status cascade. |
| IMPL-04-010 | Batch | Batch implementation is allowed only when explicitly planned and approved. High-risk tasks must remain separate unless explicitly approved. |
| IMPL-05-050 | Boundaries | Do not continue past a failing validation without explicit approval. |
| IMPL-06-010 | Procedure | Before substantive execution, load any relevant playbook or guide required by the task shape or local project context. Playbooks and guides may refine execution steps and checks, but they do not expand approved scope or override plan boundaries (`COR-04-070`). |

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
