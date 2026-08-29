# Validation (v1 migration shim)

This temporary v1-only shim routes old callers to [Intent Validation](INTENT-VALIDATION.md),
[Technical Verification](TECHNICAL-VERIFICATION.md), or [Conformance Audit](CONFORMANCE-AUDIT.md). New v2
workflows, artifacts, templates, and loaders must not cite it. It is removed by `IMPROVEMENT-0148`.

## Rules

### Legacy (v1)

Retained verbatim from the pre-v2 paired rules so active v1 UC/Spec/Task/Plan chains keep a resolvable
validation contract during the v2 cutover (`IMPROVEMENT-0148`–`0150`). The v2 replacements are
`INTENT-VALIDATION.md`, `TECHNICAL-VERIFICATION.md`, and `CONFORMANCE-AUDIT.md`; these `-v1` rows are retired
with this shim by `IMPROVEMENT-0150`. IDs carry a `-v1` suffix.

| ID | Rule |
| --- | --- |
| VAL-00-010-v1 | Validation MUST run under exactly one profile: `artifact-readiness`, `chain-preflight`, or `implementation-result`. |
| VAL-00-020-v1 | `artifact-readiness` MUST be used for a single-artifact gate, `chain-preflight` before Plan promotion, and `implementation-result` after implementation work exists or during implementation closeout. |
| VAL-00-030-v1 | Before Plan promotion, Validation MUST run the `chain-preflight` profile against the selected UC/Spec/Task/Plan chain. |
| VAL-00-040-v1 | A direct `/validate` invocation MUST name both the validation target and the current phase unless the wrapper can infer one profile unambiguously from those inputs. |
| VAL-00-050-v1 | Wrappers MUST stop and request the missing target or phase when `VAL-00-040-v1`'s profile selection is ambiguous. |
| VAL-01-010-v1 | Required frontmatter fields MUST be present and filled. |
| VAL-01-020-v1 | Status MUST be appropriate for the current stage. |
| VAL-01-030-v1 | Traceability links (`source`, `derived_*`, `related`) MUST be present and synchronized where required. |
| VAL-01-040-v1 | ID MUST be stable and follow naming conventions. |
| VAL-01-050-v1 | Body sections MUST be complete and not left as placeholders. |
| VAL-02-010-v1 | The artifact's creation MUST have been permitted by `shared-procs/RISK-TIER.md`'s Necessity cascade for its tier (carried forward from an earlier stage, or run fresh) — OR, when the artifact's own `## Risk-Tier Classification` section (`RSK-05-010-v1`) documents a valid skip, that section satisfies this check. A parent artifact's own status is not itself a creation precondition (`IMPROVEMENT-0129`). |
| VAL-02-020-v1 | The Implementation Plan MUST be at status `ready` before implementation starts. |
| VAL-02-030-v1 | Implementation MUST NOT have happened before a plan was `ready`. |
| VAL-02-040-v1 | Specs or Tasks MUST NOT have been created from Partnering mode. |
| VAL-02-050-v1 | MUST verify `COR-09-010`'s high-risk handling (scope and validation coverage, plus approval coverage for payments) was followed for any high-risk area touched. |
| VAL-02-060-v1 | MUST reconcile the actual code changes (via `git log`/`git diff`) against the `ready` Implementation Plan's `allowed_paths` and steps, flagging any file changed outside `allowed_paths`, or any change with no corresponding Plan step, as a finding. |
| VAL-02-061-v1 | `chain-preflight` MUST verify bidirectional ID consistency across the selected UC/Spec/Task/Plan chain. |
| VAL-02-062-v1 | `chain-preflight` MUST verify requirement-to-acceptance coverage, including any mapping required by the participating Spec. |
| VAL-02-063-v1 | `chain-preflight` MUST verify Task coverage and Plan-step coverage for the approved scope. |
| VAL-02-064-v1 | `chain-preflight` MUST verify dependency order and allowed/expected-path consistency across Tasks and Plan steps. |
| VAL-02-065-v1 | `chain-preflight` MUST verify ADR application and unresolved Questions that would block promotion. |
| VAL-02-066-v1 | `chain-preflight` MUST verify non-goal conflicts and risk-coverage gaps across the selected chain. |
| VAL-02-067-v1 | `chain-preflight` MUST verify that the selected validation commands or other evidence cover the approved scope without relying on future implementation outputs. |
| VAL-02-068-v1 | `chain-preflight` MUST report the checked artifact IDs, paths, `updated` values, and git blob/hash when available for every participating artifact. |
| VAL-02-069-v1 | `chain-preflight` findings MUST be returned read-only to Planning for durable recording in the Plan rather than written directly into the checked artifacts by Validation. |
| VAL-02-070-v1 | `chain-preflight` MUST verify each source-chain Spec's complete included/sibling Task accounting, the declared statuses/ownership/nonblocking rationale, and whether any excluded sibling's dependency, required shared path, requirement/acceptance overlap, or unresolved Question/Review affects the Plan slice. |
| VAL-02-071-v1 | `chain-preflight` MUST verify the Plan's declared parent requirement, acceptance, constraint, dependency, risk, and preserved-behavior items and current full-parent-fan-out result against current source artifacts. |
| VAL-03-010-v1 | Each acceptance criterion MUST be met and verifiable. |
| VAL-03-020-v1 | Under `artifact-readiness`, a Spec's `test_refs` evidence MAY be planned rather than already implemented, but the validation mapping MUST be credible and MUST NOT invent future test files merely to satisfy the gate. |
| VAL-03-021-v1 | Under `implementation-result`, when tests are the chosen evidence, `test_refs` in the Spec frontmatter MUST be populated, contain only test file paths, and every referenced test file MUST exist. |
| VAL-03-030-v1 | Under `artifact-readiness`, each acceptance criterion MUST be traceable to a credible planned evidence source such as a test intent, a named validation command, or justified manual proof. |
| VAL-03-031-v1 | Under `implementation-result`, each acceptance criterion MUST be traceable to an existing `test_refs` entry, a named validation command, or justified manual evidence. |
| VAL-03-040-v1 | Non-goals MUST NOT have been implemented. |
| VAL-03-050-v1 | Scope MUST NOT drift beyond what was planned. |
| VAL-03-060-v1 | Technical checks MUST have been run during Implementation (see `agent-harness/modes/IMPLEMENTING.md`). |
| VAL-04-010-v1 | Before moving to the next stage, MUST verify: no open `changes-requested` or `rejected` review findings, all scope-affecting blockers are resolved, and included or scope-affecting dependent artifacts are at an accepted status; an unrelated recorded draft or blocked sibling outside a scoped Plan does not itself block promotion. |
| VAL-04-020-v1 | A Plan's `## Chain Preflight` report MUST be present and passing before the Plan may advance to `ready`. |
| VAL-04-021-v1 | If any artifact or parent item participating in a Plan's recorded `chain-preflight` report changes after that run, the report is stale and MUST be rerun before promotion. |
| VAL-05-010-v1 | Manual review is the primary verification mechanism by design, not a fallback for missing automation; MUST document what was checked and the outcome. |
| VAL-06-010-v1 | MUST NOT implement or change code. |
| VAL-06-020-v1 | MUST NOT modify artifacts beyond updating their status. |
| VAL-06-021-v1 | `chain-preflight` MUST remain read-only against the checked UC/Spec/Task/Plan artifacts; Validation returns findings, and Planning writes the canonical Plan report. |
| VAL-06-022-v1 | When `chain-preflight` findings need an independent durable record, Validation or Planning MUST create or update a Review and cite it from the Plan instead of storing an inline summary on the checked artifacts. |
| VAL-06-030-v1 | MUST NOT skip validation steps without explicit approval. |
| VAL-06-040-v1 | MUST NOT execute or run technical checks/tests directly during Validation; confirm via `VAL-03-060-v1` that they were run during Implementation instead. |
| VAL-07-010-v1 | MUST verify that a relevant playbook's required checks or outputs were followed, when one defines them for the work under validation. |
| VAL-07-020-v1 | Playbooks MAY refine what to verify for a task shape; Validation retains ownership of the validation decision and boundaries (`COR-04-070`). |
