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
   reuse that result per `RISK-TIER.md`'s `RSK-07-010-v1` — otherwise run the UC-Necessity Matrix (`RSK-02-010-v1`)
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
10. If the source is an Idea, close it per `systems/STATUS-TRANSITIONS.md`'s `STT-01-050-v1` (status `landed`,
    `next` set to this Use Case's ID, moved to `archive/`) as part of this same action.
11. Stop before creating a Spec, Task, or Implementation Plan.

### Spec Creation (via `/create-spec`)

0. Step 0 (`SPS-01-040`): same carry-forward check as Use Case Creation's step 0, for the Spec-Necessity Matrix
   (`RSK-03-010-v1`) — reuse an existing classification per `RSK-07-010-v1` before running it fresh, or run it fresh
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

Task-necessity classification uses `shared-procs/RISK-TIER.md`'s `RSK-04-010-v1` (Task-Necessity Matrix) — see that
file for the table. This mode's own step-0 check before running it, reached whenever `/create-tasks` is entered
via the Spec-skip path, is `TSK-01-030` in `TASKS.md``s `## Rules` section — there is no separate prose checklist for
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

## Rules

| ID | Rule |
| --- | --- |
| RFD-00-010 | MUST use `CHANGE-SPEC.md` rather than the v1 derivation funnel for new Standard-lane work. |
| RFD-00-020 | MUST create a separate Use Case only for reused behavioral authority or a standalone Task only for independent ownership, delegation, reuse, cross-plan dependency, or lifecycle. |
| UCS-01-010 | A Use Case MUST be created from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation. |
| UCS-01-011 | MAY create a Use Case from an Idea at any status — `IDA-01-010`'s judgment gate still applies. |
| UCS-01-012 | When `RISK-TIER.md`'s UC-Necessity Matrix (`RSK-02-010-v1`) classifies the request below UC-tier, `/create-spec` MAY be entered directly, skipping Use Case creation. |
| UCS-01-030 | For source types other than an Idea, which have no formal status gate, the agent SHOULD use judgment that the source material is concrete enough to draft a scenario from. |
| UCS-01-040 | MUST load every `fleet-wide` accepted ADR unconditionally and judge every `scoped` accepted ADR for relevance before drafting a Use Case's content, recording the result in `related` at creation time — `UCS-07-010`/`UCS-07-020`/`UCS-07-030` (in `USE-CASES.md`) remain the final verification pass, not the first point of contact. |
| UCS-01-050 | Before starting Use Case creation or entering Refining at a lower tier: if the source Idea already carries a `## Risk-Tier Classification` (per `IDA-05-020`) or the source is a Transcript/Partnering discussion where `PTN-02-110` already classified this same request, MUST reuse that result per `RISK-TIER.md`'s `RSK-07-011-v1`/`RSK-07-012-v1`. This is step 0 of both the Use Case and Spec creation checklists in `REFINING.md`'s `## Core Moves`. |
| UCS-01-051 | Otherwise MUST run the UC-Necessity Matrix (`RSK-02-010-v1`) fresh. |
| UCS-04-020 | MUST NOT trigger implementation. |
| UCS-04-021 | MUST NOT create Specs, Tasks, or Implementation Plans from Use Case creation. |
| SPS-01-010 | MAY create a Spec from a Use Case at any status. |
| SPS-01-012 | When `RISK-TIER.md`'s Spec-Necessity Matrix (`RSK-03-010-v1`) classifies the request below Spec-tier, `/create-tasks` MAY be entered directly, skipping Spec creation. |
| SPS-01-030 | MUST load every `fleet-wide` accepted ADR unconditionally and judge every `scoped` accepted ADR for relevance before drafting a Spec's content, recording the result in `related` at creation time — `SPS-08-010`/`SPS-08-020`/`SPS-08-030` (in `SPECS.md`) remain the final verification pass, not the first point of contact. |
| SPS-01-040 | Same carry-forward check as `UCS-01-050`, for the Spec-Necessity Matrix (`RSK-03-010-v1`) — reuse an existing classification per `RSK-07-011-v1`/`RSK-07-012-v1` before running it fresh (or immediately after `UCS-01-050` classifies UC as not required, in which case Spec-Necessity has not yet been checked and MUST run). |
| SPS-04-010 | MUST NOT implement or change code while creating a Spec. |
| SPS-04-011 | MUST NOT create Tasks or Implementation Plans while creating a Spec. |
| TSK-01-010 | MAY create Tasks from a Spec at any status. |
| TSK-01-012 | When `RISK-TIER.md`'s Spec-Necessity Matrix already classified the request below Spec-tier and `TSK-01-030`'s Task-Necessity check requires a Task, it MAY be entered directly. |
| TSK-01-020 | Task-necessity classification uses `RISK-TIER.md`'s `RSK-04-010-v1` matrix — see `REFINING.md`'s `## Core Moves` for this file's own step-0 pointer. |
| TSK-01-030 | Step 0 of Task creation, mirroring `UCS-01-050`/`SPS-01-040` — reached whenever `/create-tasks` is entered via the Spec-skip path (i.e. `SPS-01-040` already classified Spec as not required). If the source already carries a recorded Task-Necessity result, MUST reuse it per `RSK-07-011-v1`/`RSK-07-012-v1`. |
| TSK-01-033 | Otherwise MUST run `RSK-04-010-v1` fresh, per `RSK-07-021-v1`'s full-cascade-completion rule — Spec-Necessity saying "No" is not itself grounds to create a Task. |
| TSK-01-031 | If `TSK-01-030`'s check classifies Tasks as not required (`RSK-04-010-v1`'s "No" rows) or the request qualifies for "Optional" and the user prefers the lighter path, MUST stop Task creation and instead report that the request lands on Plan-tier, routing to Planning-Implementation's natural-language entry (`IPL-08-010`) rather than creating a Task. |
| TSK-01-032 | `TSK-01-030`/`TSK-01-031` do not apply when `/create-tasks` is entered normally from a `ready` Spec (`TSK-01-010`'s unconditional path) — that case's Task-necessity was already decided when the Spec was made ready with Tasks in mind. |
| TSK-03-010 | MUST NOT implement or change code while creating Tasks. |
| TSK-03-011 | MUST NOT create Implementation Plans while creating Tasks. |
| TSK-04-010 | MUST verify existing Tasks derived from that Spec before generating Tasks from a Spec — via this entry point directly, not only when Planning-Implementation happens to check first. |
| TSK-04-011 | MUST NOT generate duplicate Tasks or skip existing ones per `TSK-04-010`'s check. This rule is owned here, not borrowed from `PLANNING-IMPLEMENTATION.md`'s `IPL-03-010`, so `/create-tasks` is protected regardless of entry path. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, requirements, or Task scope that involve domain concepts, business rules, or domain-critical areas
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when scope touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) — when the source Idea or Legacy Finding carries open items that shape the Use Case being drafted
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
