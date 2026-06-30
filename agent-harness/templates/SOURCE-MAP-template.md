---
app: <legacy-app-slug>
type: source-map
discovery_state: app-discovery-active   # app-discovery-active | app-local-complete | rewrite-ready
proof_needed: false                      # true | false
updated: ""                              # YYYY-MM-DD
---

## Source Root

`legacy/imported/<app-slug>/`

## Evidence Inventory

### Primary Evidence Files

(list the most load-bearing files for discovery: entry points, config, routes, domain modules, key tests)

### Code Areas

(list the main structural areas of the app: modules, packages, layers, services)

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

See `agent-harness/modes/LEGACY-DISCOVERY.md` for the slice roundtrip, block rules, and content boundaries that
apply to every app source map.

## Current Status

Valid status values: `done` | `next` | `pending` | `not-needed`. Do not use custom values.

| Order | Slice | Status | Notes |
| --- | --- | --- | --- |

## Completed Notes

(one entry per completed slice or block; list: included slices, evidence paths used, stable findings, unresolved
decisions)

## Import Hygiene

Complete this section when the imported snapshot contains secret-like files, local artifacts, or nested
repository metadata. Leave blank with a "none found" note only when the snapshot is clean. Do not skip.
Write FINDINGS + QUESTIONS entries for any category that requires a user decision.

| Path pattern | Type | Notes |
| --- | --- | --- |

Nested Git metadata check: `find legacy/imported/<app-slug> -path '*/.git' -type d` — expected: no output.

## Open App Notes

(app-specific open questions, risks, or observations that do not belong in a slice note or QUESTIONS.md yet)

## Restart Pointer

Next action: (slice or block name and status)

## Reference Enrichment Routing

When evidence is stable, route findings to the appropriate reference doc before closing the slice.

| Finding type | Target reference doc |
| --- | --- |
| Architecture boundaries, layer contracts | `ARCHITECTURE.md` |
| Domain concepts, rules, terminology | `DOMAIN.md` |
| Tools, commands, CI, test setup | `TOOLING.md` |
| Quality standards, test coverage, hygiene | `QUALITY.md` |

Update reference docs only when evidence is app-local and stable. Do not propagate unresolved or cross-system
findings to reference docs.

## Deferred and Cross-System Questions

(list questions that cannot be answered from app-local evidence; classify as: app-local, cross-system, or
target-product decision)

| Question | Classification | Notes |
| --- | --- | --- |
