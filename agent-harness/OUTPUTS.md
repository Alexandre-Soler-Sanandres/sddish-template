# OUTPUTS.md

## Purpose

Defines the portable v2 artifact layout, identity, and lifecycle representation.

## Artifact format

Lifecycle artifacts use YAML frontmatter followed by Markdown. `id` is immutable and filenames use the canonical
ID pattern below. Status is frontmatter only: a status change edits the same file and never changes its path.

| Type | Path | Filename |
| --- | --- | --- |
| Change Spec | `harness-data/artifacts/changes/` | `CHANGE-NNNN.md` |
| Use Case | `harness-data/artifacts/use-cases/` | `UC-NNNN.md` |
| Spec | `harness-data/artifacts/specs/` | `SPEC-NNNN.md` |
| Task | `harness-data/artifacts/tasks/` | `TASK-NNNN.md` |
| Implementation Plan | `harness-data/artifacts/plans/` | `PLAN-NNNN.md` |
| Review | `harness-data/artifacts/reviews/` | `REVIEW-NNNN.md` |
| Improvement | `harness-data/artifacts/improvements/` | `IMPROVEMENT-NNNN.md` |
| Idea | `harness-data/artifacts/ideas/` | `IDEA-NNNN.md` |
| Transcript | `harness-data/artifacts/transcripts/` | `TRANSCRIPT-NNNN.md` |
| ADR | `harness-data/artifacts/adrs/` | `ADR-NNNN.md` |
| Questions | `harness-data/artifacts/questions/QUESTIONS.md` | registry rows `Q-NNNN` |

## Canonical relationships

Use only canonical forward ID links: `source_ids`, `related_adrs`, `question_refs`, and, on an execution
coordinator, `included_ids`. Internal values are IDs, never paths; every ID resolves exactly once. Requirement IDs
are local to their artifact and evidence names the requirement it proves. External material belongs in described
`external_refs`. Reverse links, derived-child lists, and handwritten backlinks are generated views, not canonical
metadata.

## Rules

| ID | Rule |
| --- | --- |
| OUT-01-010 | Lifecycle artifacts MUST use YAML frontmatter and Markdown. |
| OUT-03-010 | Artifact filenames MUST follow this file's canonical patterns. |
| OUT-03-020 | Artifact IDs MUST remain stable. |
| OUT-04-010 | Artifact paths MUST be stable by type and MUST NOT encode lifecycle status. |
| OUT-04-020 | A lifecycle transition MUST update frontmatter status in place. |
| OUT-08-010 | Questions MUST be rows in the single registry and MUST NOT use status-specific files or folders. |
| OUT-09-010 | Canonical internal relationship fields MUST contain IDs, not paths or handwritten reverse links. |

### Legacy (v1)

Retained verbatim from the pre-v2 paired rules for active v1 artifact chains during the v2 cutover
(`IMPROVEMENT-0148`–`0150`). The v2 rows above are authoritative for all new work; where a `-v1` row conflicts
with a v2 row (notably folder-move lifecycle vs frontmatter-in-place), the v2 row governs. These `-v1` rows are
retired by `IMPROVEMENT-0150`. IDs carry a `-v1` suffix.

| ID | Rule |
| --- | --- |
| OUT-01-010-v1 | All lifecycle artifacts MUST use YAML frontmatter for metadata and Markdown for the body. |
| OUT-02-010-v1 | `agent-harness/README.md` is the harness overview, not a lifecycle artifact. |
| OUT-02-020-v1 | MUST NOT create directory-scoped README files as harness artifacts — use mode files, templates, `CATALOG.md`, and scoped restart artifacts (`SOURCE-MAP.md`, `SUMMARY.md`) for harness guidance instead. |
| OUT-03-010-v1 | Artifact filenames MUST follow the canonical naming patterns in `OUTPUTS.md`'s `## File Naming Conventions`. |
| OUT-03-020-v1 | IDs MUST remain stable even if filenames or folders change. |
| OUT-04-010-v1 | New artifacts MUST be created in `active/` unless a mode explicitly defines a different starting location. |
| OUT-04-020-v1 | MUST move artifacts between lifecycle subfolders as their status changes, without renaming the file ID. |
| OUT-05-010-v1 | For Improvements, `done/` means the approved target changes are applied and the artifact records a `## Validation Result` confirming what was checked. |
| OUT-06-010-v1 | Legacy Discovery artifacts MUST use the scoped folder structure defined in `OUTPUTS.md`'s `## Legacy Discovery Structure`. |
| OUT-07-010-v1 | ADRs use `proposed/` / `accepted/` / `archive/` instead of the generic `active/`/`archive/` pair — see `OUTPUTS.md`'s `## Folder Structure`. |
| OUT-08-010-v1 | The Questions registry does not use lifecycle subfolders. It is three flat files under `harness-data/artifacts/questions/`; a row's file *is* its status — see `agent-harness/artifact-specs/QUESTIONS.md`. |
| OUT-09-010-v1 | Change Specs MUST use the common `active/`, `ready/`, `done/`, and `archive/` lifecycle folders. |
