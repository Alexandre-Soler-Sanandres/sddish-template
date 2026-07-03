# CROSS-SYSTEM.md

## Purpose

Cross-System Synthesis rules: synthesizing boundary claims, contracts, parity, and readiness across apps that are
all `app-local-complete`.

Load this file when running Cross-System Synthesis (see the Discovery Phases table in
`agent-harness/modes/LEGACY-DISCOVERY.md`).

## Artifact Routing

Cross-system synthesis goes under:

```text
harness-data/artifacts/legacy/cross-system/
  SUMMARY.md
  CONTRACTS.md
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
  QUESTIONS.md
  PARITY-MATRIX.md
  REWRITE-READINESS.md
```

Use the cross-system artifacts for distinct jobs:

| Artifact | Job |
| --- | --- |
| `SUMMARY.md` | Defines the active synthesis scope, confirms entry criteria, records slice order, routes outputs, names the restart action. |
| `CONTRACTS.md` | Defines the inter-app boundaries: API, data, auth, health, observability, deployment, and ownership contracts. |
| `findings/` | Stores synthesized cross-app claims that require evidence from more than one app. |
| `QUESTIONS.md` | Captures unresolved cross-app or target-product decisions raised by those synthesized findings. |
| `PARITY-MATRIX.md` | Records where producer and consumer behavior matched, drifted, or still needs executable proof. |
| `REWRITE-READINESS.md` | States what is stable enough for Use Cases and Specs, and what blockers or proof items still prevent implementation planning. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDC-001 | Cross-System-Artifacts | Start cross-system synthesis by creating `harness-data/artifacts/legacy/cross-system/SUMMARY.md` from `agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working plan: it names the active synthesis scope, entry criteria, slice order, artifact routing, and next action. |
| LDC-002 | Cross-System-Artifacts | Create `CONTRACTS.md`, `findings/` entries, `QUESTIONS.md`, `PARITY-MATRIX.md`, and `REWRITE-READINESS.md` only when a slice produces evidence that needs them. Do not create empty placeholders speculatively. Cross-system artifacts cite app-scoped artifacts and source evidence instead of copying app-local detail. |
| LDC-003 | Cross-System-Artifacts | These artifacts are connected, not independent. Cross-system findings should feed `CONTRACTS.md`, `QUESTIONS.md`, `PARITY-MATRIX.md`, and `REWRITE-READINESS.md` by citation; parity rows and readiness blockers should point back to the finding IDs and proof/question IDs they depend on. |
| LDC-004 | Cross-System-Artifacts | Use the proof/parity IDs defined in `PARITY-MATRIX.md` as the canonical IDs. `REWRITE-READINESS.md` should reference those existing proof IDs directly instead of inventing a second blocker-ID namespace. |
| LDC-005 | Cross-System-Artifacts | Older flat files directly under `harness-data/artifacts/legacy/` are legacy layout debt. Continue new discovery in the scoped structure unless an explicit Improvement or cleanup task migrates them. |
| LDC-006 | Cross-System-Synthesis | Do not start cross-system synthesis until every app in the active synthesis scope is `app-local-complete`. The active scope must be explicit; do not infer it. |
| LDC-007 | Cross-System-Synthesis | Use cross-system artifacts only when a finding, question, contract, proof need, or readiness judgment requires more than one app. Route stable target-relevant findings to reference docs; leave legacy drift in legacy artifacts. |
| LDC-008 | Cross-System-Synthesis | Do not flatten app-local evidence into cross-system narrative summaries when an app finding or source-map citation is enough. Cross-system synthesis is a second layer over app-local discovery: app-scoped artifacts keep local evidence close to the source app; cross-system findings synthesize boundary claims from multiple app artifacts; cross-system questions, parity rows, and readiness blockers trace back to those synthesized findings. |
| LDC-009 | Findings | Cross-system findings are synthesized claims, not app-local copies. They must cite the contributing app findings and source evidence they depend on, state the cross-app claim once, and carry only the boundary-specific synthesis needed for downstream contracts, questions, parity rows, or readiness judgments. |
