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
12. Universal playbook index — only when the task may match a recurring cross-project procedure
13. Project playbook index — only when the task may match a repo-specific recurring procedure or subsystem workflow
14. Project guide index — only when the task may depend on local setup, tooling usage, or operating context
15. Matched support files — only when the relevant index points to them
16. Archived artifacts — only when explicitly needed

In many cases, you can stop at step 6.

## Core Rules

- **Agents start from the explicitly referenced artifact** — they do not scan entire directories by default
- **Agents use the smallest sufficient context** — they load only what the current task requires
- **Agents use frontmatter links to navigate** — `source`, `derived_*`, `related` fields point to related artifacts
- **Agents keep frontmatter links synchronized** — when creating or updating a derived artifact, they update the corresponding parent/child links in the same pass
- **Agents use `CATALOG.md` to locate artifacts** when the target is unknown or ambiguous
- **Agents use local `SUMMARY.md` files** only when the target artifact cannot be identified from CATALOG.md alone
- **Agents use `REPO-MAP.md` only for large-structure help** — it is optional, structural, and should not become a second catalog
- **Agents prefer frontmatter before full body** when only metadata is needed
- **Agents summarize findings** when context becomes large

## Always Load

These files are always loaded by the agent regardless of mode:

- `agent-harness/CORE.md` — universal rules
- `agent-harness/OUTPUTS.md` — artifact formats and folder structure
- The active mode file

For agent behavior, this is the minimum harness checkpoint before high-impact work.

## Load When Relevant

Reference files are loaded only when needed — not by default:

- `harness-data/reference/DOMAIN.md` — when domain concepts or terminology are involved
- `harness-data/reference/ARCHITECTURE.md` — when validating scope, boundaries, or allowed paths
- `harness-data/reference/TOOLING.md` — when running validation commands (Implementing mode)
- `harness-data/reference/QUALITY.md` — when checking definition of done (Implementing mode)

Support-file discovery starts from these index files:

- `agent-harness/playbooks/index.yaml`
- `harness-data/playbooks/index.yaml`
- `harness-data/guides/index.yaml`

See [10-guides.md](10-guides.md) and [11-project-playbooks.md](11-project-playbooks.md) for the meaning of each support-file type.

## Support-File Selection

Agents should check support files in this order:

1. If the task may match a reusable cross-project procedure, check `agent-harness/playbooks/index.yaml`.
2. If the task may match a repo-specific recurring procedure, check `harness-data/playbooks/index.yaml`.
3. If the task may depend on local setup or operating knowledge, check `harness-data/guides/index.yaml`.
4. Load only the files matched by those index entries.
5. Stop when the smallest sufficient support-file set is loaded.

Use this precedence when more than one support file applies:

- `CORE.md` and the active mode file
- universal playbooks
- project playbooks
- guides

Project playbooks refine the generic procedure for this repository.
Guides provide local operating context.
Neither may override core rules, mode boundaries, or approval gates.

Each index entry should stay minimal. Use:

- `file` — the support file to load
- `when` — short matching conditions
- `paths` — optional path hints when they improve matching

## Support-File Examples

| Task shape | Load |
| --- | --- |
| reviewing code changes | `agent-harness/playbooks/index.yaml` -> `code-review.md` |
| investigating a product bug | `agent-harness/playbooks/index.yaml` -> `bug-investigation.md` |
| triaging a flaky test | `agent-harness/playbooks/index.yaml` -> `flaky-test-triage.md` |
| upgrading a dependency | `agent-harness/playbooks/index.yaml` -> `dependency-upgrade.md` |
| moving or renaming repo structure | `agent-harness/playbooks/index.yaml` -> `repo-structure-change.md` |
| planning or reviewing a schema migration | `agent-harness/playbooks/index.yaml` -> `database-migration-safety.md` |
| running Python with `uv` in this repo | `harness-data/guides/index.yaml` -> matching guide |
| following one subsystem's local rollout flow | `harness-data/playbooks/index.yaml` -> matching playbook |

## CATALOG.md

`agent-harness/CATALOG.md` is a tiny navigation file — not a god-index. It lists:

- Where each artifact type lives

It must not list hundreds of individual artifacts. Use frontmatter links and SUMMARY files for that.

There are two files named `CATALOG.md`, and they do different jobs:

- `agent-harness/CATALOG.md` explains the universal artifact locations and restart-point conventions.
- `harness-data/CATALOG.md` is project-local bookkeeping, such as active Plan pointers required by some rules in `CORE.md`.

Lifecycle artifacts live under `harness-data/artifacts/`. Project support files such as `reference/`, `guides/`, and
`playbooks/` stay at the root of `harness-data/`. Harness-owned reusable procedures live under `agent-harness/playbooks/`.
Agents should check the support-file indexes before opening support files broadly.

## REPO-MAP.md

An optional `REPO-MAP.md` may exist at repo root or a major subtree when the codebase is large enough that normal
artifact navigation is not sufficient.

Agents should treat it as durable structural context only:

- major subsystems
- important boundaries
- key entrypoints
- major dependencies across areas

It should not be used as a file dump, changelog, or session scratchpad. Agents should update it only when structure
changes materially, not on every run.

## RUN-LOG.md

An optional `harness-data/RUN-LOG.md` may exist for interrupted, approval-heavy, multi-step, or high-risk work. It is
not required by default, but the agent may use it when temporary operational trace helps safe continuation. The one
mandatory case is the `IMPL-028` gate-check line, written before the first file mutation of any plan step.

When the agent uses it, it serves as a rolling operational log for:

- context actually loaded when that matters for safe resume
- approvals
- interruptions and resumptions
- validation checkpoints
- commands or checks run
- stop reason
- temporary execution notes needed to continue safely

It is not a source-of-truth artifact. Keep it small, and collapse it to a short closure note or clear it when the
work finishes.

For short, low-risk work that is unlikely to be resumed later, agents can skip it.

## Resume Discipline

After a pause, interruption, or context compaction, agents should:

- reload the active mode and restart artifact
- re-check whether a newer artifact or status change changed the correct restart point
- re-check any validations that were still uncertain when the work paused

The last conversational state alone should not be treated as a safe restart point without this mini-checkpoint.

## SUMMARY.md Files

Local `SUMMARY.md` files may exist in artifact directories (e.g. `harness-data/artifacts/specs/SUMMARY.md`) when the number of artifacts makes navigation difficult. They are created on demand — not required upfront.

SUMMARY files are not indexes of everything. They are lightweight navigation aids for finding an artifact when its ID is not known.

If the exact artifact path is already known, the agent does not need to open a summary just because it exists.

## Why This Matters

Loading too much context:

- Reduces precision — the agent loses focus on the current task
- Wastes tokens — irrelevant artifacts consume context
- Increases hallucination risk — more context to get confused by

The harness enforces context discipline through mode boundaries, reference file sections, and the smallest-sufficient-context rule.
