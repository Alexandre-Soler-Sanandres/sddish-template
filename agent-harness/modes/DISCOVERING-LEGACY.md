# DISCOVERING-LEGACY.md

## Purpose

Legacy Discovery extracts rewrite-quality evidence from existing systems. Legacy code is evidence, not authority.

## Mode Story

An imported legacy app moves through four phases: app-local discovery slices its code area by area; cross-system
synthesis (once every in-scope app is app-local-complete) reconciles boundary claims across apps; artifact
normalization tightens the accumulated artifacts without new source discovery; and question clarification
resolves, defers, discards, or proof-routes what's still open. Each phase has its own submode file with its own
`## Rules` section — this file holds the boundaries, lifecycle, evidence-precedence, and reference-enrichment
rules that apply across all of them.

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
- Questions registry rows (`Q-<APP>-NNNN`, `CSQ-NNNN`, `CSP-NNNN`) in `harness-data/artifacts/questions/`.
- Candidate Use Cases, Ideas, direct Specs, and Harness Improvements, routed rather than drafted here except
  where `LD-01-080`/`LD-02-010` permit a direct Spec.

## Examples

A slice through a legacy billing module finds an undocumented retry policy. The agent records it as a finding
with evidence paths, marks it `inferred` rather than `observed` where the retry count isn't tested, checks
whether it's a `bug`-tagged defect or a target-policy fork, raises a Question if the target behavior is
unresolved, and enriches `QUALITY.md`'s `## Discovered` section only once the finding is stable.

## Rules

