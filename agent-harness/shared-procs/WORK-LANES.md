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
| LAN-01-040 | Fast work MUST state target, delta, preserved behavior, and check before mutation. Standard and Assured work MUST record approver identity, timestamp, and the approved content hash before implementation. |
