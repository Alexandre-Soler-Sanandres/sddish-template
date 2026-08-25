# CLARIFICATION.md

## Purpose

Question Clarification: the second Post-Discovery Gate. Resolve, defer, discard, or route open questions and
proof needs, unblocking downstream Use Case and Spec work.

## Mode Story

Once Artifact Normalization is complete, the agent walks open discovery questions — usually starting with
whichever cross-system blocker dominates the next decision boundary, or app-local questions when no such
blocker exists — and for each one: classifies it, presents concrete options with a recommendation for
target-product decisions, records the resolution in the right place, enriches reference docs when the resolution
produces a stable fact, and converts anything needing new source inspection into a proof item or follow-up task.

## Operating Posture

P0/migration-critical blockers must be resolved, deferred, or routed to proof work before Use Case/Spec work
begins — that is the blocking gate, not full completion of Question Clarification (`LDG-04-100`). Everything else
may stay open in the canonical Questions registry until later, tracked by ID from downstream artifacts rather
than needing this gate to close first (`LDG-04-120`).

## When To Use

Load this file once Artifact Normalization is complete — see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`.

## Workflow Paths

Context sources for clarification (not a required order): the unified Questions registry and each source map's
deferred question table; `REWRITE-READINESS.md` blockers when they exist; `findings/`, `CONTRACTS.md`, or
source-map notes only to understand an existing question (`LDG-03-010`).

## Core Moves

1. Default to starting with the highest-impact cross-system blocker or question when cross-system synthesis
   exists and its P0/migration-critical questions dominate the next decision boundary — app-local questions
   resolve immediately whenever the cross-system decision settles them (`LDG-03-020`). Otherwise walk app-local
   questions first (`LDG-03-021`).
2. Pull in app questions only when they are prerequisites for the current answer or are implicitly answered by
   it (`LDG-03-030`).
3. Keep the original question ID stable; merge or cross-reference duplicates and near-duplicates (`LDG-04-010`).
4. Classify each question as `must-decide-before-use-cases`, `must-decide-before-specs`,
   `must-decide-before-implementation-planning`, `proof-needed`, `accepted-deferred`, or `not-needed`
   (`LDG-04-020`).
5. Present target-product decisions with concrete options and a recommended proposal (`LDG-04-030`), preserving
   evidence paths, finding IDs, proof IDs, and uncertainty notes (`LDG-04-040`).
6. When marking a question resolved (including "defer to a later iteration" or "decided, proof pending"), move
   its row per `QUESTIONS.md`'s `QST-07-010`, set `Origin: resolved-from-open` in `Notes`, and move the ID in
   every cited finding's `Source` from `## Open Questions` to `## Resolved Questions` with the resolution text,
   same pass (`LDG-04-060`). A source map's initial baseline-decision capture is exempt from this
   `Origin: resolved-from-open` step — it goes directly to `QUESTIONS-RESOLVED.md` with `Origin: baseline`
   instead (`LDG-04-061`). Never mark a question resolved until the answer is captured in the right question
   file and affected restart/readiness notes (`LDG-04-050`).
7. Enrich the matching reference doc in the same pass when a resolution produces a stable, target-relevant fact —
   use the routing table in `DISCOVERING-LEGACY.md`'s Reference Enrichment section, or the cross-system
   `SUMMARY.md`'s Reference Enrichment Routing table. Skip only for purely process/traceability bookkeeping
   (merging a duplicate ID) with no new stable fact (`LDG-04-070`).
8. Convert questions requiring new source inspection or runtime execution into proof items or follow-up tasks
   (`LDG-04-080`).
9. Update the cross-system artifacts and every affected app artifact in the same pass so traceability stays
   aligned (`LDG-03-040`) — including, when a cross-system clarification pass resolves an app question
   indirectly, the unified Questions registry, the linked app finding(s), and any affected source-map notes, all
   in the same pass, never deferred to a later reconciliation sweep (`LDG-04-090`/`LDG-04-091`).

## Routing

Carry actor-visible uncertainty, workflow-shaping decisions, and behavior-shaping proof obligations into the Use
Case, and technical constraints, dependency risks, validation/proof obligations, and any remaining inherited IDs
into the Spec, when legacy evidence seeds downstream design work (`LDG-04-110`). Keep the unified Questions
registry as the canonical home of parity/proof rows (`CSP-*`), and cite those IDs downstream instead of copying
full rows (`LDG-04-111`).

## Outputs

Updated rows in the unified Questions registry (moved between `QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, and
`QUESTIONS-DISCARDED.md`), updated app/cross-system artifacts, and reference-doc enrichment where a resolution
produced a stable fact.

## Examples

A `CSQ-*` row asks whether the target system should preserve a legacy retry policy. The agent presents "preserve
as-is" vs. "adopt exponential backoff" with a recommendation, the user decides, the agent moves the row to
`QUESTIONS-RESOLVED.md` with the resolution text, updates every finding that cited it, and enriches `QUALITY.md`
with the settled retry policy.

## Rules Map

This submode's enforceable rules live in `agent-harness/rules/modes/legacy-discovery/CLARIFICATION.md` (single
paired file — under the 25-rule grouping threshold). Load it alongside this file whenever Question Clarification
is the active phase.

## Reference Files

Load per `agent-harness/modes/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
