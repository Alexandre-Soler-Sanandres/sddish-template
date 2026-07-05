# Shared Procedures

A shared procedure (`agent-harness/shared-procs/`) is a checklist invoked by name from within a Mode's own rules.
It has no schema and produces no artifact of its own — it is neither a Mode (a behavioral posture) nor an artifact
spec (a document type). See [01-core-principles.md](01-core-principles.md)'s "Three Kinds of Harness File" section
for how the three categories relate.

## Validation

Checks artifacts, plans, and implementations against process and behavioral criteria. Does not run technical
checks — those belong to Implementing, guided by `harness-data/reference/QUALITY.md` and `TOOLING.md`.

**Invoked from:** Implementing (as its own closing gate, after each plan step), Improving-Harness (as part of its
own change process)
**Covers:** Artifact completeness, process rule compliance, acceptance criteria, readiness checks
**Output:** Findings documented inline in the plan step summary, or as a Review artifact when a formal record is
needed.

Short version:

- Validation asks "did we follow the process, and is the behavior verifiable?"
- Implementing asks "did we run the actual project checks?"
