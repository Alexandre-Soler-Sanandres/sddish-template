# VALIDATION.md

## Purpose

Validation mode checks artifacts, plans and harness changes against process and behavioral criteria.
It does not run technical checks — those are the responsibility of Implementation mode, guided by `harness-data/reference/QUALITY.md` and `harness-data/reference/TOOLING.md`.

## Entry

Via CLI: `/tw-validate`
Via natural language: explicit instruction to validate a specific artifact, plan step, or implementation.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| VAL-001 | Artifact-Validation | Required frontmatter fields are present and filled. |
| VAL-002 | Artifact-Validation | Status is appropriate for the current stage. |
| VAL-003 | Artifact-Validation | Traceability links are present and synchronized where required (`source`, `derived_*`, `related`). |
| VAL-004 | Artifact-Validation | ID is stable and follows naming conventions. |
| VAL-005 | Artifact-Validation | Body sections are complete and not left as placeholders. |
| VAL-006 | Process-Validation | The artifact was created from an accepted source (e.g. Spec from a `ready-for-spec` Use Case). |
| VAL-007 | Process-Validation | The Implementation Plan is at status `approved` before implementation started. |
| VAL-008 | Process-Validation | No implementation happened before a plan was accepted. |
| VAL-009 | Process-Validation | No Specs or Tasks were created from Partnering mode. |
| VAL-010 | Process-Validation | High-risk areas were handled with extra care. |
| VAL-011 | Behavioral-Validation | Each acceptance criterion is met and verifiable. |
| VAL-012 | Behavioral-Validation | `test_refs` in the Spec frontmatter are populated, contain only test file paths, and all referenced test files exist. |
| VAL-013 | Behavioral-Validation | Each acceptance criterion is traceable to an entry in `test_refs` or a Task validation command. |
| VAL-014 | Behavioral-Validation | Non-goals were not implemented. |
| VAL-015 | Behavioral-Validation | Scope did not drift beyond what was planned. |
| VAL-016 | Behavioral-Validation | Technical checks were run during Implementation (see `agent-harness/modes/IMPLEMENTATION.md`). |
| VAL-017 | Readiness-Checks | Before moving to the next stage, verify: no open `changes-requested` or `rejected` review findings, all blockers are resolved, and dependent artifacts are at an accepted status. |
| VAL-018 | Fallback | Manual review is acceptable as a fallback when automation is unavailable. Document what was checked and the outcome. |
| VAL-019 | Boundaries | Do not implement or change code. |
| VAL-020 | Boundaries | Do not modify artifacts beyond updating their status. |
| VAL-021 | Boundaries | Do not skip validation steps without explicit approval. |
| VAL-022 | Procedure | When a relevant playbook defines required checks or outputs for the work under validation, verify that those expectations were followed. |
| VAL-023 | Procedure | Playbooks may refine what to verify for a task shape, but Validation mode still owns the validation decision and boundaries. |

## Output

Validation findings should be documented as part of a Review artifact or inline in the plan step summary.
Use `agent-harness/templates/REVIEW-template.md` when a formal review record is needed.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when validating scope or structural boundaries
- `harness-data/reference/DOMAIN.md` — when validating domain-critical behavior
