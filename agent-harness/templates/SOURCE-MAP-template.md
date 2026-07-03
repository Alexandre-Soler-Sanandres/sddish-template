---
app: <legacy-app-slug>
type: source-map
discovery_state: app-discovery-active   # app-discovery-active | app-local-complete | rewrite-ready
proof_needed: false                      # true | false
updated: ""                              # YYYY-MM-DD
---

## Source Root

`harness-data/legacy/imported/<app-slug>/`

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

Nested Git metadata check: `find harness-data/legacy/imported/<app-slug> -path '*/.git' -type d` — expected: no output.

## Open App Notes

(app-specific open questions, risks, or observations that do not belong in a slice note or QUESTIONS.md yet)

## Restart Pointer

Next action: (slice or block name and status)

When all app-local slices are complete and cross-system synthesis is done, the next legacy action is artifact
normalization: format, deduplicate, and merge within this app's legacy artifacts without changing evidence meaning
or losing traceability. See `agent-harness/modes/LEGACY-DISCOVERY.md`.

`rewrite-ready` means the app's evidence and cross-system decisions are sufficient to begin rewrite design work.
This is an unblock state, not a claim that every legacy question is closed. Proof obligations and non-blocking open
questions may still remain if they are explicit, still tracked in the legacy artifacts, and do not block coherent Use
Cases, Specs, or planning.

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

## Discovery-Complete Shape

Apply this section once `discovery_state` reaches `app-local-complete`, as part of Post-Discovery Artifact
Normalization (see `agent-harness/modes/legacy-discovery/GATES.md`, LDG-007). This is a collapse of the same file
at the same path — do not rename it or create a second file.

Precondition: every "stable finding" and "candidate Use Case" note inside `Completed Notes` / slice notes must
already have an equivalent entry in this app's `findings/`, or in the relevant reference doc, before it is cut
from the source map. If a note has no home yet, move it there first.

Collapse the source map to only:

- `Source Root`
- `Evidence Inventory` (`Primary Evidence Files`, `Code Areas`, `Source Confidence`)
- `Import Hygiene`
- `Reference Enrichment Routing`
- `Open App Notes`, trimmed to durable open notes only — drop per-slice scratch notes that have already been
  captured elsewhere
- `Deferred and Cross-System Questions`

Remove: `Candidate Discovery Slices`, `Block Plan`, `Working Discovery Plan`, `Current Status`, `Completed Notes`,
and `Restart Pointer`. Replace the restart pointer with a single line naming the next non-discovery phase (Use
Cases or Specs) directly under `Deferred and Cross-System Questions`.
