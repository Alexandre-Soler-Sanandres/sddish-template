---
id: LEGACY-QUESTIONS-<APP-SLUG>-001
type: legacy-questions
status: active
title: "<app-slug> Legacy Discovery Questions"
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
legacy_source:
  - legacy/imported/<app-slug>
tags: [legacy-discovery, <app-slug>]
---

# `<app-slug>` Legacy Discovery Questions

## Open Decisions

Add or update a row when a slice raises a question. Before adding a new row, check existing rows for the same
underlying decision by content — not by which slice is currently running — and merge into the existing row (adding
an evidence pointer) instead of filing a duplicate.

Each question gets a stable ID: `Q-<APP>-NNN`, numbered once and never reused, mirroring the `LF-<APP>-NNN` finding
ID convention. IDs are permanent even if the question is later merged into another — record the merge in `Notes`
instead of deleting the row.

| ID | Question | Classification | Decision type | Area | Notes |
| --- | --- | --- | --- | --- | --- |
| Q-\<APP\>-001 |  | app-local \| cross-system \| target-product |  |  |  |

Classification: same meaning as the source map's Deferred and Cross-System Questions table — `app-local` (can be
answered from this app's evidence), `cross-system` (needs evidence from more than one app), or `target-product`
(a decision for the new system, not a fact discovery can resolve).

Decision type: what kind of open call this is, not who raised it.

- `scope-v1` — what ships first vs. what is deferred
- `preserve-vs-adapt` — keep the legacy pattern verbatim or redesign it
- `fidelity` — which legacy numeric/policy value carries forward as-is (thresholds, rate limits, TTLs)
- `naming` — renames or taxonomy changes
- `deferred-feature` — include-or-drop call on a legacy feature or scaffold

Area: a short domain tag for the app's own subsystems (defined by the app's `SOURCE-MAP.md` Code Areas, not by this
template) for filtering. Metadata only — do not create a section per area; that is the structure this template
replaces.

## Resolved Decisions

Flat list, no ID required — nothing else references a resolved decision back by ID. State the decision itself, not
the original question.

- (decision)
