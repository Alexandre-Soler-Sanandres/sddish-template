# OUTPUTS.md

## Purpose

Canonical output rules for harness artifacts: format, naming, placement, and lifecycle folders.
For artifact-language rules and closed-artifact rewrite rules, see `agent-harness/CORE.md`.

## Rules Map

This file's enforceable rules live in `agent-harness/rules/OUTPUTS.md` (single paired file, not grouped — `OUTPUTS.md`
has fewer than 25 rules). `OUTPUTS.md` is always loaded per `AGENTS.md`'s Always Follow list, so load
`agent-harness/rules/OUTPUTS.md` alongside it every time.

## Artifact Format

Lifecycle artifacts use YAML frontmatter for metadata and Markdown for the body.

## File Naming Conventions

| Artifact | Pattern |
| --- | --- |
| Transcript | `TRANSCRIPT-NNNN.md` |
| Idea | `IDEA-NNNN.md` |
| ADR | `ADR-NNNN.md` |
| Use Case | `UC-NNNN.md` |
| Spec | `SPEC-NNNN.md` |
| Change Spec | `CHANGE-NNNN.md` |
| Task | `TASK-NNNN.md` |
| Implementation Plan | `PLAN-NNNN.md` |
| Review | `REVIEW-NNNN.md` |
| Improvement | `IMPROVEMENT-NNNN.md` |
| Legacy Finding | `LF-<APP>-NNNN.md` (app findings) or `LF-CROSS-NNNN.md` (cross-system findings) — see `## Legacy Discovery Structure` |
| Question | Row ID `Q-NNNN` (new) or `Q-<APP>-NNNN` / `CSQ-NNNN` / `CSP-NNNN` — a row in `QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, or `QUESTIONS-DISCARDED.md`, not a separate file per question |

## Folder Structure

All lifecycle artifacts live under `harness-data/artifacts/`.

Within that root, each artifact directory uses subfolders to reflect lifecycle state. Change Spec, Use Case, Spec,
Task, and Implementation Plan share an identical four-folder shape (`active/`/`ready/`/`done/`/`archive/`) — see
`systems/LIFECYCLE-FOLDERS.md` for why this is now uniform rather than diverging per artifact type.

| Subfolder | Used in | Meaning |
| --- | --- | --- |
| `active/` | all artifact dirs except `adrs/` and `questions/` | artifact is in progress or under review |
| `archive/` | all artifact dirs except `questions/` | artifact is closed, superseded or no longer relevant |
| `ready/` | `change-specs/`, `specs/`, `use-cases/`, `tasks/`, `implementation-plans/` | artifact has passed its Readiness Checklist/Checks and may be relied on by the next tier or by Implementing |
| `done/` | `change-specs/`, `specs/`, `use-cases/`, `implementation-plans/`, `tasks/`, `improvements/` | execution is complete |
| `proposed/` | `adrs/` | not yet settled |
| `accepted/` | `adrs/` | in force, citable authority |

`adrs/` uses `proposed/` / `accepted/` / `archive/` instead of the generic `active/`/`archive/` pair (`OUT-07-010`).
`questions/` has no lifecycle subfolders at all — it is three flat files, one per status (`OUT-08-010`). See
`agent-harness/systems/LIFECYCLE-FOLDERS.md` for why these shapes diverge and how each artifact's `status` field
and folder location move together.

## Legacy Discovery Structure

Legacy Discovery uses scoped folders:

- App-specific discovery: `harness-data/artifacts/legacy/apps/<legacy-app-slug>/`
- Cross-system synthesis: `harness-data/artifacts/legacy/cross-system/`

Detailed Legacy Discovery layout and rules are defined in
`agent-harness/modes/DISCOVERING-LEGACY.md`.
