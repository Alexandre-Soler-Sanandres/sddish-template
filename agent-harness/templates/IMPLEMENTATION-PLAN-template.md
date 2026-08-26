---
id: PLAN-0001
type: implementation-plan
status: draft            # draft | ready | in-progress | blocked | done | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
entrypoint_type: ""      # task | spec | use-case | none
entrypoint: ""           # e.g. SPEC-0001
source: []               # e.g. [SPEC-0001] — empty ([]) for entrypoint_type: none; the Idea/Transcript actually used, if any, goes in the Risk-Tier Classification section instead
included_tasks: []       # e.g. [TASK-0001, TASK-0002]
excluded_tasks: []       # e.g. [TASK-0003]
risk: low                # low | medium | high
approval:
  required: true
  approved_by: null
  approved_at: null      # YYYY-MM-DD
---

## Target

(what this plan implements)

## Risk-Tier Classification

(optional — filled in only when this Plan skipped any tier per `shared-procs/RISK-TIER.md`'s cascade, including
Plan-tier direct entry with `entrypoint_type: none`; see `IMPLEMENTATION-PLAN.md`'s `IPL-01-030`)

## Readiness Checks

All items must be checked before this plan may advance to `ready`. Cite a one-line evidence pointer per
checked item beneath the checklist — see `rules/artifact-specs/IMPLEMENTATION-PLAN.md`'s `IPL-02-012`.

- [ ] Required Tasks exist
- [ ] Upward cascade (`systems/STATUS-TRANSITIONS.md`'s `STT-01-030`) succeeded: included Task(s), their Spec(s) (fan-out complete — every sibling Task also `ready`), and Use Case (fan-out complete — every sibling Spec also `ready`) all independently re-verified and promoted
- [ ] If entered with no upstream artifact per `RISK-TIER.md`'s cascade, `## Risk-Tier Classification` section is present and complete
- [ ] No blockers or unresolved dependencies
- [ ] High-risk areas identified
- [ ] Each plan step defines expected files, validation, and a suggested commit
- [ ] Structural ADR scaffolding this plan's steps depend on was verified to exist, or a bootstrap step was added
- [ ] Tooling required by this plan's own validation commands is provisioned by an earlier step, not assumed

## Included Artifacts

(list Tasks or Specs included in this plan)

## Excluded Artifacts

(list what is deliberately excluded and why)

## Plan Steps

### Step 1 — (title)

- Tasks: (TASK-XXX, TASK-YYY — or "inline" if no Task artifacts exist)
- Expected files: (list paths)
- Validation: (commands or checks)
- Risk: low / medium / high
- Suggested commit: (message)

### Step 2 — (title)

(repeat as needed — every step must define expected files, validation, and a suggested commit regardless of whether Task artifacts exist)

## Approval

- Status: draft
- Approved by: (name)
- Approved at: (date)
