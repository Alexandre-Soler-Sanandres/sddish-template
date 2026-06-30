# CORE.md

## Universal Rules

- Use the smallest sufficient context.
- Do not load unrelated artifact directories.
- Do not expose secrets.
- Do not run commands that are irreversible or have a wide blast radius (data loss, schema changes, production state changes, force operations) without explicit approval.
- Do not implement from Partnering mode.
- Do not implement before an accepted Implementation Plan exists.
- Preserve traceability across Use Cases, Specs, Tasks, Plans and Reviews.

## Context Loading

1. Start from the user request.
2. Use `agent-harness/CATALOG.md` to locate the artifact type when the artifact identity is unknown or ambiguous.
3. Load the explicitly referenced artifact.
4. Load the active mode file.
5. Load linked parent or child artifacts only when required.
6. Use summaries before full historical artifacts.
7. Load reference files only when the current work is directly affected.
8. Load archived artifacts only when explicitly needed.

## Artifact Language

Normalized artifacts are written in English by default.
Transcripts and quoted raw input may preserve the original language.

## Implementation Gate

Implementation may only start after:

- an Implementation Plan exists
- the plan is accepted (status: approved)
- required artifacts are at an accepted status — not draft or under review (e.g. Spec must be approved, Use Case must be ready-for-spec, Task must be ready)
- safety and risk rules are satisfied

## Context Checkpoint

Before any high-impact action, verify:

- What mode is active?
- Which artifact is the restart point?
- Does the latest user message explicitly authorize this action?
- Which files are in scope?
- What validation is required before stopping or committing?

High-impact actions that require this verification:

- Committing
- Changing harness mode files, templates, or reference process rules
- Creating Review or Improvement artifacts
- Changing source-map workflow or status rules
- Moving artifacts between lifecycle folders
- Starting cross-system synthesis

After a resume or context compaction, repeat the checkpoint before the next high-impact action.

## Commits

- Never commit unless the user explicitly requests it.
- When committing, follow the project's commit conventions in `agent-harness/reference/QUALITY.md`.

## High-Risk Areas

Extra care is required when touching:

- database migrations
- security, secrets or auth
- deployment or infrastructure
- payment or financial transaction execution
- domain-critical business logic (define specifics in `agent-harness/reference/DOMAIN.md`)

## Parallel Work

- Each Spec may have at most one Implementation Plan at status `approved` or `in-progress` at a time.
- Before approving a new Plan, check CATALOG.md for other Plans at `approved` or `in-progress`.
- If two active Plans have overlapping `allowed_paths` across their Tasks: stop. Surface the
  conflict — list both Plan IDs and the overlapping paths. Do not proceed until the user
  explicitly resolves it.
- Concurrent Plans on non-overlapping Specs are permitted without restriction.
- CATALOG.md must reflect all Plans at `approved` or `in-progress` status.
