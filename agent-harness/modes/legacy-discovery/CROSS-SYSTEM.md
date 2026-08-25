# CROSS-SYSTEM.md

## Purpose

Cross-System Synthesis: synthesizing boundary claims, contracts, parity, and readiness across apps that are all
`app-local-complete`.

## Mode Story

Once every app in an explicitly-stated synthesis scope is `app-local-complete`, the agent starts
`SUMMARY.md` from its template, works cross-system slices that each synthesize a boundary claim from more than
one app's evidence, and records findings, parity/proof rows, and readiness blockers by citation back to the
app-local artifacts they depend on — never by flattening app-local evidence into narrative.

## Operating Posture

Second layer over app-local discovery, not a duplicate of it: app-scoped artifacts keep local evidence close to
the source app; cross-system findings synthesize boundary claims from multiple app artifacts; cross-system
questions, parity rows, and readiness blockers trace back to those synthesized findings (`LDC-02-030`). Never
infer the active synthesis scope — it must be stated explicitly (`LDC-02-011`), and synthesis never starts until
every app in that scope is `app-local-complete` (`LDC-02-010`).

## When To Use

Load this file when running Cross-System Synthesis — see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`.

## Workflow Paths

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
per-cross-system files. Use the cross-system artifacts for distinct jobs:

| Artifact | Job |
| --- | --- |
| `SUMMARY.md` | Defines the active synthesis scope, confirms entry criteria, records slice order, routes outputs, names the restart action. |
| `CONTRACTS.md` | Defines the inter-app boundaries: API, data, auth, health, observability, deployment, and ownership contracts. |
| `findings/` | Stores synthesized cross-app claims that require evidence from more than one app. |
| Questions registry (`CSQ-*` rows) | Captures unresolved cross-app or target-product decisions raised by those synthesized findings. |
| Questions registry (`CSP-*` rows) | Records where producer and consumer behavior matched, drifted, or still needs executable proof. |
| `REWRITE-READINESS.md` | States what is stable enough for Use Cases and Specs, and what blockers or proof items still prevent implementation planning. |

## Core Moves

### Slice Roundtrip

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

### Slice Closeout Checklist

Before marking a cross-system slice `done`:

1. Confirm at least one finding, contract entry, or parity row records what the slice's cross-app area
   concretely establishes.
2. Check for cross-app parity gaps in operational/observability surfaces, data-model/contract shape,
   provider-set shape, and non-error runtime states.
3. Check whether any cross-app sub-area needs its own fidelity-preservation finding instead of only a broader
   cross-app summary.
4. Record a split-vs-enrich decision per `LDC-06-055`.
5. Check whether any concrete cross-app defect or drift needs its own first-class finding.
6. Create or update any required finding, `CSQ-*`, or `CSP-*` row in the same pass.
7. Review `## Candidate Artifacts` for every new or updated cross-system finding.
8. Record the specific app source maps, findings, or contracts consulted, or explicitly record that none were
   relevant.
9. Record negative results for checked categories when no qualifying evidence or unresolved fork is found.
10. Record the concrete evidence basis for each check.
11. Record every material unresolved cross-app decision, and create or update a `CSQ-*` row for each one that is
    not merely hypothetical.
12. Run the explicit visible-behavior and scope/policy Question pass.
13. Complete a fresh-context verification pass for the slice.
14. Address any gap found by that verification pass before closing the slice.
15. Update `SUMMARY.md` before closing the slice.

### Evidence Precedence

See `LDC-04-010` for the default order, and `LDC-04-020`/`030` for stale-evidence marking and three-way
disagreements between a contract snapshot, consumer adapter, and producing runtime. This order deliberately
differs from `DISCOVERING-LEGACY.md`'s app-local order (`LD-08-020`) for the same evidence classes: app-local
precedence favors migration/audit docs over contract snapshots because they capture a single app's own reviewed
decisions; cross-system precedence favors checked-in contracts over migration/audit docs because a contract is
the structurally shared, verifiable interface between apps, while a migration/audit doc is authored by only one
side and may not reflect the other app's actual behavior. A fact crossing from app-local evidence into
cross-system synthesis must be re-evaluated under this cross-system order, not carried forward under its
app-local ranking (`LDC-04-015`).

## Routing

Cross-system artifacts are connected, not independent: findings feed `CONTRACTS.md`, the Questions registry, and
`REWRITE-READINESS.md` by citation, and parity rows/readiness blockers point back to the finding and proof/
question IDs they depend on (`LDC-01-030`/`LDC-01-031`). Do not use cross-system artifacts at all unless a
finding, question, contract, proof need, or readiness judgment actually requires more than one app — route
stable target-relevant findings to reference docs and leave legacy drift in legacy artifacts otherwise
(`LDC-02-020`).

## Outputs

- `harness-data/artifacts/legacy/cross-system/SUMMARY.md`
- `harness-data/artifacts/legacy/cross-system/CONTRACTS.md`
- `harness-data/artifacts/legacy/cross-system/findings/active/<LF-ID>.md` (or `findings/archive/`)
- `harness-data/artifacts/legacy/cross-system/REWRITE-READINESS.md`
- `CSQ-*`/`CSP-*` rows in the unified Questions registry

## Examples

Two apps both expose a `/health` endpoint with different semantics. The agent records a cross-system finding
citing both apps' app-local findings, raises a `CSQ-*` row for which semantics the target system should adopt,
and links a `CSP-*` row noting the parity gap still needs executable proof.

## Rules Map

This submode's enforceable rules live in a grouped directory under
`agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/`:

| Group | File | Load when |
| --- | --- | --- |
| Artifacts-and-Scope | `agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/ARTIFACTS-AND-SCOPE.md` | Creating/updating cross-system artifacts, or judging synthesis entry/exit scope. |
| Findings | `agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/FINDINGS.md` | Writing a cross-system finding. |
| Evidence-Precedence | `agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/EVIDENCE-PRECEDENCE.md` | Resolving conflicting evidence across apps. |
| Slice | `agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/SLICE.md` | Defining or tracking cross-system slice status. |
| Slice-Closeout | `agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/SLICE-CLOSEOUT.md` | Closing out a cross-system slice before marking it `done`. |
| Blockwise | `agent-harness/rules/modes/legacy-discovery/CROSS-SYSTEM/BLOCKWISE.md` | Grouping related cross-system slices into a block. |

If the relevant group is unclear, load every group in this table.

## Reference Files

Load per `agent-harness/modes/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
