# SPECS Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| SPS-01-020 | Sources | Legacy Findings, Ideas, and Transcripts MUST NOT be treated as direct Spec sources except via `shared-procs/RISK-TIER.md`'s UC-skip path (`SPECS.md`'s `## Sources`) — outside that path they are upstream inputs that produce Use Cases, not Specs directly. |
| SPS-01-021 | Sources | ADRs MUST NOT be treated as a Spec source either, reference authority only — see `ADR.md`'s `DEC-02-020`/`DEC-05-010` for the citation rule (accepted vs. proposed). |
| SPS-01-050 | Sources | A Spec entered via the UC-skip path MUST include a `## Risk-Tier Classification` section (`RSK-05-010`); its `source` frontmatter field then points at the Idea/Transcript/etc. actually used instead of a Use Case. |
| SPS-02-010 | Readiness-Gate | Before this Spec's promotion (`STT-01-030`/`040`), MUST verify the Readiness Checklist in the artifact. |
| SPS-02-011 | Readiness-Gate | Every Readiness Checklist item MUST be checked; a single unchecked item blocks the status change. |
| SPS-02-012 | Readiness-Gate | Each checked Readiness Checklist item MUST be accompanied by a one-line evidence pointer (e.g. a test name, file path, or line reference) recorded beneath the checklist; a checked item with no citable evidence blocks the status change the same as an unchecked one. |
| SPS-03-010 | Updating | A Spec MAY be updated when new information changes the scope or requirements, open questions are resolved, or acceptance criteria need correction. |
| SPS-03-020 | Updating | Updating MUST NOT change the Spec ID. |
| SPS-03-021 | Updating | Updating MUST update the `updated` field. |
| SPS-05-010 | Carry-Forward | When the source Use Case inherits unresolved Questions-registry entries — regardless of legacy or non-legacy origin — MUST load those referenced items and route them into the Spec sections they constrain. |
| SPS-05-011 | Carry-Forward | Before setting status to `ready` (see `SPS-02-010`), MUST verify the registry holds nothing unresolved that should block the advance. |
| SPS-05-020 | Carry-Forward | MUST carry registry items forward by effect per `CORE.md`'s `COR-01-120`: unresolved approval-shaping questions belong in `Open Questions` as canonical Question ID references; requirements, constraints, dependencies, risks, and validation obligations belong in the section they constrain. `SPS-02-010` governs whether an unresolved reference stops approval. |
| SPS-06-010 | Legacy-Handoff | The Questions registry's `CSP-*` rows remain the canonical proof/parity backlog. A Spec MAY cite relevant `CSP-*` IDs in requirements, risks, validation, or open questions. |
| SPS-06-020 | Legacy-Handoff | A Spec SHOULD NOT duplicate unrelated `CSP-*` rows or store proof IDs in `test_refs`. |
| SPS-07-010 | Significant-Change | MUST treat a change to scope, non-goals, functional requirements, acceptance criteria, or constraints as significant; a typo, clarification, added open question, or `updated`-field bump is not. |
| SPS-08-010 | ADR-Check | Missed-ADR recheck. Before this Spec's promotion (`STT-01-030`/`040`), MUST re-run the relevance judgment against the *current* accepted-ADR list. |
| SPS-08-011 | ADR-Check | Every `fleet-wide` ADR MUST be present in `related`. |
| SPS-08-012 | ADR-Check | Every `scoped` ADR MUST be re-judged: added to `related` if newly relevant, or explicitly ruled out. |
| SPS-08-020 | ADR-Check | Content-drift recheck. Before this Spec's promotion (`STT-01-030`/`040`), MUST judge ADR relevance against the Spec's actual current content, not only its original `area` — drafting can drift the content into territory an ADR bears on that the creation-time load never saw. |
| SPS-08-030 | ADR-Check | Compliance check. Before this Spec's promotion (`STT-01-030`/`040`), MUST verify every ADR cited in `related` is actually reflected in the Spec's requirements/scope — a citation with no matching content is a gate failure. |
| SPS-07-021 | Cascade | Status transitions for this artifact are governed by `systems/STATUS-TRANSITIONS.md`, not defined here. |
