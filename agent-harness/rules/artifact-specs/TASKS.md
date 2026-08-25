# TASKS Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| TSK-02-010 | Readiness-Gate | Before setting a Task status to `ready`, MUST verify the Readiness Checklist in the artifact. |
| TSK-02-011 | Readiness-Gate | Every Readiness Checklist item MUST be checked; a single unchecked item blocks the status change. |
| TSK-02-025 | Sources | A Task entered via the Spec-skip path MUST include a `## Risk-Tier Classification` section (`RSK-05-010`); its `source` frontmatter field then points at the Idea/Transcript/etc. actually used instead of a Spec. |
| TSK-02-015 | Approval | Status MUST NOT be set to `ready` without the user's explicit confirmation of that specific Task, per `ADR.md`'s `DEC-04-010`. |
| TSK-02-017 | Approval | That confirmation MUST NOT be inferred from discussion. |
| TSK-02-016 | Approval | When the user confirms, MUST set the Task's own `approval.approved_by`/`approved_at` in the same pass. |
| TSK-02-020 | Cascade | Reopening a `done` Task (moving it off `done` for a reason other than `SPECS.md`'s `SPS-07-020` cascade already having done so) MUST trigger `CORE.md`'s `COR-01-130` — the source Spec's `implemented` status may now be stale and must be explicitly reconsidered, not left as-is by default. |
| TSK-05-010 | Traceability | When a Task is created that depends on an accepted `scoped` ADR, MUST add the ADR's ID to the Task's `related` field and add the Task's ID to the ADR's `derived_tasks` field, in the same pass — the Task-side equivalent of `RELATIONS-AND-SUPERSESSION.md`'s `DEC-07-010`, which covers Use Case/Spec only. A `fleet-wide` ADR is exempt from the reverse-link half of this rule, per the same reasoning as `DEC-07-010`. |
| TSK-06-010 | ADR-Check | Missed-ADR recheck. Before setting a Task status to `ready`, MUST re-run the relevance judgment against the *current* accepted-ADR list. |
| TSK-06-011 | ADR-Check | Every `fleet-wide` ADR MUST be present in `related`. |
| TSK-06-012 | ADR-Check | Every `scoped` ADR MUST be re-judged: added to `related` if newly relevant, or explicitly ruled out. |
| TSK-06-020 | ADR-Check | Before setting a Task status to `ready`, if the Task's `allowed_paths` add or modify an HTTP route, app instance, or an external dependency (database, model, credential) on a backend service, MUST additionally verify whether this project's accepted health/readiness-check convention ADR (if one exists) needs updating for that change — regardless of whether `TSK-06-010`'s recheck matches — and either update it or note explicitly why no update is needed. |
| TSK-06-030 | ADR-Check | Content-drift recheck. Before setting a Task status to `ready`, MUST judge ADR relevance against the Task's actual current scope, not only its original `area` — drafting/scoping can drift the Task into territory an ADR bears on that the creation-time load never saw. |
| TSK-06-040 | ADR-Check | Compliance check. Before setting a Task status to `ready`, MUST verify every ADR cited in `related` is actually reflected in the Task's `allowed_paths`/scope — a citation with no matching content is a gate failure. |
