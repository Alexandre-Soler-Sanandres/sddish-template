# Database Migration Safety

## Use When

- planning or reviewing schema migrations
- assessing data-change risk before implementation
- validating migration safety and rollback readiness

## Do Not Use For

- normal code changes without schema or persisted-data impact
- purely local fixture or seed updates with no migration risk
- generic persistence design discussion without an actual change

## Required Inputs

- migration intent and affected tables, collections, or records
- forward change, rollback path, and validation plan
- expected impact on reads, writes, backfills, and dependent services

## Agent Procedure

1. Confirm the exact data change and why it is needed.
2. Identify affected schema elements, data flows, and dependent components.
3. Check forward safety: compatibility, ordering, locks, backfills, defaults, and partial-rollout behavior.
4. Check rollback safety: reversal path, data loss risk, and fallback limits.
5. Check validation coverage before and after the migration.
6. Stop if the change is high-risk and the scope or validation remains unclear.

## Required Checks

- forward path is explicit
- rollback path or rollback limitation is explicit
- compatibility risks are stated
- validation covers both migration success and failure scenarios

## Required Output

- migration scope and risk summary
- forward-path notes
- rollback notes
- affected dependencies
- required validation and unresolved risks

## Escalate When

- rollback is impossible or destructive
- live traffic compatibility is unclear
- a backfill or multi-step rollout is required
- validation does not match the migration risk
