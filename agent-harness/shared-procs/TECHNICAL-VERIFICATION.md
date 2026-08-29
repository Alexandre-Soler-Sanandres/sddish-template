# Technical Verification

## Purpose

Run planned tests, builds, linters, analyzers, security checks, and behavioral probes during implementation and
closeout.

## Procedure

1. Select checks that prove the changed and preserved behavior.
2. Run each named check after meaningful small batches.
3. Record the command, relevant output, exit status, and the requirement/gate it proves.
4. Stop for unexpected failures, contradictory requirements, or uncovered high risk.

## Rules

| ID | Rule |
| --- | --- |
| TVR-01-010 | Technical Verification MUST run the named checks rather than merely inspect their configuration. |
| TVR-01-020 | Technical evidence MUST identify its command or probe, outcome, and the requirement or gate it proves. |
| TVR-01-030 | Unexpected failure, contradictory requirements, or uncovered high risk MUST stop the affected batch. |
