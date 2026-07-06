# IMPLEMENTATION-PLAN.md

## Purpose

An Implementation Plan is the schema, grouping logic, and lifecycle gate for the artifact produced by
`agent-harness/modes/PLANNING-IMPLEMENTATION.md` — see that file for the behavioral rules governing how a Plan is
created.

## Sources

A Plan is created only from within Planning-Implementation, from a Task, Spec, or Use Case (see that mode's Entry
Points).

## Plan Body Should Include

- Target artifact
- Readiness checks
- Included artifacts
- Excluded artifacts
- Plan steps with validation per step
- Task grouping rationale
- Expected file areas
- Risk level per step
- Suggested commit boundaries
- Approval status

## Commit Message Convention

```text
feat(area): short description

Implements:
- TASK-XXX
- TASK-YYY

Source:
- SPEC-XXX
```

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IPL-01-010 | Grouping | Group Tasks in one step when they belong to the same approved Spec, are small and tightly related, share a validation strategy, their scopes do not conflict, they produce a coherent reviewable diff, and no high-risk work is involved. |
| IPL-01-020 | Grouping | Keep Tasks separate when risk is high, validation differs between Tasks, separate commits are needed, review concerns differ, dependencies are unclear, or the change touches database, deployment, security, payment execution, security-critical logic, or domain-critical business rules. |
| IPL-02-010 | Readiness-Gate | Before setting a Plan status to `approved`, verify the Readiness Checks section in the artifact. All items must be checked. A single unchecked item blocks the status change. |
| IPL-05-010 | Parallel-Work | Before setting a Plan status to `approved`, check `harness-data/CATALOG.md` for other Plans at status `approved` or `in-progress` on the same Spec (`IPL-05-030`) or with overlapping Task `allowed_paths` (`IPL-05-050`); stop and surface the conflict if either applies. |
| IPL-05-020 | Parallel-Work | Keep `harness-data/CATALOG.md`'s Active Implementation Plans table accurate for all Plans at status `approved` or `in-progress`: add or update a Plan's row in the same pass its status changes to `approved` or `in-progress`; remove the row once the Plan is no longer either. |
| IPL-05-080 | Cascade | When a Plan reaches status `done` and every Task derived from a Spec is `done`, set that Spec's status to `implemented`. When every Spec derived from a Use Case is `implemented`, set the Use Case's status to `implemented`. |

## Output

- `harness-data/artifacts/implementation-plans/active/PLAN-*.md` while drafting or in progress; `approved/` once `IPL-02-010`'s Readiness Gate passes; `done/` on completion. See `agent-harness/OUTPUTS.md` for the full lifecycle-folder rules.
- Use `agent-harness/templates/IMPLEMENTATION-PLAN-template.md` as the starting point for every new plan.
