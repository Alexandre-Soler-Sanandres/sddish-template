# DISCOVERING-LEGACY / Questions Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-04-010 | Questions | MUST use `Q-<APP>-NNN` (app-scoped) or `CSQ-NNN` (cross-system) IDs for Legacy Discovery questions (they live in the harness-level Questions registry — `QUESTIONS-OPEN`/`RESOLVED`/`DISCARDED.md`, schema in `agent-harness/artifact-specs/QUESTIONS.md` — not per-app files, and not organized by discovery slice, subsystem, or process block), fold `Decision type` (`scope-v1` \| `preserve-vs-adapt` \| `fidelity` \| `naming` \| `deferred-feature`) into `Notes`, and follow the registry's own classification (`QST-01-010`) and status (`QST-03-010`) rules. |
| LD-04-020 | Questions | MUST check existing registry rows for the same decision by content and merge instead of duplicating, before adding a question. |
| LD-04-030 | Questions | MUST link every question back to the finding(s) that raised it through the registry's `Source` column. |
| LD-04-040 | Questions | SHOULD default cross-system questions' `Source` to `LF-CROSS-NNN`, adding app finding IDs in `Notes` only when the extra traceability matters; provenance like slice name or artifact of origin belongs in `Notes`, not the table structure. |
| LD-04-050 | Questions | MUST emit a Question when a finding establishes concrete visible behavior — including silent failure, degraded visibility, startup/config error handling, warning/notification behavior, or comparable consumer-visible runtime behavior — and the target preserve/adapt policy remains unresolved. |
| LD-04-060 | Questions | MUST treat unresolved release-scope, configurability, deployment/runtime policy, quality/acceptance-surface, accessibility/operability, design-system policy, and comparable target-policy decisions as rewrite Questions when discovery establishes the current surface but not the target policy. Use the in-scope Question home and ID scheme for the current discovery context. |
