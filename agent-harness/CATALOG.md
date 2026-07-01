# CATALOG.md

## Artifact Locations

- Transcripts: `agent-harness/transcripts/`
- Ideas: `agent-harness/ideas/`
- Use Cases: `agent-harness/use-cases/`
- Specs: `agent-harness/specs/`
- Tasks: `agent-harness/tasks/`
- Implementation Plans: `agent-harness/implementation-plans/`
- Reviews: `agent-harness/reviews/`
- Improvements: `agent-harness/improvements/`
- Legacy: `agent-harness/legacy/`
  - Legacy app discovery: `agent-harness/legacy/apps/<legacy-app-slug>/` with `SOURCE-MAP.md` as the restart point
  - Cross-system legacy synthesis: `agent-harness/legacy/cross-system/` with `SUMMARY.md` as the restart point

## Loading Rule

Start from the explicitly referenced artifact.
Use frontmatter links to navigate to related artifacts.
Use a local `SUMMARY.md` file only when the target artifact is unknown or ambiguous — these are created per-directory as needed and are not required upfront.
