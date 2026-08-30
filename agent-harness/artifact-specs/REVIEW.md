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

Persist a Review when it has findings, approval provenance, audit value, or a handoff that must survive. Assured
work uses a persisted Review and, where feasible, a fresh context or independent reviewer; routine clean
self-review records its evidence in the execution contract closeout.

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
- `status` — `draft` -> `assessed` -> `closed`, with `archived` reachable directly from `draft` or `assessed` on
  explicit discard; records *whether, and how, the record is closed*, separately from `outcome`. `closed` is
  reached differently per flavor: harness/process via `RVW-06-010` (all derived Improvements terminal),
  product/requirements via `RVW-06-040` (the user confirms every finding addressed or waived).

## Body Should Include

- Target artifact or implementation
- Checklist of criteria (from the matching flavor):
  - Product/requirements — was the output correct? complete? too broad? did validation cover the right risks?
    are the artifacts traceable?
  - Harness/process — did the agent load the right context? was context too large or too small? were the rules
    clear enough? did the agent follow the context checkpoint before high-impact actions? should the harness
    improve?
- Findings
- Finding Disposition — product/requirements flavor only: a `## Finding Disposition` table
  (Finding, Status, Updated, Evidence; `Status` one of `open` / `addressed` / `waived` / `open-by-design`)
  maintained as findings are worked through in the target artifact's producing mode; it is the source the
  `## Closure` section summarizes (`RVW-06-042`/`RVW-06-043`). Harness/process Reviews track findings as
  Improvements derived through their `source_ids` instead and omit this section.
- Follow-up artifacts (Improvements, new Tasks, etc.)
- Closure (added only on the `RVW-06-010`/`RVW-06-040` transition — see `## Lifecycle`)

## Lifecycle

`status` moves `draft` -> `assessed` -> `closed`; `archived` is reachable directly from `draft` or `assessed`
when the user calls off further work (`RVW-07-010`). `outcome` records *what was decided*; `status`
separately records *whether, and how, the record is closed*.

After reaching an outcome, the agent must take exactly the action listed for it — never improvise or skip the
required status change or artifact creation (`RVW-05-010`/`RVW-05-020`):

Product/Requirements flavor:

| Outcome | Action |
| --- | --- |
| `accepted` | Advance artifact to its next accepted status. Report completion. |
| `accepted-with-notes` | Advance artifact status. Record findings in the Review artifact, and add open questions to the target artifact only when that artifact is the correct place to carry those notes forward. The Review stays `assessed` until the user confirms every finding is addressed or explicitly waived, then becomes `closed` in place with a `## Closure` section (`RVW-06-040`–`RVW-06-042`). |
| `changes-requested` | Set artifact status to `draft`. Record findings in the Review artifact. Stop and wait for user instruction. The Review stays `assessed` until the user confirms every finding is addressed or explicitly waived, then becomes `closed` in place with a `## Closure` section (`RVW-06-040`–`RVW-06-042`). The agent MUST NOT make that transition on its own initiative. |
| `rejected` | Set the reviewed artifact's status to `rejected` in place. Stop and wait for user instruction. |
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

Closure (harness/process flavor): a Review with `outcome: follow-up-required` sets `status: closed` in place once
every Improvement whose `source_ids` cites it reaches `done` or `rejected` (`RVW-06-010`) — it stays
`status: assessed` while any such Improvement is nonterminal (`RVW-06-020`). The transition adds a `## Closure`
section (date, terminal Improvement ID(s), `done`/`rejected` for
each) (`RVW-06-030`).

Closure (product/requirements flavor): a Review with `outcome: changes-requested` or `accepted-with-notes` sets
`status: closed` in place once the user confirms every finding is addressed — through
the target artifact's own producing mode — or explicitly waived; the agent never makes this transition on its own
initiative (`RVW-06-040`), and the Review stays `status: assessed` until then (`RVW-06-041`). The
transition adds a `## Closure` section: date, and one line per finding giving its disposition
(`addressed` / `waived` / `open-by-design`) and the artifact + mode or user instruction that resolved it,
matching the latest `## Finding Disposition` rows (`RVW-06-042`). That `## Finding Disposition` table is the
running per-finding record this flavor keeps in place of derived Improvement backlinks (`RVW-06-043`).

`closed` (findings worked through) is distinct from `archived` after explicit discard (work called off): once a
Improvement has gone terminal, or once the user has confirmed a product/requirements Review's findings are all
addressed or waived, the Review closes as `closed`, never `archived` (`RVW-07-040`).

Discard: a Review may move to `status: archived` only on the user's explicit instruction that no
further work will happen for it — never inferred from a stalled draft or a nonterminal derived Improvement alone
(`RVW-07-010`/`RVW-07-011`; `COR-01-090` governs inferred approval generally). Reachable from `draft` (`outcome`
may stay unset) or `assessed` (`outcome` stays as recorded) (`RVW-07-020`), adding a `## Discard Note`
(date, reason) in the same transition (`RVW-07-030`). Never archive as discard in place of `RVW-06-010` once a
derived Improvement has already gone terminal (`RVW-07-040`). When the user explicitly declines further
follow-up for a Review's finding, apply the discard that same turn, not merely acknowledge it in conversation
(`RVW-07-050`).

