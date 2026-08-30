---
id: SPEC-0001
type: spec
status: draft            # draft | ready | in-progress | blocked | done | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
area: ""                 # domain area, e.g. user-management | payments | reporting
source_ids: []           # e.g. [UC-0001]
related_adrs: []         # e.g. [ADR-0005]
question_refs: []        # e.g. [Q-0001]
external_refs: []        # described external material
risk: low                # low | medium | high
requires: []             # harness reference files needed, e.g. [harness-data/reference/ARCHITECTURE.md#database]
tags: []
---

## Problem

(what problem this spec addresses)

## Goal

(what this spec achieves)

## Scope

(what is included)

## Non-Goals

(what is explicitly excluded — permanent exclusion by default; for a deferred/not-now item, add a forward
pointer: `(deferred, see IDEA-NNNN)` for a candidate feature, or `(deferred, see Q-NNNN)` for a genuinely
unresolved direction question — see `agent-harness/artifact-specs/IDEA.md`'s `IDA-04-010`/
`agent-harness/artifact-specs/QUESTIONS.md`'s `QST-06-010` for which applies)

## Functional Requirements

- FR-1: (requirement)

## Non-Functional Requirements

- NFR-1: (requirement — performance, reliability, security, etc.)

## Acceptance Criteria

- AC-1: (concrete, testable criterion)

## Requirement Coverage Map

| AC ID | Requirement IDs | Scenario | Evidence intent |
| --- | --- | --- | --- |
| AC-1 | FR-1, NFR-1 | (Given/When/Then or EARS-style condition/action/outcome) | (test, check, or review that proves this AC) |

## Constraints

(technical or business constraints that limit the solution space; cite inherited `Q-NNNN`
IDs when they constrain the design)

## Dependencies

(other specs, tasks or external systems this depends on; include legacy-derived dependencies or shared obligations by
ID when relevant)

## Risks

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| | | | |

## Behavior to Preserve

(required for fixes, refactors, migrations, and scoped behavior changes where existing behavior outside scope must
remain stable; list regression invariants or mark `Not applicable — net-new behavior` explicitly)

## Validation Approach

(how this spec will be validated — tests, checks, manual review; carry any inherited proof obligations that
must later be discharged here or in Open Questions, not in `test_refs`)

## Task Decision Notes

(are Tasks required for this spec? rationale)

## Risk-Tier Classification

(optional — filled in only when this Spec was entered via `shared-procs/RISK-TIER.md`'s UC-skip path; see
`SPECS.md`'s `SPS-01-050`)

## Open Questions

(cite only relevant `question_refs` IDs)

## Readiness Checklist

Before advancing to `ready`, verify all items are checked. Cite a one-line evidence pointer per checked item
beneath the checklist — see `agent-harness/artifact-specs/SPECS.md`'s `SPS-02-012`.

- [ ] Problem is clearly stated
- [ ] Goal is measurable or verifiable
- [ ] Scope and non-goals are defined
- [ ] All functional requirements are concrete
- [ ] Acceptance criteria are testable
- [ ] Every acceptance criterion maps to requirement IDs, a scenario, and evidence intent
- [ ] Normal, boundary, error, and recovery behavior is covered or explicitly marked not applicable
- [ ] Risks are identified
- [ ] `## Behavior to Preserve` is filled in or explicitly marked not applicable
- [ ] Dependencies are resolved or explicitly accepted
- [ ] Task decision notes are filled in
- [ ] If entered via the UC-skip path, `## Risk-Tier Classification` section is present and complete
- [ ] No open questions remain
- [ ] Accepted ADRs checked for scope-relevant area tags; matches cited or explicitly ruled out
