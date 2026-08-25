# REVIEW.md

## Purpose

Review evaluates outputs and decisions. Review is not only approval — it is how process problems are discovered.

## Artifact Story

An output or decision needs evaluating — a deliverable's correctness/completeness, or the harness's own
behavior. The agent records a Review with the matching flavor's checklist, reaches one of a fixed set of
outcomes, and takes exactly the action that outcome requires: advancing an artifact's status, stopping for user
instruction, or — for a harness/process finding that needs a fix — creating an Improvement from within
Improving-Harness. The agent never re-enters a producing mode on its own after a non-`accepted` outcome; only the
user restarts that work.

## Entry / Creation Paths

Via CLI: `/review-artifact <artifact-file>`
Via natural language: explicit instruction to review a specific artifact, plan, implementation, or process step.

## Sources

A Review may target:

- Ideas
- Use Cases
- Specs
- Tasks
- Implementation Plans
- Code changes
- Validation results
- Harness behavior

## When To Create

Create a Review whenever a deliverable needs evaluating for correctness/completeness/scope (product/requirements
flavor), or whenever the agent's own behavior — context loading, rule clarity, checkpoint discipline — needs
evaluating (harness/process flavor). See `## Artifact Shape`'s Two Flavors for how `target_type` decides which.

## When Not To Create

Do not use a Review to change the substantive content of the artifact under review — that requires the artifact's
own producing mode, not the review itself (`RVW-02-010`). Do not implement fixes, create Tasks/Specs, or modify
harness files as part of a review — a harness/process finding routes to an Improvement instead
(`RVW-02-011`–`RVW-02-013`).

## Artifact Shape

A Review is one of two flavors, determined entirely by `target_type` — never both at once:

- **Product/requirements review** — `target_type` is `idea`/`use-case`/`spec`/`task`/`implementation-plan`/
  `implementation`. Produced from within `Implementing` (`agent-harness/modes/IMPLEMENTING.md`). Evaluates
  whether a deliverable is correct, complete, and in scope; `accepted` advances that artifact's own status.
- **Harness/process review** — `target_type` is `process`/`harness`. Produced from within any Mode when a process
  problem surfaces, and consumed by `Improving-Harness` (`agent-harness/modes/IMPROVING-HARNESS.md`), which is
  entered only from a Review finding. Evaluates whether the agent's behavior had a problem; there is no target
  artifact whose status advances.

`outcome` is one of `accepted`, `accepted-with-notes`, `changes-requested`, `rejected`, `follow-up-required`.

## Field Semantics

- `target_type` — see `## Artifact Shape`'s Two Flavors; MUST use the matching Criteria Checklist and
  After-Review action table for that flavor, not a mix of both (`RVW-04-010`).
- `outcome` — records *what was decided*; drives the required action in `## Lifecycle`.
- `status` — `draft` -> `assessed` -> `resolved`, with `discarded` reachable directly from `draft` or `assessed`;
  records *whether, and how, the record is closed*, separately from `outcome` (see `## Lifecycle`).
- `follow_up` — for a harness/process Review with `outcome: follow-up-required`, holds the Improvement ID(s)
  created from it (see `## Relationships`).

## Body Should Include

- Target artifact or implementation
- Checklist of criteria (from the matching flavor):
  - Product/requirements — was the output correct? complete? too broad? did validation cover the right risks?
    are the artifacts traceable?
  - Harness/process — did the agent load the right context? was context too large or too small? were the rules
    clear enough? did the agent follow the context checkpoint before high-impact actions? should the harness
    improve?
- Findings
- Follow-up artifacts (Improvements, new Tasks, etc.)

## Lifecycle

`status` moves `draft` -> `assessed` -> `resolved`, with `discarded` reachable directly from `draft` or
`assessed` when the user calls off further work (`RVW-07-010`). `outcome` records *what was decided*; `status`
separately records *whether, and how, the record is closed*.

After reaching an outcome, the agent must take exactly the action listed for it — never improvise or skip the
required status change, archive move, or artifact creation (`RVW-05-010`/`RVW-05-020`):

Product/Requirements flavor:

