# Work Lanes

## Selection

Classify material work before planning or execution. Reclassify after a material change to behavior, scope,
non-goals, owner, contract, persistence, deployment, paths, reversibility, or risk.

| Lane | Use when | Durable record | Authorization |
| --- | --- | --- | --- |
| Fast | local, reversible, unambiguous work with evident verification and no hard floor | none by default; state an in-session micro-plan | direct imperative covers the plan |
| Standard | bounded meaningful behavior work with reversible risk | one Change Spec | explicit approval of current content |
| Assured | ambiguity, cross-owner/service boundary, public contract, hard-to-reverse effect, or hard floor | UC -> Spec -> Task(s) -> Execution Plan | approved Execution Plan |

Hard floors are database/schema or destructive data changes, deployment/infrastructure/CI-CD, public API/data
contracts, security/secrets/auth, payment or financial execution, domain-critical logic, and major architecture.

## Rules

| ID | Rule |
| --- | --- |
| LAN-01-010 | Material work MUST be classified Fast, Standard, or Assured before planning or execution. |
| LAN-01-020 | Hard-floor work MUST use Assured. |
| LAN-01-030 | A material input change MUST invalidate lane classification and Standard or Assured approval. |
| LAN-01-040 | Fast work MUST state target, delta, preserved behavior, and check before mutation. |

### Legacy (v1)

Retained verbatim from the pre-v2 paired rules for active v1 UC/Spec/Task/Plan chains during the v2 cutover
(`IMPROVEMENT-0148`–`0150`). The v2 rows above are authoritative for all new work; the v2 numbering reuses
`LAN-01-030`/`LAN-01-040` for different rules, so these keep a `-v1` suffix. Retired by `IMPROVEMENT-0150`.

| ID | Rule |
| --- | --- |
| LAN-01-010-v1 | MUST classify each new material work scope as Fast, Standard, or Assured before planning or execution. |
| LAN-01-020-v1 | MUST classify database/schema or destructive-data work, deployment/infrastructure/CI-CD, public API/data-contract work, security/secrets/auth, payment/financial execution, domain-critical logic, and major architecture changes as Assured. |
| LAN-01-030-v1 | MUST NOT use Fast unless scope is local, reversible, bounded, unambiguous, has evident verification, and has no hard-floor risk. |
| LAN-01-040-v1 | MUST record a stated micro-plan before Fast mutation; Standard and Assured MUST record explicit approval with approver, time, and current content hash/blob before implementation. |
| LAN-01-050-v1 | MUST invalidate classification and Standard/Assured approval when intended behavior, non-goals, owner/service/public contract, persistence, deployment, reversibility, allowed paths, or identified risk changes materially; MUST stop, reclassify, and obtain fresh approval before further work. |
| LAN-01-060-v1 | MUST preserve the recorded v1 contract for an active v1 UC/Spec/Task/Plan chain until it is reopened or explicitly migrated. |
