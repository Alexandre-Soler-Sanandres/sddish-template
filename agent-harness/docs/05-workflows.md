# Workflows

This file is the practical "what happens next?" guide.
Use this guide when you already understand the artifact types and want the normal operating flow explained clearly.

## The Standard Flow

```text
Voice / Text / Ideas
  → Partnering (TRANSCRIPT, IDEA, ADR when a structural decision settles)
  → Refining: Idea/Transcript/Partnering discussion/Legacy Finding/docs → Use Case (UC-*)
  → Refining: Use Case → Spec (SPEC-*)
  → Refining: Spec → Tasks (TASK-*) — when required
  → Planning-Implementation (PLAN-*)
  → Implementing
  → Validation (shared procedure, invoked from within Implementing)
  → [Review / Improving-Harness — when a team wants formal evaluation or process correction]
```

A Question (`harness-data/artifacts/questions/`) may be raised from any point in this flow without switching
mode — it does not appear as its own step above because it is not a stage the work passes through, but a
cross-cutting registry any mode can write to.

In plain terms:

- Partnering helps when the request is still fuzzy.
- Refining derives a Use Case from an Idea/Transcript/Partnering discussion/Legacy Finding/existing docs, a Spec
  from a Use Case, and Tasks from a Spec — these make the intended behavior explicit and, when needed, break it
  into execution slices.
- Planning-Implementation is the gate that turns requirements into an approved path.
- Implementing executes that path.
- Validation checks that the result and the process both hold up.

## Partnering Workflow

Partnering is the front door for unclear thinking. It listens, captures Transcripts and Ideas, and identifies
(without drafting) candidate ADRs and Use Cases. It must not create Use Cases, Specs, Tasks, or Implementation
Plans, or infer approval from discussion. See `agent-harness/modes/PARTNERING.md` for the full rule set.

## ADR Creation

An ADR is appropriate when the conversation reaches a settled structural or architectural decision — not an
actor-goal scenario (that's a Use Case) and not an early hunch (that's an Idea). Unlike Use Case and Spec, an ADR
is not restricted to originating from one mode: any mode may draft a candidate ADR at status `proposed` when it
surfaces one. What's restricted is not authorship, but acceptance — an ADR only becomes citable authority once
its Readiness Checklist passes and the user has explicitly confirmed `accepted` status. See
`agent-harness/artifact-specs/ADR.md` for the full rule set.

## Use Case Creation

A Use Case is appropriate when a human actor or external system has a goal to pursue, a decision flow or
business workflow needs to be defined, or observable behavior/failure paths need to be captured. Created via
Refining (`/create-use-case`) from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing
documentation. See `agent-harness/modes/REFINING.md`'s "Use Case Creation Should" for the full procedure.

## Spec Creation

A Spec is created via Refining (`/create-spec`) from a Use Case at `ready-for-spec`. See
`agent-harness/modes/REFINING.md`'s "Spec Creation Should" for the full procedure.

## Are Tasks Required?

Not permission to skip planning entirely — if Tasks aren't required, the work still needs an Implementation
Plan. See `agent-harness/modes/REFINING.md`'s Task Decision Matrix for the full decision table (small,
single-area changes usually don't need separate Tasks; anything high-risk, multi-file, or crossing a Use
Case/Spec boundary does).

### Inline Plan Without Task Artifacts

For small, low-risk, single-area Specs, an Implementation Plan may contain inline steps without separate Task artifacts if:

- The Spec is approved
- Acceptance criteria are clear
- Validation is clear
- Expected changes are small
- No high-risk area is involved
- No separate review boundaries are needed

Inline steps must still define: expected files, validation, risk level, and a suggested commit boundary.

Good fit:

- one small doc change
- one isolated config change
- one contained bugfix with obvious validation

Bad fit:

- changes that span multiple subsystems
- work with risky rollout or safety implications
- anything that would be easier to review in slices

## Planning-Implementation

Three entry points, each verifying its source artifact's maturity before creating a Plan and waiting for
approval: `/plan-task` (focused plan for one ready Task), `/plan-spec` (finds/applies the Task Decision Matrix,
then plans), `/plan-use-case` (finds all derived Specs and Tasks, plans end-to-end). If a prerequisite is
missing, the agent stops and routes to the correct upstream step. See
`agent-harness/modes/PLANNING-IMPLEMENTATION.md` for entry points and routing, and
`agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md` for grouping rules and the commit message convention.

