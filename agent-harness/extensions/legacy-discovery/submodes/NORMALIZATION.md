# NORMALIZATION.md

## Purpose

Artifact Normalization: the first Post-Discovery Gate. Format, dedupe, order, and tighten existing legacy
artifacts without new source discovery, before moving toward Question Clarification.

## Mode Story

Once app-local discovery and cross-system synthesis are complete, the agent walks the artifacts one app at a
time, then cross-system artifacts, then the unified Questions registry — fixing formatting, merging duplicate
findings, collapsing stable source maps to their discovery-complete shape, and sweeping for duplicate-decision
Questions. Normalization never adds a new finding from fresh source inspection; anything that needs new
inspection becomes a follow-up question or proof item instead.

## Operating Posture

Tighten, don't discover: preserve information density, evidence paths, artifact IDs, question IDs, finding IDs,
proof obligations, lifecycle metadata, and evidence classifications exactly (`LDG-01-030`). For cross-system artifacts,
tightening wording or merging duplicates must never sever the traceability chain across app finding IDs,
cross-system finding IDs, question IDs, proof obligations, parity evidence, and readiness blockers (`LDG-01-040`).

## When To Use

Load this file once app-local discovery and/or cross-system synthesis are complete and discovery moves toward
this gate — see the Discovery Phases table in `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`.

## Workflow Paths

Run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy
evidence into Use Cases, Specs, Tasks, or Implementation Planning, in this order: one app folder at a time
(`INVENTORY.md`, `SOURCE-MAP.md`, `findings/`), then cross-system artifacts (`SUMMARY.md`, `CONTRACTS.md`,
`findings/`, `REWRITE-READINESS.md`), then the unified Questions registry (`LDG-01-010`).

## Core Moves

1. Fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious ordering
   issues, and duplicate sections with the same claim, for each artifact (`LDG-01-020`).
2. For `findings/`, merge two `LF-<APP>-NNNN` files that make the same claim into one: keep the ID with the
   stronger evidence set, fold the other file's evidence paths into it, set the superseded file's `status` to
   `archived`, add a one-line pointer to the surviving ID, and move it to `findings/archive/` — never reuse or
   silently drop an ID as part of this merge (`LDG-01-050`/`LDG-01-051`).
3. Verify each cross-system finding's `## Evidence` section cites the contributing app finding IDs it
   synthesizes, not only raw source paths; add missing citations before normalization is considered complete
   (`LDG-01-060`).
4. Collapse `SOURCE-MAP.md` and cross-system `SUMMARY.md` to their `Discovery-Complete Shape` (see the templates)
   once `discovery_state` is `app-local-complete` or cross-system synthesis is finished — the file stays at the
   same path as the stable restart point (`LDG-01-070`). Before that collapse, port forward any stable finding or
   candidate Use Case note that lacks an equivalent entry in `findings/` or the reference docs (`LDG-01-071`).
5. Re-walk the full `Resolved`/`Discarded` lists against the Reference Enrichment table in
   `DISCOVERING-LEGACY.md` every normalization pass, confirming each decision that produces a stable,
   target-relevant fact is actually reflected there — a repeatable sweep, not a one-time backfill (`LDG-01-090`).
6. Sweep `QUESTIONS.md` for duplicate-decision signals before normalization is considered complete: any two
   rows whose `Source IDs` values overlap, and any row whose `Notes` references another Question as the same or a
   duplicate uncertainty — resolve these self-flagged candidates into an actual merge,
   not narrative (`LDG-02-010`). Merge confirmed duplicates without resolving them — normalization does not
   decide open questions; keep the clearer/more complete question text as the single entry and add a one-line
   `Notes` recording the merged-away ID and why; the question stays open until Question Clarification resolves it
   (`LDG-02-030`), and the merged-away row must stay traceable, never silently dropped (`LDG-02-031`).
7. Flag duplicate Question IDs or rows in the single registry and merge them while preserving terminal data
   (`LDG-02-040`). For each terminal row, re-check every finding listed in its `Source IDs` column — the ID must appear in that finding's
   `## Resolved Questions`, not left in `## Open Questions`; check every cited finding, not just the first
   (`LDG-02-050`).

## Routing

