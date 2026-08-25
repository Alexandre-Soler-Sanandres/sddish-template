# DISCOVERING-LEGACY / Routing Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-02-010 | Routing | MAY include, as other outputs, a candidate `harness-data/artifacts/specs/active/SPEC-*.md` (per `LD-01-080`'s exception) and Harness Improvement candidates. |
| LD-02-020 | Routing | A Legacy Finding's evidence MAY produce a candidate `harness-data/artifacts/ideas/active/IDEA-*.md` when it states a future/roadmap direction rather than an unresolved fork — apply `COR-01-110`'s test. Ideas spun off from a *resolved* Question are governed by `QUESTIONS.md`'s `QST-07-020` instead. |
| LD-02-021 | Routing | MUST note a `LD-02-020` candidate Idea in the originating finding's `## Candidate Artifacts`. |
| LD-02-022 | Routing | Before creating a new Idea per `LD-02-020`, MUST check existing `active` Ideas for overlap (`IDA-02-010`) and apply `IDA-01-020`'s atomicity rule — one Idea per opportunity, not one per source document. |
| LD-02-025 | Routing | SHOULD prefer candidate Use Cases or Ideas before direct candidate Specs when a finding primarily shapes behavior, actor workflow, or future direction. |
| LD-02-026 | Routing | A direct candidate Spec SHOULD be named only when the evidence already defines a concrete standalone technical contract, proof surface, or implementation-shaping constraint that is not merely downstream of an expected Use Case or Idea. |
| LD-02-030 | Routing | MUST NOT draft a Use Case in Legacy Discovery — once a Legacy Finding is strong enough (`LD-01-070`), route to Refining (`/create-use-case`) to create the `UC-*.md`. |
