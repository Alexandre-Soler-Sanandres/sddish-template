# Workflows

This file is the practical "what happens next?" guide.
Use this guide when you already understand the artifact types and want the normal operating flow explained clearly.

## The Standard Flow

```text
Voice / Text / Ideas
  → Partnering (TRANSCRIPT, IDEA)
  → Use Case Mode (UC-*)
  → Spec Mode (SPEC-*)
  → [Task Mode (TASK-*) — when required]
  → Implementation Planning (PLAN-*)
  → Implementation
  → Validation
  → [Review / Harness Improvement — when a team wants formal evaluation or process correction]
```

In plain terms:

- Partnering helps when the request is still fuzzy.
- Use Case and Spec make the intended behavior explicit.
- Tasks are only added when the work needs smaller execution slices.
- Implementation Planning is the gate that turns requirements into an approved path.
- Implementation executes that path.
- Validation checks that the result and the process both hold up.

## Partnering Workflow

Partnering is the front door for unclear thinking.

**Responsibilities:**

- Listen first, capture relevant statements
- Separate problem, goal, solution idea, and assumption
- Ask focused clarification questions
- Identify candidate ideas and possible Use Case drafts

**Output paths:**

- `harness-data/artifacts/transcripts/active/TRANSCRIPT-*.md`
- `harness-data/artifacts/ideas/active/IDEA-*.md`
- `harness-data/artifacts/use-cases/active/UC-*.md` (draft only, if sufficiently mature)

Partnering must not create Specs, Tasks, or Implementation Plans, or infer approval from discussion.

## Use Case Creation

A Use Case is appropriate when:

- A human actor or external system has a goal to pursue
- A decision flow or business workflow needs to be defined
- Observable behavior or failure paths need to be captured

A Use Case may be created from: Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation.

## Spec Creation

A typical Spec-creation pass by the agent includes:

1. verifying that the Use Case is at `ready-for-spec`
2. reading the Use Case
3. inspecting source Ideas or Legacy Findings for additional context
4. identifying problem and goal
5. defining scope and non-goals
6. defining functional and non-functional requirements
7. defining acceptance criteria
8. identifying risks and constraints
9. identifying whether Tasks are likely required
10. stopping before implementation

## Are Tasks Required?

This table is a practical decision aid, not permission to skip planning entirely.
If Tasks are not required, the work still needs an Implementation Plan.

| Situation | Tasks Required? | Reason |
| --- | --- | --- |
| Small documentation-only change | No | Inline plan is sufficient |
| Small isolated config change | Optional | Use inline plan if validation is clear |
| Small bugfix in one module | Optional | Use inline plan if scope is clear |
| Multiple files or modules | Yes | Reviewability and traceability |
| Multiple implementation steps | Yes | Ordering and validation boundaries |
| Cross-cutting change | Yes | Scope control |
| Unclear dependencies | Yes | Dependency management |
| Use Case with multiple Specs | Yes | Too broad for inline planning |
| Spec with multiple features | Yes | Needs execution slices |
| Database migration | Yes | High risk |
| Destructive data job | Yes | High risk |
| Deployment or infrastructure change | Yes | Operational risk |
| Security, secrets or auth | Yes | Safety-critical |
| Payment or financial transaction execution | Yes | Safety-critical |
| Domain-critical business logic | Yes | Domain-critical |
| Major architecture change | Yes | Requires reviewable slices |

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

## Implementation Planning

Implementation Planning entry points and what they mean:

**`/tw-plan-task TASK-001`**
This command tells the agent to create a focused plan for this Task and stop before coding until the plan is approved.

**`/tw-plan-spec SPEC-001`**
This command tells the agent to find existing Tasks, check maturity, apply the Task Decision Matrix, and create a plan.
If Tasks are required but missing, the agent should stop and route to `/tw-create-tasks`, then wait for approval.

**`/tw-plan-use-case UC-001`**
This command tells the agent to find all derived Specs, verify they are approved, apply the same Task discovery logic
for each Spec, and create a coherent end-to-end plan. If approval prerequisites are missing, the agent should stop and
route to the correct upstream step, then wait for approval.

### Plan Step Grouping

Group multiple Tasks into one step when: they belong to the same Spec, are small and tightly related, share a validation strategy, and do not include high-risk work.

Keep Tasks separate when: risk is high, validation differs, commits should be separate, or the change affects database, deployment, security, or safety-critical areas.

### Commit Boundaries

Each plan step should propose a commit boundary. A commit may correspond to one Task, one safe group of Tasks, or one plan step. Example:

