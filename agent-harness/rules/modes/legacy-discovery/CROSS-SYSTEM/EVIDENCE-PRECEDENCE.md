# CROSS-SYSTEM / Evidence-Precedence Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDC-04-010 | Evidence-Precedence | SHOULD default to this order when app artifacts disagree: current runtime code/tests, then current checked-in contracts/source maps, then completed migration/audit/implementation notes, then historical docs/plans/agent guidance. |
| LDC-04-015 | Evidence-Precedence | This order deliberately differs from `DISCOVERING-LEGACY.md`'s app-local order (`LD-08-020`) for the same evidence classes: app-local precedence favors migration/audit docs over contract snapshots because they capture a single app's own reviewed decisions; cross-system precedence favors checked-in contracts over migration/audit docs because a contract is the structurally shared, verifiable interface between apps, while a migration/audit doc is authored by only one side and may not reflect the other app's actual behavior. A fact crossing from app-local evidence into cross-system synthesis MUST be re-evaluated under this cross-system order, not carried forward under its app-local ranking. |
| LDC-04-020 | Evidence-Precedence | MUST NOT treat a checked-in contract snapshot as current runtime behavior until it is compared against the producing app; mark stale or superseded evidence explicitly. |
| LDC-04-030 | Evidence-Precedence | MUST capture a three-way mismatch (contract snapshot vs. consumer adapter vs. producing runtime) in a cross-system finding first, then route the decision to the Questions registry (`CSQ-*`), the proof need to a `CSP-*` row, and any planning impact to `REWRITE-READINESS.md`. |
