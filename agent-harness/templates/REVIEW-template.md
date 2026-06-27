---
id: REVIEW-001
type: review
status: draft            # draft | completed; decision semantics live in outcome
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
target_type: ""          # idea | use-case | spec | task | implementation-plan | implementation | process | harness
target: ""               # e.g. TASK-001
source: []               # e.g. [PLAN-001]
outcome: ""              # accepted | accepted-with-notes | changes-requested | rejected | follow-up-required
reviewer: ""             # name or role
follow_up: []            # e.g. [IMPROVEMENT-001]
---

## Target

_(what is being reviewed)_

## Criteria Checklist

- [ ] Output is correct
- [ ] Output is complete
- [ ] Scope was appropriate (not too broad)
- [ ] Agent loaded the right context
- [ ] Validation covered the right risks
- [ ] Artifacts are traceable

## Findings

_(list findings — positive or negative)_

## Outcome

_(accepted | accepted-with-notes | changes-requested | rejected | follow-up-required)_

## Lifecycle Note

Review artifacts stay on a simple `draft` -> `completed` path because the actual review decision is recorded separately in `outcome`.

## Follow-Up

_(list any follow-up artifacts, tasks or improvements required)_
