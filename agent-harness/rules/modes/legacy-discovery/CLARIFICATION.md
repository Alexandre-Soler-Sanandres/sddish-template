# legacy-discovery / CLARIFICATION Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDG-03-010 | Clarification-Order | MUST clarify open discovery questions after normalization, before moving toward Use Cases, Specs, Tasks, or Implementation Planning. Context sources (not a required order): the unified Questions registry and each source map's deferred question table; `REWRITE-READINESS.md` blockers when they exist; `findings/`, `CONTRACTS.md`, or source-map notes only to understand an existing question. |
| LDG-03-020 | Clarification-Order | SHOULD default to starting with the highest-impact cross-system blocker or question when cross-system synthesis exists and its P0/migration-critical questions dominate the next decision boundary. App-local questions resolve immediately whenever the cross-system decision settles them. |
| LDG-03-021 | Clarification-Order | SHOULD walk app-local questions first only when no cross-system blocker clearly dominates. |
| LDG-03-030 | Clarification-Order | MUST pull in app questions only when they are prerequisites for that answer or are implicitly answered by it. |
| LDG-03-040 | Clarification-Order | MUST update the cross-system artifacts and every affected app artifact in the same pass so traceability stays aligned. |
| LDG-04-010 | Clarification-Per-Question | MUST keep the original question ID stable; merge or cross-reference duplicates and near-duplicates. |
| LDG-04-020 | Clarification-Per-Question | MUST classify each question as `must-decide-before-use-cases`, `must-decide-before-specs`, `must-decide-before-implementation-planning`, `proof-needed`, `accepted-deferred`, or `not-needed`. |
| LDG-04-030 | Clarification-Per-Question | MUST present target-product decisions with concrete options and a recommended proposal. |
| LDG-04-040 | Clarification-Per-Question | MUST preserve evidence paths, finding IDs, proof IDs, and uncertainty notes. |
| LDG-04-050 | Clarification-Per-Question | MUST NOT mark a question resolved until the answer is captured in the right question file and affected restart/readiness notes. |
| LDG-04-060 | Clarification-Per-Question | When marking a question resolved (including "defer to a later iteration" or "decided, proof pending"), MUST move its row per `QUESTIONS.md`'s `QST-07-010`, set `Origin: resolved-from-open` in `Notes`, and move the ID in every cited finding's `Source` from `## Open Questions` to `## Resolved Questions` with the resolution text, same pass. |
| LDG-04-061 | Clarification-Per-Question | A source map's initial baseline-decision capture is exempt from `LDG-04-060`'s `Origin: resolved-from-open` step — it goes directly to `QUESTIONS-RESOLVED.md` with `Origin: baseline` instead (see `QUESTIONS-template.md`). |
| LDG-04-070 | Clarification-Per-Question | MUST enrich the matching reference doc in the same pass when a resolution produces a stable, target-relevant fact (architecture boundary, domain rule, tooling/command, quality standard) — use the routing table in `DISCOVERING-LEGACY.md`'s Reference Enrichment section, or the cross-system `SUMMARY.md`'s Reference Enrichment Routing table. Skip only for purely process/traceability bookkeeping (merging a duplicate ID) with no new stable fact. |
| LDG-04-080 | Clarification-Per-Question | MUST convert questions requiring new source inspection or runtime execution into proof items or follow-up tasks. |
| LDG-04-090 | Clarification-Per-Question | MUST update its row in the unified Questions registry, the linked app finding(s), and any affected source-map notes in the same pass when a cross-system clarification pass resolves an app question indirectly. |
| LDG-04-091 | Clarification-Per-Question | MUST NOT leave any of `LDG-04-090`'s updates waiting for a later reconciliation sweep. |
| LDG-04-100 | Clarification-Per-Question | P0/migration-critical blockers MUST be resolved, deferred, or routed to proof work before Use Case/Spec work begins — this is the blocking gate, not full completion of Question Clarification. |
| LDG-04-110 | Clarification-Per-Question | MUST carry actor-visible uncertainty, workflow-shaping decisions, and behavior-shaping proof obligations into the Use Case, and technical constraints, dependency risks, validation/proof obligations, and any remaining inherited IDs into the Spec, when legacy evidence seeds downstream design work. |
| LDG-04-111 | Clarification-Per-Question | MUST keep the unified Questions registry as the canonical home of parity/proof rows (`CSP-*`), and cite those IDs downstream instead of copying full rows. |
| LDG-04-120 | Clarification-Per-Question | Questions outside the P0/migration-critical gate (`LDG-04-100`) MAY remain Open in the canonical Questions registry until resolved, deferred, or marked `not-needed`; per `CORE.md`'s `COR-01-120`, downstream artifacts reference the ID in their own Open Questions rather than the Question living only in the legacy artifacts. |
