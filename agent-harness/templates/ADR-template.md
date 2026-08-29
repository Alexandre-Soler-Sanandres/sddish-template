---
id: ADR-0001
type: adr
status: proposed        # proposed | accepted | superseded | archived
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
area: ""                  # e.g. service-boundaries | data-ownership | security | deployment
scope: ""                 # fleet-wide | scoped — see ADR.md's DEC-14-010
source_ids: []             # e.g. [TRANSCRIPT-0002, IDEA-0001]
related_adrs: []           # e.g. [ADR-0010]
question_refs: []          # e.g. [Q-0001]
tags: []
---

## Context

(the problem, forces, or prior decisions — including cited `legacy_refs` — that made this decision necessary)

## Decision

(what was decided, stated plainly and concretely — written so it can be quoted on its own, the way `CSQ-*` rows are)

## Considered Alternatives

(other options that were weighed, and why each was rejected)

## Consequences

(what this makes easier, harder, or changes going forward — including any new open work it creates)

## Open Questions

(MUST list canonical Question IDs this decision has not settled yet, per `COR-01-120`. `DEC-03-010` governs
whether one stops acceptance.)

## Readiness Checklist

Before advancing to `accepted`, verify all items are checked:

- [ ] Context cites concrete evidence (legacy `CSQ-*`/`Q-<APP>-*` IDs, prior ADRs, or discussion) rather than unsupported assertion
- [ ] Decision is stated as a single, standalone statement that could be quoted without needing the rest of the document
- [ ] At least one real alternative is documented in Considered Alternatives, with a concrete reason for rejection
- [ ] Consequences names concrete downstream effects, not a restatement of the Decision
- [ ] `legacy_refs`, `supersedes`, `superseded_by`, and `related` are accurate and complete (`derived_use_cases`/`derived_specs`/`derived_tasks` are expected to be empty at acceptance; for a `scoped` ADR they're populated later per `DEC-07-010`/`TSK-05-010`, while a `fleet-wide` ADR stays empty permanently — see `DEC-14-010`)
- [ ] Every ID in `related` has an inline "Relation to" note stating its relationship type and reason (per `DEC-09-010`)
- [ ] No open questions remain that would change the Decision itself
- [ ] The user has explicitly confirmed acceptance (not inferred from discussion)
