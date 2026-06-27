# USE-CASES.md

## Purpose

Use Case mode creates or refines Use Case artifacts.
A Use Case is a behavioral anchor — it defines who does what, under what conditions, and with what observable outcome.
It is not an implementation plan.

## Entry

Via CLI: `/tw-create-use-case`
Via natural language: explicit instruction referencing a source artifact or describing an actor goal.

## Sources

A Use Case may be created from:

- Idea
- Transcript
- Partnering discussion
- Legacy Finding
- Existing documentation

## When to Create a Use Case

Create a Use Case when:

- A human actor or external system has a goal to pursue
- A decision flow or business workflow needs to be defined
- Observable behavior needs to be captured
- Alternatives or failure paths are relevant
- A recurring operational scenario exists

## Use Case Body Should Include

- Primary actor
- Supporting actors
- Goal
- Trigger
- Preconditions
- Main success scenario (step by step)
- Alternatives and failure paths
- Non-goals
- Observable outcome
- Open questions

## Output

- `agent-harness/use-cases/active/UC-*.md`
- Use `agent-harness/templates/USE-CASE-template.md` as the starting point for every new Use Case.

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/DOMAIN.md` — when defining actors, goals, or business rules that require domain knowledge
- `agent-harness/reference/ARCHITECTURE.md` — when the use case involves system boundaries or external integrations

## Refining a Use Case

A Use Case may be refined when:

- New information from a Partnering session or Legacy Finding changes the scope
- Open questions are resolved
- The primary actor or scenario needs correction

Refining does not change the Use Case ID. Update the `updated` field and status as appropriate.

## Readiness Gate

Before setting a Use Case status to `ready-for-spec`, verify the Readiness Checklist in the artifact.
All items must be checked. A single unchecked item blocks the status change.

## Boundaries — Must Not

- Contain low-level implementation detail (unless essential to the scenario)
- Trigger implementation
- Create Specs, Tasks, or Implementation Plans
