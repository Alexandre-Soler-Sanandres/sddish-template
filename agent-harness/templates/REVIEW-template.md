---
id: REVIEW-0001
type: review
status: draft            # draft | assessed | closed | archived
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
target_type: ""          # idea | use-case | spec | task | implementation-plan | implementation | process | harness
target: ""               # e.g. TASK-0001
source_ids: []           # e.g. [PLAN-0001]
outcome: ""              # accepted | accepted-with-notes | changes-requested | rejected | follow-up-required
reviewer: ""             # name or role
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

## Finding Disposition

<!-- Product/requirements flavor only (RVW-06-043). Harness/process Reviews derive follow-up Improvements from
     their `source_ids` backlinks and delete this section. Maintain the table as findings are worked through; it is the
     source the `## Closure` section summarizes. Status: open | addressed | waived | open-by-design
     (`open-by-design` only where the user explicitly chose to leave the finding open). -->

| Finding | Status | Updated | Evidence |
| --- | --- | --- | --- |
| F-01 | open | YYYY-MM-DD | (artifact + mode, or user instruction, that resolves it) |

## Follow-Up

(list any follow-up artifacts, tasks or improvements required)

## Closure

<!-- Added only when setting `status: closed`. Delete until then.
     Harness/process (RVW-06-030): date; each derived Improvement ID with `done`/`rejected`.
     Product/requirements (RVW-06-042): date; one line per finding with its disposition
     (addressed / waived / open-by-design) and the artifact + mode (or user instruction) that resolved it,
     matching the latest `## Finding Disposition` rows. -->

Date: YYYY-MM-DD