Not applicable — normalization does not route findings or make target decisions; it hands off to Question
Clarification once complete (`agent-harness/extensions/legacy-discovery/submodes/CLARIFICATION.md`).

## Outputs

Normalization does not produce a new artifact type — it tightens existing app-local artifacts, cross-system
artifacts, and Questions-registry entries in place. Normalization is not new discovery: never add findings from
source inspection; record a gap needing source inspection or runtime execution as a follow-up question or proof
item instead (`LDG-01-080`).

## Examples

Two `LF-APP-0014` and `LF-APP-0021` findings both describe the same caching behavior. The agent merges them,
keeping the ID with stronger evidence, folding in the other's evidence paths, archiving the superseded file with
a pointer, and preserving both files' original question-ID citations.

## Rules

| ID | Rule |
| --- | --- |
| LDG-01-010 | MUST run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy evidence into Use Cases, Specs, Tasks, or Implementation Planning, in this order: one app folder at a time (`INVENTORY.md`, `SOURCE-MAP.md`, `findings/`), then cross-system artifacts (`SUMMARY.md`, `CONTRACTS.md`, `findings/`, `REWRITE-READINESS.md`), then the unified Questions registry. |
| LDG-01-020 | MUST fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious ordering issues, and duplicate sections with the same claim for each artifact. |
| LDG-01-030 | MUST preserve information density, evidence paths, artifact IDs, question IDs, finding IDs, proof obligations, lifecycle metadata, and evidence classifications. |
| LDG-01-040 | For cross-system artifacts, MUST preserve the traceability chain across app finding IDs, cross-system finding IDs, question IDs, proof obligations, parity evidence, and readiness blockers — tightening wording or merging duplicates must not sever those links. |
| LDG-01-050 | For `findings/`, MUST merge two `LF-<APP>-NNNN` files that make the same claim into one: keep the ID with the stronger evidence set, fold the other file's evidence paths into it, set the superseded file's `status` to `archived`, add a one-line pointer to the surviving ID, and move it to `findings/archive/`. |
| LDG-01-051 | MUST NOT reuse or silently drop an ID as part of an `LDG-01-050` merge. |
| LDG-01-060 | MUST verify each cross-system finding's `## Evidence` section cites the contributing app finding IDs it synthesizes, not only raw source paths; add missing citations before normalization is considered complete. |
| LDG-01-070 | `SOURCE-MAP.md` and cross-system `SUMMARY.md` MUST collapse to their `Discovery-Complete Shape` (see the templates) once `discovery_state` is `app-local-complete` or cross-system synthesis is finished — the file stays at the same path as the stable restart point. |
| LDG-01-071 | MUST port forward, before an `LDG-01-070` collapse, any stable finding or candidate Use Case note that lacks an equivalent entry in `findings/` or the reference docs. |
| LDG-01-080 | Normalization is not new discovery — MUST NOT add findings from source inspection; record a gap needing source inspection or runtime execution as a follow-up question or proof item instead. |
| LDG-01-090 | MUST re-walk the full `Resolved`/`Discarded` lists against the Reference Enrichment table in `DISCOVERING-LEGACY.md` every normalization pass, and confirm each decision that produces a stable, target-relevant fact is actually reflected there. This is a repeatable sweep, not a one-time backfill. |
| LDG-02-010 | MUST sweep `QUESTIONS.md` for duplicate-decision signals: overlapping `Source IDs` and Notes that identify the same or a duplicate uncertainty must be resolved into an actual merge. |
| LDG-02-030 | MUST merge confirmed duplicates without resolving them — normalization does not decide open questions. Keep the clearer/more complete question text as the single entry, and add a one-line `Notes` recording the merged-away ID and why. The question stays open until Question Clarification resolves it. |
| LDG-02-031 | MUST NOT silently drop a merged-away row per `LDG-02-030` — it must stay traceable, mirroring finding-dedup's archive pointer. |
| LDG-02-040 | MUST flag duplicate Question IDs or rows in the single registry and merge them while preserving authoritative terminal data when one duplicate is terminal. |
| LDG-02-050 | MUST re-check, for each `Resolved`/`Discarded` row, every finding listed in its `Source` column — the ID must appear in that finding's `## Resolved Questions`, not left in `## Open Questions`. Check every cited finding, not just the first. |

## Reference Files

Load per `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
