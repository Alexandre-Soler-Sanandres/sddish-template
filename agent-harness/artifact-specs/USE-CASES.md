# USE-CASES.md

## Purpose

A Use Case is the behavioral anchor at the head of the Use-Case → Spec → Task funnel — it defines who does what,
under what conditions, and with what observable outcome. It is not an implementation plan. This file is the Use
Case artifact's schema, lifecycle, and boundary rules; the mechanical activity of deriving a Use Case from its
source lives in `agent-harness/modes/REFINING.md` — load both (per `COR-058`) before creating or updating a Use
Case.

## Sources

A Use Case is created only from within Refining (`/create-use-case`), from:

- Idea
- Transcript
- Partnering discussion
- Legacy Finding
- Existing documentation

When creating a Use Case, check the Questions registry (`agent-harness/artifact-specs/QUESTIONS.md`) for entries
tied to the source artifact and carry forward whichever ones shape actor goals, workflow shape, scope boundaries,
alternatives, or failure paths (see `UCS-007`). This replaces inspecting legacy handoff artifacts directly —
legacy-origin entries live in the same registry as everything else once migrated.

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
| UCS-007 | Carry-Forward | When a Use Case is created, check the Questions registry for entries tied to the source artifact — regardless of legacy or non-legacy origin — and load any that changes actor goals, workflow shape, scope boundaries, alternatives, or failure paths. Before advancing to `ready-for-spec`, verify the registry holds nothing unresolved that should block the advance (see `UCS-003`). |
| UCS-008 | Carry-Forward | Carry registry items forward by effect: actor-visible uncertainty belongs in `Open Questions`; behavior constraints belong in the scenario, preconditions, or failure paths; cite the registry's canonical ID instead of restating its full text. |
| UCS-009 | Sources | ADRs are cited as reference authority when a Use Case touches a system boundary or structural decision they settle — only `accepted` ADRs count as settled authority, a `proposed` ADR may be noted as pending context but not treated as settled (`DEC-008`); an ADR is never itself a source that produces a Use Case (`DEC-003`). |

## Output

- `harness-data/artifacts/use-cases/active/UC-*.md`
- Use `agent-harness/templates/USE-CASE-template.md` as the starting point for every new Use Case.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, goals, or business rules that require domain knowledge
- `harness-data/reference/ARCHITECTURE.md` — when the use case involves system boundaries or external integrations
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when the use case touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) or `REWRITE-READINESS.md` — when the Use Case is being derived from Legacy Discovery and those artifacts affect the scenario
