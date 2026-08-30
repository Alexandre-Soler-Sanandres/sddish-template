# TRANSCRIPT.md

## Purpose

A Transcript is the raw or lightly-processed record of a conversation, captured only when requested or when it
has durable provenance, audit, or long-running-handoff value (`PTN-03-010`). Its status enum is not decorative.

## Artifact Story

A Partnering conversation unfolds and the agent writes it down as it happens — the user never has to ask.
Content stays `recording` while captured. It becomes `recorded` once normalization is verified; `processed_into`
independently records any artifacts distilled from it.

## Entry / Creation Paths

Created from Partnering when the creation criterion is met.

## Sources

Created only from within Partnering, capturing that session's own conversation.

## When To Create

When the user requests a Transcript or durable provenance, audit, or long-running handoff requires one — see
`agent-harness/modes/PARTNERING.md`'s `PTN-03-010`.

## When Not To Create

Do not create a Transcript merely because a Partnering conversation occurred; retain concise continuation context
unless the `## When To Create` criterion applies.

## Artifact Shape

`status` moves `recording` → `recorded` → `archived` (see `## Lifecycle`) as content is normalized and
distilled into other artifacts. `processed_into` lists the artifact IDs this transcript was distilled into.

## Field Semantics

- `status` — see `## Lifecycle`.
- `processed_into` — optional forward record of artifacts distilled from this Transcript.

## Body Should Include

- Raw Content
- Summary
- Open Questions

(schema unchanged — see `agent-harness/templates/TRANSCRIPT-template.md`)

## Lifecycle

Before setting status to `recorded`, verify the content has been normalized per `CORE.md`'s `COR-02-010`/
`COR-02-020` (original-language snippets preserved only where needed, everything else in English) (`TRN-01-010`).
When downstream artifacts are created, record their IDs in `processed_into` (`TRN-01-020`). Every status change
updates the same stable file in place (`TRN-01-030`). A recorded Transcript keeps evidentiary value even once
distilled (`TRN-01-040`).

## Readiness / Acceptance

See `## Lifecycle`'s `TRN-01-010` gate for `recorded`. The Transcript ID must never change; appending content
while still `recording` is normal (`TRN-02-010`).

## Relationships

`processed_into` links this Transcript to whichever Idea, Use Case, Spec, or other artifact it was distilled
into.

## Output / Location

- `harness-data/artifacts/transcripts/TRANSCRIPT-*.md` (`recording`/`recorded`/`archived`), using
  `agent-harness/templates/TRANSCRIPT-template.md` unchanged.
- `harness-data/artifacts/transcripts/TRANSCRIPT-*.md` (`archived`)

## Template

Use `agent-harness/templates/TRANSCRIPT-template.md` unchanged.

## Examples

A Partnering session runs long and covers three distinct problems. The agent keeps writing to one Transcript
throughout (`recording`), then normalizes it, sets it to `recorded`, and records any distilled artifact IDs.

## Rules

| ID | Rule |
| --- | --- |
| TRN-00-010 | MUST create a Transcript only on user request or when durable provenance, audit, or long-running handoff value requires it. |
| TRN-01-010 | Before setting status to `recorded`, MUST verify normalization per `CORE.md`'s `COR-02-010`/`COR-02-020`. |
| TRN-01-020 | When a Transcript is distilled into artifacts, MUST list their IDs in `processed_into`. |
| TRN-01-030 | Transcript status changes MUST update the stable file in place. |
| TRN-01-040 | A `recorded` Transcript MUST retain evidentiary value even after downstream use. |
| TRN-02-010 | The Transcript ID MUST NOT change. Appending content while `recording` is normal. |

## Reference Files

None beyond the template.
