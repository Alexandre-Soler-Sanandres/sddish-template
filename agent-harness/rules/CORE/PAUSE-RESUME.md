# CORE / Pause-Resume Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-07-010 | Pause-Resume | MUST record the exact restart point before pausing interrupted work that will continue later. |
| COR-07-020 | Pause-Resume | MUST record the current execution state before pausing. |
| COR-07-030 | Pause-Resume | MUST record, before pausing, any checks that must be re-run before continuing. |
| COR-07-050 | Pause-Resume | MUST confirm, on resume, that the restart point is still valid. |
| COR-07-060 | Pause-Resume | MUST confirm, on resume, that no newer artifact, status change, or user instruction invalidates the old plan. |
| COR-07-070 | Pause-Resume | MUST re-run, on resume, any validations or checks that were still uncertain at pause time. |
| COR-07-080 | Pause-Resume | MUST NOT resume from stale conversational state alone when restart point or validation state matters. |
