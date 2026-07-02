# LEGACY-DISCOVERY.md

## Purpose

Legacy Discovery extracts rewrite-quality evidence from existing systems. Legacy code is evidence, not authority.

## Entry

- CLI: `/tw-discover-legacy <path>`
- Natural language: explicit instruction to analyze a legacy codebase or imported project directory.

## Context

Load reference files only when directly relevant:

| File | Load when |
| --- | --- |
| `harness-data/reference/DOMAIN.md` | Extracting domain concepts, rules, actors, workflows, or terminology. |
| `harness-data/reference/ARCHITECTURE.md` | Mapping legacy structure, boundaries, ownership, or runtime topology. |
| `harness-data/reference/TOOLING.md` | Recording commands, local services, validation checks, CI, or tooling. |
| `harness-data/reference/QUALITY.md` | Recording quality gates, proof standards, coverage, or hygiene rules. |
| `agent-harness/modes/legacy-discovery/APP-LOCAL.md` | Running App-Local Discovery: slicing an app, updating its `INVENTORY.md`, `SOURCE-MAP.md`, `findings/`, or `QUESTIONS.md`. |
| `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md` | Running Cross-System Synthesis across apps that are all `app-local-complete`. |
| `agent-harness/modes/legacy-discovery/GATES.md` | Running Artifact Normalization or Question Clarification (Post-Discovery Gates). |

## Discovery Phases

| Phase | Entry gate | Work | Exit gate |
| --- | --- | --- | --- |
| App-local discovery | Imported app selected | Slice app evidence, update app `SOURCE-MAP.md`, `findings/`, `QUESTIONS.md`, and stable reference docs. See `agent-harness/modes/legacy-discovery/APP-LOCAL.md`. | Source map reaches `app-local-complete`. |
| Cross-system synthesis | Active scope is explicit and all in-scope apps are `app-local-complete`. | Synthesize contracts, parity, questions, proof needs, and readiness across apps. See `agent-harness/modes/legacy-discovery/CROSS-SYSTEM.md`. | Cross-system `SUMMARY.md` marks synthesis complete and names the restart point. |
| Artifact normalization | App-local and required cross-system discovery are complete. | Format, dedupe, order, and tighten existing artifacts without new source discovery. See `agent-harness/modes/legacy-discovery/GATES.md`. | Restart pointer moves to question clarification. |
| Question clarification | Normalization is complete. | Resolve, defer, discard, or route open questions and proof needs. See `agent-harness/modes/legacy-discovery/GATES.md`. | P0/migration-critical blockers resolved, deferred, or proof-routed — restart pointer moves to Use Cases or Specs. Remaining non-P0 questions carry forward into individual Use Cases/Specs as their own `Open Questions`; each artifact's own Readiness Checklist (not this phase) gates when it is finished. |

## Discovery Lifecycle

Each app source map carries a `discovery_state` field distinct from artifact `status`.

