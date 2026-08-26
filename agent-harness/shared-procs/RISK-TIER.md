# RISK-TIER.md

## Purpose

The risk-tier cascade decides the minimum artifact tier a request actually needs — Use Case, Spec, Task, or none
of those (Plan-tier only) — before Refining or Planning-Implementation produces anything. It extends the same
risk-scaling pattern this harness already applies to Task-necessity (previously `REFINING.md`'s local Task
Decision Matrix, now `RSK-04-010` below) one level further up, to Use-Case-necessity and Spec-necessity. It is a
shared procedure, not a mode: invoked by name from `PARTNERING.md`, `REFINING.md`, and
`PLANNING-IMPLEMENTATION.md`, mirroring how `VALIDATION.md` is invoked from `IMPLEMENTING.md` and
`IMPROVING-HARNESS.md`. It is reusable, but not optional support material — its outcome changes whether the agent
creates a Use Case, Spec, Task, or direct Plan-tier Implementation Plan.

## Invoked By

- `agent-harness/modes/PARTNERING.md` (`PTN-02-110`) — at the first hand-off out of Partnering.
- `agent-harness/modes/REFINING.md` (`UCS-01-050`, `SPS-01-040`, `TSK-01-030`) — at each Refining entry point, in
  case a request enters mid-funnel rather than via Partnering.
- `agent-harness/modes/PLANNING-IMPLEMENTATION.md` (`IPL-08-010`) — when entered by a direct natural-language
  instruction naming no Use Case/Spec/Task file.

## Procedure

Necessity at every tier is judged by two axes — (a) is the change hard or impossible to reverse, and (b) does it
cross an actor/scenario, architectural/contract, or team/service boundary that someone else needs visibility
into (`RSK-01-010`). Classification must never be based on effort, agent convenience, or time pressure alone
(`RSK-01-020`). An ambiguous or unclear-scope situation defaults to the higher tier, not skipped on uncertainty
(`RSK-06-010`).

Run the cascade in order, stopping only once a tier is confirmed required:

1. **UC-Necessity** (`RSK-02-010`) — governs whether a Use Case is required before a Spec/Task/Plan may proceed.

   | Situation | UC required? | Reason |
   | --- | --- | --- |
   | New actor-facing capability or scenario, no existing UC covers it | Yes | New goal/actor framing needed |
   | Cross-cutting change spanning multiple existing Specs/components | Yes | Needs outcome-level framing tying the pieces together |
   | Change alters an existing capability's user-visible behavior or outcome | Yes | The scenario itself changed, must be recaptured |
   | Technical-only change, no new or changed actor-facing scenario | No | No scenario framing to add |
   | Fully scoped within one already-described UC's existing scenario | No | Existing UC still holds — proceed to Spec-Necessity |

2. **Spec-Necessity** (`RSK-03-010`, only if UC not required) — governs whether a Spec is required before
   Tasks/Plan.

   | Situation | Spec required? | Reason |
   | --- | --- | --- |
   | New architectural concept, structural boundary, or cross-team/service dependency | Yes | Architecturally significant, hard to reverse |
   | Meaningful trade-offs or multiple viable approaches exist | Yes | Needs a recorded rationale |
   | Changes a public/contract-facing behavior (API, schema, data contract) | Yes | Downstream consumers depend on it |
   | Requirements/acceptance criteria aren't already obvious from the request | Yes | Needs explicit framing before Tasks make sense |
   | Clear, single, mechanical way to do it — no real alternative, no contract change | No | Nothing to record a rationale about |
   | Routine maintenance / dependency bump / packaging change, no behavior change | No | Trivial, mechanical |

