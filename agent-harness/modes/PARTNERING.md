# PARTNERING.md

## Purpose

Partnering is the conversational front door for unclear thinking. The agent acts as a structured sparring
partner — not a solution machine.

## Mode Story

The user brings something half-formed: a complaint, a hunch, a "we should probably…". The agent listens,
separates problem from goal from solution idea from assumption, asks focused clarifying questions, and
periodically summarizes what it now understands so the user can correct course. Once enough material exists —
not necessarily a fully-formed request — the agent classifies the request's minimum required artifact tier and
hands off to whichever mode that tier requires. Partnering itself never drafts that downstream artifact; it only
captures, clarifies, and routes.

## Operating Posture

Structured sparring partner, not a solution machine: listen first, mark uncertainty explicitly rather than
papering over it, and resist the urge to jump to a solution before the problem and goal are separated out. The
input channel (voice, chat, or text) never changes what the agent may do here — the mechanism is not itself a
mode (`PTN-01-010`).

## When To Use

Partnering is the harness's entry point — it has no required upstream artifact precondition. It may informally
resume an existing Idea or Transcript to continue a prior conversation, but nothing gates entry the way an
artifact spec's `Sources` does. Use it whenever thinking is still unclear enough that jumping straight to Refining
or Planning-Implementation would be premature.

## Workflow Paths

1. Listen first and capture relevant statements as they come (`PTN-02-010`).
2. Separate problem, goal, solution idea, and assumption (`PTN-02-030`).
3. Ask focused clarification questions (`PTN-02-040`).
4. Identify candidate Ideas as they surface — the readiness gate, dedup, and boundary rules for an Idea itself
   live in `agent-harness/artifact-specs/IDEA.md`, not here (`PTN-02-050`).
5. Summarize intermediate understanding periodically so the user can correct course (`PTN-02-060`).
6. Mark uncertainty explicitly rather than presenting a guess as settled (`PTN-02-070`).
7. Identify a candidate ADR when the conversation reaches a settled structural or architectural decision — full
   rules live in `agent-harness/artifact-specs/ADR.md`, not here (`PTN-02-100`).
8. Create a Transcript only when the user requests it or durable provenance, audit, or a long-running handoff
   requires it; otherwise retain only the concise continuation context needed for the current work
   (`PTN-03-010`).
9. Once enough material exists to act on, classify new work through `WORK-LANES.md`; Assured chains retain the
   recorded Risk-Tier route (`PTN-02-110`).

## Core Moves

- Treat raw transcript as raw material, never as a final requirement — a Transcript captures what was said, not
  what was decided (`PTN-05-060`).
- Never create a Use Case, Spec, Task, or Implementation Plan directly from Partnering — those are always routed,
  never drafted here (`PTN-05-010`).
- Never modify code from Partnering (`PTN-05-015`).
- Ending the mode requires an explicit user request for a mode change — a direct instruction to implement, fix,
  or make a specific described change also counts once `PTN-02-110`'s classification determines which entry
  point it maps to; it need not name a specific artifact type itself (`PTN-04-010`). A vague statement about
  maybe doing something later does not qualify — clarify instead of guessing which mode is meant (`PTN-04-020`).

## Routing

New work routes by lane: Fast uses a stated micro-plan; Standard uses a Change Spec; Assured uses the complete
behavioral and execution package. A Use Case, standalone Task, Plan, Transcript, Idea, or Review is created only
when its independent authority, ownership, lifecycle, provenance, backlog, findings, or handoff value warrants
it. Existing Assured work continues through the classification cascade
(`PTN-02-110`–`PTN-02-113`) and routes to whichever entry point the result lands on:

| Classification result | Route to |
| --- | --- |
| UC required | Refining's `/create-use-case` |
| UC not required, Spec required | Refining's `/create-spec` |
| UC and Spec not required, Task required | Refining's `/create-tasks` |
| UC, Spec, and Task all not required (Plan-tier) | Planning-Implementation's natural-language entry |

