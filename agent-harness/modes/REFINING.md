# REFINING.md

## Purpose

Refining mode derives the next artifact in the Use-Case → Spec → Task funnel from its immediate source: a Use
Case from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation; a Spec from a
Use Case; or Task(s) from a Spec — unless a lower tier is classified sufficient, per `shared-procs/RISK-TIER.md`;
when even Task-tier is classified unnecessary, the request routes to Planning-Implementation's Plan-tier entry
instead of Refining producing anything at all. This file governs the mechanical derivation activity only — the
resulting document's own schema and lifecycle rules (readiness gates, Updating rules, Output) live in the
corresponding artifact spec. Per `COR-03-090`, load both this file and the relevant artifact spec
(`agent-harness/artifact-specs/USE-CASES.md`, `agent-harness/artifact-specs/SPECS.md`, or
`agent-harness/artifact-specs/TASKS.md`) before acting — neither substitutes for the other.

## Standard-Lane Boundary

Refining is an Assured-lane and v1-compatibility workflow. For new Standard work, create a single Change Spec
instead of deriving a separate Use Case, Spec, Task, and Plan. A separate Use Case is justified only by reused
behavioral authority; a standalone Task only by independent ownership, delegation, reuse, cross-plan dependency,
or lifecycle. The Change Spec contract owns ordinary execution steps.

## Mode Story

Refining is a funnel, not three unrelated commands. A request usually arrives already carrying a risk-tier
classification from whichever mode routed it here (Partnering's `PTN-02-110`, or an earlier step in this same
funnel); each entry point's first move is to check for and reuse that classification rather than re-deriving it.
From there the agent reads the source, loads relevant accepted ADRs, and mechanically derives the next artifact's
content — stopping cleanly before implementation or before drafting anything further downstream.

## Operating Posture

Mechanical derivation, not design-from-scratch: the source material (Idea, Transcript, Use Case, Spec) already
carries the substance; Refining's job is to shape it into the next funnel artifact's form, load the relevant ADRs,
and stop at the boundary of that artifact. Every entry point accepts natural language as well as its CLI form —
the input channel does not change what the mode allows (mirrors `PTN-01-010`).

## When To Use

Use Refining once Partnering (or an earlier Refining step) has classified the request as needing a Use Case, a
Spec, or Tasks. Each entry point may also be triggered directly by natural language — an explicit instruction
naming the source and what to derive from it, e.g. "use Idea IDEA-0012 to create a Use Case," "from our Partnering
transcript and ADR-0003, extract the Use Cases we need," "create the spec for UC-0007," or "plan tasks from
SPEC-0014."

## Workflow Paths

- `/create-use-case <source-reference>`
- `/create-spec <use-case-file>`
- `/create-tasks <spec-file>`

Consumes / Produces:

- `/create-use-case`: consumes an Idea, Transcript, Partnering discussion, Legacy Finding, or existing
  documentation, at any status — `IDA-01-010`'s judgment gate still applies informally when the source is an
  Idea; produces a Use Case.
- `/create-spec`: consumes a Use Case at any status — OR, when `shared-procs/RISK-TIER.md`'s UC-Necessity Matrix
  classifies the request below UC-tier, the same source types `/create-use-case` consumes; produces a Spec.
- `/create-tasks`: consumes a Spec at any status — OR, when `RISK-TIER.md`'s Spec-Necessity Matrix classifies the
  request below Spec-tier, the same source types a Spec would have been created from; produces Task(s).

## Core Moves

### Use Case Creation (via `/create-use-case`)

0. Step 0 (`UCS-01-050`): if the source Idea already carries a `## Risk-Tier Classification` (per `IDA-05-020`)
   or the source is a Transcript/Partnering discussion where `PTN-02-110` already classified this same request,
   reuse that result per `RISK-TIER.md`'s `RSK-07-010` — otherwise run the UC-Necessity Matrix (`RSK-02-010`)
   fresh. If it classifies the request below UC-tier, stop here and proceed via `/create-spec`'s skip-path
   instead of creating a Use Case.
1. Identify the source: Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation.
2. If the source is an Idea, apply `IDA-01-010`'s judgment informally — the Problem/Opportunity should be
   concrete enough to draft a scenario from; this is no longer a formal status gate. Other source types have no
   formal readiness gate either — use the same judgment that the source material is concrete enough.
