# CORE

## Purpose

The invariant kernel for every Harness lane. Load this file, the selected workflow, selected Artifact Contract, and
only invoked Procedures or enabled Extensions.

## Invariant kernel

Understand intent; state changed and preserved behavior; make a bounded plan; obtain lane-appropriate
authorization; scale assurance to risk; bound scope; verify credibly; and persist only decisions, blockers, and
handoffs needed across context loss.

## Rules

This file is the single canonical home for every universal (`COR-*`) rule. The invariant-kernel rows
(`COR-01-001`–`COR-01-008`) restate the kernel above in enforceable form; the remaining sections carry the
context-loading, support-file, checkpoint, observability, pause/resume, high-risk, rule-authoring, and
artifact-language rules that every lane depends on. A true Mode is one of: Partnering, Implementing,
Discovering-Legacy, Improving-Harness, Planning-Implementation, Refining.

### Kernel

| ID | Rule |
| --- | --- |
| COR-01-001 | Work MUST understand intended outcome before mutation. |
| COR-01-002 | Work MUST state changed and preserved behavior before mutation. |
| COR-01-003 | Work MUST record a bounded plan before mutation. |
| COR-01-004 | Work MUST obtain the authorization required by its Work Lane. |
| COR-01-005 | Work MUST scale assurance by ambiguity, reversibility, boundary impact, and risk. |
| COR-01-006 | Work MUST keep approved scope and batches bounded. |
| COR-01-007 | Work MUST verify applicable acceptance criteria with credible evidence. |
| COR-01-008 | Work MUST persist only decisions, blockers, and handoffs that need to survive context loss. |

### Universal

| ID | Rule |
| --- | --- |
| COR-01-020 | Work MUST NOT load unrelated artifact directories. |
| COR-01-030 | Work MUST NOT expose secrets. |
| COR-01-040 | Work MUST NOT perform an irreversible or wide-blast-radius operation without explicit approval. |
| COR-01-050 | Work MUST NOT implement from Partnering mode. |
| COR-01-060 | Work MUST NOT implement without its authorized Fast micro-plan, approved Standard Change Spec, or approved Assured Execution Plan. |
| COR-01-070 | Canonical forward traceability MUST remain aligned across work artifacts. |
| COR-01-080 | Terminal artifacts MUST NOT be rewritten except through an explicitly approved controlled migration. |
| COR-01-090 | Work MUST NOT infer an approval from conversational tone or direction. |
| COR-01-100 | Harness files MUST change only through Improving-Harness mode and an approved Improvement. |
| COR-01-110 | Work MUST decide Question versus Idea before creating either, when work surfaces something worth tracking without pausing the artifact in progress. See `agent-harness/artifact-specs/QUESTIONS.md`'s `QST-06-010` for the Question/Idea test and dedup/ID mechanics, `QST-06-020` for when a Question is material enough to file, and `agent-harness/systems/QUESTION-LIFECYCLE.md` for how a Question then spreads to and resolves for citing artifacts. |
| COR-01-111 | Engineering judgment applied to a Question-versus-Idea decision (`COR-01-110`) MUST stay evidence-grounded. |
| COR-01-112 | Work MUST NOT invent facts when applying that judgment. |
| COR-01-120 | Artifact-local Question references MUST use canonical Question IDs, not freeform or artifact-local-only question text. This governs every artifact type. Whether an unresolved reference stops an artifact advancing is for that artifact's own Readiness Checklist to judge. See `agent-harness/artifact-specs/QUESTIONS.md`'s `QST-09-010` for registry mechanics and `agent-harness/systems/QUESTION-LIFECYCLE.md` for how reference-by-ID lets one resolution reach every citing artifact. |

### Artifact-language

| ID | Rule |
| --- | --- |
| COR-02-010 | Work SHOULD write normalized artifacts in English by default. |
| COR-02-020 | Work MAY preserve the original language in transcripts, raw input, or quoted source material when needed. |

### Context-loading

