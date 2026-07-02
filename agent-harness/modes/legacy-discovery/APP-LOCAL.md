# APP-LOCAL.md

## Purpose

App-Local Discovery rules: slicing a single legacy app and maintaining its `INVENTORY.md`, `SOURCE-MAP.md`,
`findings/`, and `QUESTIONS.md`.

Load this file when running App-Local Discovery (see the Discovery Phases table in
`agent-harness/modes/LEGACY-DISCOVERY.md`).

## Artifact Routing

App-specific discovery goes under:

```text
harness-data/legacy/apps/<legacy-app-slug>/
  INVENTORY.md
  SOURCE-MAP.md
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
  QUESTIONS.md
```

## Slice Roundtrip

1. Select the smallest useful evidence set from the source map.
2. Inspect code, then docs, then tests.
3. Classify evidence and conflicts using the Core rules in `agent-harness/modes/LEGACY-DISCOVERY.md`.
4. Update app `findings/` (add or merge into an `LF-<APP>-NNN` file, looked up by ID), `QUESTIONS.md`, and
   `SOURCE-MAP.md`. When a question is recorded, link it bidirectionally: cite the originating finding(s) in
   `QUESTIONS.md`'s `Source finding(s)` column, and add the question ID to each cited finding's
   `## Open Questions` section. Use `baseline` / `cross-cutting` in `Source finding(s)` when the question does not
   trace to a specific finding.
5. Enrich stable reference docs per the Reference Enrichment table in `agent-harness/modes/LEGACY-DISCOVERY.md`.
6. Validate with `git diff --check`.
7. Commit only when explicitly asked.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDA-001 | Inventory | App `INVENTORY.md` uses `agent-harness/templates/INVENTORY-template.md`: fixed `Scope`, `Identity`, `Major Runtime Areas`, `Operations, Tooling, and Quality`, and `Inventory Gaps` sections, plus as many app-specific structural sections as the app's own shape needs in between. |
| LDA-002 | Inventory | Name app-specific sections after what they actually cover in this app — do not copy another app's section names by default. |
| LDA-003 | Source-Map | Each app `SOURCE-MAP.md` (the app restart point, using `agent-harness/templates/SOURCE-MAP-template.md`) must stay app-local and contain only: source root, primary evidence files, code areas, and candidate discovery slices; block list and status when blockwise discovery is used; slice status table, completed slice/block notes, open app notes, restart pointers, and reference enrichment routing; deferred/cross-system question classification before `app-local-complete`; import hygiene when the snapshot contains secret-like files, local artifacts, or nested repository metadata. |
| LDA-004 | Source-Map | Do not copy generic slice rules, block rules, roundtrip steps, cross-system judgments, or reusable process policy into app source maps. |
| LDA-005 | Slice | Slices are the durable unit of discovery progress. |
| LDA-006 | Slice | A source map may define as many slices as needed for rewrite-quality app evidence. |
| LDA-007 | Slice | Every slice has status `done`, `next`, `pending`, or `not-needed`. |
| LDA-008 | Slice | Do not mark a slice `done` until findings and unresolved questions are recorded. |
| LDA-009 | Slice | Completed slice notes list evidence paths, stable findings, and unresolved decisions. |
| LDA-010 | Slice-Roundtrip | Reference enrichment may be deferred across blockwise work only when the source map says so; it must be complete before `app-local-complete`. |
| LDA-011 | Slice-Roundtrip | Record any forward-looking candidate list a slice produces — candidate Use Cases, candidate Specs, candidate quality gates, or anything similarly shaped — in the relevant finding's `## Candidate Artifacts` section at authoring time. |
| LDA-012 | Slice-Roundtrip | Do not invent a new per-slice `"Candidate <Something>"` list in `SOURCE-MAP.md`'s slice notes under any label; that is the same duplication regardless of what the list is called. When a candidate spans multiple findings from the same slice, record it in each contributing finding's `Candidate Artifacts`, not as a new shared list. |
| LDA-013 | Slice-Roundtrip | `Completed Notes` in the source map holds evidence paths, stable findings, and unresolved decisions only. |
| LDA-014 | Blockwise | Blocks are a planning convenience for related slices with overlapping evidence; they do not replace slices. Mark each included slice individually in the slice status table. |
| LDA-015 | Blockwise | Use a block only when the grouped slices share a focused evidence set. |
| LDA-016 | Blockwise | Keep blocks app-scoped. |
| LDA-017 | Blockwise | Write one completed block note listing included slices, evidence paths, stable findings, and unresolved decisions. |
| LDA-018 | Blockwise | After a block completes, set the next unfinished slice or coherent block to `next`. |
