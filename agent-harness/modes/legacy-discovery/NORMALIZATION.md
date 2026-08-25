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
proof IDs, lifecycle metadata, and evidence classifications exactly (`LDG-01-030`). For cross-system artifacts,
tightening wording or merging duplicates must never sever the traceability chain across app finding IDs,
cross-system finding IDs, question IDs, proof IDs, parity rows, and readiness blockers (`LDG-01-040`).

## When To Use

Load this file once app-local discovery and/or cross-system synthesis are complete and discovery moves toward
this gate — see the Discovery Phases table in `agent-harness/modes/DISCOVERING-LEGACY.md`.

## Workflow Paths

Run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy
evidence into Use Cases, Specs, Tasks, or Implementation Planning, in this order: one app folder at a time
(`INVENTORY.md`, `SOURCE-MAP.md`, `findings/`), then cross-system artifacts (`SUMMARY.md`, `CONTRACTS.md`,
`findings/`, `REWRITE-READINESS.md`), then the unified Questions registry (`LDG-01-010`).

## Core Moves

1. Fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious ordering
   issues, and duplicate sections with the same claim, for each artifact (`LDG-01-020`).
2. For `findings/`, merge two `LF-<APP>-NNN` files that make the same claim into one: keep the ID with the
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
6. Sweep `QUESTIONS-OPEN.md` for duplicate-decision signals before normalization is considered complete: any two
   rows whose `Source` values overlap, and any row whose `Notes` column references another question ID ("see
   CSQ-", "same as Q-", "duplicate of", or similar) — resolve these self-flagged candidates into an actual merge,
   not narrative (`LDG-02-010`). Merge confirmed duplicates without resolving them — normalization does not
   decide open questions; keep the clearer/more complete question text as the single entry and add a one-line
   `Notes` recording the merged-away ID and why; the question stays open until Question Clarification resolves it
   (`LDG-02-030`), and the merged-away row must stay traceable, never silently dropped (`LDG-02-031`).
7. Flag any ID that appears in more than one of the three Questions status files, and remove the stale row — the
   `Resolved`/`Discarded` file's row is authoritative over `Open` (`LDG-02-040`). For each `Resolved`/`Discarded`
   row, re-check every finding listed in its `Source` column — the ID must appear in that finding's
   `## Resolved Questions`, not left in `## Open Questions`; check every cited finding, not just the first
   (`LDG-02-050`).

## Routing

Not applicable — normalization does not route findings or make target decisions; it hands off to Question
Clarification once complete (`agent-harness/modes/legacy-discovery/CLARIFICATION.md`).

## Outputs

Normalization does not produce a new artifact type — it tightens existing app-local artifacts, cross-system
artifacts, and Questions-registry entries in place. Normalization is not new discovery: never add findings from
source inspection; record a gap needing source inspection or runtime execution as a follow-up question or proof
item instead (`LDG-01-080`).

## Examples

Two `LF-APP-014` and `LF-APP-021` findings both describe the same caching behavior. The agent merges them,
keeping the ID with stronger evidence, folding in the other's evidence paths, archiving the superseded file with
a pointer, and preserving both files' original question-ID citations.

## Rules Map

This submode's enforceable rules live in `agent-harness/rules/modes/legacy-discovery/NORMALIZATION.md` (single
paired file — under the 25-rule grouping threshold). Load it alongside this file whenever Artifact Normalization
is the active phase.

## Reference Files

Load per `agent-harness/modes/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
