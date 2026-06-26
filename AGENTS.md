# AGENTS.md

This repository uses a Spec Driven Agent Harness under `agent-harness/`.

## Always Follow

- `agent-harness/CORE.md` — universal rules that apply in every mode
- `agent-harness/OUTPUTS.md` — artifact formats, naming conventions, folder structure
- The active mode file under `agent-harness/modes/`
- The explicitly referenced artifact

## Modes

| Mode | File | Purpose |
| --- | --- | --- |
| Partnering | `agent-harness/modes/PARTNERING.md` | Structured conversation to capture ideas and problems |
| Use Cases | `agent-harness/modes/USE-CASES.md` | Define behavioral anchors from actor goals |
| Specs | `agent-harness/modes/SPECS.md` | Define desired behavior from Use Cases |
| Tasks | `agent-harness/modes/TASKS.md` | Break Specs into execution units |
| Implementation Planning | `agent-harness/modes/IMPLEMENTATION-PLANNING.md` | Plan and gate code changes |
| Implementation | `agent-harness/modes/IMPLEMENTATION.md` | Execute an approved plan |
| Validation | `agent-harness/modes/VALIDATION.md` | Verify artifacts and implementations |
| Review | `agent-harness/modes/REVIEW.md` | Evaluate outputs and discover process problems |
| Improvement | `agent-harness/modes/IMPROVEMENT.md` | Change the harness itself |
| Legacy Discovery | `agent-harness/modes/LEGACY-DISCOVERY.md` | Extract evidence from existing code |

## Reference

- `agent-harness/reference/DOMAIN.md` — domain concepts and terminology
- `agent-harness/reference/ARCHITECTURE.md` — system architecture overview
- `agent-harness/reference/TOOLING.md` — tools and commands available
- `agent-harness/reference/QUALITY.md` — technical quality standards and definition of done

## Context Loading Rules

- Do not scan entire artifact directories.
- Use the smallest sufficient context.
- Start from the explicitly referenced artifact.
- Use `agent-harness/CATALOG.md` to locate artifacts.
- Use `SUMMARY.md` files only when the target artifact is unknown.

## Implementation Gate

Do not implement before an accepted Implementation Plan exists.
