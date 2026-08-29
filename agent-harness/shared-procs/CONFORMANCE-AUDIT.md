# Conformance Audit

## Purpose

Read canonical work records to establish that their lane, scope, approvals, traceability, Questions, ADRs,
conflicts, and evidence coverage conform. It is not a test runner.

## Procedure

1. Check the selected lane and required artifact shape.
2. Check approvals and current content hash where required.
3. Resolve canonical ID links, applicable ADRs, Questions, scope conflicts, and evidence coverage.
4. Report findings and record only the evidence inspected.

For chain-preflight, also inspect bidirectional IDs, Task and Plan-step coverage, dependency and path
consistency, applicable ADRs and blocking Questions, non-goals and risk gaps, scope evidence, and any independent
findings that need routing to a Review.

## Rules

| ID | Rule |
| --- | --- |
| CFA-01-010 | Conformance Audit MUST be read-only against canonical work artifacts. |
| CFA-01-020 | Conformance Audit MUST NOT claim technical checks it did not run. |
| CFA-01-030 | Assured closeout MUST record conformance evidence in its Implementation Plan; Standard closeout MUST record it in its Change Spec. |
| CFA-01-040 | Conformance Audit MUST run in one mode per phase: single-artifact readiness, chain-preflight before Plan promotion, or implementation-result after implementation exists. Before Plan promotion, chain-preflight MUST run. |
| CFA-02-010 | Chain-preflight MUST verify requirement-to-acceptance coverage across the chain, including any mapping the participating Spec requires. |
| CFA-02-020 | Chain-preflight MUST verify each source Spec's complete included and sibling Task accounting, and whether an excluded sibling affects the Plan slice. |
| CFA-02-030 | A recorded chain-conformance report is stale and MUST be rerun before promotion if any participating artifact or parent item changed after the run. |
