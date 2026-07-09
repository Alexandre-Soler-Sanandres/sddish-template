---
id: SPEC-001
type: spec
status: draft            # draft | approved | implemented | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
area: ""                 # domain area, e.g. user-management | payments | reporting
source: []               # e.g. [UC-001]; inherited legacy IDs stay in body sections, not as a copied backlog
related: []              # e.g. [SPEC-002, IDEA-001]
derived_tasks: []        # e.g. [TASK-001, TASK-002]
risk: low                # low | medium | high
approval:
  required: true
  approved_by: null
  approved_at: null      # YYYY-MM-DD
requires: []             # harness reference files needed, e.g. [harness-data/reference/ARCHITECTURE.md#database]
technical_refs: []       # external technical artifacts, e.g. [docs/api/openapi.yaml, docs/db/schema.sql]
test_refs: []            # populated during implementation — test file paths covering each AC only
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
pointer: `(deferred, see IDEA-NNN)` for a candidate feature, or `(deferred, see Q-NNN)` for a genuinely
unresolved direction question — see `agent-harness/artifact-specs/IDEA.md`'s `IDA-04-010`/
`agent-harness/artifact-specs/QUESTIONS.md`'s `QST-06-010` for which applies)

## Functional Requirements

- FR-1: (requirement)

## Non-Functional Requirements

- NFR-1: (requirement — performance, reliability, security, etc.)

## Acceptance Criteria

- AC-1: (concrete, testable criterion)

## Constraints

(technical or business constraints that limit the solution space; cite inherited `CSQ-*` / `Q-<APP>-*` / `CSP-*`
IDs when they constrain the design)

## Dependencies

(other specs, tasks or external systems this depends on; include legacy-derived dependencies or shared obligations by
ID when relevant)

## Risks

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| | | | |

## Validation Approach

(how this spec will be validated — tests, checks, manual review; cite any inherited `CSP-*` proof obligations that
must later be discharged here or in Open Questions, not in `test_refs`)

## Task Decision Notes

(are Tasks required for this spec? rationale)

## Open Questions

(MUST list canonical Question IDs per `COR-01-120`. MUST NOT restate full backlog text — cite the ID. `SPS-02-010`
governs whether an unresolved reference stops approval.)

## Readiness Checklist

Before advancing to `approved`, verify all items are checked:

- [ ] Problem is clearly stated
- [ ] Goal is measurable or verifiable
- [ ] Scope and non-goals are defined
- [ ] All functional requirements are concrete
- [ ] Acceptance criteria are testable
- [ ] Risks are identified
- [ ] Dependencies are resolved or explicitly accepted
- [ ] Task decision notes are filled in
- [ ] No open questions remain
