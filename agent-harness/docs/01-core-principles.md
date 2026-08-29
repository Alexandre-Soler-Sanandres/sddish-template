# Core Principles

## V2 assurance split

Intent Validation asks whether the requirements are right; Technical Verification runs the checks that prove the
implementation; Conformance Audit reads records to prove process conformance. Tool success is evidence, never
approval. Promotion owns common lifecycle checks and one atomic transition.

## Purpose

The SDD-ish Agent Harness provides a structured, file-based process for working with AI agents on software development tasks.

It gives agents a clear operating context — defining what they are allowed to do, what artifacts they produce, and how they hand off to the next stage. Without structure, agents drift: they implement before requirements are clear, mix concerns across artifacts, and lose traceability between decisions and code.

The harness prevents this by making the process explicit and file-based. Every artifact is traceable. Every mode is bounded. Every implementation starts from a lane-authorized execution contract.

## Problem Statement

Working with AI agents on software is powerful but fragile. The main failure modes are:

- **Premature implementation** — agents start coding before requirements are stable
- **Context collapse** — agents lose track of what they decided and why
- **Scope drift** — implementations grow beyond what was agreed
- **No traceability** — it becomes impossible to link code back to requirements
- **God-index anti-pattern** — agents load everything at once and lose precision

The harness addresses all of these through explicit modes, bounded artifacts, and structured handoffs.

## Core Principle: SDD-ish Development

The central principle is: **no code without a bounded plan and the authorization required by
`shared-procs/WORK-LANES.md`.** Fast work uses a stated micro-plan; Standard work an approved Change Spec; and
Assured work an approved Execution Plan.

This creates a clear dependency chain:

```text
Voice / Text / Legacy Code
  → Fast: stated micro-plan
  → Standard: approved Change Spec (`ready`)
  → Assured: Use Case / Spec / Tasks / Execution Plan (`ready`) as independently warranted
  → Implementation
  → Validation
  → [Review / Improving-Harness — when a stronger formal loop is wanted]
```

Only a lane’s required durable contract must persist. Secondary artifacts exist when they add independent
behavioral authority, ownership/lifecycle, provenance, backlog, findings, or handoff value. The Risk-Tier
cascade remains a compatibility procedure for Assured chains.

## Harness File Taxonomy

The harness distinguishes several kinds of file under `agent-harness/`, by location and purpose. Canonical term
definitions live in [08-glossary.md](08-glossary.md).

- **Mode Workflows** (`agent-harness/modes/`) — true interaction-patterns the agent adopts. Only one is active at a time.
  Mode transitions happen only when the user explicitly requests them; ambiguous intent must be clarified before
  switching. Voice, text, and chat are **input channels**, not modes — the input channel never changes what the
  agent may do. See [02-modes.md](02-modes.md).
- **Artifact Contracts** (`agent-harness/artifact-specs/`) — the meaning, schema, creation trigger, and lifecycle gate for one
  document type. Producing or updating one of these does not require switching Mode; any Mode's own rules may
  invoke one directly (this mirrors how ADR has always worked: "any mode may draft a candidate ADR"). See
  [03-artifacts.md](03-artifacts.md).
- **Procedure Guides** (`agent-harness/shared-procs/`) — reusable harness-native procedures invoked by name from
  Mode or artifact control flow. No schema, no artifact of their own. See [04-shared-procs.md](04-shared-procs.md).
- **Systems** (`agent-harness/systems/`) — agent-facing operating-model explanations for mechanisms spanning
  multiple rules, artifacts, statuses, or procedures.
- **Rules** — enforceable rule rows only, co-located in a `## Rules` section inside the Workflow, Contract,
  Procedure Guide, or System they constrain (`CORE.md`/`OUTPUTS.md` for the universal and output rules).
- **Templates** (`agent-harness/templates/`) — lean scaffolds: frontmatter keys, section headings, checklists,
  placeholders, and short field prompts.

Short form: Rules constrain. Workflows guide. Contracts define. Procedures run. Systems explain interactions.
Templates scaffold.

## Extraction Criteria

When splitting or migrating a harness file, route content by role:

| Content role | Destination |
| --- | --- |
| Enforceable gates, approval/status/validation/loading/traceability requirements, safety boundaries, and anything auditable by rule ID | Rules |
| Posture, examples, route shapes, how to think, common paths, and quality guidance for mode work | Mode Workflow |
| Artifact meaning, shape, field semantics, lifecycle, validity, relationships, examples, and quality expectations | Artifact Contract |
| Repeatable harness-native steps required by control-flow semantics | Procedure Guide |
| Cross-rule/cross-artifact operating models that are bigger than one file | System |
| Blank structure, placeholders, section headings, checklists, and short fill prompts | Template |

Casual prose using words like "must" or "should" should be rewritten as plain prose unless enforcement is
intended. Intended enforcement gets a rule ID.

## Modes Are Universal. References Are Project-Specific.

Mode files (`agent-harness/modes/`) define process rules that apply to every project using this harness. They must never contain project-specific commands, tool names, or technology choices.

Reference files (`harness-data/reference/`) are project-specific. They define the concrete details that vary per project: architecture, domain concepts, tooling commands, and quality standards.

`agent-harness/OUTPUTS.md` is the universal exception — it defines artifact formats, naming conventions, and folder structure for all projects.

## Design Principles

- **Artifacts over memory** — everything lives in files, not agent context
- **Traceability over convenience** — every artifact links to its source
- **Explicit gates** — implementation requires a `ready` plan; no exceptions
- **Readiness checklists** — every artifact gate is enforced by a checklist; no unchecked item passes
- **Test coverage as done criteria** — a plan step is not done until ACs are covered by tests or validation commands
- **Smallest sufficient context** — agents load only what they need
- **Modes are bounded** — each mode has clear responsibilities and must-nots
- **Rejection paths are prescribed** — after review, the agent takes a defined action and stops; the user decides what happens next
- **Parallel work is coordinated** — concurrent Plans on overlapping paths are surfaced and blocked until resolved
- **Process improves itself when needed** — Review and Improving-Harness exist when teams want a stronger formal loop
- **Universal harness, project-specific details** — the process is the same everywhere; the project details vary
