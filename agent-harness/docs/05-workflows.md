# Workflows

This file is the practical "what happens next?" guide.
Use this guide when you already understand the artifact types and want the normal operating flow explained clearly.

## Rules/Procedure Split (History)

Every harness source file follows the paired-loading model: the source file teaches the workflow, contract,
procedure, or system, and its paired rules under `agent-harness/rules/` hold the enforceable table. This split
was carried out in reviewable passes, recorded here for reference:

- `IMPROVEMENT-114`: foundation / grouped `CORE`
- `IMPROVEMENT-116`: taxonomy and migration architecture
- `IMPROVEMENT-122`: `OUTPUTS.md` guide / paired output rules split
- `IMPROVEMENT-117`: Mode Workflow rewrites and paired mode rules
- `IMPROVEMENT-118`: Artifact Contract rewrites and paired artifact rules
- `IMPROVEMENT-119`: Procedure Guide rewrites and paired procedure rules
- `IMPROVEMENT-120`: cross-file System extraction
- `IMPROVEMENT-121`: lean template migration

## The Standard Flow

```text
Voice / Text / Ideas
  → Partnering (TRANSCRIPT, IDEA, ADR when a structural decision settles)
  → Refining: Idea/Transcript/Partnering discussion/Legacy Finding/docs → Use Case (UC-*)     [skippable — see "Risk-Tier Cascade" below]
  → Refining: Use Case → Spec (SPEC-*)                                                          [skippable — see "Risk-Tier Cascade" below]
  → Refining: Spec → Tasks (TASK-*) — when required                                             [skippable — see "Risk-Tier Cascade" below]
  → Planning-Implementation (PLAN-*)
  → Implementing
  → Validation (shared procedure, invoked from within Implementing)
  → [Review / Improving-Harness — when a team wants formal evaluation or process correction]
```

A Question (`harness-data/artifacts/questions/`) may be raised from any point in this flow without switching
mode — it does not appear as its own step above because it is not a stage the work passes through, but a
cross-cutting registry any mode can write to.

## Risk-Tier Cascade

Each of the three Refining stages above is conditional, not automatic. Before Partnering routes, or Refining
creates a Use Case/Spec/Task, or Planning-Implementation is entered with no file named, the agent runs
`shared-procs/RISK-TIER.md`'s cascade to decide the minimum stage actually required:

```text
UC-Necessity?   --No--> Spec-Necessity?  --No--> Task-Necessity?  --No--> Planning-Implementation,
(RSK-02-010)             (RSK-03-010)              (RSK-04-010)           directly (Plan-tier,
  |Yes                     |Yes                      |Yes                 no artifact required first)
  v                        v                          v
/create-use-case       /create-spec                /create-tasks
```

A few things always hold, regardless of how many stages get skipped:

- The cascade runs once per request, at the first opportunity it's reached, and is carried forward — a
  later stage reuses an existing classification instead of recomputing it (`RSK-07-010`).
- Whatever artifact is produced (or the Implementation Plan, if none is) records why any stage was skipped,
  in a `## Risk-Tier Classification` section (`RSK-05-010`) — never silently.
- Ambiguous or unclear-scope requests default to *more* ceremony, not less (`RSK-06-010`).
- Database migrations, security/secrets/auth, deploys/CI, API contract changes, payments, domain-critical
  logic, and major architecture changes can never drop below Spec tier, no matter how small they look
  (`RSK-06-020`).
- Planning-Implementation's own gate is never skippable — every path still ends in an approved Implementation
  Plan before any code changes (`COR-01-060`).

See `agent-harness/shared-procs/RISK-TIER.md` for the full matrices.

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
Plans, or infer approval from discussion. Routing out of Partnering is risk-tier-informed, not automatically
toward a Use Case — see "Risk-Tier Cascade" above. See `agent-harness/modes/PARTNERING.md` for the full rule set.

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
multi-step, or high-risk work. One case is mandatory rather than optional: `IMPL-02-010` requires a gate-check line
(Plan ID, Plan status, Task `allowed_paths`) written to `RUN-LOG.md` before the first file mutation of any plan step.

It is temporary operational state, not a source-of-truth artifact — durable decisions and outcomes must still be
written back into the real artifacts, and the agent should collapse or clear it once work finishes. Most work
does not need a run log; reach for it when a future resume would otherwise depend on fragile chat memory. See
`agent-harness/CORE.md`'s Observability and Pause-Resume rules for the full behavior.

## Validation and Quality

**Validation** (a Procedure Guide, not a mode or artifact — invoked by name from within Implementing and
Improving-Harness) covers: artifact completeness, process rule compliance, acceptance criteria, readiness checks.
It is universal and does not contain project-specific commands.

**Technical checks** (tests, linting, typing, migrations) are project-specific. They are defined in `harness-data/reference/QUALITY.md` and run using commands from `harness-data/reference/TOOLING.md`.

Short version:

- Validation asks "did we follow the process, and is the behavior verifiable?"
- Implementing asks "did we run the actual project checks?"

## Template Discipline

Templates are lean blank forms. They should contain frontmatter keys, section headings, checklists, placeholders,
and short field prompts. They should not teach artifact theory, mode workflow, or cross-rule systems.

When migrating template content:

- explanation moves to the relevant Mode Workflow, Artifact Contract, Procedure Guide, or System
- enforceable constraints move to paired Rules
- placeholders and scaffold stay in the template

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
harness-data/artifacts/legacy/apps/<legacy-app-slug>/
  → legacy inventory
  → source maps
  → findings (LF-<APP>-NNN, or LF-CROSS-NNN for cross-system findings)
  → Refining: Legacy Finding → Use Case (once evidence is strong enough)
  → Specs (only when evidence is strong enough — directly from Legacy Discovery is the rare exception)
  → Tasks if required
  → Implementation Plan
```

The direct-to-Spec exception above is a separate, narrower exception from `shared-procs/RISK-TIER.md`'s general
cascade — see `RISK-TIER.md`'s `RSK-03-010` for the cascade's own Spec-Necessity criteria, which also apply once
a Legacy Finding reaches Refining.

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

## End-to-End Example: A Low-Risk Fix (Skip-Path)

1. User, in Partnering: "fix the `chown -R` layer duplication and the `psycopg[binary]`/`libpq5` duplication
   in `services/tw-watchlist/Dockerfile`."
2. Partnering (`PTN-02-110`) runs the cascade: UC-Necessity → No (technical-only, no actor-facing scenario
   changes). Spec-Necessity → No (routine packaging change, one clear approach, no contract change).
   Task-Necessity → No (single file, single module, no cross-cutting risk).
3. Cascade lands on Plan-tier — Partnering routes directly into Planning-Implementation's natural-language
   entry. No Use Case, Spec, or Task is created.
4. Planning-Implementation (`IPL-08-010`/`IPL-08-020`) creates `PLAN-0NN` directly (`entrypoint_type: none`),
   including a `## Risk-Tier Classification` section citing the three "No" rows and their reasons.
5. User reviews and approves `PLAN-0NN`.
6. Implementation executes the plan's steps.
7. Validation confirms the skip was legitimate (`VAL-02-010`'s carve-out) and the change matches the plan.
