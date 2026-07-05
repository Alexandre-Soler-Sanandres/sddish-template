# QUESTIONS.md

## Purpose

A Question is an unresolved (or resolved) point that needs a decision before some artifact can be trusted as
final. Durable and discoverable, unlike a Non-Goal (permanent exclusion) or a captured Idea (candidate work, not a
question). Generalizes Legacy Discovery's own question-tracking machinery (`LD-017`–`019`, `GATES.md`'s
`LDG-009`–`030`) to every origin, not only legacy evidence.

## Sources

A Question may be created from any mode, mirroring ADR's `DEC-001` — no mode switch is required. Valid origins:
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
| QST-001 | Classification | Classify by blast radius: `local` (confined to the one artifact that raised it), `cross-artifact` (affects more than one artifact), or `systemic` (affects overall architecture/target-product shape broadly). When translating a legacy `target-product` tag, judge each row by its actual content, not a mechanical 1:1 mapping to `systemic` — `target-product` was legacy's catch-all for "a decision about the new product," not a claim of architectural breadth; the original bulk migration mapped it to `systemic` uncritically and had to be corrected afterward (125 of 129 rows were over-classified — only whole-architecture decisions, e.g. core safety boundaries or service-topology choices, are actually `systemic`; most single-app feature/config/deployment decisions are `local`, and anything crossing an app boundary via a shared contract, volume, or visible field is `cross-artifact`). |
| QST-002 | ID-Scheme | Migrated legacy entries keep their exact existing ID (`Q-<APP>-NNN`, `CSQ-NNN`, `CSP-*`), unchanged. Brand-new, non-legacy entries get a plain `Q-NNN` ID — the next unused integer in one shared counter across all three files (not per-file, not per-classification). |
| QST-003 | Status | Status is one of `Open`, `Resolved`, `Discarded` — generalizing Legacy Discovery's own *resolve/discard* vocabulary. There is no `Status` column in any file: which of the three files a row lives in *is* its status, so a column repeating that would be redundant — a row moves file when its status changes (see `QST-007`), keeping its ID. There is no separate "Deferred" status: a real question that hasn't been decided yet, just deprioritized, is `Open` with that noted in `Notes` (nothing was decided, so it cannot be `Resolved`); a question whose decision *content* happens to be "not now, revisit later" (or "decided, but proof/implementation pending") is `Resolved` — the decision itself is settled, which is what makes it `Resolved` regardless of what the decision says. |
| QST-004 | Dedup | Before adding a new entry, check existing rows across all three files for the same underlying question by content and merge into the existing row instead of filing a duplicate (mirrors Legacy Discovery's `LD-018`). |
| QST-005 | Non-Deletion | IDs are permanent even if the question is later merged, discarded, or resolved — record the disposition in `Notes` instead of deleting the row (same non-destructive precedent as `COR-008`). |
| QST-006 | Idea-vs-Question | A Question is an open fork or uncertainty with no proposed solution shape yet — test: does it read as "we haven't decided whether/how to X"? If it already has at least a rough candidate solution/direction — test: does it read as "we might build/do X"? — it belongs in `agent-harness/artifact-specs/IDEA.md`, not here. When a Question resolves toward "yes, pursue this," that resolution is what spins off a new Idea, citing the Question's ID; the Question's own `Status` moves to `Resolved`, it does not silently become an Idea in place. |
| QST-007 | Moving-Rows | Whenever anything resolves or discards a Question — a Mode's own rule (e.g. `DEC-012`, `IDA-005`), a Use Case/Spec readiness-gate carry-forward check (`SPS-009`, `UCS-007`), or Discovering-Legacy's Question Clarification gate (`LDG-025`) — move the row out of `QUESTIONS-OPEN.md` into `QUESTIONS-RESOLVED.md` or `QUESTIONS-DISCARDED.md` in the same pass, not deferred to later reconciliation: (1) keep the ID exactly; (2) the `Question` column's text becomes the `Decision` column — replace it with the actual decision/discard content, don't leave the original question text standing in for it; (3) `Notes` must record what settled it (citing the artifact — an ADR ID, `CSQ-*`, a Use Case ID, etc. — never left blank); (4) delete the row from `QUESTIONS-OPEN.md` — do not leave a duplicate behind. There is no `Status` field to set — the destination file is the status (see `QST-003`). A question that is still genuinely undecided, just deprioritized, is never moved — it stays in `QUESTIONS-OPEN.md` with that noted in `Notes`. |

## Output

Three files, one per status, using `agent-harness/templates/QUESTIONS-template.md`:

- `harness-data/artifacts/questions/QUESTIONS-OPEN.md`
- `harness-data/artifacts/questions/QUESTIONS-RESOLVED.md`
- `harness-data/artifacts/questions/QUESTIONS-DISCARDED.md`
