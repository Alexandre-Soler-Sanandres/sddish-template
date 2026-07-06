# SDD-ish Agent Harness

A file-based process harness for working with AI agents on software development tasks.
The project is intentionally SDD-ish rather than rigidly spec-driven.

## License

Unless otherwise noted, the harness content is licensed under [CC BY-NC 4.0](LICENSE).

Copyright (c) 2026 Alexandre Soler Sanandres.

## What It Is

The SDD-ish Agent Harness gives AI agents a clear operating context, defining what they are allowed to do, what artifacts they produce, and how they hand off to the next stage.

Without structure, agents drift: they implement before requirements are clear, mix concerns across artifacts, and lose traceability between decisions and code. The harness prevents this through explicit modes, bounded artifacts, and structured handoffs.

## The Core Idea

No code without a Spec. No Spec without a Use Case. No implementation without an approved plan.

```text
Voice / Text / Ideas
  → Partnering
  → Refining (Use Case → Spec → [Tasks, when required])
  → Planning-Implementation (approved plan)
  → Implementing
  → Validation
  → [Review / Improving-Harness — when a team wants formal evaluation or process correction]
```

Every persistent artifact lives in Markdown, every file is traceable to its source, and every implementation starts from an approved plan.

## Modes

A Mode is a true, distinct behavioral posture — only one is active at a time. Artifact schemas (ADR, Use Case,
Spec, Task, Review, Improvement, Question, ...) are defined separately as artifact specs, and Validation is a
shared procedure, not a mode — see [docs/01-core-principles.md](docs/01-core-principles.md).

| Mode | Purpose |
| --- | --- |
| Partnering | Structured conversation to capture ideas and problems |
| Refining | Derive a Spec from a Use Case, or Tasks from a Spec |
| Planning-Implementation | Plan and gate code changes |
| Implementing | Execute an approved plan |
| Discovering-Legacy | Extract evidence from existing code |
| Improving-Harness | Change the harness itself |

## Repository Structure

The harness spans two top-level roots. `agent-harness/` is the portable definition — the same for every project
using this harness, and the only thing that syncs to or from the template repo:

``` text
agent-harness/
  README.md            ← harness overview
  CORE.md              ← universal rules (always loaded)
  OUTPUTS.md           ← artifact formats and folder structure (always loaded)
  CATALOG.md           ← universal navigation: where artifacts live
  docs/                ← harness documentation and human guides
  modes/               ← one file per Mode (universal, stack-neutral)
  artifact-specs/      ← one file per artifact type: schema, creation trigger, lifecycle gate
  shared-procs/        ← procedures invoked by name from within a Mode (e.g. Validation)
  playbooks/           ← optional universal reusable procedures + index.yaml
  templates/           ← artifact templates
```

`harness-data/` is this project's own data. It holds both project-owned support files and the lifecycle artifacts
the harness creates while the project uses it. Nothing here is ever copied into or out of the template:

``` text
harness-data/
  CATALOG.md           ← this project's live state (e.g. active Implementation Plans)
  RUN-LOG.md           ← optional operational trace the agent may use for interrupted or higher-risk work
  REPO-MAP.md          ← optional structural context for large repos
  reference/           ← project-specific (fill these in)
    ARCHITECTURE.md
    DOMAIN.md
    TOOLING.md
    QUALITY.md
  guides/              ← optional project-specific setup and operating guidance + index.yaml
  playbooks/           ← optional project-specific scoped procedures + index.yaml
  artifacts/           ← lifecycle artifacts generated and maintained through harness modes
    transcripts/
    ideas/
    adrs/
    use-cases/
    specs/
    tasks/
    implementation-plans/
    reviews/
    improvements/
    questions/
    legacy/
```

A third, thin layer wires the harness into each agent's own CLI: `.claude/skills/harness/` for Claude Code and
`.agents/skills/harness/` for Codex CLI, one skill per mode/artifact entry point. These are per-agent invocation
wrappers, not harness logic — each just names the mode or artifact-spec file to follow.

## Getting Started

When using the harness as a GitHub template, click **Use this template** to create a new repository with the full
harness structure and a clean git history. Alternatively, clone it locally and reinitialize git:

```bash
git clone <template-url> your-project
cd your-project
rm -rf .git && git init
```

Then fill in the four project-specific reference files in `harness-data/reference/` and start with a Partnering or
Use Case session. Use the Minimum Viable Adoption section in [docs/07-adoption.md](docs/07-adoption.md) for the
smallest useful first pass and the same guide for full adoption instructions.

## Documentation

| Document | Contents |
| --- | --- |
| [docs/01-core-principles.md](docs/01-core-principles.md) | Start here for why the harness exists, what problems it is trying to prevent, and how Modes/artifact specs/shared procedures relate |
| [docs/02-modes.md](docs/02-modes.md) | Use this when you need to know which mode you are in and what it allows |
| [docs/03-artifacts.md](docs/03-artifacts.md) | Use this to check what file should exist, what it contains, and what status it should have |
| [docs/04-shared-procs.md](docs/04-shared-procs.md) | Use this to understand Validation and other procedures invoked from within a Mode |
| [docs/05-workflows.md](docs/05-workflows.md) | Use this for the normal flow from idea to implementation and for Task/Plan decisions |
| [docs/06-context-management.md](docs/06-context-management.md) | Use this when deciding what to load into context and when to use `CATALOG.md`, `SUMMARY.md`, or `RUN-LOG.md` |
| [docs/07-adoption.md](docs/07-adoption.md) | Use this when adopting the harness in a new or existing repository |
| [docs/08-glossary.md](docs/08-glossary.md) | Use this when a harness term is unclear |
| [docs/09-legacy-applications.md](docs/09-legacy-applications.md) | Use this for practical legacy discovery work in an existing codebase |
| [docs/10-guides.md](docs/10-guides.md) | Use this to understand project-specific setup and operating guides under `harness-data/guides/` |
| [docs/11-project-playbooks.md](docs/11-project-playbooks.md) | Use this to understand project-specific scoped procedures under `harness-data/playbooks/` |

## Key Principles

- **Modes are universal** — mode files work for any tech stack without modification
- **References are project-specific** — architecture, domain, tooling, and quality vary per project
- **Guides are project-specific** — setup and operating guidance stays local to each adopting repository
- **Project playbooks are project-specific** — scoped procedures live under `harness-data/`, not in the universal harness
- **Support files are selective context** — agents consult support-file `index.yaml` files and load only the matched guides or playbooks they need
- **Lifecycle artifacts are separate** — harness-managed project artifacts live under `harness-data/artifacts/`
- **Artifacts over memory** — everything lives in files, not agent context
- **Explicit gates** — implementation requires an approved plan; no exceptions
- **Smallest sufficient context** — agents load only what they need
- **Process improves itself when needed** — Review and Improving-Harness exist for teams that want a stronger formal loop
