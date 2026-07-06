# PLANNING-IMPLEMENTATION.md

## Purpose

Planning-Implementation is the mandatory gate before code changes.
These commands do not mean "start coding now" — they mean "create a plan and wait for approval."

## Entry Points

- `/plan-task <task-file>`
- `/plan-spec <spec-file>`
- `/plan-use-case <use-case-file>`

## Consumes

Task, Spec, or Use Case (depending on entry point) — see each entry point's Required Steps below for the exact
precondition. Produces: Implementation Plan. Per `COR-03-090`, load
`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md` in addition to this file — this file governs the planning
activity, the artifact spec governs the resulting Plan's own body schema and readiness gate.

## Required Steps

### Entering via `/plan-task`

1. Load the Task.
2. Verify the Task is at status `ready`. If not, stop and report.
3. Create a focused Implementation Plan for that Task.
4. Wait for approval — do not change code.

### Entering via `/plan-spec`

1. Load the Spec.
2. Verify the Spec is at status `approved`. If not, stop and report.
3. Find existing Tasks and check their status:
   - If ready Tasks exist → use them as the planning basis.
   - If Tasks exist but are draft or blocked → stop and report.
   - If no Tasks exist → apply the task decision matrix (see `agent-harness/modes/REFINING.md`).
   - If Tasks are required but missing → stop and route to `/create-tasks`.
   - If Tasks are not required → create an inline Implementation Plan.
4. Do not generate duplicate Tasks or ignore existing ones.
5. Create the Implementation Plan.
6. Wait for approval — do not change code.

### Entering via `/plan-use-case`

1. Load the Use Case.
2. Verify the Use Case is at status `ready-for-spec`. If not, stop and report.
3. Find all derived Specs from the Use Case frontmatter.
   - If Specs are missing or not at status `approved` → stop and route to `/create-spec`.
4. For each Spec, find existing Tasks and check their status:
   - If ready Tasks exist → use them as the planning basis.
   - If Tasks exist but are draft or blocked → stop and report.
   - If no Tasks exist → apply the task decision matrix (see `agent-harness/modes/REFINING.md`).
   - If Tasks are required but missing → stop and route to `/create-tasks`.
5. Do not generate duplicate Tasks or ignore existing ones.
6. Create a coherent end-to-end Implementation Plan covering all derived Specs.
7. Wait for approval — do not change code.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IPL-03-010 | Boundaries | Do not change code; do not treat `proposed` status as approved; do not proceed if the source artifact is not at an accepted status; do not generate duplicate Tasks or skip existing ones. |
| IPL-04-010 | Procedure | When the planning task matches a reusable procedure, load the relevant universal and project playbooks before finalizing the plan. |
| IPL-04-020 | Procedure | Reflect required procedure-specific checks or validation from relevant playbooks in the Implementation Plan. |
| IPL-05-030 | Parallel-Work | Allow at most one Implementation Plan at status `approved` or `in-progress` per Spec. Plans on non-overlapping Specs may run concurrently without restriction — the check in `IPL-05-010` only ever blocks on the same Spec or overlapping `allowed_paths`. |
| IPL-05-050 | Parallel-Work | If two active Plans have overlapping `allowed_paths` across their Tasks, stop, surface the conflict, list both Plan IDs and overlapping paths, and wait for explicit user resolution. |
| IPL-05-070 | Parallel-Work | Keep `harness-data/CATALOG.md` accurate for all Plans at status `approved` or `in-progress`. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining expected file areas or architectural boundaries in the plan
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands per plan step
- `harness-data/reference/DOMAIN.md` — when the plan touches domain-critical areas (payments, security, data integrity)
