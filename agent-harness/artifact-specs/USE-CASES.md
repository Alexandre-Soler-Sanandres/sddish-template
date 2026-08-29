# USE-CASES.md

## Purpose

A Use Case is the behavioral anchor at the head of the Use-Case → Spec → Task funnel — it defines who does what,
under what conditions, and with what observable outcome. It is not an implementation plan. This file is the Use
Case artifact's schema, lifecycle, and boundary rules; the mechanical activity of deriving a Use Case from its
source lives in `agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before creating or updating a
Use Case.

## Artifact Story

An Idea, Transcript, Partnering discussion, Legacy Finding, or existing doc reaches the point where it needs a
behavioral anchor. Refining derives the primary/supporting actors, goal, scenario, and failure paths; relevant
ADRs get checked and re-checked as content firms up; and once the transition rules promote it under
`agent-harness/systems/STATUS-TRANSITIONS.md`'s `STT-01-030`/`040`, the Use Case reaches `ready`, no longer a
precondition for Spec creation (`SPS-01-010`). Later significant changes can send derived artifacts back down
the funnel through the same transition system.

## Entry / Creation Paths

Created only from within Refining (`/create-use-case`).

## Sources

A Use Case is created only from within Refining (`/create-use-case`), from:

- Idea
- Transcript
- Partnering discussion
- Legacy Finding
- Existing documentation

— when `shared-procs/RISK-TIER.md`'s UC-Necessity Matrix (`RSK-02-010`) classifies a request below UC-tier, no
Use Case is created; work proceeds directly to Spec or Task creation instead (see `SPECS.md`/`TASKS.md`'s own
Sources sections) — this statement is normative, not descriptive (`UCS-01-060`; mirrors `REFINING.md`'s
`UCS-01-050`).

When creating a Use Case, check the Questions registry (`agent-harness/artifact-specs/QUESTIONS.md`) for entries
tied to the source artifact and carry forward whichever ones shape actor goals, workflow shape, scope boundaries,
alternatives, or failure paths (see `## Relationships`). This replaces inspecting legacy handoff artifacts
directly — legacy-origin entries live in the same registry as everything else once migrated.

## When To Create

For new Standard-lane work, create a separate Use Case only when its actor journey is reused by multiple changes,
crosses several components or services, or is the durable behavioral authority. Otherwise state the relevant actor,
trigger, outcome, alternatives, and failures in the Change Spec.

Create a Use Case when:

- A human actor or external system has a goal to pursue
- A decision flow or business workflow needs to be defined
- Observable behavior needs to be captured
- Alternatives or failure paths are relevant
- A recurring operational scenario exists

## When Not To Create

An ADR must never be used as a source that produces a Use Case — reference authority only (`UCS-01-020`; see
`ADR.md`'s `DEC-02-020`/`DEC-05-010`). A Use Case must not contain low-level implementation detail unless
essential to the scenario (`UCS-04-010`).

## Artifact Shape

`technical_impact` is `db-schema`/`api-contract`/empty, set via frontmatter at creation/update time
(`UCS-06-020`): `db-schema` when the Use Case implies new/changed *database-backed* persisted state — a flat-file
or other non-database write does not qualify; `api-contract` when the primary or supporting actor is another
service this monorepo/system owns and deploys, reached via a real call — external third-party actors are
excluded, since this system defines no contract for those, only a client against theirs; leave empty if neither
applies. When a Use Case's primary or supporting actor is itself a separate deployable service (not a human or
external actor), the Trigger and/or Main Success Scenario must state the interaction mechanism explicitly
(synchronous API call, async event, precomputed-and-polled read, or whichever actually applies) (`UCS-06-010`) —
never carry forward legacy phrasing such as "called directly"/"invoked by" without confirming that same
in-process assumption still holds under the target architecture (`UCS-06-011`).

## Field Semantics

- `status` — see `## Lifecycle`.
- `technical_impact` — see `## Artifact Shape`.
- `related` — accepted ADRs this Use Case depends on; see `## Relationships`.

