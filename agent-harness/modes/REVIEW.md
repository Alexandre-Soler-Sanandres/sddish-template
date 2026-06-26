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

## Boundaries — Must Not

- Change the artifact under review
- Implement fixes
- Create Tasks or Specs as a side effect
- Modify harness files without an Improvement artifact
