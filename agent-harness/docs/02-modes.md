# Modes

A Mode is a true, distinct behavioral posture the agent adopts. See [01-core-principles.md](01-core-principles.md)'s
"Harness File Taxonomy" section for how Mode Workflows relate to Artifact Contracts, Procedure Guides, Systems,
Rules, and Templates. This document covers Modes only.

## Mode Workflow Form

A file under `agent-harness/modes/` is a Mode Workflow. It should teach the agent how to do excellent work in that
mode: posture, path choice, examples, handoffs, common failure modes, and how to use the mode's rules. It should
not become a thin pointer file, and it should not hide enforceable constraints in prose rather than its `## Rules` section.

## Work Lanes (v2)

Before entering a producing or execution workflow, classify new material work using
`shared-procs/WORK-LANES.md`. Fast records an in-session micro-plan; Standard creates an approved Change Spec;
Assured uses the complete behavior and execution package. The pre-v2 Refining and Planning-Implementation funnel
remains the compatibility route for active v1 work and the normal Assured route.

Canonical Mode Workflow sections:

- `Purpose`
- `Mode Story`
- `Operating Posture`
- `When To Use`
- `Workflow Paths`
- `Core Moves`
- `Routing`
- `Outputs`
- `Examples`
- `Rules`
- `Reference Files`

Every mode file follows this canonical form. Explanatory mode prose stays in the Mode Workflow; enforceable
gates, approvals, validation, loading, traceability, and safety boundaries live in the file`s own `## Rules` section.

## Mode Overview

| Mode | CLI | Purpose |
| --- | --- | --- |
| Partnering | — | Structured conversation to capture ideas and problems |
| Refining | `/create-use-case`, `/create-spec`, `/create-tasks` | Derive a Use Case, Spec, or Tasks from their upstream source |
| Planning-Implementation | `/plan-task`, `/plan-spec`, `/plan-use-case` | Plan and gate code changes |
| Implementing | `/execute-plan` | Execute a `ready` plan |
| Discovering-Legacy | `/legacy-discovery` | Extract evidence from existing code (Legacy Discovery Extension — active only when enabled in `HARNESS-PROFILE.yaml`) |
| Improving-Harness | `/improve-harness` | Change the harness itself |

---

## Partnering

The conversational front door for unclear thinking — a structured sparring partner, not a solution machine.
Produces Transcripts and Ideas, and identifies ADRs and Use Cases for hand-off to the appropriate mode — Partnering
may draft a candidate ADR itself when a settled decision surfaces (`DEC-01-010`, mirrored by `PTN-02-100`), but
does not draft Use Cases, Specs, Tasks, or Plans itself; it classifies the request via
`shared-procs/RISK-TIER.md`'s cascade and hands off to whichever entry point the classification lands on —
Refining, or directly into Planning-Implementation when no upstream artifact is needed at all. Ends only on
explicit user request, never on a vague statement. See `agent-harness/modes/PARTNERING.md` for the full rule set.

## Refining

Derives the next artifact in the Use-Case → Spec → Task funnel from its source — a Use Case from an Idea/
Transcript/Partnering discussion/Legacy Finding/existing docs, a Spec from a Use Case, or Tasks from a Spec —
unless `shared-procs/RISK-TIER.md`'s cascade classifies a lower tier sufficient, in which case the corresponding
entry point may be entered directly. Each entry point also accepts natural language. See
`agent-harness/modes/REFINING.md` for entry points, gates, and boundaries, and [03-artifacts.md](03-artifacts.md)
for the resulting documents' own schemas.

## Planning-Implementation

The mandatory gate before code changes: inspect the artifact, gather downstream artifacts, verify maturity,
produce an Implementation Plan, and wait for approval. Also reachable with no upstream artifact at all, when
`shared-procs/RISK-TIER.md`'s cascade classifies a request as needing none of Use Case/Spec/Task — see that
file and `agent-harness/modes/PLANNING-IMPLEMENTATION.md`'s `IPL-08-010`/`IPL-08-020`. See
`agent-harness/modes/PLANNING-IMPLEMENTATION.md` for entry points and routing.

## Implementing

Changes code, one plan step at a time by default, only after a `ready` Implementation Plan exists. Invokes the
shared Validation procedure ([04-shared-procs.md](04-shared-procs.md)) as its closing gate after each step. See
`agent-harness/modes/IMPLEMENTING.md`.

## Discovering-Legacy

Extracts rewrite-quality evidence from an existing project — evidence, not authority. Provided by the optional
Legacy Discovery Extension; base context never loads it unless `harness-data/HARNESS-PROFILE.yaml` sets
`extensions.legacy_discovery: enabled`. See `agent-harness/extensions/legacy-discovery/EXTENSION.md`.

## Improving-Harness

Changes the harness itself, triggered only by a harness/process-flavored Review finding — never from Partnering
or a direct request. The only Mode allowed to modify `agent-harness/*`. See
`agent-harness/modes/IMPROVING-HARNESS.md`.
