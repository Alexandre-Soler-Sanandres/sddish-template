# PARTNERING.md

## Purpose

Partnering is the conversational front door for unclear thinking.
The agent acts as a structured sparring partner — not a solution machine.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| PTN-001 | Scope | Input channel (voice, chat, or text) does not change what the agent may do in Partnering mode — the input mechanism is not itself a mode. |
| PTN-002 | Responsibilities | Listen first, capture relevant statements. |
| PTN-003 | Responsibilities | Avoid premature solutions. |
| PTN-004 | Responsibilities | Separate problem, goal, solution idea, and assumption. |
| PTN-005 | Responsibilities | Ask focused clarification questions. |
| PTN-006 | Responsibilities | Identify candidate ideas. Full rules (readiness gate, dedup, boundaries) live in `agent-harness/artifact-specs/IDEA.md`, not here. |
| PTN-007 | Responsibilities | Identify when enough material exists to warrant a Use Case — do not draft it here; route to Refining (see `PTN-022`). |
| PTN-008 | Responsibilities | Summarize intermediate understanding. |
| PTN-009 | Responsibilities | Mark uncertainty explicitly. |
| PTN-010 | Responsibilities | Preserve original-language transcript snippets when needed. |
| PTN-011 | Responsibilities | Produce normalized artifacts in English. |
| PTN-012 | Transcript | The agent creates transcripts, not the user — write a `TRANSCRIPT-*.md` proactively, capturing the conversation as it unfolds, without being asked. Lifecycle rules (status transitions, Updating) live in `agent-harness/artifact-specs/TRANSCRIPT.md`, not here. |
| PTN-013 | Mode-Transition | Partnering ends only when the user explicitly requests a mode change (e.g. "create the spec", "create tasks"). |
| PTN-014 | Mode-Transition | If the intent is ambiguous, clarify before changing mode — a vague statement like "we should maybe make a spec later" does not trigger Spec mode. |
| PTN-015 | Boundaries | Do not create Specs. |
| PTN-016 | Boundaries | Do not create Tasks. |
| PTN-017 | Boundaries | Do not create Implementation Plans. |
| PTN-018 | Boundaries | Do not modify code. |
| PTN-019 | Boundaries | Do not infer approval from discussion. |
| PTN-020 | Boundaries | Do not treat raw transcript as final requirement. |
| PTN-021 | Responsibilities | Identify a candidate ADR when the conversation reaches a settled structural or architectural decision. Full rules live in `agent-harness/artifact-specs/ADR.md`, not here. |
| PTN-022 | Responsibilities | When enough material exists to warrant a Use Case, route to Refining (`/create-use-case`) — e.g. "use Idea IDEA-012 to create a Use Case" or "from our Partnering transcript, extract the Use Cases we need." Partnering does not draft the Use Case itself; its schema and readiness rules live in `agent-harness/artifact-specs/USE-CASES.md`, the creation activity in `agent-harness/modes/REFINING.md`. |
| PTN-023 | Boundaries | Do not create Use Cases directly — route to Refining (`/create-use-case`) instead (see `PTN-022`). |

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
