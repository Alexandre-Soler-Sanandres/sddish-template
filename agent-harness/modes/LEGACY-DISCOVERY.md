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
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
  QUESTIONS.md
```

Cross-system synthesis goes under:

```text
agent-harness/legacy/cross-system/
  SUMMARY.md
  CONTRACTS.md
  findings/
    active/<LF-ID>.md
    archive/<LF-ID>.md
  QUESTIONS.md
  PARITY-MATRIX.md
  REWRITE-READINESS.md
```

Other outputs may include candidate `agent-harness/use-cases/active/UC-*.md`, candidate
`agent-harness/specs/active/SPEC-*.md`, and Harness Improvement candidates.

### Inventory

Each app `INVENTORY.md` uses `agent-harness/templates/INVENTORY-template.md`: fixed `Scope`, `Identity`, `Major
Runtime Areas`, `Operations, Tooling, and Quality`, and `Inventory Gaps` sections, plus as many app-specific
structural sections as the app's own shape needs in between. Name app-specific sections after what they actually
cover in this app — do not copy another app's section names by default.

### Findings

Store each finding as its own file, using `agent-harness/templates/LEGACY-FINDING-template.md` as-is:
`agent-harness/legacy/apps/<app-slug>/findings/active/<LF-ID>.md` for app-scoped findings, and
`agent-harness/legacy/cross-system/findings/active/<LF-ID>.md` for cross-system findings. IDs follow the existing
`LF-<APP>-NNN` convention, numbered once per app (or `LF-CROSS-NNN` for cross-system) and never reused, even after a
finding moves or is merged.

Move a finding to the matching `findings/archive/<LF-ID>.md` path when its `status` becomes `converted`, `archived`,
or `rejected`. Findings with `status: draft` or `status: reviewed` stay in `findings/active/`.

Always look up or add a finding by ID — scan `findings/active/` and `findings/archive/` file names or frontmatter,
never by reading through file append order. Do not create slice-numbered or subsystem-named headings as a
substitute for the ID; that is exactly the structure this replaces.

Cross-system findings are synthesized claims, not app-local copies. They must cite the contributing app findings and
source evidence they depend on, state the cross-app claim once, and carry only the boundary-specific synthesis needed
for downstream contracts, questions, parity rows, or readiness judgments.

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

### Questions

Each app and cross-system `QUESTIONS.md` uses `agent-harness/templates/QUESTIONS-template.md`: an `Open Decisions`
table with stable IDs (`Q-<APP>-NNN` for app-scoped questions, `CSQ-NNN` for cross-system questions), a
`Classification` column (`app-local` | `cross-system` | `target-product`), and a `Decision type` column
(`scope-v1` | `preserve-vs-adapt` | `fidelity` | `naming` | `deferred-feature`), followed by a flat
`Resolved Decisions` list. Do not organize `QUESTIONS.md` into sections named after the discovery slice, subsystem,
or process block that raised the question — that is metadata (`Area`), not structure. Before adding a question,
check existing rows for the same decision by content and merge instead of duplicating.

Every question links back to the finding(s) that raised it through the `Source finding(s)` column. For cross-system
questions, those source finding IDs should usually be `LF-CROSS-NNN`, with app finding IDs added in `Notes` only when
the extra traceability matters. Provenance like slice name or artifact of origin belongs in `Notes`, not in the table
structure.

### Cross-System Artifacts

Start cross-system synthesis by creating `agent-harness/legacy/cross-system/SUMMARY.md` from
`agent-harness/templates/CROSS-SYSTEM-SUMMARY-template.md`. The summary is the cross-system restart point and working
plan: it names the active synthesis scope, entry criteria, slice order, artifact routing, and next action.
Cross-system artifacts are outputs of cross-system synthesis, not app-local discovery.

Create `CONTRACTS.md`, `findings/` entries, `QUESTIONS.md`, `PARITY-MATRIX.md`, and `REWRITE-READINESS.md` only when
a slice produces evidence that needs them. Do not create empty placeholders speculatively. Cross-system artifacts
cite app-scoped artifacts and source evidence instead of copying app-local detail.

Use the cross-system artifacts for distinct jobs:

- `SUMMARY.md` defines the active synthesis scope, confirms entry criteria, records slice order, routes outputs, and
  names the restart action.
- `CONTRACTS.md` defines the inter-app boundaries: API, data, auth, health, observability, deployment, and ownership
  contracts.
- `findings/` stores synthesized cross-app claims that require evidence from more than one app.
- `QUESTIONS.md` captures unresolved cross-app or target-product decisions raised by those synthesized findings.
- `PARITY-MATRIX.md` records where producer and consumer behavior matched, drifted, or still needs executable proof.
- `REWRITE-READINESS.md` states what is stable enough for Use Cases and Specs, and what blockers or proof items still
  prevent implementation planning.

These artifacts are connected, not independent. Cross-system findings should feed `CONTRACTS.md`, `QUESTIONS.md`,
`PARITY-MATRIX.md`, and `REWRITE-READINESS.md` by citation; parity rows and readiness blockers should point back to
the finding IDs and proof/question IDs they depend on.
Use the proof/parity IDs defined in `PARITY-MATRIX.md` as the canonical IDs. `REWRITE-READINESS.md` should reference
those existing proof IDs directly instead of inventing a second blocker-ID namespace.

Older flat files directly under `agent-harness/legacy/` are legacy layout debt. Continue new discovery in the scoped
structure unless an explicit Improvement or cleanup task migrates them.

## Discovery Phases

| Phase | Entry gate | Work | Exit gate |
| --- | --- | --- | --- |
| App-local discovery | Imported app selected | Slice app evidence, update app `SOURCE-MAP.md`, `findings/`, `QUESTIONS.md`, and stable reference docs. | Source map reaches `app-local-complete`. |
| Cross-system synthesis | Active scope is explicit and all in-scope apps are `app-local-complete`. | Synthesize contracts, parity, questions, proof needs, and readiness across apps. | Cross-system `SUMMARY.md` marks synthesis complete and names the restart point. |
| Artifact normalization | App-local and required cross-system discovery are complete. | Format, dedupe, order, and tighten existing artifacts without new source discovery. | Restart pointer moves to question clarification. |
| Question clarification | Normalization is complete. | Resolve, defer, discard, or route open questions and proof needs. | P0/migration-critical blockers resolved, deferred, or proof-routed — restart pointer moves to Use Cases or Specs. Remaining non-P0 questions carry forward into individual Use Cases/Specs as their own `Open Questions`; each artifact's own Readiness Checklist (not this phase) gates when it is finished. |

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
4. Update app `findings/` (add or merge into an `LF-<APP>-NNN` file, looked up by ID), `QUESTIONS.md`, and
   `SOURCE-MAP.md`. When a question is recorded, link it bidirectionally: cite the originating finding(s) in
   `QUESTIONS.md`'s `Source finding(s)` column, and add the question ID to each cited finding's
   `## Open Questions` section. Use `baseline` / `cross-cutting` in `Source finding(s)` when the question does not
   trace to a specific finding.
