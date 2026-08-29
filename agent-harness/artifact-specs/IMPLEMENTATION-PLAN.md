# IMPLEMENTATION-PLAN.md

## Purpose

Implementation Plans are the separately resumable execution contract for Assured work and retained v1 chains.
New Standard work uses the Change Spec's embedded plan steps unless a separate plan has independent lifecycle value.

An Implementation Plan is the schema, grouping logic, and lifecycle gate for the artifact produced by
`agent-harness/modes/PLANNING-IMPLEMENTATION.md` — see that file for the behavioral rules governing how a Plan is
created.

## Artifact Story

A Task, Spec, or Use Case (or, for a Plan-tier request, nothing at all) needs implementation guidance. The agent
may draft the Plan at `active/` while the upstream chain is at any status, recording its current dependencies and
implementation-readiness facts. Nothing changes in the codebase until the operator explicitly requests Plan
promotion, the `STT-01-030` scoped readiness transition succeeds, and that approval is recorded in the same transition
that moves the Plan to `ready/` and unlocks Implementing mode. Once every step completes, the Plan reaches `done`,
which can cascade the source Spec and Use Case to `done`.

## Entry / Creation Paths

Created only from within Planning-Implementation (`agent-harness/modes/PLANNING-IMPLEMENTATION.md`), never
directly.

## Sources

