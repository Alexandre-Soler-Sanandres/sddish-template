# DISCOVERING-LEGACY / Completion-and-Proof Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-05-010 | Completion-Criteria | MAY move to `app-local-complete` when: all planned slices are `done`, `not-needed`, or explicitly deferred; every open Question referenced from this app (per `COR-01-120`) has a `QST-01-010` Classification recorded in the canonical Questions registry — not a local copy in the source map; stable findings have been propagated to reference docs where appropriate; and no remaining slice is needed for app-local rewrite planning. |
| LD-06-010 | Proof-Gate | MUST set `proof_needed` to `true` when discovery found drift or runtime behavior needing executable proof before rewrite planning treats it as stable; to `false` when no required executable proof is known, or required proof is complete. |
| LD-06-030 | Proof-Gate | MAY reach `app-local-complete` with `proof_needed: true`. Rewrite-ready means the remaining proof obligations are explicit and can be carried forward into Use Cases, Specs, validation, or later implementation work without making the rewrite design incoherent. |