3. **Task-Necessity** (`RSK-04-010`, only if Spec not required) — governs whether Tasks are required before a
   Plan (moved here verbatim from `REFINING.md`'s former local Task Decision Matrix; content unchanged).

   | Situation | Tasks required? | Reason |
   | --- | --- | --- |
   | Small documentation-only change | No | Inline plan is sufficient |
   | Small isolated config change | Optional | Use inline plan if validation is clear |
   | Small bugfix in one module | Optional | Use inline plan if scope is clear |
   | Multiple files or modules | Yes | Reviewability and traceability |
   | Multiple implementation steps | Yes | Ordering and validation boundaries |
   | Cross-cutting change | Yes | Scope control |
   | Unclear dependencies | Yes | Dependency management |
   | Use Case with multiple Specs | Yes | Too broad for inline planning |
   | Spec with multiple features | Yes | Needs execution slices |
   | Database migration | Yes | High risk |
   | Destructive data job | Yes | High risk |
   | Deployment or infrastructure change | Yes | Operational risk |
   | CI/CD workflow setup | Yes | Operational risk |
   | Local development execution path | Yes | Operational risk |
   | API contract publication or change | Yes | Operational risk |
   | Security, secrets or auth | Yes | Safety-critical |
   | Payment or financial transaction execution | Yes | Safety-critical |
   | Domain-critical business logic | Yes | Domain-critical |
   | Major architecture change | Yes | Requires reviewable slices |

Regardless of matrix outcome, these categories must never go below Spec tier: database migration, destructive
data job, deployment/infrastructure change, CI/CD workflow setup, API contract publication/change,
security/secrets/auth, payment/financial transaction execution, domain-critical business logic, major
architecture change (`RSK-06-020`).

**Recording a skip:** whenever a tier is skipped, the resulting artifact — or the Implementation Plan itself, if
no artifact is produced — must include a `## Risk-Tier Classification` section naming the matching matrix row
and reasoning. When classification happens before any resulting artifact exists yet (at Partnering's hand-off,
before the Idea is promoted), the source Idea holds it instead, until something actually results. Omission is a
process violation, not a valid shortcut (`RSK-05-010`).

**Run-once discipline:** the cascade runs at most once per request, at the first opportunity it's reached —
Partnering's hand-off, Refining's entry, or Planning-Implementation's entry, whichever comes first. The result is
carried forward, not recomputed: a skip is recorded via the `## Risk-Tier Classification` section above; a
non-skip (full tier required) is evidenced by the artifact's own normal chain (an accepted Use Case behind an
ready Spec behind a `ready` Task is itself proof the classification already happened) (`RSK-07-010`). Every
consuming mode checks for an existing classification — on the named artifact, or on its cited source
Idea/Transcript — before running it fresh, and never recomputes one that already exists unless the user
explicitly asks for re-evaluation (`RSK-07-011`/`RSK-07-012`). This run-once rule applies per-matrix, not only to
the cascade as a whole: if an earlier stage already ran UC-Necessity or Spec-Necessity and recorded a partial
result, a later stage picking up the same request reuses that partial result and continues from the next unrun
matrix, not a restart (`RSK-07-013`).

**Full-cascade completion:** a consuming mode file determining whether a request needs an upstream artifact at
all must run the cascade through Task-Necessity before concluding no artifact above Plan-tier is required
(`RSK-07-020`) — never stop after UC-Necessity or Spec-Necessity alone and default into creating a Spec or Task
on that basis; a Spec-Necessity "No" is not itself a reason to create a Task, exactly as a UC-Necessity "No" is
not itself a reason to create a Spec without first checking Spec-Necessity (`RSK-07-021`). A request may be
concluded as landing on Plan-tier directly only once Task-Necessity is also checked, fresh or carried forward
(`RSK-07-022`).

## Examples

A request comes in via Partnering to "fix a typo in the README." UC-Necessity: No (technical-only, no actor
scenario). Spec-Necessity: No (trivial, mechanical). Task-Necessity: No (small documentation-only change). The
cascade completes through all three matrices and lands on Plan-tier — the agent records the classification and
routes to Planning-Implementation's natural-language entry, never stopping early after just the first "No."

## Rules Map

This procedure's enforceable rules live in `agent-harness/rules/shared-procs/RISK-TIER.md` (single paired file —
under the 25-rule grouping threshold). Load it alongside this file whenever running the risk-tier cascade.

## Reference Files

None beyond the modes that invoke this procedure — see each consuming mode's own Reference Files for the context
needs of the surrounding work.
