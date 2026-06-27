# Core Principles

## Purpose

The Spec Driven Agent Harness provides a structured, file-based process for working with AI agents on software development tasks.

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

## Core Principle: Spec Driven Development

The central principle is: **no code without a Spec, no Spec without a Use Case, no implementation without an approved plan.**

This creates a clear dependency chain:

```
Voice / Text / Legacy Code
  → Transcript / Idea
  → Use Case
  → Spec
  → Tasks (when required)
  → Implementation Plan (approved)
  → Implementation
  → Validation / Review
```

Each stage produces a file-based artifact. Each artifact is traceable to its source. No stage may be skipped — but stages may be lightweight when the work is small and low-risk.

## Modes Are Universal. References Are Project-Specific.

Mode files (`agent-harness/modes/`) define process rules that apply to every project using this harness, regardless of tech stack. They must never contain stack-specific commands, tool names, or technology choices.

Reference files (`agent-harness/reference/`) are project-specific. They define the concrete details that vary per project: architecture, domain concepts, tooling commands, and quality standards.

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
- **Process improves itself** — Review and Improvement modes close the loop
- **Universal harness, project-specific details** — the process is the same everywhere; the stack details vary
