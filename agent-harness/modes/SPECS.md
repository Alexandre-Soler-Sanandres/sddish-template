# SPECS.md

## Purpose

Spec mode creates or updates Spec artifacts.
Specs are the source of truth for desired behavior.

## Entry

Via CLI: `/tw-create-spec <use-case-file>`
Via natural language: explicit, unambiguous instruction referencing the source artifact.

## Spec Creation Should

1. Verify the source artifact is at an accepted status before proceeding.
2. Read the Use Case or Legacy Finding.
3. Inspect source Ideas or Legacy Findings when additional context is needed.
4. When the Use Case originated from Legacy Discovery, inspect the inherited legacy question IDs and any referenced parity/proof obligations that still shape the design.
5. Identify problem and goal.
6. Define scope and non-goals.
7. Define functional and non-functional requirements.
8. Define acceptance criteria.
9. Identify risks and constraints.
10. Identify whether Tasks are likely required.
11. Stop before implementation.

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

When legacy evidence is involved, the Spec should additionally:

- carry inherited legacy open questions into `Open Questions` until they are resolved, deferred, marked not-needed, or proof-routed for this Spec
- place technical legacy obligations in the section they constrain: requirements, constraints, dependencies, risks, validation, or `technical_refs` / `test_refs`
- cite canonical legacy IDs (`CSQ-*`, `Q-<APP>-*`, `CSP-*`) rather than duplicating full legacy backlog rows

## Technical References

A Spec may reference external technical artifacts via the `technical_refs` frontmatter field.
These are project artifacts (OpenAPI specs, database schemas, contracts) that live outside `agent-harness/`.
They are input constraints or expected outputs, not part of the behavioral spec itself.
Their location is project-defined — the harness does not enforce a specific folder.

## When a Spec Changes

A **significant change** is any modification to: scope, non-goals, functional requirements,
acceptance criteria, or constraints.

A **non-significant change** is: typos, clarifications, adding open questions, updating the
`updated` field.

When a significant change is made to an approved Spec:

1. Reset Spec status to `draft`.
2. For each Task ID in `derived_tasks`: set Task status to `draft`.
3. For each Implementation Plan where `source` includes this Spec ID: set Plan status to `proposed`.
4. Report the full impact — list affected Task IDs and Plan IDs.
5. Stop and wait for user instruction before proceeding.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| SPS-001 | Sources | A Spec must always be created from a Use Case. The Use Case must be at status `ready-for-spec` before a Spec may be created. |
| SPS-002 | Sources | Legacy Findings, Ideas and Transcripts are upstream inputs — they produce Use Cases, not Specs directly. |
| SPS-003 | Readiness-Gate | Before setting a Spec status to `approved`, verify the Readiness Checklist in the artifact. All items must be checked. A single unchecked item blocks the status change. |
| SPS-004 | Updating | A Spec may be updated when new information changes the scope or requirements, open questions are resolved, or acceptance criteria need correction. |
| SPS-005 | Updating | Updating does not change the Spec ID. Update the `updated` field. |
| SPS-006 | Boundaries | Do not implement or change code. |
| SPS-007 | Boundaries | Do not create Tasks or Implementation Plans. |
| SPS-008 | Boundaries | Do not proceed if the source Use Case is not at an accepted status. |
| SPS-009 | Legacy-Handoff | When the source Use Case inherits unresolved legacy questions or parity/proof obligations, load those referenced items and route them into the Spec sections they actually constrain. |
| SPS-010 | Legacy-Handoff | Keep `PARITY-MATRIX.md` as the canonical proof/parity backlog. A Spec may cite relevant `CSP-*` IDs in requirements, risks, validation, or open questions, but should not duplicate unrelated matrix rows or store proof IDs in `test_refs`. |

## Output

- `harness-data/specs/active/SPEC-*.md`
- Use `agent-harness/templates/SPEC-template.md` as the starting point for every new Spec.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining requirements that involve domain concepts, business rules, or domain terminology
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- relevant legacy `QUESTIONS.md`, `PARITY-MATRIX.md`, or `REWRITE-READINESS.md` artifacts — when inherited legacy decisions or obligations still constrain the Spec