| State | Meaning |
| --- | --- |
| `app-discovery-active` | App-local slices are still being discovered. |
| `app-local-complete` | App evidence is sufficient for app-local rewrite planning. |
| `rewrite-ready` | App evidence, cross-system synthesis, and target decisions are sufficient to begin rewrite design work. Proof obligations may still remain when they are explicit and do not block coherent design. |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-001 | Core | Do not modify legacy source code or implement new code. |
| LD-002 | Core | Do not treat legacy behavior as automatically correct target behavior. |
| LD-003 | Core | Inspect current code first, then docs, then tests. |
| LD-004 | Core | Record evidence paths for every finding. |
| LD-005 | Core | Distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, dead code, stale notes, target-product decisions, and proof needs. |
| LD-006 | Core | Mark inferred intent clearly; never present it as observed behavior. |
| LD-007 | Core | Extract candidate Use Cases and candidate Specs only when evidence is strong enough. |
| LD-008 | Core | Do not create Specs directly without a Use Case unless the evidence is unambiguous and strong. |
| LD-009 | Core | Preserve app-local evidence inside app-scoped artifacts until cross-system synthesis is in scope. |
| LD-010 | Core | Validate docs with `git diff --check`; use additional Markdown checks when the repository defines them. |
| LD-011 | Core | Commit only when the user explicitly asks. |
| LD-012 | Routing | Other outputs may include candidate `harness-data/use-cases/active/UC-*.md`, candidate `harness-data/specs/active/SPEC-*.md`, and Harness Improvement candidates. |
| LD-013 | Findings | Store each finding as its own file, using `agent-harness/templates/LEGACY-FINDING-template.md` as-is: `harness-data/legacy/apps/<app-slug>/findings/active/<LF-ID>.md` for app-scoped findings, `harness-data/legacy/cross-system/findings/active/<LF-ID>.md` for cross-system findings. |
| LD-014 | Findings | IDs follow the existing `LF-<APP>-NNN` convention, numbered once per app (or `LF-CROSS-NNN` for cross-system) and never reused, even after a finding moves or is merged. |
| LD-015 | Findings | Move a finding to the matching `findings/archive/<LF-ID>.md` path when its `status` becomes `converted`, `archived`, or `rejected`. Findings with `status: draft` or `status: reviewed` stay in `findings/active/`. |
| LD-016 | Findings | Always look up or add a finding by ID — scan `findings/active/` and `findings/archive/` file names or frontmatter, never by reading through file append order. Do not create slice-numbered or subsystem-named headings as a substitute for the ID. |
| LD-017 | Questions | Each app and cross-system `QUESTIONS.md` (using `agent-harness/templates/QUESTIONS-template.md`) has an `Open Decisions` table with stable IDs (`Q-<APP>-NNN` for app-scoped, `CSQ-NNN` for cross-system), a `Classification` column (`app-local` \| `cross-system` \| `target-product`), and a `Decision type` column (`scope-v1` \| `preserve-vs-adapt` \| `fidelity` \| `naming` \| `deferred-feature`), followed by a flat `Resolved Decisions` list. Do not organize `QUESTIONS.md` into sections named after the discovery slice, subsystem, or process block that raised the question — that is metadata (`Area`), not structure. |
| LD-018 | Questions | Before adding a question, check existing rows for the same decision by content and merge instead of duplicating. |
| LD-019 | Questions | Every question links back to the finding(s) that raised it through the `Source finding(s)` column. For cross-system questions, those source finding IDs should usually be `LF-CROSS-NNN`, with app finding IDs added in `Notes` only when the extra traceability matters. Provenance like slice name or artifact of origin belongs in `Notes`, not in the table structure. |
| LD-020 | Completion-Criteria | An app may move to `app-local-complete` when all planned slices are `done`, `not-needed`, or explicitly deferred. |
| LD-021 | Completion-Criteria | Open questions are classified as `app-local`, `cross-system`, or `target-product` in the source map table. |
| LD-022 | Completion-Criteria | Stable findings have been propagated to reference docs where appropriate. |
| LD-023 | Completion-Criteria | No remaining slice is needed for app-local rewrite planning. |
| LD-024 | Proof-Gate | `proof_needed: true` — discovery found drift or runtime behavior needing executable proof before rewrite planning treats it as stable. |
| LD-025 | Proof-Gate | `proof_needed: false` — no required executable proof is known, or required proof is complete. |
| LD-026 | Proof-Gate | An app may be `app-local-complete` with `proof_needed: true`. Rewrite-ready means the remaining proof obligations are explicit and can be carried forward into Use Cases, Specs, validation, or later implementation work without making the rewrite design incoherent. |
| LD-027 | Import-Hygiene | During normal discovery, inventory `.env`, `.env.*`, `.env.local`, `secrets/`, `*.key`, `*.pem`, password files, token files, logs, caches, virtual environments, coverage output, test artifacts, generated metadata, egg-info, and build output by path only — do not open contents. |
| LD-028 | Import-Hygiene | Open log contents only in an explicit log or security discovery slice, after confirming they do not contain secrets. |
| LD-029 | Import-Hygiene | Do not remove or rewrite imported artifacts during normal discovery. |
| LD-030 | Import-Hygiene | Before committing an imported snapshot or import-hygiene change, verify nested Git metadata: `find harness-data/legacy/imported/<app-slug> -path '*/.git' -type d` — expected result is no output. Surface any hit to the user before proceeding. |
| LD-031 | Import-Hygiene | When import noise needs a user decision, add a FINDINGS entry for the risk and a QUESTIONS entry asking whether to remove, quarantine, or leave it as-is. The user's response authorizes cleanup. |
| LD-032 | Evidence-Precedence | Every finding states whether it is based on observed behavior, documented behavior, or inference, and records which source was treated as authoritative when evidence conflicts. |
| LD-033 | Reference-Enrichment | Do not enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings. |

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
