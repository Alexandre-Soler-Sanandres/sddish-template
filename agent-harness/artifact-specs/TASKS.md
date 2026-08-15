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
| TSK-05-010 | Traceability | When a Task is created that depends on an accepted ADR, MUST add the ADR's ID to the Task's `related` field and add the Task's ID to the ADR's `derived_tasks` field, in the same pass — the Task-side equivalent of `RELATIONS-AND-SUPERSESSION.md`'s `DEC-07-010`, which covers Use Case/Spec only. |
| TSK-06-010 | ADR-Check | Before setting a Task status to `ready`, MUST grep `harness-data/artifacts/adrs/accepted/*.md` frontmatter `area:` values for terms matching this Task's own `area`/scope keywords, and for each match either cite the ADR (via `TSK-05-010`'s `related` field) or note explicitly that it was checked and found not applicable. |
| TSK-06-020 | ADR-Check | Before setting a Task status to `ready`, if the Task's `allowed_paths` add or modify an HTTP route, app instance, or an external dependency (database, model, credential) on a backend service, MUST additionally verify whether this project's accepted health/readiness-check convention ADR (if one exists) needs updating for that change — regardless of whether `TSK-06-010`'s area-keyword grep matches — and either update it or note explicitly why no update is needed. |

## Output

- `harness-data/artifacts/tasks/active/TASK-*.md`
- Use `agent-harness/templates/TASK-template.md` as the starting point for every new Task.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining allowed and forbidden paths or verifying scope against system boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
- `harness-data/reference/DOMAIN.md` — when the Task touches domain-critical areas (payments, security, data integrity)
