# PLANNING-IMPLEMENTATION.md

## Purpose

Planning-Implementation is the mandatory gate before code changes. These commands do not mean "start coding
now" — they mean "create a plan and wait for approval."

## Standard-Lane Boundary

For Standard work, the approved Change Spec embeds the execution steps and is the execution contract; do not
create an Implementation Plan merely to restate those steps. Planning-Implementation remains for Assured work,
Assured chains, and cases where a separately resumable execution plan has independent value.

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

## Rules

| ID | Rule |
| --- | --- |
| IPL-00-011 | MUST NOT create an Implementation Plan for new Standard-lane work solely to duplicate Change Spec plan steps. |
| IPL-03-010 | MUST NOT: change code; treat an upstream `draft` or Plan `draft` status as implementation authorization; or generate duplicate Tasks or skip existing ones. |
| IPL-03-020 | MUST consult `REFINING.md`'s Task Decision Matrix before creating an inline Implementation Plan for a Spec/Use Case with no existing Tasks and record existing Tasks' current status, dependencies, and implementation-readiness facts without treating them as Plan-creation blockers. |
| IPL-04-010 | MUST load the relevant universal and project playbooks before finalizing the plan, when the planning task matches a reusable procedure. |
| IPL-04-020 | MUST reflect required procedure-specific checks or validation from relevant playbooks in the Implementation Plan. |
| IPL-04-021 | When a loaded playbook establishes preserved behavior, regression risk, or baseline evidence, the resulting Spec or Plan MUST carry that forward in its own contract sections rather than leaving it only in conversational output. |
| IPL-04-030 | Before requesting a Plan's promotion to `ready`, Planning-Implementation MUST invoke Validation with the profile required by `CFA-01-040` and record the resulting durable report in the Plan when that profile is `chain-preflight`. |
| IPL-04-031 | Planning-Implementation MUST NOT treat local artifact readiness alone as sufficient when `CFA-01-040` requires `chain-preflight` for the selected chain. |
| IPL-05-030 | MUST NOT allow more than one Implementation Plan at status `ready` or `in-progress` per Spec. For a Plan-tier Plan with `entrypoint_type: none` (no source Spec), this check does not apply — there is no Spec to key it on. |
| IPL-05-031 | For a Plan-tier Plan, `IPL-05-050`'s path-overlap check is the only dedup protection available, so it MUST still be run. |
| IPL-05-040 | Plans on non-overlapping Specs MAY run concurrently without restriction — the check in `IPL-05-010` only ever blocks on the same Spec or overlapping `allowed_paths`. |
| IPL-05-050 | MUST stop, surface the conflict, list both Plan IDs and overlapping paths, and wait for explicit user resolution, if two active Plans have overlapping `allowed_paths` across their Tasks. |
| IPL-05-051 | For a Plan-tier Plan with no Task artifacts, substitute the Plan's own Plan Steps' declared file paths (`## Plan Steps`, `Expected files:`) for "Tasks" `allowed_paths` in `IPL-05-050`'s comparison — the check MUST still run against every other active Plan's Task `allowed_paths` or, symmetrically, their own Plan Steps' file paths if they are also Plan-tier. |
| IPL-07-010 | Before finalizing Implementation Plan steps that reference file paths implied by a structural/foundational accepted ADR (directory layout, workspace/build config, deployment topology), MUST verify those paths/structures actually exist in the repository via a direct filesystem check, not an assumption from the ADR text. |
| IPL-07-011 | If `IPL-07-010`'s check finds a path/structure missing, MUST add an explicit bootstrap step covering only what the plan's own steps need, not a general build-out of everything the ADR describes. |
| IPL-07-020 | Before finalizing an Implementation Plan, MUST verify that any tooling a step's own `## Validation` commands invoke (lint/type-check/test runners, etc.) is provisioned by an earlier step in the same Plan (config present, declared as a dependency) rather than assumed available. |
| IPL-07-021 | If `IPL-07-020`'s check finds provisioning missing, MUST add it to the bootstrap step (or the earliest step that needs it), scoped to only what the plan's own steps actually invoke. |
| IPL-08-010 | When entered by a direct natural-language instruction with no Use Case/Spec/Task file named: if the request (or its cited source Idea/Transcript) already carries a `## Risk-Tier Classification` — whether complete or partial, since Partnering may already have resolved UC- and Spec-Necessity via `PTN-02-110` before routing here — MUST reuse that result and continue the cascade only from its next unrun matrix, per `shared-procs/RISK-TIER.md`'s `RSK-07-011`–`RSK-07-013`. |
| IPL-08-011 | Otherwise MUST run the full cascade (`RSK-02-010` → `RSK-03-010` → `RSK-04-010`) fresh to determine the minimum required tier. This entry point is not always the first opportunity for the request — it commonly is not, since `PARTNERING.md`'s `PTN-02-110` and `REFINING.md`'s `TSK-01-030` both hand off here after already running part or all of the cascade. |
| IPL-08-020 | If the cascade lands above Plan-tier, MUST stop, report which tier is actually required, and route to the matching Refining entry point (`/create-use-case`, `/create-spec`, or `/create-tasks`). |
| IPL-08-021 | MUST NOT proceed to planning when the cascade lands above Plan-tier. |
| IPL-08-022 | If the cascade lands at Plan-tier, MUST create the Implementation Plan, including a `## Risk-Tier Classification` section (`RSK-05-010`) and setting `entrypoint_type: none` since no Task/Spec/Use Case exists. |
| IPL-08-025 | A Plan created under `IPL-08-022` MUST include the compact `## Behavior Contract` required by `IPL-01-032`/`IPL-02-014` rather than escalating to a full Spec solely to capture preserved behavior or proof intent. |
| IPL-08-026 | A direct Plan-tier entry with no higher-tier artifact chain MUST NOT fabricate `chain-preflight`; it uses the single-artifact validation path until a real UC/Spec/Task chain exists. |
| IPL-08-023 | MUST wait for approval, exactly as every other entry point already requires. |
| IPL-08-024 | MUST NOT change code before that approval, exactly as every other entry point already requires. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining expected file areas or architectural boundaries in the plan
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands per plan step
- `harness-data/reference/DOMAIN.md` — when the plan touches domain-critical areas (payments, security, data integrity)
