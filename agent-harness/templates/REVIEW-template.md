---
id: REVIEW-0001
type: review
status: draft            # draft | assessed | resolved | discarded; decision semantics live in outcome
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
target_type: ""          # idea | use-case | spec | task | implementation-plan | implementation | process | harness
target: ""               # e.g. TASK-0001
source: []               # e.g. [PLAN-0001]
outcome: ""              # accepted | accepted-with-notes | changes-requested | rejected | follow-up-required
reviewer: ""             # name or role
follow_up: []            # e.g. [IMPROVEMENT-0001]
---

## Target

(what is being reviewed)

## Criteria Checklist

Use the list matching this Review's `target_type` (see `agent-harness/artifact-specs/REVIEW.md`'s Two Flavors) —
delete the other list, don't fill both.

Product/requirements flavor (`target_type`: idea/use-case/spec/task/implementation-plan/implementation):

- [ ] Output is correct
- [ ] Output is complete
- [ ] Scope was appropriate (not too broad)
- [ ] Validation covered the right risks
- [ ] Artifacts are traceable

Harness/process flavor (`target_type`: process/harness):

- [ ] Agent loaded the right context
- [ ] Rules were clear enough
- [ ] Agent followed context checkpoint before high-impact actions
- [ ] Harness improvement need assessed

## Findings

(list findings — positive or negative)

## Follow-Up

(list any follow-up artifacts, tasks or improvements required)
