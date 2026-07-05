# Core Principles

## Purpose

The SDD-ish Agent Harness provides a structured, file-based process for working with AI agents on software development tasks.

It gives agents a clear operating context — defining what they are allowed to do, what artifacts they produce, and how they hand off to the next stage. Without structure, agents drift: they implement before requirements are clear, mix concerns across artifacts, and lose traceability between decisions and code.

The harness prevents this by making the process explicit and file-based. Every artifact is traceable. Every mode is bounded. Every implementation starts from an approved plan.

## Problem Statement

Working with AI agents on software is powerful but fragile. The main failure modes are:

- **Premature implementation** — agents start coding before requirements are stable
- **Context collapse** — agents lose track of what they decided and why
- **Scope drift** — implementations grow beyond what was agreed
- **No traceability** — it becomes impossible to link code back to requirements
- **God-index anti-pattern** — agents load everything at once and lose precision

The harness addresses all of these through explicit modes, bounded artifacts, and structured handoffs.

## Core Principle: SDD-ish Development

The central principle is: **no code without a Spec, no Spec without a Use Case, no implementation without an approved plan.**

This creates a clear dependency chain:

```text
Voice / Text / Legacy Code
  → Transcript / Idea
  → Use Case
  → Spec
  → Tasks (when required)
  → Implementation Plan (approved)
  → Implementation
  → Validation
  → [Review / Improving-Harness — when a stronger formal loop is wanted]
```

Each persistent stage produces a file-based artifact. Each artifact is traceable to its source. No stage may be skipped — but stages may be lightweight when the work is small and low-risk.

## Three Kinds of Harness File

The harness distinguishes three kinds of file under `agent-harness/`, by location and purpose:

- **Modes** (`agent-harness/modes/`) — a true interaction-pattern the agent adopts. Only one is active at a time.
  Mode transitions happen only when the user explicitly requests them; ambiguous intent must be clarified before
  switching. Voice, text, and chat are **input channels**, not modes — the input channel never changes what the
  agent may do. See [02-modes.md](02-modes.md).
- **Artifact specs** (`agent-harness/artifact-specs/`) — the schema, creation trigger, and lifecycle gate for one
  document type. Producing or updating one of these does not require switching Mode; any Mode's own rules may
  invoke one directly (this mirrors how ADR has always worked: "any mode may draft a candidate ADR"). See
  [03-artifacts.md](03-artifacts.md).
- **Shared procedures** (`agent-harness/shared-procs/`) — a checklist invoked by name from within a Mode's own
  rules. No schema, no artifact of its own. See [04-shared-procs.md](04-shared-procs.md).

## Modes Are Universal. References Are Project-Specific.

Mode files (`agent-harness/modes/`) define process rules that apply to every project using this harness. They must never contain project-specific commands, tool names, or technology choices.

Reference files (`harness-data/reference/`) are project-specific. They define the concrete details that vary per project: architecture, domain concepts, tooling commands, and quality standards.

`agent-harness/OUTPUTS.md` is the universal exception — it defines artifact formats, naming conventions, and folder structure for all projects.

## Design Principles

- **Artifacts over memory** — everything lives in files, not agent context
- **Traceability over convenience** — every artifact links to its source
- **Explicit gates** — implementation requires an approved plan; no exceptions
- **Readiness checklists** — every artifact gate is enforced by a checklist; no unchecked item passes
- **Test coverage as done criteria** — a plan step is not done until ACs are covered by tests or validation commands
- **Smallest sufficient context** — agents load only what they need
- **Modes are bounded** — each mode has clear responsibilities and must-nots
- **Rejection paths are prescribed** — after review, the agent takes a defined action and stops; the user decides what happens next
- **Parallel work is coordinated** — concurrent Plans on overlapping paths are surfaced and blocked until resolved
- **Process improves itself when needed** — Review and Improving-Harness exist when teams want a stronger formal loop
- **Universal harness, project-specific details** — the process is the same everywhere; the project details vary