| ID | Rule |
| --- | --- |
| LD-01-010 | MUST NOT modify legacy source code or implement new code. |
| LD-01-020 | MUST NOT treat legacy behavior as automatically correct target behavior. |
| LD-01-030 | MUST inspect current code first, then docs, then tests. |
| LD-01-040 | MUST record evidence paths for every finding. |
| LD-01-050 | MUST distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, dead code, stale notes, target-product decisions, and proof needs. |
| LD-01-060 | MUST NOT present inferred intent as observed behavior — mark it clearly as inferred instead. |
| LD-01-070 | MUST NOT draft a Use Case directly — once a Legacy Finding is strong enough to warrant one, flag it and route to Refining (`/create-use-case`) instead (see `LD-02-010`); Specs may still be drafted directly only per `LD-01-080`'s exception. |
| LD-01-080 | MUST NOT create Specs directly without a Use Case unless the evidence is unambiguous and strong. |
| LD-01-090 | MUST preserve app-local evidence inside app-scoped artifacts until cross-system synthesis is in scope. |
| LD-01-100 | MUST validate docs with `git diff --check` and any additional Markdown checks the repository defines. |
| LD-01-110 | MUST capture the rewrite-facing conclusion when the evidence clearly establishes one, not only the local implementation fact that produced it. |
| LD-01-115 | MUST capture not only factual legacy behavior but also any material target decisions the evidence leaves unresolved, including latent forks recognized through engineering judgment, not only direct source conflict. |
| LD-01-120 | MUST treat changing source-map workflow or status rules, and starting cross-system synthesis, as additional high-impact actions under `COR-05-010`'s checkpoint, on top of the universal list in `COR-05-020`. |
| LD-02-010 | MAY include, as other outputs, a candidate `harness-data/artifacts/specs/active/SPEC-*.md` (per `LD-01-080`'s exception) and Harness Improvement candidates. |
| LD-02-020 | A Legacy Finding's evidence MAY produce a candidate `harness-data/artifacts/ideas/active/IDEA-*.md` when it states a future/roadmap direction rather than an unresolved fork — apply `COR-01-110`'s test. Ideas spun off from a *resolved* Question are governed by `QUESTIONS.md`'s `QST-07-020-v1` instead. |
| LD-02-021 | MUST note a `LD-02-020` candidate Idea in the originating finding's `## Candidate Artifacts`. |
| LD-02-022 | Before creating a new Idea per `LD-02-020`, MUST check existing `active` Ideas for overlap (`IDA-02-010`) and apply `IDA-01-020`'s atomicity rule — one Idea per opportunity, not one per source document. |
| LD-02-025 | SHOULD prefer candidate Use Cases or Ideas before direct candidate Specs when a finding primarily shapes behavior, actor workflow, or future direction. |
| LD-02-026 | A direct candidate Spec SHOULD be named only when the evidence already defines a concrete standalone technical contract, proof surface, or implementation-shaping constraint that is not merely downstream of an expected Use Case or Idea. |
| LD-02-030 | MUST NOT draft a Use Case in Legacy Discovery — once a Legacy Finding is strong enough (`LD-01-070`), route to Refining (`/create-use-case`) to create the `UC-*.md`. |
| LD-03-010 | MUST store each finding as its own file, using `agent-harness/templates/LEGACY-FINDING-template.md` as-is: `harness-data/artifacts/legacy/apps/<app-slug>/findings/active/<LF-ID>.md` for app-scoped findings, `harness-data/artifacts/legacy/cross-system/findings/active/<LF-ID>.md` for cross-system findings. |
| LD-03-020 | MUST follow the existing `LF-<APP>-NNNN` convention for IDs, numbered once per app (or `LF-CROSS-NNNN` for cross-system). |
| LD-03-021 | An `LF-*` ID MUST NOT be reused, even after a finding moves or is merged. |
| LD-03-030 | MUST move a finding to the matching `findings/archive/<LF-ID>.md` path when its `status` becomes `converted`, `archived`, or `rejected`; findings with `status: draft` or `status: reviewed` stay in `findings/active/`. |
| LD-03-040 | MUST NOT look up or add a finding except by ID — scan `findings/active/` and `findings/archive/` file names or frontmatter, not by reading through file append order or by creating slice-numbered or subsystem-named headings as a substitute for the ID. |
| LD-03-050 | MUST tag a finding `bug` in its `tags` frontmatter when it documents a confirmed defect (wrong runtime, dashboard, or metrics behavior) or dead/wired-but-inert code, as distinct from an unresolved fork (`Q-*`/`CSQ-*`) or future-facing intent (`IDEA-*`). This tag exists so bug-shaped findings stay discoverable across an app's full finding set, not to create a new artifact type or lifecycle. |
| LD-03-055 | MUST preserve a concrete runtime-correctness defect, stale-code conclusion, or dead/wired-but-inert behavior as its own first-class finding when the evidence establishes it, even if a broader subsystem finding covering the same area also exists. |
| LD-03-060 | MUST treat operational or manual surfaces as first-class findings when they materially define current runtime trust, operator workflow, or observability — including CLI/operator tools, health/readiness/metrics surfaces, SQL diagnostics, and other human-run inspection paths. |
| LD-03-070 | MUST record material data-model shape choices when evidence establishes them, even without a defect — including storage topology, typed-vs-JSON structure, DB views as read models, key typing, and authority boundaries between ORM metadata and migrations. |
| LD-03-080 | MUST capture non-error runtime states when they materially affect operator understanding, rewrite fidelity, or target behavior — for example warmup periods, degraded-but-expected modes, or long-running intermediate states. |
| LD-03-085 | MUST preserve a sub-area as its own finding when its contract shape, fetch/execution pattern, fallback strategy, interaction model, dependency timing, state model, or cost profile would materially affect rewrite fidelity if collapsed into a broader family summary. |
| LD-03-087 | MUST preserve a sub-area as its own finding when collapsing it into a broader family summary would hide a materially different deployment posture, hardening posture, operator visibility surface, or benchmark/evaluation policy surface. |
| LD-03-088 | MUST preserve a log-only visibility surface or deployment-file omission as its own first-class finding when in-scope deployment files or runtime evidence establish that it materially affects operator trust, observability expectations, readiness semantics, hardening posture, or rewrite fidelity. |
| LD-03-090 | MUST capture app-internal architectural boundaries when the evidence clearly establishes a cross-layer or cross-subsystem contract inside one app, not only the files or functions on each side. |
| LD-03-100 | MUST record provider-set shape when a capability depends on providers and the evidence makes the portfolio materially relevant — including primary, fallback, overlapping, deferred, or disabled-but-wired providers. |
| LD-04-010 | MUST use `Q-<APP>-NNNN` (app-scoped) or `CSQ-NNNN` (cross-system) IDs for Legacy Discovery questions (they live in the harness-level Questions registry — `QUESTIONS-OPEN`/`RESOLVED`/`DISCARDED.md`, schema in `agent-harness/artifact-specs/QUESTIONS.md` — not per-app files, and not organized by discovery slice, subsystem, or process block), fold `Decision type` (`scope-v1` \| `preserve-vs-adapt` \| `fidelity` \| `naming` \| `deferred-feature`) into `Notes`, and follow the registry's own classification (`QST-01-010-v1`) and status (`QST-03-010-v1`) rules. |
| LD-04-020 | MUST check existing registry rows for the same decision by content and merge instead of duplicating, before adding a question. |
| LD-04-030 | MUST link every question back to the finding(s) that raised it through the registry's `Source` column. |
| LD-04-040 | SHOULD default cross-system questions' `Source` to `LF-CROSS-NNNN`, adding app finding IDs in `Notes` only when the extra traceability matters; provenance like slice name or artifact of origin belongs in `Notes`, not the table structure. |
| LD-04-050 | MUST emit a Question when a finding establishes concrete visible behavior — including silent failure, degraded visibility, startup/config error handling, warning/notification behavior, or comparable consumer-visible runtime behavior — and the target preserve/adapt policy remains unresolved. |
| LD-04-060 | MUST treat unresolved release-scope, configurability, deployment/runtime policy, quality/acceptance-surface, accessibility/operability, design-system policy, and comparable target-policy decisions as rewrite Questions when discovery establishes the current surface but not the target policy. Use the in-scope Question home and ID scheme for the current discovery context. |
| LD-05-010 | MAY move to `app-local-complete` when: all planned slices are `done`, `not-needed`, or explicitly deferred; every open Question referenced from this app (per `COR-01-120`) has a `QST-01-010-v1` Classification recorded in the canonical Questions registry — not a local copy in the source map; stable findings have been propagated to reference docs where appropriate; and no remaining slice is needed for app-local rewrite planning. |
| LD-06-010 | MUST set `proof_needed` to `true` when discovery found drift or runtime behavior needing executable proof before rewrite planning treats it as stable; to `false` when no required executable proof is known, or required proof is complete. |
| LD-06-030 | MAY reach `app-local-complete` with `proof_needed: true`. Rewrite-ready means the remaining proof obligations are explicit and can be carried forward into Use Cases, Specs, validation, or later implementation work without making the rewrite design incoherent. |
| LD-08-010 | Every finding MUST state whether it is based on observed behavior, documented behavior, or inference, and record which source was treated as authoritative when evidence conflicts. |
| LD-08-020 | SHOULD default to the order given in `DISCOVERING-LEGACY.md`'s `### Evidence Precedence` when sources conflict, and record any deviation and why. |
| LD-09-010 | MUST NOT enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings. |
| LD-09-020 | MUST NOT write target-decision language into `## Discovered` — write reference-doc enrichment there from findings, citing the specific `LF-*` ID; a settled target decision belongs under `## Decisions` instead, added when the decision is actually made (via Question Clarification outcome or a later ADR), not during Legacy Discovery itself. |
| LD-09-030 | Before closing out a slice, MUST check every `bug`-tagged finding from that slice against `DISCOVERING-LEGACY.md`'s `### Reference Enrichment` routing table and confirm it was written into at least one reference doc's `## Discovered` section. The tag flags a finding for this check; the finding's actual content still decides which doc(s) it belongs in per the routing table — a `bug` tag does not mean it must go in `QUALITY.md` specifically. |

## Reference Files

Load these when directly relevant — do not load all of them by default:

| File | Load when |
| --- | --- |
| `harness-data/reference/DOMAIN.md` | Extracting domain concepts, rules, actors, workflows, or terminology. |
| `harness-data/reference/ARCHITECTURE.md` | Mapping legacy structure, boundaries, ownership, or runtime topology. |
| `harness-data/reference/TOOLING.md` | Recording commands, local services, validation checks, CI, or tooling. |
| `harness-data/reference/QUALITY.md` | Recording quality gates, proof standards, coverage, or hygiene rules. |
