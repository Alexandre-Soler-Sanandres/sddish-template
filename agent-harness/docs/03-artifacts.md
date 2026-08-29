# Artifacts

Every artifact is a Markdown file with YAML frontmatter. Artifacts are the source of truth — not agent memory, not conversation history.
Lifecycle artifacts live under `harness-data/artifacts/`.

Each file under `agent-harness/artifact-specs/` is an Artifact Contract: it defines what one artifact means, when
it is created, how its fields and lifecycle work, and what makes it valid. "Artifact spec" is the historical folder
name; "Artifact Contract" is the role.

This document covers harness-managed lifecycle artifacts only. Project-owned support files such as
`harness-data/reference/`, `harness-data/guides/`, and `harness-data/playbooks/` are not artifacts and do not follow
artifact lifecycle statuses.

## Standard Change Spec (v2)

`CHANGE-NNNN.md` is the single durable execution contract for Standard work. It records intent, preserved
behavior, scope, non-goals, paths, requirements and acceptance criteria, verification evidence, dependencies,
approved execution steps, progress, and closeout. Use Cases, Tasks, Plans, Transcripts, Ideas, and Reviews are
conditional artifacts: persist them only when they supply independent authority, ownership/lifecycle, provenance,
backlog, findings, or handoff value.

For project-owned support files, see [10-guides.md](10-guides.md) and [11-project-playbooks.md](11-project-playbooks.md).

## Artifact Contract Form

Artifact Contracts teach meaning, validity, lifecycle, relationships, examples, and quality expectations. They are
not Mode Workflows: they do not describe how to conduct an interactive mode session except where that context is
needed to explain creation paths. Enforceable constraints live in the contract`s own `## Rules` section; the surrounding prose keeps the explanation.

Canonical Artifact Contract sections:

- `Purpose`
- `Artifact Story`
- `Entry / Creation Paths`
- `Sources`
- `When To Create`
- `When Not To Create`
- `Artifact Shape`
- `Field Semantics`
- `Body Should Include`
- `Lifecycle`
- `Readiness / Acceptance`
- `Relationships`
- `Output / Location`
- `Template`
- `Examples`
- `Rules`
- `Reference Files`

Every artifact spec already follows this canonical form.

## Reference File Structure

`harness-data/reference/{ARCHITECTURE,DOMAIN,TOOLING,QUALITY}.md` mix content with two different mutability
profiles. Structure each file with up to two top-level sections so a reader can tell them apart:

- `## Discovered` — present only in projects that ran Legacy Discovery. Facts extracted from `LF-*` findings.
  Cite the finding ID inline (e.g. "billing service owns invoice writes (LF-BILLING-0014)"). Stable once written —
  edit only to correct a transcription error against the finding, never because a target decision changed.
- `## Decisions` — present once at least one target-architecture decision exists. States the decision in one or
  two lines, then cites whatever settled it: an accepted ADR (`ADR-NNNN`), a Legacy Finding (`LF-*`), the Questions
  registry (`CSQ-*`/`CSP-NNNN` rows), or a legacy synthesis artifact (`REWRITE-READINESS.md`, `CONTRACTS.md`). Cite
  authority, don't restate its reasoning — mirrors `DEC-02-020`'s rule for Use Cases/Specs citing ADRs.

A greenfield project (no Legacy Discovery) has `## Decisions` only — do not add a `## Discovered` section with
placeholder content just because this convention exists.

When the artifact a `## Decisions` entry cites is superseded (an ADR superseded per `DEC-06-010`, or a Legacy
Finding/Question re-resolved), update the citation in the same pass — see `DEC-08-010`.

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
| `LF-<APP>-` / `LF-CROSS-` | Legacy Finding (app / cross-system, see `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md` LD-03-010/LD-03-020) |
| `Q-NNNN` (new) / `Q-<APP>-NNNN`, `CSQ-`, `CSP-` (migrated legacy) | Question |

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

