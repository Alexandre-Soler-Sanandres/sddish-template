# REVIEW.md

## Purpose

Review mode evaluates outputs and decisions.
Review is not only approval — it is how process problems are discovered.

## Entry

Via CLI: `/review-artifact <artifact-file>`
Via natural language: explicit instruction to review a specific artifact, plan, implementation, or process step.

## Review May Target

- Ideas
- Use Cases
- Specs
- Tasks
- Implementation Plans
- Code changes
- Validation results
- Harness behavior

## Two Flavors

A Review is one of two flavors, determined entirely by `target_type` — never both at once:

- **Product/requirements review** — `target_type` is `idea`/`use-case`/`spec`/`task`/`implementation-plan`/
  `implementation`. Produced from within `Implementing` (`agent-harness/modes/IMPLEMENTING.md`). Evaluates whether
  a deliverable is correct, complete, and in scope; `accepted` advances that artifact's own status.
- **Harness/process review** — `target_type` is `process`/`harness`. Produced from within any Mode when a process
  problem surfaces, and consumed by `Improving-Harness` (`agent-harness/modes/IMPROVING-HARNESS.md`), which is
  entered only from a Review finding. Evaluates whether the agent's behavior had a problem; there is no target
  artifact whose status advances.

## Review Answers — Product/Requirements Flavor

- Was the output correct?
- Was it complete?
- Was it too broad?
- Did validation cover the right risks?
- Are the artifacts traceable?

## Review Answers — Harness/Process Flavor

- Did the agent load the right context?
- Was context too large or too small?
- Were the rules clear enough?
- Did the agent follow the context checkpoint before high-impact actions?
- Should the harness improve?

## Possible Outcomes

- `accepted`
- `accepted-with-notes`
- `changes-requested`
- `rejected`
- `follow-up-required`

## Review Body Should Include

- Target artifact or implementation
- Checklist of criteria (from the matching flavor above)
- Findings
- Outcome
- Follow-up artifacts (Improvements, new Tasks, etc.)

## After Review — Required Agent Actions, Product/Requirements Flavor

| Outcome | Action |
| --- | --- |
| `accepted` | Advance artifact to its next accepted status. Report completion. |
| `accepted-with-notes` | Advance artifact status. Record findings in the Review artifact, and add open questions to the target artifact only when that artifact is the correct place to carry those notes forward. |
| `changes-requested` | Set artifact status to `draft`. Record findings in the Review artifact. Stop and wait for user instruction. |
| `rejected` | Set artifact status to `rejected`. Move artifact to `archive/`. Stop and wait for user instruction. |
| `follow-up-required` | Hold artifact at current status. Create an Improvement artifact if a process problem was found. Stop and wait for user instruction. |

## After Review — Required Agent Actions, Harness/Process Flavor

| Outcome | Action |
| --- | --- |
| `accepted` | Record findings. Report completion. No target-artifact status to advance. |
| `accepted-with-notes` | Record findings in the Review artifact. No target-artifact status to advance. |
| `changes-requested` | Record findings in the Review artifact. Stop and wait for user instruction. |
| `rejected` | Record findings in the Review artifact. Stop and wait for user instruction. |
| `follow-up-required` | Create an Improvement artifact (only from within `Improving-Harness`). Stop and wait for user instruction. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| RVW-01-010 | Escalation | The agent never autonomously re-enters a producing mode after `changes-requested`, `rejected`, or `follow-up-required` — the user must explicitly request the next action. |
| RVW-02-010 | Boundaries | Do not change the substantive content of the artifact under review as part of the review itself. Status transitions and explicitly prescribed follow-up metadata updates are allowed. |
| RVW-02-020 | Boundaries | Do not implement fixes. |
| RVW-02-030 | Boundaries | Do not create Tasks or Specs as a side effect. |
| RVW-02-040 | Boundaries | Do not modify harness files without an Improvement artifact. |
| RVW-03-010 | Procedure | When the review target matches a specialized review procedure, load the relevant playbook before reviewing. |
| RVW-03-020 | Procedure | Playbooks may refine how the review is performed, but they do not change Review outcomes, follow-up actions, or mode boundaries. |
| RVW-04-010 | Flavor | `target_type` determines the flavor (see Two Flavors) — use the matching Criteria Checklist and After-Review action table; never mix the two. |

## Output

- `harness-data/artifacts/reviews/active/REVIEW-*.md`
- Use `agent-harness/templates/REVIEW-template.md` for every new Review.
- The Review artifact feeds into Improving-Harness mode when process problems are found.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when reviewing domain correctness of a Spec, Use Case, or implementation
- `harness-data/reference/ARCHITECTURE.md` — when reviewing scope or boundary decisions
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
