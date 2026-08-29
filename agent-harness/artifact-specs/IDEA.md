# IDEA.md

## Purpose

An Idea is a candidate opportunity or problem worth remembering before it is mature enough to commit to a Use
Case. Ideas are meant to stay fuzzy — `maturity`/`confidence` fields exist precisely to express that. This
contract is deliberately lightweight, proportional to Idea's intentionally rough nature; do not import
ADR-level rigor.

## Artifact Story

Something worth remembering surfaces — in Partnering, in a Review finding, in Legacy Discovery — but isn't yet
concrete enough to draft a Use Case from. The agent captures it as an Idea and lets it stay `captured` or
`clarifying` while it firms up. Once it's concrete enough to act on, promotion to the next funnel artifact
(Use Case, or a lower tier per the risk-tier cascade) requires the user's explicit confirmation — the Idea is
never silently promoted from discussion alone. Once promoted or merged into an existing artifact, the Idea
closes: `landed`, pointing at whatever it became.

## Entry / Creation Paths

Created inline from whichever mode surfaces it — no dedicated CLI command or mode switch required.

## Sources

An Idea may be created from Partnering discussion, Transcript, Review finding, or Legacy Discovery insight.

## When To Create

Create an Idea only when the user requests durable backlog storage or a candidate opportunity needs to survive as
a future option; a deferred non-goal alone is not enough.

Create an Idea when a candidate opportunity or problem has a direction worth remembering but is not yet mature
enough to commit to a Use Case — see `QUESTIONS.md`'s `QST-06-010` for the exact test distinguishing a candidate
direction (Idea) from an unresolved fork (Question).

## When Not To Create

Do not classify an item as an Idea if it is an open fork with no proposed solution yet — that is a Question, not
an Idea (`IDA-04-010`). Do not create a new Idea when an existing `active` Idea already covers the same
Problem/Opportunity — merge into it instead (`IDA-02-010`). An Idea must never itself trigger implementation, or
create a Use Case, Spec, Task, or Plan directly (`IDA-03-010`).

## Artifact Shape

`status` is one of `captured | clarifying | ready-for-refining | landed | archived | rejected`. `landed` and
`archived` both leave `active/` but mean opposite outcomes: `archived` is a dead end (superseded by a split per
`IDA-01-020`, or rejected outright — `rejected` is the sharper-worded variant of the same dead-end family);
`landed` means the Idea's content is now inside a Use Case or Spec and no longer a candidate to evaluate on its
own (see `## Lifecycle`).

## Field Semantics

- `status` — see `## Artifact Shape` for the enum and `## Lifecycle` for transitions.
- `next` — populated only when closing per `STT-01-050-v1` (see `## Lifecycle`), pointing at the citing artifact's ID.
- `## Risk-Tier Classification` (optional body section) — see `IDA-05-020`: records the classification when
  `PTN-02-110` classifies this Idea's next step and the Idea is not promoted in the same action, so the artifact
  that eventually promotes this Idea carries the classification forward rather than re-running the cascade.

## Body Should Include

- Problem or Opportunity
- Initial Thoughts
- Open Questions
- Notes
- Risk-Tier Classification (optional — see `IDA-05-020`)

(schema unchanged — see `agent-harness/templates/IDEA-template.md`)

## Lifecycle

Before setting status to `ready-for-refining`, judge (not checklist) whether the Problem/Opportunity is stated
concretely enough that a next artifact could plausibly be drafted from it — a Use Case, or, per
`shared-procs/RISK-TIER.md`'s cascade, directly a Spec, Task, or Plan (`IDA-01-010`). When `/create-use-case`,
or (skip-path) `/create-spec`/`/create-tasks`, or a direct Planning-Implementation entry successfully creates
the next artifact from this Idea, or when this Idea's content is incorporated as an in-place amendment to an
already-existing Use Case or Spec, `STT-01-050-v1` closes the Idea in the same action: `status: landed`, `next`
set to the citing artifact's ID, moved to `archive/`. This does not wait for the citing artifact to reach
`done`.

## Readiness / Acceptance

See `## Lifecycle`'s `IDA-01-010` judgment gate for `ready-for-refining`. This status is no longer a precondition
for Use Case creation — see `REFINING.md`'s `UCS-01-011` — it remains available for tracking an Idea's own
maturity, but promotion is gated only by `IDA-01-010`'s judgment call (informally, regardless of whether this
status was ever formally set) and `RISK-TIER.md`. Promotion to the next funnel artifact requires explicit user
confirmation, never inferred from discussion (`IDA-03-010`).

