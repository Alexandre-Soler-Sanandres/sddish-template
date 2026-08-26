---
id: UC-0001
type: use-case
status: draft            # draft | ready | in-progress | blocked | done | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
area: ""                 # domain area, e.g. user-management | payments | reporting
primary_actor: ""        # e.g. operator | user | system | external-service
supporting_actors: []
source: []               # e.g. [IDEA-0001]; include legacy finding IDs when derived from Legacy Discovery
related: []              # e.g. [ADR-0005] — accepted ADRs this Use Case depends on; see USE-CASES.md's UCS-07-010
derived_specs: []        # e.g. [SPEC-0001]
tags: []
technical_impact: []     # e.g. [db-schema, api-contract] — see agent-harness/artifact-specs/USE-CASES.md's UCS-06-020
confidence: medium       # low | medium | high
risk: low                # low | medium | high
---

## Goal

(what the primary actor is trying to achieve)

## Trigger

(what causes this use case to begin)

## Preconditions

(what must be true before this use case can start)

## Main Success Scenario

1. (step by step — actor actions and system responses)

## Alternatives and Failure Paths

- (describe key alternatives or error conditions; if a legacy proof/parity item changes scenario behavior, cite its
  ID here or in Open Questions)

## Non-Goals

- (what this use case explicitly does not cover — permanent exclusion by default; for a deferred/not-now item,
  add a forward pointer: `(deferred, see IDEA-NNNN)` for a candidate feature, or `(deferred, see Q-NNNN)` for a
  genuinely unresolved direction question — see `agent-harness/artifact-specs/IDEA.md`'s `IDA-04-010`/
  `agent-harness/artifact-specs/QUESTIONS.md`'s `QST-06-010` for which applies)

## Observable Outcome

(what the actor or system can observe when this use case succeeds)

## Open Questions

(MUST list canonical Question IDs per `COR-01-120`. MUST NOT restate full backlog text — cite the ID. `UCS-03-011`
governs whether an unresolved reference stops advancement.)

## Readiness Checklist

Before advancing to `ready`, verify all items are checked. Cite a one-line evidence pointer per checked
item beneath the checklist — see `rules/artifact-specs/USE-CASES.md`'s `UCS-03-012`.

- [ ] Primary actor is defined
- [ ] Goal is clear and specific
- [ ] Trigger is identified
- [ ] Preconditions are stated
- [ ] Main success scenario has at least 3 steps
- [ ] Alternatives and failure paths are defined
- [ ] Observable outcome is defined
- [ ] No open questions remain that would block Spec creation
- [ ] Accepted ADRs checked for scope-relevant area tags; matches cited or explicitly ruled out
