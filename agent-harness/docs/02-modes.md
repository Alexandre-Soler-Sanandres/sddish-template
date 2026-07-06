# Modes

A Mode is a true, distinct behavioral posture the agent adopts. See [01-core-principles.md](01-core-principles.md)'s
"Three Kinds of Harness File" section for how Modes relate to artifact specs and shared procedures. This document
covers Modes only.

## Mode Overview

| Mode | CLI | Purpose |
| --- | --- | --- |
| Partnering | — | Structured conversation to capture ideas and problems |
| Refining | `/create-use-case`, `/create-spec`, `/create-tasks` | Derive a Use Case, Spec, or Tasks from their upstream source |
| Planning-Implementation | `/plan-task`, `/plan-spec`, `/plan-use-case` | Plan and gate code changes |
| Implementing | `/execute-plan` | Execute an approved plan |
| Discovering-Legacy | `/legacy-discovery` | Extract evidence from existing code |
| Improving-Harness | `/improve-harness` | Change the harness itself |

---

## Partnering

The conversational front door for unclear thinking — a structured sparring partner, not a solution machine.
Produces Transcripts and Ideas, and identifies (but does not draft) ADRs and Use Cases for hand-off to the
appropriate mode. Ends only on explicit user request, never on a vague statement. See
`agent-harness/modes/PARTNERING.md` for the full rule set.

## Refining

Derives the next artifact in the Use-Case → Spec → Task funnel from its source — a Use Case from an Idea/
Transcript/Partnering discussion/Legacy Finding/existing docs, a Spec from a Use Case, or Tasks from a Spec. Each
entry point also accepts natural language. See `agent-harness/modes/REFINING.md` for entry points, gates, and
boundaries, and [03-artifacts.md](03-artifacts.md) for the resulting documents' own schemas.

## Planning-Implementation

The mandatory gate before code changes: inspect the artifact, gather downstream artifacts, verify maturity,
produce an Implementation Plan, and wait for approval. See `agent-harness/modes/PLANNING-IMPLEMENTATION.md` for
entry points and routing.

## Implementing

Changes code, one plan step at a time by default, only after an approved Implementation Plan exists. Invokes the
shared Validation procedure ([04-shared-procs.md](04-shared-procs.md)) as its closing gate after each step. See
`agent-harness/modes/IMPLEMENTING.md`.

## Discovering-Legacy

Extracts rewrite-quality evidence from an existing project — evidence, not authority. See
`agent-harness/modes/DISCOVERING-LEGACY.md`.

## Improving-Harness

Changes the harness itself, triggered only by a harness/process-flavored Review finding — never from Partnering
or a direct request. The only Mode allowed to modify `agent-harness/*`. See
`agent-harness/modes/IMPROVING-HARNESS.md`.
