# OUTPUTS.md

## Artifact Language

Normalized artifacts are written in English by default.

This applies to:

- Ideas
- Use Cases
- Specs
- Tasks
- Implementation Plans
- Reviews
- Improvements
- Legacy Findings
- Source Maps

Original-language content may be preserved in:

- Transcripts
- Raw notes
- Quoted source excerpts
- Evidence snippets

## Artifact Format

All harness artifacts use YAML frontmatter for metadata and Markdown for the body.

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

New artifacts are created in `active/`.
Move artifacts between subfolders as their status changes — do not rename the file ID.
