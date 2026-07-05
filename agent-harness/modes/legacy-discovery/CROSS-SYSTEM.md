# CROSS-SYSTEM.md

## Purpose

Cross-System Synthesis rules: synthesizing boundary claims, contracts, parity, and readiness across apps that are
all `app-local-complete`.

Load this file when running Cross-System Synthesis (see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`).

## Artifact Routing

Cross-system synthesis goes under:

```text
harness-data/artifacts/legacy/cross-system/
  SUMMARY.md
  CONTRACTS.md
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
  REWRITE-READINESS.md
```

Cross-system questions (`CSQ-*`) and parity/proof rows (`CSP-*`) live in the harness-level Questions registry
(`harness-data/artifacts/questions/QUESTIONS-OPEN.md`/`QUESTIONS-RESOLVED.md`/`QUESTIONS-DISCARDED.md`), not
per-cross-system files — migrated there by `IMPROVEMENT-047`.

Use the cross-system artifacts for distinct jobs:

| Artifact | Job |
| --- | --- |
| `SUMMARY.md` | Defines the active synthesis scope, confirms entry criteria, records slice order, routes outputs, names the restart action. |
| `CONTRACTS.md` | Defines the inter-app boundaries: API, data, auth, health, observability, deployment, and ownership contracts. |
| `findings/` | Stores synthesized cross-app claims that require evidence from more than one app. |
| Questions registry (`CSQ-*` rows) | Captures unresolved cross-app or target-product decisions raised by those synthesized findings. |
| Questions registry (`CSP-*` rows) | Records where producer and consumer behavior matched, drifted, or still needs executable proof. |
| `REWRITE-READINESS.md` | States what is stable enough for Use Cases and Specs, and what blockers or proof items still prevent implementation planning. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDC-001 | Cross-System-Artifacts | Start cross-system synthesis by creating `harness-data/artifacts/legacy/cross-system/SUMMARY.md` from `agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working plan: it names the active synthesis scope, entry criteria, slice order, artifact routing, and next action. |
| LDC-002 | Cross-System-Artifacts | Create `CONTRACTS.md`, `findings/` entries, Questions-registry rows (`CSQ-*`/`CSP-*`), and `REWRITE-READINESS.md` only when a slice produces evidence that needs them. Do not create empty placeholders speculatively. Cross-system artifacts cite app-scoped artifacts and source evidence instead of copying app-local detail. |
| LDC-003 | Cross-System-Artifacts | These artifacts are connected, not independent. Cross-system findings should feed `CONTRACTS.md`, the Questions registry, and `REWRITE-READINESS.md` by citation; parity rows and readiness blockers should point back to the finding IDs and proof/question IDs they depend on. |
| LDC-004 | Cross-System-Artifacts | Use the proof/parity IDs (`CSP-*`) defined in the Questions registry as the canonical IDs. `REWRITE-READINESS.md` should reference those existing proof IDs directly instead of inventing a second blocker-ID namespace. |
| LDC-005 | Cross-System-Artifacts | Older flat files directly under `harness-data/artifacts/legacy/` are legacy layout debt. Continue new discovery in the scoped structure unless an explicit Improvement or cleanup task migrates them. |
| LDC-006 | Cross-System-Synthesis | Do not start cross-system synthesis until every app in the active synthesis scope is `app-local-complete`. The active scope must be explicit; do not infer it. |
| LDC-007 | Cross-System-Synthesis | Use cross-system artifacts only when a finding, question, contract, proof need, or readiness judgment requires more than one app. Route stable target-relevant findings to reference docs; leave legacy drift in legacy artifacts. |
| LDC-008 | Cross-System-Synthesis | Do not flatten app-local evidence into cross-system narrative summaries when an app finding or source-map citation is enough. Cross-system synthesis is a second layer over app-local discovery: app-scoped artifacts keep local evidence close to the source app; cross-system findings synthesize boundary claims from multiple app artifacts; cross-system questions, parity rows, and readiness blockers trace back to those synthesized findings. |
| LDC-009 | Findings | Cross-system findings are synthesized claims, not app-local copies. They must cite the contributing app findings and source evidence they depend on, state the cross-app claim once, and carry only the boundary-specific synthesis needed for downstream contracts, questions, parity rows, or readiness judgments. |

## Slice Roundtrip

For each cross-system slice:

1. Start from `SUMMARY.md`.
2. Load only the app-scoped source-map sections relevant to the slice.
3. Follow citations from source maps to app findings, the Questions registry, tests, contracts, and source files
   only when needed.
4. Record synthesized cross-app facts in the appropriate cross-system artifact.
5. Record or update the supporting cross-system finding first whenever the slice makes a cross-app claim.
6. Record unresolved cross-app decisions in the Questions registry (`CSQ-*`).
7. Link parity rows (`CSP-*`) and readiness blockers back to the finding, question, or proof IDs they depend on.
8. Route stable system-level findings to reference docs only when they are target-relevant and not merely legacy
   drift.
9. Validate docs with `git diff --check`.
10. Commit only when the user explicitly asks.

## Evidence Precedence

When app artifacts disagree, apply this default order and record deviations:

1. Current runtime code and tests from the relevant imported app.
2. Current checked-in API contracts and app source maps.
3. Completed migration, audit, or implementation notes.
4. Historical README, old plans, and agent guidance.

Mark stale or superseded evidence explicitly — do not treat a checked-in contract snapshot as current runtime
behavior until it is compared with the producing app. When a checked-in contract snapshot, consumer adapter, and
producing runtime disagree, capture the mismatch in a cross-system finding first, then route the downstream
decision to the Questions registry (`CSQ-*`), the executable proof need to a `CSP-*` row, and any planning impact
to `REWRITE-READINESS.md`.