A Plan is created only from within Planning-Implementation, from a Task, Spec, or Use Case — OR, when
`shared-procs/RISK-TIER.md`'s cascade lands on Plan-tier, directly from a natural-language request with no
upstream artifact at all (`entrypoint_type: none`) (see that mode's Entry Points).

## When To Create

Whenever a Task, Spec, or Use Case needs implementation guidance, regardless of its current status, or a direct
request classifies as Plan-tier — see `PLANNING-IMPLEMENTATION.md`'s `## Workflow Paths`.

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
Classification` section regardless of how small the change is (`IPL-01-030`/`IPL-01-031`). When no Spec
participates, the Plan must carry a compact `## Behavior Contract` section stating the expected change,
preserved behavior, and observable proof instead of forcing a full Spec (`IPL-01-032`).

## Field Semantics

`entrypoint_type` distinguishes a Plan sourced from a Task/Spec/Use Case from a Plan-tier Plan with no upstream
artifact (`entrypoint_type: none`) — the latter records its Spec-ID column as `—` in `harness-data/CATALOG.md`'s
Active Implementation Plans table (`IPL-05-020`).

## Body Should Include

- Target artifact
- Behavior Contract (when no Spec participates)
- Scoped Parent Readiness (when a UC/Spec/Task chain participates)
- Chain Preflight (when a UC/Spec/Task chain participates)
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
once the Plan is no longer either (`IPL-05-020`). If no Spec participates, verify the Plan's own
`## Behavior Contract` captures the expected delta, preserved behavior, and observable proof before advancing
(`IPL-02-014`). When a real UC/Spec/Task chain participates, require a complete `## Scoped Parent Readiness`
section and a passing `## Chain Preflight` report. They record included and every excluded sibling Task/Spec,
scope-affecting dependencies or blockers, parent requirements/criteria/constraints/dependencies/risks/preserved
behavior, and the current full-parent-fan-out result, plus validation profile, run date/time, checked IDs/paths,
`updated` values, git blob/hash when available, and findings or a cited Review reference. A later change to any
recorded participant or parent item makes the report stale until rerun (`IPL-02-015`-`019`).

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

A draft Task for a Dockerfile chown fix: the agent creates a single-step Plan (small, tightly related, no
high-risk work), records the Task's implementation-readiness facts and suggested commit message, and waits for
an explicit Plan-promotion request.

## Rules

| ID | Rule |
| --- | --- |
| IPL-00-010 | MUST NOT create an Implementation Plan for new Standard work unless a separately resumable execution contract has independent lifecycle value. |
| IPL-01-010 | SHOULD group Tasks in one step when they belong to the same Spec, are small and tightly related, share a validation strategy, their scopes do not conflict, they produce a coherent reviewable diff, and no high-risk work is involved. |
| IPL-01-030 | A Plan whose entry skipped any tier (per `shared-procs/RISK-TIER.md`'s cascade) MUST include a `## Risk-Tier Classification` section (`RSK-05-010-v1`). |
| IPL-01-031 | MUST NOT omit `IPL-01-030`'s `## Risk-Tier Classification` section regardless of how small the change is. |
| IPL-01-032 | When no Spec participates, a Plan MUST include a compact `## Behavior Contract` section stating the expected change, preserved behavior, and observable proof. |
| IPL-01-020 | SHOULD keep Tasks separate when risk is high, validation differs between Tasks, separate commits are needed, review concerns differ, dependencies are unclear, or the change touches database, deployment, security, payment execution, security-critical logic, or domain-critical business rules. |
| IPL-02-010 | Before this Plan's promotion (`STT-01-030`'s Plan row), MUST verify the Readiness Checks section in the artifact. |
| IPL-02-011 | Every Readiness Checks item MUST be checked; a single unchecked item blocks the status change. |
| IPL-02-012 | Each checked Readiness Checks item MUST be accompanied by a one-line evidence pointer (e.g. a test name, file path, or line reference) recorded beneath the checklist; a checked item with no citable evidence blocks the status change the same as an unchecked one. |
| IPL-02-013 | In the same transition that sets a Plan to `ready`, MUST populate `approval.approved_by` and `approval.approved_at` from the explicit user instruction authorizing that promotion. |
| IPL-02-014 | When no Spec participates, the Plan's `## Behavior Contract` MUST be complete before the Plan may advance to `ready`. |
| IPL-02-015 | When a UC/Spec/Task chain participates, the Plan MUST contain a passing `## Chain Preflight` report before it may advance to `ready`. |
| IPL-02-016 | A Plan's recorded `## Chain Preflight` report MUST include the validation profile, run date/time, checked artifact IDs and paths, each checked artifact's `updated` value, git blob/hash when available, and either findings or a cited Review reference. |
| IPL-02-017 | When a UC/Spec/Task chain participates, the Plan MUST contain `## Scoped Parent Readiness` identifying its source-chain parents and paths, included Tasks, every excluded sibling Task/Spec with current status/known owning Plan/nonblocking rationale, parent requirement/acceptance/constraint/dependency/risk/preserved-behavior items used by the slice, open Question/Review/blocker assessment, and current full-parent-fan-out result. |
| IPL-02-018 | For each source-chain Spec, the union of included Tasks and sibling Tasks recorded in `## Scoped Parent Readiness` MUST equal that Spec's current derived Task set; an excluded sibling with a dependency, required shared path, requirement/acceptance overlap, or unresolved Question/Review affecting the slice MUST block promotion unless included or resolved. |
| IPL-02-019 | An included Task MAY be `draft` and promote only after its fresh local gate passes, or already `ready`; an included `blocked`, `in-progress`, `archived`, `rejected`, or `done` Task MUST block promotion, and a `done` Task MUST instead be recorded as completed sibling/foundation scope. |
| IPL-05-010 | Before setting a Plan status to `ready`, MUST check `harness-data/CATALOG.md` for other Plans at status `ready` or `in-progress` on the same Spec (`IPL-05-030`) or with overlapping Task `allowed_paths` (`IPL-05-050`). |
| IPL-05-011 | MUST stop and surface the conflict if `IPL-05-010`'s check finds either condition. |
| IPL-05-020 | MUST keep `harness-data/CATALOG.md`'s Active Implementation Plans table accurate for all Plans at status `ready` or `in-progress`: add or update a Plan's row in the same pass its status changes to `ready` or `in-progress`; remove the row once the Plan is no longer either. For a Plan-tier Plan (`entrypoint_type: none`), record its row with the Spec ID column as `—`; the row is still required while the Plan is `ready` or `in-progress`, so `IPL-05-050`'s path-overlap check has a live table to check against. |
| IPL-06-010 | MUST use the Commit Message Convention format in `IMPLEMENTATION-PLAN.md`'s `## Commit Message Convention` for a Plan step's suggested commit boundaries, citing the step's Task IDs under `Implements:` and its source Spec under `Source:`. |

## Reference Files

None beyond the template and `harness-data/CATALOG.md` — see `PLANNING-IMPLEMENTATION.md`'s and
`IMPLEMENTING.md`'s own Reference Files for planning/execution-time context.