| ID | Rule |
| --- | --- |
| COR-03-010 | Context loading MUST start from the user request and explicitly named artifact. |
| COR-03-020 | Work MUST use `agent-harness/CATALOG.md` when the artifact identity is unknown or ambiguous. |
| COR-03-030 | Work MUST load the explicitly referenced artifact before exploring related artifacts. |
| COR-03-040 | Work MUST load the active true-Mode file (`agent-harness/modes/`) before taking mode-specific action. |
| COR-03-046 | Initial harness context MUST include this file, the selected workflow, the referenced artifact, and its Contract when an artifact is created, updated, or reviewed. |
| COR-03-047 | On a true Mode transition, Work MUST reload the initial harness context for the newly active workflow and the current restart or referenced artifact. |
| COR-03-048 | Context MUST expand only to invoked Procedures, enabled Extensions, cited authority, or evidence needed for the action; stop expanding once the needed rule, procedure, system, or context is understood. |
| COR-03-050 | Work MUST NOT load linked parent or child artifacts unless they are required for the current task. |
| COR-03-055 | Work MUST NOT exclude an in-scope file or evidence source based only on assumed triviality, filename convention, or boilerplate appearance. |
| COR-03-056 | `smallest sufficient context` MUST limit reading depth within in-scope material, not whether that material is read. |
| COR-03-060 | Work SHOULD prefer summaries before full historical artifacts when both are available. |
| COR-03-070 | Work MUST NOT load reference files unless the current task is directly affected by them. |
| COR-03-080 | Work MUST NOT load archived artifacts unless they are explicitly needed. |
| COR-03-090 | Work MUST also load that artifact type's Contract under `agent-harness/artifact-specs/` before creating or updating an artifact, in addition to the active Mode file (`COR-03-040`). |
| COR-03-100 | Work MUST NOT load `agent-harness/shared-procs/` by default — load only when a shared procedure is actually invoked by name from the active mode file's own rules. |
| COR-03-110 | A delegation prompt to a sub-agent doing mode-scoped work MUST name, as required reading for that sub-agent, the same mode/spec/core layer `COR-03-040`/`COR-03-090` require the primary agent to load: `CORE.md`, the active mode file, and the relevant Artifact Contract. This does not require the sub-agent to read every reference file (`COR-03-070` still applies); it only stops the mode/spec/core layer being left to the orchestrator's own prompt wording. |
| COR-03-120 | Work MUST NOT load, cite, or route through an Extension's files (`agent-harness/extensions/<name>/**`) unless `harness-data/HARNESS-PROFILE.yaml` sets `extensions.<name>: enabled`; a disabled or absent Extension is invisible to context loading, the Catalog, and wrapper generation. |

### Support-files

| ID | Rule |
| --- | --- |
| COR-04-010 | Work MUST consult `agent-harness/playbooks/index.yaml` before loading universal playbooks broadly. |
| COR-04-020 | Work MUST consult `harness-data/playbooks/index.yaml` before loading project playbooks broadly. |
| COR-04-030 | Work MUST consult `harness-data/guides/index.yaml` before loading guides broadly. |
| COR-04-040 | Work MUST NOT inspect an entire support-file folder when its index is sufficient — load only the matched support files needed for the current task. |
| COR-04-050 | Work MUST follow the universal playbook for the generic procedure and the project playbook for repo-local refinement when both apply. |
| COR-04-060 | Guides provide local operating context; Work MUST NOT treat them as replacing procedural instructions from playbooks. |
| COR-04-070 | Playbooks and guides MUST NOT override core rules, mode boundaries, or explicit approval gates. |

### Checkpoint

