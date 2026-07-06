# CLARIFICATION.md

## Purpose

Question Clarification: the second Post-Discovery Gate. Resolve, defer, discard, or route open questions and
proof needs, unblocking downstream Use Case and Spec work.

Load this file once Artifact Normalization is complete (see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`).

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDG-03-010 | Clarification-Order | After normalization, clarify open discovery questions before moving toward Use Cases, Specs, Tasks, or Implementation Planning. Context sources (not a required order): the unified Questions registry and each source map's deferred question table; `REWRITE-READINESS.md` blockers when they exist; `findings/`, `CONTRACTS.md`, or source-map notes only to understand an existing question. |
| LDG-03-020 | Clarification-Order | When cross-system synthesis exists and its P0 or migration-critical questions dominate the next decision boundary, start with the highest-impact cross-system blocker or question first; only when no cross-system blocker clearly dominates should clarification start by walking app-local questions first. Cross-system questions are the default driver whenever they represent the broadest open concerns; app-local questions resolve immediately whenever the cross-system decision settles them. |
| LDG-03-030 | Clarification-Order | Pull in app questions only when they are prerequisites for that answer or are implicitly answered by it. |
| LDG-03-040 | Clarification-Order | Update the cross-system artifacts and every affected app artifact in the same pass so traceability stays aligned. |
| LDG-04-010 | Clarification-Per-Question | Keep the original question ID stable; merge or cross-reference duplicates and near-duplicates. |
| LDG-04-020 | Clarification-Per-Question | Classify each question as `must-decide-before-use-cases`, `must-decide-before-specs`, `must-decide-before-implementation-planning`, `proof-needed`, `accepted-deferred`, or `not-needed`. |
| LDG-04-030 | Clarification-Per-Question | Present target-product decisions with concrete options and a recommended proposal. |
| LDG-04-040 | Clarification-Per-Question | Preserve evidence paths, finding IDs, proof IDs, and uncertainty notes. |
| LDG-04-050 | Clarification-Per-Question | Mark resolved only after the answer is captured in the right question file and affected restart/readiness notes. |
| LDG-04-060 | Clarification-Per-Question | When marking a question resolved — including "defer to a later iteration" or "decided, proof pending" — move its row per `QUESTIONS.md`'s `QST-07-010`, and additionally: set `Origin: resolved-from-open` in `Notes`, and move the ID in every cited finding's `Source` from `## Open Questions` to `## Resolved Questions` with the resolution text, same pass. A source map's initial baseline-decision capture goes directly to `QUESTIONS-RESOLVED.md` with `Origin: baseline` instead (see `QUESTIONS-template.md`). |
| LDG-04-070 | Clarification-Per-Question | When a resolution produces a stable, target-relevant fact (architecture boundary, domain rule, tooling/command, quality standard), enrich the matching reference doc in the same pass — use the routing table in `agent-harness/modes/DISCOVERING-LEGACY.md`'s Reference Enrichment section, or the cross-system `SUMMARY.md`'s Reference Enrichment Routing table for cross-system decisions. Skip only for purely process/traceability bookkeeping (e.g. merging a duplicate ID) with no new stable fact. |
| LDG-04-080 | Clarification-Per-Question | Convert questions requiring new source inspection or runtime execution into proof items or follow-up tasks. |
| LDG-04-090 | Clarification-Per-Question | When a cross-system clarification pass resolves an app question indirectly, update its row in the unified Questions registry, the linked app finding(s), and any affected source-map notes in the same pass — do not leave anything waiting for a later reconciliation sweep. |
| LDG-04-100 | Clarification-Per-Question | P0/migration-critical blockers must be resolved, deferred, or routed to proof work before Use Case/Spec work begins — this is the blocking gate, not full completion of Question Clarification. Non-blocking open questions may remain; keep them tracked in the legacy artifacts until resolved, deferred, marked not-needed, or carried into a downstream artifact's own `Open Questions` (per that artifact's Readiness Checklist). |
| LDG-04-110 | Clarification-Per-Question | When legacy evidence seeds downstream design work: carry actor-visible uncertainty, workflow-shaping decisions, and behavior-shaping proof obligations into the Use Case; carry technical constraints, dependency risks, validation/proof obligations, and any remaining inherited IDs into the Spec. Keep the unified Questions registry as the canonical home of parity/proof rows (`CSP-*`), and cite those IDs downstream instead of copying full rows. |
