# RELATIONS-AND-SUPERSESSION.md

## Purpose

Handling for ADR `related`/`supersedes`/`superseded_by` relationship fields, and for changing a decision after
acceptance. This is a support file for `agent-harness/artifact-specs/ADR.md`, not an independent Artifact
Contract — it has no `Sources`, `When To Create`, or lifecycle of its own beyond the ADR's. Load it when an ADR
supersedes another ADR, cites a `related` ADR, or settles a Questions registry entry — not needed when drafting
a fresh, unrelated ADR (`ADR.md`'s `DEC-12-010`).

## Rules Map

This file's enforceable rules live in
`agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` (single paired file — under the 25-rule
grouping threshold). Load it alongside this file under the same condition as this file itself (`DEC-12-010`).
