# ADR.md

## Purpose

An ADR (Architecture Decision Record) is a settled structural or architectural decision — durable and citable,
unlike an Idea (pre-decision) or a Use Case (which cannot itself decide architecture, per `USE-CASES.md`'s
`UCS-04-010`–`030`). It is not a scenario, and it is not a hunch.

## Artifact Story

A structural or architectural decision gets reached — sometimes explicitly discussed, sometimes surfacing
incidentally inside another mode's work. Any mode may draft it as a `proposed` ADR the moment it recognizes the
decision as settled rather than still open. It stays `proposed` — citable only as pending context — until the
user explicitly confirms it, at which point it becomes `accepted`: load-bearing authority that Use Cases and
Specs may cite as settled. If the decision is later reversed, the ADR is never edited in place; a new ADR
supersedes it, and both artifacts' relationship fields update together.

## Entry / Creation Paths

Via CLI: `/create-adr` (command registration lives outside `agent-harness/`).
Via natural language: from any mode, when a settled structural/architectural decision is reached.

Unlike Use Case and Spec, authorship is not restricted to one entry point — real-world ADR practice treats
drafting as broadly proposable (`DEC-01-010`). What's restricted is acceptance, not authorship.

## Sources

An ADR may be created from:

- Partnering discussion
- Transcript
- An Idea being promoted once it's recognized as a settled decision rather than a hunch
- A Review finding that recommends an architectural change
- A Question (`agent-harness/artifact-specs/QUESTIONS.md`) that resolves toward a settled structural/architectural decision
- Any other mode where a structural decision surfaces incidentally to its main work

## When To Create

Create an ADR when:

- A structural or architectural decision has actually been settled — not merely discussed
- The decision affects service/module boundaries, data ownership, security posture, or deployment topology
- The decision needs to be citable as authority by future Use Cases, Specs, or `ARCHITECTURE.md`/`DOMAIN.md`

## When Not To Create

Do not create an ADR while the conversation is still exploring options — route to a Transcript or Idea instead —
or when the decision is about actor-visible behavior rather than structure — route to a Use Case instead
(`DEC-13-010`). An ADR must never itself trigger implementation, nor create Specs, Tasks, or Implementation Plans
directly (`DEC-02-010`), and it must never be used as a source that produces a Use Case or Spec — it is cited
only as reference authority (`DEC-02-020`; see `SPECS.md`'s `SPS-01-020`/`SPS-01-021`, `USE-CASES.md`'s
`UCS-01-020`).

## Artifact Shape

Every ADR sets `scope` to `fleet-wide` (applies to every artifact regardless of `area`) or `scoped` (applies only
where area-based relevance judgment finds it applicable) — `DEC-14-010`. `status` moves `proposed` → `accepted`,
or to `superseded`/`rejected`. Relationship fields — `related`, `supersedes`, `superseded_by`,
`derived_use_cases`, `derived_specs`, `derived_tasks` — are governed by `## Relationships` below and by
`agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md`.

## Field Semantics

- `scope: fleet-wide` — a `fleet-wide` ADR is exempt from the `derived_use_cases`/`derived_specs`/`derived_tasks`
  reverse-link bookkeeping that `scoped` ADRs carry, since its applicability is already fully expressed by the
  field itself (`RELATIONS-AND-SUPERSESSION.md`'s `DEC-07-011`, `TASKS.md`'s `TSK-05-010`).
- `scope: scoped` — applicability is judged case by case; reverse links to citing artifacts are required.
- `status` — see `## Lifecycle` below for the full transition set and gates.

## Body Should Include

- Context
- Decision
- Considered Alternatives
- Consequences
- Open Questions
- Readiness Checklist (gates advancement to `accepted`)

## Lifecycle

A new ADR is created at `proposed` (`## Output / Location`). Before setting status to `accepted`, verify the
Readiness Checklist in the artifact — an open question blocks acceptance only if answering it differently would
require rewriting the `Decision` section itself; a question that only affects implementation detail, performance
tuning, or narrower in-scope choices does not block and may remain listed (`DEC-03-010`). Status must never be
set to `accepted` without the user's explicit confirmation — never infer approval from discussion (`DEC-04-010`).
Once `accepted`, `Decision`/`Consequences` are immutable — a change of mind creates a new superseding ADR instead
of an in-place edit (`RELATIONS-AND-SUPERSESSION.md`'s `DEC-06-010`; refining `Context`/`Open Questions` before
acceptance is fine). `superseded`/`rejected` ADRs move to `archive/` together.

## Readiness / Acceptance

See `## Lifecycle`'s `DEC-03-010`/`DEC-04-010` gate — the Readiness Checklist plus explicit user confirmation are
both required before `accepted`.

## Relationships

See `agent-harness/systems/ADR-AUTHORITY.md` for the full story of how an ADR's authority propagates to
dependent Use Cases/Specs/Tasks, how relationship fields stay wired both directions, and how a decision changes
after acceptance without ever being edited in place. Locally: an ID in `related` always needs an explicit
"Relation to (ID) (type):" note (`DEC-09-010`), and load
`agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` in addition to this file whenever the ADR
supersedes another ADR, cites a `related` ADR, or settles a Questions-registry entry (`DEC-12-010`).

## Output / Location

- `harness-data/artifacts/adrs/proposed/ADR-*.md` (every new ADR starts here)
- A new ADR is created in `proposed/`. When it advances to `accepted` (per `## Lifecycle`), move it to
  `accepted/` — this is the load-bearing status that makes it citable authority, the same reason Implementation
  Plan gives `approved` its own folder rather than lumping it into `active/`. `superseded` and `rejected` ADRs
  move to `archive/` together (content preserved, per the same non-destructive precedent as `COR-01-080`) — no
  operational reason to split those two further, matching how Idea lumps `archived`/`rejected` into one
  `archive/` folder.

## Template

Use `agent-harness/templates/ADR-template.md` as the starting point for every new ADR.

## Examples

A Review finding recommends splitting a monolithic service by data ownership. The user discusses it in
Partnering, the decision is reached, and the agent drafts a `proposed` ADR from that discussion — not from the
Review finding directly, since drafting is broadly proposable from any mode once the decision is settled. The
ADR stays `proposed`, citable only as pending context, until the user explicitly confirms it.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/ADR.md` (single paired file — under
the 25-rule grouping threshold). Load it whenever creating, updating, or citing an ADR. Also load
`agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` and its paired
`agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` per `DEC-12-010` above.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when the decision involves domain concepts or business rules
- `harness-data/reference/ARCHITECTURE.md` — when the decision touches system boundaries already described there
- the Questions registry (`harness-data/artifacts/questions/`) or `CONTRACTS.md` — when the decision builds on, narrows, or overrides
  a legacy-derived decision (cite via the `legacy_refs` frontmatter field rather than restating the text)
