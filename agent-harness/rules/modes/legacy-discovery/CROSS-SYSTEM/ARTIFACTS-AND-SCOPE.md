# CROSS-SYSTEM / Artifacts-and-Scope Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDC-01-010 | Cross-System-Artifacts | MUST start cross-system synthesis by creating `harness-data/artifacts/legacy/cross-system/SUMMARY.md` from `agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working plan: it names the active synthesis scope, entry criteria, slice order, artifact routing, and next action. |
| LDC-01-015 | Cross-System-Artifacts | At creation time (LDC-01-010), SUMMARY.md MUST have active_synthesis_scope and the Entry Criteria table filled in for every in-scope app, and a "Slice 0: Cross-system plan and scope setup" row present in the Working Discovery Plan with status done or next. This is a minimum-at-creation floor, distinct from LDC-01-020's ceiling on speculative placeholder content once synthesis is underway. |
| LDC-01-018 | Cross-System-Artifacts | MUST NOT copy generic slice, block, roundtrip, or closeout-checklist process policy from `CROSS-SYSTEM.md` into `SUMMARY.md`. |
| LDC-01-020 | Cross-System-Artifacts | MUST NOT create `CONTRACTS.md`, `findings/` entries, Questions-registry rows (`CSQ-*`/`CSP-*`), or `REWRITE-READINESS.md` speculatively as empty placeholders — create them only when a slice produces evidence that needs them, and cite app-scoped artifacts and source evidence instead of copying app-local detail. |
| LDC-01-030 | Cross-System-Artifacts | Cross-system artifacts are connected, not independent: findings SHOULD feed `CONTRACTS.md`, the Questions registry, and `REWRITE-READINESS.md` by citation. |
| LDC-01-031 | Cross-System-Artifacts | Parity rows and readiness blockers SHOULD point back to the finding IDs and proof/question IDs they depend on. |
| LDC-01-040 | Cross-System-Artifacts | MUST use the proof/parity IDs (`CSP-*`) defined in the Questions registry as the canonical IDs. |
| LDC-01-050 | Cross-System-Artifacts | MUST continue new discovery in the scoped structure unless an explicit Improvement or cleanup task migrates the older flat files under `harness-data/artifacts/legacy/` (legacy layout debt). |
| LDC-01-060 | Cross-System-Artifacts | `REWRITE-READINESS.md` SHOULD reference those existing proof IDs directly instead of inventing a second blocker-ID namespace. |
| LDC-02-010 | Cross-System-Synthesis | MUST NOT start cross-system synthesis until every app in the active synthesis scope is `app-local-complete`. |
| LDC-02-011 | Cross-System-Synthesis | MUST NOT infer the active synthesis scope — it must be stated explicitly. |
| LDC-02-020 | Cross-System-Synthesis | MUST NOT use cross-system artifacts unless a finding, question, contract, proof need, or readiness judgment requires more than one app; route stable target-relevant findings to reference docs and leave legacy drift in legacy artifacts. |
| LDC-02-030 | Cross-System-Synthesis | MUST NOT flatten app-local evidence into cross-system narrative summaries when an app finding or source-map citation is enough. Cross-system synthesis is a second layer over app-local discovery: app-scoped artifacts keep local evidence close to the source app; cross-system findings synthesize boundary claims from multiple app artifacts; cross-system questions, parity rows, and readiness blockers trace back to those synthesized findings. |
| LDC-02-035 | Cross-System-Synthesis | `SUMMARY.md`'s `discovery_state` MUST be `cross-system-active` while synthesis is in progress. This is the `SUMMARY.md`-scoped counterpart to `DISCOVERING-LEGACY.md`'s Discovery Lifecycle table, which scopes `discovery_state` to app source maps only. |
| LDC-02-036 | Cross-System-Synthesis | `discovery_state` MAY move to `cross-system-complete` only when every planned cross-system slice is `done`, `not-needed`, or explicitly deferred, and the Restart Pointer names the next non-discovery phase. |
| LDC-02-040 | Cross-System-Synthesis | MUST complete reference enrichment for all stable cross-system findings, per `DISCOVERING-LEGACY.md`'s Reference Enrichment table, before `SUMMARY.md`'s `discovery_state` moves to `cross-system-complete` (`LDC-02-036`). |
