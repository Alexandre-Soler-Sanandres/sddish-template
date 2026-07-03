# Artifacts

Every artifact is a Markdown file with YAML frontmatter. Artifacts are the source of truth — not agent memory, not conversation history.
Lifecycle artifacts live under `harness-data/artifacts/`.

This document covers harness-managed lifecycle artifacts only. Project-owned support files such as
`harness-data/reference/`, `harness-data/guides/`, and `harness-data/playbooks/` are not artifacts and do not follow
artifact lifecycle statuses.

For project-owned support files, see [09-guides.md](09-guides.md) and [10-project-playbooks.md](10-project-playbooks.md).

## Reference File Structure

`harness-data/reference/{ARCHITECTURE,DOMAIN,TOOLING,QUALITY}.md` mix content with two different mutability
profiles. Structure each file with up to two top-level sections so a reader can tell them apart:

- `## Discovered` — present only in projects that ran Legacy Discovery. Facts extracted from `LF-*` findings.
  Cite the finding ID inline (e.g. "engine owns OHLC writes (LF-TW-ENGINE-014)"). Stable once written — edit only
  to correct a transcription error against the finding, never because a target decision changed.
- `## Decisions` — present once at least one target-architecture decision exists. States the decision in one or
  two lines, then cites whatever settled it: an accepted ADR (`ADR-NNN`), a Legacy Finding (`LF-*`), or a legacy
  synthesis artifact (`QUESTIONS.md`, `PARITY-MATRIX.md`, `REWRITE-READINESS.md`, `CONTRACTS.md`). Cite authority,
  don't restate its reasoning — mirrors `DEC-003`'s rule for Use Cases/Specs citing ADRs.

A greenfield project (no Legacy Discovery) has `## Decisions` only — do not add a `## Discovered` section with
placeholder content just because this convention exists.

When the artifact a `## Decisions` entry cites is superseded (an ADR superseded per `DEC-005`, or a Legacy
Finding/Question re-resolved), update the citation in the same pass — see `DEC-009`.

## YAML Frontmatter

Every artifact has a minimum set of frontmatter fields:

```yaml
id: TYPE-001
type: artifact-type
status: draft
title: ""
created: ""   # YYYY-MM-DD
updated: ""   # YYYY-MM-DD
```

### ID Prefixes

| Prefix | Type |
| --- | --- |
| `TRANSCRIPT-` | Transcript |
| `IDEA-` | Idea |
| `UC-` | Use Case |
| `SPEC-` | Spec |
| `TASK-` | Task |
| `PLAN-` | Implementation Plan |
| `REVIEW-` | Review |
| `IMPROVEMENT-` | Harness Improvement |
| `ADR-` | Architecture Decision Record |
| `LF-<APP>-` / `LF-CROSS-` | Legacy Finding (app / cross-system, see `agent-harness/modes/LEGACY-DISCOVERY.md` LD-013/LD-014) |

### Relationship Fields

| Field | Purpose |
| --- | --- |
| `source` | what this artifact was created from |
| `derived_*` | artifacts derived from this one |
| `related` | loosely related artifacts |
| `depends_on` | what must exist before this can proceed |
| `blocks` | what this artifact is blocking |

When a new artifact is created from an existing one, update the relationship fields in the same pass:

- child artifact: set `source` to the parent ID
- parent artifact: add the child ID to the relevant `derived_*` field when that field exists
- sibling or cross-cutting links: update `related`, `depends_on`, or `blocks` where needed

Frontmatter links are part of the harness's navigation contract, not optional bookkeeping.

## Artifact Types

### Transcript

Raw or lightly processed input from voice, chat, meetings, or imported notes.
Transcripts are evidence — not approved requirements.

**Statuses:** `raw` → `reviewed` → `processed` → `archived`
**Location:** `harness-data/artifacts/transcripts/active/TRANSCRIPT-*.md`
**Template:** `agent-harness/templates/TRANSCRIPT-template.md`

### Idea

Early structured thoughts. Not implementation requests.

**Statuses:** `captured` → `clarifying` → `ready-for-use-case` → `archived` → `rejected`
**Location:** `harness-data/artifacts/ideas/active/IDEA-*.md`
**Template:** `agent-harness/templates/IDEA-template.md`

### ADR (Architecture Decision Record)

A settled structural or architectural decision — durable and citable, unlike an Idea (which is pre-decision) or
a Use Case (which cannot itself decide architecture, per `UCS-004`/`005`/`006`). Referenced as authority by
`harness-data/reference/ARCHITECTURE.md`, Use Cases, and Specs.

**Statuses:** `proposed` → `accepted` → `superseded` | `rejected`
**Location:** `harness-data/artifacts/adrs/proposed/ADR-*.md` (not yet settled),
`harness-data/artifacts/adrs/accepted/ADR-*.md` (in force, citable authority), or
`harness-data/artifacts/adrs/archive/ADR-*.md` (superseded/rejected)
**Template:** `agent-harness/templates/ADR-template.md`

Body should include: context, decision, considered alternatives, consequences, open questions, and a Readiness
Checklist gating advancement to `accepted`. Once `accepted`, the decision and consequences are not rewritten in
place — a change of direction produces a new ADR that supersedes it, linked via the `supersedes`/`superseded_by`
frontmatter fields.

