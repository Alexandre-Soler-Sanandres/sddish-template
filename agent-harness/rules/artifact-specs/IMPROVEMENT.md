# IMPROVEMENT Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPR-03-010 | Validation | MUST keep `## Validation` as the validation plan or checklist. |
| IMPR-03-020 | Validation | MUST add `## Validation Result` with the date, checks performed, and outcome before an Improvement artifact is set to `done` or moved to `done/`. |
| IMPR-03-030 | Validation | If a validation item is prospective and cannot be fully proven yet, MUST state that explicitly instead of treating it as completed evidence. |
| IMPR-03-040 | Validation | MUST NOT move an Improvement artifact to `done/` until the approved target changes are applied and the validation result is documented. |
| IMPR-03-050 | Validation | `status: proposed -> approved` is a distinct, user-only gate from this file's `approved -> done` validation gate (`IMPR-03-040`) — see `IMPR-02-025` in `IMPROVING-HARNESS.md`. Meeting `IMPR-03-040`'s validation conditions MUST NOT be treated as substituting for that approval. |
| IMPR-04-010 | Traceability | MUST add this Improvement's own ID to the `follow_up` field of every Review in `source`, at creation time — not deferred until approval or `done`. |
| IMPR-04-020 | Traceability | When this Improvement's `status` transitions to `done` or `rejected`, MUST resolve each `source` Review per `REVIEW.md`'s `RVW-06-010` if every `follow_up` Improvement is now terminal. |
| IMPR-04-030 | Traceability | MUST perform the `RVW-06-010` resolution in the same action as this Improvement's `done`/`rejected` transition — not a separately-scheduled sweep. |
