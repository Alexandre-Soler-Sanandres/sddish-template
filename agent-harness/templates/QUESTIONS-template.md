---
id: LEGACY-QUESTIONS-<APP-SLUG>-001
type: legacy-questions
status: active
title: "<app-slug> Legacy Discovery Questions"
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
legacy_source:
  - harness-data/legacy/imported/<app-slug>
tags: [legacy-discovery, <app-slug>]
---

# `<app-slug>` Legacy Discovery Questions

## Open Decisions

Add or update a row when a slice raises a question. Before adding a new row, check existing rows for the same
underlying decision by content — not by which slice is currently running — and merge into the existing row (adding
an evidence pointer) instead of filing a duplicate.

Each question gets a stable ID, numbered once and never reused, mirroring the finding ID convention.

- App-scoped questions use `Q-<APP>-NNN`.
- Cross-system questions use `CSQ-NNN`.

IDs are permanent even if the question is later merged into another — record the merge in `Notes` instead of
deleting the row.

| ID | Question | Classification | Decision type | Area | Source finding(s) | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Q-\<APP\>-001 / CSQ-001 |  | app-local \| cross-system \| target-product |  |  |  |  |

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

Source finding(s): one or more finding IDs whose evidence raised this question, comma-separated:
`LF-<APP>-NNN` for app-scoped questions, usually `LF-CROSS-NNN` for cross-system questions, or `baseline` /
`cross-cutting` when the question does not trace to a specific finding (broad architecture, naming, or
deployment-topology calls raised independent of any single finding). Link bidirectionally at authoring time: when you
record a question here, also add its ID to the cited finding's `## Open Questions` section.

## Resolved Decisions

Table, parallel in shape to `Open Decisions`. State the decision itself in the `Decision` column, not the original
question.

| ID | Decision | Origin | Source finding(s) | Notes |
| --- | --- | --- | --- | --- |
| Q-\<APP\>-001 / CSQ-001 |  | resolved-from-open \| baseline |  |  |

Origin:

- `resolved-from-open` — this decision was a row in `Open Decisions` and moved here on resolution, keeping the
  original ID it already had (`Q-<APP>-NNN` or `CSQ-NNN`). Findings reference it back by that ID in their own
  `## Resolved Questions` section, so the ID must stay addressable.
- `baseline` — this decision was already known/resolved before or independent of the `Open Decisions` cycle (e.g.
  captured during initial baseline discovery). Leave `ID` blank. Do not assign a new `Q-<APP>-NNN` ID to a baseline
  decision — it was never open, nothing references it by ID, and inventing one would misrepresent it as having gone
  through the `Open Decisions` cycle when it did not.

`Source finding(s)`: same semantics as the `Open Decisions` column.
