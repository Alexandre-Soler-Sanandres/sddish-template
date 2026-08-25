# STATUS-CASCADE.md

## Purpose

Explain how status changes propagate across the Idea -> Use Case -> Spec -> Task -> Plan chain when completion or
reopening could make another artifact's status stale.

This is a System file: it explains how multiple rules and artifacts interact. It is not a Rules table. The
enforceable obligations remain in the rule files that define the participating rule IDs.

## Participating Rules

| Rule | Home | Direction | Role |
| --- | --- | --- | --- |
| `COR-01-130` | `agent-harness/rules/CORE/UNIVERSAL.md` | Cross-chain reconsideration | Reconsiders other artifacts in the Use Case -> Spec -> Task -> Plan chain when one artifact moves off a terminal status for a reason other than the completion cascade itself. |
| `COR-01-131` | `agent-harness/rules/CORE/UNIVERSAL.md` | Cross-chain reporting | Requires the reconsideration outcome to be reported explicitly. |
| `UCS-02-040` | `agent-harness/artifact-specs/USE-CASES.md` | Downward reset | Handles Use Case reopening effects on downstream Specs and their descendants. |
| `SPS-07-020` | `agent-harness/artifact-specs/SPECS.md` | Downward reset | Handles Spec reopening effects on downstream Tasks and Plans. |
| `TSK-02-020` | `agent-harness/artifact-specs/TASKS.md` | Reopening trigger | Handles Task reopening effects on downstream Plans and related completion claims. |
| `IPL-05-080` | `agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md` | Completion cascade | Handles Plan completion effects that can move a Spec to `implemented` when every Task derived from it is `done`. |
| `IPL-05-081` | `agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md` | Completion cascade | Handles completion effects that can move a Use Case to `implemented` when every Spec derived from it is `implemented`. |
| `IPL-05-082` | `agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md` | Reopening trigger | Connects Plan or Task reopening after the completion cascade back to `COR-01-130` reconsideration. |

## Operating Model

The cascade has two different forces:

- Completion moves forward or upward from implementation work: when an approved Plan is completed, the Plan can
  mark included Tasks done and may complete the related Spec or Use Case when their own cascade gates are
  satisfied.
- Reopening moves in the opposite direction: when any artifact leaves a terminal status, other artifacts that
  became terminal because of the old state may now be stale and need explicit reconsideration.

`UCS-02-040`, `SPS-07-020`, and `TSK-02-020` own the artifact-local downward reset cases. `COR-01-130` covers the
cross-chain symmetry that is not already fully handled by those local rules, especially upward or sibling effects
from a downstream-originated reopening. `COR-01-131` makes the reconsideration visible even when the answer is
"no change needed."

## How To Apply

When a Use Case, Spec, Task, or Plan moves off a terminal status, identify how it reached that terminal status.
If the terminal status came from the completion cascade, check the other artifacts in the chain for stale
terminal claims. Apply the local artifact rule first when it directly covers the direction of travel, then use
`COR-01-130` for any remaining chain member whose status may still depend on the reopened artifact.

Do not infer that every related artifact must change status. The required action is reconsideration, not automatic
reset. A recorded "no change needed" outcome satisfies `COR-01-131` when the evidence supports it.

## Examples

- A completed Plan reopens because validation failed after completion. Reconsider included Tasks and any Spec or
  Use Case that reached terminal status through that Plan's completion.
- A Spec marked done through completed Tasks reopens because its scope changed. Apply the Spec's own downstream
  reset rule, then check whether related Plan or Use Case status claims are now stale.
- A Task marked done through Plan completion reopens because implementation evidence was wrong. Apply the Task
  reopening rule for downstream planning effects and use `COR-01-130` for any upstream terminal status claim that
  depended on that Task being done.

## Reference Files

- `agent-harness/rules/CORE/UNIVERSAL.md`
- `agent-harness/artifact-specs/USE-CASES.md`
- `agent-harness/artifact-specs/SPECS.md`
- `agent-harness/artifact-specs/TASKS.md`
- `agent-harness/artifact-specs/IMPLEMENTATION-PLAN.md`
