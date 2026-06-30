# LEGACY-DISCOVERY.md

## Purpose

Legacy Discovery analyzes an existing project as evidence for a new SDD-ish development process.
The legacy project is evidence, not authority.

## Entry

Via CLI: `/tw-discover-legacy <path>`
Via natural language: explicit instruction to analyze a legacy codebase or imported project directory.

## Inputs May Include

- Old source code
- Old documentation
- Tests, Docker files, CI configuration
- Deployment scripts, README files, issue notes

## Agent Must

- Not modify legacy source code
- Not implement new code
- Not treat legacy code as automatically correct
- Identify observed behavior
- Identify documented behavior
- Mark inferred intent clearly
- Mark uncertainty explicitly
- Identify accidental complexity
- Extract candidate Use Cases
- Extract candidate Specs only when evidence is strong enough
- Record evidence paths

## Agent Must Distinguish

- Observed behavior (code does X)
- Documented behavior (docs say X)
- Inferred intent (likely meant X)
- Accidental complexity (unclear why X exists)
- Dead or uncertain code

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/DOMAIN.md` — when extracting domain concepts, rules, or terminology from legacy code
- `agent-harness/reference/ARCHITECTURE.md` — when mapping legacy structure to the current system architecture

## Outputs May Include

- `agent-harness/legacy/apps/<legacy-app-slug>/INVENTORY.md`
- `agent-harness/legacy/apps/<legacy-app-slug>/SOURCE-MAP.md`
- `agent-harness/legacy/apps/<legacy-app-slug>/FINDINGS.md`
- `agent-harness/legacy/apps/<legacy-app-slug>/QUESTIONS.md`
- `agent-harness/legacy/cross-system/SUMMARY.md`
- `agent-harness/legacy/cross-system/CONTRACTS.md`
- `agent-harness/legacy/cross-system/FINDINGS.md`
- `agent-harness/legacy/cross-system/QUESTIONS.md`
- `agent-harness/legacy/cross-system/PARITY-MATRIX.md`
- `agent-harness/legacy/cross-system/REWRITE-READINESS.md`
- `agent-harness/legacy/active/LEGACY-FINDING-*.md`
- `agent-harness/use-cases/active/UC-*.md` (candidate, draft)
- `agent-harness/specs/active/SPEC-*.md` (candidate, only when evidence is strong)
- Harness Improvement candidates

## Legacy Artifact Structure

Use app-scoped legacy folders for app-specific discovery. A legacy app is any imported source root that can be
discovered independently, such as an engine, dashboard, inference service, worker, library, or old monolith.

```text
agent-harness/legacy/apps/<legacy-app-slug>/
  INVENTORY.md
  SOURCE-MAP.md
  FINDINGS.md
  QUESTIONS.md
```

Each app-scoped `SOURCE-MAP.md` is the restart point for that app. Use
`agent-harness/templates/SOURCE-MAP-template.md` for every new source map. Each source map must include:

- source root
- primary evidence files
- code areas
- candidate discovery slices
- block list and status (when blockwise discovery is used)
- current slice status table
- completed slice notes
- open source-map notes
- reference enrichment routing

Source maps must contain app-specific material only. Do not copy generic slice rules, block rules, or roundtrip
steps into each app source map — those belong in this mode file and the source-map template.

Use cross-system artifacts only after app-scoped evidence exists and a finding, question, or readiness judgment
requires more than one app:

```text
agent-harness/legacy/cross-system/
  SUMMARY.md
  CONTRACTS.md
  FINDINGS.md
  QUESTIONS.md
  PARITY-MATRIX.md
  REWRITE-READINESS.md
```

Do not put app-local evidence directly into cross-system artifacts. Cross-system artifacts should cite the
app-scoped artifact and source evidence they synthesize.

Start cross-system synthesis by creating `agent-harness/legacy/cross-system/SUMMARY.md` from
`agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working
plan: it defines the active synthesis scope, entry criteria, slice order, artifact routing, and next action. Create
`CONTRACTS.md`, `FINDINGS.md`, `QUESTIONS.md`, `PARITY-MATRIX.md`, and `REWRITE-READINESS.md` only when a slice
produces evidence that needs those artifacts; do not create empty placeholders speculatively.

