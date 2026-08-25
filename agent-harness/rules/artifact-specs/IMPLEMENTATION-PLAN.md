# IMPLEMENTATION-PLAN Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IPL-01-010 | Grouping | SHOULD group Tasks in one step when they belong to the same approved Spec, are small and tightly related, share a validation strategy, their scopes do not conflict, they produce a coherent reviewable diff, and no high-risk work is involved. |
| IPL-01-030 | Grouping | A Plan whose entry skipped any tier (per `shared-procs/RISK-TIER.md`'s cascade) MUST include a `## Risk-Tier Classification` section (`RSK-05-010`). |
| IPL-01-031 | Grouping | MUST NOT omit `IPL-01-030`'s `## Risk-Tier Classification` section regardless of how small the change is. |
| IPL-01-020 | Grouping | SHOULD keep Tasks separate when risk is high, validation differs between Tasks, separate commits are needed, review concerns differ, dependencies are unclear, or the change touches database, deployment, security, payment execution, security-critical logic, or domain-critical business rules. |
| IPL-02-010 | Readiness-Gate | Before setting a Plan status to `approved`, MUST verify the Readiness Checks section in the artifact. |
| IPL-02-011 | Readiness-Gate | Every Readiness Checks item MUST be checked; a single unchecked item blocks the status change. |
| IPL-05-010 | Parallel-Work | Before setting a Plan status to `approved`, MUST check `harness-data/CATALOG.md` for other Plans at status `approved` or `in-progress` on the same Spec (`IPL-05-030`) or with overlapping Task `allowed_paths` (`IPL-05-050`). |
| IPL-05-011 | Parallel-Work | MUST stop and surface the conflict if `IPL-05-010`'s check finds either condition. |
| IPL-05-020 | Parallel-Work | MUST keep `harness-data/CATALOG.md`'s Active Implementation Plans table accurate for all Plans at status `approved` or `in-progress`: add or update a Plan's row in the same pass its status changes to `approved` or `in-progress`; remove the row once the Plan is no longer either. For a Plan-tier Plan (`entrypoint_type: none`), record its row with the Spec ID column as `—`; the row is still required while the Plan is `approved` or `in-progress`, so `IPL-05-050`'s path-overlap check has a live table to check against. |
| IPL-05-080 | Cascade | When a Plan reaches status `done` and every Task derived from a Spec is `done`, MUST set that Spec's status to `implemented`. |
| IPL-05-081 | Cascade | When every Spec derived from a Use Case is `implemented`, MUST set the Use Case's status to `implemented`. |
| IPL-05-082 | Cascade | If a Plan or Task reopens after `IPL-05-080`/`IPL-05-081`'s cascade already ran (independent of `SPECS.md`'s `SPS-07-020`), the Spec's/Use Case's `implemented` status this cascade set may now be stale — see `CORE.md`'s `COR-01-130`, which governs the reconsideration obligation for that case. |
| IPL-06-010 | Commit-Convention | MUST use the Commit Message Convention format in `IMPLEMENTATION-PLAN.md`'s `## Commit Message Convention` for a Plan step's suggested commit boundaries, citing the step's Task IDs under `Implements:` and its source Spec under `Source:`. |
