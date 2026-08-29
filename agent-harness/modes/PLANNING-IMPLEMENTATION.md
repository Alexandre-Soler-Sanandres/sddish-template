# PLANNING-IMPLEMENTATION.md

## Purpose

Planning-Implementation is the mandatory gate before code changes. These commands do not mean "start coding
now" — they mean "create a plan and wait for approval."

## Mode Story

A Task, Spec, or Use Case (or, for the Plan-tier entry, no upstream artifact at all) needs implementation
guidance. The agent loads the selected chain at its current status, checks for existing Tasks so it never duplicates
planning work, records readiness facts and dependencies, drafts a focused Implementation Plan, and stops — waiting
for an explicit promotion request before any code changes. Every entry point ends the same way: draft Plan
produced, no code touched.

## Operating Posture

Planning, not a gateway to typing code immediately. Verify that the selected chain is sufficient to make a useful
plan, and record its current dependencies and readiness facts. An upstream draft or blocked status never blocks
Plan creation; it is assessed again when an operator requests Plan promotion. Once the draft Plan exists, the
mode's job is done until that request arrives.

## When To Use

Use Planning-Implementation when an existing Task, Spec, or Use Case needs implementation guidance, regardless of
its current status, or when Refining's/Partnering's risk-tier cascade classifies a request as needing no upstream artifact at all
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
2. Record the Task's current status, dependencies, and implementation-readiness facts in the Plan; do not treat
   them as Plan-creation blockers.
3. Create a focused Implementation Plan for that Task.
4. Wait for an explicit promotion request — do not change code.

### Entering via `/plan-spec`

1. Load the Spec.
2. Record the Spec's current status, dependencies, and implementation-readiness facts in the Plan; do not treat
   them as Plan-creation blockers.
3. Find existing Tasks and record their current status, dependencies, and implementation-readiness facts:
   - If Tasks exist → use them as the planning basis, regardless of current status.
   - If no Tasks exist → apply the Task Decision Matrix (`IPL-03-020`).
   - If Tasks are required but missing → stop and route to `/create-tasks`.
   - If Tasks are not required → create an inline Implementation Plan.
4. Do not generate duplicate Tasks or ignore existing ones.
5. Create the Implementation Plan.
6. Wait for an explicit promotion request — do not change code. Before that promotion, record the Plan's scoped
   parent readiness and run Validation's `chain-preflight` profile; record its durable report in `## Chain
   Preflight`.

### Entering via `/plan-use-case`

1. Load the Use Case.
2. Record the Use Case's current status, dependencies, and implementation-readiness facts in the Plan; do not
   treat them as Plan-creation blockers.
3. Find all derived Specs from the Use Case frontmatter.
   - If Specs are missing → stop and route to `/create-spec`.
4. For each Spec, record its current status, dependencies, and implementation-readiness facts. Then find existing
   Tasks and record the same facts:
   - If Tasks exist → use them as the planning basis, regardless of current status.
   - If no Tasks exist → apply the Task Decision Matrix (`IPL-03-020`).
   - If Tasks are required but missing → stop and route to `/create-tasks`.
5. Do not generate duplicate Tasks or ignore existing ones.
6. Create a coherent end-to-end Implementation Plan covering all derived Specs.
7. Wait for an explicit promotion request — do not change code. Before that promotion, record the Plan's scoped
   parent readiness and run Validation's `chain-preflight` profile; record its durable report in `## Chain
   Preflight`.

### Entering via direct instruction (no Use Case/Spec/Task file named)

1. Reuse an existing classification or run the cascade fresh (`IPL-08-010`/`IPL-08-011`).
2. If above Plan-tier, stop and route to Refining instead (`IPL-08-020`/`IPL-08-021`).
3. If at Plan-tier, create the Implementation Plan (`IPL-08-022`).
   - If no Spec participates, include the compact `## Behavior Contract` required by the Plan contract instead of
     inventing a full Spec.
4. Run Validation's `chain-preflight` profile when a chain exists, or `artifact-readiness` against the Plan
   itself when no higher-tier artifact participates; record the resulting durable report in the Plan's
   `## Chain Preflight` section when preflight was used.
5. Wait for approval; do not change code (`IPL-08-023`/`IPL-08-024`).

## Routing

If the cascade lands above Plan-tier, stop, report which tier is actually required, and route to the matching
Refining entry point (`/create-use-case`, `/create-spec`, or `/create-tasks`) — do not proceed to planning
(`IPL-08-020`/`IPL-08-021`). A missing-Tasks precondition inside `/plan-spec` or `/plan-use-case` routes to
`/create-tasks` instead.

## Outputs

An Implementation Plan under `harness-data/artifacts/implementation-plans/active/PLAN-*.md`, per
`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`, with its required validation state recorded before
awaiting approval.

## Examples

"Plan the implementation for the Dockerfile chown fix" with no Task/Spec/Use Case named: the agent runs the
risk-tier cascade, finds it lands at Plan-tier, creates an Implementation Plan with `entrypoint_type: none`, and
waits for approval rather than making the fix directly. That Plan includes a compact `## Behavior Contract`
capturing the expected change, preserved behavior, and observable proof.

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
