# IMPLEMENTING.md

## Purpose

Implementing mode executes an approved Standard Change Spec or a `ready` Assured/v1 Implementation Plan. Default
execution is one plan step at a time.

## Mode Story

A `ready` Implementation Plan and its `ready` Tasks exist. The agent attests to the gate before touching any
file, executes the plan one step at a time by default, keeps the diff focused, runs validation after each step,
and updates Task/Plan/Spec/Use Case status as it goes. It stops immediately on unexpected validation failure,
missing/contradictory requirements, or an uncovered high-risk area.

## Operating Posture

Follow the plan; do not deviate from approved scope. Prefer stopping and reporting over improvising past a gap the
plan didn't anticipate — a high-risk surprise or a validation failure outside expected scope is a stop condition,
not a judgment call to push through.

## When To Use

Use Implementing only once a Standard Change Spec exists at status `ready`, or an Assured/v1 Implementation Plan
exists at status `ready` and its included Tasks are `ready` (`IMPL-01-010`/`IMPL-01-020`).

## Workflow Paths

- CLI: `/execute-plan <plan-file>` or `/execute-change <change-spec-file>`
- Natural language: explicit instruction referencing a `ready` execution contract.

Consumes: a Change Spec at status `ready` (`agent-harness/artifact-specs/CHANGE-SPEC.md`) or an Implementation
Plan at status `ready` (`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`)
whose included Tasks are `ready` (`agent-harness/artifact-specs/TASKS.md`). Per `COR-03-090`, this file's
Execution rules trigger status changes on Task, Plan, Spec, and Use Case (`IMPL-03-150`, `IMPL-03-110`) — load
`agent-harness/systems/STATUS-TRANSITIONS.md` for those artifacts' own status-transition mechanics; this file
only says when to trigger the change, not what the change requires.

## Core Moves

1. Write a gate-check line to `harness-data/RUN-LOG.md` before the first file mutation of an execution step, recording
   the execution-contract ID, status, and allowed paths (`IMPL-02-010`). Create `RUN-LOG.md` first if it does
   not yet exist, keeping it minimal — do not backfill earlier history (`IMPL-02-011`).
2. Execute one plan step at a time by default (`IMPL-03-020`), following the plan without deviating from approved
   scope (`IMPL-03-010`).
3. Set a Change Spec to `in-progress` when execution begins and `done` when all embedded steps are complete. For
   Assured/v1 work, set Task status to `in-progress` when starting a Task, `done` when complete; set Plan status to `in-progress`
   when execution begins, `done` when all steps are complete, per `systems/STATUS-TRANSITIONS.md`'s `STT-01-020`
   (`IMPL-03-150`).
4. Keep the diff focused on the current step (`IMPL-03-050`) and respect allowed/forbidden paths from the execution
   contract (`IMPL-03-060`) — no unrelated refactoring (`IMPL-03-070`).
5. Run the planned validation after each step (`IMPL-03-080`); before marking a plan step done, verify every Spec
   acceptance criterion is covered by a `test_refs` entry or a Task-frontmatter validation command that exercises
   it (`IMPL-03-110`).
6. Summarize results per Task or plan step (`IMPL-03-100`), following the plan's suggested commit boundaries
   where given (`IMPL-03-090`).
7. Follow `IMPLEMENTATION-PLAN.md`'s own status-transition rules for CATALOG bookkeeping and the Spec/Use-Case
   status cascade when a Plan's status changes, or when every Task derived from a Spec reaches `done`
   (`IMPL-03-150`).

## Routing

Stop and report — do not push through — if validation fails outside the expected scope (`IMPL-03-120`), missing
or contradictory requirements are discovered (`IMPL-03-130`), or a high-risk area not covered by the plan is
encountered (`IMPL-03-140`); continuing past a failing validation requires explicit approval (`IMPL-05-050`).
Batch implementation may proceed only when explicitly planned and approved; high-risk tasks stay separate unless
explicitly approved (`IMPL-04-010`/`IMPL-04-020`).

## Outputs

Implementing does not produce a new artifact type of its own — it updates the execution contract and, for Assured
work, Task/Plan/Spec/Use Case status
(`IMPL-03-150`) and the code itself. When a durable record is needed (e.g. before a
status advance that should be citable later), it produces the product/requirements flavor of Review
(`agent-harness/artifact-specs/REVIEW.md`'s Two Flavors) — not required for every plan step, only when a formal
record is warranted.

## Examples

Executing step 2 of a `ready` Plan: the agent logs the gate-check line, sets the Task to `in-progress`, makes
the focused change described in that step, runs the planned validation command, confirms the covered acceptance
criteria, and summarizes the result before moving to step 3.

## Rules Map

This mode's enforceable rules live in `agent-harness/rules/modes/IMPLEMENTING.md` (single paired file — under
the 25-rule grouping threshold). Load it alongside this file whenever Implementing is the active mode.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/QUALITY.md` — always load when running validation after a plan step; defines the definition of done and technical quality standards
- `harness-data/reference/TOOLING.md` — always load when running validation commands; defines the actual commands to execute
- `harness-data/reference/ARCHITECTURE.md` — when verifying allowed paths or architectural boundaries during execution
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
