# USE-CASES.md

## Purpose

A Use Case is the behavioral anchor at the head of the Use-Case → Spec → Task funnel — it defines who does what,
under what conditions, and with what observable outcome. It is not an implementation plan. This file is the Use
Case artifact's schema, lifecycle, and boundary rules; the mechanical activity of deriving a Use Case from its
source lives in `agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before creating or updating a Use
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
alternatives, or failure paths (see `UCS-05-010`). This replaces inspecting legacy handoff artifacts directly —
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
| UCS-01-020 | Sources | An ADR MUST NOT be used as a source that produces a Use Case — reference authority only — see `ADR.md`'s `DEC-02-020`/`DEC-05-010` for the citation rule (accepted vs. proposed). |
| UCS-02-010 | Refining | A Use Case MAY be refined when new information from a Partnering session or Legacy Finding changes the scope, open questions are resolved, or the primary actor or scenario needs correction. |
| UCS-02-020 | Refining | Refining MUST NOT change the Use Case ID; MUST update the `updated` field and status as appropriate. |
| UCS-03-010 | Readiness-Gate | Before setting a Use Case status to `ready-for-spec`, MUST verify the Readiness Checklist in the artifact; all items must be checked, and a single unchecked item blocks the status change. |
| UCS-04-010 | Boundaries | MUST NOT contain low-level implementation detail (unless essential to the scenario). |
| UCS-05-010 | Carry-Forward | When a Use Case is created, MUST check the Questions registry for entries tied to the source artifact — regardless of legacy or non-legacy origin — and load any that changes actor goals, workflow shape, scope boundaries, alternatives, or failure paths. Before advancing to `ready-for-spec`, MUST verify the registry holds nothing unresolved that should block the advance (see `UCS-03-010`). |
| UCS-05-020 | Carry-Forward | MUST carry registry items forward by effect per `CORE.md`'s `COR-01-120`: actor-visible uncertainty belongs in `Open Questions` as canonical Question ID references; behavior constraints belong in the scenario, preconditions, or failure paths. `UCS-03-010` governs whether an unresolved reference stops advancement. |
| UCS-02-030 | Significant-Change | MUST treat a change to the primary actor, goal, trigger, preconditions, main success scenario, or non-goals as significant; a typo, clarification, added Open Questions reference, or `updated`-field bump is not. |
| UCS-02-040 | Cascade | MUST run this cascade when a significant change lands on a Use Case already at `ready-for-spec` or later: reset the Use Case to `draft`; set every Spec whose `source` includes this Use Case to `draft` (triggering that Spec's own `SPS-07-020` cascade in turn); report all affected IDs; then stop and wait for user instruction. |

## When a Use Case Changes

See `UCS-02-030` for what counts as significant, and `UCS-02-040` for the required cascade.

## Output

- `harness-data/artifacts/use-cases/active/UC-*.md`
- Use `agent-harness/templates/USE-CASE-template.md` as the starting point for every new Use Case.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, goals, or business rules that require domain knowledge
- `harness-data/reference/ARCHITECTURE.md` — when the use case involves system boundaries or external integrations
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when the use case touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) or `REWRITE-READINESS.md` — when the Use Case is being derived from Legacy Discovery and those artifacts affect the scenario
