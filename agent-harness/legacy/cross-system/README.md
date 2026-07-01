# Cross-System Discovery

## Purpose

Cross-system artifacts synthesize evidence that spans more than one legacy app. They are the output of
cross-system synthesis, not of app-local discovery.

## Entry Criteria

Cross-system synthesis may only start when:

- Every app in the active synthesis scope has `discovery_state: app-local-complete` in its source map.
- The active synthesis scope is defined explicitly (by the user or by a cross-system work artifact).

Do not start cross-system synthesis while any in-scope app is still at `app-discovery-active`.

## Planning and Template

Start cross-system synthesis with `SUMMARY.md`.

Use `agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md` when creating it. The summary is the cross-system
restart point and working plan: it defines the active synthesis scope, confirms entry criteria, records slice order,
routes outputs to the other cross-system artifacts, and names the next action.

Create the other cross-system artifacts only when a slice produces evidence that needs them. Do not create empty
placeholder files speculatively.

## Citation Requirements

Every cross-system artifact must cite the app-scoped source maps and source evidence it synthesizes. Do not
copy app-local evidence directly into cross-system artifacts — reference it by path and artifact ID.

Cross-system findings are synthesized claims, not duplicates of app-local findings. Cite the app finding IDs and
source evidence that support the boundary claim, then let downstream artifacts cite that cross-system finding instead
of repeating the same narrative again.

## Artifacts

| Artifact | Purpose |
| --- | --- |
| `SUMMARY.md` | High-level cross-system discovery summary |
| `CONTRACTS.md` | Inter-app API and data contracts |
| `findings/active/<LF-ID>.md` | Cross-system findings that require evidence from more than one app |
| `QUESTIONS.md` | Open questions and target-product decisions that cannot be resolved from a single app's evidence |
| `PARITY-MATRIX.md` | Match/drift/proof tracking for feature or behavior parity between legacy apps and the target |
| `REWRITE-READINESS.md` | Cross-system rewrite-readiness assessment and planning blockers |

Create artifacts only when evidence from app-local discovery makes them necessary. Empty placeholder files
should not be created speculatively.

## Traceability Shape

Use cross-system artifacts as a chain, not as isolated notes:

1. app-scoped findings capture local evidence
2. cross-system findings synthesize cross-app claims
3. `QUESTIONS.md` records unresolved decisions raised by those claims
4. `PARITY-MATRIX.md` records matched behavior, drift, and executable proof needs
5. `REWRITE-READINESS.md` records what is stable enough for Use Cases/Specs and what still blocks planning

`CONTRACTS.md` sits alongside that chain and defines the inter-app boundary surface the other artifacts are talking
about.

`PARITY-MATRIX.md` owns the canonical proof/parity IDs. `REWRITE-READINESS.md` should reference those existing IDs
when it summarizes blockers, rather than creating a second readiness-specific ID namespace.

## Clarification Flow

After cross-system normalization, question clarification may be driven by the cross-system blocker set rather than by
strictly walking every app file first.

Recommended working method:

1. start from the highest-impact cross-system blocker or question
2. pull in app questions only when they are dependencies of that blocker or are resolved by the same decision
3. update all touched artifacts together: cross-system `QUESTIONS.md`, app `QUESTIONS.md`, linked findings, parity
   rows, and rewrite-readiness notes
4. after the cross-system blocker set is clarified, finish any remaining truly app-local questions

This keeps the broad architectural decisions in front while still preserving app-level traceability.
