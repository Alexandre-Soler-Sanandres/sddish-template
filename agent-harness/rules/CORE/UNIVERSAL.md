# CORE / Universal Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-01-020 | Universal | MUST NOT load unrelated artifact directories. |
| COR-01-030 | Universal | MUST NOT expose secrets. |
| COR-01-040 | Universal | MUST NOT run commands that are irreversible or have a wide blast radius (data loss, schema changes, production state changes, force operations) without explicit approval. |
| COR-01-050 | Universal | MUST NOT implement from Partnering mode. |
| COR-01-060 | Universal | MUST NOT implement before an approved Implementation Plan exists. |
| COR-01-070 | Universal | MUST keep traceability links aligned across Use Cases, Specs, Tasks, Plans, and Reviews. |
| COR-01-080 | Universal | MUST NOT retroactively rewrite artifacts in `done/` or `archive/` folders when paths, structure, or conventions change elsewhere in the harness. See `agent-harness/systems/LIFECYCLE-FOLDERS.md` for how this rule holds across every artifact type's folder shape. |
| COR-01-090 | Universal | MUST NOT infer approval from a conversation's tone or direction — any status change or action requiring user approval needs the user's explicit confirmation instead. |
| COR-01-100 | Universal | MUST NOT modify `agent-harness/*` (harness mode files, templates, artifact specs, process rules) outside Improving-Harness mode. |
| COR-01-110 | Universal | MUST decide Question vs Idea before creating either, when work surfaces something worth tracking without needing to pause the artifact currently in progress. See `QUESTIONS.md`'s `QST-06-010` for the Question/Idea test (including latent, judgment-informed forks) and dedup/ID mechanics, `QST-06-020` for when a Question is material enough to warrant filing, and `agent-harness/systems/QUESTION-LIFECYCLE.md` for how a Question then spreads to and resolves for the artifacts that cite it. |
| COR-01-111 | Universal | Engineering judgment applied to a Question-vs-Idea decision (`COR-01-110`) MUST stay evidence-grounded. |
| COR-01-112 | Universal | MUST NOT invent facts when applying that judgment. |
| COR-01-120 | Universal | Every artifact's own Open Questions section (or equivalent) MUST hold references to canonical Question IDs, not freeform or artifact-local-only question text. This governs every artifact type (Transcript, Idea, Use Case, Spec, Task, ADR, Legacy Finding, Review). Whether an unresolved reference stops this artifact from advancing is for that artifact's own Readiness Checklist to judge — not a stored attribute on the reference. See `QUESTIONS.md`'s `QST-09-010` for registry mechanics and `agent-harness/systems/QUESTION-LIFECYCLE.md` for how this reference-by-ID discipline lets one Question resolution reach every citing artifact. |
| COR-01-130 | Universal | MUST reconsider every other artifact in the Use Case → Spec → Task → Plan chain — in either direction — whose own terminal status was reached via `IMPLEMENTATION-PLAN.md`'s `IPL-05-080` completion cascade, whenever any artifact in that chain moves off a terminal status (`implemented`, `done`) for a reason other than that same completion cascade itself. See `agent-harness/systems/STATUS-CASCADE.md` for how this rule's upward direction relates to `UCS-02-040`/`SPS-07-020`'s downward resets and `IPL-05-080`'s/`TSK-02-020`'s cascade-completion and reopening triggers. |
| COR-01-131 | Universal | MUST report the `COR-01-130` reconsideration outcome explicitly ("no change needed" is a valid outcome) rather than leaving an ancestor's or descendant's status claim unexamined by default. |
