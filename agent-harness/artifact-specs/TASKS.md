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
| TSK-02-010 | Readiness-Gate | Before setting a Task status to `ready`, verify the Readiness Checklist in the artifact. All items must be checked. A single unchecked item blocks the status change. |

## Output

- `harness-data/artifacts/tasks/active/TASK-*.md`
- Use `agent-harness/templates/TASK-template.md` as the starting point for every new Task.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining allowed and forbidden paths or verifying scope against system boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
- `harness-data/reference/DOMAIN.md` — when the Task touches domain-critical areas (payments, security, data integrity)