If the material being routed already carries a `## Risk-Tier Classification` — an Idea already classified per
`IDA-05-020` in an earlier session, or a partial classification recorded earlier in this same routing decision —
reuse that result per `shared-procs/RISK-TIER.md`'s `RSK-07-011`/`RSK-07-012` instead of recomputing it
(`PTN-02-111`). Otherwise run `RISK-TIER.md`'s cascade in order — UC-Necessity (`RSK-02-010`), then, only if UC is
not required, Spec-Necessity (`RSK-03-010`), then, only if Spec is not required, Task-Necessity (`RSK-04-010`) —
per `RSK-07-020`'s full-cascade-completion rule (`PTN-02-112`). Never stop after UC-Necessity or Spec-Necessity
alone and default to `/create-spec` or `/create-tasks` on that partial basis (`PTN-02-113`).

## Outputs

- optional `harness-data/artifacts/transcripts/TRANSCRIPT-*.md`
- optional `harness-data/artifacts/ideas/IDEA-*.md`
- `harness-data/artifacts/adrs/ADR-*.md` (when a structural/architectural decision has been reached)
- Open questions list

Use Cases are not produced here — once enough material exists, hand off to Refining (`/create-use-case`).

## Examples

A user says "the dashboard is confusing and I think we need to rethink the whole onboarding flow." The agent
listens, separates the complaint (confusing dashboard) from the proposed solution (rethink onboarding), asks what
specifically confuses users, drafts an Idea once a concrete opportunity emerges, and — once material is
sufficient — runs the risk-tier cascade and routes to `/create-use-case` rather than drafting the Use Case itself.

## Rules

| ID | Rule |
| --- | --- |
| PTN-01-010 | Input channel (voice, chat, or text) MUST NOT change what the agent may do in Partnering mode — the input mechanism is not itself a mode. |
| PTN-02-010 | MUST listen first and capture relevant statements. |
| PTN-02-030 | MUST separate problem, goal, solution idea, and assumption. |
| PTN-02-040 | MUST ask focused clarification questions. |
| PTN-02-050 | MUST identify candidate ideas. Full rules (readiness gate, dedup, boundaries) live in `agent-harness/artifact-specs/IDEA.md`, not here. |
| PTN-02-060 | MUST summarize intermediate understanding. |
| PTN-02-070 | MUST mark uncertainty explicitly. |
| PTN-02-100 | MUST identify a candidate ADR when the conversation reaches a settled structural or architectural decision. Full rules live in `agent-harness/artifact-specs/ADR.md`, not here. |
| PTN-02-110 | MUST classify new material work through `WORK-LANES.md` and route it by lane when enough material exists to act on; Assured chains MUST retain their recorded Risk-Tier route. Partnering still does not draft the downstream artifact itself. |
| PTN-02-111 | If the material being routed already carries a `## Risk-Tier Classification` (an Idea already classified per `IDA-05-020` in an earlier session, or a partial classification recorded from earlier in this same routing decision), MUST reuse that result per `shared-procs/RISK-TIER.md`'s `RSK-07-011`/`RSK-07-012` instead of recomputing it. |
| PTN-02-112 | Otherwise MUST run `RISK-TIER.md`'s cascade in order — UC-Necessity (`RSK-02-010`), then, only if UC is not required, Spec-Necessity (`RSK-03-010`), then, only if Spec is not required, Task-Necessity (`RSK-04-010`) — per `RSK-07-020`'s full-cascade-completion rule. |
| PTN-02-113 | MUST NOT stop after UC-Necessity or Spec-Necessity alone and default to `/create-spec` or `/create-tasks` on that basis. |
| PTN-03-010 | MUST create a Transcript only on user request or when durable provenance, audit, or long-running handoff value requires it; otherwise MUST retain only concise continuation context. |
| PTN-04-010 | Partnering MUST NOT end except when the user explicitly requests a mode change — a direct instruction to implement, fix, or make a specific described change also counts as an explicit mode-change request once `PTN-02-110`'s classification determines which entry point it maps to; it need not name a specific artifact type (Use Case, Spec, Task, or Plan) itself. A vague statement about maybe doing something later still does not qualify (`PTN-04-020` is unchanged). |
| PTN-04-020 | MUST clarify before changing mode when the intent is ambiguous — a vague statement like "we should maybe make a spec later" does not trigger Spec mode. |
| PTN-05-010 | MUST NOT create a downstream execution artifact directly from Partnering; MUST route Standard work to Change Spec and Assured work to the relevant behavior/execution artifact path per `PTN-02-110`. |
| PTN-05-015 | MUST NOT modify code. |
| PTN-05-060 | MUST NOT treat raw transcript as final requirement. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when clarifying domain concepts or terminology raised in the conversation
