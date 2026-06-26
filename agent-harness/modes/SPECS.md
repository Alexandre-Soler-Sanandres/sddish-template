# SPECS.md

## Purpose

Spec mode creates or updates Spec artifacts.
Specs are the source of truth for desired behavior.

## Entry

Via CLI: `/tw-create-spec <use-case-file>`
Via natural language: explicit, unambiguous instruction referencing the source artifact.

## Sources

A Spec must always be created from a Use Case.
The Use Case must be at status `ready-for-spec` or `approved` before a Spec may be created.

Legacy Findings, Ideas and Transcripts are upstream inputs — they produce Use Cases, not Specs directly.

## Spec Creation Should

1. Verify the source artifact is at an accepted status before proceeding.
2. Read the Use Case or Legacy Finding.
3. Inspect source Ideas or Legacy Findings when additional context is needed.
4. Identify problem and goal.
5. Define scope and non-goals.
6. Define functional and non-functional requirements.
7. Define acceptance criteria.
8. Identify risks and constraints.
9. Identify whether Tasks are likely required.
10. Stop before implementation.

## Spec Body Should Include

- Problem
- Goal
- Scope
- Non-goals
- Functional requirements
- Non-functional requirements
- Acceptance criteria
- Constraints
- Dependencies
- Risks
- Validation approach
- Task decision notes (if relevant)

## Technical References

A Spec may reference external technical artifacts via the `technical_refs` frontmatter field.
These are project artifacts (OpenAPI specs, database schemas, contracts) that live outside `agent-harness/`.
They are input constraints or expected outputs, not part of the behavioral spec itself.
Their location is project-defined — the harness does not enforce a specific folder.

## Output

- `agent-harness/specs/active/SPEC-*.md`
- Use `agent-harness/templates/SPEC-template.md` as the starting point for every new Spec.

## Updating a Spec

A Spec may be updated when:

- New information changes the scope or requirements
- Open questions are resolved
- Acceptance criteria need correction

Updating does not change the Spec ID. Update the `updated` field and reset status to `draft` if the change is significant enough to require re-approval.

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/DOMAIN.md` — when defining requirements that involve domain concepts, business rules, or domain terminology
- `agent-harness/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints

## Boundaries — Must Not

- Implement or change code
- Create Tasks or Implementation Plans
- Proceed if the source Use Case is not at an accepted status
