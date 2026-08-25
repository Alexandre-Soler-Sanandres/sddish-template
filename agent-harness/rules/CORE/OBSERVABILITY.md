# CORE / Observability Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-06-010 | Observability | SHOULD record temporary operational trace only when it helps safe continuation, validation, or explanation of agent behavior. |
| COR-06-020 | Observability | MAY use `harness-data/RUN-LOG.md`; it is not required by default. |
| COR-06-030 | Observability | MUST record only operational facts that matter: context loaded, approvals, commands/checks run, current execution state, restart point, and stop reason. |
| COR-06-040 | Observability | MUST move durable decisions, stable blockers, and lasting outcomes into the real artifacts instead of leaving them only in operational trace. |
| COR-06-050 | Observability | MUST keep operational trace small and temporary; collapse it to a short closure note or clear it when the work finishes. |
| COR-06-060 | Observability | MUST use `harness-data/RUN-LOG.md` for the Implementation gate-check required by `IMPL-02-010`. |
