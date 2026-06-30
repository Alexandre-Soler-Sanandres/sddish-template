# LEGACY-DISCOVERY.md

## Purpose

Legacy Discovery extracts rewrite-quality evidence from existing systems. Legacy code is evidence, not authority.

## Entry

- CLI: `/tw-discover-legacy <path>`
- Natural language: explicit instruction to analyze a legacy codebase or imported project directory.

## Core Rules

- Do not modify legacy source code or implement new code.
- Do not treat legacy behavior as automatically correct target behavior.
- Inspect current code first, then docs, then tests.
- Record evidence paths for every finding.
- Distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, dead code,
  stale notes, target-product decisions, and proof needs.
- Mark inferred intent clearly; never present it as observed behavior.
- Extract candidate Use Cases and candidate Specs only when evidence is strong enough.
- Do not create Specs directly without a Use Case unless the evidence is unambiguous and strong.
- Preserve app-local evidence inside app-scoped artifacts until cross-system synthesis is in scope.
- Validate docs with `git diff --check`; use additional Markdown checks when the repository defines them.
- Commit only when the user explicitly asks.

## Context

Load reference files only when directly relevant:

| File | Load when |
| --- | --- |
| `agent-harness/reference/DOMAIN.md` | Extracting domain concepts, rules, actors, workflows, or terminology. |
| `agent-harness/reference/ARCHITECTURE.md` | Mapping legacy structure, boundaries, ownership, or runtime topology. |
| `agent-harness/reference/TOOLING.md` | Recording commands, local services, validation checks, CI, or tooling. |
| `agent-harness/reference/QUALITY.md` | Recording quality gates, proof standards, coverage, or hygiene rules. |

## Artifact Routing

App-specific discovery goes under:

```text
agent-harness/legacy/apps/<legacy-app-slug>/
  INVENTORY.md
  SOURCE-MAP.md
  FINDINGS.md
  QUESTIONS.md
```

Cross-system synthesis goes under:

```text
agent-harness/legacy/cross-system/
  SUMMARY.md
  CONTRACTS.md
  FINDINGS.md
  QUESTIONS.md
  PARITY-MATRIX.md
  REWRITE-READINESS.md
```

Other outputs may include `agent-harness/legacy/active/LEGACY-FINDING-*.md`, candidate
`agent-harness/use-cases/active/UC-*.md`, candidate `agent-harness/specs/active/SPEC-*.md`, and Harness Improvement
candidates.

### App Source Maps

Each app `SOURCE-MAP.md` is the app restart point. Use `agent-harness/templates/SOURCE-MAP-template.md`.
It must stay app-local and contain only:

- source root, primary evidence files, code areas, and candidate discovery slices
- block list and status when blockwise discovery is used
- slice status table, completed slice/block notes, open app notes, restart pointers, and reference enrichment routing
- deferred/cross-system question classification before `app-local-complete`
- import hygiene when the snapshot contains secret-like files, local artifacts, or nested repository metadata

Do not copy generic slice rules, block rules, roundtrip steps, cross-system judgments, or reusable process policy into
app source maps.

### Cross-System Artifacts

