# QUESTION-LIFECYCLE.md

## Purpose

Explain how a Question moves from raised, to referenced by the artifacts it constrains, to resolved or
discarded — and how that resolution can spin off a new Idea or unblock the artifact that was waiting on it.

This is a System file: it explains how multiple rules and artifacts interact. It is not a Rules table. The
enforceable obligations remain in the rule files that define the participating rule IDs.

## Participating Rules

| Rule | Home | Direction | Role |
| --- | --- | --- | --- |
| `QST-08-010` | `agent-harness/rules/artifact-specs/QUESTIONS.md` | Raising | Allows any mode to create a Question, no mode switch required. |
| `QST-09-010` | `agent-harness/rules/artifact-specs/QUESTIONS.md` | Raising | Requires every Question to be recorded in the registry — no local-only store. |
| `COR-01-110`–`112` | `agent-harness/rules/CORE/UNIVERSAL.md` | Raising | Governs the Question-vs-Idea decision before either is created (see `QST-06-010`). |
| `COR-01-120` | `agent-harness/rules/CORE/UNIVERSAL.md` | Referencing | Requires every artifact's Open Questions section to hold canonical Question IDs, not freeform text — the link that lets a resolution reach every artifact citing it. |
| `UCS-05-010`/`020` | `agent-harness/rules/artifact-specs/USE-CASES.md` | Carry-forward | Loads registry entries tied to the Use Case's source artifact and routes them by effect into the Use Case body. |
| `SPS-05-010`/`020` | `agent-harness/rules/artifact-specs/SPECS.md` | Carry-forward | Same carry-forward, one funnel stage later, for Specs. |
| `LDG-04-060`/`070` | `agent-harness/rules/modes/legacy-discovery/CLARIFICATION.md` | Resolution (legacy) | Moves a legacy-origin question's row and enriches reference docs in the same pass. |
| `DEC-11-010` | `agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` | Resolution (ADR) | Moves a Question's row when an ADR settles it and reaches `accepted`. |
| `QST-07-010` | `agent-harness/rules/artifact-specs/QUESTIONS.md` | Resolution | The mechanical row-move: keep the ID, turn `Question` text into `Decision`, record what settled it, delete the stale copy. |
| `QST-07-020` | `agent-harness/rules/artifact-specs/QUESTIONS.md` | Idea spin-off | Requires a `Follow-up: resolved\|idea` tag on every resolved row, and creates a new Idea citing the Question's ID when tagged `idea`. |
| `QST-05-010` | `agent-harness/rules/artifact-specs/QUESTIONS.md` | Non-deletion | IDs stay permanent through merges, discards, and resolutions. |

## Operating Model

A Question can be raised from any mode the moment a genuine fork is recognized (`QST-08-010`) — the harness draws
the line between an Idea (a candidate direction) and a Question (an unresolved fork) via `QST-06-010`, applied
through `CORE.md`'s `COR-01-110`–`112`. It always lands in `QUESTIONS-OPEN.md`, never a local per-artifact store
(`QST-09-010`).

Once raised, a Question spreads outward by citation, not by copy: every artifact whose content depends on the
answer references the Question's canonical ID in its own Open Questions section (`COR-01-120`), rather than
restating the question text. A Use Case or Spec created from a source that carries open registry entries loads
those entries and routes them by effect — approval-shaping uncertainty into Open Questions, concrete constraints
into the section they constrain (`UCS-05-010`/`020`, `SPS-05-010`/`020`). This is how one Question can gate
several downstream artifacts without duplicating its text in each one.

Resolution is a single atomic move, regardless of what triggered it — a Question Clarification pass in Legacy
Discovery, an ADR reaching `accepted`, or any other mode settling the fork. The row moves out of
`QUESTIONS-OPEN.md` into `QUESTIONS-RESOLVED.md` or `QUESTIONS-DISCARDED.md`, its ID preserved, its former
`Question` text becoming `Decision` text, with `Notes` recording what settled it (`QST-07-010`). The ID is never
reused or deleted, even after merges (`QST-05-010`) — every citation an artifact recorded against it in step two
above continues to resolve correctly, now pointing at a resolved answer instead of an open fork. If the
resolution itself amounts to "yes, pursue this," it does not silently become an Idea in place — a new Idea is
created citing the Question's ID, tagged in `Notes` so the trigger is explicit rather than inferred
(`QST-07-020`).

## How To Apply

Before creating a Question, apply the Idea-vs-Question test (`QST-06-010`) rather than defaulting to whichever
artifact type is more familiar. When an artifact is created from a source that has open registry entries, load
them before drafting content — don't discover the carry-forward obligation only at a later readiness check. When
resolving a Question, perform the row move, the `Follow-up` tag, and (if `idea`) the new Idea creation as one
pass, not staggered across turns — the citing artifacts' Open Questions sections stay accurate only if the
registry move and any downstream artifact updates happen together.

## Examples

- A Legacy Finding establishes current behavior but leaves the target policy open. The agent raises a
  `Q-<APP>-NNNN` row, cites the finding in `Source`, and adds the ID to the finding's own Open Questions. Later, a
  Use Case drafted from that finding loads the still-open row and carries it into its own Open Questions rather
  than repeating the question text.
- Question Clarification resolves that row toward "adopt the legacy behavior as-is." The agent moves it to
  `QUESTIONS-RESOLVED.md`, tags `Follow-up: resolved`, and updates the citing Use Case's Open Questions entry to
  reflect the settled answer.
- A different Question resolves toward "yes, let's build a rate-limiter." The agent moves the row, tags
  `Follow-up: idea`, and creates a new `IDEA-*.md` citing the Question's ID in `source`.

## Reference Files

- `agent-harness/artifact-specs/QUESTIONS.md`
- `agent-harness/rules/CORE/UNIVERSAL.md`
- `agent-harness/artifact-specs/USE-CASES.md`
- `agent-harness/artifact-specs/SPECS.md`
- `agent-harness/modes/legacy-discovery/CLARIFICATION.md`