## Implementation Execution

Executes one plan step at a time by default, updates Task/Plan status as it goes, runs technical checks (from
`QUALITY.md`/`TOOLING.md`) after each step, and stops on out-of-scope validation failure, missing/contradictory
requirements, or an uncovered high-risk area. See `agent-harness/modes/IMPLEMENTING.md` for the full rule set.

### Optional Operational Trace

`harness-data/RUN-LOG.md` is not required by default, but the agent may use it for interrupted, approval-heavy,
multi-step, or high-risk work. One case is mandatory rather than optional: `IMPL-028` requires a gate-check line
(Plan ID, Plan status, Task `allowed_paths`) written to `RUN-LOG.md` before the first file mutation of any plan step.

It is temporary operational state, not a source-of-truth artifact — durable decisions and outcomes must still be
written back into the real artifacts, and the agent should collapse or clear it once work finishes. Most work
does not need a run log; reach for it when a future resume would otherwise depend on fragile chat memory. See
`agent-harness/CORE.md`'s Observability and Pause-Resume rules for the full behavior.

## Validation and Quality

**Validation** (a shared procedure, not a mode or artifact — invoked by name from within Implementing and
Improving-Harness) covers: artifact completeness, process rule compliance, acceptance criteria, readiness checks.
It is universal and does not contain project-specific commands.

**Technical checks** (tests, linting, typing, migrations) are project-specific. They are defined in `harness-data/reference/QUALITY.md` and run using commands from `harness-data/reference/TOOLING.md`.

Short version:

- Validation asks "did we follow the process, and is the behavior verifiable?"
- Implementing asks "did we run the actual project checks?"

## Readiness Gates

Every artifact has a gate status. Before the agent advances an artifact past its gate, it must
verify every item in the artifact's Readiness Checklist. A single unchecked item blocks the
status change.

| Artifact | Gate status | Checklist location |
| --- | --- | --- |
| Use Case | `ready-for-spec` | `## Readiness Checklist` in the artifact |
| Spec | `approved` | `## Readiness Checklist` in the artifact |
| Task | `ready` | `## Readiness Checklist` in the artifact |
| Implementation Plan | `approved` | `## Readiness Checks` in the artifact |

## Review and Improving-Harness

Every significant artifact or implementation should be reviewable. For teams that want a lighter default flow, Review
and Improving-Harness are optional advanced disciplines rather than a mandatory everyday step. See
`agent-harness/artifact-specs/REVIEW.md` for the two flavors, outcomes, and required actions.

If a process problem is found:

```text
Review → Improvement artifact → approved harness change → updated harness files
```

Improvement artifacts must originate from Review findings — not from Partnering or direct requests. That
stricter loop exists to keep harness changes deliberate and reviewable instead of being mixed into unrelated
work. See `agent-harness/modes/IMPROVING-HARNESS.md`.

## Legacy Discovery Flow

For the practical step-by-step legacy application playbook, see
[09-legacy-applications.md](09-legacy-applications.md).

```text
harness-data/artifacts/legacy/imported/old-project
  → legacy inventory
  → source maps
  → findings (LEGACY-FINDING-*)
  → Refining: Legacy Finding → Use Case (once evidence is strong enough)
  → Specs (only when evidence is strong enough — directly from Legacy Discovery is the rare exception)
  → Tasks if required
  → Implementation Plan
```

The legacy project is evidence, not authority. The agent must never treat legacy code as automatically correct.

## End-to-End Example: Voice to Implementation

1. User speaks — agent records `TRANSCRIPT-001`
2. Agent identifies candidate idea — creates `IDEA-018`
3. Partnering session clarifies the problem
4. Refining creates a Use Case from the Idea — `UC-011` at status `ready-for-spec`
5. Spec created — `SPEC-021` reviewed and approved
6. Task Decision Matrix applied — Tasks required
7. Tasks created — `TASK-071`, `TASK-072`, `TASK-073`
8. Implementation Plan created — `PLAN-009` reviewed and approved
9. Implementation executes step by step
10. Validation checks acceptance criteria
11. Review evaluates the result
12. If process problems found → Improvement artifact → harness updated
