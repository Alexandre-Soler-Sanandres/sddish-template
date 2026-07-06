# RELATIONS-AND-SUPERSESSION.md

## Purpose

Handling for ADR `related`/`supersedes`/`superseded_by` relationship fields, and for changing a decision after
acceptance. Load this file when an ADR supersedes another ADR, cites a `related` ADR, or settles a Questions
registry entry — not needed when drafting a fresh, unrelated ADR.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| DEC-06-010 | Immutability | Once `status` is `accepted`, do not edit `Decision` or `Consequences` in place to reflect a change of mind — create a new ADR that supersedes this one and update both artifacts' `supersedes`/`superseded_by` links. Refining `Context` or `Open Questions` before acceptance is fine. |
| DEC-07-010 | Relationship-Fields | When a Use Case or Spec is created that depends on an accepted ADR, add the ADR's ID to that artifact's `related` field and add the new artifact's ID to the ADR's own `derived_use_cases`/`derived_specs` field in the same pass. |
| DEC-08-010 | Reference-Sync | When a `harness-data/reference/*.md` `## Decisions` entry cites this ADR and the ADR is superseded per `DEC-06-010`, update that reference doc's citation to the superseding ADR in the same pass. |
| DEC-09-010 | Relations | Every ID listed in `related` must be explained in the ADR body under a "Relation to (ID) (type):" note, naming which of a fixed vocabulary the relationship is — `supersession-deferred`, `reuse`, `dependency`, `additive`, or `sibling-split` — plus the concrete reason. IDs already covered by `supersedes`/`superseded_by` don't need a separate note; this targets `related`, where the relationship is otherwise implicit. |
| DEC-10-010 | Supersession-Timing | A `proposed` ADR that intends to supersede an already-`accepted` ADR must not set `supersedes` for that target, and the target must not set `superseded_by`, until the superseding ADR's own `status` actually transitions to `accepted` — record the relationship via `related` with a `supersession-deferred` note (per `DEC-09-010`) until then. Both frontmatter fields update together, in the same pass, at that transition. |
| DEC-11-010 | Resolution-Sync | When an ADR settles a Questions-registry entry (mirrors `DEC-07-010`'s relationship-field pattern), update that entry's `Status` to `Resolved` citing this ADR's ID, in the same pass as setting the ADR to `accepted`. |
