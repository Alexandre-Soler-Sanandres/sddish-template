# RISK-TIER Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| RSK-01-010 | Principle | Necessity at every tier MUST be judged by two axes — (a) is the change hard or impossible to reverse, and (b) does it cross an actor/scenario, architectural/contract, or team/service boundary that someone else needs visibility into. |
| RSK-01-020 | Principle | Classification MUST NOT be based on effort, agent convenience, or time pressure alone. |
| RSK-02-010 | UC-Necessity | Governs whether a Use Case is required before a Spec/Task/Plan may proceed — see the UC-Necessity Matrix in `RISK-TIER.md`'s `## Procedure`. |
| RSK-03-010 | Spec-Necessity | Governs whether a Spec is required before Tasks/Plan — see the Spec-Necessity Matrix in `RISK-TIER.md`'s `## Procedure`. |
| RSK-04-010 | Task-Necessity | Governs whether Tasks are required before a Plan — see the Task-Necessity Matrix in `RISK-TIER.md`'s `## Procedure` (moved here verbatim from `REFINING.md`'s former local Task Decision Matrix; content unchanged). |
| RSK-05-010 | Recording | Whenever a tier is skipped, the resulting artifact — or the Implementation Plan itself, if no artifact is produced — MUST include a `## Risk-Tier Classification` section naming the matching matrix row and reasoning. When classification happens before any resulting artifact exists yet (at Partnering's hand-off, before the Idea is promoted), the source Idea holds it instead, per `RSK-07-010`, until something actually results. Omission is a process violation, not a valid shortcut. |
| RSK-06-010 | Ambiguity | An ambiguous or unclear-scope situation MUST default to the higher tier, not be skipped on uncertainty. |
| RSK-06-020 | Hard-Floor | Regardless of matrix outcome, these categories MUST NOT go below Spec tier: database migration, destructive data job, deployment/infrastructure change, CI/CD workflow setup, API contract publication/change, security/secrets/auth, payment/financial transaction execution, domain-critical business logic, major architecture change. |
| RSK-07-010 | Run-Once | The cascade MUST run at most once per request, at the first opportunity it's reached — Partnering's hand-off, Refining's entry, or Planning-Implementation's entry, whichever comes first for that request. The result is carried forward, not recomputed: a skip is recorded via `RSK-05-010`'s `## Risk-Tier Classification` section; a non-skip (full tier required) is evidenced by the artifact's own normal chain (an accepted Use Case behind an ready Spec behind a `ready` Task is itself proof the classification already happened). |
| RSK-07-011 | Run-Once | Every mode consuming this cascade MUST check for an existing classification — on the named artifact, or on its cited source Idea/Transcript — before running it fresh. |
| RSK-07-012 | Run-Once | MUST NOT recompute a classification that already exists unless the user explicitly asks for re-evaluation. |
| RSK-07-013 | Run-Once | `RSK-07-010`'s run-once rule applies per-matrix, not only to the cascade as a whole: if an earlier stage already ran `RSK-02-010` or `RSK-03-010` and recorded a partial result, a later stage picking up the same request MUST reuse that partial result and continue the cascade from the next unrun matrix, not restart from `RSK-02-010`. |
| RSK-07-020 | Full-Cascade | A consuming mode file determining whether a request needs an upstream artifact at all MUST run the cascade through `RSK-04-010` (Task-Necessity) before concluding no artifact above Plan-tier is required. |
| RSK-07-021 | Full-Cascade | MUST NOT stop after `RSK-02-010` (UC-Necessity) or `RSK-03-010` (Spec-Necessity) alone and default into creating a Spec or Task on that basis — a Spec-Necessity "No" result is not itself a reason to create a Task, exactly as a UC-Necessity "No" result is not itself a reason to create a Spec without first checking Spec-Necessity. Landing on `/create-spec` or `/create-tasks` requires having also checked the matrix one tier below it. |
| RSK-07-022 | Full-Cascade | MAY conclude the request lands on Plan-tier directly only once `RSK-04-010` is also checked (fresh or carried forward, per `RSK-07-010`). |
