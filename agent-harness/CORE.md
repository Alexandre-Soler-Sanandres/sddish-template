# CORE

## Purpose

The invariant kernel for every Harness lane. Load this file, the selected workflow, selected Artifact Contract, and
only invoked Procedures or enabled Extensions.

## Invariant kernel

Understand intent; state changed and preserved behavior; make a bounded plan; obtain lane-appropriate
authorization; scale assurance to risk; bound scope; verify credibly; and persist only decisions, blockers, and
handoffs needed across context loss.

## Rules

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
| COR-01-030 | Work MUST NOT expose secrets. |
| COR-01-040 | Work MUST NOT perform an irreversible or wide-blast-radius operation without explicit approval. |
| COR-01-060 | Work MUST NOT implement without its authorized Fast micro-plan, approved Standard Change Spec, or approved Assured Execution Plan. |
| COR-01-070 | Canonical forward traceability MUST remain aligned across work artifacts. |
| COR-01-080 | Terminal artifacts MUST NOT be rewritten except through an explicitly approved controlled migration. |
| COR-01-090 | Work MUST NOT infer an approval from conversational tone or direction. |
| COR-01-100 | Harness files MUST change only through Improving-Harness mode and an approved Improvement. |
| COR-01-110 | Work MUST decide Question versus Idea before creating either. |
| COR-01-120 | Artifact-local Question references MUST use canonical Question IDs. |
| COR-03-010 | Context loading MUST start from the user request and explicitly named artifact. |
| COR-03-040 | Work MUST load the selected true workflow before workflow-specific action. |
| COR-03-046 | Initial harness context MUST include this file, the selected workflow, the referenced artifact, and its Contract when an artifact is created, updated, or reviewed. |
| COR-03-048 | Context MUST expand only to invoked Procedures, enabled Extensions, cited authority, or evidence needed for the action. |
| COR-05-010 | Work MUST checkpoint mode, authorization, in-scope files, and validation before high-impact actions, stopping, or committing. |
| COR-08-010 | Work MUST NOT commit unless the user explicitly requests it. |