| ID | Rule |
| --- | --- |
| COR-05-010 | Work MUST checkpoint mode, authorization, in-scope files, and validation before high-impact actions, stopping, or committing. |
| COR-05-020 | Work MUST treat these as high-impact actions: committing; changing harness mode files, templates, or process rules; creating Review or Improvement artifacts; moving artifacts between lifecycle folders (see `agent-harness/systems/LIFECYCLE-FOLDERS.md` for why that move is never a bare housekeeping step). Discovering-Legacy mode adds its own high-impact actions on top of this list — see `agent-harness/extensions/legacy-discovery/DISCOVERING-LEGACY.md`. |
| COR-05-030 | After a resume or context compaction, Work MUST repeat the checkpoint (`COR-05-010`) and re-read `CORE.md` and the active true-Mode file in full before the next high-impact action — the checkpoint verifies state, not rule text, so confirming mode identity alone is not enough. |
| COR-05-040 | On a true Mode transition (per `COR-03-040`'s list — not every artifact-producing action), Work MUST re-read the newly-active mode file in full before taking any mode-specific action. |

### Observability

| ID | Rule |
| --- | --- |
| COR-06-010 | Work SHOULD record temporary operational trace only when it helps safe continuation, validation, or explanation of agent behavior. |
| COR-06-020 | Work MAY use `harness-data/RUN-LOG.md`; it is not required by default. |
| COR-06-030 | Work MUST record only operational facts that matter: context loaded, approvals, commands/checks run, current execution state, restart point, and stop reason. |
| COR-06-040 | Work MUST move durable decisions, stable blockers, and lasting outcomes into the real artifacts instead of leaving them only in operational trace. |
| COR-06-050 | Work MUST keep operational trace small and temporary; collapse it to a short closure note or clear it when the work finishes. |
| COR-06-060 | Work MUST use `harness-data/RUN-LOG.md` for the Implementation gate-check required by `IMPL-02-010`. |

### Pause-resume

| ID | Rule |
| --- | --- |
| COR-07-010 | Work MUST record the exact restart point before pausing interrupted work that will continue later. |
| COR-07-020 | Work MUST record the current execution state before pausing. |
| COR-07-030 | Work MUST record, before pausing, any checks that must be re-run before continuing. |
| COR-07-050 | Work MUST confirm, on resume, that the restart point is still valid. |
| COR-07-060 | Work MUST confirm, on resume, that no newer artifact, status change, or user instruction invalidates the old plan. |
| COR-07-070 | Work MUST re-run, on resume, any validations or checks that were still uncertain at pause time. |
| COR-07-080 | Work MUST NOT resume from stale conversational state alone when restart point or validation state matters. |

### High-risk

| ID | Rule |
| --- | --- |
| COR-09-010 | Work MUST NOT proceed with database migrations, security/secrets/auth, deployment/infrastructure, payment/financial transaction execution, or domain-critical business logic (`harness-data/reference/DOMAIN.md`) — treated as high-risk — without explicit scope and validation coverage; payments additionally require explicit approval coverage. |

### Rule-authoring

| ID | Rule |
| --- | --- |
| COR-10-010 | When a mode file, Artifact Contract, Procedure Guide, System, or template's descriptive prose states an expectation of agent behavior, Work MUST back it with a corresponding ID'd rule in that file's own Rules section, or the template's own guidance line for templates. Prose may explain *why*. |
| COR-10-011 | Prose MUST NOT be the only place an enforceable *must/should* lives — the backing rule required by `COR-10-010` is what makes it enforceable. |
| COR-10-020 | When a Review finding traces back to prose-only intent, the resulting Improvement MUST add the missing rule to that file's own Rules section. |
| COR-10-021 | Work MUST NOT treat the `COR-10-020` instance as fully closed until the missing rule is added. |
| COR-10-030 | Work MUST state every rule's obligation strength using exactly one RFC 2119 keyword per rule (`MUST` / `MUST NOT` / `SHOULD` / `SHOULD NOT` / `MAY`, per RFC 2119/RFC 8174 (BCP 14)) — capitalized; lowercase modal words carry no special meaning. |
| COR-10-031 | Work MUST NOT use an ad hoc substitute ("always," "never," "do not," "should probably") in place of a keyword where the keyword conveys the same obligation more precisely. |
| COR-10-040 | Work MUST state rule text as concisely as possible while preserving every distinction, condition, exception, and cross-reference the rule currently enforces — the agent's ability to apply the rule correctly to every case it covers today must not shrink. |
| COR-10-041 | Work MUST NOT cut content, nuance, or edge-case coverage to save length; only cut redundant wording, restated context available elsewhere, or filler that adds no decision-relevant information. |
| COR-10-050 | Rule text MUST NOT rely on an inline example ("e.g.", "such as", "for instance") to convey scope; state the general condition precisely enough that no example is needed. When an example remains genuinely useful to the reader, place it in the file's surrounding prose, not inside the Rule table row. |
| COR-10-060 | When an Improvement creates, deletes, renames, or physically moves a Rules-table row or Rules table, Work MUST perform a rule-ID citation audit using the agent's available inspection/search capabilities rather than repo-local validation tooling. |
| COR-10-061 | For deletes, renames, or physical moves covered by `COR-10-060`, Work MUST run the citation audit before and after the change and record both the baseline and post-change result. |
| COR-10-062 | The `COR-10-060` citation audit MUST verify every cited rule ID resolves to exactly one defined Rules-table row, no rule ID is defined more than once, and required scan roots are covered and reported in the Improvement's validation result. |
| COR-10-063 | Rule-ID citation audits MUST NOT add repo-local checker scripts, generated indexes, or copied validation artifacts to adopter repos; template-maintenance automation, if pursued, belongs in a separate template-repository Improvement. |
| COR-10-070 | Harness source files MUST preserve the taxonomy defined in `agent-harness/docs/08-glossary.md`: Mode Workflows guide, Artifact Contracts define, Procedure Guides run, Systems explain interactions, Rules constrain, and Templates scaffold. |
| COR-10-071 | A source file's Rules section MUST hold enforceable rule rows only: gates, approvals, statuses, validation, loading, traceability, safety boundaries, or other behavior that must be auditable by rule ID. |
| COR-10-072 | Workflow, Contract, Procedure, and System files MUST keep explanatory prose out of their Rules section unless the statement is intended as an enforceable constraint backed by an ID'd rule. |
| COR-10-073 | Templates MUST stay lean scaffolds: frontmatter keys, section headings, checklists, placeholders, and short field prompts; artifact theory, mode workflow, system explanations, and enforceable constraints belong in the appropriate source file's Rules section. |

### Commits

| ID | Rule |
| --- | --- |
| COR-08-010 | Work MUST NOT commit unless the user explicitly requests it. |
| COR-08-020 | Work MUST follow the project's commit conventions in `harness-data/reference/QUALITY.md` when committing. |
