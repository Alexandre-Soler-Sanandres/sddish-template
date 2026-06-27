# Artifacts

Every artifact is a Markdown file with YAML frontmatter. Artifacts are the source of truth — not agent memory, not conversation history.

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
|---|---|
| `TRANSCRIPT-` | Transcript |
| `IDEA-` | Idea |
| `UC-` | Use Case |
| `SPEC-` | Spec |
| `TASK-` | Task |
| `PLAN-` | Implementation Plan |
| `REVIEW-` | Review |
| `IMPROVEMENT-` | Harness Improvement |
| `LEGACY-FINDING-` | Legacy Finding |

### Relationship Fields

| Field | Purpose |
|---|---|
| `source` | what this artifact was created from |
| `derived_*` | artifacts derived from this one |
| `related` | loosely related artifacts |
| `depends_on` | what must exist before this can proceed |
| `blocks` | what this artifact is blocking |

## Artifact Types

### Transcript

Raw or lightly processed input from voice, chat, meetings, or imported notes.  
Transcripts are evidence — not approved requirements.

**Statuses:** `raw` → `reviewed` → `processed` → `archived`  
**Location:** `agent-harness/transcripts/active/TRANSCRIPT-*.md`  
**Template:** `agent-harness/templates/TRANSCRIPT-template.md`

### Idea

Early structured thoughts. Not implementation requests.

**Statuses:** `captured` → `clarifying` → `ready-for-use-case` → `converted` → `archived` → `rejected`  
**Location:** `agent-harness/ideas/active/IDEA-*.md`  
**Template:** `agent-harness/templates/IDEA-template.md`

### Use Case

Describes actor-driven behavior. A behavioral anchor — not an implementation plan.

**Statuses:** `draft` → `review` → `ready-for-spec` → `converted` → `implemented` → `archived` → `rejected`  
**Location:** `agent-harness/use-cases/active/UC-*.md`  
**Template:** `agent-harness/templates/USE-CASE-template.md`

Body should include: primary actor, supporting actors, goal, trigger, preconditions, main success scenario, alternatives and failure paths, non-goals, observable outcome, open questions.

### Spec

The central artifact of the SDD-ish process. Defines desired behavior and acceptance criteria.  
Must always be created from a Use Case at `ready-for-spec` or `approved` status.

**Statuses:** `draft` → `review` → `approved` → `taskified` → `implemented` → `archived` → `rejected`  
**Location:** `agent-harness/specs/active/SPEC-*.md`  
**Template:** `agent-harness/templates/SPEC-template.md`

Body should include: problem, goal, scope, non-goals, functional requirements, non-functional requirements, acceptance criteria, constraints, dependencies, risks, validation approach, task decision notes.

The `technical_refs` frontmatter field links to external technical artifacts (OpenAPI specs, schemas, contracts) that live outside `agent-harness/`.

The `test_refs` frontmatter field is populated by the agent during implementation — it lists paths to test files that cover each acceptance criterion. A plan step is not done until `test_refs` is populated or each AC is covered by a Task validation command.

### Task

Execution unit derived from a Spec. Tasks are not the source of truth for behavior — Specs are.  
Must always be created from an approved Spec. Not always required — see [04-workflows.md](04-workflows.md).

**Statuses:** `draft` → `ready` → `planned` → `in-progress` → `done` → `blocked` → `archived` → `rejected`  
**Location:** `agent-harness/tasks/active/TASK-*.md`  
**Template:** `agent-harness/templates/TASK-template.md`

Task frontmatter includes `allowed_paths` and `forbidden_paths` to constrain implementation scope.

### Implementation Plan

Defines how implementation will proceed. Required before any code changes.

**Statuses:** `proposed` → `review` → `approved` → `in-progress` → `done` → `rejected` → `archived`  
**Location:** `agent-harness/implementation-plans/active/PLAN-*.md`  
**Template:** `agent-harness/templates/IMPLEMENTATION-PLAN-template.md`

Each plan step must define: Tasks (or "inline"), expected files, validation, risk level, and a suggested commit boundary.

### Review

Evaluates artifacts, plans, implementations, or process results.

**Outcomes:** `accepted` | `accepted-with-notes` | `changes-requested` | `rejected` | `follow-up-required`  
**Location:** `agent-harness/reviews/active/REVIEW-*.md`  
**Template:** `agent-harness/templates/REVIEW-template.md`

### Harness Improvement

Changes the process itself. Triggered by Review findings.

**Statuses:** `proposed` → `approved` → `in-progress` → `done` → `rejected` → `archived`  
**Location:** `agent-harness/improvements/active/IMPROVEMENT-*.md`  
**Template:** `agent-harness/templates/IMPROVEMENT-template.md`

### Legacy Finding

Records evidence extracted from legacy projects.

**Statuses:** `draft` → `reviewed` → `converted` → `archived` → `rejected`  
**Location:** `agent-harness/legacy/active/LEGACY-FINDING-*.md`  
**Template:** `agent-harness/templates/LEGACY-FINDING-template.md`

Must distinguish: observed behavior, documented behavior, inferred intent, accidental complexity, dead or uncertain code.

## Readiness Checklists

Every artifact template contains a Readiness Checklist. Before the agent advances an artifact
to its gate status, every checklist item must be checked. A single unchecked item blocks the
status change.

| Artifact | Gate status | Checklist section |
|---|---|---|
| Use Case | `ready-for-spec` | `## Readiness Checklist` |
| Spec | `approved` | `## Readiness Checklist` |
| Task | `ready` | `## Readiness Checklist` |
| Implementation Plan | `approved` | `## Readiness Checks` |

## Artifact Maturity

An artifact is mature enough to proceed when its status is at an accepted level:

| Artifact | Required Status Before Next Step |
|---|---|
| Use Case | `ready-for-spec` or `approved` |
| Spec | `approved` |
| Task | `ready` or `planned` |
| Implementation Plan | `approved` |

## Initiatives

Initiatives group related Use Cases and Plans under a shared goal. They are not standalone
artifacts — they live as named sections in `CATALOG.md`. See `agent-harness/OUTPUTS.md` for
the initiative entry format.
