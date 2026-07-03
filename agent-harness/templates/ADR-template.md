---
id: ADR-001
type: adr
status: proposed        # proposed | accepted | superseded | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
area: ""                  # e.g. service-boundaries | data-ownership | security | deployment
source: []                # e.g. [TRANSCRIPT-002], [IDEA-001]
legacy_refs: []            # e.g. [CSQ-NNN] — legacy decisions this ADR builds on, narrows, or overrides
supersedes: []            # e.g. [IDEA-001] — artifacts this ADR replaces
superseded_by: []         # e.g. [ADR-010] — filled in later if this ADR is ever replaced
related: []                # e.g. [SPEC-002, ADR-005] — loosely related artifacts
derived_use_cases: []      # e.g. [UC-011] — Use Cases created that depend on this ADR
derived_specs: []          # e.g. [SPEC-021] — Specs created that depend on this ADR
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

(what this decision deliberately does not settle)

## Readiness Checklist

Before advancing to `accepted`, verify all items are checked:

- [ ] Context cites concrete evidence (legacy `CSQ-*`/`Q-<APP>-*` IDs, prior ADRs, or discussion) rather than unsupported assertion
- [ ] Decision is stated as a single, standalone statement that could be quoted without needing the rest of the document
- [ ] At least one real alternative is documented in Considered Alternatives, with a concrete reason for rejection
- [ ] Consequences names concrete downstream effects, not a restatement of the Decision
- [ ] `legacy_refs`, `supersedes`, `superseded_by`, and `related` are accurate and complete (`derived_use_cases`/`derived_specs` are expected to be empty at acceptance — they're populated later, per `DEC-007`)
- [ ] No open questions remain that would change the Decision itself
- [ ] The user has explicitly confirmed acceptance (not inferred from discussion)

## Lifecycle Note

See `agent-harness/modes/ADR.md`'s `DEC-004`–`DEC-006` for the acceptance gate, immutability, and approval rules.
