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
`agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`.

## Workflow Paths

App-specific discovery goes under:

```text
harness-data/extensions/legacy-discovery/apps/<legacy-app-slug>/
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
3. Classify evidence and conflicts using the Core rules in `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`.
4. Update app `findings/` (add or merge into an `LF-<APP>-NNNN` file, looked up by ID), the unified Questions
   registry, and `SOURCE-MAP.md`. When a question is recorded, link it bidirectionally: cite the originating
   finding(s) in the registry's `Source` column, and add the question ID to each cited finding's
   `## Open Questions` section. Use `baseline` / `cross-cutting` in `Source` when the question does not trace to
   a specific finding. Before leaving any finding's `## Open Questions` empty, test its own `Classification` and
   `Evidence Conflict` text against `QST-06-010` — if it reads as an undecided fork, raise a `Q-<APP>-NNNN` row
   instead of leaving it as prose (`LDA-04-040`).
5. Enrich stable reference docs per the Reference Enrichment table in `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`.
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

- `harness-data/extensions/legacy-discovery/apps/<legacy-app-slug>/INVENTORY.md`
- `harness-data/extensions/legacy-discovery/apps/<legacy-app-slug>/SOURCE-MAP.md`
- `harness-data/extensions/legacy-discovery/apps/<legacy-app-slug>/findings/active/<LF-ID>.md` (or `findings/archive/`)
- Rows in the unified Questions registry

## Examples

Slicing an app's authentication module: the agent reads the code, then any docs, then tests; writes a baseline
finding describing the current auth flow; writes a second finding flagging an undocumented session-timeout
behavior as a target-policy fork; raises a `Q-<APP>-NNNN` row for that fork; enriches `DOMAIN.md` with the stable
auth-concept vocabulary; and runs the Slice Closeout Checklist before marking the slice `done`.

## Rules