Start cross-system synthesis by creating `agent-harness/legacy/cross-system/SUMMARY.md` from
`agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working
plan: it names the active synthesis scope, entry criteria, slice order, artifact routing, and next action.

Create `CONTRACTS.md`, `FINDINGS.md`, `QUESTIONS.md`, `PARITY-MATRIX.md`, and `REWRITE-READINESS.md` only when a
slice produces evidence that needs them. Do not create empty placeholders speculatively. Cross-system artifacts cite
app-scoped artifacts and source evidence instead of copying app-local detail.

Older flat files directly under `agent-harness/legacy/` are legacy layout debt. Continue new discovery in the scoped
structure unless an explicit Improvement or cleanup task migrates them.

## Discovery Phases

| Phase | Entry gate | Work | Exit gate |
| --- | --- | --- | --- |
| App-local discovery | Imported app selected | Slice app evidence, update app `SOURCE-MAP.md`, `FINDINGS.md`, `QUESTIONS.md`, and stable reference docs. | Source map reaches `app-local-complete`. |
| Cross-system synthesis | Active scope is explicit and all in-scope apps are `app-local-complete`. | Synthesize contracts, parity, questions, proof needs, and readiness across apps. | Cross-system `SUMMARY.md` marks synthesis complete and names the restart point. |
| Artifact normalization | App-local and required cross-system discovery are complete. | Format, dedupe, order, and tighten existing artifacts without new source discovery. | Restart pointer moves to question clarification. |
| Question clarification | Normalization is complete. | Resolve, defer, discard, or route open questions and proof needs. | Restart pointer moves to Use Cases or Specs. |

## App-Local Discovery

### Slice Rules

- Slices are the durable unit of discovery progress.
- A source map may define as many slices as needed for rewrite-quality app evidence.
- Every slice has status `done`, `next`, `pending`, or `not-needed`.
- Do not mark a slice `done` until findings and unresolved questions are recorded.
- Completed slice notes list evidence paths, stable findings, and unresolved decisions.

### Slice Roundtrip

1. Select the smallest useful evidence set from the source map.
2. Inspect code, then docs, then tests.
3. Classify evidence and conflicts using the Core Rules.
4. Update app `FINDINGS.md`, `QUESTIONS.md`, and `SOURCE-MAP.md`.
5. Enrich stable reference docs: `ARCHITECTURE.md`, `DOMAIN.md`, `TOOLING.md`, and `QUALITY.md`.
6. Validate with `git diff --check`.
7. Commit only when explicitly asked.

Reference enrichment may be deferred across blockwise work only when the source map says so; it must be complete
before `app-local-complete`.

### Blockwise Discovery

Blocks are a planning convenience for related slices with overlapping evidence. They do not replace slices.

- Mark each included slice individually in the slice status table.
- Use a block only when the grouped slices share a focused evidence set.
- Keep blocks app-scoped.
- Write one completed block note listing included slices, evidence paths, stable findings, and unresolved decisions.
- After a block completes, set the next unfinished slice or coherent block to `next`.

## Cross-System Synthesis

Do not start cross-system synthesis until every app in the active synthesis scope is `app-local-complete`. The active
scope must be explicit; do not infer it.

Use cross-system artifacts only when a finding, question, contract, proof need, or readiness judgment requires more
than one app. Route stable target-relevant findings to reference docs; leave legacy drift in legacy artifacts.

## Post-Discovery Gates

### Artifact Normalization

Run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy evidence
into Use Cases, Specs, Tasks, or Implementation Planning.

Normalize in this order:

1. One app folder at a time: `INVENTORY.md`, `SOURCE-MAP.md`, `FINDINGS.md`, and `QUESTIONS.md`.
2. Cross-system artifacts: `SUMMARY.md`, `CONTRACTS.md`, `FINDINGS.md`, `QUESTIONS.md`, `PARITY-MATRIX.md`, and
   `REWRITE-READINESS.md`.

For each artifact, fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious
ordering issues, and duplicate sections with the same claim. Preserve information density, evidence paths, artifact
IDs, question IDs, finding IDs, proof IDs, lifecycle metadata, and evidence classifications.

Normalization is not new discovery. Do not add findings from source inspection. If a gap needs source inspection or
runtime execution, record a follow-up question or proof item.

### Question Clarification

After normalization, clarify open discovery questions before moving toward Use Cases, Specs, Tasks, or Implementation
Planning.

Inputs, in order:

1. App `QUESTIONS.md` files and each source map's deferred/cross-system question table.
2. Cross-system `QUESTIONS.md` when synthesis exists.
3. Cross-system `PARITY-MATRIX.md` proof candidates and `REWRITE-READINESS.md` blockers when they exist.
4. Relevant `FINDINGS.md`, `CONTRACTS.md`, or source-map notes only to understand an existing question.

For each open question:

- Keep the original question ID stable.
- Merge or cross-reference duplicates and near-duplicates.
- Classify it as `must-decide-before-use-cases`, `must-decide-before-specs`,
  `must-decide-before-implementation-planning`, `proof-needed`, `accepted-deferred`, or `not-needed`.
- Present target-product decisions with concrete options and a recommended proposal.
- Preserve evidence paths, finding IDs, proof IDs, and uncertainty notes.
- Mark resolved only after the answer is captured in the right question file and affected restart/readiness notes.
- Convert questions requiring new source inspection or runtime execution into proof items or follow-up tasks.

Before starting Use Cases or Specs, every in-scope discovery question must be resolved, explicitly deferred with
rationale, marked not-needed, or routed to a named proof item. P0 or migration-critical blockers must be resolved,
explicitly accepted as deferred, or routed to proof work before any Spec relies on that behavior.

## Discovery Lifecycle

Each app source map carries a `discovery_state` field distinct from artifact `status`.

| State | Meaning |
| --- | --- |
| `app-discovery-active` | App-local slices are still being discovered. |
| `app-local-complete` | App evidence is sufficient for app-local rewrite planning. |
| `rewrite-ready` | App evidence, cross-system synthesis, and required proof checks are complete or explicitly deferred. |

### App-Local Completion Criteria

An app may move to `app-local-complete` when:

- all planned slices are `done`, `not-needed`, or explicitly deferred
- open questions are classified as `app-local`, `cross-system`, or `target-product` in the source map table
- stable findings have been propagated to reference docs where appropriate
- no remaining slice is needed for app-local rewrite planning

### Proof Gate

Each source map carries `proof_needed`:

- `true`: discovery found drift or runtime behavior needing executable proof before rewrite planning treats it as
  stable
- `false`: no required executable proof is known, or required proof is complete

An app may be `app-local-complete` with `proof_needed: true`. Rewrite-readiness requires required proofs to be
completed or explicitly deferred with an accepted decision.

## Import Hygiene

During normal discovery, inventory these by path only and do not open contents:

- `.env`, `.env.*`, `.env.local`, `secrets/`, `*.key`, `*.pem`, password files, token files
- logs, caches, virtual environments, coverage output, test artifacts, generated metadata, egg-info, and build output

Open log contents only in an explicit log or security discovery slice after confirming they do not contain secrets.
Do not remove or rewrite imported artifacts during normal discovery.

Before committing an imported snapshot or import-hygiene change, verify nested Git metadata:

```sh
find legacy/imported/<app-slug> -path '*/.git' -type d
```

Expected result: no output. Surface any hit to the user before proceeding.

When import noise needs a user decision, add a FINDINGS entry for the risk and a QUESTIONS entry asking whether to
remove, quarantine, or leave it as-is. The user's response authorizes cleanup.

## Evidence Precedence

When sources conflict, apply this default order and record deviations:

1. Current runtime code and tests.
2. Completed migration or audit docs.
3. Checked-in contract snapshots.
4. Historical docs, README snippets, and agent rules.
5. Stale setup or deployment docs.

Every finding states whether it is based on observed behavior, documented behavior, or inference, and records which
source was treated as authoritative when evidence conflicts.

## Reference Enrichment

Enrich reference docs when app-local evidence is stable:

| Finding type | Target reference doc |
| --- | --- |
| Architecture boundaries, layer contracts | `ARCHITECTURE.md` |
| Domain concepts, rules, terminology | `DOMAIN.md` |
| Tools, commands, CI, test setup | `TOOLING.md` |
| Quality standards, test coverage, hygiene | `QUALITY.md` |

Do not enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings.
