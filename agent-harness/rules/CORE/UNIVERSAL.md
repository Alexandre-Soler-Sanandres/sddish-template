# CORE / Universal Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-01-001 | Invariant Kernel | MUST understand the intended outcome before mutation. |
| COR-01-002 | Invariant Kernel | MUST state changed behavior and applicable preserved behavior before mutation. |
| COR-01-003 | Invariant Kernel | MUST record a bounded plan before mutation. |
| COR-01-004 | Invariant Kernel | MUST obtain the execution authorization required by the selected Work Lane before mutation. |
| COR-01-005 | Invariant Kernel | MUST scale assurance by ambiguity, reversibility, boundary impact, and risk. |
| COR-01-006 | Invariant Kernel | MUST keep approved scope and execution batches bounded. |
| COR-01-007 | Invariant Kernel | MUST verify applicable acceptance criteria with credible evidence. |
| COR-01-008 | Invariant Kernel | MUST persist decisions, blockers, and handoffs only when they need to survive context loss. |
| COR-01-020 | Universal | MUST NOT load unrelated artifact directories. |
| COR-01-030 | Universal | MUST NOT expose secrets. |
| COR-01-040 | Universal | MUST NOT run commands that are irreversible or have a wide blast radius (data loss, schema changes, production state changes, force operations) without explicit approval. |
| COR-01-050 | Universal | MUST NOT implement from Partnering mode. |
| COR-01-060 | Universal | MUST NOT implement without the authorized execution contract required by `shared-procs/WORK-LANES.md`: a stated Fast micro-plan, approved Standard Change Spec, or approved Assured Execution Plan. |
| COR-01-070 | Universal | MUST keep traceability links aligned across Use Cases, Specs, Tasks, Plans, and Reviews. |
| COR-01-080 | Universal | MUST NOT retroactively rewrite artifacts in `done/` or `archive/` folders when paths, structure, or conventions change elsewhere in the harness. See `agent-harness/systems/LIFECYCLE-FOLDERS.md` for how this rule holds across every artifact type's folder shape. |
| COR-01-090 | Universal | MUST NOT infer approval from a conversation's tone or direction — any status change or action requiring user approval needs the user's explicit confirmation instead. |
| COR-01-100 | Universal | MUST NOT modify `agent-harness/*` (harness mode files, templates, artifact specs, process rules) outside Improving-Harness mode. |
| COR-01-110 | Universal | MUST decide Question vs Idea before creating either, when work surfaces something worth tracking without needing to pause the artifact currently in progress. See `QUESTIONS.md`'s `QST-06-010` for the Question/Idea test (including latent, judgment-informed forks) and dedup/ID mechanics, `QST-06-020` for when a Question is material enough to warrant filing, and `agent-harness/systems/QUESTION-LIFECYCLE.md` for how a Question then spreads to and resolves for the artifacts that cite it. |
| COR-01-111 | Universal | Engineering judgment applied to a Question-vs-Idea decision (`COR-01-110`) MUST stay evidence-grounded. |
| COR-01-112 | Universal | MUST NOT invent facts when applying that judgment. |
| COR-01-120 | Universal | Every artifact's own Open Questions section (or equivalent) MUST hold references to canonical Question IDs, not freeform or artifact-local-only question text. This governs every artifact type (Transcript, Idea, Use Case, Spec, Task, ADR, Legacy Finding, Review). Whether an unresolved reference stops this artifact from advancing is for that artifact's own Readiness Checklist to judge — not a stored attribute on the reference. See `QUESTIONS.md`'s `QST-09-010` for registry mechanics and `agent-harness/systems/QUESTION-LIFECYCLE.md` for how this reference-by-ID discipline lets one Question resolution reach every citing artifact. |
