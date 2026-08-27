# AGENTS.md

This repository uses an SDD-ish Agent Harness under `agent-harness/`.

## Always Follow

- `agent-harness/CORE.md` — universal harness contract and Rules Map; load paired CORE rules per its map
- `agent-harness/OUTPUTS.md` — artifact formats, naming conventions, folder structure
- The active Mode Workflow under `agent-harness/modes/`
- The explicitly referenced artifact

When a required harness file has a paired rules file or grouped rules directory under `agent-harness/rules/`, load
the source file's Rules Map and the applicable paired rules. If the relevant rule group is unclear, or the work is
editing/auditing rules, load every paired rules group for that source file.

## Modes

A Mode is a true, distinct behavioral posture — only one is active at a time, and switching happens only on
explicit user request.

| Mode | File | Purpose |
| --- | --- | --- |
| Partnering | `agent-harness/modes/PARTNERING.md` | Structured conversation to capture ideas and problems |
| Refining | `agent-harness/modes/REFINING.md` | Derive a Spec from a Use Case, or Tasks from a Spec (or directly, per the risk-tier cascade, when a layer is classified unnecessary) |
| Planning-Implementation | `agent-harness/modes/PLANNING-IMPLEMENTATION.md` | Plan and gate code changes |
| Implementing | `agent-harness/modes/IMPLEMENTING.md` | Execute a user-approved plan at status `ready` |
| Discovering-Legacy | `agent-harness/modes/DISCOVERING-LEGACY.md` | Extract evidence from existing code |
| Improving-Harness | `agent-harness/modes/IMPROVING-HARNESS.md` | Change the harness itself |

## Artifact Specs

An artifact spec is an Artifact Contract: it defines the meaning, schema, creation trigger, and lifecycle gate for
one document type. Any Mode's own rules may invoke one directly — no mode switch required. See
`agent-harness/artifact-specs/` and
`agent-harness/docs/03-artifacts.md`.

## Shared Procedures

A shared procedure is a Procedure Guide invoked by name from within Mode or artifact control flow — no schema, no
artifact of its own. See `agent-harness/shared-procs/VALIDATION.md` and
`agent-harness/docs/04-shared-procs.md`.

## Harness File Taxonomy

- `agent-harness/modes/` — Mode Workflows: how the agent moves through one true Mode
- `agent-harness/artifact-specs/` — Artifact Contracts: what an artifact means and must contain
- `agent-harness/shared-procs/` — Procedure Guides: reusable harness-native procedures required by control flow
- `agent-harness/systems/` — Systems: agent-facing cross-rule/cross-artifact operating models
- `agent-harness/rules/` — Rules: enforceable rule tables only
- `agent-harness/templates/` — Templates: lean blank forms and scaffolds

Canonical definitions live in `agent-harness/docs/08-glossary.md`.

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

At the start of harness work, load `AGENTS.md`, `CORE.md`, `OUTPUTS.md`, the active Mode Workflow, and the explicitly
referenced artifact, plus paired rules required by their Rules Maps where present. After a resume or context
compaction, repeat the checkpoint before the next high-impact action. See `agent-harness/CORE.md` for the full
checkpoint and high-impact action list.

## Implementation Gate

Do not implement before a user-approved Implementation Plan is at status `ready`.
