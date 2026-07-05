# REFINING.md

## Purpose

Refining mode derives the next artifact in the Use-Case → Spec → Task funnel from its immediate source: a Spec
from a Use Case, or Task(s) from a Spec. This file governs the mechanical derivation activity only — the
resulting document's own schema and lifecycle rules (readiness gates, Updating rules, Output) live in the
corresponding artifact spec. Per `COR-058`, load both this file and the relevant artifact spec
(`agent-harness/artifact-specs/SPECS.md` or `agent-harness/artifact-specs/TASKS.md`) before acting — neither
substitutes for the other.

## Entry Points

- `/tw-create-spec <use-case-file>`
- `/tw-create-tasks <spec-file>`

## Consumes / Produces

- `/tw-create-spec`: consumes a Use Case at status `ready-for-spec`; produces a Spec.
- `/tw-create-tasks`: consumes a Spec at status `approved`; produces Task(s).

## Spec Creation Should (via `/tw-create-spec`)

1. Verify the source Use Case is at status `ready-for-spec` before proceeding.
2. Read the Use Case.
3. Inspect source Ideas or Legacy Findings when additional context is needed.
4. Identify problem and goal.
5. Define scope and non-goals.
6. Define functional and non-functional requirements.
7. Define acceptance criteria.
8. Identify risks and constraints.
9. Identify whether Tasks are likely required.
10. Stop before implementation.

Questions-registry carry-forward (inspecting inherited open items from the source Use Case, legacy-origin or not)
is a separate, cross-cutting concern, not part of this mechanical derivation — see
`agent-harness/artifact-specs/SPECS.md`'s `SPS-009`.

## Task Decision Matrix (via `/tw-create-tasks`)

| Situation | Tasks required? | Reason |
| --- | --- | --- |
| Small documentation-only change | No | Inline plan is sufficient |
| Small isolated config change | Optional | Use inline plan if validation is clear |
| Small bugfix in one module | Optional | Use inline plan if scope is clear |
| Multiple files or modules | Yes | Reviewability and traceability |
| Multiple implementation steps | Yes | Ordering and validation boundaries |
| Cross-cutting change | Yes | Scope control |
| Unclear dependencies | Yes | Dependency management |
| Use Case with multiple Specs | Yes | Too broad for inline planning |
| Spec with multiple features | Yes | Needs execution slices |
| Database migration | Yes | High risk |
| Destructive data job | Yes | High risk |
| Deployment or infrastructure change | Yes | Operational risk |
| Security, secrets or auth | Yes | Safety-critical |
| Payment or financial transaction execution | Yes | Safety-critical |
| Domain-critical business logic | Yes | Domain-critical |
| Major architecture change | Yes | Requires reviewable slices |

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| SPS-001 | Sources | A Spec must always be created from a Use Case. The Use Case must be at status `ready-for-spec` before a Spec may be created. |
| SPS-006 | Boundaries | Do not implement or change code. |
| SPS-007 | Boundaries | Do not create Tasks or Implementation Plans while creating a Spec. |
| SPS-008 | Boundaries | Do not proceed if the source Use Case is not at an accepted status. |
| TSK-001 | Sources | Tasks must always be created from an approved Spec. The Spec must be at status `approved` before Tasks may be created. |
| TSK-003 | Boundaries | Do not implement or change code. |
| TSK-004 | Boundaries | Do not create Implementation Plans. |
| TSK-005 | Boundaries | Do not proceed if the source Spec is not at status `approved`. |
| REF-001 | Dedup | Before generating Tasks from a Spec — via this entry point directly, not only when Planning-Implementation happens to check first — verify existing Tasks derived from that Spec; do not generate duplicate Tasks or skip existing ones. This rule is owned here, not borrowed from `PLANNING-IMPLEMENTATION.md`'s `IPL-007`, so `/tw-create-tasks` is protected regardless of entry path. |

## Output

- Spec: `harness-data/artifacts/specs/active/SPEC-*.md`, per `agent-harness/artifact-specs/SPECS.md`.
- Task: `harness-data/artifacts/tasks/active/TASK-*.md`, per `agent-harness/artifact-specs/TASKS.md`.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining requirements or Task scope that involve domain concepts, business rules, or domain-critical areas
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when scope touches a system boundary or structural decision already settled by an ADR
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
