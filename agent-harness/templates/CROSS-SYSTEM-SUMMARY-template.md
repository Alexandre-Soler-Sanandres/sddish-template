---
id: CROSS-SYSTEM-SUMMARY-001
type: cross-system-summary
status: active
discovery_state: cross-system-active
updated: ""                 # YYYY-MM-DD
active_synthesis_scope: []  # app slugs, e.g. [tw-engine, tw-dashboard]
source_maps: []             # app-scoped source-map paths
tags: [legacy-discovery, cross-system]
---

# Cross-System Legacy Discovery Summary

## Purpose

(describe why cross-system synthesis is needed and which app-local discoveries it connects)

## Documentation Decision

Document the whole cross-system discovery plan in this `SUMMARY.md`.

Create the other cross-system artifacts only when a slice produces evidence that needs them:

- `CONTRACTS.md` for inter-app API, data, auth, health, observability, and deployment contracts.
- `FINDINGS.md` for cross-system findings that require evidence from more than one app.
- `QUESTIONS.md` for unresolved decisions that cannot be answered from one app alone.
- `PARITY-MATRIX.md` for legacy-to-target parity and proof tracking.
- `REWRITE-READINESS.md` for the final readiness assessment after contracts, questions, and proof needs are known.

Do not create empty placeholder artifacts speculatively.

## Entry Criteria

Cross-system synthesis scope is explicit:

| App | Source map | Discovery state | Proof flag |
| --- | --- | --- | --- |
| `<app-slug>` | `agent-harness/legacy/apps/<app-slug>/SOURCE-MAP.md` | `app-local-complete` | `proof_needed: false` |

All in-scope app source maps must be at `app-local-complete` before synthesis starts. App-level proof flags do not
block cross-system synthesis when they are already accepted or explicitly deferred, but cross-system slices may still
identify proof work required before rewrite-readiness.

## Evidence Precedence

Use this precedence when app artifacts disagree:

1. Current runtime code and tests from the relevant imported app.
2. Current checked-in API contracts and app source maps.
3. Completed migration, audit, or implementation notes.
4. Historical README, old plans, and agent guidance.

Mark stale or superseded evidence explicitly. Do not treat a checked-in contract snapshot as current runtime behavior
until it is compared with the producing app.

## Working Discovery Plan

| Order | Slice | Status | Primary output | Purpose |
| --- | --- | --- | --- | --- |
| 0 | Cross-system plan and scope setup | done | `SUMMARY.md` | Define the synthesis scope, restart point, slice order, artifact routing, and validation expectations. |
| 1 | Inter-app topology and contract inventory | next | `CONTRACTS.md`, `FINDINGS.md`, `QUESTIONS.md` as needed | Map runtime relationships, inter-app calls, shared assumptions, and operator entry points. |
| 2 | Contract parity and drift | pending | `CONTRACTS.md`, `PARITY-MATRIX.md`, `QUESTIONS.md` as needed | Compare producer contracts, consumer adapters, checked-in snapshots, compatibility shims, and known drift. |
| 3 | Health, readiness, metrics, and observability | pending | `CONTRACTS.md`, `FINDINGS.md`, `QUESTIONS.md` as needed | Synthesize liveness/readiness semantics, metrics surfaces, logs, dashboards, and alerting across apps. |
| 4 | Security, auth, secrets, and trust boundaries | pending | `CONTRACTS.md`, `QUESTIONS.md`, `PARITY-MATRIX.md` as needed | Clarify user auth, service auth, API keys, secret handling, network trust, and target decisions. |
| 5 | Deployment, runtime topology, and configuration parity | pending | `CONTRACTS.md`, `FINDINGS.md`, `QUESTIONS.md` as needed | Synthesize ports, networks, Compose/Swarm/Kubernetes posture, images, volumes, env vars, and runtime responsibilities. |
| 6 | Domain ownership and workflow boundary synthesis | pending | `FINDINGS.md`, `QUESTIONS.md`, candidate Use Cases/Specs as needed | Confirm which app owns canonical outcomes versus presentation, orchestration, or adapter behavior. |
| 7 | Rewrite proof and parity matrix | pending | `PARITY-MATRIX.md` | Turn known drift into executable proof candidates and parity rows. |
| 8 | Cross-system rewrite-readiness assessment | pending | `REWRITE-READINESS.md` | Decide what is rewrite-ready, what remains a target-product decision, and what must feed Use Cases, Specs, or Implementation Planning. |

Adjust slice names and count to the active synthesis scope. Keep every slice focused enough to complete with a small
evidence set.

## Slice Roundtrip

For each cross-system slice:

1. Start from this `SUMMARY.md`.
2. Load only the app-scoped source-map sections relevant to the slice.
3. Follow citations from source maps to app FINDINGS, QUESTIONS, tests, contracts, and source files only when needed.
4. Record synthesized cross-app facts in the appropriate cross-system artifact.
5. Record unresolved cross-app decisions in `QUESTIONS.md`.
6. Route stable system-level findings to reference docs only when they are target-relevant and not merely legacy drift.
7. Validate docs with `git diff --check`.
8. Commit only when the user explicitly asks.

## Reference Enrichment Routing

| Finding kind | Target reference doc |
| --- | --- |
| System boundaries, app ownership, runtime topology, API contracts | `agent-harness/reference/ARCHITECTURE.md` |
| Cross-app domain ownership, actors, workflows, canonical outcomes | `agent-harness/reference/DOMAIN.md` |
| Cross-app commands, local Compose, ports, validation/proof commands | `agent-harness/reference/TOOLING.md` |
| Contract tests, parity tests, security gates, readiness/proof standards | `agent-harness/reference/QUALITY.md` |

## Initial Cross-System Questions

(planning seeds only; move or refine into `QUESTIONS.md` when a slice confirms they cannot be answered from available
evidence)

| Question | Likely slice | Notes |
| --- | --- | --- |
|  |  |  |

## Restart Pointer

Next action: (slice name and status)

Start from:

- `agent-harness/legacy/apps/<app-slug>/SOURCE-MAP.md`

Read only the source-map sections and evidence paths needed for the next slice.
