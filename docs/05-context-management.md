# Context Management

Agents have limited context windows. The harness is designed to keep context small and precise — not to load everything at once.

## Core Rules

- **Start from the explicitly referenced artifact** — do not scan entire directories
- **Use the smallest sufficient context** — load only what the current task requires
- **Use frontmatter links to navigate** — `source`, `derived_*`, `related` fields point to related artifacts
- **Use `CATALOG.md` to locate artifacts** when the target is unknown or ambiguous
- **Use local `SUMMARY.md` files** only when the target artifact cannot be identified from CATALOG.md alone

## Always Load

These files are always loaded regardless of mode:

- `agent-harness/CORE.md` — universal rules
- `agent-harness/OUTPUTS.md` — artifact formats and folder structure
- The active mode file

## Load When Relevant

Reference files are loaded only when needed — not by default:

- `agent-harness/reference/DOMAIN.md` — when domain concepts or terminology are involved
- `agent-harness/reference/ARCHITECTURE.md` — when validating scope, boundaries, or allowed paths
- `agent-harness/reference/TOOLING.md` — when running validation commands (Implementation mode)
- `agent-harness/reference/QUALITY.md` — when checking definition of done (Implementation mode)

## CATALOG.md

`agent-harness/CATALOG.md` is a tiny navigation file — not a god-index. It lists:
- Where each artifact type lives
- Which high-level initiatives are currently active

It must not list hundreds of individual artifacts. Use frontmatter links and SUMMARY files for that.

## SUMMARY.md Files

Local `SUMMARY.md` files may exist in artifact directories (e.g. `agent-harness/specs/SUMMARY.md`) when the number of artifacts makes navigation difficult. They are created on demand — not required upfront.

SUMMARY files are not indexes of everything. They are lightweight navigation aids for finding an artifact when its ID is not known.

## Why This Matters

Loading too much context:
- Reduces precision — the agent loses focus on the current task
- Wastes tokens — irrelevant artifacts consume context
- Increases hallucination risk — more context to get confused by

The harness enforces context discipline through mode boundaries, reference file sections, and the smallest-sufficient-context rule.
