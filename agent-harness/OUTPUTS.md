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
| Transcript | `TRANSCRIPT-NNN.md` |
| Idea | `IDEA-NNN.md` |
| ADR | `ADR-NNN.md` |
| Use Case | `UC-NNN.md` |
| Spec | `SPEC-NNN.md` |
| Task | `TASK-NNN.md` |
| Implementation Plan | `PLAN-NNN.md` |
| Review | `REVIEW-NNN.md` |
| Improvement | `IMPROVEMENT-NNN.md` |
| Legacy Finding | `LF-<APP>-NNN.md` (app findings) or `LF-CROSS-NNN.md` (cross-system findings) — see `## Legacy Discovery Structure` |
| Question | Row ID `Q-NNN` (new) or `Q-<APP>-NNN` / `CSQ-NNN` / `CSP-*` (migrated legacy) — a row in `QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, or `QUESTIONS-DISCARDED.md`, not a separate file per question |

## Folder Structure

All lifecycle artifacts live under `harness-data/artifacts/`.

Within that root, each artifact directory uses subfolders to reflect lifecycle state.

| Subfolder | Used in | Meaning |
| --- | --- | --- |
| `active/` | all artifact dirs except `adrs/` and `questions/` | artifact is in progress or under review |
| `archive/` | all artifact dirs except `questions/` | artifact is closed, superseded or no longer relevant |
| `approved/` | `implementation-plans/` | plan has been approved and is awaiting execution |
| `done/` | `implementation-plans/`, `tasks/`, `improvements/` | execution is complete |
| `implemented/` | `specs/`, `use-cases/` | described behavior now exists in code and remains citable authority |
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
