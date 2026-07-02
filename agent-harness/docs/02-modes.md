# Modes

A mode defines what the agent is allowed to do. Only one mode is active at a time.

Voice, text, and chat are **input channels** — not modes. The input channel does not change what the agent may do. Partnering is the mode for conversation regardless of how the input arrives.

Mode transitions happen only when the user explicitly requests them. Ambiguous intent must be clarified before switching modes.

## Mode Overview

| Mode | CLI | Purpose |
| --- | --- | --- |
| Partnering | — | Structured conversation to capture ideas and problems |
| Use Cases | `/tw-create-use-case` | Define behavioral anchors from actor goals |
| Specs | `/tw-create-spec <use-case-file>` | Define desired behavior from Use Cases |
| Tasks | `/tw-create-tasks <spec-file>` | Break Specs into execution units |
| Implementation Planning | `/tw-implement-task/spec/use-case` | Plan and gate code changes |
| Implementation | `/tw-execute-plan <plan-file>` | Execute an approved plan |
| Validation | `/tw-validate` | Verify artifacts and implementations |
| Review | `/tw-review <artifact-file>` | Evaluate outputs and discover process problems |
| Improvement | `/tw-improve-harness <review-file>` | Change the harness itself |
| Legacy Discovery | `/tw-discover-legacy <path>` | Extract evidence from existing code |

## Partnering

The conversational front door for unclear thinking. The agent acts as a structured sparring partner — not a solution machine.

**May produce:** Transcripts, Ideas, Use Case drafts (if sufficiently mature)  
**Must not:** Create Specs, Tasks, or Implementation Plans. Modify code.

The transcript is raw data. The agent writes it proactively as the conversation unfolds.

Mode transition: Partnering ends only when the user explicitly requests a mode change. A vague statement like "we should maybe make a spec later" does not trigger Spec mode.

## Use Case Mode

Creates or refines Use Case artifacts. A Use Case is a behavioral anchor — it defines who does what, under what conditions, and with what observable outcome.

**Sources:** Idea, Transcript, Partnering discussion, Legacy Finding, existing documentation
**Output:** `harness-data/use-cases/active/UC-*.md`
**Must not:** Trigger implementation. Create Specs, Tasks, or Plans.

## Spec Mode

Creates or updates Spec artifacts. Specs are the source of truth for desired behavior.

A Spec must always be created from a Use Case at status `ready-for-spec`. Legacy Findings, Ideas, and Transcripts are upstream inputs — they produce Use Cases, not Specs directly.

**Output:** `harness-data/specs/active/SPEC-*.md`
**Must not:** Implement code. Create Tasks or Plans. Proceed if source Use Case is not at an accepted status.

A Spec may reference external technical artifacts (OpenAPI specs, database schemas, contracts) via the `technical_refs` frontmatter field. These live outside `agent-harness/` — their location is project-defined.

## Tasks Mode

Creates Task artifacts when they are required. Tasks are execution units, not the source of truth for behavior — Specs are.

Tasks must always be created from an approved Spec. Tasks are not always mandatory — see [04-workflows.md](04-workflows.md) for the Task Decision Matrix.

**Output:** `harness-data/tasks/active/TASK-*.md`
**Must not:** Implement code. Proceed if source Spec is not approved.

## Implementation Planning Mode

The mandatory gate before code changes. These commands mean: inspect the artifact, gather downstream artifacts, verify maturity, produce an Implementation Plan, and wait for approval.

**Entry points and routing:**

- `/tw-implement-task <task-file>` — verify Task is `ready`, create focused plan
- `/tw-implement-spec <spec-file>` — find Tasks, apply Task Decision Matrix, create plan
- `/tw-implement-use-case <use-case-file>` — find all derived Specs and Tasks, create end-to-end plan

**Output:** `harness-data/implementation-plans/active/PLAN-*.md`
**Must not:** Change code. Proceed without verifying artifact maturity.

## Implementation Mode

Changes code. May only start after an approved Implementation Plan exists and all included Tasks are `ready` or `planned`.

Executes one plan step at a time by default. Sets Task status to `in-progress` → `done` as work proceeds.

**Entry:** `/tw-execute-plan <plan-file>`  
**Must not:** Deviate from approved scope. Skip validation. Refactor unrelated code.

A plan step is not done until every acceptance criterion in the Spec is covered by either an
entry in `test_refs` (pointing to an existing test file) or a validation command in the Task
frontmatter. The agent populates `test_refs` on the Spec during implementation.

## Validation Mode

Checks artifacts, plans, and implementations against process and behavioral criteria. Does not run technical checks — those belong to Implementation mode, guided by `QUALITY.md` and `TOOLING.md`.

**Covers:** Artifact completeness, process rule compliance, acceptance criteria, readiness checks  
**Output:** Findings documented inline in the plan step summary, or as a Review artifact when a formal record is needed — created via Review mode.

## Review Mode

Evaluates outputs and decisions. Review is not only approval — it is how process problems are discovered. In the
overall harness, this is an optional advanced mode rather than something every team must use for everyday work.

**Entry:** `/tw-review <artifact-file>`
**Output:** `harness-data/reviews/active/REVIEW-*.md`
**Must not:** Change the artifact under review. Implement fixes. Modify harness files without an Improvement artifact.

After review, the agent takes a prescribed action based on the outcome and stops:

| Outcome | Agent action |
| --- | --- |
| `accepted` | Advance artifact to next accepted status. Report. |
| `accepted-with-notes` | Advance status. Record follow-up notes in the Review artifact, and add open questions to the target artifact only when that artifact is the correct place to carry the note forward. |
| `changes-requested` | Set artifact to `draft`. Record findings. Wait for user instruction. |
| `rejected` | Set artifact to `rejected`. Move to archive. Wait for user instruction. |
| `follow-up-required` | Hold status. Create Improvement if process problem found. Wait for user instruction. |

The agent never autonomously re-enters a producing mode after rejection or escalation.

## Harness Improvement Mode

Changes the harness itself. Only triggered by Review findings — not from Partnering or direct requests. Like Review,
this is an optional advanced discipline in the overall operating model, even though its rules are strict when used.

**Entry:** `/tw-improve-harness <review-file>`
**Output:** `harness-data/improvements/active/IMPROVEMENT-*.md`
**Must not:** Change harness during normal feature implementation.

## Legacy Discovery Mode

Analyzes an existing project as evidence for a new SDD-ish development process. The legacy project is evidence, not authority.

**Entry:** `/tw-discover-legacy <path>`  
**Must not:** Modify legacy source code. Implement new code. Create Specs without a Use Case unless evidence is unambiguous and strong.