Older flat files directly under `agent-harness/legacy/` may exist in repositories that started discovery before
this structure was introduced. Treat them as legacy layout debt. Continue new discovery in the scoped structure
unless an explicit Improvement or cleanup task migrates the old files.

## Slice Rules

Slices are the durable unit of discovery progress.

- A source map may define as many slices as necessary to support rewrite-quality app-local discovery.
- Every slice must be marked individually with a status: `done`, `next`, `pending`, or `not-needed`.
- Do not close a slice as `done` until its findings and unresolved questions are recorded.
- Completed slice notes must list: evidence paths used, stable findings, and any unresolved decisions.

## Slice Roundtrip

Each discovery slice follows the same roundtrip:

1. Select the smallest useful evidence set from the source map.
2. Inspect current code first, then docs, then tests for the slice.
3. Distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, and
   stale historical notes.
4. Add or update findings in the app `FINDINGS.md`.
5. Update the source map with completed slice notes and useful evidence paths.
6. Add unresolved decisions to the app `QUESTIONS.md`.
7. Enrich project reference docs when evidence is stable: `ARCHITECTURE.md`, `DOMAIN.md`, `TOOLING.md`,
   and `QUALITY.md`. For blockwise discovery, enrich after each block before committing the block.
   Deferring enrichment across blocks is acceptable when noted in the source map Open App Notes, but
   enrichment must be complete before `app-local-complete` is declared.
8. Validate docs with `git diff --check`.
9. Commit only when the user explicitly asks for a commit.

## Blockwise Discovery Rules

Slices may be grouped into a block when they share a focused, overlapping evidence set and produce a more coherent
rewrite boundary together. Blocks are a planning convenience, not a replacement for slices.

- Mark every included slice individually in the slice status table even when running as a block.
- Use a block only when the grouped slices can be discovered from a focused, overlapping evidence set.
- Keep blocks app-scoped. Do not turn block work into cross-system or cross-cutting synthesis.
- Write one completed block note that lists: included slices, evidence paths, stable findings, and unresolved
  decisions. Do not hide unresolved decisions inside the block note.
- After a block completes, set the next unfinished slice or next coherent block as `next`.
- Block rules belong in this mode file and the source-map template, not in each app source map.

Reference enrichment (step 7 of the slice roundtrip) applies per block. Complete enrichment for each block
before committing it. If enrichment is deferred across multiple blocks, record this explicitly in the source
map Open App Notes and ensure enrichment completes before `app-local-complete` is declared.

## Source Map Content Boundaries

An app source map is an app-local evidence ledger. It must contain only:

- source root
- evidence inventory (primary files, areas, candidate slices)
- block list and status (app-specific block plans and completed block notes)
- slice status table (individual slice progress)
- completed notes per slice or block
- open app-specific notes
- restart pointers
- reference enrichment routing

An app source map must not contain:

- generic slice rules or roundtrip steps (those belong in this mode file)
- generic block rules (those belong in this mode file)
- cross-system or cross-app findings or judgments
- reusable process policy of any kind

## Cross-System Deferral

Do not start cross-system synthesis until every app in the active synthesis scope has reached `app-local-complete`
discovery state. See lifecycle state definitions in the Discovery Lifecycle section below.

## Discovery Lifecycle

Each app source map carries a `discovery_state` field. This is distinct from the artifact lifecycle `status` field.

| State | Meaning |
| --- | --- |
| `app-discovery-active` | App-local slices are still being discovered. |
| `app-local-complete` | Slice coverage is sufficient for app-local rewrite evidence. |
| `rewrite-ready` | App-local evidence, cross-system synthesis, and required proof checks are complete enough to feed Use Cases, Specs, or Implementation Planning. |

Cross-system synthesis may start only when every app in the active synthesis scope has reached `app-local-complete`.

### App-Local Completion Exit Criteria

An app source map may move to `app-local-complete` when all of the following hold:

- All planned slices have status `done`, `not-needed`, or an explicitly deferred status.
- Open questions are classified as `app-local`, `cross-system`, or `target-product` decisions. This
  classification must be recorded in the source map's "Deferred and Cross-System Questions" table before
  `app-local-complete` is declared. QUESTIONS.md may organize questions by topic area; the source map
  table is the classification record that makes this criterion verifiable.
