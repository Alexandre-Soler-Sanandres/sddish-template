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
`agent-harness/README.md` is the harness overview, not a lifecycle artifact. Do not create directory-scoped README
files as harness artifacts; use mode files, templates, `CATALOG.md`, and scoped restart artifacts such as
`SOURCE-MAP.md` or `SUMMARY.md` for harness guidance.

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
For Improvements, `done/` means the approved target changes are applied and the artifact records a
`## Validation Result` confirming what was checked.

## Legacy Discovery Structure

Legacy Discovery uses scoped folders:

- App-specific discovery: `agent-harness/legacy/apps/<legacy-app-slug>/`
- Cross-system synthesis: `agent-harness/legacy/cross-system/`

Detailed Legacy Discovery layout and rules are defined in
`agent-harness/modes/LEGACY-DISCOVERY.md`.
