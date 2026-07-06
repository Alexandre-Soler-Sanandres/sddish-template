# OUTPUTS.md

## Purpose

Canonical output rules for harness artifacts: format, naming, placement, and lifecycle folders.
For artifact-language rules and closed-artifact rewrite rules, see `agent-harness/CORE.md`.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| OUT-001 | Format | All lifecycle artifacts use YAML frontmatter for metadata and Markdown for the body. |
| OUT-002 | Scope | `agent-harness/README.md` is the harness overview, not a lifecycle artifact. |
| OUT-003 | Scope | Do not create directory-scoped README files as harness artifacts. Use mode files, templates, `CATALOG.md`, and scoped restart artifacts such as `SOURCE-MAP.md` or `SUMMARY.md` for harness guidance. |
| OUT-004 | Naming | Artifact filenames must follow the canonical naming patterns in `## File Naming Conventions`. |
| OUT-005 | Naming | IDs must remain stable even if filenames or folders change. |
| OUT-006 | Lifecycle | New artifacts are created in `active/` unless a mode explicitly defines a different starting location. |
| OUT-007 | Lifecycle | Move artifacts between lifecycle subfolders as their status changes. Do not rename the file ID when moving them. |
| OUT-008 | Improvement-Lifecycle | For Improvements, `done/` means the approved target changes are applied and the artifact records a `## Validation Result` confirming what was checked. |
| OUT-009 | Legacy-Discovery | Legacy Discovery artifacts must use the scoped folder structure defined in `## Legacy Discovery Structure`. |
| OUT-010 | ADR-Lifecycle | ADRs use `proposed/` / `accepted/` / `archive/` instead of the generic `active/`/`archive/` pair — see `## Folder Structure`. |
| OUT-011 | Questions-Lifecycle | The Questions registry does not use lifecycle subfolders. It is three flat files under `harness-data/artifacts/questions/`; a row's file *is* its status — see `agent-harness/artifact-specs/QUESTIONS.md`. |

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
| `proposed/` | `adrs/` | not yet settled |
| `accepted/` | `adrs/` | in force, citable authority |

`adrs/` uses `proposed/` / `accepted/` / `archive/` instead of the generic `active/`/`archive/` pair (`OUT-010`).
`questions/` has no lifecycle subfolders at all — it is three flat files, one per status (`OUT-011`).

## Legacy Discovery Structure

Legacy Discovery uses scoped folders:

- App-specific discovery: `harness-data/artifacts/legacy/apps/<legacy-app-slug>/`
- Cross-system synthesis: `harness-data/artifacts/legacy/cross-system/`

Detailed Legacy Discovery layout and rules are defined in
`agent-harness/modes/DISCOVERING-LEGACY.md`.
