# Guides

Project guides are optional support files under `harness-data/guides/`.
They are project-owned, not lifecycle artifacts, and they exist to help agents and humans work safely in one specific repository.

## What Guides Are For

Guides are useful for practical project-specific setup and operating knowledge such as:

- package manager and environment bootstrap
- local services and startup order
- test, lint, and type-check workflow in this repo
- environment quirks and recovery notes
- project-specific conventions that are too operational for `reference/`

Guides explain how this project works in practice.

## What Guides Are Not

Guides are not:

- harness lifecycle artifacts
- universal harness rules
- the canonical source of domain or architecture truth
- a place for fake template content
- a substitute for project playbooks

Canonical facts still belong in:

- `harness-data/reference/ARCHITECTURE.md`
- `harness-data/reference/DOMAIN.md`
- `harness-data/reference/TOOLING.md`
- `harness-data/reference/QUALITY.md`

Recurring project procedures belong in `harness-data/playbooks/`.

## When To Create A Guide

A guide is worth creating when:

- an agent would otherwise repeat the same setup mistakes
- one subsystem has non-obvious bootstrap or operating steps
- practical local workflow knowledge does not fit cleanly in `reference/`
- the setup is stable enough to be worth documenting

A guide is not needed just because the folder exists.

## Who Creates And Maintains Guides

Guides are project-owned support files.
They may be written or updated by humans or AI, but they are not required harness outputs.

The harness does not automatically generate or lifecycle-manage them.
They are worth creating or refining only when they add real operational value.

## How Agents Should Use Guides

Agents should load a guide only when the current task depends on local setup, tooling usage, bootstrap steps, or operating quirks.
Guides give local operating context for this repository. They do not define the main procedure for a task shape.

Typical examples:

- a task needs Python and `uv` setup details
- a service must be started locally in a specific order
- test data or seed steps are easy to get wrong
- one repo area has local operational conventions not captured elsewhere

Agents should not load guides by default for every task.
When both a playbook and a guide are relevant, the playbook defines the procedure and the guide supplies the local operating details.
Guides do not override `agent-harness/CORE.md`, the active mode file, or relevant playbooks.

## Suggested Shape

The [GUIDE-template.md](../templates/GUIDE-template.md) template can be used as a neutral structure when helpful.

Recommended sections:

- `## Purpose`
- `## Use When`
- `## Relevant Paths`
- `## Setup Or Workflow`
- `## Validation Or Checks`
- `## Common Pitfalls`
- `## Related Files`

Not every guide needs every section.
Prefer a small, accurate guide over a broad, speculative one.

## Example

```md
# Python And uv

## Purpose
Explain how this project bootstraps Python tooling and runs common local commands.

## Use When
- creating a local environment
- running tests for the first time
- troubleshooting missing dependencies

## Relevant Paths
- `pyproject.toml`
- `uv.lock`

## Setup Or Workflow
1. Install `uv`.
2. Run `uv sync`.
3. Use `uv run pytest` for tests.

## Common Pitfalls
- running `python` directly instead of `uv run`
- forgetting to sync after dependency changes
```

## Template Discipline

The template repository should keep `harness-data/guides/` empty until a real adopted project adds real local content.
Guides should not be filled with placeholder or imaginary project details.