```text
feat(area): short description

Implements:
- TASK-001
- TASK-002

Source:
- SPEC-001
```

The important part is not the exact commit wording. The important part is that the plan proposes reviewable change boundaries before implementation starts.

## Implementation Execution

During implementation, the agent should:

- execute one plan step at a time by default
- set Task status `in-progress` when starting, `done` when complete
- set Plan status `in-progress` when execution begins, `done` when all steps complete
- run technical checks (from `QUALITY.md` / `TOOLING.md`) after each step
- stop if validation fails outside the expected scope
- stop if missing or contradictory requirements are discovered
- stop if a high-risk area is encountered that is not covered by the plan

### Optional Operational Trace

`harness-data/RUN-LOG.md` is not required by default, but the agent may use it for interrupted, approval-heavy,
multi-step, or high-risk work:

- It is temporary operational state, not a source-of-truth artifact.
- The agent can use it for approvals, resumptions, interruptions, and validation checkpoints that help work continue safely.
- When work finishes, the agent should collapse it to a short closure note or clear it.
- Durable decisions and outcomes must still be written back into the real artifacts.

This is the harness's lightweight observability layer when runtime visibility matters:

- what context was loaded
- what commands or checks were run
- where work paused or resumed
- why execution stopped

Most work does not need a run log. Reach for it when a future resume would otherwise depend on fragile chat memory.

### Pause / Resume Protocol

When implementation or planning work is interrupted and will continue later:

Before pausing, the agent should:

- record the exact restart point
- record the current execution state
- record any checks that must be re-run before continuing

On resume, the agent should:

- repeat the context checkpoint
- confirm the restart point is still valid
- confirm no newer artifact, status change, or user instruction invalidates the old path
- re-run any validations or checks that were still uncertain at pause time

The lightest appropriate place for this state is:

- the real Task, Plan, or artifact when the pause changes durable status or blockers
- `harness-data/RUN-LOG.md` when it is temporary operational state for interrupted or higher-risk work

## Validation and Quality

**Validation mode** covers: artifact completeness, process rule compliance, acceptance criteria, readiness checks. It is universal and does not contain project-specific commands.

**Technical checks** (tests, linting, typing, migrations) are project-specific. They are defined in `harness-data/reference/QUALITY.md` and run using commands from `harness-data/reference/TOOLING.md`.

Short version:

- Validation mode asks "did we follow the process, and is the behavior verifiable?"
- Implementation mode asks "did we run the actual project checks?"

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

## Review and Harness Improvement

Every significant artifact or implementation should be reviewable. For teams that want a lighter default flow, Review
and Improvement are optional advanced disciplines rather than a mandatory everyday step. When used, Reviews answer:

- Was the output correct and complete?
- Did the agent load the right context?
- Were the rules clear enough?
- Should the harness improve?

After review, the agent takes a prescribed action and stops — it does not autonomously continue:

- `accepted` / `accepted-with-notes` → advance artifact, record follow-up notes, and update the target artifact only when it is the correct place to carry those notes forward
- `changes-requested` → set artifact to `draft`, wait for user
- `rejected` → archive artifact, wait for user
- `follow-up-required` → hold status, create Improvement if needed, wait for user

If a process problem is found:

```text
Review → Improvement artifact → approved harness change → updated harness files
```

Improvement artifacts must originate from Review findings — not from Partnering or direct requests.

That stricter loop exists to keep harness changes deliberate and reviewable instead of being mixed into unrelated work.

## Legacy Discovery Flow

For the practical step-by-step legacy application playbook, see
[08-legacy-applications.md](08-legacy-applications.md).

```text
harness-data/artifacts/legacy/imported/old-project
  → legacy inventory
  → source maps
  → findings (LEGACY-FINDING-*)
  → candidate Use Cases (UC-*, draft)
  → Specs (only when evidence is strong enough)
  → Tasks if required
  → Implementation Plan
```

The legacy project is evidence, not authority. The agent must never treat legacy code as automatically correct.

## End-to-End Example: Voice to Implementation

1. User speaks — agent records `TRANSCRIPT-001`
2. Agent identifies candidate idea — creates `IDEA-018`
3. Partnering session clarifies the problem
4. Use Case created — `UC-011` at status `ready-for-spec`
5. Spec created — `SPEC-021` reviewed and approved
6. Task Decision Matrix applied — Tasks required
7. Tasks created — `TASK-071`, `TASK-072`, `TASK-073`
8. Implementation Plan created — `PLAN-009` reviewed and approved
9. Implementation executes step by step
10. Validation checks acceptance criteria
11. Review evaluates the result
12. If process problems found → Improvement artifact → harness updated
