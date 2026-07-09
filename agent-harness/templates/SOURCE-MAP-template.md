---
app: <legacy-app-slug>
type: source-map
discovery_state: app-discovery-active   # app-discovery-active | app-local-complete | rewrite-ready
proof_needed: false                      # true | false
updated: ""                              # YYYY-MM-DD
---

## Source Root

`harness-data/artifacts/legacy/imported/<app-slug>/`

## Evidence Inventory

### Primary Evidence Files

(list the most load-bearing files for discovery: entry points, config, routes, domain modules, key tests)

### Code Areas

(list the main structural areas of the app: modules, packages, layers, services)

## Evidence Enumeration

(record the app root contents and any package/directory listings needed to support slice scope claims)

### Source Confidence

| Source | Confidence | Notes |
| --- | --- | --- |
| Current code / tests | high | Observed behavior — highest authority |
| Completed migration / audit docs | high | Supersede superseded plans |
| Checked-in contract snapshots | medium | Evidence of intent; may drift from runtime |
| Historical docs / README / agent rules | low | Use only when current code does not contradict |
| Stale setup / deployment docs | low | Treat as background; verify against current code |

Evidence precedence notes: (record any local conflicts and which source was treated as authoritative)

## Candidate Discovery Slices

(list all planned slices; add more as needed; source maps may define as many slices as rewrite planning requires)

| Order | Slice | Status | Notes |
| --- | --- | --- | --- |
| 0 | Baseline inventory and source-map setup | pending | |

## Block Plan

(define blocks only when adjacent slices share a focused, overlapping evidence set; omit if not using blockwise discovery)

| Block | Included slices | Status | Purpose |
| --- | --- | --- | --- |

## Working Discovery Plan

Use this plan to continue `<app-slug>` discovery across sessions without relying on chat history.

See `agent-harness/modes/DISCOVERING-LEGACY.md` for the slice roundtrip, block rules, and content boundaries that
apply to every app source map.

## Current Status

Valid status values: `done` | `next` | `pending` | `not-needed`.

| Order | Slice | Status | Notes |
| --- | --- | --- | --- |

## Completed Notes

(one entry per completed slice or block; list: included slices, evidence paths used, stable findings, unresolved
decisions, docs consulted or "none relevant", negative results for checked `LDA-04-055`/`056`/`057`/`058`/`059`
categories, the evidence basis for those checks, the fresh-context verification result, and any resulting
follow-up)

## Import Hygiene

Inventory of secret-like files, local artifacts, or nested repository metadata found in the imported snapshot —
see `agent-harness/modes/legacy-discovery/IMPORT-HYGIENE.md`'s `LD-07-010`–`050` for the governing rules. A "none found" note is
the expected content when the snapshot is clean, not an empty section.

| Path pattern | Type | Notes |
| --- | --- | --- |

Nested Git metadata check: `find harness-data/artifacts/legacy/imported/<app-slug> -path '*/.git' -type d` — expected: no output.

## Open App Notes

(app-specific open questions, risks, or observations that do not belong in a slice note or the harness Questions
registry yet)

## Restart Pointer

Next action: (slice or block name and status)

When all app-local slices are complete and cross-system synthesis is done, the next legacy action is artifact
normalization: format, deduplicate, and merge within this app's legacy artifacts without changing evidence meaning
or losing traceability. See `agent-harness/modes/DISCOVERING-LEGACY.md`.

`rewrite-ready` means the app's evidence and cross-system decisions are sufficient to begin rewrite design work.
This is an unblock state, not a claim that every legacy question is closed. Proof obligations and non-blocking open
questions may still remain if they are explicit, still tracked in the legacy artifacts, and do not block coherent Use
Cases, Specs, or planning.

## Reference Enrichment Routing

Route stable findings to the appropriate reference doc before closing the slice — see
`agent-harness/modes/DISCOVERING-LEGACY.md`'s `LD-09-010`/`020` for what qualifies as stable enough to enrich.

| Finding type | Target reference doc |
| --- | --- |
| Architecture boundaries, layer contracts | `ARCHITECTURE.md` |
| Domain concepts, rules, terminology | `DOMAIN.md` |
| Tools, commands, CI, test setup | `TOOLING.md` |
| Quality standards, test coverage, hygiene | `QUALITY.md` |

## Deferred and Cross-System Questions

(list questions that cannot be answered from app-local evidence; classify by blast radius per
`agent-harness/artifact-specs/QUESTIONS.md`'s `QST-01-010`: `local`, `cross-artifact`, or `systemic`)

| Question | Classification | Notes |
| --- | --- | --- |

## Discovery-Complete Shape

The collapsed shape of this same file once `discovery_state` reaches `app-local-complete` — see
`agent-harness/modes/legacy-discovery/NORMALIZATION.md`'s `LDG-01-070` for the collapse procedure itself.

Collapses to only: `Source Root`, `Evidence Inventory`, `Import Hygiene`, `Reference Enrichment Routing`,
`Open App Notes` (trimmed to durable notes only), and `Deferred and Cross-System Questions` (with a single line
naming the next non-discovery phase in place of `Restart Pointer`).

Removed: `Candidate Discovery Slices`, `Block Plan`, `Working Discovery Plan`, `Current Status`,
`Completed Notes`, `Restart Pointer`, `Evidence Enumeration`.
