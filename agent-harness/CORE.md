# CORE.md

## Purpose

Universal harness rules that apply in every mode.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-001 | Universal | Use the smallest sufficient context. |
| COR-002 | Universal | Do not load unrelated artifact directories. |
| COR-003 | Universal | Do not expose secrets. |
| COR-004 | Universal | Do not run commands that are irreversible or have a wide blast radius (data loss, schema changes, production state changes, force operations) without explicit approval. |
| COR-005 | Universal | Do not implement from Partnering mode. |
| COR-006 | Universal | Do not implement before an approved Implementation Plan exists. |
| COR-007 | Universal | Keep traceability links aligned across Use Cases, Specs, Tasks, Plans, and Reviews. |
| COR-008 | Universal | Do not retroactively rewrite artifacts in `done/` or `archive/` folders when paths, structure, or conventions change elsewhere in the harness. |
| COR-009 | Artifact-Language | Write normalized artifacts in English by default. |
| COR-010 | Artifact-Language | Preserve the original language only in transcripts, raw input, or quoted source material when needed. |
| COR-011 | Context-Loading | Start context loading from the user request. |
| COR-012 | Context-Loading | Use `agent-harness/CATALOG.md` when the artifact identity is unknown or ambiguous. |
| COR-013 | Context-Loading | Load the explicitly referenced artifact before exploring related artifacts. |
| COR-014 | Context-Loading | Load the active true-Mode file (`agent-harness/modes/`) before taking mode-specific action. A true Mode is one of: Partnering, Implementing, Discovering-Legacy, Improving-Harness, Planning-Implementation, Refining. |
| COR-015 | Context-Loading | Load linked parent or child artifacts only when they are required for the current task. |
| COR-016 | Context-Loading | Prefer summaries before full historical artifacts when both are available. |
| COR-017 | Context-Loading | Load reference files only when the current task is directly affected by them. |
| COR-018 | Context-Loading | Load archived artifacts only when they are explicitly needed. |
| COR-058 | Context-Loading | Before creating or updating an artifact, also load that artifact type's spec under `agent-harness/artifact-specs/` (in addition to the active Mode file, `COR-014`) — e.g. creating a Spec loads both `REFINING.md` and `SPECS.md`. |
| COR-061 | Context-Loading | `agent-harness/shared-procs/` holds procedures explicitly invoked during a Mode's own work (e.g. Validation, invoked during Implementing or named in Improving-Harness's Improvement Process) — not a Mode or artifact spec itself. Load only when actually invoked, not by default. |
| COR-019 | Support-Files | Consult `agent-harness/playbooks/index.yaml` before loading universal playbooks broadly. |
| COR-020 | Support-Files | Consult `harness-data/playbooks/index.yaml` before loading project playbooks broadly. |
| COR-021 | Support-Files | Consult `harness-data/guides/index.yaml` before loading guides broadly. |
| COR-022 | Support-Files | Load only the matched support files needed for the current task. Do not inspect an entire support-file folder when its index is sufficient. |
| COR-023 | Support-Files | When both a universal playbook and a project playbook apply, follow the universal playbook for the generic procedure and the project playbook for repo-local refinement. |
| COR-024 | Support-Files | Guides provide local operating context. They do not replace procedural instructions from playbooks. |
| COR-025 | Support-Files | Playbooks and guides must not override core rules, mode boundaries, or explicit approval gates. |
| COR-030 | Checkpoint | Before any high-impact action, verify the active mode, restart artifact, explicit user authorization, in-scope files, and required validation before stopping or committing. |
| COR-031 | Checkpoint | Treat these as high-impact actions: committing; changing harness mode files, templates, or reference process rules; creating Review or Improvement artifacts; changing source-map workflow or status rules; moving artifacts between lifecycle folders; starting cross-system synthesis. |
| COR-032 | Checkpoint | After a resume or context compaction, repeat the checkpoint (`COR-030`) and re-read `CORE.md` and the active true-Mode file in full before the next high-impact action — the checkpoint verifies state, not rule text, so confirming mode identity alone is not enough. |
| COR-060 | Checkpoint | On a true Mode transition (per `COR-014`'s list — not every artifact-producing action), re-read the newly-active mode file in full before taking any mode-specific action. |
| COR-033 | Observability | Record temporary operational trace only when it helps safe continuation, validation, or explanation of agent behavior. |
| COR-034 | Observability | Use `harness-data/RUN-LOG.md` only when operational trace is useful; it is not required by default, except for the Implementation gate-check required by `IMPL-028`. |
| COR-035 | Observability | Record only operational facts that matter, such as context loaded, approvals, commands/checks run, current execution state, restart point, and stop reason. |
| COR-036 | Observability | Move durable decisions, stable blockers, and lasting outcomes into the real artifacts instead of leaving them only in operational trace. |
| COR-037 | Observability | Keep operational trace small and temporary; collapse it to a short closure note or clear it when the work finishes. |
| COR-038 | Pause-Resume | Before pausing interrupted work that will continue later, record the exact restart point. |
| COR-039 | Pause-Resume | Before pausing, record the current execution state. |
| COR-040 | Pause-Resume | Before pausing, record any checks that must be re-run before continuing. |
| COR-041 | Pause-Resume | On resume, repeat the context checkpoint. |
| COR-042 | Pause-Resume | On resume, confirm that the restart point is still valid. |
| COR-043 | Pause-Resume | On resume, confirm that no newer artifact, status change, or user instruction invalidates the old plan. |
| COR-044 | Pause-Resume | On resume, re-run any validations or checks that were still uncertain at pause time. |
| COR-045 | Pause-Resume | Do not resume from stale conversational state alone when restart point or validation state matters. |
| COR-046 | Commits | Do not commit unless the user explicitly requests it. |
| COR-047 | Commits | Follow the project's commit conventions in `harness-data/reference/QUALITY.md` when committing. |
| COR-048 | High-Risk | Treat database migrations, security/secrets/auth, deployment/infrastructure, payment/financial transaction execution, and domain-critical business logic (`harness-data/reference/DOMAIN.md`) as high-risk: do not proceed without explicit scope and validation coverage (payments additionally require explicit approval coverage). |