- Stable findings have been propagated to reference docs where appropriate.
- No remaining slice is needed to support rewrite planning from app-local evidence alone.

### Proof Gate

Each source map also carries a `proof_needed` flag:

- `proof_needed: true` — discovery found drift or runtime behavior that must be verified with executable checks
  before rewrite planning may treat it as stable.
- `proof_needed: false` — no required executable proof is currently known, or required proof has already been
  completed.

An app may reach `app-local-complete` with `proof_needed: true`. Rewrite-readiness requires that required proofs
are completed or explicitly deferred with an accepted decision.

### Active Synthesis Scope

The active synthesis scope is the set of apps that must all reach `app-local-complete` before cross-system
synthesis starts. Scope is defined explicitly in the cross-system work or by the user — do not infer it.

## Import Hygiene

Imported legacy snapshots often contain secret-like files, local runtime artifacts, and nested repository
metadata. Apply these rules during normal discovery.

### Path-only inventory

Inventory the following by path only. Do not open their contents during normal discovery:

- `.env`, `.env.*`, `.env.local`, and similar environment files
- `secrets/`, `*.key`, `*.pem`, password files, token files
- local logs, caches (`.cache/`, `__pycache__/`, `*.pyc`)
- virtual environments (`.venv/`, `venv/`, `env/`)
- coverage output, test artifacts, generated metadata
- egg-info and build output directories

### Log files

Inventory log files by path only. Open log contents only in an explicit log or security discovery slice,
after confirming the log does not contain secrets.

### No mutation during discovery

Do not remove or rewrite imported artifacts during normal discovery.

### Nested Git metadata

Before committing an imported snapshot or import-hygiene change, verify no nested `.git` directories exist:

```sh
find legacy/imported/<app-slug> -path '*/.git' -type d
```

Expected result: no output. Surface any hit to the user before proceeding.

### Source maps

Must include an Import Hygiene section (see SOURCE-MAP template) whenever the snapshot contains
secret-like files, local runtime artifacts, or nested repository metadata. The section must list
found paths and their type.

For each category of import noise that requires a user decision (secret-like files, nested `.git`
hits, unusual local artifacts), write:

- A FINDINGS entry documenting what was found and what risk it represents.
- A QUESTIONS entry asking what action to take (remove, quarantine, leave as-is).

The user's response to the open QUESTIONS authorizes any cleanup action.

## Evidence Precedence

When sources conflict, apply this default precedence model. Record deviations explicitly in the source map.

1. **Current runtime code and tests** — highest authority for observed behavior.
2. **Completed migration or audit docs** — supersede the plans they replaced.
3. **Checked-in contract snapshots** — evidence of intent; may drift from another app's current runtime.
4. **Historical docs, README snippets, agent rules** — low confidence when current code contradicts them.
5. **Stale setup or deployment docs** — background context only; verify against current code before use.

Every finding must state whether its claim is based on observed behavior, documented behavior, or inference.
When evidence sources disagree, record the conflict and which source was treated as authoritative.

## Reference Enrichment

Enrich reference docs (`ARCHITECTURE.md`, `DOMAIN.md`, `TOOLING.md`, `QUALITY.md`) when app-local evidence
is stable. Route findings by type:

| Finding type | Target reference doc |
| --- | --- |
| Architecture boundaries, layer contracts | `ARCHITECTURE.md` |
| Domain concepts, rules, terminology | `DOMAIN.md` |
| Tools, commands, CI, test setup | `TOOLING.md` |
| Quality standards, test coverage, hygiene | `QUALITY.md` |

Do not enrich reference docs with findings that are:

- still unresolved or uncertain
- cross-system (wait for cross-system synthesis)
- speculative or inferred without code evidence

## Boundaries — Must Not

- Modify legacy source code
- Implement new code
- Treat legacy code as automatically correct
- Create Specs directly without a Use Case unless evidence is unambiguous and strong
- Mark inferred intent as observed behavior
- Commit findings only when the user explicitly requests it. See `CORE.md` Commits section.