## Relationships

A harness/process Review derives follow-up Improvements by scanning Improvement `source_ids` for its ID. The
Review does not maintain a handwritten reverse list.

## Output / Location

- `harness-data/artifacts/reviews/REVIEW-*.md`
- The Review artifact feeds into Improving-Harness mode when process problems are found.

## Template

Use `agent-harness/templates/REVIEW-template.md` for every new Review.

## Examples

An Implementing-mode plan step completes; the agent produces a product/requirements Review (`target_type: task`),
finds the output correct and complete, sets `outcome: accepted`, and advances the Task's status. Separately, a
Review of the agent's own context-loading behavior (`target_type: process`) finds a recurring gap, sets
`outcome: follow-up-required`, and — since this Review is a harness/process flavor — the agent creates an
Improvement from within Improving-Harness.

## Rules

| ID | Rule |
| --- | --- |
| RVW-00-010 | MUST persist a Review only for findings, approval provenance, audit value, a durable handoff, or Assured-work review; routine clean self-review MUST record evidence in the execution-contract closeout instead. |
| RVW-01-010 | The agent MUST NOT autonomously re-enter a producing mode after `changes-requested`, `rejected`, or `follow-up-required` — the user must explicitly request the next action. |
| RVW-02-010 | MUST NOT change the substantive content of the artifact under review as part of the review itself (status transitions and explicitly prescribed follow-up metadata updates are allowed). |
| RVW-02-011 | MUST NOT implement fixes as part of a review. |
| RVW-02-012 | MUST NOT create Tasks or Specs as a side effect of a review. |
| RVW-02-013 | MUST NOT modify harness files as part of a review, without an Improvement artifact. |
| RVW-03-010 | MUST load the relevant playbook before reviewing, when the review target matches a specialized review procedure. |
| RVW-03-020 | Playbooks MAY refine how the review is performed; they do not change Review outcomes, follow-up actions, or mode boundaries (`COR-04-070`). |
| RVW-04-010 | `target_type` determines the flavor (see `REVIEW.md`'s Two Flavors) — MUST use the matching Criteria Checklist and After-Review action table for that flavor, not a mix of both. |
| RVW-05-010 | MUST take exactly the action listed in the matching After-Review table for the recorded Outcome before stopping. |
| RVW-05-020 | MUST NOT improvise or skip the required status change or artifact creation named by `RVW-05-010`. |
| RVW-06-010 | A harness/process Review with `outcome: follow-up-required` MUST set `status: closed` in place once every Improvement whose `source_ids` cites it reaches `done` or `rejected`. |
| RVW-06-020 | A harness/process Review MUST stay `status: assessed` while any derived Improvement is nonterminal. |
| RVW-06-030 | MUST add a `## Closure` section (date, terminal Improvement ID(s), `done`/`rejected` for each) as part of the `RVW-06-010` transition. |
| RVW-06-040 | A product/requirements Review with `outcome: changes-requested` or `accepted-with-notes` MUST set `status: closed` in place only once the user confirms every finding is addressed or explicitly waived. |
| RVW-06-041 | Before that confirmation such a Review MUST stay `status: assessed`. |
| RVW-06-042 | MUST add a `## Closure` section (date; per finding: disposition `addressed` / `waived` / `open-by-design`, and the resolving artifact and mode or user instruction; `open-by-design` only where the user chose to leave the finding open), matching the `## Finding Disposition` rows, as part of the `RVW-06-040` transition. |
| RVW-06-043 | A product/requirements Review SHOULD maintain a `## Finding Disposition` table; the harness/process flavor omits it and derives Improvements from their `source_ids`. |
| RVW-07-010 | A Review MAY move to `status: archived` only on the user's explicit instruction that no further work will happen for it. |
| RVW-07-011 | That instruction MUST NOT be inferred from a stalled draft or a nonterminal derived Improvement alone (`COR-01-090`). |
| RVW-07-020 | `archived` is reachable from `draft` (`outcome` MAY stay unset) or `assessed` (`outcome` stays recorded). |
| RVW-07-030 | MUST add a `## Discard Note` (date, reason) as part of the `RVW-07-010` move. |
| RVW-07-040 | MUST NOT use discard-style `archived` in place of `closed` once a derived Improvement is terminal or the user confirms all product findings addressed/waived. |
| RVW-07-050 | When the user explicitly declines further follow-up for a Review's finding, MUST apply `RVW-07-010` that same turn, not merely acknowledge it in conversation. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when reviewing domain correctness of a Spec, Use Case, or implementation
- `harness-data/reference/ARCHITECTURE.md` — when reviewing scope or boundary decisions
- `harness-data/artifacts/adrs/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