5. Enrich stable reference docs: `ARCHITECTURE.md`, `DOMAIN.md`, `TOOLING.md`, and `QUALITY.md`.
6. Validate with `git diff --check`.
7. Commit only when explicitly asked.

Reference enrichment may be deferred across blockwise work only when the source map says so; it must be complete
before `app-local-complete`.

Record any forward-looking candidate list a slice produces — candidate Use Cases, candidate Specs, candidate
quality gates, or anything similarly shaped — in the relevant finding's `## Candidate Artifacts` section at
authoring time. Do not invent a new per-slice `"Candidate <Something>"` list in `SOURCE-MAP.md`'s slice notes under
any label; that is the same duplication regardless of what the list is called. When a candidate spans multiple
findings from the same slice, record it in each contributing finding's `Candidate Artifacts`, not as a new shared
list. `Completed Notes` in the source map holds evidence paths, stable findings, and unresolved decisions only.

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

Cross-system synthesis is a second layer over app-local discovery:

- app-scoped artifacts keep local evidence close to the source app
- cross-system findings synthesize boundary claims from multiple app artifacts
- cross-system questions, parity rows, and readiness blockers trace back to those synthesized findings

Do not flatten app-local evidence into cross-system narrative summaries when an app finding or source-map citation is
enough.

## Post-Discovery Gates

### Artifact Normalization

Run normalization after app-local discovery and cross-system synthesis are complete, before moving legacy evidence
into Use Cases, Specs, Tasks, or Implementation Planning.

