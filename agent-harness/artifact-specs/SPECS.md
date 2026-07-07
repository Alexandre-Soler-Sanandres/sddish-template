# SPECS.md

## Purpose

Specs are the source of truth for desired behavior. This file is the Spec artifact's schema, lifecycle, and
boundary rules; the mechanical activity of deriving a Spec from a Use Case lives in
`agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before creating or updating a Spec.

## Sources

A Spec is created only from within Refining (`/create-spec`), from a Use Case. Legacy Findings, Ideas,
Transcripts, and ADRs are upstream/reference inputs, not direct Spec sources — Legacy Findings, Ideas, and
Transcripts produce Use Cases, not Specs directly; ADRs are cited as reference authority and never produce a Use
Case or Spec directly (see `agent-harness/artifact-specs/ADR.md`'s `DEC-02-020`).

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

See `SPS-07-010` for what counts as significant, and `SPS-07-020` for the required cascade.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| SPS-01-020 | Sources | Legacy Findings, Ideas, and Transcripts MUST NOT be treated as direct Spec sources — they are upstream inputs that produce Use Cases, not Specs directly; ADRs likewise must not be treated as a Spec source, reference authority only — see `ADR.md`'s `DEC-02-020`/`DEC-05-010` for the citation rule (accepted vs. proposed). |
| SPS-02-010 | Readiness-Gate | Before setting a Spec status to `approved`, MUST verify the Readiness Checklist in the artifact; all items must be checked, and a single unchecked item blocks the status change. |
| SPS-03-010 | Updating | A Spec MAY be updated when new information changes the scope or requirements, open questions are resolved, or acceptance criteria need correction. |
| SPS-03-020 | Updating | Updating MUST NOT change the Spec ID; must update the `updated` field. |
| SPS-05-010 | Carry-Forward | When the source Use Case inherits unresolved Questions-registry entries — regardless of legacy or non-legacy origin — MUST load those referenced items and route them into the Spec sections they constrain. Before setting status to `approved` (see `SPS-02-010`), must verify the registry holds nothing unresolved that should block the advance. |
| SPS-06-010 | Legacy-Handoff | The Questions registry's `CSP-*` rows remain the canonical proof/parity backlog. A Spec MAY cite relevant `CSP-*` IDs in requirements, risks, validation, or open questions. |
| SPS-06-020 | Legacy-Handoff | A Spec SHOULD NOT duplicate unrelated `CSP-*` rows or store proof IDs in `test_refs`. |
| SPS-07-010 | Significant-Change | MUST treat a change to scope, non-goals, functional requirements, acceptance criteria, or constraints as significant; a typo, clarification, added open question, or `updated`-field bump is not. |
| SPS-07-020 | Cascade | MUST run this cascade when a significant change lands on an `approved` Spec: reset the Spec to `draft`; set every Task in `derived_tasks` to `draft`; set every Implementation Plan whose `source` includes this Spec to `proposed`; report all affected IDs; then stop and wait for user instruction. |

## Output

- `harness-data/artifacts/specs/active/SPEC-*.md`
- Use `agent-harness/templates/SPEC-template.md` as the starting point for every new Spec.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining requirements that involve domain concepts, business rules, or domain terminology
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when scope touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) or `REWRITE-READINESS.md` — when inherited legacy decisions or obligations still constrain the Spec
