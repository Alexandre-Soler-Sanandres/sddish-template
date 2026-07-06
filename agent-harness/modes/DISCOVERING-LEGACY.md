# DISCOVERING-LEGACY.md

## Purpose

Legacy Discovery extracts rewrite-quality evidence from existing systems. Legacy code is evidence, not authority.

## Entry

- CLI: `/legacy-discovery <path>`
- Natural language: explicit instruction to analyze a legacy codebase or imported project directory.

## Context

Load reference files only when directly relevant:

| File | Load when |
| --- | --- |
| `harness-data/reference/DOMAIN.md` | Extracting domain concepts, rules, actors, workflows, or terminology. |
| `harness-data/reference/ARCHITECTURE.md` | Mapping legacy structure, boundaries, ownership, or runtime topology. |
| `harness-data/reference/TOOLING.md` | Recording commands, local services, validation checks, CI, or tooling. |
| `harness-data/reference/QUALITY.md` | Recording quality gates, proof standards, coverage, or hygiene rules. |
| `agent-harness/modes/legacy-discovery/APP-LOCAL.md` | Running App-Local Discovery: slicing an app, updating its `INVENTORY.md`, `SOURCE-MAP.md`, `findings/`, or its rows in the Questions registry. |
| `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md` | Running Cross-System Synthesis across apps that are all `app-local-complete`. |
| `agent-harness/modes/legacy-discovery/NORMALIZATION.md` | Running Artifact Normalization (Post-Discovery Gate). |
| `agent-harness/modes/legacy-discovery/CLARIFICATION.md` | Running Question Clarification (Post-Discovery Gate). |
| `agent-harness/modes/legacy-discovery/IMPORT-HYGIENE.md` | Before inventorying or reading files in a freshly imported legacy snapshot — load first, not after noticing something suspicious. |

## Discovery Phases

| Phase | Entry gate | Work | Exit gate |
| --- | --- | --- | --- |
| App-local discovery | Imported app selected | Slice app evidence, update app `SOURCE-MAP.md`, `findings/`, the Questions registry, and stable reference docs. See `agent-harness/modes/legacy-discovery/APP-LOCAL.md`. | Source map reaches `app-local-complete`. |
| Cross-system synthesis | Active scope is explicit and all in-scope apps are `app-local-complete`. | Synthesize contracts, parity, questions, proof needs, and readiness across apps. See `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`. | Cross-system `SUMMARY.md` marks synthesis complete and names the restart point. |
| Artifact normalization | App-local and required cross-system discovery are complete. | Format, dedupe, order, and tighten existing artifacts without new source discovery. See `agent-harness/modes/legacy-discovery/NORMALIZATION.md`. | Restart pointer moves to question clarification. |
| Question clarification | Normalization is complete. | Resolve, defer, discard, or route open questions and proof needs. See `agent-harness/modes/legacy-discovery/CLARIFICATION.md`. | Downstream-work is unblocked once P0/migration-critical blockers are resolved, deferred, or proof-routed, so the restart pointer may move to Use Cases or Specs. This does not mean Question Clarification is complete, and it does not make other open questions irrelevant. Any remaining open cross-system or app-local questions stay tracked in the legacy artifacts until they are resolved, deferred, marked not-needed, converted to proof work, or intentionally carried into individual Use Cases/Specs as `Open Questions`; each downstream artifact's own Readiness Checklist then gates when that artifact is finished. |

## Discovery Lifecycle

Each app source map carries a `discovery_state` field distinct from artifact `status`.

