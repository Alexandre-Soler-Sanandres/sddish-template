# TASKS.md

## Purpose

Task mode creates Task artifacts when they are required.
Tasks are execution units, not the source of truth for behavior — Specs are.

## Entry

Via CLI: `/tw-create-tasks <spec-file>`
Via natural language: explicit instruction referencing the Spec.

## Task Decision Matrix

| Situation | Tasks required? | Reason |
| --- | --- | --- |
| Small documentation-only change | No | Inline plan is sufficient |
| Small isolated config change | Optional | Use inline plan if validation is clear |
| Small bugfix in one module | Optional | Use inline plan if scope is clear |
| Multiple files or modules | Yes | Reviewability and traceability |
| Multiple implementation steps | Yes | Ordering and validation boundaries |
| Cross-cutting change | Yes | Scope control |
| Unclear dependencies | Yes | Dependency management |
| Use Case with multiple Specs | Yes | Too broad for inline planning |
| Spec with multiple features | Yes | Needs execution slices |
| Database migration | Yes | High risk |
| Destructive data job | Yes | High risk |
| Deployment or infrastructure change | Yes | Operational risk |
| Security, secrets or auth | Yes | Safety-critical |
| Payment or financial transaction execution | Yes | Safety-critical |
| Domain-critical business logic | Yes | Domain-critical |
| Major architecture change | Yes | Requires reviewable slices |

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
| TSK-001 | Sources | Tasks must always be created from an approved Spec. The Spec must be at status `approved` before Tasks may be created. |
| TSK-002 | Readiness-Gate | Before setting a Task status to `ready`, verify the Readiness Checklist in the artifact. All items must be checked. A single unchecked item blocks the status change. |
| TSK-003 | Boundaries | Do not implement or change code. |
| TSK-004 | Boundaries | Do not create Implementation Plans. |
| TSK-005 | Boundaries | Do not proceed if the source Spec is not at status `approved`. |

## Output

- `harness-data/artifacts/tasks/active/TASK-*.md`
- Use `agent-harness/templates/TASK-template.md` as the starting point for every new Task.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when defining allowed and forbidden paths or verifying scope against system boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
- `harness-data/reference/DOMAIN.md` — when the Task touches domain-critical areas (payments, security, data integrity)
