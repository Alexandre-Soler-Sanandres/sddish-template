# SPECS.md

## Purpose

Specs are the source of truth for desired behavior. This file is the Spec artifact's schema, lifecycle, and
boundary rules; the mechanical activity of deriving a Spec from a Use Case lives in
`agent-harness/modes/REFINING.md` — load both (per `COR-03-090`) before creating or updating a Spec.

## Artifact Story

A Use Case (or, via the UC-skip path, an Idea/Transcript/Partnering discussion/Legacy Finding/existing doc)
reaches the point where its behavior needs a technical contract. Refining derives the Spec's scope, requirements,
and acceptance criteria; relevant ADRs get checked and re-checked as the content firms up; and once the
transition rules promote it under `agent-harness/systems/STATUS-TRANSITIONS.md`'s `STT-01-030`/`040`, the Spec
becomes `ready`, the status Planning-Implementation requires before it will plan any code change. Significant
changes and later reopening/reset behavior are modeled in that same transition system.

## Entry / Creation Paths

Created only from within Refining (`/create-spec`).

## Sources

A Spec is created only from within Refining (`/create-spec`), from a Use Case — OR, when
`shared-procs/RISK-TIER.md`'s UC-Necessity Matrix (`RSK-02-010`) classifies the request below UC-tier, directly
from the same source types a Use Case would have been created from (Idea, Transcript, Partnering discussion,
Legacy Finding, existing documentation). ADRs remain reference authority only, never a direct Spec source
(`ADR.md`'s `DEC-02-020`), in both cases.

## When To Create

Whenever a Use Case exists (any status — no longer gated on `ready`, `SPS-01-010`), or a request
classifies below UC-tier via the risk-tier cascade.

## When Not To Create

Legacy Findings, Ideas, and Transcripts must not be treated as direct Spec sources except via the UC-skip path
above — outside that path they are upstream inputs that produce Use Cases, not Specs directly (`SPS-01-020`).
ADRs must never be treated as a Spec source either — reference authority only (`SPS-01-021`; see `ADR.md`'s
`DEC-02-020`/`DEC-05-010`).

## Artifact Shape

A Spec entered via the UC-skip path must include a `## Risk-Tier Classification` section (`RSK-05-010`); its
`source` frontmatter field then points at the Idea/Transcript/etc. actually used instead of a Use Case
(`SPS-01-050`). `technical_refs` names external technical artifacts (OpenAPI specs, database schemas, contracts)
that live outside `agent-harness/` — input constraints or expected outputs, not part of the behavioral spec
itself; their location is project-defined, not enforced by the harness.

## Field Semantics

- `status` — see `## Lifecycle`.
- `source` — the Use Case (or UC-skip-path source) this Spec was derived from.
- `related` — accepted ADRs this Spec depends on; see `## Relationships`.
- `technical_refs` — see `## Artifact Shape`.
- `test_refs` — links to test files exercising this Spec's acceptance criteria; consumed by
  `IMPLEMENTING.md`'s `IMPL-03-110`.

## Body Should Include

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
- Risk-Tier Classification (if entered via the UC-skip path — see `SPS-01-050`)

When legacy evidence is involved, the Spec should additionally:

- carry inherited legacy open questions into `Open Questions` until they are resolved, deferred, marked
  not-needed, or proof-routed for this Spec
- place technical legacy obligations in the section they constrain: requirements, constraints, dependencies,
  risks, validation, or `technical_refs` / `test_refs`
- cite canonical legacy IDs (`CSQ-*`, `Q-<APP>-*`, `CSP-*`) rather than duplicating full legacy backlog rows

## Lifecycle

A Spec may be updated when new information changes the scope or requirements, open questions are resolved, or
acceptance criteria need correction (`SPS-03-010`) — updating must never change the Spec ID, and must update the
`updated` field (`SPS-03-020`/`SPS-03-021`). A change to scope, non-goals, functional requirements, acceptance
criteria, or constraints is significant; a typo, clarification, added open question, or `updated`-field bump is
not (`SPS-07-010`). Status transitions for this artifact — including promotion to `ready` and the effect of a
later significant change — are described in `agent-harness/systems/STATUS-TRANSITIONS.md` and enforced by the
paired `STT-*` rules.

## Readiness / Acceptance

Before a transition rule promotes a Spec to `ready`, verify the Readiness Checklist in the artifact — every item
must be checked; a single unchecked item blocks the promotion (`SPS-02-010`/`SPS-02-011`). Also re-run three
ADR checks before promotion: missed-ADR recheck against the *current* accepted-ADR list, with every
`fleet-wide` ADR present in `related` and every `scoped` ADR re-judged (`SPS-08-010`–`012`); content-drift
recheck against the Spec's actual current content, not only its original `area` (`SPS-08-020`); and a
compliance check that every ADR cited in `related` is actually reflected in the Spec's requirements/scope
(`SPS-08-030`). Also verify the Questions registry holds nothing unresolved that should block the advance
(`SPS-05-011`). `ready` is no
longer a precondition for Task creation (see `REFINING.md`'s `TSK-01-010`) — `STT-01-030`/`040` set it once
these local gates pass.

## Relationships

When the source Use Case inherits unresolved Questions-registry entries — regardless of legacy or non-legacy
origin — load those referenced items and route them into the Spec sections they constrain (`SPS-05-010`), by
effect per `CORE.md`'s `COR-01-120`: unresolved promotion-shaping questions belong in `Open Questions` as
canonical Question ID references; requirements, constraints, dependencies, risks, and validation obligations
belong in the section they constrain (`SPS-05-020`). The Questions registry's `CSP-*` rows remain the canonical
proof/parity backlog — a Spec may cite relevant `CSP-*` IDs in requirements, risks, validation, or open
questions, but should not duplicate unrelated rows or store proof IDs in `test_refs` (`SPS-06-010`/`SPS-06-020`).

## Output / Location

- `harness-data/artifacts/specs/active/SPEC-*.md` (`draft`)
- `harness-data/artifacts/specs/ready/SPEC-*.md` (`ready`)
- `harness-data/artifacts/specs/done/SPEC-*.md` (`done` — still-authoritative behavior, distinct
  from closed/superseded; see `agent-harness/systems/LIFECYCLE-FOLDERS.md`)
- `harness-data/artifacts/specs/archive/SPEC-*.md` (`archived`/`rejected`)

## Template

Use `agent-harness/templates/SPEC-template.md` as the starting point for every new Spec.

## Examples

An existing Use Case needs technical detail, regardless of its current status. The agent drafts scope,
functional/non-functional requirements, and acceptance criteria, loads every `fleet-wide` accepted ADR plus
relevant `scoped` ones, and leaves the Spec's promotion to `STT-01-030`/`040` once the local readiness gates
pass.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/SPECS.md` (single paired file —
under the 25-rule grouping threshold). Load it alongside `agent-harness/modes/REFINING.md`'s own Rules Map
whenever creating, updating, or promoting a Spec.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when defining requirements that involve domain concepts, business rules, or domain terminology
- `harness-data/reference/ARCHITECTURE.md` — when scope touches system boundaries, layers, or architectural constraints
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when scope touches a system boundary or structural decision already settled by an ADR
- the Questions registry (`harness-data/artifacts/questions/`) or `REWRITE-READINESS.md` — when inherited legacy decisions or obligations still constrain the Spec
