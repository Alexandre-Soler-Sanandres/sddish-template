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
| COR-006 | Universal | Do not implement before an accepted Implementation Plan exists. |
| COR-007 | Universal | Keep traceability links aligned across Use Cases, Specs, Tasks, Plans, and Reviews. |
| COR-008 | Universal | Do not retroactively rewrite artifacts in `done/` or `archive/` folders when paths, structure, or conventions change elsewhere in the harness. |
| COR-009 | Artifact-Language | Write normalized artifacts in English by default. |
| COR-010 | Artifact-Language | Preserve the original language only in transcripts, raw input, or quoted source material when needed. |
| COR-011 | Context-Loading | Start context loading from the user request. |
| COR-012 | Context-Loading | Use `agent-harness/CATALOG.md` when the artifact identity is unknown or ambiguous. |
| COR-013 | Context-Loading | Load the explicitly referenced artifact before exploring related artifacts. |
| COR-014 | Context-Loading | Load the active mode file before taking mode-specific action. |
| COR-015 | Context-Loading | Load linked parent or child artifacts only when they are required for the current task. |
| COR-016 | Context-Loading | Prefer summaries before full historical artifacts when both are available. |
| COR-017 | Context-Loading | Load reference files only when the current task is directly affected by them. |
| COR-018 | Context-Loading | Load archived artifacts only when they are explicitly needed. |
| COR-019 | Support-Files | Load a universal playbook from `agent-harness/playbooks/` when the task matches a harness-defined reusable procedure. |
| COR-020 | Support-Files | Load a project playbook from `harness-data/playbooks/` when the task matches a repo-specific recurring procedure or subsystem workflow. |
| COR-021 | Support-Files | Load a guide from `harness-data/guides/` when the task depends on project-specific setup, tooling usage, bootstrap steps, or local operating knowledge. |
| COR-022 | Support-Files | Load only the smallest relevant set of playbooks and guides needed for the current task. |
| COR-023 | Support-Files | When both a universal playbook and a project playbook apply, follow the universal playbook for the generic procedure and the project playbook for repo-local refinement. |
| COR-024 | Support-Files | Guides provide local operating context. They do not replace procedural instructions from playbooks. |
| COR-025 | Support-Files | Playbooks and guides must not override core rules, mode boundaries, or explicit approval gates. |
| COR-026 | Implementation-Gate | Verify that an Implementation Plan exists before implementation starts. |
| COR-027 | Implementation-Gate | Verify that the Implementation Plan is at status `approved` before implementation starts. |
| COR-028 | Implementation-Gate | Verify that required upstream artifacts are at accepted status, not draft or under review (for example: Spec `approved`, Use Case `ready-for-spec`, Task `ready`). |
| COR-029 | Implementation-Gate | Verify that safety and risk rules are satisfied before implementation starts. |
| COR-030 | Checkpoint | Before any high-impact action, verify the active mode, restart artifact, explicit user authorization, in-scope files, and required validation before stopping or committing. |
| COR-031 | Checkpoint | Treat these as high-impact actions: committing; changing harness mode files, templates, or reference process rules; creating Review or Improvement artifacts; changing source-map workflow or status rules; moving artifacts between lifecycle folders; starting cross-system synthesis. |
| COR-032 | Checkpoint | After a resume or context compaction, repeat the checkpoint before the next high-impact action. |
| COR-033 | Observability | Record temporary operational trace only when it helps safe continuation, validation, or explanation of agent behavior. |
| COR-034 | Observability | Use `harness-data/RUN-LOG.md` only when operational trace is useful; it is not required by default. |
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
| COR-048 | High-Risk | When work touches database migrations, treat it as high-risk and do not proceed without explicit scope and validation coverage. |
| COR-049 | High-Risk | When work touches security, secrets, or auth, treat it as high-risk and stop if scope or validation coverage is unclear. |
| COR-050 | High-Risk | When work touches deployment or infrastructure, treat it as high-risk and require explicit validation coverage before proceeding. |
| COR-051 | High-Risk | When work touches payment or financial transaction execution, treat it as high-risk and stop unless scope, validation, and approval coverage are explicit. |
| COR-052 | High-Risk | When work touches domain-critical business logic defined in `harness-data/reference/DOMAIN.md`, treat it as high-risk and verify that scope and validation are explicit before proceeding. |
| COR-053 | Parallel-Work | Allow at most one Implementation Plan at status `approved` or `in-progress` per Spec. |
| COR-054 | Parallel-Work | Check `harness-data/CATALOG.md` for existing Plans at status `approved` or `in-progress` before approving a new Plan. |
| COR-055 | Parallel-Work | If two active Plans have overlapping `allowed_paths` across their Tasks, stop, surface the conflict, list both Plan IDs and overlapping paths, and wait for explicit user resolution. |
| COR-056 | Parallel-Work | Allow concurrent Plans on non-overlapping Specs without restriction. |
| COR-057 | Parallel-Work | Keep `harness-data/CATALOG.md` accurate for all Plans at status `approved` or `in-progress`. |
