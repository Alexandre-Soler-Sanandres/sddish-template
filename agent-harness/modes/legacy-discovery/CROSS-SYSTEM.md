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
per-cross-system files.

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
| LDC-01-010 | Cross-System-Artifacts | MUST start cross-system synthesis by creating `harness-data/artifacts/legacy/cross-system/SUMMARY.md` from `agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working plan: it names the active synthesis scope, entry criteria, slice order, artifact routing, and next action. |
| LDC-01-020 | Cross-System-Artifacts | MUST NOT create `CONTRACTS.md`, `findings/` entries, Questions-registry rows (`CSQ-*`/`CSP-*`), or `REWRITE-READINESS.md` speculatively as empty placeholders — create them only when a slice produces evidence that needs them, and cite app-scoped artifacts and source evidence instead of copying app-local detail. |
| LDC-01-030 | Cross-System-Artifacts | Cross-system artifacts are connected, not independent: findings SHOULD feed `CONTRACTS.md`, the Questions registry, and `REWRITE-READINESS.md` by citation, and parity rows and readiness blockers SHOULD point back to the finding IDs and proof/question IDs they depend on. |
| LDC-01-040 | Cross-System-Artifacts | MUST use the proof/parity IDs (`CSP-*`) defined in the Questions registry as the canonical IDs. |
| LDC-01-050 | Cross-System-Artifacts | MUST continue new discovery in the scoped structure unless an explicit Improvement or cleanup task migrates the older flat files under `harness-data/artifacts/legacy/` (legacy layout debt). |
| LDC-01-060 | Cross-System-Artifacts | `REWRITE-READINESS.md` SHOULD reference those existing proof IDs directly instead of inventing a second blocker-ID namespace. |
| LDC-02-010 | Cross-System-Synthesis | MUST NOT start cross-system synthesis until every app in the active synthesis scope is `app-local-complete`, and MUST NOT infer that scope — it must be stated explicitly. |
| LDC-02-020 | Cross-System-Synthesis | MUST NOT use cross-system artifacts unless a finding, question, contract, proof need, or readiness judgment requires more than one app; route stable target-relevant findings to reference docs and leave legacy drift in legacy artifacts. |
| LDC-02-030 | Cross-System-Synthesis | MUST NOT flatten app-local evidence into cross-system narrative summaries when an app finding or source-map citation is enough. Cross-system synthesis is a second layer over app-local discovery: app-scoped artifacts keep local evidence close to the source app; cross-system findings synthesize boundary claims from multiple app artifacts; cross-system questions, parity rows, and readiness blockers trace back to those synthesized findings. |
| LDC-03-010 | Findings | Cross-system findings are synthesized claims, not app-local copies. They MUST cite the contributing app findings and source evidence they depend on, state the cross-app claim once, and carry only the boundary-specific synthesis needed for downstream contracts, questions, parity rows, or readiness judgments. |
| LDC-04-010 | Evidence-Precedence | SHOULD default to this order when app artifacts disagree: current runtime code/tests, then current checked-in contracts/source maps, then completed migration/audit/implementation notes, then historical docs/plans/agent guidance. |
| LDC-04-015 | Evidence-Precedence | This order deliberately differs from `DISCOVERING-LEGACY.md`'s app-local order (`LD-08-020`) for the same evidence classes: app-local precedence favors migration/audit docs over contract snapshots because they capture a single app's own reviewed decisions; cross-system precedence favors checked-in contracts over migration/audit docs because a contract is the structurally shared, verifiable interface between apps, while a migration/audit doc is authored by only one side and may not reflect the other app's actual behavior. A fact crossing from app-local evidence into cross-system synthesis MUST be re-evaluated under this cross-system order, not carried forward under its app-local ranking. |
| LDC-04-020 | Evidence-Precedence | MUST NOT treat a checked-in contract snapshot as current runtime behavior until it is compared against the producing app; mark stale or superseded evidence explicitly. |
| LDC-04-030 | Evidence-Precedence | MUST capture a three-way mismatch (contract snapshot vs. consumer adapter vs. producing runtime) in a cross-system finding first, then route the decision to the Questions registry (`CSQ-*`), the proof need to a `CSP-*` row, and any planning impact to `REWRITE-READINESS.md`. |
| LDC-05-010 | Slice | MUST treat cross-system slices as the durable unit of synthesis progress, tracked in `SUMMARY.md`'s Working Discovery Plan status table. |
| LDC-05-020 | Slice | MUST define enough cross-system slices to cover every inter-app boundary, contract, and shared concern in the active synthesis scope where material cross-app findings could exist; the apps and boundaries actually in scope — not `CROSS-SYSTEM-SUMMARY-template.md`'s example slice list — decide how many slices that requires and where their boundaries fall. |
| LDC-05-030 | Slice | Completed Slice Notes in `SUMMARY.md` MUST hold one entry per completed cross-system slice, recording the closeout outputs required by `LDC-06-010` through `LDC-06-050`. |
| LDC-06-010 | Slice-Closeout | MUST check each completed cross-system slice for material cross-app parity gaps — operational/observability surfaces, data-model/contract shape, provider-set shape, non-error runtime states, sub-area-local fidelity, and concrete cross-app defects that a broader cross-app summary would lose — and MUST write a new cross-system finding or update an existing one when present. |
| LDC-06-020 | Slice-Closeout | MUST review every new or updated cross-system finding's `## Candidate Artifacts` section before closing the slice, and MUST leave it empty only after confirming that no plausible downstream Use Case, Idea, Spec, or proof surface is clearly indicated by the evidence. |
| LDC-06-030 | Slice-Closeout | MUST run an explicit visible-behavior and scope/policy Question pass for the slice (release scope, configurability vs. fixed policy, visibility/warning behavior, acceptance/proof surface, operator/consumer priority) before marking it done, per `LD-04-050`/`060`. |
| LDC-06-040 | Slice-Closeout | MUST complete a fresh-context verification pass — a separate agent invocation receiving only the slice's recorded evidence, findings, Questions/parity rows, and checklist outputs — before marking a cross-system slice `done`, and MUST address any gap it finds before closing the slice. |
| LDC-06-050 | Slice-Closeout | MUST complete the Cross-System Slice Closeout Checklist before marking a cross-system slice `done`. |

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
9. Complete the Cross-System Slice Closeout Checklist (`LDC-06-050`).
10. Validate docs with `git diff --check`.
11. Commit only when the user explicitly asks.

