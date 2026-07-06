# CLARIFICATION.md

## Purpose

Question Clarification: the second Post-Discovery Gate. Resolve, defer, discard, or route open questions and
proof needs, unblocking downstream Use Case and Spec work.

Load this file once Artifact Normalization is complete (see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`).

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDG-015 | Clarification-Order | After normalization, clarify open discovery questions before moving toward Use Cases, Specs, Tasks, or Implementation Planning. Context sources (used to gather context, not as a required execution order): the unified Questions registry (app-scoped and cross-system rows both live there now) and each source map's deferred question table; `REWRITE-READINESS.md` blockers when they exist; relevant `findings/`, `CONTRACTS.md`, or source-map notes only to understand an existing question. |
| LDG-016 | Clarification-Order | When cross-system synthesis exists and its P0 or migration-critical questions dominate the next decision boundary, start with the highest-impact cross-system blocker or question first. |
| LDG-017 | Clarification-Order | Pull in app questions only when they are prerequisites for that answer or are implicitly answered by it. |
| LDG-018 | Clarification-Order | Update the cross-system artifacts and every affected app artifact in the same pass so traceability stays aligned. |
| LDG-019 | Clarification-Order | Only when no cross-system blocker clearly dominates should clarification start by walking app-local questions first. Cross-system questions are the default driver whenever they represent the broadest open concerns; app-local questions resolve immediately whenever the cross-system decision settles them. |
| LDG-020 | Clarification-Per-Question | Keep the original question ID stable; merge or cross-reference duplicates and near-duplicates. |
| LDG-021 | Clarification-Per-Question | Classify each question as `must-decide-before-use-cases`, `must-decide-before-specs`, `must-decide-before-implementation-planning`, `proof-needed`, `accepted-deferred`, or `not-needed`. |
| LDG-022 | Clarification-Per-Question | Present target-product decisions with concrete options and a recommended proposal. |
| LDG-023 | Clarification-Per-Question | Preserve evidence paths, finding IDs, proof IDs, and uncertainty notes. |
| LDG-024 | Clarification-Per-Question | Mark resolved only after the answer is captured in the right question file and affected restart/readiness notes. |
| LDG-025 | Clarification-Per-Question | When marking a question resolved — including a resolution whose content is "defer this to a later iteration" or "decided, proof pending" — move its row per the general mechanic in `agent-harness/artifact-specs/QUESTIONS.md`'s `QST-007`, and additionally: set `Origin: resolved-from-open` in `Notes`, and for every finding in its `Source`, move the ID from that finding's `## Open Questions` to `## Resolved Questions` with the resolution text — in the same pass, not a later reconciliation. A source map's initial baseline-decision capture, before any slice work begins, also goes directly to `QUESTIONS-RESOLVED.md` with `Origin: baseline` noted (see `QUESTIONS-template.md`). |
| LDG-026 | Clarification-Per-Question | When a resolution produces a stable, target-relevant fact (architecture boundary, domain rule, tooling/command, quality standard), enrich the matching reference doc in the same pass — use the routing table in `agent-harness/modes/DISCOVERING-LEGACY.md`'s Reference Enrichment section, or the cross-system `SUMMARY.md`'s Reference Enrichment Routing table for cross-system decisions. Skip only for purely process/traceability bookkeeping (e.g. merging a duplicate ID) with no new stable fact. |
| LDG-027 | Clarification-Per-Question | Convert questions requiring new source inspection or runtime execution into proof items or follow-up tasks. |
| LDG-028 | Clarification-Per-Question | When a cross-system clarification pass resolves an app question indirectly, update its row in the unified Questions registry, the linked app finding(s), and any affected source-map notes in the same pass — do not leave anything waiting for a later reconciliation sweep. |
| LDG-029 | Clarification-Per-Question | P0 or migration-critical blockers must be resolved, explicitly accepted as deferred, or routed to proof work before any Use Case or Spec work begins. This defines the blocking gate for downstream work, not the full completion condition for Question Clarification. Once that gate is met, downstream Use Case or Spec work may begin even if non-blocking questions remain open. Those remaining open questions still matter: keep them tracked in the legacy artifacts and continue to either resolve them, defer them, mark them not-needed, convert them to proof work, or intentionally carry them into a downstream artifact's own `Open Questions`. An individual Use Case or Spec is not finished until its own inherited or local open questions are resolved, deferred, marked not-needed, or routed to proof, per that artifact's Readiness Checklist. |
| LDG-030 | Clarification-Per-Question | When legacy evidence seeds downstream design work: carry actor-visible uncertainty, workflow-shaping decisions, and behavior-shaping proof obligations into the Use Case; carry technical constraints, dependency risks, validation/proof obligations, and any remaining inherited IDs into the Spec. Keep the unified Questions registry as the canonical home of parity/proof rows (`CSP-*`), and cite those IDs downstream instead of copying full rows. |
