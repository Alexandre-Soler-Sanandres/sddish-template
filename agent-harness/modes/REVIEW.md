# REVIEW.md

## Purpose

Review mode evaluates outputs and decisions.
Review is not only approval — it is how process problems are discovered.

## Entry

Via CLI: `/tw-review <artifact-file>`
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

## Review Answers

- Was the output correct?
- Was it complete?
- Was it too broad?
- Did the agent load the right context?
- Was context too large or too small?
- Were the rules clear enough?
- Did validation catch the right risks?
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
- Checklist of criteria
- Findings
- Outcome
- Follow-up artifacts (Improvements, new Tasks, etc.)

## After Review — Required Agent Actions

After completing a review, take the following action based on the outcome. Do not deviate.

| Outcome | Action |
| --- | --- |
| `accepted` | Advance artifact to its next accepted status. Report completion. |
| `accepted-with-notes` | Advance artifact status. Record findings in the Review artifact, and add open questions to the target artifact only when that artifact is the correct place to carry those notes forward. |
| `changes-requested` | Set artifact status to `draft`. Record findings in the Review artifact. Stop and wait for user instruction. |
| `rejected` | Set artifact status to `rejected`. Move artifact to `archive/`. Stop and wait for user instruction. |
| `follow-up-required` | Hold artifact at current status. Create an Improvement artifact if a process problem was found. Stop and wait for user instruction. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| RVW-001 | Escalation | The agent never autonomously re-enters a producing mode after `changes-requested`, `rejected`, or `follow-up-required` — the user must explicitly request the next action. |
| RVW-002 | Boundaries | Do not change the substantive content of the artifact under review as part of the review itself. Status transitions and explicitly prescribed follow-up metadata updates are allowed. |
| RVW-003 | Boundaries | Do not implement fixes. |
| RVW-004 | Boundaries | Do not create Tasks or Specs as a side effect. |
| RVW-005 | Boundaries | Do not modify harness files without an Improvement artifact. |
| RVW-006 | Procedure | When the review target matches a specialized review procedure, load the relevant playbook before reviewing. |
| RVW-007 | Procedure | Playbooks may refine how the review is performed, but they do not change Review outcomes, follow-up actions, or mode boundaries. |

## Output

- `harness-data/artifacts/reviews/active/REVIEW-*.md`
- Use `agent-harness/templates/REVIEW-template.md` for every new Review.
- The Review artifact feeds into Improvement mode when process problems are found.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when reviewing domain correctness of a Spec, Use Case, or implementation
- `harness-data/reference/ARCHITECTURE.md` — when reviewing scope or boundary decisions
