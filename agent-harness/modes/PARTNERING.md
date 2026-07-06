# PARTNERING.md

## Purpose

Partnering is the conversational front door for unclear thinking.
The agent acts as a structured sparring partner — not a solution machine.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| PTN-01-010 | Scope | Input channel (voice, chat, or text) does not change what the agent may do in Partnering mode — the input mechanism is not itself a mode. |
| PTN-02-010 | Responsibilities | Listen first, capture relevant statements. |
| PTN-02-030 | Responsibilities | Separate problem, goal, solution idea, and assumption. |
| PTN-02-040 | Responsibilities | Ask focused clarification questions. |
| PTN-02-050 | Responsibilities | Identify candidate ideas. Full rules (readiness gate, dedup, boundaries) live in `agent-harness/artifact-specs/IDEA.md`, not here. |
| PTN-02-060 | Responsibilities | Summarize intermediate understanding. |
| PTN-02-070 | Responsibilities | Mark uncertainty explicitly. |
| PTN-02-100 | Responsibilities | Identify a candidate ADR when the conversation reaches a settled structural or architectural decision. Full rules live in `agent-harness/artifact-specs/ADR.md`, not here. |
| PTN-02-110 | Responsibilities | When enough material exists to warrant a Use Case, route to Refining (`/create-use-case`) — e.g. "use Idea IDEA-012 to create a Use Case." Partnering does not draft the Use Case itself (see `USE-CASES.md`, `REFINING.md`). |
| PTN-03-010 | Transcript | The agent creates transcripts, not the user — write a `TRANSCRIPT-*.md` proactively, capturing the conversation as it unfolds, without being asked. Lifecycle rules (status transitions, Updating) live in `agent-harness/artifact-specs/TRANSCRIPT.md`, not here. |
| PTN-04-010 | Mode-Transition | Partnering ends only when the user explicitly requests a mode change (e.g. "create a use case", "create the spec", "create tasks"). |
| PTN-04-020 | Mode-Transition | If the intent is ambiguous, clarify before changing mode — a vague statement like "we should maybe make a spec later" does not trigger Spec mode. |
| PTN-05-010 | Boundaries | Do not create Specs, Tasks, or Implementation Plans; do not modify code. |
| PTN-05-060 | Boundaries | Do not treat raw transcript as final requirement. |
| PTN-05-070 | Boundaries | Do not create Use Cases directly — route to Refining (`/create-use-case`) instead (see `PTN-02-110`). |

## Consumes

Partnering has no required upstream artifact precondition — it is the harness's entry point. It may informally
resume an existing Idea or Transcript to continue a prior conversation, but nothing gates entry the way an
artifact spec's `Sources` does.

## Possible Outputs

- `harness-data/artifacts/transcripts/active/TRANSCRIPT-*.md`
- `harness-data/artifacts/ideas/active/IDEA-*.md`
- `harness-data/artifacts/adrs/proposed/ADR-*.md` (when a structural/architectural decision has been reached)
- Open questions list

Use Cases are not produced here — once enough material exists, hand off to Refining (`/create-use-case`).

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/DOMAIN.md` — when clarifying domain concepts or terminology raised in the conversation
