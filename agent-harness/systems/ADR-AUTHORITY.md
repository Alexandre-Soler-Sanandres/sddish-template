# ADR-AUTHORITY.md

## Purpose

Explain how an ADR becomes citable authority, how Use Cases/Specs/Tasks depend on and re-check that authority
over time, and how a decision changes after acceptance without ever being edited in place.

This is a System file: it explains how multiple rules and artifacts interact. It is not a Rules table. The
enforceable obligations remain in the rule files that define the participating rule IDs.

## Participating Rules

| Rule | Home | Direction | Role |
| --- | --- | --- | --- |
| `DEC-01-010` | `agent-harness/rules/artifact-specs/ADR.md` | Authorship | Any mode may draft a candidate ADR the moment it recognizes a settled decision. |
| `DEC-04-010` | `agent-harness/rules/artifact-specs/ADR.md` | Acceptance | Only explicit user confirmation moves an ADR to `accepted` — never inferred. |
| `DEC-05-010`–`030` | `agent-harness/rules/artifact-specs/ADR.md` | Citation gate | Only `accepted` ADRs are settled authority; `proposed` is pending context only. |
| `DEC-14-010` | `agent-harness/rules/artifact-specs/ADR.md` | Scope | `fleet-wide` (always relevant) vs. `scoped` (relevance judged per artifact) — decides whether reverse-link bookkeeping applies. |
| `DEC-07-010`–`012` | `agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` | Reverse links | Use Case/Spec/Task record dependence on a `scoped` ADR, and the ADR records the dependents back. |
| `DEC-06-010` | `agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` | Immutability | `Decision`/`Consequences` never change in place once `accepted` — a change of mind creates a new superseding ADR. |
| `DEC-09-010` | `agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` | Relations | Every `related` ID needs an explicit relationship-type note. |
| `DEC-10-010` | `agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` | Supersession timing | A superseding ADR's `supersedes` link only sets once it itself becomes `accepted`. |
| `DEC-08-010` | `agent-harness/rules/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` | Reference sync | A superseded ADR's citations in `harness-data/reference/*.md` update to the superseding ADR. |
| `UCS-07-010`–`030` | `agent-harness/rules/artifact-specs/USE-CASES.md` | Re-check (readiness) | Missed-ADR, content-drift, and compliance rechecks before `ready-for-spec`. |
| `SPS-08-010`–`030` | `agent-harness/rules/artifact-specs/SPECS.md` | Re-check (readiness) | Same three rechecks before `approved`. |
| `TSK-06-010`–`040` | `agent-harness/rules/artifact-specs/TASKS.md` | Re-check (readiness) | Same three rechecks (plus a health/readiness-check ADR check) before `ready`. |

## Operating Model

Authorship is deliberately wide open — any mode may draft a `proposed` ADR the instant it recognizes a settled
structural decision (`DEC-01-010`), because real-world architectural decisions surface incidentally everywhere,
not only in a dedicated ADR-writing session. What stays narrow is acceptance: an ADR only becomes citable
authority once the user explicitly confirms it (`DEC-04-010`), and until then it is noted only as pending context,
never treated as settled (`DEC-05-010`–`030`).

Once `accepted`, an ADR's `scope` decides how its authority propagates. A `fleet-wide` ADR applies everywhere by
declaration — no artifact needs to record a dependency on it, and none needs to reverse-link back (`DEC-14-010`,
`DEC-07-011`). A `scoped` ADR's authority is narrower and must be actively wired: when a Use Case, Spec, or Task
depends on it, that dependency is recorded on both sides in the same pass — the dependent artifact's `related`
field, and the ADR's own `derived_use_cases`/`derived_specs`/`derived_tasks` field (`DEC-07-010`–`012`). This
two-way link is what lets `ADR-AUTHORITY.md`'s re-check discipline work: an agent can walk from either side.

Because content drifts during drafting and the accepted-ADR list itself changes over time, every downstream
artifact re-verifies its ADR relevance at its own readiness gate, not only at creation time — three checks, run
identically at each layer: a missed-ADR recheck against the *current* accepted list, a content-drift recheck
against the artifact's *actual* current content (not its original `area`), and a compliance check that every
cited ADR is actually reflected in the artifact's substance (`UCS-07-010`–`030`, `SPS-08-010`–`030`,
`TSK-06-010`–`040`). This is why an ADR accepted after a Use Case was drafted can still surface at Spec or Task
readiness — the chain keeps re-checking, it doesn't trust the earliest load.

Once accepted, a decision is immutable in place — reversing it never means editing `Decision`/`Consequences`; it
means drafting a new ADR that supersedes the old one, with both artifacts' `supersedes`/`superseded_by` fields
updated together (`DEC-06-010`). A superseding ADR that is itself still `proposed` cannot yet claim `supersedes`
— that link only forms once the superseding ADR itself becomes `accepted`, recorded as a `related`
`supersession-deferred` note until then (`DEC-10-010`). Every other `related` ID carries its own explicit
relationship-type note, since `related` alone leaves the relationship implicit (`DEC-09-010`). When a reference
doc's own `## Decisions` entry cited the now-superseded ADR, that citation updates to the superseding ADR in the
same pass (`DEC-08-010`) — reference docs never point at stale authority.

## How To Apply

Before citing an ADR as settled authority anywhere, check its `status` — only `accepted` counts. Before setting a
Use Case, Spec, or Task to its readiness-gate status, run all three ADR rechecks fresh against the *current*
accepted list and the artifact's *actual* content, even if ADRs were already checked at creation time. When
reversing a settled decision, never edit the original ADR — draft a superseding one and wire both sides' fields
together only once the new ADR is itself `accepted`.

## Examples

- A `scoped` ADR about a caching layer is accepted after a Spec was drafted. At the Spec's next readiness check,
  the missed-ADR recheck surfaces it as newly relevant; the agent adds it to `related` and verifies the Spec's
  requirements actually reflect it before approving.
- A team decides to reverse an accepted database-choice ADR. The agent drafts a new `proposed` ADR that will
  supersede it, records the relationship as `related`/`supersession-deferred` in both directions, and only sets
  `supersedes`/`superseded_by` once the new ADR itself reaches `accepted`.

## Reference Files

- `agent-harness/artifact-specs/ADR.md`
- `agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md`
- `agent-harness/artifact-specs/USE-CASES.md`
- `agent-harness/artifact-specs/SPECS.md`
- `agent-harness/artifact-specs/TASKS.md`
