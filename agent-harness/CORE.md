# CORE.md

## Purpose

Universal harness rules that apply in every mode. Use the smallest sufficient context throughout — the concrete
instances of this live in the Context-Loading group below.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-01-020 | Universal | MUST NOT load unrelated artifact directories. |
| COR-01-030 | Universal | MUST NOT expose secrets. |
| COR-01-040 | Universal | MUST NOT run commands that are irreversible or have a wide blast radius (data loss, schema changes, production state changes, force operations) without explicit approval. |
| COR-01-050 | Universal | MUST NOT implement from Partnering mode. |
| COR-01-060 | Universal | MUST NOT implement before an approved Implementation Plan exists. |
| COR-01-070 | Universal | MUST keep traceability links aligned across Use Cases, Specs, Tasks, Plans, and Reviews. |
| COR-01-080 | Universal | MUST NOT retroactively rewrite artifacts in `done/` or `archive/` folders when paths, structure, or conventions change elsewhere in the harness. |
| COR-01-090 | Universal | MUST NOT infer approval from a conversation's tone or direction — any status change or action requiring user approval needs the user's explicit confirmation instead. |
| COR-01-100 | Universal | MUST NOT modify `agent-harness/*` (harness mode files, templates, artifact specs, process rules) outside Improving-Harness mode. |
| COR-01-110 | Universal | MUST decide Question vs Idea before creating either, when work surfaces something worth tracking without needing to pause the artifact currently in progress. Engineering judgment applied to reach that decision MUST stay evidence-grounded and MUST NOT invent facts. See `QUESTIONS.md`'s `QST-06-010` for the Question/Idea test (including latent, judgment-informed forks) and dedup/ID mechanics, and `QST-06-020` for when a Question is material enough to warrant filing. |
| COR-01-120 | Universal | Every artifact's own Open Questions section (or equivalent) MUST hold references to canonical Question IDs, never freeform or artifact-local-only question text. This governs every artifact type (Transcript, Idea, Use Case, Spec, Task, ADR, Legacy Finding, Review). Whether an unresolved reference stops this artifact from advancing is for that artifact's own Readiness Checklist to judge — not a stored attribute on the reference. See `QUESTIONS.md`'s `QST-09-010` for registry mechanics. |
| COR-02-010 | Artifact-Language | SHOULD write normalized artifacts in English by default. |
| COR-02-020 | Artifact-Language | MAY preserve the original language in transcripts, raw input, or quoted source material when needed. |
| COR-03-010 | Context-Loading | MUST start context loading from the user request. |
| COR-03-020 | Context-Loading | MUST use `agent-harness/CATALOG.md` when the artifact identity is unknown or ambiguous. |
| COR-03-030 | Context-Loading | MUST load the explicitly referenced artifact before exploring related artifacts. |
| COR-03-040 | Context-Loading | MUST load the active true-Mode file (`agent-harness/modes/`) before taking mode-specific action. A true Mode is one of: Partnering, Implementing, Discovering-Legacy, Improving-Harness, Planning-Implementation, Refining. |
| COR-03-050 | Context-Loading | MUST NOT load linked parent or child artifacts unless they are required for the current task. |
| COR-03-055 | Context-Loading | MUST NOT exclude an in-scope file or evidence source based only on assumed triviality, filename convention, or boilerplate appearance. |
| COR-03-056 | Context-Loading | `smallest sufficient context` MUST limit reading depth within in-scope material, not whether that material is read. |
| COR-03-060 | Context-Loading | SHOULD prefer summaries before full historical artifacts when both are available. |
| COR-03-070 | Context-Loading | MUST NOT load reference files unless the current task is directly affected by them. |
| COR-03-080 | Context-Loading | MUST NOT load archived artifacts unless they are explicitly needed. |
| COR-03-090 | Context-Loading | MUST also load that artifact type's spec under `agent-harness/artifact-specs/` before creating or updating an artifact (in addition to the active Mode file, `COR-03-040`) — e.g. creating a Spec loads both `REFINING.md` and `SPECS.md`. |
| COR-03-100 | Context-Loading | MUST NOT load `agent-harness/shared-procs/` by default — load only when actually invoked (e.g. Validation, invoked during Implementing or named in Improving-Harness's Improvement Process). |
| COR-03-110 | Context-Loading | A delegation prompt to a sub-agent doing mode-scoped work MUST name, as required reading for that sub-agent: `CORE.md`, the active mode file, and the relevant artifact spec — the same set `COR-03-040`/`COR-03-090` require the primary agent to load. This does not require the sub-agent to read every reference file (`COR-03-070` still applies); it only stops the mode/spec/core layer being left to the orchestrator's own prompt wording. |
| COR-04-010 | Support-Files | MUST consult `agent-harness/playbooks/index.yaml` before loading universal playbooks broadly. |
| COR-04-020 | Support-Files | MUST consult `harness-data/playbooks/index.yaml` before loading project playbooks broadly. |
| COR-04-030 | Support-Files | MUST consult `harness-data/guides/index.yaml` before loading guides broadly. |
| COR-04-040 | Support-Files | MUST NOT inspect an entire support-file folder when its index is sufficient — load only the matched support files needed for the current task. |
| COR-04-050 | Support-Files | MUST follow the universal playbook for the generic procedure and the project playbook for repo-local refinement when both apply. |
| COR-04-060 | Support-Files | Guides provide local operating context; MUST NOT be treated as replacing procedural instructions from playbooks. |
| COR-04-070 | Support-Files | Playbooks and guides MUST NOT override core rules, mode boundaries, or explicit approval gates. |
| COR-05-010 | Checkpoint | MUST verify the active mode, restart artifact, explicit user authorization, in-scope files, and required validation before any high-impact action, before stopping or committing. |
| COR-05-020 | Checkpoint | MUST treat these as high-impact actions: committing; changing harness mode files, templates, or reference process rules; creating Review or Improvement artifacts; moving artifacts between lifecycle folders. Discovering-Legacy mode adds its own high-impact actions on top of this list — see `agent-harness/modes/DISCOVERING-LEGACY.md`. |
| COR-05-030 | Checkpoint | MUST repeat the checkpoint (`COR-05-010`) and re-read `CORE.md` and the active true-Mode file in full before the next high-impact action, after a resume or context compaction — the checkpoint verifies state, not rule text, so confirming mode identity alone is not enough. |
| COR-05-040 | Checkpoint | MUST re-read the newly-active mode file in full before taking any mode-specific action, on a true Mode transition (per `COR-03-040`'s list — not every artifact-producing action). |
| COR-06-010 | Observability | SHOULD record temporary operational trace only when it helps safe continuation, validation, or explanation of agent behavior. |
| COR-06-020 | Observability | MAY use `harness-data/RUN-LOG.md`; it is not required by default. |
| COR-06-030 | Observability | MUST record only operational facts that matter, such as context loaded, approvals, commands/checks run, current execution state, restart point, and stop reason. |
| COR-06-040 | Observability | MUST move durable decisions, stable blockers, and lasting outcomes into the real artifacts instead of leaving them only in operational trace. |
| COR-06-050 | Observability | MUST keep operational trace small and temporary; collapse it to a short closure note or clear it when the work finishes. |
| COR-06-060 | Observability | MUST use `harness-data/RUN-LOG.md` for the Implementation gate-check required by `IMPL-02-010`. |
| COR-07-010 | Pause-Resume | MUST record the exact restart point before pausing interrupted work that will continue later. |
| COR-07-020 | Pause-Resume | MUST record the current execution state before pausing. |
| COR-07-030 | Pause-Resume | MUST record, before pausing, any checks that must be re-run before continuing. |
| COR-07-050 | Pause-Resume | MUST confirm, on resume, that the restart point is still valid. |
| COR-07-060 | Pause-Resume | MUST confirm, on resume, that no newer artifact, status change, or user instruction invalidates the old plan. |
| COR-07-070 | Pause-Resume | MUST re-run, on resume, any validations or checks that were still uncertain at pause time. |
| COR-07-080 | Pause-Resume | MUST NOT resume from stale conversational state alone when restart point or validation state matters. |
| COR-08-010 | Commits | MUST NOT commit unless the user explicitly requests it. |
| COR-08-020 | Commits | MUST follow the project's commit conventions in `harness-data/reference/QUALITY.md` when committing. |
| COR-09-010 | High-Risk | MUST NOT proceed with database migrations, security/secrets/auth, deployment/infrastructure, payment/financial transaction execution, or domain-critical business logic (`harness-data/reference/DOMAIN.md`) — treated as high-risk — without explicit scope and validation coverage (payments additionally require explicit approval coverage). |
| COR-10-010 | Rule-Authoring | When a mode file, artifact spec, or template's descriptive prose (a Purpose section, a `## Sources`/`## Candidate Artifacts`-style field description, a frontmatter field comment) states an expectation of agent behavior, back it with a corresponding ID'd rule in that file's own Rules table (or the template's own guidance line, for templates). Prose may explain *why*; it must not be the only place an enforceable *must/should* lives. |
| COR-10-020 | Rule-Authoring | When a Review finding traces back to prose-only intent (this shape has recurred — see `REVIEW-019`, `021`, `022`, `023`), the resulting Improvement must add the missing rule to the specific file found, and must not treat the instance as fully closed until it does. |
| COR-10-030 | Rule-Authoring | State every rule's obligation strength using an RFC 2119 keyword (`MUST` / `MUST NOT` / `SHOULD` / `SHOULD NOT` / `MAY`) per RFC 2119/RFC 8174 (BCP 14) — capitalized, exactly one per rule; lowercase modal words carry no special meaning. Do not use ad hoc substitutes ("always," "never," "do not," "should probably") where a keyword conveys the same obligation more precisely. |
| COR-10-040 | Rule-Authoring | MUST state rule text as concisely as possible while preserving every distinction, condition, exception, and cross-reference the rule currently enforces — the agent's ability to apply the rule correctly to every case it covers today must not shrink. MUST NOT cut content, nuance, or edge-case coverage to save length; only cut redundant wording, restated context available elsewhere, or filler that adds no decision-relevant information. |
