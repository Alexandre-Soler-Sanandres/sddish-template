# LIFECYCLE-FOLDERS.md

## Purpose

Explain why different artifact types use different lifecycle-folder shapes — some a plain `active/`/`archive/`
pair, some an extra load-bearing intermediate folder, one a no-subfolder flat-file registry — and how an
artifact's `status` field and its folder location move together.

This is a System file: it explains how multiple rules and artifacts interact. It is not a Rules table. The
enforceable obligations remain in the rule files that define the participating rule IDs.

## Participating Rules

| Rule | Home | Direction | Role |
| --- | --- | --- | --- |
| `OUT-04-010` | `agent-harness/rules/OUTPUTS.md` | Creation | New artifacts start in `active/` unless a mode defines a different starting location. |
| `OUT-04-020` | `agent-harness/rules/OUTPUTS.md` | Movement | Artifacts move between lifecycle subfolders as status changes, without renaming the file ID. |
| `OUT-05-010` | `agent-harness/rules/OUTPUTS.md` | Improvement-specific | `done/` for an Improvement means the approved changes are applied *and* the validation result is documented — not just a status label. |
| `OUT-07-010` | `agent-harness/rules/OUTPUTS.md` | ADR-specific | ADRs use `proposed/`/`accepted/`/`archive/` instead of the generic pair. |
| `OUT-08-010` | `agent-harness/rules/OUTPUTS.md` | Questions-specific | The Questions registry has no lifecycle subfolders at all — the file a row lives in *is* its status. |
| `COR-01-080` | `agent-harness/rules/CORE/UNIVERSAL.md` | Non-destructive | Artifacts already in `done/`/`archive/` are never retroactively rewritten when conventions change elsewhere. |
| `DEC-04-010`/`DEC-05-010`–`030` | `agent-harness/rules/artifact-specs/ADR.md` | ADR gate | Explicit acceptance is what makes `accepted/` — and therefore citable authority — load-bearing rather than a label. |
| `STT-01-050` | `agent-harness/systems/STATUS-TRANSITIONS.md` | Idea-specific | Closing an Idea is one action: `status: landed`, `next` populated, moved to `archive/`. |
| `STT-01-030` | `agent-harness/systems/STATUS-TRANSITIONS.md` | Plan-specific (own row) | The Readiness Gate is what makes `ready/` load-bearing for a Plan — Implementing may only act on a Plan that actually cleared it, the same weight `ready/` now carries for every other artifact type too. |
| `IMPR-03-040` | `agent-harness/rules/artifact-specs/IMPROVEMENT.md` | Improvement-specific | An Improvement cannot move to `done/` until both the target changes are applied and `## Validation Result` is documented. |
| `TRN-01-030` | `agent-harness/rules/artifact-specs/TRANSCRIPT.md` | Transcript-specific | `archived` Transcripts move to `archive/`, content preserved. |
| `QST-07-010` | `agent-harness/rules/artifact-specs/QUESTIONS.md` | Questions-specific | Resolving/discarding a Question is the row-move itself — there is no separate folder move to perform. |

## Operating Model

Every lifecycle artifact defaults to the same two-folder shape: created in `active/`, moved to `archive/` when
closed, ID stable across the move (`OUT-04-010`/`OUT-04-020`). Several artifact types diverge from that default
because a plain `active/`→`archive/` pair cannot express a load-bearing intermediate state that downstream work
actually depends on. They split into two groups by *why* the divergence needs its own rule.

**Change Spec, Use Case, Spec, Task, and Implementation Plan share one four-folder shape**: `active/` (covers `draft`,
`in-progress`, `blocked` — none of these need their own folder, since nothing downstream depends on
distinguishing them by location), `ready/` (the artifact's own Readiness Checklist/Checks passed — set via
`systems/STATUS-TRANSITIONS.md`'s `STT-01-030` cascade-or-manual-instruction mechanism for UC/Spec/Task, and its
own Plan row — the walk's own root trigger, not a downstream output — for Plan; this is where the next tier, or
Implementing for a Plan, may safely rely on it), `done/` (fully realized — set via `STT-01-020` for all four),
`archive/` (`archived`/`rejected`). The folder name matches the status word exactly at every step; no artifact
type needs its own clarifying rule for this shape anymore — `ready/` carries the same load-bearing weight for
all four, not just Plan.

For a **Change Spec**, `ready/` means its current-content approval and evidence mapping are complete. It is then
the Standard-lane execution contract; `draft`, `in-progress`, and `blocked` stay in `active/`; `done` moves to
`done/`; and `archived` or `rejected` moves to `archive/`, exactly as for Tasks and Specs.

Two artifact types still diverge, for reasons unrelated to the above and each still getting its own rule:

- **ADRs** add `accepted/` between `proposed/` and `archive/`, because "this decision is settled and citable" is
  not the same claim as "this decision exists" — `accepted/` is where an ADR becomes authority other artifacts
  may rely on (see `agent-harness/systems/ADR-AUTHORITY.md`), and that transition requires the explicit
  confirmation gate in `DEC-04-010`, not a folder move on its own.
- **Improvements** keep the generic `active/`→`done/` pair, but `done/` itself carries an extra load-bearing
  condition unique to this artifact type: it means the approved changes are actually applied *and* validated
  (`OUT-05-010`, `IMPR-03-040`) — a status flip with no applied change and no validation record is not a
  completed Improvement, regardless of what the folder holds.

One artifact type diverges the other direction: the **Questions registry** has no lifecycle subfolders at all.
Its three files (`QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, `QUESTIONS-DISCARDED.md`) are not folders holding
many small files — they are the status itself, at row granularity (`OUT-08-010`). Resolving a Question is not
"move a file"; it is "move a row between three files," per `QST-07-010`.

Across every shape, one rule holds absolute: once an artifact reaches `done/`/`archive/`, its content is frozen
against retroactive rewrites even when the harness's own conventions change later (`COR-01-080`). A folder move
records history; it does not get revised to match a newer convention after the fact.

## How To Apply

Before moving an artifact's folder, confirm the underlying gate actually cleared — the folder move documents a
status transition that already happened, it does not itself constitute the transition. For an ADR or
Implementation Plan, that means the acceptance/readiness gate passed first. For an Improvement, that means the
target changes are applied and validated first. Never edit an artifact already sitting in `done/`/`archive/` to
match a newer convention — a later Improvement changing folder or naming conventions applies only going forward.

## Examples

- Any of UC/Spec/Task/Plan's Readiness Checklist passes. The agent moves it `active/`→`ready/` in the same pass
  as setting `status: ready` — the folder move is not a separate, later housekeeping step.
- `UC-0012.md` moves `active/`→`ready/` when its own Readiness Checklist passes and either the Plan-approval
  cascade or an explicit operator instruction sets it `ready`.
- An Improvement's target changes are applied but `## Validation Result` is not yet written. The artifact stays
  in `active/` even though the code changes already landed — `done/` requires both conditions together.
- A Question resolves. The agent deletes its row from `QUESTIONS-OPEN.md` and adds it to
  `QUESTIONS-RESOLVED.md` in the same pass — there is no `QUESTIONS-*` folder to move a file into.

## Reference Files

- `agent-harness/OUTPUTS.md`
- `agent-harness/systems/STATUS-TRANSITIONS.md`
- `agent-harness/artifact-specs/ADR.md`
- `agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`
- `agent-harness/artifact-specs/IMPROVEMENT.md`
- `agent-harness/artifact-specs/QUESTIONS.md`
- `agent-harness/artifact-specs/SPECS.md`
- `agent-harness/artifact-specs/USE-CASES.md`
