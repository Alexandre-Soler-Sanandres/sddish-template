# CORE / High-Risk Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-09-010 | High-Risk | MUST NOT proceed with database migrations, security/secrets/auth, deployment/infrastructure, payment/financial transaction execution, or domain-critical business logic (`harness-data/reference/DOMAIN.md`) — treated as high-risk — without explicit scope and validation coverage (payments additionally require explicit approval coverage). |