| Outcome | Action |
| --- | --- |
| `accepted` | Advance artifact to its next accepted status. Report completion. |
| `accepted-with-notes` | Advance artifact status. Record findings in the Review artifact, and add open questions to the target artifact only when that artifact is the correct place to carry those notes forward. |
| `changes-requested` | Set artifact status to `draft`. Record findings in the Review artifact. Stop and wait for user instruction. |
| `rejected` | Set artifact status to `rejected`. Move artifact to `archive/`. Stop and wait for user instruction. |
| `follow-up-required` | Hold artifact at current status. Note any process problem found in the Review artifact — MUST NOT create an Improvement artifact from this flavor. An Improvement may only be created from a harness/process-flavored Review (see `IMPROVEMENT.md`'s Sources rule); if a process fix is warranted, that requires a separate harness/process-flavored Review. Stop and wait for user instruction. |

Harness/Process flavor:

| Outcome | Action |
| --- | --- |
| `accepted` | Record findings. Report completion. No target-artifact status to advance. |
| `accepted-with-notes` | Record findings in the Review artifact. No target-artifact status to advance. |
| `changes-requested` | Record findings in the Review artifact. Stop and wait for user instruction. |
| `rejected` | Record findings in the Review artifact. Stop and wait for user instruction. |
| `follow-up-required` | Create an Improvement artifact (only from within `Improving-Harness`). Stop and wait for user instruction. |

The agent must never autonomously re-enter a producing mode after `changes-requested`, `rejected`, or
`follow-up-required` — the user must explicitly request the next action (`RVW-01-010`).

## Readiness / Acceptance

Not applicable in the artifact-readiness sense — a Review's own completion is governed by `## Lifecycle`'s
closure and discard rules below, not a pre-status checklist.

Closure: a harness/process-flavored Review with `outcome: follow-up-required` moves `active/` → `archive/` and
sets `status: resolved` once every `follow_up` Improvement ID reaches `done` or `rejected` (`RVW-06-010`) — it
stays `status: assessed` in `active/` while `follow_up` is empty or contains a non-terminal Improvement
(`RVW-06-020`). The move adds a `## Closure` section (date, terminal Improvement ID(s), `done`/`rejected` for
each) (`RVW-06-030`).

Discard: a Review may move to `status: discarded` (→ `archive/`) only on the user's explicit instruction that no
further work will happen for it — never inferred from a stalled draft or an unresolved `follow_up` alone
(`RVW-07-010`/`RVW-07-011`; `COR-01-090` governs inferred approval generally). Reachable from `draft` (`outcome`
may stay unset) or `assessed` (`outcome`/`follow_up` stay as recorded) (`RVW-07-020`), adding a `## Discard Note`
(date, reason) as part of the move (`RVW-07-030`). Never use `discarded` in place of `RVW-06-010` once a
`follow_up` Improvement has already gone terminal (`RVW-07-040`). When the user explicitly declines further
follow-up for a Review's finding, apply the discard that same turn, not merely acknowledge it in conversation
(`RVW-07-050`).

## Relationships

A harness/process-flavored Review's `follow_up` field names every Improvement created from it — see
`IMPROVEMENT.md`'s `IMPR-04-010` for the reverse-link obligation on the Improvement side, and `## Readiness /
Acceptance`'s Closure rules above for how `follow_up` gates this Review's own resolution.

## Output / Location

- `harness-data/artifacts/reviews/active/REVIEW-*.md`
- The Review artifact feeds into Improving-Harness mode when process problems are found.

## Template

Use `agent-harness/templates/REVIEW-template.md` for every new Review.

## Examples

An Implementing-mode plan step completes; the agent produces a product/requirements Review (`target_type: task`),
finds the output correct and complete, sets `outcome: accepted`, and advances the Task's status. Separately, a
Review of the agent's own context-loading behavior (`target_type: process`) finds a recurring gap, sets
`outcome: follow-up-required`, and — since this Review is a harness/process flavor — the agent creates an
Improvement from within Improving-Harness.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/REVIEW.md` (single paired file —
under the 25-rule grouping threshold). Load it whenever creating, assessing, resolving, or discarding a Review.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when reviewing domain correctness of a Spec, Use Case, or implementation
- `harness-data/reference/ARCHITECTURE.md` — when reviewing scope or boundary decisions
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
