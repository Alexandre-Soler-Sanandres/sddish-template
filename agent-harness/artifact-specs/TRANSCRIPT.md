# TRANSCRIPT.md

## Purpose

A Transcript is the raw or lightly-processed record of a conversation, captured proactively during Partnering
(`PTN-03-010`). Given the same standard of treatment as every other artifact — its status enum is not decorative.

## Artifact Story

A Partnering conversation unfolds and the agent writes it down as it happens — the user never has to ask.
Content stays `raw` until it's normalized (original-language snippets preserved only where needed, everything
else in English), then `processed` once the artifact IDs it was distilled into are recorded, then `reviewed`
once that normalization is verified.

## Entry / Creation Paths

Created only from within Partnering, proactively by the agent — never by the user.

## Sources

Created only from within Partnering, capturing that session's own conversation.

## When To Create

At the start of every Partnering conversation the agent expects to continue — see
`agent-harness/modes/PARTNERING.md`'s `PTN-03-010`.

## When Not To Create

Not applicable — a Transcript is always created proactively whenever Partnering conducts a conversation worth
recording; there is no separate creation gate to fail.

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

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/TRANSCRIPT.md` (single paired
file — under the 25-rule grouping threshold). Load it whenever creating or updating a Transcript.

## Reference Files

None beyond the template.
