# IDEA.md

## Purpose

An Idea is a candidate opportunity or problem worth remembering before it is mature enough to commit to a Use
Case. Ideas are meant to stay fuzzy — `maturity`/`confidence` fields exist precisely to express that. This spec is
deliberately lightweight, proportional to Idea's intentionally rough nature; do not import ADR-level rigor.

## Sources

An Idea may be created from Partnering discussion, Transcript, Review finding, or Legacy Discovery insight.

## Body Should Include

- Problem or Opportunity
- Initial Thoughts
- Open Questions
- Notes

(schema unchanged — see `agent-harness/templates/IDEA-template.md`)

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IDA-01-010 | Readiness-Gate | Before setting status to `ready-for-use-case`, judge (not checklist) whether the Problem/Opportunity is stated concretely enough that a Use Case could plausibly be drafted from it. |
| IDA-02-010 | Dedup | Before creating a new Idea, check existing `active` Ideas for overlapping Problem/Opportunity and merge instead of duplicating (scaled-down mirror of Legacy Discovery's `LD-04-020`). |
| IDA-03-010 | Boundaries | An Idea must not itself trigger implementation or create a Use Case/Spec directly; promotion to a Use Case requires explicit user confirmation, not inferred from discussion. |
| IDA-04-010 | Idea-vs-Question | An item is an Idea only if it has a candidate direction, not an open fork — see `QUESTIONS.md`'s `QST-06-010` for the exact test and how a Question resolving toward "yes, pursue this" spins off a new Idea. |
| IDA-05-010 | Carry-Forward | When an Idea is seeded from a source (Transcript, Review finding, etc.) that has its own Questions-registry entries, check the registry and note any relevant entry in this Idea's own Open Questions — informally; this does not block `captured` or `clarifying`, since Ideas are not gated the way Use Cases/Specs/ADRs are (see `IDA-01-010`). |

## Output

- `harness-data/artifacts/ideas/active/IDEA-*.md`, using `agent-harness/templates/IDEA-template.md` unchanged.
- `archived`/`rejected` Ideas move to `harness-data/artifacts/ideas/archive/` (content preserved, per `COR-01-080`).
