# IMPLEMENTATION-PLANNING.md

## Purpose

Implementation Planning is the mandatory gate before code changes.
These commands do not mean "start coding now" — they mean "create a plan and wait for approval."

## Entry Points

- `/tw-implement-task <task-file>`
- `/tw-implement-spec <spec-file>`
- `/tw-implement-use-case <use-case-file>`

## Required Steps

### Entering via `/tw-implement-task`

1. Load the Task.
2. Verify the Task is at status `ready`. If not, stop and report.
3. Create a focused Implementation Plan for that Task.
4. Wait for approval — do not change code.

### Entering via `/tw-implement-spec`

1. Load the Spec.
2. Verify the Spec is at status `approved`. If not, stop and report.
3. Find existing Tasks and check their status:
   - If ready Tasks exist → use them as the planning basis.
   - If Tasks exist but are draft, blocked, stale or inconsistent → stop and report.
   - If no Tasks exist → apply the task decision matrix (see `agent-harness/modes/TASKS.md`).
   - If Tasks are required but missing → stop and route to `/tw-create-tasks`.
   - If Tasks are not required → create an inline Implementation Plan.
4. Do not generate duplicate Tasks or ignore existing ones.
5. Create the Implementation Plan.
6. Wait for approval — do not change code.

### Entering via `/tw-implement-use-case`

1. Load the Use Case.
2. Verify the Use Case is at status `approved` or `ready-for-spec`. If not, stop and report.
3. Find all derived Specs from the Use Case frontmatter.
   - If Specs are missing or not at status `approved` → stop and route to `/tw-create-spec`.
4. For each Spec, find existing Tasks and check their status:
   - If ready Tasks exist → use them as the planning basis.
   - If Tasks exist but are draft, blocked, stale or inconsistent → stop and report.
   - If no Tasks exist → apply the task decision matrix (see `agent-harness/modes/TASKS.md`).
   - If Tasks are required but missing → stop and route to `/tw-create-tasks`.
5. Do not generate duplicate Tasks or ignore existing ones.
6. Create a coherent end-to-end Implementation Plan covering all derived Specs.
7. Wait for approval — do not change code.

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

## Grouping Rules

Group Tasks in one step when:

- They belong to the same approved Spec
- They are small and tightly related
- They share a validation strategy
- Their scopes do not conflict
- They produce a coherent, reviewable diff
- No high-risk work is involved

Keep Tasks separate when:

- Risk is high
- Validation differs between Tasks
- Separate commits are needed
- Review concerns differ
- Dependencies are unclear
- The change touches database, deployment, security, payment execution, security-critical logic, or domain-critical business rules

## Commit Message Convention

```text
feat(area): short description

Implements:
- TASK-XXX
- TASK-YYY

Source:
- SPEC-XXX
```

## Output

- `agent-harness/implementation-plans/active/PLAN-*.md`
- Use `agent-harness/templates/IMPLEMENTATION-PLAN-template.md` as the starting point for every new plan.

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/ARCHITECTURE.md` — when defining expected file areas or architectural boundaries in the plan
- `agent-harness/reference/TOOLING.md` — when specifying validation commands per plan step
- `agent-harness/reference/DOMAIN.md` — when the plan touches domain-critical areas (payments, security, data integrity)

## Readiness Gate

Before setting a Plan status to `approved`, verify the Readiness Checks section in the artifact.
All items must be checked. A single unchecked item blocks the status change.

## Boundaries — Must Not

- Change code
- Treat `proposed` status as approved
- Proceed if the source artifact is not at an accepted status
- Generate duplicate Tasks or skip existing ones
