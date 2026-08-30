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
supersedes it through a forward citation and typed relation note.

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
where area-based relevance judgment finds it applicable) — `DEC-14-010`. `status` moves `proposed` → `accepted`
or `archived`; an accepted ADR may become `superseded`. Canonical forward relationships are governed below and by
`agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md`.

## Field Semantics

- `scope: fleet-wide` — applies to every artifact regardless of area.
- `scope: scoped` — applicability is judged case by case; consumers cite it in `related_adrs`.
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
acceptance is fine). Rejected proposals use `archived`; every transition updates the stable file in place.

## Readiness / Acceptance

See `## Lifecycle`'s `DEC-03-010`/`DEC-04-010` gate — the Readiness Checklist plus explicit user confirmation are
both required before `accepted`.

## Relationships

See `agent-harness/systems/ADR-AUTHORITY.md` for the full story of how an ADR's authority propagates to
dependent Use Cases/Specs/Tasks, how backlinks are derived from forward citations, and how a decision changes
after acceptance without ever being edited in place. Locally: an ID in `related_adrs` always needs an explicit
"Relation to (ID) (type):" note (`DEC-09-010`), and load
`agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` in addition to this file whenever the ADR
supersedes another ADR, cites a related ADR, or settles a Questions-registry entry (`DEC-12-010`).

## Output / Location

- `harness-data/artifacts/adrs/ADR-*.md` (every new ADR starts here)
- Every ADR status updates this stable file in place. `accepted` is the load-bearing state; rejected proposals
  become `archived`, and replaced accepted ADRs become `superseded`.

## Template

Use `agent-harness/templates/ADR-template.md` as the starting point for every new ADR.

## Examples

A Review finding recommends splitting a monolithic service by data ownership. The user discusses it in
Partnering, the decision is reached, and the agent drafts a `proposed` ADR from that discussion — not from the
Review finding directly, since drafting is broadly proposable from any mode once the decision is settled. The
ADR stays `proposed`, citable only as pending context, until the user explicitly confirms it.

## Rules

| ID | Rule |
| --- | --- |
| DEC-01-010 | Any mode MAY identify and draft a candidate ADR at status `proposed` when it surfaces a settled structural/architectural decision. |
| DEC-02-010 | An ADR MUST NOT itself trigger implementation, nor create Specs, Tasks, or Implementation Plans directly. |
| DEC-02-020 | An ADR MUST NOT be used as a source that produces a Use Case or Spec — it is cited only as reference authority by Use Cases and Specs (see `SPECS.md`'s `SPS-01-020`, `USE-CASES.md`'s Sources). |
| DEC-03-010 | Before setting status to `accepted`, MUST verify the Readiness Checklist in the artifact. An open question blocks acceptance only if answering it differently would require rewriting the `Decision` section itself; a question that only affects implementation detail, performance tuning, or narrower in-scope choices does not block and may remain listed. |
| DEC-04-010 | Status MUST NOT be set to `accepted` without the user's explicit confirmation — do not infer approval from discussion. |
| DEC-05-010 | Use Cases and Specs MAY cite only `accepted` ADRs as settled authority. |
| DEC-05-020 | A `proposed` ADR MAY be noted as pending context. |
| DEC-05-030 | A `proposed` ADR MUST NOT be treated as settled. |
| DEC-12-010 | MUST load `agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` when the ADR supersedes another ADR, cites `related_adrs`, or settles a Question. |
| DEC-13-010 | MUST NOT create an ADR while the conversation is still exploring options (route to a Transcript or Idea instead) or when the decision is about actor-visible behavior (route to a Use Case instead). |
| DEC-14-010 | Every ADR MUST set `scope` to `fleet-wide` or `scoped`; consumers express applicability through forward `related_adrs` citations. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when the decision involves domain concepts or business rules
- `harness-data/reference/ARCHITECTURE.md` — when the decision touches system boundaries already described there
- the Questions registry (`harness-data/artifacts/questions/`) or `CONTRACTS.md` — when the decision builds on, narrows, or overrides
  a legacy-derived decision (cite canonical artifact or Question IDs rather than restating the text)
