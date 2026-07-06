# VALIDATION.md

## Purpose

Validation checks artifacts, plans and harness changes against process and behavioral criteria.
It does not run technical checks — those are the responsibility of Implementing, guided by `harness-data/reference/QUALITY.md` and `harness-data/reference/TOOLING.md`.

## Entry

Via CLI: `/validate`
Via natural language: explicit instruction to validate a specific artifact, plan step, or implementation.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| VAL-01-010 | Artifact-Validation | Required frontmatter fields are present and filled. |
| VAL-01-020 | Artifact-Validation | Status is appropriate for the current stage. |
| VAL-01-030 | Artifact-Validation | Traceability links are present and synchronized where required (`source`, `derived_*`, `related`). |
| VAL-01-040 | Artifact-Validation | ID is stable and follows naming conventions. |
| VAL-01-050 | Artifact-Validation | Body sections are complete and not left as placeholders. |
| VAL-02-010 | Process-Validation | The artifact was created from an accepted source (e.g. Spec from a `ready-for-spec` Use Case). |
| VAL-02-020 | Process-Validation | The Implementation Plan is at status `approved` before implementation started. |
| VAL-02-030 | Process-Validation | No implementation happened before a plan was accepted. |
| VAL-02-040 | Process-Validation | No Specs or Tasks were created from Partnering mode. |
| VAL-02-050 | Process-Validation | Verify `COR-09-010`'s high-risk handling (scope and validation coverage, plus approval coverage for payments) was actually followed for any high-risk area touched. |
| VAL-02-060 | Process-Validation | Reconcile the actual code changes (via `git log`/`git diff`) against the approved Implementation Plan's `allowed_paths` and steps. Flag any file changed outside `allowed_paths`, or any change with no corresponding Plan step, as a finding. |
| VAL-03-010 | Behavioral-Validation | Each acceptance criterion is met and verifiable. |
| VAL-03-020 | Behavioral-Validation | `test_refs` in the Spec frontmatter are populated, contain only test file paths, and all referenced test files exist. |
| VAL-03-030 | Behavioral-Validation | Each acceptance criterion is traceable to an entry in `test_refs` or a Task validation command. |
| VAL-03-040 | Behavioral-Validation | Non-goals were not implemented. |
| VAL-03-050 | Behavioral-Validation | Scope did not drift beyond what was planned. |
| VAL-03-060 | Behavioral-Validation | Technical checks were run during Implementation (see `agent-harness/modes/IMPLEMENTING.md`). |
| VAL-04-010 | Readiness-Checks | Before moving to the next stage, verify: no open `changes-requested` or `rejected` review findings, all blockers are resolved, and dependent artifacts are at an accepted status. |
| VAL-05-010 | Fallback | Manual review is the primary verification mechanism by design, not a fallback for missing automation. Document what was checked and the outcome. |
| VAL-06-010 | Boundaries | Do not implement or change code. |
| VAL-06-020 | Boundaries | Do not modify artifacts beyond updating their status. |
| VAL-06-030 | Boundaries | Do not skip validation steps without explicit approval. |
| VAL-07-010 | Procedure | When a relevant playbook defines required checks or outputs for the work under validation, verify that those expectations were followed. Playbooks may refine what to verify for a task shape, but Validation still owns the validation decision and boundaries (`COR-04-070`). |

## Output

Validation findings should be documented as part of a Review artifact or inline in the plan step summary.
Use `agent-harness/templates/REVIEW-template.md` when a formal review record is needed.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when validating scope or structural boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/DOMAIN.md` — when validating domain-critical behavior