Normalize in this order:

1. One app folder at a time: `INVENTORY.md`, `SOURCE-MAP.md`, `findings/`, and `QUESTIONS.md`.
2. Cross-system artifacts: `SUMMARY.md`, `CONTRACTS.md`, `findings/`, `QUESTIONS.md`, `PARITY-MATRIX.md`, and
   `REWRITE-READINESS.md`.

For each artifact, fix Markdown formatting, heading hierarchy, table consistency, stale restart pointers, obvious
ordering issues, and duplicate sections with the same claim. Preserve information density, evidence paths, artifact
IDs, question IDs, finding IDs, proof IDs, lifecycle metadata, and evidence classifications.

For cross-system artifacts specifically, preserve the traceability chain across app finding IDs, cross-system finding
IDs, question IDs, proof IDs, parity rows, and readiness blockers. Normalization may tighten wording or merge
duplicates, but it must not sever those links.

For `findings/`, normalizing duplicates means merging two `LF-<APP>-NNN` files that make the same claim into one:
keep the ID with the stronger evidence set, fold the other file's evidence paths into it, and do not delete the
superseded file — set its `status` to `archived`, add a one-line pointer to the surviving ID, and move it to
`findings/archive/`. IDs are never reused or silently dropped.

For `QUESTIONS.md` (app-local and cross-system), sweep `Open Decisions` for duplicate rows before normalization is
considered complete:

- Flag any two rows whose `Source finding(s)` sets overlap — this is a strong, mechanical signal of the same
  underlying decision raised more than once.