## Slice Closeout Checklist

Before marking a cross-system slice `done`:

1. Confirm at least one finding, contract entry, or parity row records what the slice's cross-app area
   concretely establishes.
2. Check for cross-app parity gaps in operational/observability surfaces, data-model/contract shape, provider-set
   shape, and non-error runtime states.
3. Check whether any cross-app sub-area needs its own fidelity-preservation finding instead of only a broader
   cross-app summary.
4. Check whether any concrete cross-app defect or drift needs its own first-class finding.
5. Create or update any required finding, `CSQ-*`, or `CSP-*` row in the same pass.
6. Review `## Candidate Artifacts` for every new or updated cross-system finding.
7. Record the specific app source maps, findings, or contracts consulted, or explicitly record that none were
   relevant.
8. Record negative results for checked categories when no qualifying evidence or unresolved fork is found.
9. Record the concrete evidence basis for each check.
10. Record every material unresolved cross-app decision, and create or update a `CSQ-*` row for each one that is
    not merely hypothetical.
11. Run the explicit visible-behavior and scope/policy Question pass.
12. Complete a fresh-context verification pass for the slice.
13. Address any gap found by that verification pass before closing the slice.
14. Update `SUMMARY.md` before closing the slice.

## Evidence Precedence

See `LDC-04-010` for the default order, and `LDC-04-020`/`030` for stale-evidence marking and three-way
disagreements between a contract snapshot, consumer adapter, and producing runtime.
