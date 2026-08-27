# IMPLEMENTATION-PLAN.md

## Purpose

An Implementation Plan is the schema, grouping logic, and lifecycle gate for the artifact produced by
`agent-harness/modes/PLANNING-IMPLEMENTATION.md` — see that file for the behavioral rules governing how a Plan is
created.

## Artifact Story

A Task, Spec, or Use Case (or, for a Plan-tier request, nothing at all) is ready for implementation. The agent
groups the required changes into steps, records validation and risk per step, and drafts the Plan at `active/`.
Nothing changes in the codebase until the user explicitly approves the Plan and that approval is recorded in the
same transition that moves it to `ready/` and unlocks Implementing mode. Once every step completes, the Plan
reaches `done`, which can cascade the source Spec and Use Case to `done`.

## Entry / Creation Paths

Created only from within Planning-Implementation (`agent-harness/modes/PLANNING-IMPLEMENTATION.md`), never
directly.

## Sources

A Plan is created only from within Planning-Implementation, from a Task, Spec, or Use Case — OR, when
`shared-procs/RISK-TIER.md`'s cascade lands on Plan-tier, directly from a natural-language request with no
upstream artifact at all (`entrypoint_type: none`) (see that mode's Entry Points).

## When To Create

Whenever a Task, Spec, or Use Case has reached the status Planning-Implementation requires, or a direct request
classifies as Plan-tier — see `PLANNING-IMPLEMENTATION.md`'s `## Workflow Paths`.

## When Not To Create

Never create a Plan outside Planning-Implementation, and never treat its existence as license to change code —
code changes require the separate `ready` status transition (`## Readiness / Acceptance`).

## Artifact Shape

Grouping logic: Tasks SHOULD be grouped in one step when they belong to the same Spec, are small and tightly
related, share a validation strategy, their scopes do not conflict, they produce a coherent reviewable diff, and
no high-risk work is involved (`IPL-01-010`). Tasks SHOULD stay separate when risk is high, validation
differs between Tasks, separate commits are needed, review concerns differ, dependencies are unclear, or the
change touches database, deployment, security, payment execution, security-critical logic, or domain-critical
business rules (`IPL-01-020`). A Plan whose entry skipped any risk-tier level MUST include a `## Risk-Tier
Classification` section regardless of how small the change is (`IPL-01-030`/`IPL-01-031`).

## Field Semantics

`entrypoint_type` distinguishes a Plan sourced from a Task/Spec/Use Case from a Plan-tier Plan with no upstream
artifact (`entrypoint_type: none`) — the latter records its Spec-ID column as `—` in `harness-data/CATALOG.md`'s
Active Implementation Plans table (`IPL-05-020`).

## Body Should Include

- Target artifact
- Readiness checks
- Included artifacts
- Excluded artifacts
- Plan steps with validation per step
- Task grouping rationale
- Expected file areas
- Risk level per step
- Suggested commit boundaries
- Risk-Tier Classification (if entry skipped any tier — see `IPL-01-030`)

## Lifecycle

`active/` while drafting or in progress; `ready/` once the Readiness Gate passes; `done/` on completion (see
`## Output / Location`). Status transitions for this artifact — including the upward cascade this Plan's
promotion and completion trigger — are described in `agent-harness/systems/STATUS-TRANSITIONS.md` and enforced
by the paired `STT-*` rules.

## Readiness / Acceptance

Before this Plan's promotion (`STT-01-030`'s Plan row), verify the Readiness Checks section in the artifact —
every item must be checked; a single unchecked item blocks the status change (`IPL-02-010`/`IPL-02-011`). In
the same transition that sets the Plan to `ready`, populate `approval.approved_by` and `approval.approved_at`
from the explicit user instruction authorizing that promotion (`IPL-02-013`). Before that transition, also
check `harness-data/CATALOG.md` for other Plans at status `ready` or `in-progress` on the same Spec, or with
overlapping Task `allowed_paths` — stop and surface the conflict if either condition is found (`IPL-05-010`/
`IPL-05-011`). Keep `harness-data/CATALOG.md`'s Active Implementation Plans table accurate for all Plans at
status `ready` or `in-progress`, adding/updating a row in the same pass the status changes and removing it
once the Plan is no longer either (`IPL-05-020`).

## Relationships

A Plan's `source` names the Task/Spec/Use Case it was planned from (or is absent for a Plan-tier Plan). Its
completion can settle the parent Spec or Use Case through the transition system described in `## Lifecycle`.

## Output / Location

`harness-data/artifacts/implementation-plans/active/PLAN-*.md` while drafting or in progress; `ready/` once
the Readiness Gate passes; `done/` on completion. See `agent-harness/OUTPUTS.md` for the full lifecycle-folder
rules.

## Template

Use `agent-harness/templates/IMPLEMENTATION-PLAN-template.md` as the starting point for every new plan.

## Commit Message Convention

```text
feat(area): short description

Implements:
- TASK-XXX
- TASK-YYY

Source:
- SPEC-XXX
```

Use this format for a Plan step's suggested commit boundaries, citing the step's Task IDs under `Implements:` and
its source Spec under `Source:` (`IPL-06-010`).

## Examples

A `ready` Task for a Dockerfile chown fix: the agent creates a single-step Plan (small, tightly related, no
high-risk work), records the suggested commit message under the Commit Message Convention, and waits for
approval.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/IMPLEMENTATION-PLAN.md` (single
paired file — under the 25-rule grouping threshold). Load it whenever creating, updating, approving, or executing
against an Implementation Plan.

## Reference Files

None beyond the template and `harness-data/CATALOG.md` — see `PLANNING-IMPLEMENTATION.md`'s and
`IMPLEMENTING.md`'s own Reference Files for planning/execution-time context.
