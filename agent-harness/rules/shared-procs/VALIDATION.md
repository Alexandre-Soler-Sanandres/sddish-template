# VALIDATION Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| VAL-01-010 | Artifact-Validation | Required frontmatter fields MUST be present and filled. |
| VAL-01-020 | Artifact-Validation | Status MUST be appropriate for the current stage. |
| VAL-01-030 | Artifact-Validation | Traceability links (`source`, `derived_*`, `related`) MUST be present and synchronized where required. |
| VAL-01-040 | Artifact-Validation | ID MUST be stable and follow naming conventions. |
| VAL-01-050 | Artifact-Validation | Body sections MUST be complete and not left as placeholders. |
| VAL-02-010 | Process-Validation | The artifact's creation MUST have been permitted by `shared-procs/RISK-TIER.md`'s Necessity cascade for its tier (carried forward from an earlier stage, or run fresh) — OR, when the artifact's own `## Risk-Tier Classification` section (`RSK-05-010`) documents a valid skip, that section satisfies this check. A parent artifact's own status is not itself a creation precondition (`IMPROVEMENT-0129`). |
| VAL-02-020 | Process-Validation | The Implementation Plan MUST be at status `ready` before implementation starts. |
| VAL-02-030 | Process-Validation | Implementation MUST NOT have happened before a plan was `ready`. |
| VAL-02-040 | Process-Validation | Specs or Tasks MUST NOT have been created from Partnering mode. |
| VAL-02-050 | Process-Validation | MUST verify `COR-09-010`'s high-risk handling (scope and validation coverage, plus approval coverage for payments) was followed for any high-risk area touched. |
| VAL-02-060 | Process-Validation | MUST reconcile the actual code changes (via `git log`/`git diff`) against the `ready` Implementation Plan's `allowed_paths` and steps, flagging any file changed outside `allowed_paths`, or any change with no corresponding Plan step, as a finding. |
| VAL-03-010 | Behavioral-Validation | Each acceptance criterion MUST be met and verifiable. |
| VAL-03-020 | Behavioral-Validation | `test_refs` in the Spec frontmatter MUST be populated, contain only test file paths, with all referenced test files existing. |
| VAL-03-030 | Behavioral-Validation | Each acceptance criterion MUST be traceable to an entry in `test_refs` or a Task validation command. |
| VAL-03-040 | Behavioral-Validation | Non-goals MUST NOT have been implemented. |
| VAL-03-050 | Behavioral-Validation | Scope MUST NOT drift beyond what was planned. |
| VAL-03-060 | Behavioral-Validation | Technical checks MUST have been run during Implementation (see `agent-harness/modes/IMPLEMENTING.md`). |
| VAL-04-010 | Readiness-Checks | Before moving to the next stage, MUST verify: no open `changes-requested` or `rejected` review findings, all blockers are resolved, and dependent artifacts are at an accepted status. |
| VAL-05-010 | Fallback | Manual review is the primary verification mechanism by design, not a fallback for missing automation; MUST document what was checked and the outcome. |
| VAL-06-010 | Boundaries | MUST NOT implement or change code. |
| VAL-06-020 | Boundaries | MUST NOT modify artifacts beyond updating their status. |
| VAL-06-030 | Boundaries | MUST NOT skip validation steps without explicit approval. |
| VAL-06-040 | Boundaries | MUST NOT execute or run technical checks/tests directly during Validation; confirm via `VAL-03-060` that they were run during Implementation instead. |
| VAL-07-010 | Procedure | MUST verify that a relevant playbook's required checks or outputs were followed, when one defines them for the work under validation. |
| VAL-07-020 | Procedure | Playbooks MAY refine what to verify for a task shape; Validation retains ownership of the validation decision and boundaries (`COR-04-070`). |
