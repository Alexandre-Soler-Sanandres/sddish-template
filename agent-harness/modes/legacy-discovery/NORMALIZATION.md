# NORMALIZATION.md

## Purpose

Artifact Normalization: the first Post-Discovery Gate. Format, dedupe, order, and tighten existing legacy
artifacts without new source discovery, before moving toward Question Clarification.

Load this file once app-local discovery and/or cross-system synthesis are complete and discovery moves toward
this gate (see the Discovery Phases table in `agent-harness/modes/DISCOVERING-LEGACY.md`).

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDG-01-010 | Normalization | Run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy evidence into Use Cases, Specs, Tasks, or Implementation Planning, in this order: one app folder at a time (`INVENTORY.md`, `SOURCE-MAP.md`, `findings/`), then cross-system artifacts (`SUMMARY.md`, `CONTRACTS.md`, `findings/`, `REWRITE-READINESS.md`), then the unified Questions registry (the three `QUESTIONS-OPEN`/`RESOLVED`/`DISCARDED.md` files under `harness-data/artifacts/questions/`). |
| LDG-01-020 | Normalization | For each artifact, fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious ordering issues, and duplicate sections with the same claim. |
| LDG-01-030 | Normalization | Preserve information density, evidence paths, artifact IDs, question IDs, finding IDs, proof IDs, lifecycle metadata, and evidence classifications. |
| LDG-01-040 | Normalization | For cross-system artifacts, preserve the traceability chain across app finding IDs, cross-system finding IDs, question IDs, proof IDs, parity rows, and readiness blockers; tightening wording or merging duplicates must not sever those links. |
| LDG-01-050 | Normalization | For `findings/`, merge two `LF-<APP>-NNN` files that make the same claim into one: keep the ID with the stronger evidence set, fold the other file's evidence paths into it, set the superseded file's `status` to `archived`, add a one-line pointer to the surviving ID, and move it to `findings/archive/`. Never reuse or silently drop an ID. |
| LDG-01-060 | Normalization | For cross-system `findings/`, verify each finding's `## Evidence` section cites the contributing app finding IDs it synthesizes, not only raw source paths; add missing citations before normalization is considered complete. |
| LDG-01-070 | Normalization | `SOURCE-MAP.md` and cross-system `SUMMARY.md` additionally collapse to their `Discovery-Complete Shape` (see `SOURCE-MAP-template.md` and `CROSS-SYSTEM-SUMMARY-template.md`) once `discovery_state` is `app-local-complete` (app-scoped) or cross-system synthesis is finished. Before collapsing, port forward any stable finding or candidate Use Case note in the removed sections that does not already have an equivalent entry in `findings/` or the reference docs. This is a structural collapse of session-resumption scaffolding, not a loss of evidence — the file stays at the same path as the artifact's stable restart point. |
| LDG-01-080 | Normalization | Normalization is not new discovery. Do not add findings from source inspection; record a gap needing source inspection or runtime execution as a follow-up question or proof item instead. |
| LDG-01-090 | Normalization | Re-walk the full `Resolved`/`Discarded` lists (`harness-data/artifacts/questions/QUESTIONS-RESOLVED.md`, `QUESTIONS-DISCARDED.md`) against the Reference Enrichment table in `agent-harness/modes/DISCOVERING-LEGACY.md` every normalization pass, and confirm each decision that produces a stable, target-relevant fact is actually reflected there. This is a repeatable sweep, not a one-time backfill. |
| LDG-02-010 | Questions-Dedup-Sweep | Before normalization is considered complete, sweep `QUESTIONS-OPEN.md`: flag any two rows whose `Source` values overlap — a strong, mechanical signal of the same underlying decision raised more than once. |
| LDG-02-020 | Questions-Dedup-Sweep | Flag any row whose `Notes` column references another question ID (e.g. "see CSQ-", "same as Q-", "duplicate of") — these self-flagged candidates must be resolved into an actual merge, not left as narrative. |
| LDG-02-030 | Questions-Dedup-Sweep | Merge confirmed duplicates without resolving them — normalization does not decide open questions. Keep the row with the clearer/more complete question text as the single entry, and add a one-line note in `Notes` recording the merged-away ID and why (e.g. "merges duplicate CSQ-012, same source finding LF-CROSS-016"). Do not silently drop the merged-away row — the ID must stay traceable, mirroring finding-dedup's archive pointer. The question itself stays open until Question Clarification resolves it. |
| LDG-02-040 | Questions-Dedup-Sweep | Flag any ID that appears in more than one of the three status files. Remove the stale row; the `Resolved`/`Discarded` file's row is authoritative over `Open`. |
| LDG-02-050 | Questions-Dedup-Sweep | For each `Resolved / Discarded` row, re-check every finding listed in its `Source` column — the ID must appear in that finding's `## Resolved Questions`, not left in `## Open Questions`. Check every cited finding, not just the first; a multi-finding citation is a common place for one sibling to be missed while the others are updated correctly. |
