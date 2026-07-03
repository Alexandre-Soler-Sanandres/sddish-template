# CATALOG.md

## Artifact Locations

These are the lifecycle-managed artifact roots under `harness-data/artifacts/`. Project-owned support files such as
`harness-data/reference/`, `harness-data/guides/`, and `harness-data/playbooks/` are not listed here because they are
not lifecycle artifacts.

Support-file discovery uses these index files instead:

- `agent-harness/playbooks/index.yaml`
- `harness-data/playbooks/index.yaml`
- `harness-data/guides/index.yaml`

- Transcripts: `harness-data/artifacts/transcripts/`
- Ideas: `harness-data/artifacts/ideas/`
- Use Cases: `harness-data/artifacts/use-cases/`
- Specs: `harness-data/artifacts/specs/`
- Tasks: `harness-data/artifacts/tasks/`
- Implementation Plans: `harness-data/artifacts/implementation-plans/`
- Reviews: `harness-data/artifacts/reviews/`
- Improvements: `harness-data/artifacts/improvements/`
- ADRs: `harness-data/artifacts/adrs/`
- Legacy: `harness-data/artifacts/legacy/`
  - Legacy app discovery: `harness-data/artifacts/legacy/apps/<legacy-app-slug>/` with `SOURCE-MAP.md` as the restart point
  - Cross-system legacy synthesis: `harness-data/artifacts/legacy/cross-system/` with `SUMMARY.md` as the restart point

Live per-project state (e.g. active Implementation Plan pointers) is tracked in `harness-data/CATALOG.md`, not
here.

## Loading Rule

Start from the explicitly referenced artifact.
Use frontmatter links to navigate to related artifacts.
Load this file (`agent-harness/CATALOG.md`) when the artifact's type is known but its location or root folder is
not — it resolves type to folder.
Use a local `SUMMARY.md` file only when the target artifact within that folder is still unknown or ambiguous — these
are created per-directory as needed and are not required upfront.
