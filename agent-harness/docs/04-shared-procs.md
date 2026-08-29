# Shared Procedures

## V2 procedures

- `INTENT-VALIDATION.md` — requirements correctness, completeness, feasibility, and verifiability.
- `TECHNICAL-VERIFICATION.md` — executed tests and other technical evidence.
- `CONFORMANCE-AUDIT.md` — read-only lane, approval, traceability, Question, ADR, conflict, and evidence review.
- `PROMOTION.md` — common promotion gates and atomic status transition.

`VALIDATION.md` is a temporary v1 migration shim only and is not a v2 procedure.

A shared procedure file under `agent-harness/shared-procs/` is a Procedure Guide. It is invoked by name from Mode
or artifact control flow, has no schema, and produces no artifact of its own. It is neither a Mode Workflow (a
behavioral posture) nor an Artifact Contract (a document type). See [01-core-principles.md](01-core-principles.md)'s
"Harness File Taxonomy" section for how the categories relate.

Procedure Guides are harness-native and universal. They are required by the harness model when invoked: skipping
one can change routing, validation, lifecycle, or approval semantics. That is why `RISK-TIER.md` is a Procedure
Guide, not a playbook: its cascade decides which artifact tiers may be skipped before Planning-Implementation.

Procedure Guide prose explains how to run the procedure well; paired rules under
`agent-harness/rules/shared-procs/` hold enforceable gates, routing requirements, and audit points.

## Validation

`VALIDATION.md` checks artifacts, plans, and implementations against process and behavioral criteria. It does not
run technical checks — those belong to Implementing, guided by `harness-data/reference/QUALITY.md` and `TOOLING.md`.

**Invoked from:** Planning-Implementation (the `chain-preflight` profile, before a Plan is promoted), Implementing
(as its own closing gate, after each plan step), Improving-Harness (as part of its own change process)
**Covers:** Artifact completeness, process rule compliance, acceptance criteria, readiness checks
**Output:** Profile-dependent — `artifact-readiness` reports pass/fail to the invoking mode or wrapper,
`chain-preflight` returns a read-only report for the Plan's `## Chain Preflight` section and verifies its
`## Scoped Parent Readiness` evidence, and
`implementation-result` reports into the relevant closeout surface. Validation does not modify the checked
artifacts beyond status; a Review artifact holds the record when a formal one is needed.

Short version:

- Validation asks "did we follow the process, and is the behavior verifiable?"
- Implementing asks "did we run the actual project checks?"

## Risk-Tier

`RISK-TIER.md` classifies the minimum required entry tier before work reaches Planning-Implementation. It is
reusable, but it is not optional support material: its outcome changes whether the agent creates a Use Case, Spec,
Task, or direct Plan-tier Implementation Plan.
