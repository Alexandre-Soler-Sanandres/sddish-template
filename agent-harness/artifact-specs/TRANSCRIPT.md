# TRANSCRIPT.md

## Purpose

A Transcript is the raw or lightly-processed record of a conversation, captured proactively during Partnering
(`PTN-03-010`). Given the same standard of treatment as every other artifact — its status enum is not decorative.

## Sources

Created only from within Partnering, capturing that session's own conversation.

## Body Should Include

- Raw Content
- Summary
- Open Questions

(schema unchanged — see `agent-harness/templates/TRANSCRIPT-template.md`)

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| TRN-01-010 | Lifecycle | Before setting status to `reviewed`, verify the content has been normalized per `PTN-02-090` (original-language snippets preserved only where needed, everything else in English). |
| TRN-01-020 | Lifecycle | Before setting status to `processed`, verify `processed_into` actually lists the artifact IDs this transcript was distilled into. |
| TRN-01-030 | Lifecycle | `archived` transcripts move to `harness-data/artifacts/transcripts/archive/`, content preserved (same non-destructive precedent as `COR-01-080`). |
| TRN-02-010 | Updating | The Transcript ID never changes. Appending content while still `raw` is normal and does not require a status change. |

## Output

- `harness-data/artifacts/transcripts/active/TRANSCRIPT-*.md`, using `agent-harness/templates/TRANSCRIPT-template.md` unchanged.
