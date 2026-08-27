# IDEA Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IDA-01-010 | Readiness-Gate | Before setting status to `ready-for-refining`, MUST judge (not checklist) whether the Problem/Opportunity is stated concretely enough that a next artifact could plausibly be drafted from it — a Use Case, or, per `shared-procs/RISK-TIER.md`'s cascade, directly a Spec, Task, or Plan. |
| IDA-01-011 | Readiness-Gate | A Use Case MAY be created from this Idea regardless of status (see `UCS-01-011`). |
| IDA-01-020 | Boundaries | An Idea MUST represent one distinguishable, independently-decidable opportunity or problem — something that could be pursued or skipped on its own, separately from its neighbors. When source evidence bundles several (a roadmap table, a research-backlog document, a multi-item legacy doc), MUST split into one Idea per opportunity, not one Idea per source document. |
| IDA-01-030 | Boundaries | Genuinely interchangeable variations of the same opportunity (e.g. a list of similar technical indicators serving one purpose) MAY stay grouped as one Idea. |
| IDA-01-040 | Boundaries | A distinguishable architecture or product-shape decision MUST get its own Idea even if it is a single line in the source. |
| IDA-02-010 | Dedup | Before creating a new Idea, MUST check existing `active` Ideas for overlapping Problem/Opportunity and merge instead of duplicating (scaled-down mirror of Legacy Discovery's `LD-04-020`). |
| IDA-03-010 | Boundaries | An Idea MUST NOT itself trigger implementation, or create a Use Case, Spec, Task, or Plan directly — promotion requires explicit user confirmation, not inferred from discussion; per `shared-procs/RISK-TIER.md`'s cascade, that promotion may land on any tier, not only a Use Case. |
| IDA-04-010 | Idea-vs-Question | MUST classify an item as an Idea only if it has a candidate direction, not an open fork — see `QUESTIONS.md`'s `QST-06-010` for the exact test and how a Question resolving toward "yes, pursue this" spins off a new Idea. |
| IDA-05-010 | Carry-Forward | When an Idea is seeded from a source (Transcript, Review finding, etc.) that has its own Questions-registry entries, SHOULD note the relevant canonical Question ID(s) in this Idea's own Open Questions per `CORE.md`'s `COR-01-120` — informally; this has no effect on `captured` or `clarifying` status, since Ideas are not gated the way Use Cases/Specs/ADRs are (see `IDA-01-010`). |
| IDA-05-020 | Carry-Forward | When `PTN-02-110` classifies this Idea's next step and the Idea is not promoted in the same action, MUST record that classification in this Idea's own `## Risk-Tier Classification` section, per `shared-procs/RISK-TIER.md`'s `RSK-07-010` — the artifact that eventually promotes this Idea then carries the classification forward from here rather than re-running the cascade. |
