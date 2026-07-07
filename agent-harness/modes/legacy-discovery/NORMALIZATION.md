# NORMALIZATION.md

## Purpose

Artifact Normalization: the first Post-Discovery Gate. Format, dedupe, order, and tighten existing legacy
artifacts without new source discovery, before moving toward Question Clarification.

Load this file once app-local discovery and/or cross-system synthesis are complete and discovery moves toward
this gate (see the Discovery Phases table in `agent-harness/modes/DISCOVERING-LEGACY.md`).

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDG-01-010 | Normalization | MUST run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy evidence into Use Cases, Specs, Tasks, or Implementation Planning, in this order: one app folder at a time (`INVENTORY.md`, `SOURCE-MAP.md`, `findings/`), then cross-system artifacts (`SUMMARY.md`, `CONTRACTS.md`, `findings/`, `REWRITE-READINESS.md`), then the unified Questions registry. |
| LDG-01-020 | Normalization | MUST fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious ordering issues, and duplicate sections with the same claim for each artifact. |
| LDG-01-030 | Normalization | MUST preserve information density, evidence paths, artifact IDs, question IDs, finding IDs, proof IDs, lifecycle metadata, and evidence classifications. |
| LDG-01-040 | Normalization | For cross-system artifacts, MUST preserve the traceability chain across app finding IDs, cross-system finding IDs, question IDs, proof IDs, parity rows, and readiness blockers — tightening wording or merging duplicates must not sever those links. |
| LDG-01-050 | Normalization | For `findings/`, MUST merge two `LF-<APP>-NNN` files that make the same claim into one: keep the ID with the stronger evidence set, fold the other file's evidence paths into it, set the superseded file's `status` to `archived`, add a one-line pointer to the surviving ID, and move it to `findings/archive/` — never reuse or silently drop an ID. |
| LDG-01-060 | Normalization | MUST verify each cross-system finding's `## Evidence` section cites the contributing app finding IDs it synthesizes, not only raw source paths; add missing citations before normalization is considered complete. |
| LDG-01-070 | Normalization | `SOURCE-MAP.md` and cross-system `SUMMARY.md` MUST collapse to their `Discovery-Complete Shape` (see the templates) once `discovery_state` is `app-local-complete` or cross-system synthesis is finished; MUST port forward, before collapsing, any stable finding or candidate Use Case note that lacks an equivalent entry in `findings/` or the reference docs — the file stays at the same path as the stable restart point. |
| LDG-01-080 | Normalization | Normalization is not new discovery — MUST NOT add findings from source inspection; record a gap needing source inspection or runtime execution as a follow-up question or proof item instead. |
| LDG-01-090 | Normalization | MUST re-walk the full `Resolved`/`Discarded` lists against the Reference Enrichment table in `DISCOVERING-LEGACY.md` every normalization pass, and confirm each decision that produces a stable, target-relevant fact is actually reflected there. This is a repeatable sweep, not a one-time backfill. |
| LDG-02-010 | Questions-Dedup-Sweep | MUST sweep `QUESTIONS-OPEN.md` for duplicate-decision signals before normalization is considered complete: any two rows whose `Source` values overlap, and any row whose `Notes` column references another question ID (e.g. "see CSQ-", "same as Q-", "duplicate of") — these self-flagged candidates must be resolved into an actual merge, not left as narrative. |
| LDG-02-030 | Questions-Dedup-Sweep | MUST merge confirmed duplicates without resolving them — normalization does not decide open questions. Keep the clearer/more complete question text as the single entry, and add a one-line `Notes` recording the merged-away ID and why; do not silently drop the merged-away row — it must stay traceable, mirroring finding-dedup's archive pointer. The question stays open until Question Clarification resolves it. |
| LDG-02-040 | Questions-Dedup-Sweep | MUST flag any ID that appears in more than one of the three status files, and remove the stale row; the `Resolved`/`Discarded` file's row is authoritative over `Open`. |
| LDG-02-050 | Questions-Dedup-Sweep | MUST re-check, for each `Resolved`/`Discarded` row, every finding listed in its `Source` column — the ID must appear in that finding's `## Resolved Questions`, not left in `## Open Questions`. Check every cited finding, not just the first. |
