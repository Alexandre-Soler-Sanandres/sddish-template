# DISCOVERING-LEGACY.md

## Purpose

Legacy Discovery extracts rewrite-quality evidence from existing systems. Legacy code is evidence, not authority.

## Mode Story

An imported legacy app moves through four phases: app-local discovery slices its code area by area; cross-system
synthesis (once every in-scope app is app-local-complete) reconciles boundary claims across apps; artifact
normalization tightens the accumulated artifacts without new source discovery; and question clarification
resolves, defers, discards, or proof-routes what's still open. Each phase has its own submode file with its own
paired rules — this file holds the boundaries, lifecycle, evidence-precedence, and reference-enrichment rules
that apply across all of them.

## Operating Posture

Evidence, not authority: legacy behavior is a fact to record, never an assumption of correctness (`LD-01-020`).
Inspect current code first, then docs, then tests (`LD-01-030`); distinguish observed behavior, documented
behavior, inferred intent, uncertainty, accidental complexity, dead code, stale notes, target-product decisions,
and proof needs, and never present inferred intent as observed (`LD-01-050`/`LD-01-060`). Discovery never writes
or modifies legacy source, and never implements new code (`LD-01-010`).

## When To Use

- CLI: `/legacy-discovery <path>`
- Natural language: explicit instruction to analyze a legacy codebase or imported project directory.

## Workflow Paths

