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
