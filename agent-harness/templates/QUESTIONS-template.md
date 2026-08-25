---
id: QUESTIONS-<STATUS>
type: questions
status: active
title: "Questions Registry — <Status>"
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
tags: [questions]
---

A harness-level registry of unresolved (and resolved) questions from any origin — Transcript, Idea, Use Case,
Spec, Task, ADR, Legacy Finding, or Review finding. Not scoped to any one app or Mode. See
`agent-harness/artifact-specs/QUESTIONS.md` for the full rules governing classification, ID scheme, dedup,
non-deletion, and the Idea-vs-Question distinction — this file is schema and examples only.

Split across three files, one per status — a row moves file when its status changes, keeping its ID:

- `harness-data/artifacts/questions/QUESTIONS-OPEN.md`
- `harness-data/artifacts/questions/QUESTIONS-RESOLVED.md`
- `harness-data/artifacts/questions/QUESTIONS-DISCARDED.md`

## `QUESTIONS-OPEN.md` shape

| ID | Question | Classification | Impact | Source | Notes |
| --- | --- | --- | --- | --- | --- |
| Q-001 | | local / cross-artifact / systemic | active / none | | |

`Source`: the artifact or transcript whose evidence raised this question (e.g. `TRANSCRIPT-NNN`, `IDEA-NNN`,
`UC-NNN`, `LF-<APP>-NNN`) — link bidirectionally at authoring time by also adding this ID to the source
artifact's own Open Questions section. `Impact`: `active` (currently degrading a running system) or `none` —
see `agent-harness/artifact-specs/QUESTIONS.md`'s `QST-10-010`.

## `QUESTIONS-RESOLVED.md` / `QUESTIONS-DISCARDED.md` shape

Table, parallel in spirit to the Open shape but with the decision recorded, not the original question.

| ID | Decision | Source | Notes |
| --- | --- | --- | --- |
| Q-001 | | | |

`Resolved`: record the actual decision (not the original question), citing what settled it in `Notes`.
`Discarded`: considered and dropped without becoming a decision — record why in `Notes`. `Source`: same
semantics as the Open shape. `Impact` is not carried into these two files.
