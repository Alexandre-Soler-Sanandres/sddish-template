# Cross-System Discovery

## Purpose

Cross-system artifacts synthesize evidence that spans more than one legacy app. They are the output of
cross-system synthesis, not of app-local discovery.

## Entry Criteria

Cross-system synthesis may only start when:

- Every app in the active synthesis scope has `discovery_state: app-local-complete` in its source map.
- The active synthesis scope is defined explicitly (by the user or by a cross-system work artifact).

Do not start cross-system synthesis while any in-scope app is still at `app-discovery-active`.

## Citation Requirements

Every cross-system artifact must cite the app-scoped source maps and source evidence it synthesizes. Do not
copy app-local evidence directly into cross-system artifacts — reference it by path and artifact ID.

## Artifacts

| Artifact | Purpose |
| --- | --- |
| `SUMMARY.md` | High-level cross-system discovery summary |
| `CONTRACTS.md` | Inter-app API and data contracts |
| `FINDINGS.md` | Cross-system findings that require evidence from more than one app |
| `QUESTIONS.md` | Open questions that cannot be resolved from a single app's evidence |
| `PARITY-MATRIX.md` | Feature or behavior parity between legacy apps and the target |
| `REWRITE-READINESS.md` | Cross-system rewrite-readiness assessment |

Create artifacts only when evidence from app-local discovery makes them necessary. Empty placeholder files
should not be created speculatively.
