---
id: PLAN-001
type: implementation-plan
status: proposed         # proposed | review | approved | in-progress | done | rejected | archived
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
entrypoint_type: ""      # task | spec | use-case
entrypoint: ""           # e.g. SPEC-001
source: []               # e.g. [SPEC-001]
included_tasks: []       # e.g. [TASK-001, TASK-002]
excluded_tasks: []       # e.g. [TASK-003]
risk: low                # low | medium | high
approval:
  required: true
  approved_by: null
  approved_at: null      # YYYY-MM-DD
---

## Target

_(what this plan implements)_

## Readiness Checks

All items must be checked before this plan may advance to `approved`:

- [ ] Source artifact is approved
- [ ] Required Tasks exist and are ready
- [ ] No blockers or unresolved dependencies
- [ ] High-risk areas identified
- [ ] Each plan step defines expected files, validation, and a suggested commit

## Included Artifacts

_(list Tasks or Specs included in this plan)_

## Excluded Artifacts

_(list what is deliberately excluded and why)_

## Plan Steps

### Step 1 — _(title)_

- Tasks: _(TASK-XXX, TASK-YYY — or "inline" if no Task artifacts exist)_
- Expected files: _(list paths)_
- Validation: _(commands or checks)_
- Risk: low / medium / high
- Suggested commit: `_(message)_`

### Step 2 — _(title)_

_(repeat as needed — every step must define expected files, validation, and a suggested commit regardless of whether Task artifacts exist)_

## Approval

- Status: proposed
- Approved by: _(name)_
- Approved at: _(date)_
