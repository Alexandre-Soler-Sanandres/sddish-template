# SDD-ish Agent Harness

A file-based process harness for working with AI agents on software development tasks.
The project is intentionally SDD-ish rather than rigidly spec-driven.

## License

Unless otherwise noted, the content in this repository is licensed under
[CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/).

Copyright (c) 2026 Alexandre Soler Sanandres.

## What It Is

The SDD-ish Agent Harness gives AI agents a clear operating context, defining what they are allowed to do, what artifacts they produce, and how they hand off to the next stage.

Without structure, agents drift: they implement before requirements are clear, mix concerns across artifacts, and lose traceability between decisions and code. The harness prevents this through explicit modes, bounded artifacts, and structured handoffs.

## The Core Idea

No code without a Spec. No Spec without a Use Case. No implementation without an approved plan.

```text
Voice / Text / Ideas
  → Partnering
  → Use Case
  → Spec
  → [Tasks — when required]
  → Implementation Plan (approved)
  → Implementation
  → Validation / Review
```

Every stage produces a Markdown file. Every file is traceable to its source. Every implementation starts from an approved plan.

## Modes

| Mode | Purpose |
| --- | --- |
| Partnering | Structured conversation to capture ideas and problems |
| Use Cases | Define behavioral anchors from actor goals |
| Specs | Define desired behavior from Use Cases |
| Tasks | Break Specs into execution units |
| Implementation Planning | Plan and gate code changes |
| Implementation | Execute an approved plan |
| Validation | Verify artifacts and process compliance |
| Review | Evaluate outputs and discover process problems |
| Improvement | Change the harness itself |
| Legacy Discovery | Extract evidence from existing code |

## Repository Structure

``` text
agent-harness/
  CORE.md              ← universal rules (always loaded)
  OUTPUTS.md           ← artifact formats and folder structure (always loaded)
  CATALOG.md           ← navigation: where artifacts live
  modes/               ← one file per mode (universal, stack-neutral)
  templates/           ← artifact templates
  reference/           ← project-specific (fill these in)
    ARCHITECTURE.md
    DOMAIN.md
    TOOLING.md
    QUALITY.md
  guides/              ← optional stack-specific bootstrap guides
  transcripts/
  ideas/
  use-cases/
  specs/
  tasks/
  implementation-plans/
  reviews/
  improvements/
  legacy/
```

## Getting Started

This repository is a GitHub template. Click **Use this template** to create a new repository with the full harness structure and a clean git history. Alternatively, clone it locally and reinitialize git:

```bash
git clone <template-url> your-project
cd your-project
rm -rf .git && git init
```

Then fill in the four project-specific reference files in `agent-harness/reference/` and start with a Partnering or Use Case session.

See [docs/06-adoption.md](docs/06-adoption.md) for full adoption instructions.

## Documentation

| Document | Contents |
| --- | --- |
| [docs/01-core-principles.md](docs/01-core-principles.md) | Why this exists, the core principle, design philosophy |
| [docs/02-modes.md](docs/02-modes.md) | All 10 modes explained with boundaries and outputs |
| [docs/03-artifacts.md](docs/03-artifacts.md) | Artifact types, frontmatter, statuses, templates |
| [docs/04-workflows.md](docs/04-workflows.md) | End-to-end flows, Task Decision Matrix, commit boundaries |
| [docs/05-context-management.md](docs/05-context-management.md) | Context rules, CATALOG, SUMMARY files |
| [docs/06-adoption.md](docs/06-adoption.md) | Bootstrap steps, minimal adoption path, what belongs where |
| [docs/07-glossary.md](docs/07-glossary.md) | Term definitions |
| [docs/08-legacy-applications.md](docs/08-legacy-applications.md) | Practical legacy application discovery playbook |

## Key Principles

- **Modes are universal** — mode files work for any tech stack without modification
- **References are project-specific** — architecture, domain, tooling, and quality vary per project
- **Artifacts over memory** — everything lives in files, not agent context
- **Explicit gates** — implementation requires an approved plan; no exceptions
- **Smallest sufficient context** — agents load only what they need
- **Process improves itself** — Review and Improvement modes close the loop
