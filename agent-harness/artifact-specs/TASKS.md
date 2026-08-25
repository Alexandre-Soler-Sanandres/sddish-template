# TASKS.md

## Purpose

Tasks are execution units, not the source of truth for behavior — Specs are. This file is the Task artifact's
schema and lifecycle rules; the mechanical activity of deriving Tasks from a Spec (including the Task Decision
Matrix and dedup protection) lives in `agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before
creating or updating a Task.

## Artifact Story

An approved Spec (or, via the Spec-skip path, a lower-tier source) needs execution units. Refining derives Tasks
with allowed/forbidden paths and validation commands; each Task waits for the user's explicit confirmation before
becoming `ready` for Planning-Implementation to plan against. ADR checks re-run at that gate the same way they do
for Specs and Use Cases, plus an extra check when a Task's paths touch a route, service instance, or external
dependency that a health/readiness-check ADR might govern.

## Entry / Creation Paths

Created only from within Refining (`/create-tasks`).

## Sources

A Task is created only from within Refining (`/create-tasks`), from an approved Spec — OR, when
`shared-procs/RISK-TIER.md`'s Spec-Necessity Matrix (`RSK-03-010`) classifies the request below Spec-tier,
directly from the same source types a Spec would have been created from.

## When To Create

Whenever a Spec reaches `approved` and the Task Decision Matrix determines Tasks are required, or a request
classifies below Spec-tier via the risk-tier cascade.

## When Not To Create

Not applicable beyond `## Sources`' precondition — see `agent-harness/modes/REFINING.md`'s `TSK-01-011`/
`TSK-01-031` for when `/create-tasks` must stop instead of creating a Task.

## Artifact Shape

A Task entered via the Spec-skip path must include a `## Risk-Tier Classification` section (`RSK-05-010`); its
`source` frontmatter field then points at the Idea/Transcript/etc. actually used instead of a Spec
(`TSK-02-025`). `allowed_paths`/`forbidden_paths` scope what Implementing may touch (`IMPLEMENTING.md`'s
`IMPL-03-060`).

## Field Semantics

- `status` — see `## Lifecycle`.
- `related` — accepted ADRs this Task depends on; see `## Relationships`.
- `approval.approved_by`/`approved_at` — set together when the user confirms the Task (`TSK-02-016`).
- `allowed_paths`/`forbidden_paths` — see `## Artifact Shape`.

## Body Should Include

- Goal
- Scope
- Non-goals
- Allowed paths
- Forbidden paths
- Validation commands
- Dependencies and blockers
- Risk level
- Estimated size
- Risk-Tier Classification (if entered via the Spec-skip path — see `TSK-02-025`)

## Lifecycle

Before setting a Task status to `ready`, verify the Readiness Checklist in the artifact — every item must be
checked; a single unchecked item blocks the status change (`TSK-02-010`/`TSK-02-011`). Reopening a `done` Task
for a reason other than `SPECS.md`'s `SPS-07-020` cascade already having done so is a reopening trigger in the
harness-wide status cascade — see `agent-harness/systems/STATUS-CASCADE.md` for the full mechanism (`TSK-02-020`,
`CORE.md`'s `COR-01-130`).

## Readiness / Acceptance

Status must not be set to `ready` without the user's explicit confirmation of that specific Task, per `ADR.md`'s
`DEC-04-010` — never inferred from discussion; when confirmed, set the Task's own `approval.approved_by`/
`approved_at` in the same pass (`TSK-02-015`–`017`). Also re-run the same three ADR checks Specs and Use Cases
require: missed-ADR recheck against the *current* accepted-ADR list, with every `fleet-wide` ADR present in
`related` and every `scoped` ADR re-judged (`TSK-06-010`–`012`); content-drift recheck against the Task's actual
current scope, not only its original `area` (`TSK-06-030`); and a compliance check that every ADR cited in
`related` is actually reflected in the Task's `allowed_paths`/scope (`TSK-06-040`). If `allowed_paths` add or
modify an HTTP route, app instance, or an external dependency (database, model, credential) on a backend service,
additionally verify whether this project's accepted health/readiness-check convention ADR (if one exists) needs
updating for that change — regardless of whether the missed-ADR recheck matches — and either update it or note
explicitly why no update is needed (`TSK-06-020`).

## Relationships

When a Task is created that depends on an accepted `scoped` ADR, add the ADR's ID to the Task's `related` field
and the Task's ID to the ADR's `derived_tasks` field, in the same pass — the Task-side equivalent of
`RELATIONS-AND-SUPERSESSION.md`'s `DEC-07-010`, which covers Use Case/Spec only. A `fleet-wide` ADR is exempt
from the reverse-link half of this rule, per the same reasoning as `DEC-07-010` (`TSK-05-010`).

## Output / Location

- `harness-data/artifacts/tasks/active/TASK-*.md`

## Template

Use `agent-harness/templates/TASK-template.md` as the starting point for every new Task.

## Examples

An approved Spec needs three small, related file changes with no high risk. The agent derives one Task covering
all three (per `REFINING.md`'s Task Decision Matrix), sets `allowed_paths` to the touched files, and waits for
the user's explicit confirmation before the Task becomes `ready`.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/TASKS.md` (single paired file —
under the 25-rule grouping threshold). Load it alongside `agent-harness/modes/REFINING.md`'s own Rules Map
whenever creating, updating, or approving a Task.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining allowed and forbidden paths or verifying scope against system boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
- `harness-data/reference/DOMAIN.md` — when the Task touches domain-critical areas (payments, security, data integrity)
