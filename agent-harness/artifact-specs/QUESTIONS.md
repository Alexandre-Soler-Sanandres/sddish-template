# QUESTIONS.md

## Purpose

A Question is an unresolved (or resolved) point that needs a decision before some artifact can be trusted as
final. Durable and discoverable, unlike a Non-Goal (permanent exclusion) or a captured Idea (candidate work, not a
question). Generalizes Legacy Discovery's own question-tracking machinery (`LD-04-010`–`030`, `NORMALIZATION.md`'s
`LDG-01-090`/`LDG-02-010`–`050`, `CLARIFICATION.md`'s `LDG-03-010`–`LDG-04-110`) to every origin, not only legacy
evidence.

## Sources

A Question may be created from any mode, mirroring ADR's `DEC-01-010` — no mode switch is required. Valid origins:
Transcript, Idea, Use Case, Spec, Task, ADR, Legacy Finding, Review finding.

## When to Create

Create a Question when something raised during any mode's work is real and needs a decision, but does not block
the artifact currently being produced (if it does block, it stays inline as that artifact's own Open Questions
item instead).

## Body Should Include

- A table of question rows (schema per file — see `agent-harness/templates/QUESTIONS-template.md`)

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| QST-01-010 | Classification | Classify by blast radius: `local` (one artifact), `cross-artifact` (multiple artifacts), or `systemic` (overall architecture/target-product shape). Judge legacy `target-product` tags by content, not mechanical mapping — see Notes. |
| QST-02-010 | ID-Scheme | Migrated legacy entries keep their exact existing ID (`Q-<APP>-NNN`, `CSQ-NNN`, `CSP-*`), unchanged. Brand-new, non-legacy entries get a plain `Q-NNN` ID — the next unused integer in one shared counter across all three files (not per-file, not per-classification). |
| QST-03-010 | Status | Status is one of `Open`, `Resolved`, `Discarded` — the file a row lives in *is* its status, no separate column. A decision to defer ("not now, revisit later") is still `Resolved`, since the decision itself is settled; only a genuinely undecided, deprioritized item stays `Open` (noted in `Notes`). |
| QST-04-010 | Dedup | Before adding a new entry, check existing rows across all three files for the same underlying question by content and merge into the existing row instead of filing a duplicate (mirrors Legacy Discovery's `LD-04-020`). |
| QST-05-010 | Non-Deletion | IDs are permanent even if the question is later merged, discarded, or resolved — record the disposition in `Notes` instead of deleting the row (same non-destructive precedent as `COR-01-080`). |
| QST-06-010 | Idea-vs-Question | A Question is an open fork with no proposed solution yet — test: "we haven't decided whether/how to X." A rough candidate direction — "we might build/do X" — belongs in `IDEA.md` instead. A Question resolving toward "yes, pursue this" spins off a new Idea citing the Question's ID; its own `Status` moves to `Resolved`, it doesn't silently become an Idea in place (the mechanical trigger for this is `QST-07-020`). |
| QST-07-010 | Moving-Rows | Whenever anything resolves or discards a Question, move the row out of `QUESTIONS-OPEN.md` into `QUESTIONS-RESOLVED.md` or `QUESTIONS-DISCARDED.md` in the same pass (see Notes for common triggers): (1) keep the ID exactly; (2) the `Question` column's text becomes the `Decision` column; (3) `Notes` must record what settled it, citing the artifact; (4) delete the row from `QUESTIONS-OPEN.md` — no duplicate left behind. There is no `Status` field to set (`QST-03-010`). A question that is still genuinely undecided stays in `QUESTIONS-OPEN.md`. |
| QST-07-020 | Idea-Spin-Off | A row moved per `QST-07-010` carries a `Follow-up: resolved\|idea` tag in `Notes`, set by whoever resolves the row — never inferred by the agent from the Decision text. When `idea`, create `IDEA-*.md` in the same pass, citing the question's ID in `source` and populating it from the full context: the question's text/Classification, the Decision, the originating `Source` artifact, and any other artifact citing this ID in its own Open Questions. |

## Notes

**Classification (`QST-01-010`):** Legacy's `target-product` tag doesn't map 1:1 to `systemic` — it was legacy's catch-all for "a decision about the new product," not a claim of architectural breadth. Only whole-architecture decisions (core safety boundaries, service-topology) are `systemic`; most single-app feature/config/deployment decisions are `local`; anything crossing an app boundary via a shared contract, volume, or visible field is `cross-artifact`.

**Moving rows (`QST-07-010`):** Common triggers include a Mode's own rule (e.g. `DEC-11-010`, `IDA-05-010`), a Use Case/Spec readiness-gate carry-forward check (`SPS-05-010`, `UCS-05-010`), or Discovering-Legacy's Question Clarification gate (`LDG-04-060`).

## Output

Three files, one per status, using `agent-harness/templates/QUESTIONS-template.md`:

- `harness-data/artifacts/questions/QUESTIONS-OPEN.md`
- `harness-data/artifacts/questions/QUESTIONS-RESOLVED.md`
- `harness-data/artifacts/questions/QUESTIONS-DISCARDED.md`