| ID | Rule |
| --- | --- |
| LDA-01-010 | App `INVENTORY.md` MUST use `agent-harness/extensions/legacy-discovery/templates/INVENTORY-template.md`: fixed `Scope`, `Identity`, `Major Runtime Areas`, `Operations, Tooling, and Quality`, and `Inventory Gaps` sections, plus as many app-specific structural sections as the app's own shape needs in between. |
| LDA-01-020 | MUST name app-specific sections after what they actually cover in this app, not copy another app's section names. |
| LDA-01-030 | MUST create `INVENTORY.md` and `SOURCE-MAP.md` together for a newly-selected app, before reading evidence into any `LF-<APP>-NNNN.md` finding for that app. |
| LDA-02-010 | Each app `SOURCE-MAP.md` (the app restart point, per `SOURCE-MAP-template.md`) MUST stay app-local, containing only: source root, primary evidence files, code areas, and candidate discovery slices; block list/status when blockwise; slice status table, completed notes, open app notes, restart pointers, and reference enrichment routing; deferred/cross-system Question ID references (per `COR-01-120` — classification itself lives only in the Questions registry, never duplicated here) before `app-local-complete`; import hygiene when the snapshot has secret-like files, local artifacts, or nested repo metadata. |
| LDA-02-016 | At creation time (`LDA-01-030`), `SOURCE-MAP.md` MUST have `Source Root` filled in and a `Slice 0: Baseline inventory and import hygiene` row present in `Candidate Discovery Slices` (or `Current Status`, once slice work starts) with status `pending` or `next`. This is a minimum-at-creation floor, distinct from `LDA-02-010`'s ceiling on total allowed content once discovery is underway — `LDA-02-010` still governs what the file may contain as discovery proceeds; this rule only governs what must already be true at `t=0`. This fixed bootstrap slice name is a deliberate exception to `LDA-03-020`'s app-discretionary slice list, not a precedent for copying other slice names. |
| LDA-02-020 | MUST NOT copy generic slice rules, block rules, roundtrip steps, cross-system judgments, or reusable process policy into app source maps. |
| LDA-03-010 | MUST treat slices as the durable unit of discovery progress. |
| LDA-03-020 | MUST define enough slices to cover every area of the app where material findings could exist; the app's own shape, not a fixed count or another app's slice list, decides how many slices that requires and where their boundaries fall. |
| LDA-03-030 | Every slice MUST have status `done`, `next`, `pending`, or `not-needed`. |
| LDA-03-040 | MUST NOT mark a slice `done` until findings and unresolved questions are recorded. |
| LDA-03-050 | Completed slice notes (`Completed Notes` in the source map) MUST hold evidence paths, stable findings, unresolved decisions, and required slice-closeout records only. |
| LDA-04-010 | Reference enrichment MAY be deferred across blockwise work only when the source map says so. |
| LDA-04-020 | MUST review every new or updated finding for downstream artifact candidates before closing the slice. |
| LDA-04-021 | MUST record each clearly supported candidate found per `LDA-04-020` in that finding's `## Candidate Artifacts` section at authoring time. |
| LDA-04-025 | MUST leave a finding's `## Candidate Artifacts` section empty only after checking that no plausible downstream Use Case, Idea, Spec, proof surface, or other durable follow-on artifact is clearly indicated by the evidence. |
| LDA-04-030 | MUST NOT invent a new per-slice `"Candidate <Something>"` list in `SOURCE-MAP.md`'s slice notes under any label; that is the same duplication. When a candidate spans multiple findings from the same slice, record it in each contributing finding's `Candidate Artifacts`, not as a new shared list. |
| LDA-04-035 | SHOULD use a finding's `## Candidate Artifacts` section to note meaningful cross-finding impact when that traceability will materially help later synthesis or prioritization. Record each such note as a flat bullet in the form `- Affects: <LF-ID> — <short reason>`. Frontmatter `candidate_artifacts` remains for artifact IDs only. |
| LDA-04-040 | MUST test each finding for a material unresolved target choice before leaving its `## Open Questions` empty, not only its own `Classification`/`Evidence Conflict` prose. |
| LDA-04-041 | If `LDA-04-040`'s test finds a fork that satisfies `QST-06-010` and `QST-06-020`, whether explicit or latent after applying engineering judgment, MUST raise or update a `Q-<APP>-NNNN` registry row instead of leaving the fork only as prose in the finding. |
| LDA-04-050 | MUST NOT mark a slice `done` until at least one finding records what the slice's area concretely contains or does, independent of anomaly, conflict, or edge-case behavior. |
| LDA-04-055 | MUST check each completed slice for material operational or manual surfaces in scope — including CLI/operator tools, health/readiness/metrics surfaces, SQL diagnostics, or comparable observability paths. |
| LDA-04-056 | MUST check each completed slice for material data-model shape choices in scope — including storage topology, JSON-vs-typed structure, DB views as read models, key typing, or migration-authority boundaries. |
| LDA-04-057 | MUST check each completed slice for material provider-set shape in scope — including primary, fallback, overlapping, deferred, or disabled-but-wired providers. |
| LDA-04-058 | MUST check each completed slice for material non-error runtime states in scope — including warmup, degraded-but-expected, or long-running intermediate states. |
| LDA-04-059 | MUST check each completed slice for target-design forks implied by the evidence — including `preserve-vs-adapt`, `scope-v1`, `fidelity`, `naming`, and `deferred-feature` forks, plus visible-behavior questions, release-scope questions, configurability-vs-fixed-policy questions, deployment/runtime-policy questions, quality/acceptance-surface questions, and operator- or consumer-priority questions when the current evidence establishes the surface but not the target decision. |
| LDA-04-060 | Reference enrichment MUST be complete before `app-local-complete`. |
| LDA-04-062 | MUST check each completed slice for unresolved release, deployment, observability, benchmark, documentation-surface, and acceptance-policy forks established by in-scope deployment files, checked-in contracts, or historical docs. |
| LDA-04-065 | MUST check each completed slice for sub-area-local fidelity that would be lost if the slice were represented only by a broader family summary. |
| LDA-04-066 | MUST check each completed slice for concrete runtime-correctness defects, stale-code conclusions, or dead/wired-but-inert behavior that deserves first-class preservation. |
| LDA-04-070 | MUST NOT treat the baseline-finding requirement alone as sufficient when a slice also clearly establishes rewrite-facing conclusions, operational/manual surfaces, data-model shape, provider-set shape, non-error runtime states, sub-area-local fidelity worth preserving separately, concrete defect-shaped evidence worth preserving separately, or target-design forks; those evidence classes still need their own finding or Question coverage in the same pass. |
| LDA-04-071 | MUST use engineering judgment to identify materially unresolved forks per `LDA-04-059` even when no direct artifact conflict states them. |
| LDA-04-072 | MUST write a new finding or update an existing finding when `LDA-04-055`/`056`/`057`/`058` finds a qualifying surface present. |
| LDA-04-073 | MUST create a new Question or update an existing Question when `LDA-04-059` finds a qualifying fork present. |
| LDA-04-074 | MUST create a new Question or update an existing Question when `LDA-04-062` finds a qualifying fork present. |
| LDA-04-075 | MUST write a new finding or update an existing finding when `LDA-04-065` finds such a sub-area present. |
| LDA-04-076 | MUST write a new finding or update an existing finding when `LDA-04-066` finds such evidence present. |
| LDA-05-010 | Blocks are a planning convenience for related slices with overlapping evidence, not a replacement for slices — MUST mark each included slice individually in the slice status table. |
| LDA-05-020 | MUST use a block only when the grouped slices share a focused evidence set. |
| LDA-05-030 | MUST keep blocks app-scoped. |
| LDA-05-040 | MUST write one completed block note listing included slices, evidence paths, stable findings, and unresolved decisions. |
| LDA-05-050 | MUST set the next unfinished slice or coherent block to `next` after a block completes. |
| LDA-06-010 | MUST record a listing of the app root's contents and of every package directory a slice's scope references before treating that scope as fully known. |
| LDA-06-020 | MUST name the specific docs consulted for each completed slice, or explicitly record that no relevant docs were found for that slice's scope. |
| LDA-06-030 | MUST record a negative result for each checked `LDA-04-055`/`056`/`057`/`058`/`059` category when no qualifying evidence is found. |
| LDA-06-040 | MUST record the concrete evidence basis for each `LDA-04-055`/`056`/`057`/`058`/`059` check. |
| LDA-06-045 | MUST record a split-vs-enrich decision for each deployment, observability, hardening, and benchmark/evaluation sub-area evidenced in the slice before marking the slice `done`. |
| LDA-06-050 | MUST complete a fresh-context verification pass before marking a slice `done`. |
| LDA-06-055 | MUST address any gap found by the fresh-context verification pass before marking a slice `done`. |
| LDA-06-060 | MUST complete the Slice Closeout Checklist before marking a slice `done`. |

## Reference Files

Load per `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
