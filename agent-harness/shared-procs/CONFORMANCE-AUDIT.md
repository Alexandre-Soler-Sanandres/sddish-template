# Conformance Audit

## Purpose

Read canonical work records to establish that their lane, scope, approvals, traceability, Questions, ADRs,
conflicts, and evidence coverage conform. It is not a test runner.

## Procedure

1. Check the selected lane and required artifact shape.
2. Check approvals and current content hash where required.
3. Resolve canonical ID links, applicable ADRs, Questions, scope conflicts, and evidence coverage.
4. Report findings and record only the evidence inspected.

## Rules

| ID | Rule |
| --- | --- |
| CFA-01-010 | Conformance Audit MUST be read-only against canonical work artifacts. |
| CFA-01-020 | Conformance Audit MUST NOT claim technical checks it did not run. |
| CFA-01-030 | Assured closeout MUST record conformance evidence in its Implementation Plan; Standard closeout MUST record it in its Change Spec. |
