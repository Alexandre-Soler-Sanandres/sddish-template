# VALIDATION Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| VAL-00-010 | Profile-Selection | Validation MUST run under exactly one profile: `artifact-readiness`, `chain-preflight`, or `implementation-result`. |
| VAL-00-020 | Profile-Selection | `artifact-readiness` MUST be used for a single-artifact gate, `chain-preflight` before Plan promotion, and `implementation-result` after implementation work exists or during implementation closeout. |
| VAL-00-030 | Profile-Selection | Before Plan promotion, Validation MUST run the `chain-preflight` profile against the selected UC/Spec/Task/Plan chain. |
| VAL-00-040 | Profile-Selection | A direct `/validate` invocation MUST name both the validation target and the current phase unless the wrapper can infer one profile unambiguously from those inputs. |
| VAL-00-050 | Profile-Selection | Wrappers MUST stop and request the missing target or phase when `VAL-00-040`'s profile selection is ambiguous. |
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
| VAL-02-061 | Process-Validation | `chain-preflight` MUST verify bidirectional ID consistency across the selected UC/Spec/Task/Plan chain. |
| VAL-02-062 | Process-Validation | `chain-preflight` MUST verify requirement-to-acceptance coverage, including any mapping required by the participating Spec. |
| VAL-02-063 | Process-Validation | `chain-preflight` MUST verify Task coverage and Plan-step coverage for the approved scope. |
| VAL-02-064 | Process-Validation | `chain-preflight` MUST verify dependency order and allowed/expected-path consistency across Tasks and Plan steps. |
| VAL-02-065 | Process-Validation | `chain-preflight` MUST verify ADR application and unresolved Questions that would block promotion. |
| VAL-02-066 | Process-Validation | `chain-preflight` MUST verify non-goal conflicts and risk-coverage gaps across the selected chain. |
| VAL-02-067 | Process-Validation | `chain-preflight` MUST verify that the selected validation commands or other evidence cover the approved scope without relying on future implementation outputs. |
| VAL-02-068 | Process-Validation | `chain-preflight` MUST report the checked artifact IDs, paths, `updated` values, and git blob/hash when available for every participating artifact. |
| VAL-02-069 | Process-Validation | `chain-preflight` findings MUST be returned read-only to Planning for durable recording in the Plan rather than written directly into the checked artifacts by Validation. |
| VAL-02-070 | Process-Validation | `chain-preflight` MUST verify each source-chain Spec's complete included/sibling Task accounting, the declared statuses/ownership/nonblocking rationale, and whether any excluded sibling's dependency, required shared path, requirement/acceptance overlap, or unresolved Question/Review affects the Plan slice. |
| VAL-02-071 | Process-Validation | `chain-preflight` MUST verify the Plan's declared parent requirement, acceptance, constraint, dependency, risk, and preserved-behavior items and current full-parent-fan-out result against current source artifacts. |
| VAL-03-010 | Behavioral-Validation | Each acceptance criterion MUST be met and verifiable. |
| VAL-03-020 | Behavioral-Validation | Under `artifact-readiness`, a Spec's `test_refs` evidence MAY be planned rather than already implemented, but the validation mapping MUST be credible and MUST NOT invent future test files merely to satisfy the gate. |
| VAL-03-021 | Behavioral-Validation | Under `implementation-result`, when tests are the chosen evidence, `test_refs` in the Spec frontmatter MUST be populated, contain only test file paths, and every referenced test file MUST exist. |
| VAL-03-030 | Behavioral-Validation | Under `artifact-readiness`, each acceptance criterion MUST be traceable to a credible planned evidence source such as a test intent, a named validation command, or justified manual proof. |
| VAL-03-031 | Behavioral-Validation | Under `implementation-result`, each acceptance criterion MUST be traceable to an existing `test_refs` entry, a named validation command, or justified manual evidence. |
| VAL-03-040 | Behavioral-Validation | Non-goals MUST NOT have been implemented. |
| VAL-03-050 | Behavioral-Validation | Scope MUST NOT drift beyond what was planned. |
| VAL-03-060 | Behavioral-Validation | Technical checks MUST have been run during Implementation (see `agent-harness/modes/IMPLEMENTING.md`). |
| VAL-04-010 | Readiness-Checks | Before moving to the next stage, MUST verify: no open `changes-requested` or `rejected` review findings, all scope-affecting blockers are resolved, and included or scope-affecting dependent artifacts are at an accepted status; an unrelated recorded draft or blocked sibling outside a scoped Plan does not itself block promotion. |
| VAL-04-020 | Readiness-Checks | A Plan's `## Chain Preflight` report MUST be present and passing before the Plan may advance to `ready`. |
| VAL-04-021 | Readiness-Checks | If any artifact or parent item participating in a Plan's recorded `chain-preflight` report changes after that run, the report is stale and MUST be rerun before promotion. |
| VAL-05-010 | Fallback | Manual review is the primary verification mechanism by design, not a fallback for missing automation; MUST document what was checked and the outcome. |
| VAL-06-010 | Boundaries | MUST NOT implement or change code. |
| VAL-06-020 | Boundaries | MUST NOT modify artifacts beyond updating their status. |
| VAL-06-021 | Boundaries | `chain-preflight` MUST remain read-only against the checked UC/Spec/Task/Plan artifacts; Validation returns findings, and Planning writes the canonical Plan report. |
| VAL-06-022 | Boundaries | When `chain-preflight` findings need an independent durable record, Validation or Planning MUST create or update a Review and cite it from the Plan instead of storing an inline summary on the checked artifacts. |
| VAL-06-030 | Boundaries | MUST NOT skip validation steps without explicit approval. |
| VAL-06-040 | Boundaries | MUST NOT execute or run technical checks/tests directly during Validation; confirm via `VAL-03-060` that they were run during Implementation instead. |
| VAL-07-010 | Procedure | MUST verify that a relevant playbook's required checks or outputs were followed, when one defines them for the work under validation. |
| VAL-07-020 | Procedure | Playbooks MAY refine what to verify for a task shape; Validation retains ownership of the validation decision and boundaries (`COR-04-070`). |
