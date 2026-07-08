# APP-LOCAL.md

## Purpose

App-Local Discovery rules: slicing a single legacy app and maintaining its `INVENTORY.md`, `SOURCE-MAP.md`,
`findings/`, and its rows in the unified Questions registry.

Load this file when running App-Local Discovery (see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`).

## Artifact Routing

App-specific discovery goes under:

```text
harness-data/artifacts/legacy/apps/<legacy-app-slug>/
  INVENTORY.md
  SOURCE-MAP.md
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
```

Questions raised during this app's discovery live in the harness-level Questions registry
(`harness-data/artifacts/questions/QUESTIONS-OPEN.md`/`QUESTIONS-RESOLVED.md`/`QUESTIONS-DISCARDED.md`), not a
per-app file.

## Slice Roundtrip

1. Select the smallest useful evidence set from the source map.
2. Inspect code, then docs, then tests.
3. Classify evidence and conflicts using the Core rules in `agent-harness/modes/DISCOVERING-LEGACY.md`.
4. Update app `findings/` (add or merge into an `LF-<APP>-NNN` file, looked up by ID), the unified Questions
   registry, and `SOURCE-MAP.md`. When a question is recorded, link it bidirectionally: cite the originating
   finding(s) in the registry's `Source` column, and add the question ID to each cited finding's
   `## Open Questions` section. Use `baseline` / `cross-cutting` in `Source` when the question does not trace to a
   specific finding. Before leaving any finding's `## Open Questions` empty, test its own `Classification` and
   `Evidence Conflict` text against `QST-06-010` — if it reads as an undecided fork, raise a `Q-<APP>-NNN` row
   instead of leaving it as prose (`LDA-04-040`).
5. Enrich stable reference docs per the Reference Enrichment table in `agent-harness/modes/DISCOVERING-LEGACY.md`.
6. Before marking a slice `done`, confirm at least one of its findings is a plain baseline/descriptive finding —
   what the slice's area concretely contains or does — not only anomaly, conflict, or edge-case findings; write
   the missing baseline finding first if every finding so far is anomaly-shaped (`LDA-04-050`).
7. Validate with `git diff --check`.
8. Commit only when explicitly asked.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDA-01-010 | Inventory | App `INVENTORY.md` MUST use `agent-harness/templates/INVENTORY-template.md`: fixed `Scope`, `Identity`, `Major Runtime Areas`, `Operations, Tooling, and Quality`, and `Inventory Gaps` sections, plus as many app-specific structural sections as the app's own shape needs in between. |
| LDA-01-020 | Inventory | SHOULD name app-specific sections after what they actually cover in this app, not copy another app's section names by default. |
| LDA-02-010 | Source-Map | Each app `SOURCE-MAP.md` (the app restart point, per `SOURCE-MAP-template.md`) MUST stay app-local, containing only: source root, primary evidence files, code areas, and candidate discovery slices; block list/status when blockwise; slice status table, completed notes, open app notes, restart pointers, and reference enrichment routing; deferred/cross-system question classification before `app-local-complete`; import hygiene when the snapshot has secret-like files, local artifacts, or nested repo metadata. |
| LDA-02-020 | Source-Map | MUST NOT copy generic slice rules, block rules, roundtrip steps, cross-system judgments, or reusable process policy into app source maps. |
| LDA-03-010 | Slice | MUST treat slices as the durable unit of discovery progress. |
| LDA-03-020 | Slice | A source map MAY define as many slices as needed for rewrite-quality app evidence. |
| LDA-03-030 | Slice | Every slice MUST have status `done`, `next`, `pending`, or `not-needed`. |
| LDA-03-040 | Slice | MUST NOT mark a slice `done` until findings and unresolved questions are recorded. |
| LDA-03-050 | Slice | Completed slice notes (`Completed Notes` in the source map) MUST hold evidence paths, stable findings, and unresolved decisions only. |
| LDA-04-010 | Slice-Roundtrip | Reference enrichment MAY be deferred across blockwise work only when the source map says so. |
| LDA-04-020 | Slice-Roundtrip | MUST record any forward-looking candidate list a slice produces — candidate Use Cases, candidate Specs, candidate quality gates, or anything similarly shaped — in the relevant finding's `## Candidate Artifacts` section at authoring time. |
| LDA-04-030 | Slice-Roundtrip | MUST NOT invent a new per-slice `"Candidate <Something>"` list in `SOURCE-MAP.md`'s slice notes under any label; that is the same duplication. When a candidate spans multiple findings from the same slice, record it in each contributing finding's `Candidate Artifacts`, not as a new shared list. |
| LDA-04-040 | Slice-Roundtrip | MUST test a finding's own `Classification`/`Evidence Conflict` text against `QST-06-010`'s Question test before leaving its `## Open Questions` empty, and raise a `Q-<APP>-NNN` registry row if it matches, rather than leaving the fork as prose inside the finding. |
| LDA-04-050 | Slice-Roundtrip | MUST NOT mark a slice `done` unless at least one of its findings is a plain baseline/descriptive finding — what the slice's area concretely contains or does, independent of any anomaly; if every finding so far is anomaly, conflict, or edge-case, write the missing baseline finding first. |
| LDA-04-055 | Slice-Roundtrip | MUST check each completed slice for material operational or manual surfaces in scope — including CLI/operator tools, health/readiness/metrics surfaces, SQL diagnostics, or comparable observability paths — and write or update a finding when present. |
| LDA-04-056 | Slice-Roundtrip | MUST check each completed slice for material data-model shape choices in scope — including storage topology, JSON-vs-typed structure, DB views as read models, key typing, or migration-authority boundaries — and write or update a finding when present. |
| LDA-04-057 | Slice-Roundtrip | MUST check each completed slice for material provider-set shape in scope — including primary, fallback, overlapping, deferred, or disabled-but-wired providers — and write or update a finding when present. |
| LDA-04-058 | Slice-Roundtrip | MUST check each completed slice for material non-error runtime states in scope — including warmup, degraded-but-expected, or long-running intermediate states — and write or update a finding when present. |
| LDA-04-059 | Slice-Roundtrip | MUST check each completed slice for target-design forks implied by the evidence — including `preserve-vs-adapt`, `scope-v1`, `fidelity`, and `naming` forks — and create or update the corresponding Question in the same pass when present. |
| LDA-04-060 | Slice-Roundtrip | Reference enrichment MUST be complete before `app-local-complete`. |
| LDA-04-070 | Slice-Roundtrip | MUST NOT treat the baseline-finding requirement alone as sufficient when a slice also clearly establishes rewrite-facing conclusions, operational/manual surfaces, data-model shape, provider-set shape, non-error runtime states, or target-design forks; those evidence classes still need their own finding or Question coverage in the same pass. |
| LDA-05-010 | Blockwise | Blocks are a planning convenience for related slices with overlapping evidence, not a replacement for slices — MUST mark each included slice individually in the slice status table. |
| LDA-05-020 | Blockwise | MUST use a block only when the grouped slices share a focused evidence set. |
| LDA-05-030 | Blockwise | MUST keep blocks app-scoped. |
| LDA-05-040 | Blockwise | MUST write one completed block note listing included slices, evidence paths, stable findings, and unresolved decisions. |
| LDA-05-050 | Blockwise | MUST set the next unfinished slice or coherent block to `next` after a block completes. |
