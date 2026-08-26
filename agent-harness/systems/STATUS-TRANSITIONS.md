# STATUS-TRANSITIONS.md

## Purpose

The source of truth for how status changes across the Idea -> Use Case -> Spec -> Task -> Plan chain: which
artifact moves to which status, what triggers it, and what condition must hold. Every transition table below is
enforceable — this file is not an index of pointers to other rules; it is the rules table itself.

## Transition Tables

`Artifact | From | Trigger | To | Condition`. `From: any` means the transition applies regardless of current
status. Vocabulary: `draft | ready | in-progress | blocked | done | archived | rejected` for Use Case, Spec,
Task, and Implementation Plan; Idea keeps its own separate vocabulary (`captured | clarifying | ready-for-refining
| landed | archived | rejected`) throughout.

### `STT-01-010` — Downward-reset

| Artifact | From | Trigger | To | Condition |
| --- | --- | --- | --- | --- |
| Use Case or Spec | `ready` or later | a significant change lands on it | `draft` | every child artifact derived from it (a Spec's `source` citing this UC; a Task's `derived_tasks` membership under this Spec) also resets, recursively — this row fires again for each; Implementation Plans are never reset directly by this row |

After firing: MUST stop and wait for user instruction before further action.

### `STT-01-020` — Completion

| Artifact | From | Trigger | To | Condition |
| --- | --- | --- | --- | --- |
| Task or Plan | any | Implementing starts the work | `in-progress` | — |
| Task or Plan | `in-progress` | Implementing completes the work | `done` | — |
| Spec or Use Case | any | (chained from the row above) | `done` | every child derived from it (a Spec's Tasks; a UC's Specs) is `done` |

### `STT-01-030` — Upward, approval-triggered cascade

| Artifact | From | Trigger | To | Condition |
| --- | --- | --- | --- | --- |
| Plan | any | operator explicitly confirms this Plan's Readiness Checks pass (human-only, `COR-01-090` — this is the walk's own root trigger, not a downstream output of it) | `ready` | this Plan's own Readiness Checks (`IPL-02-010`/`011`/`012`) pass; the walk below succeeds |
| Task, Spec, or Use Case | any | (chained from the Plan row above — the walk this Plan's promotion triggers) | `ready` | this artifact's own Readiness Checklist re-verified fresh against current content; AND, if it has children in the funnel (a Spec's Tasks, a UC's Specs — not applicable to Task), every one of those children is already `ready` too |

All-or-nothing: any artifact's condition failing halts the whole walk — no status changes anywhere in the chain,
including the Plan row itself. Walk stops at Use Case; never reaches Idea. A Risk-Tier skip-path entry truncates
the walk at the point the chain actually ends: a Task with no Spec (Spec-skip path) is promoted and the walk
stops there; a Spec with no Use Case (UC-skip path) is promoted and the walk stops there; a Plan with no Task at
all (`entrypoint_type: none`, Plan-tier skip) has nothing to promote below the Plan row and trivially succeeds.
Setting these statuses is not itself a "significant change" for `STT-01-010`'s purposes — promoting an artifact
via this cascade MUST NOT itself re-trigger a downward-reset cascade on the artifact just promoted. Independent
of `STT-01-020` (different trigger — approval vs. completion — even though both target `ready`/`done`, this row
is pre-implementation, `STT-01-020` is post-implementation; both remain in force independently).

### `STT-01-040` — Manual instruction

| Artifact | From | Trigger | To | Condition |
| --- | --- | --- | --- | --- |
| Task, Spec, or Use Case | any | explicit operator instruction naming this specific artifact | `ready` | this artifact's own Readiness Checklist passes — fan-out (children already `ready`) is NOT required on this path, unlike `STT-01-030` |

`STT-01-030` and `STT-01-040` are the only two paths to `ready` for these three artifact types — no other path is
permitted, and neither may be inferred from discussion (`COR-01-090`). Plan has no equivalent manual-instruction
row: it IS the manual gate `STT-01-030`'s Plan row already describes, not a downstream artifact with an
alternative path.

### `STT-01-050` — Idea closure

| Artifact | From | Trigger | To | Condition |
| --- | --- | --- | --- | --- |
| Idea | any | a next-tier artifact is created from it (Use Case, or Risk-Tier skip-path Spec/Task/Plan), or its content is incorporated as an in-place amendment to an already-existing Use Case/Spec | `landed` (archived) | populate `next` with the citing artifact's ID |

Does not wait for the citing artifact's own `done` status. This is the one row where the artifact type is not a
variable, because nothing else in the chain shares Idea's shape.

### `STT-02-010` / `STT-02-011` — Reconsideration

`STT-02-010`: Whenever an artifact in the Idea -> Use Case -> Spec -> Task -> Plan chain moves off a status that
one of `STT-01-010`-`050` set, for a reason other than another `STT-01-*` row already having set it again, MUST
reconsider every other artifact in the chain — in either direction — whose own status depended on that fact.

`STT-02-011`: MUST report the `STT-02-010` reconsideration outcome explicitly — "no change needed" is a valid
outcome, but it MUST be stated, not left unexamined by default.

## How To Apply

When a Use Case, Spec, Task, or Plan moves off a status, identify which table row set the status it's leaving.
Apply that row's own logic first (e.g. `STT-01-010`'s cascade for a reopened Spec). Then use `STT-02-010` for any
remaining chain member whose status may still depend on the artifact that just changed — this covers directions
the local table row doesn't already handle (for example, an upstream Use Case's status depending on a downstream
Spec that just reopened).

Do not infer that every related artifact must change status. The required action is reconsideration, not
automatic reset. A recorded "no change needed" outcome satisfies `STT-02-011` when the evidence supports it.

## Examples

- A significant change lands on a `ready` Spec. `STT-01-010` fires: the Spec resets to `draft`, every Task
  derived from it also resets to `draft`. The Spec's own source Use Case is not touched by this row directly —
  `STT-02-010` covers whether it needs reconsidering.
- An operator confirms a Plan's Readiness Checks pass. `STT-01-030` walks upward: each included Task's Readiness
  Checklist is re-verified and, if it passes, the Task becomes `ready`; each such Task's Spec is checked the same
  way once every Task derived from it is `ready`; that Spec's Use Case is checked once every Spec derived from it
  is `ready`. Any failure anywhere halts the whole walk with no status changes.
- `UC-0012.md` moves `active/`→`ready/` when its own Readiness Checklist passes and either the Plan-approval
  cascade (`STT-01-030`) or an explicit operator instruction (`STT-01-040`) sets it `ready`.
- A Task marked `done` through Plan completion reopens because implementation evidence was wrong. `STT-02-010`
  requires reconsidering the source Spec's `done` status — it may now be stale, since it depended on that Task's
  completion.

## Reference Files

- `agent-harness/rules/CORE/UNIVERSAL.md`
- `agent-harness/rules/modes/IMPLEMENTING.md`
- `agent-harness/rules/artifact-specs/USE-CASES.md`
- `agent-harness/rules/artifact-specs/SPECS.md`
- `agent-harness/rules/artifact-specs/TASKS.md`
- `agent-harness/rules/artifact-specs/IMPLEMENTATION-PLAN.md`
- `agent-harness/rules/artifact-specs/IDEA.md`
