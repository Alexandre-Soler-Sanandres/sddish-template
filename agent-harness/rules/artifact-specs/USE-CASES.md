# USE-CASES Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| UCS-01-020 | Sources | An ADR MUST NOT be used as a source that produces a Use Case — reference authority only — see `ADR.md`'s `DEC-02-020`/`DEC-05-010` for the citation rule (accepted vs. proposed). |
| UCS-01-060 | Sources | This file's `## Sources` statement that no Use Case is created when the UC-Necessity Matrix classifies a request below UC-tier is normative, not descriptive — mirrors `REFINING.md`'s `UCS-01-050`. |
| UCS-02-010 | Refining | A Use Case MAY be refined when new information from a Partnering session or Legacy Finding changes the scope, open questions are resolved, or the primary actor or scenario needs correction. |
| UCS-02-020 | Refining | Refining MUST NOT change the Use Case ID. |
| UCS-02-021 | Refining | Refining MUST update the `updated` field and status as appropriate. |
| UCS-03-010 | Readiness-Gate | Before setting a Use Case status to `ready-for-spec`, MUST verify the Readiness Checklist in the artifact. |
| UCS-03-011 | Readiness-Gate | Every Readiness Checklist item MUST be checked; a single unchecked item blocks the status change. |
| UCS-03-012 | Readiness-Gate | Each checked Readiness Checklist item MUST be accompanied by a one-line evidence pointer (e.g. a test name, file path, or line reference) recorded beneath the checklist; a checked item with no citable evidence blocks the status change the same as an unchecked one. |
| UCS-04-010 | Boundaries | MUST NOT contain low-level implementation detail (unless essential to the scenario). |
| UCS-05-010 | Carry-Forward | When a Use Case is created, MUST check the Questions registry for entries tied to the source artifact — regardless of legacy or non-legacy origin — and load any that changes actor goals, workflow shape, scope boundaries, alternatives, or failure paths. |
| UCS-05-015 | Carry-Forward | Before advancing to `ready-for-spec`, MUST verify the registry holds nothing unresolved that should block the advance (see `UCS-03-010`). |
| UCS-05-020 | Carry-Forward | MUST carry registry items forward by effect per `CORE.md`'s `COR-01-120`: actor-visible uncertainty belongs in `Open Questions` as canonical Question ID references; behavior constraints belong in the scenario, preconditions, or failure paths. `UCS-03-011` governs whether an unresolved reference stops advancement. |
| UCS-02-030 | Significant-Change | MUST treat a change to the primary actor, goal, trigger, preconditions, main success scenario, or non-goals as significant; a typo, clarification, added Open Questions reference, or `updated`-field bump is not. |
| UCS-02-040 | Cascade | MUST run this cascade when a significant change lands on a Use Case already at `ready-for-spec` or later (also applies at `implemented`, per `CORE.md`'s `COR-01-130`): reset the Use Case to `draft`; set every Spec whose `source` includes this Use Case to `draft` (triggering that Spec's own `SPS-07-020` cascade in turn); report all affected IDs. |
| UCS-02-041 | Cascade | After running `UCS-02-040`'s cascade, MUST stop and wait for user instruction. |
| UCS-02-042 | Cascade | `UCS-02-040` covers a significant change originating on the Use Case itself; it does not cover the case where a downstream Spec/Task/Plan reopens without the Use Case itself changing — see `CORE.md`'s `COR-01-130` for that direction. |
| UCS-06-010 | Boundaries | When a Use Case's primary or supporting actor is itself a separate deployable service (not a human or external actor), the Trigger and/or Main Success Scenario MUST state the interaction mechanism explicitly (synchronous API call, async event, precomputed-and-polled read, or whichever actually applies). |
| UCS-06-011 | Boundaries | MUST NOT carry forward legacy phrasing such as "called directly"/"invoked by" without confirming that same in-process assumption still holds under the target architecture. |
| UCS-06-020 | Technical-Impact | MUST set the `technical_impact` frontmatter field at creation/update time per the definition in `USE-CASES.md`'s `## Artifact Shape` above. |
| UCS-07-010 | ADR-Check | Missed-ADR recheck. Before setting a Use Case status to `ready-for-spec`, MUST re-run the relevance judgment against the *current* accepted-ADR list. |
| UCS-07-011 | ADR-Check | Every `fleet-wide` ADR MUST be present in `related`. |
| UCS-07-012 | ADR-Check | Every `scoped` ADR MUST be re-judged: added to `related` if newly relevant, or explicitly ruled out. |
| UCS-07-020 | ADR-Check | Content-drift recheck. Before setting a Use Case status to `ready-for-spec`, MUST judge ADR relevance against the Use Case's actual current content, not only its original `area` — drafting can drift the content into territory an ADR bears on that the creation-time load never saw. |
| UCS-07-030 | ADR-Check | Compliance check. Before setting a Use Case status to `ready-for-spec`, MUST verify every ADR cited in `related` is actually reflected in the Use Case's content — a citation with no matching content is a gate failure. |
