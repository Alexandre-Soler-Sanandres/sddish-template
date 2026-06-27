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
- Should the harness improve?

## Possible Outcomes

- `accepted`
- `accepted-with-notes`
- `changes-requested`
- `rejected`
- `follow-up-required`

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/DOMAIN.md` — when reviewing domain correctness of a Spec, Use Case, or implementation
- `agent-harness/reference/ARCHITECTURE.md` — when reviewing scope or boundary decisions

## Review Body Should Include

- Target artifact or implementation
- Checklist of criteria
- Findings
- Outcome
- Follow-up artifacts (Improvements, new Tasks, etc.)

## Output

- `agent-harness/reviews/active/REVIEW-*.md`
- Use `agent-harness/templates/REVIEW-template.md` for every new Review.
- The Review artifact feeds into Improvement mode when process problems are found.

## After Review — Required Agent Actions

After completing a review, take the following action based on the outcome. Do not deviate.

| Outcome | Action |
|---|---|
| `accepted` | Advance artifact to its next accepted status. Report completion. |
| `accepted-with-notes` | Advance artifact status. Add findings as open questions in the artifact. |
| `changes-requested` | Set artifact status to `draft`. Record findings in the Review artifact. Stop and wait for user instruction. |
| `rejected` | Set artifact status to `rejected`. Move artifact to `archive/`. Stop and wait for user instruction. |
| `follow-up-required` | Hold artifact at current status. Create an Improvement artifact if a process problem was found. Stop and wait for user instruction. |

The agent never autonomously re-enters a producing mode after `changes-requested`, `rejected`, or `follow-up-required`.
The user must explicitly request the next action.

## Boundaries — Must Not

- Change the artifact under review
- Implement fixes
- Create Tasks or Specs as a side effect
- Modify harness files without an Improvement artifact
- Re-enter any producing mode after a rejection or escalation without explicit user instruction