### Use Case

Describes actor-driven behavior. A behavioral anchor — not an implementation plan.

**Statuses:** `draft` → `ready-for-spec` → `implemented` → `archived` → `rejected`
**Location:** `harness-data/artifacts/use-cases/active/UC-*.md`
**Template:** `agent-harness/templates/USE-CASE-template.md`

Body should include: primary actor, supporting actors, goal, trigger, preconditions, main success scenario, alternatives and failure paths, non-goals, observable outcome, open questions.

### Spec

The central artifact of the SDD-ish process. Defines desired behavior and acceptance criteria.
Must always be created from a Use Case at `ready-for-spec` status.

**Statuses:** `draft` → `approved` → `implemented` → `archived` → `rejected`
**Location:** `harness-data/artifacts/specs/active/SPEC-*.md`
**Template:** `agent-harness/templates/SPEC-template.md`

Body should include: problem, goal, scope, non-goals, functional requirements, non-functional requirements, acceptance criteria, constraints, dependencies, risks, validation approach, task decision notes.

The `technical_refs` frontmatter field links to external technical artifacts (OpenAPI specs, schemas, contracts) that live outside `agent-harness/`.

The `test_refs` frontmatter field is populated by the agent during implementation — it lists paths to test files that cover each acceptance criterion. It is only for test file paths, not legacy proof IDs or other backlog references. A plan step is not done until `test_refs` is populated or each AC is covered by a Task validation command.

### Task

Execution unit derived from a Spec. Tasks are not the source of truth for behavior — Specs are.
Must always be created from an approved Spec. Not always required — see [04-workflows.md](04-workflows.md).

**Statuses:** `draft` → `ready` → `planned` → `in-progress` → `done` → `blocked` → `archived` → `rejected`
**Location:** `harness-data/artifacts/tasks/active/TASK-*.md`
**Template:** `agent-harness/templates/TASK-template.md`

Task frontmatter includes `allowed_paths` and `forbidden_paths` to constrain implementation scope.

### Implementation Plan

Defines how implementation will proceed. Required before any code changes.

**Statuses:** `proposed` → `approved` → `in-progress` → `done` → `rejected` → `archived`
**Location:** `harness-data/artifacts/implementation-plans/active/PLAN-*.md`
**Template:** `agent-harness/templates/IMPLEMENTATION-PLAN-template.md`

Each plan step must define: Tasks (or "inline"), expected files, validation, risk level, and a suggested commit boundary.

### Review

Evaluates artifacts, plans, implementations, or process results.

**Statuses:** `draft` → `completed`
**Outcomes:** `accepted` | `accepted-with-notes` | `changes-requested` | `rejected` | `follow-up-required`
**Location:** `harness-data/artifacts/reviews/active/REVIEW-*.md`
**Template:** `agent-harness/templates/REVIEW-template.md`

### Harness Improvement

Changes the process itself. Triggered by Review findings.

**Statuses:** `proposed` → `approved` → `in-progress` → `done` → `rejected` → `archived`
**Location:** `harness-data/artifacts/improvements/active/IMPROVEMENT-*.md`
**Template:** `agent-harness/templates/IMPROVEMENT-template.md`

### Legacy Finding

Records evidence extracted from legacy projects.

**Statuses:** `draft` → `reviewed` → `converted` → `archived` → `rejected`
**Location:** `harness-data/artifacts/legacy/apps/<legacy-app-slug>/findings/active/<LF-ID>.md` (app-scoped) or
`harness-data/artifacts/legacy/cross-system/findings/active/<LF-ID>.md` (cross-system) — see
`agent-harness/modes/LEGACY-DISCOVERY.md` (LD-013)
**Template:** `agent-harness/templates/LEGACY-FINDING-template.md`

Must distinguish: observed behavior, documented behavior, inferred intent, accidental complexity, dead or uncertain code.

Legacy Discovery also produces `INVENTORY.md`, `SOURCE-MAP.md`, `QUESTIONS.md`, and `CROSS-SYSTEM-SUMMARY.md`
(templates under `agent-harness/templates/`). These are scoped Legacy Discovery artifacts, not general-purpose
lifecycle types — see [08-legacy-applications.md](08-legacy-applications.md) and
`agent-harness/modes/LEGACY-DISCOVERY.md` for their statuses, IDs, and folder layout.

## Readiness Checklists

Every artifact template contains a Readiness Checklist. Before the agent advances an artifact
to its gate status, every checklist item must be checked. A single unchecked item blocks the
status change.

| Artifact | Gate status | Checklist section |
| --- | --- | --- |
| Use Case | `ready-for-spec` | `## Readiness Checklist` |
| Spec | `approved` | `## Readiness Checklist` |
| Task | `ready` | `## Readiness Checklist` |
| Implementation Plan | `approved` | `## Readiness Checks` |
| ADR | `accepted` | `## Readiness Checklist` |

## Artifact Maturity

An artifact is mature enough to proceed when its status is at an accepted level:

| Artifact | Required Status Before Next Step |
| --- | --- |
| Use Case | `ready-for-spec` |
| Spec | `approved` |
| Task | `ready` or `planned` |
| Implementation Plan | `approved` |
| ADR (before being cited as settled authority) | `accepted` |
