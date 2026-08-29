# TRANSCRIPT.md

## Purpose

A Transcript is the raw or lightly-processed record of a conversation, captured only when requested or when it
has durable provenance, audit, or long-running-handoff value (`PTN-03-010`). Its status enum is not decorative.

## Artifact Story

A Partnering conversation unfolds and the agent writes it down as it happens — the user never has to ask.
Content stays `raw` until it's normalized (original-language snippets preserved only where needed, everything
else in English), then `processed` once the artifact IDs it was distilled into are recorded, then `reviewed`
once that normalization is verified.

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

`status` moves through `raw` → `processed`/`reviewed` (see `## Lifecycle`) as content is normalized and
distilled into other artifacts. `processed_into` lists the artifact IDs this transcript was distilled into.

## Field Semantics

- `status` — see `## Lifecycle`.
- `processed_into` — required before `status: processed`; see `## Lifecycle`'s `TRN-01-020`.

## Body Should Include

- Raw Content
- Summary
- Open Questions

(schema unchanged — see `agent-harness/templates/TRANSCRIPT-template.md`)

## Lifecycle

Before setting status to `reviewed`, verify the content has been normalized per `CORE.md`'s `COR-02-010`/
`COR-02-020` (original-language snippets preserved only where needed, everything else in English) (`TRN-01-010`).
Before setting status to `processed`, verify `processed_into` lists the artifact IDs this transcript was
distilled into (`TRN-01-020`). `archived` transcripts move to `harness-data/artifacts/transcripts/archive/`,
content preserved (same non-destructive precedent as `COR-01-080`) (`TRN-01-030`). `processed`/`reviewed`
Transcripts intentionally remain in `active/` — a Transcript keeps evidentiary value even once distilled, unlike
`archived`, which means no longer relevant (`TRN-01-040`).

## Readiness / Acceptance

See `## Lifecycle`'s `TRN-01-010`/`TRN-01-020` gates for `reviewed`/`processed`. The Transcript ID must never
change; appending content while still `raw` is normal and does not require a status change (`TRN-02-010`).

## Relationships

`processed_into` links this Transcript to whichever Idea, Use Case, Spec, or other artifact it was distilled
into.

## Output / Location

- `harness-data/artifacts/transcripts/active/TRANSCRIPT-*.md` (`raw`/`processed`/`reviewed`), using
  `agent-harness/templates/TRANSCRIPT-template.md` unchanged.
- `harness-data/artifacts/transcripts/archive/TRANSCRIPT-*.md` (`archived`)

## Template

Use `agent-harness/templates/TRANSCRIPT-template.md` unchanged.

## Examples

A Partnering session runs long and covers three distinct problems. The agent keeps writing to one Transcript
throughout (`raw`), then once the session distills into two Ideas and a candidate ADR, sets `processed_into` to
those three IDs and moves the Transcript to `processed`.

## Rules

| ID | Rule |
| --- | --- |
| TRN-00-010 | MUST create a Transcript only on user request or when durable provenance, audit, or long-running handoff value requires it. |
| TRN-01-010 | Before setting status to `reviewed`, MUST verify the content has been normalized per `CORE.md`'s `COR-02-010`/`COR-02-020` (original-language snippets preserved only where needed, everything else in English). |
| TRN-01-020 | Before setting status to `processed`, MUST verify `processed_into` lists the artifact IDs this transcript was distilled into. |
| TRN-01-030 | `archived` transcripts MUST move to `harness-data/artifacts/transcripts/archive/`, content preserved (same non-destructive precedent as `COR-01-080`). |
| TRN-01-040 | `processed`/`reviewed` Transcripts MUST remain in `active/` — no folder move for these statuses. A Transcript keeps evidentiary value even once distilled, unlike `archived`, which means no longer relevant. |
| TRN-02-010 | The Transcript ID MUST NOT change. Appending content while still `raw` is normal and does not require a status change. |

## Reference Files

None beyond the template.
