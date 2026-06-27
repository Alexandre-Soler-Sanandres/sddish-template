# VALIDATION.md

## Purpose

Validation mode checks artifacts, plans and harness changes against process and behavioral criteria.
It does not run technical checks — those are the responsibility of Implementation mode, guided by `agent-harness/reference/QUALITY.md` and `agent-harness/reference/TOOLING.md`.

## Entry

Via CLI: `/tw-validate`
Via natural language: explicit instruction to validate a specific artifact, plan step, or implementation.

## Artifact Validation

Check that the artifact is complete and correctly structured:

- Required frontmatter fields are present and filled
- Status is appropriate for the current stage
- Traceability links are present (source, derived, related)
- ID is stable and follows naming conventions
- Body sections are complete and not left as placeholders

## Process Validation

Check that the process rules have been followed:

- The artifact was created from an accepted source (e.g. Spec from approved Use Case)
- The Implementation Plan is at status `approved` before implementation started
- No implementation happened before a plan was accepted
- No Specs or Tasks were created from Partnering mode
- High-risk areas were handled with extra care

## Behavioral Validation

Check that the implementation satisfies the acceptance criteria defined in the Spec:

- Each acceptance criterion is met and verifiable
- `test_refs` in the Spec frontmatter are populated and all referenced test files exist
- Each acceptance criterion is traceable to an entry in `test_refs` or a Task validation command
- Non-goals were not implemented
- Scope did not drift beyond what was planned
- Technical checks were run during Implementation (see `agent-harness/modes/IMPLEMENTATION.md`)

## Readiness Checks

Before moving to the next stage, verify:

- No open `changes-requested` or `rejected` review findings
- All blockers are resolved
- Dependent artifacts are at an accepted status

## Output

Validation findings should be documented as part of a Review artifact or inline in the plan step summary.
Use `agent-harness/templates/REVIEW-template.md` when a formal review record is needed.

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/ARCHITECTURE.md` — when validating scope or structural boundaries
- `agent-harness/reference/DOMAIN.md` — when validating domain-critical behavior

## When Automation Is Unavailable

Manual review is acceptable as a fallback.
Document what was checked and the outcome.

## Boundaries — Must Not

- Implement or change code
- Modify artifacts beyond updating their status
- Skip validation steps without explicit approval
