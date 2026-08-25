# REFINING Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| UCS-01-010 | Sources | A Use Case MUST be created from an Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation. |
| UCS-01-011 | Sources | If the source is an Idea, it MUST be at status `ready-for-refining` (`IDA-01-010`) before a Use Case may be created from it — OR, when `shared-procs/RISK-TIER.md`'s UC-Necessity Matrix (`RSK-02-010`) classifies the request below UC-tier, `/create-spec` may be entered directly from the same source types listed in `UCS-01-010`, skipping Use Case creation. |
| UCS-01-030 | Sources | For source types other than an Idea, which have no formal status gate, the agent SHOULD use judgment that the source material is concrete enough to draft a scenario from. |
| UCS-01-040 | Sources | MUST load every `fleet-wide` accepted ADR unconditionally and judge every `scoped` accepted ADR for relevance before drafting a Use Case's content, recording the result in `related` at creation time — `UCS-07-010`/`UCS-07-020`/`UCS-07-030` (in `USE-CASES.md`) remain the final verification pass, not the first point of contact. |
| UCS-01-050 | Sources | Before starting Use Case creation or entering Refining at a lower tier: if the source Idea already carries a `## Risk-Tier Classification` (per `IDA-05-020`) or the source is a Transcript/Partnering discussion where `PTN-02-110` already classified this same request, MUST reuse that result per `RISK-TIER.md`'s `RSK-07-011`/`RSK-07-012`. This is step 0 of both the Use Case and Spec creation checklists in `REFINING.md`'s `## Core Moves`. |
| UCS-01-051 | Sources | Otherwise MUST run the UC-Necessity Matrix (`RSK-02-010`) fresh. |
| UCS-04-020 | Boundaries | MUST NOT trigger implementation. |
| UCS-04-021 | Boundaries | MUST NOT create Specs, Tasks, or Implementation Plans from Use Case creation. |
| SPS-01-010 | Sources | MUST create a Spec only from a Use Case at status `ready-for-spec` — OR, when `RISK-TIER.md`'s Spec-Necessity Matrix (`RSK-03-010`) classifies the request below Spec-tier, `/create-tasks` may be entered directly from the same source types, skipping Spec creation. |
| SPS-01-011 | Sources | MUST NOT proceed with Spec creation otherwise. |
| SPS-01-030 | Sources | MUST load every `fleet-wide` accepted ADR unconditionally and judge every `scoped` accepted ADR for relevance before drafting a Spec's content, recording the result in `related` at creation time — `SPS-08-010`/`SPS-08-020`/`SPS-08-030` (in `SPECS.md`) remain the final verification pass, not the first point of contact. |
| SPS-01-040 | Sources | Same carry-forward check as `UCS-01-050`, for the Spec-Necessity Matrix (`RSK-03-010`) — reuse an existing classification per `RSK-07-011`/`RSK-07-012` before running it fresh (or immediately after `UCS-01-050` classifies UC as not required, in which case Spec-Necessity has not yet been checked and MUST run). |
| SPS-04-010 | Boundaries | MUST NOT implement or change code while creating a Spec. |
| SPS-04-011 | Boundaries | MUST NOT create Tasks or Implementation Plans while creating a Spec. |
| TSK-01-010 | Sources | MUST create Tasks only from a Spec at status `approved` — OR, when `RISK-TIER.md`'s Spec-Necessity Matrix already classified the request below Spec-tier and `TSK-01-030`'s Task-Necessity check determines a Task is required, Tasks may be entered directly from the same source types. |
| TSK-01-011 | Sources | MUST NOT proceed with Task creation otherwise. |
| TSK-01-020 | Sources | Task-necessity classification uses `RISK-TIER.md`'s `RSK-04-010` matrix — see `REFINING.md`'s `## Core Moves` for this file's own step-0 pointer. |
| TSK-01-030 | Sources | Step 0 of Task creation, mirroring `UCS-01-050`/`SPS-01-040` — reached whenever `/create-tasks` is entered via the Spec-skip path (i.e. `SPS-01-040` already classified Spec as not required). If the source already carries a recorded Task-Necessity result, MUST reuse it per `RSK-07-011`/`RSK-07-012`. |
| TSK-01-033 | Sources | Otherwise MUST run `RSK-04-010` fresh, per `RSK-07-021`'s full-cascade-completion rule — Spec-Necessity saying "No" is not itself grounds to create a Task. |
| TSK-01-031 | Sources | If `TSK-01-030`'s check classifies Tasks as not required (`RSK-04-010`'s "No" rows) or the request qualifies for "Optional" and the user prefers the lighter path, MUST stop Task creation and instead report that the request lands on Plan-tier, routing to Planning-Implementation's natural-language entry (`IPL-08-010`) rather than creating a Task. |
| TSK-01-032 | Sources | `TSK-01-030`/`TSK-01-031` do not apply when `/create-tasks` is entered normally from an `approved` Spec (`TSK-01-010`'s unconditional path) — that case's Task-necessity was already decided when the Spec was approved with Tasks in mind. |
| TSK-03-010 | Boundaries | MUST NOT implement or change code while creating Tasks. |
| TSK-03-011 | Boundaries | MUST NOT create Implementation Plans while creating Tasks. |
| TSK-04-010 | Dedup | MUST verify existing Tasks derived from that Spec before generating Tasks from a Spec — via this entry point directly, not only when Planning-Implementation happens to check first. |
| TSK-04-011 | Dedup | MUST NOT generate duplicate Tasks or skip existing ones per `TSK-04-010`'s check. This rule is owned here, not borrowed from `PLANNING-IMPLEMENTATION.md`'s `IPL-03-010`, so `/create-tasks` is protected regardless of entry path. |
