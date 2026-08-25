# APP-LOCAL / Slice Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDA-03-010 | Slice | MUST treat slices as the durable unit of discovery progress. |
| LDA-03-020 | Slice | MUST define enough slices to cover every area of the app where material findings could exist; the app's own shape, not a fixed count or another app's slice list, decides how many slices that requires and where their boundaries fall. |
| LDA-03-030 | Slice | Every slice MUST have status `done`, `next`, `pending`, or `not-needed`. |
| LDA-03-040 | Slice | MUST NOT mark a slice `done` until findings and unresolved questions are recorded. |
| LDA-03-050 | Slice | Completed slice notes (`Completed Notes` in the source map) MUST hold evidence paths, stable findings, unresolved decisions, and required slice-closeout records only. |
