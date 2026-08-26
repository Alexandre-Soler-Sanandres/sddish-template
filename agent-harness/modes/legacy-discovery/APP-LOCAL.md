# APP-LOCAL.md

## Purpose

App-Local Discovery: slicing a single legacy app and maintaining its `INVENTORY.md`, `SOURCE-MAP.md`,
`findings/`, and its rows in the unified Questions registry.

## Mode Story

For a newly-selected app, the agent creates `INVENTORY.md` and `SOURCE-MAP.md` together before reading any
evidence into a finding. It then works slice by slice: pick the smallest useful evidence set, inspect code then
docs then tests, classify evidence per `DISCOVERING-LEGACY.md`'s Core rules, update findings/Questions/
`SOURCE-MAP.md`, enrich stable reference docs, and run the Slice Closeout Checklist before marking the slice
`done`.

## Operating Posture

Slices are the durable unit of progress — a slice isn't done until findings and unresolved questions are
recorded (`LDA-03-040`), at least one finding describes what the area concretely contains (not only anomalies),
and the closeout checklist has run. `SOURCE-MAP.md` stays a restart pointer and status table, never a place to
restate generic process policy that already lives in this file.

## When To Use

Load this file when running App-Local Discovery — see the Discovery Phases table in
`agent-harness/modes/DISCOVERING-LEGACY.md`.

## Workflow Paths

App-specific discovery goes under:

```text
harness-data/artifacts/legacy/apps/<legacy-app-slug>/
  INVENTORY.md
  SOURCE-MAP.md
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
```

Questions raised during this app's discovery live in the harness-level Questions registry
(`harness-data/artifacts/questions/QUESTIONS-OPEN.md`/`QUESTIONS-RESOLVED.md`/`QUESTIONS-DISCARDED.md`), not a
per-app file.

## Core Moves

### Slice Roundtrip

1. Select the smallest useful evidence set from the source map.
2. Inspect code, then docs, then tests.
3. Classify evidence and conflicts using the Core rules in `agent-harness/modes/DISCOVERING-LEGACY.md`.
4. Update app `findings/` (add or merge into an `LF-<APP>-NNNN` file, looked up by ID), the unified Questions
   registry, and `SOURCE-MAP.md`. When a question is recorded, link it bidirectionally: cite the originating
   finding(s) in the registry's `Source` column, and add the question ID to each cited finding's
   `## Open Questions` section. Use `baseline` / `cross-cutting` in `Source` when the question does not trace to
   a specific finding. Before leaving any finding's `## Open Questions` empty, test its own `Classification` and
   `Evidence Conflict` text against `QST-06-010` — if it reads as an undecided fork, raise a `Q-<APP>-NNNN` row
   instead of leaving it as prose (`LDA-04-040`).
5. Enrich stable reference docs per the Reference Enrichment table in `agent-harness/modes/DISCOVERING-LEGACY.md`.
6. Before marking a slice `done`, confirm at least one of its findings is a plain baseline/descriptive finding —
   what the slice's area concretely contains or does — not only anomaly, conflict, or edge-case findings; write
   the missing baseline finding first if every finding so far is anomaly-shaped (`LDA-04-050`).
7. Complete the Slice Closeout Checklist (`LDA-06-060`).
8. Validate with `git diff --check`.
9. Commit only when explicitly asked.

### Slice Closeout Checklist

Before marking a slice `done`:

1. Confirm at least one finding records what the slice's area concretely contains or does.
2. Check `LDA-04-055`/`056`/`057`/`058`/`059` coverage for the slice.
3. Check whether any sub-area needs its own fidelity-preservation finding instead of only a broader family
   summary, including deployment posture, observability surface, hardening posture, and benchmark/evaluation
   policy sub-areas when evidenced in the slice.
4. Record a split-vs-enrich decision for each deployment, observability, hardening, and benchmark/evaluation
   sub-area evidenced in the slice.
5. Check whether any concrete runtime-correctness defect, stale-code conclusion, or dead/wired-but-inert
   behavior needs its own first-class finding.
6. Create or update any required finding or Question in the same pass.
7. Review `## Candidate Artifacts` for every new or updated finding, recording each clearly supported candidate
   and leaving the section empty only after a conscious negative check.
8. Record the specific docs consulted for the slice, or explicitly record that none were relevant.
9. Record negative results per `LDA-06-030`.
10. Record the evidence basis for each check per `LDA-06-040`.
11. Record every material unresolved target choice the slice leaves behind, and create or update a Question for
    each one that is not merely hypothetical.
12. Run an explicit visible-behavior and scope/policy Question pass for the slice: release scope,
    configurability versus fixed policy, visibility/warning behavior, acceptance/proof surface, and
    operator/consumer priority when relevant.
13. Complete a fresh-context verification pass for the slice.
14. Address any gap found by that verification pass before closing the slice.
15. Update `SOURCE-MAP.md` before closing the slice.

For this checklist, a fresh-context verification pass means a separate agent invocation that receives only the
slice's recorded evidence, findings/Questions, and checklist outputs needed to perform the verification.

## Routing

Not applicable at this level — App-Local Discovery routes findings to candidate artifacts per
`DISCOVERING-LEGACY.md`'s `## Routing`, and hands off to Cross-System Synthesis once every in-scope app reaches
`app-local-complete`.

## Outputs

- `harness-data/artifacts/legacy/apps/<legacy-app-slug>/INVENTORY.md`
- `harness-data/artifacts/legacy/apps/<legacy-app-slug>/SOURCE-MAP.md`
- `harness-data/artifacts/legacy/apps/<legacy-app-slug>/findings/active/<LF-ID>.md` (or `findings/archive/`)
- Rows in the unified Questions registry

## Examples

Slicing an app's authentication module: the agent reads the code, then any docs, then tests; writes a baseline
finding describing the current auth flow; writes a second finding flagging an undocumented session-timeout
behavior as a target-policy fork; raises a `Q-<APP>-NNNN` row for that fork; enriches `DOMAIN.md` with the stable
auth-concept vocabulary; and runs the Slice Closeout Checklist before marking the slice `done`.

## Rules Map

This submode's enforceable rules live in a grouped directory under
`agent-harness/rules/modes/legacy-discovery/APP-LOCAL/`:

| Group | File | Load when |
| --- | --- | --- |
| Inventory-and-Source-Map | `agent-harness/rules/modes/legacy-discovery/APP-LOCAL/INVENTORY-AND-SOURCE-MAP.md` | Creating or updating `INVENTORY.md`/`SOURCE-MAP.md`. |
| Slice | `agent-harness/rules/modes/legacy-discovery/APP-LOCAL/SLICE.md` | Defining or tracking slice status. |
| Slice-Roundtrip | `agent-harness/rules/modes/legacy-discovery/APP-LOCAL/SLICE-ROUNDTRIP.md` | Doing the roundtrip work inside a slice — evidence checks, candidate-artifact review, target-fork checks. |
| Blockwise | `agent-harness/rules/modes/legacy-discovery/APP-LOCAL/BLOCKWISE.md` | Grouping related slices into a block. |
| Slice-Closeout | `agent-harness/rules/modes/legacy-discovery/APP-LOCAL/SLICE-CLOSEOUT.md` | Closing out a slice before marking it `done`. |

If the relevant group is unclear, load every group in this table.

## Reference Files

Load per `agent-harness/modes/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
