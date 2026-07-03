# Context Management

Agents have limited context windows. The harness is designed to keep context small and precise — not to load everything at once.

For most tasks, you do not need a repo tour. You need the current request, the harness rules that always apply, the active mode, and the specific artifact you were asked to touch.

## Default Context Loading Order

When an agent starts a task, it loads context in this order — stopping as soon as it has enough:

1. User request
2. Root loader file (`AGENTS.md`)
3. `agent-harness/CORE.md`
4. `agent-harness/OUTPUTS.md`
5. Active mode file
6. Explicitly referenced artifact
7. Frontmatter links (`source`, `derived_*`, `related`)
8. Local `SUMMARY.md` if the target artifact is ambiguous
9. Full related artifact — only if required
10. `REPO-MAP.md` — only when repo size or subsystem sprawl makes normal navigation clumsy
11. Reference files — only when affected by the current task
12. Project guides or project playbooks — only when the task depends on local setup, operating guidance, or scoped procedures
13. Archived artifacts — only when explicitly needed

In many cases, you can stop at step 6.

## Core Rules

- **Start from the explicitly referenced artifact** — do not scan entire directories
- **Use the smallest sufficient context** — load only what the current task requires
- **Use frontmatter links to navigate** — `source`, `derived_*`, `related` fields point to related artifacts
- **Keep frontmatter links synchronized** — when creating or updating a derived artifact, update the corresponding parent/child links in the same pass
- **Use `CATALOG.md` to locate artifacts** when the target is unknown or ambiguous
- **Use local `SUMMARY.md` files** only when the target artifact cannot be identified from CATALOG.md alone
- **Use `REPO-MAP.md` only for large-structure help** — it is optional, structural, and should not become a second catalog
- **Prefer frontmatter before full body** when only metadata is needed
- **Summarize findings** when context becomes large

## Always Load

These files are always loaded regardless of mode:

- `agent-harness/CORE.md` — universal rules
- `agent-harness/OUTPUTS.md` — artifact formats and folder structure
- The active mode file

Treat this as the minimum harness checkpoint before high-impact work.

## Load When Relevant

Reference files are loaded only when needed — not by default:

- `harness-data/reference/DOMAIN.md` — when domain concepts or terminology are involved
- `harness-data/reference/ARCHITECTURE.md` — when validating scope, boundaries, or allowed paths
- `harness-data/reference/TOOLING.md` — when running validation commands (Implementation mode)
- `harness-data/reference/QUALITY.md` — when checking definition of done (Implementation mode)

Project-local supporting files are also loaded only when needed — not by default:

- `harness-data/guides/` — when the task depends on project-specific setup, tooling usage, bootstrap steps, or local operating quirks
- `harness-data/playbooks/` — when the task matches a recurring project-specific procedure or subsystem workflow

See [09-guides.md](09-guides.md) and [10-playbooks.md](10-playbooks.md) for when to create these files and how agents should use them.

## CATALOG.md

`agent-harness/CATALOG.md` is a tiny navigation file — not a god-index. It lists:

- Where each artifact type lives

It must not list hundreds of individual artifacts. Use frontmatter links and SUMMARY files for that.

There are two files named `CATALOG.md`, and they do different jobs:

- `agent-harness/CATALOG.md` explains the universal artifact locations and restart-point conventions.
- `harness-data/CATALOG.md` is project-local bookkeeping, such as active Plan pointers required by some rules in `CORE.md`.

Lifecycle artifacts live under `harness-data/artifacts/`. Project support files such as `reference/`, `guides/`, and
`playbooks/` stay at the root of `harness-data/` and are loaded only when relevant.

## REPO-MAP.md

An optional `REPO-MAP.md` may exist at repo root or a major subtree when the codebase is large enough that normal
artifact navigation is not sufficient.

Use it for durable structural context only:

- major subsystems
- important boundaries
- key entrypoints
- major dependencies across areas

Do not use it as a file dump, changelog, or session scratchpad. Update it when structure changes materially, not on
every run.

## RUN-LOG.md

An optional `harness-data/RUN-LOG.md` may exist for interrupted, approval-heavy, multi-step, or high-risk work. It is
not required by default, but the agent may use it when temporary operational trace helps safe continuation.

Use it as a rolling operational log for:

- context actually loaded when that matters for safe resume
- approvals
- interruptions and resumptions
- validation checkpoints
- commands or checks run
- stop reason
- temporary execution notes needed to continue safely

It is not a source-of-truth artifact. Keep it small, and collapse it to a short closure note or clear it when the
work finishes.

If the work is short, low-risk, and unlikely to be resumed later, skip it.

## Resume Discipline

After a pause, interruption, or context compaction:

- reload the active mode and restart artifact
- re-check whether a newer artifact or status change changed the correct restart point
- re-check any validations that were still uncertain when the work paused

Do not assume the last conversational state is still safe to continue from without this mini-checkpoint.

## SUMMARY.md Files

Local `SUMMARY.md` files may exist in artifact directories (e.g. `harness-data/artifacts/specs/SUMMARY.md`) when the number of artifacts makes navigation difficult. They are created on demand — not required upfront.

SUMMARY files are not indexes of everything. They are lightweight navigation aids for finding an artifact when its ID is not known.

If you already know the exact artifact path, do not open a summary just because it exists.

## Why This Matters

Loading too much context:

- Reduces precision — the agent loses focus on the current task
- Wastes tokens — irrelevant artifacts consume context
- Increases hallucination risk — more context to get confused by

The harness enforces context discipline through mode boundaries, reference file sections, and the smallest-sufficient-context rule.