**Statuses:** `captured` → `clarifying` → `ready-for-refining` → `landed` → `archived` → `rejected`
**Location:** `harness-data/artifacts/ideas/active/IDEA-*.md`
**Template:** `agent-harness/templates/IDEA-template.md`

### ADR (Architecture Decision Record)

A settled structural or architectural decision — durable and citable, unlike an Idea (which is pre-decision) or
a Use Case (which cannot itself decide architecture, per `UCS-04-010`–`030`). Referenced as authority by
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
Created via Refining, from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing
documentation — unless `shared-procs/RISK-TIER.md`'s UC-Necessity Matrix classifies the request below UC-tier,
in which case no Use Case is created at all and work proceeds directly to a Spec or Task.

**Statuses:** `draft` → `ready` → `done` → `archived` → `rejected`
**Location:** `harness-data/artifacts/use-cases/active/UC-*.md` (`draft`),
`harness-data/artifacts/use-cases/ready/UC-*.md` (`ready`),
`harness-data/artifacts/use-cases/done/UC-*.md` (`done`), or
`harness-data/artifacts/use-cases/archive/UC-*.md` (`archived`/`rejected`)
**Template:** `agent-harness/templates/USE-CASE-template.md`

Body should include: primary actor, supporting actors, goal, trigger, preconditions, main success scenario, alternatives and failure paths, non-goals, observable outcome, open questions.

### Spec

The central artifact of the SDD-ish process. Defines desired behavior and acceptance criteria.
Created from a Use Case (any status) — OR, when `shared-procs/RISK-TIER.md`'s UC-Necessity Matrix
classifies the request below UC-tier, directly from the same source types a Use Case would have been created
from.

**Statuses:** `draft` → `ready` → `done` → `archived` → `rejected`
**Location:** `harness-data/artifacts/specs/active/SPEC-*.md` (`draft`),
`harness-data/artifacts/specs/ready/SPEC-*.md` (`ready`),
`harness-data/artifacts/specs/done/SPEC-*.md` (`done`), or
`harness-data/artifacts/specs/archive/SPEC-*.md` (`archived`/`rejected`)
**Template:** `agent-harness/templates/SPEC-template.md`

Body should include: problem, goal, scope, non-goals, functional requirements, non-functional requirements, acceptance criteria, constraints, dependencies, risks, validation approach, task decision notes.

The `technical_refs` frontmatter field links to external technical artifacts (OpenAPI specs, schemas, contracts) that live outside `agent-harness/`.

The `test_refs` frontmatter field is populated by the agent during implementation — it lists paths to test files that cover each acceptance criterion. It is only for test file paths, not legacy proof IDs or other backlog references. A plan step is not done until `test_refs` is populated or each AC is covered by a Task validation command.

### Task

Execution unit derived from a Spec. Tasks are not the source of truth for behavior — Specs are.
Created from a Spec at any status — OR, when `shared-procs/RISK-TIER.md`'s Spec-Necessity Matrix classifies the
request below Spec-tier, directly from the same source types a Spec would have been created from. Not always
required — see [05-workflows.md](05-workflows.md).

**Statuses:** `draft` → `ready` → `in-progress` → `done` → `blocked` → `archived` → `rejected`
**Location:** `harness-data/artifacts/tasks/active/TASK-*.md` (`draft`/`in-progress`/`blocked`),
`harness-data/artifacts/tasks/ready/TASK-*.md` (`ready`),
`harness-data/artifacts/tasks/done/TASK-*.md` (`done`), or
`harness-data/artifacts/tasks/archive/TASK-*.md` (`archived`/`rejected`)
**Template:** `agent-harness/templates/TASK-template.md`

Task frontmatter includes `allowed_paths` and `forbidden_paths` to constrain implementation scope.

### Implementation Plan

Defines how implementation will proceed. Required before any code changes.

