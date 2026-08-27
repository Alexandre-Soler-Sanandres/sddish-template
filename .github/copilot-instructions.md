# Copilot Instructions

This repository uses an SDD-ish Agent Harness under `agent-harness/`. See `AGENTS.md` for the full loader
description — this file mirrors its Always Follow list, Modes table, Context Checkpoint, and Implementation Gate
for GitHub Copilot.

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

## Context Checkpoint

At the start of harness work, load `AGENTS.md`, `CORE.md`, `OUTPUTS.md`, the active Mode Workflow, and the explicitly
referenced artifact, plus paired rules required by their Rules Maps where present. After a resume or context
compaction, repeat the checkpoint before the next high-impact action. See `agent-harness/CORE.md` for the full
checkpoint and high-impact action list.

## Implementation Gate

Do not implement before a user-approved Implementation Plan is at status `ready`.