3. Read the source material.
4. Load every `fleet-wide` accepted ADR unconditionally and judge every `scoped` accepted ADR for relevance;
   record the result in `related` now (`UCS-01-040`) — before drafting the goal/scenario, not after.
5. Identify the primary actor and supporting actors.
6. Define the goal, trigger, and preconditions.
7. Write the main success scenario, alternatives, and failure paths.
8. Define non-goals and the observable outcome.
9. Carry forward relevant Questions-registry entries tied to the source artifact (`UCS-05-010`).
10. If the source is an Idea, close it per `systems/STATUS-TRANSITIONS.md`'s `STT-01-050` (status `landed`,
    `next` set to this Use Case's ID, moved to `archive/`) as part of this same action.
11. Stop before creating a Spec, Task, or Implementation Plan.

### Spec Creation (via `/create-spec`)

0. Step 0 (`SPS-01-040`): same carry-forward check as Use Case Creation's step 0, for the Spec-Necessity Matrix
   (`RSK-03-010`) — reuse an existing classification per `RSK-07-010` before running it fresh, or run it fresh
   immediately after step 0 above classified UC as not required (Spec-Necessity has not yet been checked in that
   case). If entering directly (no Use Case in hand), this is the source's first check.
1. Identify the source Use Case (any status) — unless entered via the UC-skip path (step 0 classified UC-tier
   unnecessary), in which case proceed directly from the same source types Use Case creation would have used.
2. Read the Use Case (or, on the skip-path, the source material directly).
3. Load every `fleet-wide` accepted ADR unconditionally and judge every `scoped` accepted ADR for relevance;
   record the result in `related` now (`SPS-01-030`) — before drafting scope/requirements, not after.
4. Inspect source Ideas or Legacy Findings when additional context is needed.
5. Identify problem and goal.
6. Define scope and non-goals.
7. Define functional and non-functional requirements.
8. Define acceptance criteria.
9. Identify risks and constraints.
10. Identify whether Tasks are likely required.
11. Stop before implementation.

Questions-registry carry-forward (inspecting inherited open items from the source Use Case, legacy-origin or not)
is a separate, cross-cutting concern, not part of this mechanical derivation — see
`agent-harness/artifact-specs/SPECS.md`'s `SPS-05-010`.

### Task Creation (via `/create-tasks`)

Task-necessity classification uses `shared-procs/RISK-TIER.md`'s `RSK-04-010` (Task-Necessity Matrix) — see that
file for the table. This mode's own step-0 check before running it, reached whenever `/create-tasks` is entered
via the Spec-skip path, is `TSK-01-030` in the paired rules file — there is no separate prose checklist for
`/create-tasks` (unlike Use Case and Spec creation above), so that rule is the sole statement of the check.

## Routing

When `TSK-01-030`'s check classifies Tasks as not required, or the request qualifies for "Optional" and the user
prefers the lighter path, stop Task creation and report that the request lands on Plan-tier, routing to
Planning-Implementation's natural-language entry (`IPL-08-010`) rather than creating a Task (`TSK-01-031`). This
does not apply when `/create-tasks` is entered normally from a `ready` Spec — that case's Task-necessity was
already decided when the Spec was made ready with Tasks in mind (`TSK-01-032`).

## Outputs

- Use Case: `harness-data/artifacts/use-cases/active/UC-*.md`, per `agent-harness/artifact-specs/USE-CASES.md`.
- Spec: `harness-data/artifacts/specs/active/SPEC-*.md`, per `agent-harness/artifact-specs/SPECS.md`.
- Task: `harness-data/artifacts/tasks/active/TASK-*.md`, per `agent-harness/artifact-specs/TASKS.md`.

## Examples

"Create the spec for UC-0007" — the agent reads UC-0007, loads relevant ADRs, drafts
scope/requirements/acceptance-criteria, and stops before touching code or drafting Tasks.

## Rules Map

This mode's enforceable rules live in `agent-harness/rules/modes/REFINING.md` (single paired file covering all
three entry points — `UCS-*`, `SPS-*`, and `TSK-*`; their combined count falls in the 25–35-rule band, where a
single file is the default per `IMPROVEMENT-0116`'s grouping policy, and the three clusters are not independent
enough to justify splitting — they share one funnel). Load it alongside this file whenever Refining is the
active mode.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, requirements, or Task scope that involve domain concepts, business rules, or domain-critical areas
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when scope touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) — when the source Idea or Legacy Finding carries open items that shape the Use Case being drafted
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
