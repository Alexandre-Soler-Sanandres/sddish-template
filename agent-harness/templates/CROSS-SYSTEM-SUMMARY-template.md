---
id: CROSS-SYSTEM-SUMMARY-001
type: cross-system-summary
status: active
discovery_state: cross-system-active
updated: ""                 # YYYY-MM-DD
active_synthesis_scope: []  # app slugs, e.g. [app-one, app-two]
source_maps: []             # app-scoped source-map paths
tags: [legacy-discovery, cross-system]
---

# Cross-System Legacy Discovery Summary

## Purpose

(describe why cross-system synthesis is needed and which app-local discoveries it connects)

## Documentation Decision

This `SUMMARY.md` documents the whole cross-system discovery plan. The other cross-system artifacts
(`CONTRACTS.md`, `findings/`, `REWRITE-READINESS.md`, plus `CSQ-*`/`CSP-*` rows in the harness Questions registry)
are created only when a slice produces evidence that needs them — see
`agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`'s `LDC-002`/`003` for the governing rules and each
artifact's job.

## Entry Criteria

Cross-system synthesis scope is explicit:

| App | Source map | Discovery state | Proof flag |
| --- | --- | --- | --- |
| `<app-slug>` | `harness-data/artifacts/legacy/apps/<app-slug>/SOURCE-MAP.md` | `app-local-complete` | `proof_needed: false` |

All in-scope app source maps must be at `app-local-complete` before synthesis starts. App-level proof flags do not
block cross-system synthesis when they are already accepted or explicitly deferred, but cross-system slices may still
identify proof work required before rewrite-readiness.

## Evidence Precedence

See `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`'s own `## Evidence Precedence` section for the
governing default order and conflict-routing rule.

## Working Discovery Plan

Example slice order — adjust names and count to the active synthesis scope; keep every slice focused enough to
complete with a small evidence set:

| Order | Slice | Status | Primary output | Purpose |
| --- | --- | --- | --- | --- |
| 0 | Cross-system plan and scope setup | done | `SUMMARY.md` | Define the synthesis scope, restart point, slice order, artifact routing, and validation expectations. |
| 1 | Inter-app topology and contract inventory | next | `CONTRACTS.md`, `findings/` entries, Questions registry as needed | Map runtime relationships, inter-app calls, shared assumptions, and operator entry points. |
| 2 | Contract parity and drift | pending | `CONTRACTS.md`, Questions registry (`CSP-*`) | Compare producer contracts, consumer adapters, checked-in snapshots, compatibility shims, and known drift. |
| 3 | Health, readiness, metrics, and observability | pending | `CONTRACTS.md`, `findings/` entries, Questions registry as needed | Synthesize liveness/readiness semantics, metrics surfaces, logs, dashboards, and alerting across apps. |
| 4 | Security, auth, secrets, and trust boundaries | pending | `CONTRACTS.md`, Questions registry | Clarify user auth, service auth, API keys, secret handling, network trust, and target decisions. |
| 5 | Deployment, runtime topology, and configuration parity | pending | `CONTRACTS.md`, `findings/` entries, Questions registry as needed | Synthesize ports, networks, Compose/Swarm/Kubernetes posture, images, volumes, env vars, and runtime responsibilities. |
| 6 | Domain ownership and workflow boundary synthesis | pending | `findings/` entries, Questions registry | Confirm which app owns canonical outcomes versus presentation, orchestration, or adapter behavior. Record candidate Use Cases/Specs in the relevant finding's `Candidate Artifacts`, not as a separate list. |
| 7 | Rewrite proof and parity | pending | Questions registry (`CSP-*`) | Turn known drift into executable proof candidates and parity rows. |
| 8 | Cross-system rewrite-readiness assessment | pending | `REWRITE-READINESS.md` | Decide what is ready to feed rewrite design work, what remains a target-product decision, and which proof or validation obligations must be carried forward into Use Cases, Specs, validation, or Implementation Planning. |
| 9 | Post-discovery artifact normalization | pending | App and cross-system legacy artifacts | Format, deduplicate, and merge within each artifact without losing information density, evidence paths, IDs, or correctness. |

## Slice Roundtrip

See `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`'s own `## Slice Roundtrip` section for the governing
per-slice procedure.

## Reference Enrichment Routing

| Finding kind | Target reference doc |
| --- | --- |
| System boundaries, app ownership, runtime topology, API contracts | `harness-data/reference/ARCHITECTURE.md` |
| Cross-app domain ownership, actors, workflows, canonical outcomes | `harness-data/reference/DOMAIN.md` |
| Cross-app commands, local Compose, ports, validation/proof commands | `harness-data/reference/TOOLING.md` |
| Contract tests, parity tests, security gates, readiness/proof standards | `harness-data/reference/QUALITY.md` |

Cross-system artifact responsibilities and canonical-ID ownership: see
`agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`'s Artifact Routing table and `LDC-004`. Clarification
sequencing after normalization: see `agent-harness/modes/legacy-discovery/GATES.md`'s `LDG-016`/`018`.

## Initial Cross-System Questions

(planning seeds only; move or refine into the harness Questions registry when a slice confirms they cannot be
answered from available evidence)

| Question | Likely slice | Notes |
| --- | --- | --- |
|  |  |  |

## Restart Pointer

Next action: (slice name and status)

Start from:

- `harness-data/artifacts/legacy/apps/<app-slug>/SOURCE-MAP.md`

Read only the source-map sections and evidence paths needed for the next slice.

After cross-system discovery is complete, run post-discovery artifact normalization before moving into Use Cases,
Specs, Tasks, or Implementation Planning. Normalize app-scoped artifacts first, then cross-system artifacts, and do
not change evidence meaning or remove traceability.

## Discovery-Complete Shape

The collapsed shape of this same file once cross-system synthesis is finished — see
`agent-harness/modes/legacy-discovery/GATES.md`'s `LDG-007` for the collapse procedure itself.

Collapses to only: `Purpose`, `Entry Criteria` (kept as a record of the scope synthesis actually ran against),
`Evidence Precedence`, `Reference Enrichment Routing`, and any unresolved items from `Initial Cross-System
Questions` that were never moved into the harness Questions registry (move them there now instead of leaving them
here), plus a single line naming the next non-discovery phase in place of `Restart Pointer`.

Removed: `Documentation Decision`, `Working Discovery Plan`, `Slice Roundtrip`, `Completed Slice Notes`, `Restart
Pointer`.
