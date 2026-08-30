# RELATIONS-AND-SUPERSESSION.md

## Purpose

Handling for ADR `related_adrs`, typed relation notes, generated backlinks, and changing a decision after
acceptance. This is a support file for `agent-harness/artifact-specs/ADR.md`, not an independent Artifact
Contract — it has no `Sources`, `When To Create`, or lifecycle of its own beyond the ADR's. Load it when an ADR
supersedes another ADR, cites `related_adrs`, or settles a Questions registry entry — not needed when drafting
a fresh, unrelated ADR (`ADR.md`'s `DEC-12-010`).

## Rules

| ID | Rule |
| --- | --- |
| DEC-06-010 | Once `status` is `accepted`, MUST NOT edit `Decision` or `Consequences` to reflect a change of mind; create a new ADR that cites the old ADR in `related_adrs`, records a `supersedes` typed body note, and set the old ADR to `superseded` only when the new ADR is accepted. |
| DEC-07-010 | When a Use Case or Spec depends on an accepted ADR, MUST add its ID to that consumer's `related_adrs`; derive ADR consumers by scanning forward citations. |
| DEC-07-011 | A `fleet-wide` ADR MUST omit handwritten consumer lists; explicit dependencies still use `related_adrs`. |
| DEC-07-012 | Tasks MUST use the same forward `related_adrs` consumer rule; see `TASKS.md`'s `TSK-05-010`. |
| DEC-08-010 | When a `harness-data/reference/*.md` `## Decisions` entry cites this ADR and the ADR is superseded per `DEC-06-010`, MUST update that reference doc's citation to the superseding ADR in the same pass. |
| DEC-09-010 | Every ID in `related_adrs` MUST have a body note `Relation to (ID) (type):` using `supersedes`, `supersession-deferred`, `reuse`, `dependency`, `additive`, or `sibling-split`, plus the reason. |
| DEC-10-010 | A proposed successor MUST cite the accepted ADR in `related_adrs` with `supersession-deferred`; when accepted, change the note type to `supersedes` and set the older ADR to `superseded` in the same pass. |
| DEC-11-010 | When an accepted ADR settles a Question, MUST update that registry row in place per `QST-07-010` and cite the ADR as its resolution basis. |
