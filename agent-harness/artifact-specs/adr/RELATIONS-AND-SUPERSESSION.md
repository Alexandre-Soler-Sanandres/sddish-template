# RELATIONS-AND-SUPERSESSION.md

## Purpose

Handling for ADR `related`/`supersedes`/`superseded_by` relationship fields, and for changing a decision after
acceptance. This is a support file for `agent-harness/artifact-specs/ADR.md`, not an independent Artifact
Contract — it has no `Sources`, `When To Create`, or lifecycle of its own beyond the ADR's. Load it when an ADR
supersedes another ADR, cites a `related` ADR, or settles a Questions registry entry — not needed when drafting
a fresh, unrelated ADR (`ADR.md`'s `DEC-12-010`).

## Rules

| ID | Rule |
| --- | --- |
| DEC-06-010 | Once `status` is `accepted`, MUST NOT edit `Decision` or `Consequences` in place to reflect a change of mind — instead create a new ADR that supersedes this one and update both artifacts' `supersedes`/`superseded_by` links. (Refining `Context` or `Open Questions` before acceptance is fine.) |
| DEC-07-010 | When a Use Case or Spec is created that depends on an accepted `scoped` ADR, MUST add the ADR's ID to that artifact's `related` field and add the new artifact's ID to the ADR's own `derived_use_cases`/`derived_specs` field in the same pass. |
| DEC-07-011 | A `fleet-wide` ADR (`ADR.md`'s `DEC-14-010`) is exempt from `DEC-07-010`'s reverse-link half — its applicability is already fully expressed by `scope: fleet-wide` itself; `derived_use_cases`/`derived_specs` stay empty by convention and this is not a gap. |
| DEC-07-012 | `DEC-07-010`/`DEC-07-011` cover Use Case/Spec only — the Task-side equivalent lives in `agent-harness/artifact-specs/TASKS.md`'s `TSK-05-010` (Task `related` ↔ ADR `derived_tasks`). |
| DEC-08-010 | When a `harness-data/reference/*.md` `## Decisions` entry cites this ADR and the ADR is superseded per `DEC-06-010`, MUST update that reference doc's citation to the superseding ADR in the same pass. |
| DEC-09-010 | Every ID listed in `related` MUST be explained in the ADR body under a "Relation to (ID) (type):" note, naming which of a fixed vocabulary the relationship is — `supersession-deferred`, `reuse`, `dependency`, `additive`, or `sibling-split` — plus the concrete reason. IDs already covered by `supersedes`/`superseded_by` don't need a separate note; this targets `related`, where the relationship is otherwise implicit. |
| DEC-10-010 | A `proposed` ADR that intends to supersede an already-`accepted` ADR MUST NOT set `supersedes` for that target, nor may the target set `superseded_by`, until the superseding ADR's own `status` actually transitions to `accepted` — record the relationship via `related` with a `supersession-deferred` note (per `DEC-09-010`) until then. Both frontmatter fields then update together, in the same pass, at that transition. |
| DEC-11-010 | When an ADR settles a Questions-registry entry and the ADR is set to `accepted`, MUST move that entry's row per `QUESTIONS.md`'s `QST-07-010` in the same pass, citing this ADR's ID. |
