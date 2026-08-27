# IMPLEMENTATION-PLAN Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IPL-01-010 | Grouping | SHOULD group Tasks in one step when they belong to the same Spec, are small and tightly related, share a validation strategy, their scopes do not conflict, they produce a coherent reviewable diff, and no high-risk work is involved. |
| IPL-01-030 | Grouping | A Plan whose entry skipped any tier (per `shared-procs/RISK-TIER.md`'s cascade) MUST include a `## Risk-Tier Classification` section (`RSK-05-010`). |
| IPL-01-031 | Grouping | MUST NOT omit `IPL-01-030`'s `## Risk-Tier Classification` section regardless of how small the change is. |
| IPL-01-020 | Grouping | SHOULD keep Tasks separate when risk is high, validation differs between Tasks, separate commits are needed, review concerns differ, dependencies are unclear, or the change touches database, deployment, security, payment execution, security-critical logic, or domain-critical business rules. |
| IPL-02-010 | Readiness-Gate | Before this Plan's promotion (`STT-01-030`'s Plan row), MUST verify the Readiness Checks section in the artifact. |
| IPL-02-011 | Readiness-Gate | Every Readiness Checks item MUST be checked; a single unchecked item blocks the status change. |
| IPL-02-012 | Readiness-Gate | Each checked Readiness Checks item MUST be accompanied by a one-line evidence pointer (e.g. a test name, file path, or line reference) recorded beneath the checklist; a checked item with no citable evidence blocks the status change the same as an unchecked one. |
| IPL-02-013 | Readiness-Gate | In the same transition that sets a Plan to `ready`, MUST populate `approval.approved_by` and `approval.approved_at` from the explicit user instruction authorizing that promotion. |
| IPL-05-010 | Parallel-Work | Before setting a Plan status to `ready`, MUST check `harness-data/CATALOG.md` for other Plans at status `ready` or `in-progress` on the same Spec (`IPL-05-030`) or with overlapping Task `allowed_paths` (`IPL-05-050`). |
| IPL-05-011 | Parallel-Work | MUST stop and surface the conflict if `IPL-05-010`'s check finds either condition. |
| IPL-05-020 | Parallel-Work | MUST keep `harness-data/CATALOG.md`'s Active Implementation Plans table accurate for all Plans at status `ready` or `in-progress`: add or update a Plan's row in the same pass its status changes to `ready` or `in-progress`; remove the row once the Plan is no longer either. For a Plan-tier Plan (`entrypoint_type: none`), record its row with the Spec ID column as `—`; the row is still required while the Plan is `ready` or `in-progress`, so `IPL-05-050`'s path-overlap check has a live table to check against. |
| IPL-06-010 | Commit-Convention | MUST use the Commit Message Convention format in `IMPLEMENTATION-PLAN.md`'s `## Commit Message Convention` for a Plan step's suggested commit boundaries, citing the step's Task IDs under `Implements:` and its source Spec under `Source:`. |
