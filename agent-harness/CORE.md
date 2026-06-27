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
2. Use `agent-harness/CATALOG.md` to locate the artifact type and any active initiatives when the artifact identity is unknown or ambiguous.
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

## High-Risk Areas

Extra care is required when touching:

- database migrations
- security, secrets or auth
- deployment or infrastructure
- payment or financial transaction execution
- domain-critical business logic (define specifics in `agent-harness/reference/DOMAIN.md`)
