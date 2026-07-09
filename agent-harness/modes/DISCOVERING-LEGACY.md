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
| Question clarification | Normalization is complete. | Resolve, defer, discard, or route open questions and proof needs. See `agent-harness/modes/legacy-discovery/CLARIFICATION.md`. | Downstream-work is unblocked once P0/migration-critical blockers are resolved, deferred, or proof-routed (see `CLARIFICATION.md`'s `LDG-04-100`), so the restart pointer may move to Use Cases or Specs. This does not mean Question Clarification is complete, and it does not make other open Questions irrelevant. See `CLARIFICATION.md`'s `LDG-04-120` and `CORE.md`'s `COR-01-120` for how remaining Questions stay tracked and referenced downstream. |

## Discovery Lifecycle

Each app source map carries a `discovery_state` field distinct from artifact `status`.

| State | Meaning |
| --- | --- |
| `app-discovery-active` | App-local slices are still being discovered. |
| `app-local-complete` | App evidence is sufficient for app-local rewrite planning. |
| `rewrite-ready` | App evidence, cross-system synthesis, and target decisions are sufficient to begin rewrite design work. This is an unblock state, not a claim that every legacy question is closed. See `SOURCE-MAP-template.md`'s rewrite-ready note for what may still remain and under what conditions — this table intentionally does not restate it. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-01-010 | Core | MUST NOT modify legacy source code or implement new code. |
| LD-01-020 | Core | MUST NOT treat legacy behavior as automatically correct target behavior. |
| LD-01-030 | Core | MUST inspect current code first, then docs, then tests. |
| LD-01-040 | Core | MUST record evidence paths for every finding. |
| LD-01-050 | Core | MUST distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, dead code, stale notes, target-product decisions, and proof needs. |
| LD-01-060 | Core | MUST NOT present inferred intent as observed behavior — mark it clearly as inferred instead. |
| LD-01-070 | Core | MUST NOT draft a Use Case directly — once a Legacy Finding is strong enough to warrant one, flag it and route to Refining (`/create-use-case`) instead (see `LD-02-010`); Specs may still be drafted directly only per `LD-01-080`'s exception. |
| LD-01-080 | Core | MUST NOT create Specs directly without a Use Case unless the evidence is unambiguous and strong. |
| LD-01-090 | Core | MUST preserve app-local evidence inside app-scoped artifacts until cross-system synthesis is in scope. |
| LD-01-100 | Core | MUST validate docs with `git diff --check` and any additional Markdown checks the repository defines. |
| LD-01-110 | Core | MUST capture the rewrite-facing conclusion when the evidence clearly establishes one, not only the local implementation fact that produced it. |
| LD-01-115 | Core | MUST capture not only factual legacy behavior but also any material target decisions the evidence leaves unresolved, including latent forks recognized through engineering judgment, not only direct source conflict. |
| LD-01-120 | Core | MUST treat changing source-map workflow or status rules, and starting cross-system synthesis, as additional high-impact actions under `COR-05-010`'s checkpoint, on top of the universal list in `COR-05-020`. |
| LD-02-010 | Routing | MAY include, as other outputs, a candidate `harness-data/artifacts/specs/active/SPEC-*.md` (per `LD-01-080`'s exception) and Harness Improvement candidates. |
| LD-02-020 | Routing | A Legacy Finding's evidence may produce a candidate `harness-data/artifacts/ideas/active/IDEA-*.md` when it states a future/roadmap direction rather than an unresolved fork — apply `COR-01-110`'s test. Note the candidate Idea in the originating finding's `## Candidate Artifacts`. Check existing `active` Ideas for overlap before creating a new one (`IDA-02-010`), and apply `IDA-01-020`'s atomicity rule — one Idea per opportunity, not one per source document. Ideas spun off from a *resolved* Question are governed by `QUESTIONS.md`'s `QST-07-020` instead. |
| LD-02-030 | Routing | MUST NOT draft a Use Case in Legacy Discovery — once a Legacy Finding is strong enough (`LD-01-070`), route to Refining (`/create-use-case`) to create the `UC-*.md`. |
| LD-03-010 | Findings | MUST store each finding as its own file, using `agent-harness/templates/LEGACY-FINDING-template.md` as-is: `harness-data/artifacts/legacy/apps/<app-slug>/findings/active/<LF-ID>.md` for app-scoped findings, `harness-data/artifacts/legacy/cross-system/findings/active/<LF-ID>.md` for cross-system findings. |
| LD-03-020 | Findings | MUST follow the existing `LF-<APP>-NNN` convention for IDs, numbered once per app (or `LF-CROSS-NNN` for cross-system) and never reused, even after a finding moves or is merged. |
| LD-03-030 | Findings | MUST move a finding to the matching `findings/archive/<LF-ID>.md` path when its `status` becomes `converted`, `archived`, or `rejected`; findings with `status: draft` or `status: reviewed` stay in `findings/active/`. |
| LD-03-040 | Findings | MUST NOT look up or add a finding except by ID — scan `findings/active/` and `findings/archive/` file names or frontmatter, never by reading through file append order or by creating slice-numbered or subsystem-named headings as a substitute for the ID. |
| LD-03-050 | Findings | MUST tag a finding `bug` in its `tags` frontmatter when it documents a confirmed defect (wrong runtime, dashboard, or metrics behavior) or dead/wired-but-inert code, as distinct from an unresolved fork (`Q-*`/`CSQ-*`) or future-facing intent (`IDEA-*`). This tag exists so bug-shaped findings stay discoverable across an app's full finding set, not to create a new artifact type or lifecycle. |
| LD-03-060 | Findings | MUST treat operational or manual surfaces as first-class findings when they materially define current runtime trust, operator workflow, or observability — including CLI/operator tools, health/readiness/metrics surfaces, SQL diagnostics, and other human-run inspection paths. |
| LD-03-070 | Findings | MUST record material data-model shape choices when evidence establishes them, even without a defect — including storage topology, typed-vs-JSON structure, DB views as read models, key typing, and authority boundaries between ORM metadata and migrations. |
| LD-03-080 | Findings | MUST capture non-error runtime states when they materially affect operator understanding, rewrite fidelity, or target behavior — for example warmup periods, degraded-but-expected modes, or long-running intermediate states. |
| LD-03-090 | Findings | MUST capture app-internal architectural boundaries when the evidence clearly establishes a cross-layer or cross-subsystem contract inside one app, not only the files or functions on each side. |
| LD-03-100 | Findings | MUST record provider-set shape when a capability depends on providers and the evidence makes the portfolio materially relevant — including primary, fallback, overlapping, deferred, or disabled-but-wired providers. |
| LD-04-010 | Questions | MUST use `Q-<APP>-NNN` (app-scoped) or `CSQ-NNN` (cross-system) IDs for Legacy Discovery questions (they live in the harness-level Questions registry — `QUESTIONS-OPEN`/`RESOLVED`/`DISCARDED.md`, schema in `agent-harness/artifact-specs/QUESTIONS.md` — not per-app files, and not organized by discovery slice, subsystem, or process block), fold `Decision type` (`scope-v1` \| `preserve-vs-adapt` \| `fidelity` \| `naming` \| `deferred-feature`) into `Notes`, and follow the registry's own classification (`QST-01-010`) and status (`QST-03-010`) rules. |
| LD-04-020 | Questions | MUST check existing registry rows for the same decision by content and merge instead of duplicating, before adding a question. |
| LD-04-030 | Questions | MUST link every question back to the finding(s) that raised it through the registry's `Source` column. |
| LD-04-040 | Questions | SHOULD default cross-system questions' `Source` to `LF-CROSS-NNN`, adding app finding IDs in `Notes` only when the extra traceability matters; provenance like slice name or artifact of origin belongs in `Notes`, not the table structure. |
| LD-05-010 | Completion-Criteria | MAY move to `app-local-complete` when: all planned slices are `done`, `not-needed`, or explicitly deferred; every open Question referenced from this app (per `COR-01-120`) has a `QST-01-010` Classification recorded in the canonical Questions registry — not a local copy in the source map; stable findings have been propagated to reference docs where appropriate; and no remaining slice is needed for app-local rewrite planning. |
| LD-06-010 | Proof-Gate | MUST set `proof_needed` to `true` when discovery found drift or runtime behavior needing executable proof before rewrite planning treats it as stable; to `false` when no required executable proof is known, or required proof is complete. |
| LD-06-030 | Proof-Gate | MAY reach `app-local-complete` with `proof_needed: true`. Rewrite-ready means the remaining proof obligations are explicit and can be carried forward into Use Cases, Specs, validation, or later implementation work without making the rewrite design incoherent. |
| LD-08-010 | Evidence-Precedence | Every finding MUST state whether it is based on observed behavior, documented behavior, or inference, and record which source was treated as authoritative when evidence conflicts. |
| LD-08-020 | Evidence-Precedence | SHOULD default to the order given in `## Evidence Precedence` below when sources conflict, and record any deviation and why. |
| LD-09-010 | Reference-Enrichment | MUST NOT enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings. |
| LD-09-020 | Reference-Enrichment | MUST NOT write target-decision language into `## Discovered` — write reference-doc enrichment there from findings, citing the specific `LF-*` ID; a settled target decision belongs under `## Decisions` instead, added when the decision is actually made (via Question Clarification outcome or a later ADR), not during Legacy Discovery itself. |
| LD-09-030 | Reference-Enrichment | Before closing out a slice, MUST check every `bug`-tagged finding from that slice against the Reference Enrichment routing table and confirm it was written into at least one reference doc's `## Discovered` section. The tag flags a finding for this check; the finding's actual content still decides which doc(s) it belongs in per the routing table — a `bug` tag does not mean it must go in `QUALITY.md` specifically. |

## Evidence Precedence

When sources conflict, apply this default order and record deviations (`LD-08-020`):

1. Current runtime code and tests.
2. Completed migration or audit docs.
3. Checked-in contract snapshots.
4. Historical docs, README snippets, and agent rules.
5. Stale setup or deployment docs.

See `CROSS-SYSTEM.md`'s `LDC-04-010`/`LDC-04-015` for why cross-system synthesis deliberately uses a different
order for the same evidence classes once a fact crosses an app boundary.

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