- Flag any row whose `Notes` column references another question ID (e.g. "see CSQ-", "same as Q-", "duplicate
  of") — these are self-flagged candidates that must be resolved into an actual merge, not left as narrative.
- Merge confirmed duplicates without resolving them — normalization does not decide open questions. Keep the row
  with the clearer/more complete question text as the single `Open Decisions` entry, and add a one-line note in
  its `Notes` column recording the merged-away ID and why (e.g. "merges duplicate CSQ-012, same source finding
  LF-CROSS-016"). Do not silently drop the merged-away row — the ID must stay traceable even though it no longer
  has its own row, mirroring how finding-dedup keeps a pointer instead of deleting the superseded file. The
  question itself stays open until Question Clarification actually resolves it.
- Flag any ID that appears in both `Open Decisions` and `Resolved Decisions` in the same file — a resolution that
  added a `Resolved Decisions` row without removing the original `Open Decisions` row. Remove the stale
  `Open Decisions` row; the `Resolved Decisions` row is authoritative.
- For each row in `Resolved Decisions`, re-check every finding listed in its `Source finding(s)` column — the ID
  must appear in that finding's `## Resolved Questions`, not left in `## Open Questions`. This applies to *every*
  cited finding, not just the first one checked; a multi-finding citation list is a common place for one sibling
  finding to be missed while the others are updated correctly.

For cross-system `findings/`, verify each finding's `## Evidence` section cites the contributing app finding IDs
it synthesizes, not only raw source paths — add the missing citations before normalization is considered complete.

`SOURCE-MAP.md` and cross-system `SUMMARY.md` additionally collapse to their `Discovery-Complete Shape` (see
`SOURCE-MAP-template.md` and `CROSS-SYSTEM-SUMMARY-template.md`) as part of this pass, once `discovery_state` is
`app-local-complete` (app-scoped) or cross-system synthesis is finished. Before collapsing, verify every stable
finding and candidate Use Case note in the sections being removed already has an equivalent entry in `findings/`
or the reference docs; port it forward first if it does not. This is a structural collapse of session-resumption
scaffolding whose purpose has ended, not a loss of evidence — the same file, same path, stays the artifact's stable
restart point.

Normalization is not new discovery. Do not add findings from source inspection. If a gap needs source inspection or
runtime execution, record a follow-up question or proof item.

### Question Clarification

After normalization, clarify open discovery questions before moving toward Use Cases, Specs, Tasks, or Implementation
Planning.

Context sources:

1. App `QUESTIONS.md` files and each source map's deferred/cross-system question table.
2. Cross-system `QUESTIONS.md` when synthesis exists.
3. Cross-system `PARITY-MATRIX.md` proof candidates and `REWRITE-READINESS.md` blockers when they exist.
4. Relevant `findings/`, `CONTRACTS.md`, or source-map notes only to understand an existing question.

Use those sources to gather context, not as a required execution order.

Default execution order:

- when cross-system synthesis exists and its P0 or migration-critical questions dominate the next decision boundary,
  start with the highest-impact cross-system blocker or question first
- pull in app questions only when they are prerequisites for that answer or are implicitly answered by it
- update the cross-system artifacts and every affected app artifact in the same pass so the traceability stays aligned
- after the cross-system blocker set is clarified, finish any remaining truly app-local questions

Only when no cross-system blocker clearly dominates should clarification start by walking app-local questions first.

In cross-system-driven clarification:

- start from the cross-system question, blocker, or proof need with the broadest impact
- pull in app questions only when they are prerequisites for that answer or are implicitly answered by it
- update the cross-system artifacts and every affected app artifact in the same pass so the traceability stays aligned

This means cross-system questions are the default driver whenever they represent the broadest open concerns, while
app-local questions are resolved immediately whenever the cross-system decision settles them.

For each open question:

- Keep the original question ID stable.
- Merge or cross-reference duplicates and near-duplicates.
- Classify it as `must-decide-before-use-cases`, `must-decide-before-specs`,
  `must-decide-before-implementation-planning`, `proof-needed`, `accepted-deferred`, or `not-needed`.
- Present target-product decisions with concrete options and a recommended proposal.
- Preserve evidence paths, finding IDs, proof IDs, and uncertainty notes.
- Mark resolved only after the answer is captured in the right question file and affected restart/readiness notes.
- When marking a question resolved, move its row to the `Resolved Decisions` table keeping its ID, set
  `Origin: resolved-from-open`, and for every finding listed in its `Source finding(s)`, move the ID from that
  finding's `## Open Questions` to `## Resolved Questions` with the resolution text — do this at the same time, not
  as a later reconciliation pass. A source map's initial baseline-decision capture, before any slice work begins,
  also uses the `Resolved Decisions` table with `Origin: baseline` — see `QUESTIONS-template.md`.
- When a resolution produces a stable, target-relevant fact (architecture boundary, domain rule, tooling/command,
  quality standard), enrich the matching reference doc in the same pass — do not defer it. Use the app-local
  routing table in `## Reference Enrichment` below, or the cross-system `SUMMARY.md`'s `Reference Enrichment
  Routing` table when the decision is cross-system. Skip enrichment only when the decision is purely
  process/traceability bookkeeping (e.g., merging a duplicate ID) with no new stable fact to record.
- Convert questions requiring new source inspection or runtime execution into proof items or follow-up tasks.

When a cross-system clarification pass resolves an app question indirectly, update the app `QUESTIONS.md`, the linked
app finding(s), and any affected source-map notes in that same pass. Do not leave the app artifact waiting for a
later reconciliation sweep.

P0 or migration-critical blockers must be resolved, explicitly accepted as deferred, or routed to proof work
before any Use Case or Spec work begins. Once that gate is met, any cross-system or app-local finding may seed a
Use Case or Spec regardless of remaining non-P0 open questions — carry those questions forward into the
artifact's own `Open Questions` section. An individual Use Case or Spec is not finished (cannot reach
`ready-for-spec` / `approved`) until its own open questions are resolved, deferred, marked not-needed, or routed
to proof, per that artifact's Readiness Checklist.

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

Enrich reference docs when evidence is stable — from App-Local Discovery, Cross-System Synthesis, or Question
Clarification:

| Finding type | Target reference doc |
| --- | --- |
| Architecture boundaries, layer contracts | `ARCHITECTURE.md` |
| Domain concepts, rules, terminology | `DOMAIN.md` |
| Tools, commands, CI, test setup | `TOOLING.md` |
| Quality standards, test coverage, hygiene | `QUALITY.md` |

Do not enrich references with unresolved, uncertain, cross-system-before-synthesis, or speculative findings.

During Artifact Normalization, re-walk the full `Resolved Decisions` list (app and cross-system `QUESTIONS.md`
files) against the reference docs and confirm each decision that produces a stable, target-relevant fact is
actually reflected there. This is a repeatable sweep run every normalization pass, not a one-time backfill — a
resolution landing after the last sweep is exactly the kind of gap it exists to catch.