## Body Should Include

- Primary actor
- Supporting actors
- Technical impact (see `## Artifact Shape`)
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
- behavior-shaping proof or parity obligations in `Alternatives and Failure Paths`, `Preconditions`, or
  `Open Questions`, whichever best matches their effect on the scenario
- canonical legacy IDs by reference (`CSQ-*`, `Q-<APP>-*`, `CSP-*`) instead of copied backlog text

## Lifecycle

A Use Case may be refined when new information from a Partnering session or Legacy Finding changes the scope,
open questions are resolved, or the primary actor or scenario needs correction — refining must never change the
Use Case ID, and must update the `updated` field and status as appropriate (`UCS-02-010`–`021`). A change to the
primary actor, goal, trigger, preconditions, main success scenario, or non-goals is significant; a typo,
clarification, added Open Questions reference, or `updated`-field bump is not (`UCS-02-030`). Status
transitions for this artifact — including promotion to `ready` and the effect of a later significant change —
are described in `agent-harness/systems/STATUS-TRANSITIONS.md` and enforced by the paired `STT-*` rules.

## Readiness / Acceptance

Before a transition rule promotes a Use Case to `ready`, verify the Readiness Checklist in the artifact — every
item must be checked; a single unchecked item blocks the promotion (`UCS-03-010`/`UCS-03-011`). Also re-run
three ADR checks: missed-ADR recheck against the *current* accepted-ADR list, with every `fleet-wide` ADR
present in `related` and every `scoped` ADR re-judged (`UCS-07-010`–`012`); content-drift recheck against the
Use Case's actual current content, not only its original `area` (`UCS-07-020`); and a compliance check that
every ADR cited in `related` is actually reflected in the Use Case's content (`UCS-07-030`). Also verify the
registry holds nothing unresolved that should block the advance (`UCS-05-015`). `ready` is no longer a
precondition for Spec creation (see `REFINING.md`'s `SPS-01-010`) — `STT-01-030`/`040` set it once these local
gates pass.

## Relationships

When a Use Case is created, check the Questions registry for entries tied to the source artifact — regardless of
legacy or non-legacy origin — and load any that changes actor goals, workflow shape, scope boundaries,
alternatives, or failure paths (`UCS-05-010`). Carry registry items forward by effect per `CORE.md`'s
`COR-01-120`: actor-visible uncertainty belongs in `Open Questions` as canonical Question ID references; behavior
constraints belong in the scenario, preconditions, or failure paths (`UCS-05-020`).

## Output / Location

- `harness-data/artifacts/use-cases/active/UC-*.md` (`draft`)
- `harness-data/artifacts/use-cases/ready/UC-*.md` (`ready`)
- `harness-data/artifacts/use-cases/done/UC-*.md` (`done` — still-authoritative behavior, distinct
  from closed/superseded; see `agent-harness/systems/LIFECYCLE-FOLDERS.md`)
- `harness-data/artifacts/use-cases/archive/UC-*.md` (`archived`/`rejected`)

## Template

Use `agent-harness/templates/USE-CASE-template.md` as the starting point for every new Use Case.

## Examples

A Legacy Finding establishes a recurring operator workflow with an unresolved visibility question. The agent
drafts a Use Case, carries the Question ID into `Open Questions`, sets `technical_impact` to `api-contract` since
a supporting actor is another owned service, and stops before `ready` until that Question resolves.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/USE-CASES.md` (single paired
file — at the 25-rule grouping threshold; grouping into a directory has not yet been done and is a separate
decision, not required by this rule count alone). Load it alongside `agent-harness/modes/REFINING.md`'s own
Rules Map whenever creating, updating, or approving a Use Case.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, goals, or business rules that require domain knowledge
- `harness-data/reference/ARCHITECTURE.md` — when the use case involves system boundaries or external integrations
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when the use case touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) or `REWRITE-READINESS.md` — when the Use Case is being derived from Legacy Discovery and those artifacts affect the scenario
