# ADR.md

## Purpose

ADR mode creates or refines Architecture Decision Record artifacts.
An ADR is a settled structural or architectural decision — durable and citable, unlike an Idea (pre-decision) or
a Use Case (which cannot itself decide architecture, per `USE-CASES.md`'s `UCS-04-010`–`030`).
It is not a scenario, and it is not a hunch.

## Entry

Via CLI: `/create-adr` (command registration lives outside `agent-harness/`).
Via natural language: from any mode, when a settled structural/architectural decision is reached.

Unlike Use Case and Spec, authorship is not restricted to one entry point — real-world ADR practice treats
drafting as broadly proposable (see `DEC-01-010`). What's restricted is acceptance, not authorship.

## Sources

An ADR may be created from:

- Partnering discussion
- Transcript
- An Idea being promoted once it's recognized as a settled decision rather than a hunch
- A Review finding that recommends an architectural change
- A Question (`agent-harness/artifact-specs/QUESTIONS.md`) that resolves toward a settled structural/architectural decision
- Any other mode where a structural decision surfaces incidentally to its main work

## When to Create an ADR

Create an ADR when:

- A structural or architectural decision has actually been settled — not merely discussed
- The decision affects service/module boundaries, data ownership, security posture, or deployment topology
- The decision needs to be citable as authority by future Use Cases, Specs, or `ARCHITECTURE.md`/`DOMAIN.md`

See `DEC-13-010` for what routes elsewhere instead.

## Body Should Include

- Context
- Decision
- Considered Alternatives
- Consequences
- Open Questions
- Readiness Checklist (gates advancement to `accepted`)

## Rules

See `DEC-12-010` for when to load `agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md`
(`DEC-06-010`–`DEC-11-010` live there).

| ID | Type | Rule |
| --- | --- | --- |
| DEC-01-010 | Sources | Any mode MAY identify and draft a candidate ADR at status `proposed` when it surfaces a settled structural/architectural decision. |
| DEC-02-010 | Boundaries | An ADR MUST NOT itself trigger implementation, nor create Specs, Tasks, or Implementation Plans directly. |
| DEC-02-020 | Boundaries | An ADR MUST NOT be used as a source that produces a Use Case or Spec — it is cited only as reference authority by Use Cases and Specs (see `SPECS.md`'s `SPS-01-020`, `USE-CASES.md`'s Sources). |
| DEC-03-010 | Readiness-Gate | Before setting status to `accepted`, MUST verify the Readiness Checklist in the artifact. An open question blocks acceptance only if answering it differently would require rewriting the `Decision` section itself; a question that only affects implementation detail, performance tuning, or narrower in-scope choices does not block and may remain listed. |
| DEC-04-010 | Approval | Status MUST NOT be set to `accepted` without the user's explicit confirmation — do not infer approval from discussion. |
| DEC-05-010 | Citation-Gate | Use Cases and Specs MAY cite only `accepted` ADRs as settled authority. |
| DEC-05-020 | Citation-Gate | A `proposed` ADR MAY be noted as pending context. |
| DEC-05-030 | Citation-Gate | A `proposed` ADR MUST NOT be treated as settled. |
| DEC-12-010 | Context-Loading | MUST load `agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` in addition to this file when the ADR supersedes another ADR, cites a `related` ADR, or settles a Questions-registry entry. |
| DEC-13-010 | Creation-Gate | MUST NOT create an ADR while the conversation is still exploring options (route to a Transcript or Idea instead) or when the decision is about actor-visible behavior (route to a Use Case instead). |

## Output

- `harness-data/artifacts/adrs/proposed/ADR-*.md` (every new ADR starts here)
- Use `agent-harness/templates/ADR-template.md` as the starting point for every new ADR.
- A new ADR is created in `proposed/`. When it advances to `accepted` (per `DEC-03-010`, `DEC-04-010`), move it to
  `accepted/` — this is the load-bearing status that makes it citable authority (`DEC-05-010`), the same reason
  Implementation Plan gives `approved` its own folder rather than lumping it into `active/`. `superseded` and
  `rejected` ADRs move to `archive/` together (content preserved, per the same non-destructive precedent as
  `COR-01-080`) — no operational reason to split those two further, matching how Idea lumps `archived`/`rejected`
  into one `archive/` folder.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when the decision involves domain concepts or business rules
- `harness-data/reference/ARCHITECTURE.md` — when the decision touches system boundaries already described there
- the Questions registry (`harness-data/artifacts/questions/`) or `CONTRACTS.md` — when the decision builds on, narrows, or overrides
  a legacy-derived decision (cite via the `legacy_refs` frontmatter field rather than restating the text)
