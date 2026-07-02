# USE-CASES.md

## Purpose

Use Case mode creates or refines Use Case artifacts.
A Use Case is a behavioral anchor — it defines who does what, under what conditions, and with what observable outcome.
It is not an implementation plan.

## Entry

Via CLI: `/tw-create-use-case`
Via natural language: explicit instruction referencing a source artifact or describing an actor goal.

## Sources

A Use Case may be created from:

- Idea
- Transcript
- Partnering discussion
- Legacy Finding
- Existing documentation

When the source is legacy evidence, also inspect the smallest relevant set of legacy handoff artifacts:

- the related app or cross-system `QUESTIONS.md` entries
- the related `PARITY-MATRIX.md` rows when they shape behavior
- the related `REWRITE-READINESS.md` note only when it clarifies whether the topic is ready for design

## When to Create a Use Case

Create a Use Case when:

- A human actor or external system has a goal to pursue
- A decision flow or business workflow needs to be defined
- Observable behavior needs to be captured
- Alternatives or failure paths are relevant
- A recurring operational scenario exists

## Use Case Body Should Include

- Primary actor
- Supporting actors
- Goal
- Trigger
- Preconditions
- Main success scenario (step by step)
- Alternatives and failure paths
- Non-goals
- Observable outcome
- Open questions

When legacy evidence is involved, the body should also preserve the design-relevant carry-forward items:

- actor-visible or workflow-shaping open decisions in `Open Questions`
- behavior-shaping proof or parity obligations in `Alternatives and Failure Paths`, `Preconditions`, or `Open Questions`, whichever best matches their effect on the scenario
- canonical legacy IDs by reference (`CSQ-*`, `Q-<APP>-*`, `CSP-*`) instead of copied backlog text

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| UCS-001 | Refining | A Use Case may be refined when new information from a Partnering session or Legacy Finding changes the scope, open questions are resolved, or the primary actor or scenario needs correction. |
| UCS-002 | Refining | Refining does not change the Use Case ID. Update the `updated` field and status as appropriate. |
| UCS-003 | Readiness-Gate | Before setting a Use Case status to `ready-for-spec`, verify the Readiness Checklist in the artifact. All items must be checked. A single unchecked item blocks the status change. |
| UCS-004 | Boundaries | Do not contain low-level implementation detail (unless essential to the scenario). |
| UCS-005 | Boundaries | Do not trigger implementation. |
| UCS-006 | Boundaries | Do not create Specs, Tasks, or Implementation Plans. |
| UCS-007 | Legacy-Handoff | When a Use Case is created from legacy evidence, load the related finding plus any unresolved legacy question or parity/proof item that changes actor goals, workflow shape, scope boundaries, alternatives, or failure paths. |
| UCS-008 | Legacy-Handoff | Carry legacy items forward by effect: actor-visible uncertainty belongs in `Open Questions`; behavior constraints belong in the scenario, preconditions, or failure paths; use canonical IDs instead of restating entire legacy tables. |

## Output

- `harness-data/use-cases/active/UC-*.md`
- Use `agent-harness/templates/USE-CASE-template.md` as the starting point for every new Use Case.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, goals, or business rules that require domain knowledge
- `harness-data/reference/ARCHITECTURE.md` — when the use case involves system boundaries or external integrations
- relevant legacy `QUESTIONS.md`, `PARITY-MATRIX.md`, or `REWRITE-READINESS.md` artifacts — when the Use Case is being derived from Legacy Discovery and those artifacts affect the scenario
