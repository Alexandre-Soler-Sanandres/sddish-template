# TRANSCRIPT Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| TRN-00-010 | Conditional Creation | MUST create a Transcript only on user request or when durable provenance, audit, or long-running handoff value requires it. |
| TRN-01-010 | Lifecycle | Before setting status to `reviewed`, MUST verify the content has been normalized per `CORE.md`'s `COR-02-010`/`COR-02-020` (original-language snippets preserved only where needed, everything else in English). |
| TRN-01-020 | Lifecycle | Before setting status to `processed`, MUST verify `processed_into` lists the artifact IDs this transcript was distilled into. |
| TRN-01-030 | Lifecycle | `archived` transcripts MUST move to `harness-data/artifacts/transcripts/archive/`, content preserved (same non-destructive precedent as `COR-01-080`). |
| TRN-01-040 | Lifecycle | `processed`/`reviewed` Transcripts MUST remain in `active/` — no folder move for these statuses. A Transcript keeps evidentiary value even once distilled, unlike `archived`, which means no longer relevant. |
| TRN-02-010 | Updating | The Transcript ID MUST NOT change. Appending content while still `raw` is normal and does not require a status change. |
