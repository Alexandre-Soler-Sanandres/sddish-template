# TASKS.md

## Purpose

Tasks are execution units, not the source of truth for behavior — Specs are. This file is the Task artifact's
schema and lifecycle rules; the mechanical activity of deriving Tasks from a Spec (including the Task Decision
Matrix and dedup protection) lives in `agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before
creating or updating a Task.

## Artifact Story

A Spec (any status — no longer gated on `ready`, `TSK-01-010`), or via the Spec-skip path a lower-tier source,
needs execution units. Refining derives Tasks with allowed/forbidden paths and validation commands; each Task
becomes `ready` for Planning-Implementation only when `agent-harness/systems/STATUS-TRANSITIONS.md`'s
`STT-01-030`/`040` applies, not through a standalone per-Task confirmation step. ADR checks re-run at that gate
the same way they do
for Specs and Use Cases, plus an extra check when a Task's paths touch a route, service instance, or external
dependency that a health/readiness-check ADR might govern.

## Entry / Creation Paths

Created only from within Refining (`/create-tasks`).

## Sources

A Task is created only from within Refining (`/create-tasks`), from a Spec at any status — OR, when
`shared-procs/RISK-TIER.md`'s Spec-Necessity Matrix (`RSK-03-010`) classifies the request below Spec-tier,
directly from the same source types a Spec would have been created from.

## When To Create

Whenever a Spec exists and the Task Decision Matrix determines Tasks are required, or a request classifies below
Spec-tier via the risk-tier cascade.

## When Not To Create

Not applicable beyond `## Sources`' precondition — see `agent-harness/modes/REFINING.md`'s `TSK-01-031` for when
`/create-tasks` must stop instead of creating a Task.

## Artifact Shape

A Task entered via the Spec-skip path must include a `## Risk-Tier Classification` section (`RSK-05-010`); its
`source` frontmatter field then points at the Idea/Transcript/etc. actually used instead of a Spec
(`TSK-02-025`). `allowed_paths`/`forbidden_paths` scope what Implementing may touch (`IMPLEMENTING.md`'s
`IMPL-03-060`).

## Field Semantics

- `status` — see `## Lifecycle`.
- `related` — accepted ADRs this Task depends on; see `## Relationships`.
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

Before a transition rule promotes a Task to `ready`, verify the Readiness Checklist in the artifact — every item
must be checked; a single unchecked item blocks the promotion (`TSK-02-010`/`TSK-02-011`). Status transitions
for this artifact — including how it reaches `ready` and how reopening and reconsideration work — are described
in `agent-harness/systems/STATUS-TRANSITIONS.md` and enforced by the paired `STT-*` rules.

## Readiness / Acceptance

Status is set to `ready` only when `agent-harness/systems/STATUS-TRANSITIONS.md`'s `STT-01-030`/`040` applies.
Also re-run the same three ADR checks Specs and Use Cases
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

- `harness-data/artifacts/tasks/active/TASK-*.md` (`draft`/`in-progress`/`blocked`)
- `harness-data/artifacts/tasks/ready/TASK-*.md` (`ready`)
- `harness-data/artifacts/tasks/done/TASK-*.md` (`done`)
- `harness-data/artifacts/tasks/archive/TASK-*.md` (`archived`/`rejected`)

## Template

Use `agent-harness/templates/TASK-template.md` as the starting point for every new Task.

## Examples

A ready Spec needs three small, related file changes with no high risk. The agent derives one Task covering all
three (per `REFINING.md`'s Task Decision Matrix), sets `allowed_paths` to the touched files, and then leaves the
Task's eventual promotion to `ready` to `STT-01-030`/`040` once the local gates are satisfied.

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
