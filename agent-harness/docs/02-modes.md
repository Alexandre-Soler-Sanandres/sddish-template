# Modes

A Mode is a true, distinct behavioral posture the agent adopts. See [01-core-principles.md](01-core-principles.md)'s
"Three Kinds of Harness File" section for how Modes relate to artifact specs and shared procedures. This document
covers Modes only.

## Mode Overview

| Mode | CLI | Purpose |
| --- | --- | --- |
| Partnering | — | Structured conversation to capture ideas and problems |
| Refining | `/tw-create-spec <use-case-file>`, `/tw-create-tasks <spec-file>` | Derive a Spec from a Use Case, or Tasks from a Spec |
| Planning-Implementation | `/tw-plan-task/spec/use-case` | Plan and gate code changes |
| Implementing | `/tw-execute-plan <plan-file>` | Execute an approved plan |
| Discovering-Legacy | `/tw-legacy-discovery <path>` | Extract evidence from existing code |
| Improving-Harness | `/tw-improve-harness <review-file>` | Change the harness itself |

---

## Partnering

The conversational front door for unclear thinking. The agent acts as a structured sparring partner — not a solution machine.

**May produce:** Transcripts, Ideas, Use Case drafts (if sufficiently mature), ADRs (when a structural/architectural decision is reached)  
**Must not:** Create Specs, Tasks, or Implementation Plans. Modify code.

The transcript is raw data. The agent writes it proactively as the conversation unfolds.

Mode transition: Partnering ends only when the user explicitly requests a mode change. A vague statement like "we should maybe make a spec later" does not trigger a mode change.

## Refining

Derives the next artifact in the Use-Case → Spec → Task funnel from its immediate source — the mechanical
derivation activity only. The resulting document's own schema and lifecycle rules live in the corresponding
artifact spec ([03-artifacts.md](03-artifacts.md)) — load both before acting.

**Entry points:** `/tw-create-spec <use-case-file>` (consumes a Use Case at `ready-for-spec`, produces a Spec);
`/tw-create-tasks <spec-file>` (consumes an approved Spec, produces Tasks)  
**Must not:** Change code. Generate duplicate Tasks or skip existing ones (owned natively here, not borrowed from
Planning-Implementation).

## Planning-Implementation

The mandatory gate before code changes. These commands mean: inspect the artifact, gather downstream artifacts, verify maturity, produce an Implementation Plan, and wait for approval.

**Entry points and routing:**

- `/tw-plan-task <task-file>` — verify Task is `ready`, create focused plan
- `/tw-plan-spec <spec-file>` — find Tasks, apply the Task Decision Matrix (in `REFINING.md`), create plan
- `/tw-plan-use-case <use-case-file>` — find all derived Specs and Tasks, create end-to-end plan

**Output:** `harness-data/artifacts/implementation-plans/active/PLAN-*.md`
**Must not:** Change code. Proceed without verifying artifact maturity.

## Implementing

Changes code. May only start after an approved Implementation Plan exists and all included Tasks are `ready` or `planned`.

Executes one plan step at a time by default. Sets Task status to `in-progress` → `done` as work proceeds. Invokes
the shared Validation procedure ([04-shared-procs.md](04-shared-procs.md)) as its own closing gate after each step,
and produces the product/requirements flavor of Review when a durable record is needed.

**Entry:** `/tw-execute-plan <plan-file>`  
**Must not:** Deviate from approved scope. Skip validation. Refactor unrelated code.

A plan step is not done until every acceptance criterion in the Spec is covered by either an
entry in `test_refs` (pointing to an existing test file) or a validation command in the Task
frontmatter. The agent populates `test_refs` on the Spec during implementation.

## Discovering-Legacy

Analyzes an existing project as evidence for a new SDD-ish development process. The legacy project is evidence, not authority.

**Entry:** `/tw-legacy-discovery <path>`
**Must not:** Modify legacy source code. Implement new code. Create Specs without a Use Case unless evidence is unambiguous and strong.

## Improving-Harness

Changes the harness itself. Only triggered by a harness/process-flavored Review finding — not from Partnering or direct requests. This is the only Mode allowed to modify `agent-harness/*`.

**Entry:** `/tw-improve-harness <review-file>`
**Output:** `harness-data/artifacts/improvements/active/IMPROVEMENT-*.md`
**Must not:** Change harness during normal feature implementation.
