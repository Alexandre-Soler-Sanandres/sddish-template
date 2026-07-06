# CORE.md

## Purpose

Universal harness rules that apply in every mode.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-01-010 | Universal | Use the smallest sufficient context. |
| COR-01-020 | Universal | Do not load unrelated artifact directories. |
| COR-01-030 | Universal | Do not expose secrets. |
| COR-01-040 | Universal | Do not run commands that are irreversible or have a wide blast radius (data loss, schema changes, production state changes, force operations) without explicit approval. |
| COR-01-050 | Universal | Do not implement from Partnering mode. |
| COR-01-060 | Universal | Do not implement before an approved Implementation Plan exists. |
| COR-01-070 | Universal | Keep traceability links aligned across Use Cases, Specs, Tasks, Plans, and Reviews. |
| COR-01-080 | Universal | Do not retroactively rewrite artifacts in `done/` or `archive/` folders when paths, structure, or conventions change elsewhere in the harness. |
| COR-02-010 | Artifact-Language | Write normalized artifacts in English by default. |
| COR-02-020 | Artifact-Language | Preserve the original language only in transcripts, raw input, or quoted source material when needed. |
| COR-03-010 | Context-Loading | Start context loading from the user request. |
| COR-03-020 | Context-Loading | Use `agent-harness/CATALOG.md` when the artifact identity is unknown or ambiguous. |
| COR-03-030 | Context-Loading | Load the explicitly referenced artifact before exploring related artifacts. |
| COR-03-040 | Context-Loading | Load the active true-Mode file (`agent-harness/modes/`) before taking mode-specific action. A true Mode is one of: Partnering, Implementing, Discovering-Legacy, Improving-Harness, Planning-Implementation, Refining. |
| COR-03-050 | Context-Loading | Load linked parent or child artifacts only when they are required for the current task. |
| COR-03-060 | Context-Loading | Prefer summaries before full historical artifacts when both are available. |
| COR-03-070 | Context-Loading | Load reference files only when the current task is directly affected by them. |
| COR-03-080 | Context-Loading | Load archived artifacts only when they are explicitly needed. |
| COR-03-090 | Context-Loading | Before creating or updating an artifact, also load that artifact type's spec under `agent-harness/artifact-specs/` (in addition to the active Mode file, `COR-03-040`) — e.g. creating a Spec loads both `REFINING.md` and `SPECS.md`. |
| COR-03-100 | Context-Loading | `agent-harness/shared-procs/` holds procedures explicitly invoked during a Mode's own work (e.g. Validation, invoked during Implementing or named in Improving-Harness's Improvement Process) — not a Mode or artifact spec itself. Load only when actually invoked, not by default. |
| COR-04-010 | Support-Files | Consult `agent-harness/playbooks/index.yaml` before loading universal playbooks broadly. |
| COR-04-020 | Support-Files | Consult `harness-data/playbooks/index.yaml` before loading project playbooks broadly. |
| COR-04-030 | Support-Files | Consult `harness-data/guides/index.yaml` before loading guides broadly. |
| COR-04-040 | Support-Files | Load only the matched support files needed for the current task. Do not inspect an entire support-file folder when its index is sufficient. |
| COR-04-050 | Support-Files | When both a universal playbook and a project playbook apply, follow the universal playbook for the generic procedure and the project playbook for repo-local refinement. |
| COR-04-060 | Support-Files | Guides provide local operating context. They do not replace procedural instructions from playbooks. |
| COR-04-070 | Support-Files | Playbooks and guides must not override core rules, mode boundaries, or explicit approval gates. |
| COR-05-010 | Checkpoint | Before any high-impact action, verify the active mode, restart artifact, explicit user authorization, in-scope files, and required validation before stopping or committing. |
| COR-05-020 | Checkpoint | Treat these as high-impact actions: committing; changing harness mode files, templates, or reference process rules; creating Review or Improvement artifacts; changing source-map workflow or status rules; moving artifacts between lifecycle folders; starting cross-system synthesis. |
| COR-05-030 | Checkpoint | After a resume or context compaction, repeat the checkpoint (`COR-05-010`) and re-read `CORE.md` and the active true-Mode file in full before the next high-impact action — the checkpoint verifies state, not rule text, so confirming mode identity alone is not enough. |
| COR-05-040 | Checkpoint | On a true Mode transition (per `COR-03-040`'s list — not every artifact-producing action), re-read the newly-active mode file in full before taking any mode-specific action. |
| COR-06-010 | Observability | Record temporary operational trace only when it helps safe continuation, validation, or explanation of agent behavior. |
| COR-06-020 | Observability | Use `harness-data/RUN-LOG.md` only when operational trace is useful; it is not required by default, except for the Implementation gate-check required by `IMPL-028`. |
| COR-06-030 | Observability | Record only operational facts that matter, such as context loaded, approvals, commands/checks run, current execution state, restart point, and stop reason. |
| COR-06-040 | Observability | Move durable decisions, stable blockers, and lasting outcomes into the real artifacts instead of leaving them only in operational trace. |
| COR-06-050 | Observability | Keep operational trace small and temporary; collapse it to a short closure note or clear it when the work finishes. |
| COR-07-010 | Pause-Resume | Before pausing interrupted work that will continue later, record the exact restart point. |
| COR-07-020 | Pause-Resume | Before pausing, record the current execution state. |
| COR-07-030 | Pause-Resume | Before pausing, record any checks that must be re-run before continuing. |
| COR-07-040 | Pause-Resume | On resume, repeat the context checkpoint. |
| COR-07-050 | Pause-Resume | On resume, confirm that the restart point is still valid. |
| COR-07-060 | Pause-Resume | On resume, confirm that no newer artifact, status change, or user instruction invalidates the old plan. |
| COR-07-070 | Pause-Resume | On resume, re-run any validations or checks that were still uncertain at pause time. |
| COR-07-080 | Pause-Resume | Do not resume from stale conversational state alone when restart point or validation state matters. |
| COR-08-010 | Commits | Do not commit unless the user explicitly requests it. |
| COR-08-020 | Commits | Follow the project's commit conventions in `harness-data/reference/QUALITY.md` when committing. |
| COR-09-010 | High-Risk | Treat database migrations, security/secrets/auth, deployment/infrastructure, payment/financial transaction execution, and domain-critical business logic (`harness-data/reference/DOMAIN.md`) as high-risk: do not proceed without explicit scope and validation coverage (payments additionally require explicit approval coverage). |
