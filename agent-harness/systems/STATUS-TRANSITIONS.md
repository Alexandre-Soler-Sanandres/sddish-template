# STATUS-TRANSITIONS.md

## Purpose

Explain how status changes compose across the Idea -> Use Case -> Spec -> Task -> Plan chain: which transition
rules exist, which artifact-local gates they invoke, and how the cascade and reconsideration paths fit
together. This is a System file: it models the interaction among rule families. The enforceable `STT-*` rows
live in the paired rules file.

## Rules Map

This System's enforceable rules live in
`agent-harness/rules/systems/STATUS-TRANSITIONS.md` (single paired file — under the 25-rule grouping
threshold). Load it alongside this file whenever status-transition mechanics, routing, or reconsideration are in
scope.

## Transition Vocabulary

`draft | ready | in-progress | blocked | done | archived | rejected` apply to Use Case, Spec, Task, and
Implementation Plan. Idea keeps its own separate vocabulary:
`captured | clarifying | ready-for-refining | landed | archived | rejected`.

`From: any` in the paired rules file means the transition can begin from any current status. The artifact-local
rules decide whether a local gate passes; the `STT-*` rules decide which status change follows from that gate
clearing and which related artifacts the change reaches.

## Participating Rules

| Transition | Paired Rule Home | Artifact-Local Gates It Invokes | Notes |
| --- | --- | --- | --- |
| `STT-01-010` | `agent-harness/rules/systems/STATUS-TRANSITIONS.md` | `UCS-02-030`, `SPS-07-010` | Uses artifact-local significant-change definitions, then fans downward through the derived-artifact chain. |
| `STT-01-020` | `agent-harness/rules/systems/STATUS-TRANSITIONS.md` | `IMPL-03-150` consumes it during execution | Covers execution start/completion for Task and Plan, plus the resulting parent completion cascade. |
| `STT-01-030` | `agent-harness/rules/systems/STATUS-TRANSITIONS.md` | `IPL-02-010`-`012`, `IPL-05-010`/`011`; `TSK-02-010`-`012`, `TSK-06-010`-`040`; `SPS-02-010`-`012`, `SPS-05-011`, `SPS-08-010`-`030`; `UCS-03-010`-`012`, `UCS-05-015`, `UCS-07-010`-`030` | The Plan row is the walk's root trigger; lower tiers are promoted only if their own local gates re-pass fresh. |
| `STT-01-040` | `agent-harness/rules/systems/STATUS-TRANSITIONS.md` | `TSK-02-010`-`012`, `TSK-06-010`-`040`; `SPS-02-010`-`012`, `SPS-05-011`, `SPS-08-010`-`030`; `UCS-03-010`-`012`, `UCS-05-015`, `UCS-07-010`-`030` | Manual promotion path for one named artifact only; unlike `STT-01-030`, it does not require child fan-out. |
| `STT-01-050` | `agent-harness/rules/systems/STATUS-TRANSITIONS.md` | `IDA-03-010` remains the separate confirmation gate for promotion itself | Idea closure happens as part of the same action that lands or merges the Idea into the next artifact. |
| `STT-02-010` / `STT-02-011` | `agent-harness/rules/systems/STATUS-TRANSITIONS.md` | — | Reconsideration runs after the transition rule that directly handled the reopening, reset, or completion change. |

## Operating Model

`STT-01-010` is the downward reset path. It begins only when a Use Case or Spec has already reached the
load-bearing portion of its lifecycle and then receives a significant content change under its own artifact-local
definition. The reset moves downward through derived children and leaves Implementation Plans alone.

`STT-01-020` is the execution path. Implementing uses it when work starts and finishes on Tasks and Plans, and
that completion can then settle the parent Spec or Use Case when every derived child is already `done`.

`STT-01-030` is the Plan-triggered upward walk. The Plan's own readiness and conflict checks open the walk; each
lower artifact is then re-checked through its own local readiness, ADR, and question gates. The transition rule
owns the walk's scope, atomicity, and truncation behavior; the artifact-local rules own the evidence needed to
pass.

`STT-01-040` is the manual promotion path for one named Task, Spec, or Use Case. It uses the same artifact-local
promotion gates as `STT-01-030`, but it does not walk through siblings or ancestors as a precondition.

`STT-01-050` closes Ideas once their content has actually landed in the next artifact or in an amendment to an
existing artifact. It is separate from the confirmation rule that allows the promotion in the first place.

`STT-02-010` and `STT-02-011` are the follow-on path when an artifact later moves off a status one of the
transition rules had previously set. Reconsideration is broader than any one local cascade, because the stale
dependency can point upward or downward in the chain.

## How To Apply

When an artifact changes status, first identify which `STT-*` rule directly governs that change. Then load the
artifact-local gates that transition rule invokes, rather than re-deriving the gate from examples or lifecycle
prose elsewhere. If the artifact is moving off a previously set status, the direct transition rule runs first
and the reconsideration pair is applied afterward for any remaining dependent artifacts.

## Examples

- A significant change lands on a `ready` Spec. `STT-01-010` resets the Spec and its derived Tasks to `draft`.
  Whether the source Use Case now needs attention is handled by the reconsideration pair, not by the reset row
  itself.
- An operator approves a Plan's readiness. `STT-01-030` opens the upward walk, and each included Task, Spec, and
  Use Case is re-checked through its own local gates before any `ready` status is recorded.
- A Task becomes `ready` by explicit instruction. `STT-01-040` uses that Task's own readiness and ADR gates, but
  it does not require sibling Tasks or the parent Spec to be `ready` first.
- A completed Task later reopens because the implementation evidence was wrong. `STT-02-010` then covers whether
  the parent Spec's or Use Case's `done` claim has gone stale.

## Reference Files

- `agent-harness/rules/systems/STATUS-TRANSITIONS.md`
- `agent-harness/rules/CORE/UNIVERSAL.md`
- `agent-harness/rules/modes/IMPLEMENTING.md`
- `agent-harness/rules/artifact-specs/USE-CASES.md`
- `agent-harness/rules/artifact-specs/SPECS.md`
- `agent-harness/rules/artifact-specs/TASKS.md`
- `agent-harness/rules/artifact-specs/IMPLEMENTATION-PLAN.md`
- `agent-harness/rules/artifact-specs/IDEA.md`