## Relationships

An Idea seeded from a source (Transcript, Review finding, etc.) that has its own Questions-registry entries
should note the relevant canonical Question ID(s) in this Idea's own Open Questions per `CORE.md`'s `COR-01-120`
— informally; this has no effect on `captured` or `clarifying` status, since Ideas are not gated the way Use
Cases/Specs/ADRs are (`IDA-05-010`).

## Output / Location

- `harness-data/artifacts/ideas/active/IDEA-*.md`, using `agent-harness/templates/IDEA-template.md` unchanged.
- `landed`/`archived`/`rejected` Ideas move to `harness-data/artifacts/ideas/archive/` (content preserved, per
  `COR-01-080`).

## Template

Use `agent-harness/templates/IDEA-template.md` unchanged.

## Examples

A Review finding notes that a legacy retry policy might be worth generalizing across services. The agent captures
it as an Idea (`captured`), and once discussion firms up which services and what trigger conditions apply —
enough that `IDA-01-010`'s judgment is satisfied — promotes it via `/create-use-case` on the user's explicit
confirmation; the Idea need not first be moved to `ready-for-refining`, though it may be if useful for tracking
maturity.

## Rules

| ID | Rule |
| --- | --- |
| IDA-00-010 | MUST create an Idea only for requested durable backlog storage or a future opportunity that needs persistence; MUST NOT turn every deferred item or non-goal into an Idea. |
| IDA-01-010 | Before setting status to `ready-for-refining`, MUST judge (not checklist) whether the Problem/Opportunity is stated concretely enough that a next artifact could plausibly be drafted from it — a Use Case, or, per `shared-procs/RISK-TIER.md`'s cascade, directly a Spec, Task, or Plan. |
| IDA-01-011 | A Use Case MAY be created from this Idea regardless of status (see `UCS-01-011`). |
| IDA-01-020 | An Idea MUST represent one distinguishable, independently-decidable opportunity or problem — something that could be pursued or skipped on its own, separately from its neighbors. When source evidence bundles several (a roadmap table, a research-backlog document, a multi-item legacy doc), MUST split into one Idea per opportunity, not one Idea per source document. |
| IDA-01-030 | Genuinely interchangeable variations of the same opportunity (e.g. a list of similar technical indicators serving one purpose) MAY stay grouped as one Idea. |
| IDA-01-040 | A distinguishable architecture or product-shape decision MUST get its own Idea even if it is a single line in the source. |
| IDA-02-010 | Before creating a new Idea, MUST check existing `active` Ideas for overlapping Problem/Opportunity and merge instead of duplicating (scaled-down mirror of Legacy Discovery's `LD-04-020`). |
| IDA-03-010 | An Idea MUST NOT itself trigger implementation, or create a Use Case, Spec, Task, or Plan directly — promotion requires explicit user confirmation, not inferred from discussion; per `shared-procs/RISK-TIER.md`'s cascade, that promotion may land on any tier, not only a Use Case. |
| IDA-04-010 | MUST classify an item as an Idea only if it has a candidate direction, not an open fork — see `QUESTIONS.md`'s `QST-06-010` for the exact test and how a Question resolving toward "yes, pursue this" spins off a new Idea. |
| IDA-05-010 | When an Idea is seeded from a source (Transcript, Review finding, etc.) that has its own Questions-registry entries, SHOULD note the relevant canonical Question ID(s) in this Idea's own Open Questions per `CORE.md`'s `COR-01-120` — informally; this has no effect on `captured` or `clarifying` status, since Ideas are not gated the way Use Cases/Specs/ADRs are (see `IDA-01-010`). |
| IDA-05-020 | When `PTN-02-110` classifies this Idea's next step and the Idea is not promoted in the same action, MUST record that classification in this Idea's own `## Risk-Tier Classification` section, per `shared-procs/RISK-TIER.md`'s `RSK-07-010-v1` — the artifact that eventually promotes this Idea then carries the classification forward from here rather than re-running the cascade. |

## Reference Files

None beyond the template — Ideas are intentionally lightweight and rarely need reference-doc context of their
own before promotion.
