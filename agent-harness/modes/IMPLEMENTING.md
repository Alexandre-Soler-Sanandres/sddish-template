# IMPLEMENTING.md

## Purpose

Implementing mode executes an approved Implementation Plan.
Default execution is one plan step at a time.

## Entry

Via CLI: `/execute-plan <plan-file>`
Via natural language: explicit instruction referencing an approved plan.

## Consumes

An Implementation Plan at status `approved` (`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`) whose included
Tasks are `ready`/`planned` (`agent-harness/artifact-specs/TASKS.md`). Per `COR-058`, this file's Execution rules
trigger status changes on Task, Spec, and Use Case (`IMPL-006`, `IMPL-014`, `IMPL-027`) — load
`agent-harness/artifact-specs/TASKS.md`, `SPECS.md`, and `USE-CASES.md` for those artifacts' own status-transition
rules; this file only says when to trigger the change, not what the change requires.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPL-001 | Preconditions | An Implementation Plan exists with status `approved`. |
| IMPL-002 | Preconditions | All included Tasks are at status `ready` or `planned`. |
| IMPL-003 | Preconditions | Safety and risk rules are satisfied. |
| IMPL-028 | Gate-Attestation | Before the first file mutation of a plan step, write a gate-check line to `harness-data/RUN-LOG.md` recording the Plan ID, Plan status, and the Task's `allowed_paths`. Do not proceed to mutation without this line. |
| IMPL-004 | Execution | Follow the plan — do not deviate from approved scope. |
| IMPL-005 | Execution | Execute one plan step at a time by default. |
| IMPL-006 | Execution | Set Task status to `in-progress` when starting a Task, `done` when complete. |
| IMPL-007 | Execution | Set Plan status to `in-progress` when execution begins, `done` when all steps are complete. |
| IMPL-026 | Execution | When a Plan's status changes into or out of `in-progress` (including to `done`), update its row in the `harness-data/CATALOG.md` Active Implementation Plans table in the same pass (`IPL-016`); remove the row once the Plan is no longer `approved` or `in-progress`. |
| IMPL-027 | Execution | When a Plan reaches status `done` and every Task derived from a Spec is `done`, set that Spec's status to `implemented`. When every Spec derived from a Use Case is `implemented`, set the Use Case's status to `implemented`. |
| IMPL-008 | Execution | Keep the diff focused on the current step. |
| IMPL-009 | Execution | Respect allowed and forbidden paths from Task frontmatter. |
| IMPL-010 | Execution | Avoid unrelated refactoring. |
| IMPL-011 | Execution | Run the planned validation after each step. |
| IMPL-012 | Execution | Follow the suggested commit boundaries defined in the plan. |
| IMPL-013 | Execution | Summarize results per Task or plan step. |
| IMPL-014 | Execution | Before marking a plan step done, verify that every acceptance criterion in the Spec is covered by either: (a) an entry in `test_refs` in the Spec frontmatter pointing to an existing test file, or (b) a validation command in the Task frontmatter that exercises that criterion. A plan step is not done until this is satisfied. |
| IMPL-015 | Execution | Stop if validation fails outside the expected scope. |
| IMPL-016 | Execution | Stop if missing or contradictory requirements are discovered. |
| IMPL-017 | Execution | Stop if a high-risk area is encountered that was not covered by the plan. |
| IMPL-018 | Batch | Batch implementation is allowed only when explicitly planned and approved. High-risk tasks must remain separate unless explicitly approved. |
| IMPL-019 | Boundaries | Do not implement beyond the approved plan scope. |
| IMPL-020 | Boundaries | Do not skip planned validation steps. |
| IMPL-021 | Boundaries | Do not refactor unrelated code. |
| IMPL-022 | Boundaries | Do not modify files outside the allowed paths defined in Task frontmatter. |
| IMPL-023 | Boundaries | Do not continue past a failing validation without explicit approval. |
| IMPL-024 | Procedure | Before substantive execution, load any relevant playbook or guide required by the task shape or local project context. |
| IMPL-025 | Procedure | Playbooks and guides may refine execution steps and checks, but they do not expand approved scope or override plan boundaries. |

## Output

Implementing does not produce a new artifact type of its own — it updates Task/Plan/Spec/Use Case status
(`IMPL-006`, `IMPL-007`, `IMPL-027`) and the code itself. When a durable record is needed (e.g. before a status
advance that should be citable later), it produces the product/requirements flavor of Review
(`agent-harness/artifact-specs/REVIEW.md`'s Two Flavors) — not required for every plan step, only when a formal
record is warranted.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/QUALITY.md` — always load when running validation after a plan step; defines the definition of done and technical quality standards
- `harness-data/reference/TOOLING.md` — always load when running validation commands; defines the actual commands to execute
- `harness-data/reference/ARCHITECTURE.md` — when verifying allowed paths or architectural boundaries during execution
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
