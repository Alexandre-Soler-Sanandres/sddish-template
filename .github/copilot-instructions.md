# Copilot Instructions

This repository uses an SDD-ish Agent Harness under `agent-harness/`. See `AGENTS.md` for the full loader
description — this file mirrors its Always Follow list, Modes table, Context Checkpoint, and Implementation Gate
for GitHub Copilot.

## Always Follow

- `agent-harness/CORE.md` — universal harness contract; its `## Rules` section carries every `COR-*` rule
- `agent-harness/OUTPUTS.md` — artifact formats, naming conventions, folder structure
- The active Mode Workflow under `agent-harness/modes/` (or `agent-harness/extensions/<name>/` for an enabled Extension)
- The explicitly referenced artifact

Every harness source file carries its own enforceable rules in a `## Rules` section in the same file; loading the
file loads its rules. There is no separate rules tree. An Extension under `agent-harness/extensions/<name>/` is
loaded only when `harness-data/HARNESS-PROFILE.yaml` sets `extensions.<name>: enabled`.

## Modes

A Mode is a true, distinct behavioral posture — only one is active at a time, and switching happens only on
explicit user request.

| Mode | File | Purpose |
| --- | --- | --- |
| Partnering | `agent-harness/modes/PARTNERING.md` | Structured conversation to capture ideas and problems |
| Refining | `agent-harness/modes/REFINING.md` | Derive a Spec from a Use Case, or Tasks from a Spec (or directly, per the risk-tier cascade, when a layer is classified unnecessary) |
| Planning-Implementation | `agent-harness/modes/PLANNING-IMPLEMENTATION.md` | Plan and gate code changes |
| Implementing | `agent-harness/modes/IMPLEMENTING.md` | Execute a ready lane-authorized execution contract |
| Discovering-Legacy | `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md` (Extension — active only when `HARNESS-PROFILE.yaml` enables `legacy_discovery`) | Extract evidence from existing code |
| Improving-Harness | `agent-harness/modes/IMPROVING-HARNESS.md` | Change the harness itself |

## Context Checkpoint

At the start of harness work, load `AGENTS.md`, `CORE.md`, `OUTPUTS.md`, the active Mode Workflow, and the explicitly
referenced artifact — each file's own `## Rules` section comes with it. After a resume or context
compaction, repeat the checkpoint before the next high-impact action. See `agent-harness/CORE.md` for the full
checkpoint and high-impact action list.

## Implementation Gate

For new work, do not implement before the authorized execution contract required by
`agent-harness/shared-procs/WORK-LANES.md` is ready: a stated Fast micro-plan, an approved Standard Change Spec,
or an approved Assured Execution Plan. Active v1 chains retain their recorded Implementation Plan gate.