| State | Meaning |
| --- | --- |
| `app-discovery-active` | App-local slices are still being discovered. |
| `app-local-complete` | App evidence is sufficient for app-local rewrite planning. |
| `rewrite-ready` | App evidence, cross-system synthesis, and target decisions are sufficient to begin rewrite design work. This is an unblock state, not a claim that every legacy question is closed. Proof obligations and non-blocking open questions may still remain when they are explicit, still tracked, and do not block coherent design. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-01-010 | Core | Do not modify legacy source code or implement new code. |
| LD-01-020 | Core | Do not treat legacy behavior as automatically correct target behavior. |
| LD-01-030 | Core | Inspect current code first, then docs, then tests. |
| LD-01-040 | Core | Record evidence paths for every finding. |
| LD-01-050 | Core | Distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, dead code, stale notes, target-product decisions, and proof needs. |
| LD-01-060 | Core | Mark inferred intent clearly; never present it as observed behavior. |
| LD-01-070 | Core | Flag when evidence is strong enough to warrant a Use Case or Spec. Do not draft a Use Case directly — route to Refining (`/create-use-case`) once a Legacy Finding is strong enough (see `LD-02-010`); Specs may still be drafted directly only per `LD-01-080`'s exception. |
| LD-01-080 | Core | Do not create Specs directly without a Use Case unless the evidence is unambiguous and strong. |
| LD-01-090 | Core | Preserve app-local evidence inside app-scoped artifacts until cross-system synthesis is in scope. |
| LD-01-100 | Core | Validate docs with `git diff --check`; use additional Markdown checks when the repository defines them. |
| LD-01-120 | Core | Treat changing source-map workflow or status rules, and starting cross-system synthesis, as additional high-impact actions under `COR-05-010`'s checkpoint, on top of the universal list in `COR-05-020`. |
| LD-02-010 | Routing | Other outputs may include candidate `harness-data/artifacts/specs/active/SPEC-*.md` (per `LD-01-080`'s exception) and Harness Improvement candidates. Use Cases are not drafted here — once a Legacy Finding is strong enough (`LD-01-070`), route to Refining (`/create-use-case`) to create the `UC-*.md`. |
| LD-03-010 | Findings | Store each finding as its own file, using `agent-harness/templates/LEGACY-FINDING-template.md` as-is: `harness-data/artifacts/legacy/apps/<app-slug>/findings/active/<LF-ID>.md` for app-scoped findings, `harness-data/artifacts/legacy/cross-system/findings/active/<LF-ID>.md` for cross-system findings. |
| LD-03-020 | Findings | IDs follow the existing `LF-<APP>-NNN` convention, numbered once per app (or `LF-CROSS-NNN` for cross-system) and never reused, even after a finding moves or is merged. |
| LD-03-030 | Findings | Move a finding to the matching `findings/archive/<LF-ID>.md` path when its `status` becomes `converted`, `archived`, or `rejected`. Findings with `status: draft` or `status: reviewed` stay in `findings/active/`. |
| LD-03-040 | Findings | Always look up or add a finding by ID — scan `findings/active/` and `findings/archive/` file names or frontmatter, never by reading through file append order. Do not create slice-numbered or subsystem-named headings as a substitute for the ID. |
| LD-04-010 | Questions | Legacy Discovery questions live in the harness-level Questions registry (`QUESTIONS-OPEN`/`RESOLVED`/`DISCARDED.md`, schema in `agent-harness/artifact-specs/QUESTIONS.md`), not per-app files. Use `Q-<APP>-NNN` (app-scoped) or `CSQ-NNN` (cross-system) IDs, fold `Decision type` (`scope-v1` \| `preserve-vs-adapt` \| `fidelity` \| `naming` \| `deferred-feature`) into `Notes`, and follow the registry's own classification (`QST-01-010`) and status (`QST-03-010`) rules. Don't organize the registry by discovery slice, subsystem, or process block. |
| LD-04-020 | Questions | Before adding a question, check existing registry rows for the same decision by content and merge instead of duplicating. |
| LD-04-030 | Questions | Every question links back to the finding(s) that raised it through the registry's `Source` column. For cross-system questions, those source finding IDs should usually be `LF-CROSS-NNN`, with app finding IDs added in `Notes` only when the extra traceability matters. Provenance like slice name or artifact of origin belongs in `Notes`, not in the table structure. |
| LD-05-010 | Completion-Criteria | An app may move to `app-local-complete` when: all planned slices are `done`, `not-needed`, or explicitly deferred; open questions are classified as `local`, `cross-artifact`, or `systemic` (per `agent-harness/artifact-specs/QUESTIONS.md`'s `QST-01-010`) in the source map table; stable findings have been propagated to reference docs where appropriate; and no remaining slice is needed for app-local rewrite planning. |
| LD-06-010 | Proof-Gate | `proof_needed` is `true` when discovery found drift or runtime behavior needing executable proof before rewrite planning treats it as stable; `false` when no required executable proof is known, or required proof is complete. |
| LD-06-030 | Proof-Gate | An app may be `app-local-complete` with `proof_needed: true`. Rewrite-ready means the remaining proof obligations are explicit and can be carried forward into Use Cases, Specs, validation, or later implementation work without making the rewrite design incoherent. |
| LD-08-010 | Evidence-Precedence | Every finding states whether it is based on observed behavior, documented behavior, or inference, and records which source was treated as authoritative when evidence conflicts. |
| LD-09-010 | Reference-Enrichment | Do not enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings. |
| LD-09-020 | Reference-Enrichment | Write reference-doc enrichment from findings under that doc's `## Discovered` heading, citing the specific `LF-*` ID. Do not write target-decision language into `## Discovered` — a settled target decision belongs under `## Decisions`, added when the decision is actually made (via Question Clarification outcome or a later ADR), not during Legacy Discovery itself. |

## Evidence Precedence

When sources conflict, apply this default order and record deviations:

1. Current runtime code and tests.
2. Completed migration or audit docs.
3. Checked-in contract snapshots.
4. Historical docs, README snippets, and agent rules.
5. Stale setup or deployment docs.

## Reference Enrichment

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