| Phase | Entry gate | Work | Exit gate |
| --- | --- | --- | --- |
| App-local discovery | Imported app selected | Slice app evidence, update app `SOURCE-MAP.md`, `findings/`, the Questions registry, and stable reference docs. See `agent-harness/modes/legacy-discovery/APP-LOCAL.md`. | Source map reaches `app-local-complete`. |
| Cross-system synthesis | Active scope is explicit and all in-scope apps are `app-local-complete`. | Synthesize contracts, parity, questions, proof needs, and readiness across apps. See `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`. | Cross-system `SUMMARY.md` marks synthesis complete and names the restart point. |
| Artifact normalization | App-local and required cross-system discovery are complete. | Format, dedupe, order, and tighten existing artifacts without new source discovery. See `agent-harness/modes/legacy-discovery/NORMALIZATION.md`. | Restart pointer moves to question clarification. |
| Question clarification | Normalization is complete. | Resolve, defer, discard, or route open questions and proof needs. See `agent-harness/modes/legacy-discovery/CLARIFICATION.md`. | Downstream-work is unblocked once P0/migration-critical blockers are resolved, deferred, or proof-routed (see `CLARIFICATION.md`'s `LDG-04-100`), so the restart pointer may move to Use Cases or Specs. This does not mean Question Clarification is complete, and it does not make other open Questions irrelevant. See `CLARIFICATION.md`'s `LDG-04-120` and `CORE.md`'s `COR-01-120` for how remaining Questions stay tracked and referenced downstream. |

Before inventorying or reading files in a freshly imported legacy snapshot, load
`agent-harness/modes/legacy-discovery/IMPORT-HYGIENE.md` first, not after noticing something suspicious.

## Core Moves

### Discovery Lifecycle

Each app source map carries a `discovery_state` field distinct from artifact `status`.

| State | Meaning |
| --- | --- |
| `app-discovery-active` | App-local slices are still being discovered. |
| `app-local-complete` | App evidence is sufficient for app-local rewrite planning. |
| `rewrite-ready` | App evidence, cross-system synthesis, and target decisions are sufficient to begin rewrite design work. This is an unblock state, not a claim that every legacy question is closed. See `SOURCE-MAP-template.md`'s rewrite-ready note for what may still remain and under what conditions — this table intentionally does not restate it. |

### Evidence

Record evidence paths for every finding (`LD-01-040`), and capture the rewrite-facing conclusion when the
evidence clearly establishes one, not only the local implementation fact that produced it (`LD-01-110`) —
including material target decisions the evidence leaves unresolved, even latent forks recognized only through
engineering judgment (`LD-01-115`). Preserve app-local evidence inside app-scoped artifacts until cross-system
synthesis is in scope (`LD-01-090`), and validate docs with `git diff --check` and any additional Markdown
checks the repository defines (`LD-01-100`). Changing source-map workflow or status rules, and starting
cross-system synthesis, are additional high-impact actions under `CORE.md`'s `COR-05-010` checkpoint, on top of
the universal list in `COR-05-020` (`LD-01-120`).

### Evidence Precedence

When sources conflict, apply this default order and record deviations (`LD-08-020`):

1. Current runtime code and tests.
2. Completed migration or audit docs.
3. Checked-in contract snapshots.
4. Historical docs, README snippets, and agent rules.
5. Stale setup or deployment docs.

See `CROSS-SYSTEM.md`'s `LDC-04-010`/`LDC-04-015` for why cross-system synthesis deliberately uses a different
order for the same evidence classes once a fact crosses an app boundary. Every finding states whether it is based
on observed behavior, documented behavior, or inference, and records which source was treated as authoritative
when evidence conflicts (`LD-08-010`).

### Reference Enrichment

Enrich reference docs when evidence is stable — from App-Local Discovery, Cross-System Synthesis, or Question
Clarification:

| Finding type | Target reference doc |
| --- | --- |
| Architecture boundaries, layer contracts | `ARCHITECTURE.md` |
| Domain concepts, rules, terminology | `DOMAIN.md` |
| Tools, commands, CI, test setup | `TOOLING.md` |
| Quality standards, test coverage, hygiene | `QUALITY.md` |

Write enrichment under that doc's `## Discovered` heading, citing the specific `LF-*` ID (`LD-09-020`). This is a
transcription of stable evidence, not a target decision — target decisions land under that doc's separate
`## Decisions` heading instead, per `agent-harness/docs/03-artifacts.md`'s Reference File Structure convention.
Never enrich with unresolved, uncertain, cross-system-before-synthesis, or speculative findings (`LD-09-010`);
before closing out a slice, check every `bug`-tagged finding from that slice against this routing table and
confirm it was written into at least one reference doc's `## Discovered` section (`LD-09-030`).

## Routing

Never draft a Use Case directly — once a Legacy Finding is strong enough to warrant one, flag it and route to
Refining (`/create-use-case`) instead (`LD-01-070`/`LD-02-030`); Specs may be drafted directly only when the
evidence is unambiguous and strong (`LD-01-080`), and even then are only ever a *candidate* output alongside
Harness Improvement candidates (`LD-02-010`). A finding may also produce a candidate Idea when it states a
future/roadmap direction rather than an unresolved fork, per `CORE.md`'s `COR-01-110` test (`LD-02-020`) — note
it in the originating finding's `## Candidate Artifacts` (`LD-02-021`) and check existing `active` Ideas for
overlap first (`LD-02-022`). Prefer candidate Use Cases or Ideas before direct candidate Specs when a finding
primarily shapes behavior, actor workflow, or future direction (`LD-02-025`); a direct candidate Spec should be
named only when the evidence already defines a concrete standalone technical contract, proof surface, or
implementation-shaping constraint (`LD-02-026`).

## Outputs

- App-scoped: `harness-data/artifacts/legacy/apps/<legacy-app-slug>/` — `INVENTORY.md`, `SOURCE-MAP.md`,
  `findings/`.
- Cross-system: `harness-data/artifacts/legacy/cross-system/` — `SUMMARY.md`, `CONTRACTS.md`, `findings/`,
  `REWRITE-READINESS.md`.
- Questions registry rows (`Q-<APP>-NNN`, `CSQ-NNN`, `CSP-*`) in `harness-data/artifacts/questions/`.
- Candidate Use Cases, Ideas, direct Specs, and Harness Improvements, routed rather than drafted here except
  where `LD-01-080`/`LD-02-010` permit a direct Spec.

## Examples

A slice through a legacy billing module finds an undocumented retry policy. The agent records it as a finding
with evidence paths, marks it `inferred` rather than `observed` where the retry count isn't tested, checks
whether it's a `bug`-tagged defect or a target-policy fork, raises a Question if the target behavior is
unresolved, and enriches `QUALITY.md`'s `## Discovered` section only once the finding is stable.

## Rules Map

This mode's enforceable rules live in a grouped directory under `agent-harness/rules/modes/DISCOVERING-LEGACY/`,
split by phase:

| Group | File | Load when |
| --- | --- | --- |
| Core | `agent-harness/rules/modes/DISCOVERING-LEGACY/CORE.md` | Always with this file — boundaries, evidence discipline, and high-impact-action scope. |
| Routing | `agent-harness/rules/modes/DISCOVERING-LEGACY/ROUTING.md` | Deciding whether a finding should route to a candidate Use Case, Idea, Spec, or Harness Improvement. |
| Findings | `agent-harness/rules/modes/DISCOVERING-LEGACY/FINDINGS.md` | Creating, updating, moving, or tagging any `LF-*` finding. |
| Questions | `agent-harness/rules/modes/DISCOVERING-LEGACY/QUESTIONS.md` | Raising, deduping, or linking a Questions-registry row from discovery. |
| Completion-and-Proof | `agent-harness/rules/modes/DISCOVERING-LEGACY/COMPLETION-AND-PROOF.md` | Judging `app-local-complete` readiness or setting `proof_needed`. |
| Evidence-and-Reference | `agent-harness/rules/modes/DISCOVERING-LEGACY/EVIDENCE-AND-REFERENCE.md` | Applying evidence precedence or writing reference-doc enrichment. |

If the relevant group is unclear, load every group in this table. Also load the active submode's own Rules Map
(`APP-LOCAL.md`, `CROSS-SYSTEM.md`, `NORMALIZATION.md`, `CLARIFICATION.md`, or `IMPORT-HYGIENE.md`) per
`## Workflow Paths` above.

## Reference Files

Load these when directly relevant — do not load all of them by default:

| File | Load when |
| --- | --- |
| `harness-data/reference/DOMAIN.md` | Extracting domain concepts, rules, actors, workflows, or terminology. |
| `harness-data/reference/ARCHITECTURE.md` | Mapping legacy structure, boundaries, ownership, or runtime topology. |
| `harness-data/reference/TOOLING.md` | Recording commands, local services, validation checks, CI, or tooling. |
| `harness-data/reference/QUALITY.md` | Recording quality gates, proof standards, coverage, or hygiene rules. |
