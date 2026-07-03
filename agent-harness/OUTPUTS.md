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

## Artifact Format

Lifecycle artifacts use YAML frontmatter for metadata and Markdown for the body.

## File Naming Conventions

| Artifact | Pattern |
| --- | --- |
| Transcript | `TRANSCRIPT-NNN.md` |
| Idea | `IDEA-NNN.md` |
| Use Case | `UC-NNN.md` |
| Spec | `SPEC-NNN.md` |
| Task | `TASK-NNN.md` |
| Implementation Plan | `PLAN-NNN.md` |
| Review | `REVIEW-NNN.md` |
| Improvement | `IMPROVEMENT-NNN.md` |
| Legacy Finding | `LEGACY-FINDING-NNN.md` |

IDs must remain stable even if filenames or folders change.

## Folder Structure

Each artifact directory uses subfolders to reflect lifecycle state.

| Subfolder | Used in | Meaning |
| --- | --- | --- |
| `active/` | all artifact dirs | artifact is in progress or under review |
| `archive/` | all artifact dirs | artifact is closed, superseded or no longer relevant |
| `approved/` | `implementation-plans/` | plan has been approved and is awaiting execution |
| `done/` | `implementation-plans/`, `tasks/`, `improvements/` | execution is complete |

## Legacy Discovery Structure

Legacy Discovery uses scoped folders:

- App-specific discovery: `harness-data/legacy/apps/<legacy-app-slug>/`
- Cross-system synthesis: `harness-data/legacy/cross-system/`

Detailed Legacy Discovery layout and rules are defined in
`agent-harness/modes/LEGACY-DISCOVERY.md`.
