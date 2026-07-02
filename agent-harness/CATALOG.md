# CATALOG.md

## Artifact Locations

- Transcripts: `harness-data/transcripts/`
- Ideas: `harness-data/ideas/`
- Use Cases: `harness-data/use-cases/`
- Specs: `harness-data/specs/`
- Tasks: `harness-data/tasks/`
- Implementation Plans: `harness-data/implementation-plans/`
- Reviews: `harness-data/reviews/`
- Improvements: `harness-data/improvements/`
- Legacy: `harness-data/legacy/`
  - Legacy app discovery: `harness-data/legacy/apps/<legacy-app-slug>/` with `SOURCE-MAP.md` as the restart point
  - Cross-system legacy synthesis: `harness-data/legacy/cross-system/` with `SUMMARY.md` as the restart point

Live per-project state (e.g. active Implementation Plan pointers) is tracked in `harness-data/CATALOG.md`, not
here.

## Loading Rule

Start from the explicitly referenced artifact.
Use frontmatter links to navigate to related artifacts.
Use a local `SUMMARY.md` file only when the target artifact is unknown or ambiguous — these are created per-directory as needed and are not required upfront.
