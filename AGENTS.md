# AGENTS.md

This repository uses an SDD-ish Agent Harness under `agent-harness/`.

## Always Follow

- `agent-harness/CORE.md` — universal rules that apply in every mode
- `agent-harness/OUTPUTS.md` — artifact formats, naming conventions, folder structure
- The active mode file under `agent-harness/modes/`
- The explicitly referenced artifact

## Modes

A Mode is a true, distinct behavioral posture — only one is active at a time, and switching happens only on
explicit user request.

| Mode | File | Purpose |
| --- | --- | --- |
| Partnering | `agent-harness/modes/PARTNERING.md` | Structured conversation to capture ideas and problems |
| Refining | `agent-harness/modes/REFINING.md` | Derive a Spec from a Use Case, or Tasks from a Spec |
| Planning-Implementation | `agent-harness/modes/PLANNING-IMPLEMENTATION.md` | Plan and gate code changes |
| Implementing | `agent-harness/modes/IMPLEMENTING.md` | Execute an approved plan |
| Discovering-Legacy | `agent-harness/modes/DISCOVERING-LEGACY.md` | Extract evidence from existing code |
| Improving-Harness | `agent-harness/modes/IMPROVING-HARNESS.md` | Change the harness itself |

## Artifact Specs

An artifact spec defines the schema, creation trigger, and lifecycle gate for one document type. Any Mode's own
rules may invoke one directly — no mode switch required. See `agent-harness/artifact-specs/` and
`agent-harness/docs/03-artifacts.md`.

## Shared Procedures

A shared procedure is a checklist invoked by name from within a Mode's own rules — no schema, no artifact of its
own. See `agent-harness/shared-procs/VALIDATION.md` and `agent-harness/docs/04-shared-procs.md`.

## Reference

- `harness-data/reference/DOMAIN.md` — domain concepts and terminology
- `harness-data/reference/ARCHITECTURE.md` — system architecture overview
- `harness-data/reference/TOOLING.md` — tools and commands available
- `harness-data/reference/QUALITY.md` — technical quality standards and definition of done

## Context Loading Rules

- Do not scan entire artifact directories.
- Use the smallest sufficient context.
- Start from the explicitly referenced artifact.
- Use `agent-harness/CATALOG.md` to locate artifacts.
- Use `SUMMARY.md` files only when the target artifact is unknown.

## Context Checkpoint

At the start of harness work, load `AGENTS.md`, `CORE.md`, `OUTPUTS.md`, the active mode file, and the explicitly
referenced artifact. After a resume or context compaction, repeat the checkpoint before the next high-impact action.
See `agent-harness/CORE.md` for the full checkpoint and high-impact action list.

## Implementation Gate

Do not implement before an approved Implementation Plan exists.
