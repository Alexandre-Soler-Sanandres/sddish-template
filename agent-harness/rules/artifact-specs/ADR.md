# ADR Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| DEC-01-010 | Sources | Any mode MAY identify and draft a candidate ADR at status `proposed` when it surfaces a settled structural/architectural decision. |
| DEC-02-010 | Boundaries | An ADR MUST NOT itself trigger implementation, nor create Specs, Tasks, or Implementation Plans directly. |
| DEC-02-020 | Boundaries | An ADR MUST NOT be used as a source that produces a Use Case or Spec — it is cited only as reference authority by Use Cases and Specs (see `SPECS.md`'s `SPS-01-020`, `USE-CASES.md`'s Sources). |
| DEC-03-010 | Readiness-Gate | Before setting status to `accepted`, MUST verify the Readiness Checklist in the artifact. An open question blocks acceptance only if answering it differently would require rewriting the `Decision` section itself; a question that only affects implementation detail, performance tuning, or narrower in-scope choices does not block and may remain listed. |
| DEC-04-010 | Approval | Status MUST NOT be set to `accepted` without the user's explicit confirmation — do not infer approval from discussion. |
| DEC-05-010 | Citation-Gate | Use Cases and Specs MAY cite only `accepted` ADRs as settled authority. |
| DEC-05-020 | Citation-Gate | A `proposed` ADR MAY be noted as pending context. |
| DEC-05-030 | Citation-Gate | A `proposed` ADR MUST NOT be treated as settled. |
| DEC-12-010 | Context-Loading | MUST load `agent-harness/artifact-specs/adr/RELATIONS-AND-SUPERSESSION.md` in addition to this file when the ADR supersedes another ADR, cites a `related` ADR, or settles a Questions-registry entry. |
| DEC-13-010 | Creation-Gate | MUST NOT create an ADR while the conversation is still exploring options (route to a Transcript or Idea instead) or when the decision is about actor-visible behavior (route to a Use Case instead). |
| DEC-14-010 | Scope | Every ADR MUST set `scope` to `fleet-wide` (applies to every artifact regardless of `area`; exempt from `derived_use_cases`/`derived_specs`/`derived_tasks` reverse-link bookkeeping, per `RELATIONS-AND-SUPERSESSION.md`'s `DEC-07-010` and `TASKS.md`'s `TSK-05-010`) or `scoped` (applies only where area-based relevance judgment finds it applicable). |
