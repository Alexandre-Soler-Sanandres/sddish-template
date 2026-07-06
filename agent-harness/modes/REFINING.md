# REFINING.md

## Purpose

Refining mode derives the next artifact in the Use-Case → Spec → Task funnel from its immediate source: a Use
Case from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation; a Spec from a
Use Case; or Task(s) from a Spec. This file governs the mechanical derivation activity only — the resulting
document's own schema and lifecycle rules (readiness gates, Updating rules, Output) live in the corresponding
artifact spec. Per `COR-03-090`, load both this file and the relevant artifact spec
(`agent-harness/artifact-specs/USE-CASES.md`, `agent-harness/artifact-specs/SPECS.md`, or
`agent-harness/artifact-specs/TASKS.md`) before acting — neither substitutes for the other.

## Entry Points

- `/create-use-case <source-reference>`
- `/create-spec <use-case-file>`
- `/create-tasks <spec-file>`

Each entry point may also be triggered by natural language — an explicit instruction naming the source and what
to derive from it, e.g. "use Idea IDEA-012 to create a Use Case," "from our Partnering transcript and ADR-003,
extract the Use Cases we need," "create the spec for UC-007," or "plan tasks from SPEC-014." The input channel
does not change what the mode allows (mirrors `PTN-001`) — a natural-language trigger still requires the same
source and readiness checks as its CLI equivalent.

## Consumes / Produces

- `/create-use-case`: consumes an Idea, Transcript, Partnering discussion, Legacy Finding, or existing
  documentation — if the source is an Idea, it must be at status `ready-for-use-case`; produces a Use Case.
- `/create-spec`: consumes a Use Case at status `ready-for-spec`; produces a Spec.
- `/create-tasks`: consumes a Spec at status `approved`; produces Task(s).

## Use Case Creation Should (via `/create-use-case`)

1. Identify the source: Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation.
2. If the source is an Idea, verify it is at status `ready-for-use-case` before proceeding (per `IDA-001`). Other
   source types have no formal readiness gate — use judgment that the source material is concrete enough to
   draft a scenario from.
3. Read the source material.
4. Identify the primary actor and supporting actors.
5. Define the goal, trigger, and preconditions.
6. Write the main success scenario, alternatives, and failure paths.
7. Define non-goals and the observable outcome.
8. Carry forward relevant Questions-registry entries tied to the source artifact (`UCS-007`).
9. Stop before creating a Spec, Task, or Implementation Plan.

## Spec Creation Should (via `/create-spec`)

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

## Task Decision Matrix (via `/create-tasks`)

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
| UCS-011 | Sources | A Use Case must be created from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation. If the source is an Idea, it must be at status `ready-for-use-case` (`IDA-001`) before a Use Case may be created from it; other source types have no formal status gate — use judgment instead. |
| UCS-005 | Boundaries | Do not trigger implementation. |
| UCS-006 | Boundaries | Do not create Specs, Tasks, or Implementation Plans. |
| SPS-001 | Sources | A Spec must always be created from a Use Case. The Use Case must be at status `ready-for-spec` before a Spec may be created. |
| SPS-006 | Boundaries | Do not implement or change code. |
| SPS-007 | Boundaries | Do not create Tasks or Implementation Plans while creating a Spec. |
| SPS-008 | Boundaries | Do not proceed if the source Use Case is not at an accepted status. |
| TSK-001 | Sources | Tasks must always be created from an approved Spec. The Spec must be at status `approved` before Tasks may be created. |
| TSK-003 | Boundaries | Do not implement or change code. |
| TSK-004 | Boundaries | Do not create Implementation Plans. |
| TSK-005 | Boundaries | Do not proceed if the source Spec is not at status `approved`. |
| REF-001 | Dedup | Before generating Tasks from a Spec — via this entry point directly, not only when Planning-Implementation happens to check first — verify existing Tasks derived from that Spec; do not generate duplicate Tasks or skip existing ones. This rule is owned here, not borrowed from `PLANNING-IMPLEMENTATION.md`'s `IPL-007`, so `/create-tasks` is protected regardless of entry path. |

## Output

- Use Case: `harness-data/artifacts/use-cases/active/UC-*.md`, per `agent-harness/artifact-specs/USE-CASES.md`.
- Spec: `harness-data/artifacts/specs/active/SPEC-*.md`, per `agent-harness/artifact-specs/SPECS.md`.
- Task: `harness-data/artifacts/tasks/active/TASK-*.md`, per `agent-harness/artifact-specs/TASKS.md`.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining actors, requirements, or Task scope that involve domain concepts, business rules, or domain-critical areas
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when scope touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) — when the source Idea or Legacy Finding carries open items that shape the Use Case being drafted
- `harness-data/reference/TOOLING.md` — when specifying validation commands in Task frontmatter
