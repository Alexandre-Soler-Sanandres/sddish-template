# TASKS.md

## Purpose

Tasks are execution units, not the source of truth for behavior — Specs are. This file is the Task artifact's
schema and lifecycle rules; the mechanical activity of deriving Tasks from a Spec (including the Task Decision
Matrix and dedup protection) lives in `agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before
creating or updating a Task.

## Sources

A Task is created only from within Refining (`/create-tasks`), from an approved Spec.

## Task Body Should Include

- Goal
- Scope
- Non-goals
- Allowed paths
- Forbidden paths
- Validation commands
- Dependencies and blockers
- Risk level
- Estimated size

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| TSK-02-010 | Readiness-Gate | Before setting a Task status to `ready`, MUST verify the Readiness Checklist in the artifact; all items must be checked, and a single unchecked item blocks the status change. |
| TSK-02-020 | Cascade | Reopening a `done` Task (moving it off `done` for a reason other than `SPECS.md`'s `SPS-07-020` cascade already having done so) MUST trigger `CORE.md`'s `COR-01-130` — the source Spec's `implemented` status may now be stale and must be explicitly reconsidered, not left as-is by default. |
| TSK-05-010 | Traceability | When a Task is created that depends on an accepted `scoped` ADR, MUST add the ADR's ID to the Task's `related` field and add the Task's ID to the ADR's `derived_tasks` field, in the same pass — the Task-side equivalent of `RELATIONS-AND-SUPERSESSION.md`'s `DEC-07-010`, which covers Use Case/Spec only. A `fleet-wide` ADR is exempt from the reverse-link half of this rule, per the same reasoning as `DEC-07-010`. |
| TSK-06-010 | ADR-Check | Missed-ADR recheck. Before setting a Task status to `ready`, MUST re-run the relevance judgment against the *current* accepted-ADR list: every `fleet-wide` ADR MUST be present in `related`; every `scoped` ADR MUST be re-judged, added if newly relevant, or explicitly ruled out. |
| TSK-06-020 | ADR-Check | Before setting a Task status to `ready`, if the Task's `allowed_paths` add or modify an HTTP route, app instance, or an external dependency (database, model, credential) on a backend service, MUST additionally verify whether this project's accepted health/readiness-check convention ADR (if one exists) needs updating for that change — regardless of whether `TSK-06-010`'s recheck matches — and either update it or note explicitly why no update is needed. |
| TSK-06-030 | ADR-Check | Content-drift recheck. Before setting a Task status to `ready`, MUST judge ADR relevance against the Task's actual current scope, not only its original `area` — drafting/scoping can drift the Task into territory an ADR bears on that the creation-time load never saw. |
| TSK-06-040 | ADR-Check | Compliance check. Before setting a Task status to `ready`, MUST verify every ADR cited in `related` is actually reflected in the Task's `allowed_paths`/scope — a citation with no matching content is a gate failure. |

## Output

- `harness-data/artifacts/tasks/active/TASK-*.md`
- Use `agent-harness/templates/TASK-template.md` as the starting point for every new Task.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining allowed and forbidden paths or verifying scope against system boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
- `harness-data/reference/DOMAIN.md` — when the Task touches domain-critical areas (payments, security, data integrity)
