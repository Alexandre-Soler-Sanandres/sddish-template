# PLANNING-IMPLEMENTATION.md

## Purpose

Planning-Implementation is the mandatory gate before code changes. These commands do not mean "start coding
now" — they mean "create a plan and wait for approval."

## Mode Story

A Task, Spec, or Use Case (or, for the Plan-tier entry, no upstream artifact at all) arrives ready for
implementation planning. The agent verifies the source is at an accepted status, checks for existing Tasks so it
never duplicates planning work, drafts a focused Implementation Plan, and stops — waiting for explicit approval
before any code changes. Every entry point ends the same way: plan produced, approval awaited, no code touched.

## Operating Posture

Gate, not gateway to typing code immediately. Verify preconditions before drafting anything; when a precondition
fails, stop and report rather than proceeding on a best-effort basis. Once the plan exists, the mode's job is done
until approval arrives.

## When To Use

Use Planning-Implementation once a Task, Spec, or Use Case has reached the status this mode requires, or when
Refining's/Partnering's risk-tier cascade classifies a request as needing no upstream artifact at all
(`IPL-08-010`/`IPL-08-020`).

## Workflow Paths

- `/plan-task <task-file>`
- `/plan-spec <spec-file>`
- `/plan-use-case <use-case-file>`
- A direct instruction naming the change, with no Use Case/Spec/Task file named — e.g. "plan the implementation
  for the Dockerfile chown fix." See `IPL-08-010`/`IPL-08-020`.

Consumes: Task, Spec, or Use Case (depending on entry point) — or, for the natural-language entry point, no
upstream artifact at all, per `shared-procs/RISK-TIER.md`'s cascade (`IPL-08-010`). Produces: Implementation Plan.
Per `COR-03-090`, load `agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md` in addition to this file — this file
governs the planning activity, the artifact spec governs the resulting Plan's own body schema and readiness gate.

## Core Moves

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
   - If no Tasks exist → apply the Task Decision Matrix (`IPL-03-020`).
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
   - If no Tasks exist → apply the Task Decision Matrix (`IPL-03-020`).
   - If Tasks are required but missing → stop and route to `/create-tasks`.
5. Do not generate duplicate Tasks or ignore existing ones.
6. Create a coherent end-to-end Implementation Plan covering all derived Specs.
7. Wait for approval — do not change code.

### Entering via direct instruction (no Use Case/Spec/Task file named)

1. Reuse an existing classification or run the cascade fresh (`IPL-08-010`/`IPL-08-011`).
2. If above Plan-tier, stop and route to Refining instead (`IPL-08-020`/`IPL-08-021`).
3. If at Plan-tier, create the Implementation Plan (`IPL-08-022`).
4. Wait for approval; do not change code (`IPL-08-023`/`IPL-08-024`).

## Routing

If the cascade lands above Plan-tier, stop, report which tier is actually required, and route to the matching
Refining entry point (`/create-use-case`, `/create-spec`, or `/create-tasks`) — do not proceed to planning
(`IPL-08-020`/`IPL-08-021`). A missing-Tasks precondition inside `/plan-spec` or `/plan-use-case` routes to
`/create-tasks` instead.

## Outputs

An Implementation Plan under `harness-data/artifacts/implementation-plans/active/PLAN-*.md`, per
`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`, awaiting approval.

## Examples

"Plan the implementation for the Dockerfile chown fix" with no Task/Spec/Use Case named: the agent runs the
risk-tier cascade, finds it lands at Plan-tier, creates an Implementation Plan with `entrypoint_type: none`, and
waits for approval rather than making the fix directly.

## Rules Map

This mode's enforceable rules live in `agent-harness/rules/modes/PLANNING-IMPLEMENTATION.md` (single paired
file — under the 25-rule grouping threshold). Load it alongside this file whenever Planning-Implementation is
the active mode.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining expected file areas or architectural boundaries in the plan
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands per plan step
- `harness-data/reference/DOMAIN.md` — when the plan touches domain-critical areas (payments, security, data integrity)