**Statuses:** `draft` → `ready` → `in-progress` → `done` → `rejected` → `archived`
**Location:** `harness-data/artifacts/implementation-plans/active/PLAN-*.md` (`draft`/`in-progress`),
`harness-data/artifacts/implementation-plans/ready/PLAN-*.md` (`ready`),
`harness-data/artifacts/implementation-plans/done/PLAN-*.md` (`done`), or
`harness-data/artifacts/implementation-plans/archive/PLAN-*.md` (`archived`/`rejected`)
**Template:** `agent-harness/templates/IMPLEMENTATION-PLAN-template.md`

Each plan step must define: Tasks (or "inline"), expected files, validation, risk level, and a suggested commit boundary.

### Review

Evaluates artifacts, plans, implementations, or process results — one of two flavors depending on `target_type`.
Review is not only approval — it is how process problems are discovered.

- **Product/requirements flavor** (`idea`/`use-case`/`spec`/`task`/`implementation-plan`/`implementation`):
  produced from within Implementing. `accepted` advances the target artifact's own status.
- **Harness/process flavor** (`process`/`harness`): produced from within any Mode when a process problem
  surfaces; consumed by Improving-Harness, which is entered only from one. No target-artifact status to advance.

**Statuses:** `draft` | `assessed` | `resolved` | `discarded`
**Outcomes:** `accepted` | `accepted-with-notes` | `changes-requested` | `rejected` | `follow-up-required`
**Location:** `harness-data/artifacts/reviews/active/REVIEW-*.md`
**Template:** `agent-harness/templates/REVIEW-template.md`

After review, the agent takes a prescribed action based on the outcome and stops — it never autonomously
re-enters a producing mode after rejection or escalation. See `agent-harness/artifact-specs/REVIEW.md`'s own
outcome-action table for the exact required action per outcome, for each flavor.

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
`agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md` (LD-03-010)
**Template:** `agent-harness/extensions/legacy-discovery/templates/LEGACY-FINDING-template.md`

Must distinguish: observed behavior, documented behavior, inferred intent, accidental complexity, dead or uncertain code.

Legacy Discovery also produces `INVENTORY.md`, `SOURCE-MAP.md`, and `CROSS-SYSTEM-SUMMARY.md`
(templates under `agent-harness/templates/`). These are scoped Legacy Discovery artifacts, not general-purpose
lifecycle types — see [the Legacy Discovery guide](../extensions/legacy-discovery/GUIDE.md) and
`agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md` for their statuses, IDs, and folder layout. Questions raised during
Legacy Discovery are not a scoped Legacy Discovery artifact — they go into the harness-level Question registry
below, like questions from any other mode.

### Question

An unresolved (or resolved) point that needs a decision before some artifact can be trusted as final. Durable and
discoverable, unlike a Non-Goal (permanent exclusion) or an Idea (candidate work, not a question). May be created
from any mode — no mode switch required.

**Statuses:** none as a field — which of the three files a row lives in *is* its status (`Open`, `Resolved`,
`Discarded`); see `agent-harness/artifact-specs/QUESTIONS.md`.
**Location:** `harness-data/artifacts/questions/QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, `QUESTIONS-DISCARDED.md`
**Template:** `agent-harness/templates/QUESTIONS-template.md`

Classified by blast radius (`local` / `cross-artifact` / `systemic`), not by origin. IDs are permanent — a resolved
or discarded question is moved to the corresponding file, never deleted.

## Readiness Checklists

Every artifact template contains a Readiness Checklist. Before the agent advances an artifact
to its gate status, every checklist item must be checked. A single unchecked item blocks the
status change.

| Artifact | Gate status | Checklist section |
| --- | --- | --- |
| Use Case | `ready` | `## Readiness Checklist` |
| Spec | `ready` | `## Readiness Checklist` |
| Task | `ready` | `## Readiness Checklist` |
| Implementation Plan | `ready` | `## Readiness Checks` |
| ADR | `accepted` | `## Readiness Checklist` |
