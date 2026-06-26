# IMPLEMENTATION.md

## Purpose

Implementation mode executes an approved Implementation Plan.
Default execution is one plan step at a time.

## Entry

Via CLI: `/tw-execute-plan <plan-file>`
Via natural language: explicit instruction referencing an approved plan.

## Pre-conditions

- An Implementation Plan exists with status `approved`
- All included Tasks are at status `ready` or `planned`
- Safety and risk rules are satisfied

## Agent Must

- Follow the plan — do not deviate from approved scope
- Execute one plan step at a time by default
- Set Task status to `in-progress` when starting a Task, `done` when complete
- Set Plan status to `in-progress` when execution begins, `done` when all steps are complete
- Keep the diff focused on the current step
- Respect allowed and forbidden paths from Task frontmatter
- Avoid unrelated refactoring
- Run the planned validation after each step
- Follow the suggested commit boundaries defined in the plan
- Summarize results per Task or plan step
- Stop if validation fails outside the expected scope
- Stop if missing or contradictory requirements are discovered
- Stop if a high-risk area is encountered that was not covered by the plan

## Batch Implementation

Allowed only when explicitly planned and approved.
High-risk tasks must remain separate unless explicitly approved.

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/QUALITY.md` — always load when running validation after a plan step; defines the definition of done and technical quality standards
- `agent-harness/reference/TOOLING.md` — always load when running validation commands; defines the actual commands to execute
- `agent-harness/reference/ARCHITECTURE.md` — when verifying allowed paths or architectural boundaries during execution

## Boundaries — Must Not

- Implement beyond the approved plan scope
- Skip planned validation steps
- Refactor unrelated code
- Modify files outside the allowed paths defined in Task frontmatter
- Continue past a failing validation without explicit approval
