# Questions Registry

## Purpose

The Questions registry is the single durable backlog for unresolved decisions. It is a table at
`harness-data/artifacts/questions/QUESTIONS.md`, not a collection of lifecycle files.

## Row schema

| Field | Meaning |
| --- | --- |
| ID | Stable `Q-NNNN` ID. |
| Status | `open`, `resolved`, or `discarded`. |
| Question | The unresolved decision or uncertainty. |
| Classification | `local`, `cross-artifact`, or `systemic`. |
| Impact | `blocking`, `material`, or `none`. |
| Source IDs | Canonical IDs that raised it. |
| Resolution / Disposition | Required for terminal rows: chosen answer or reason it is no longer material. |
| Resolution basis | IDs that settled it, or dated direct user decision when no durable artifact exists. |
| Follow-up | `none` or successor artifact ID. |
| Resolved at | Required terminal date. |

## Rules

| ID | Rule |
| --- | --- |
| QST-06-010 | A Question MUST represent an uncertainty that blocks or materially affects current work; a deferred opportunity MUST be an Idea. |
| QST-06-020 | An artifact that depends on an unresolved Question MUST cite its ID in `question_refs`. |
| QST-07-010 | A terminal Question row MUST contain Resolution / Disposition, Resolution basis, Follow-up, and Resolved at. |
| QST-09-010 | Question IDs MUST be unique and MUST NOT be deleted or reused. |
| QST-10-010 | A resolved row MUST state the chosen answer; a discarded row MUST state why it is no longer material. |

### Legacy (v1)

Retained verbatim from the pre-v2 paired rules for active v1 chains and Legacy Discovery output during the v2 cutover (`IMPROVEMENT-0148`–`0150`). The v2 rows above are authoritative for all new work; the v2 numbering reuses `QST-06-010`/`06-020`/`07-010`/`09-010`/`10-010` for a different single-registry model, so these keep a `-v1` suffix. Retired by `IMPROVEMENT-0150`.

| ID | Rule |
| --- | --- |
| QST-01-010-v1 | MUST classify by blast radius: `local` (one artifact), `cross-artifact` (multiple artifacts), or `systemic` (overall architecture/target-product shape), judging legacy `target-product` tags by content, not mechanical mapping — see `QUESTIONS.md`'s `## Field Semantics`. |
| QST-02-010-v1 | Every Question ID family with a numeric suffix MUST use four digits: `Q-NNNN`, `Q-<APP>-NNNN`, `CSQ-NNNN`, `CSP-NNNN`. New IDs take the next unused integer in their existing family/counter shape, zero-padded to four digits. |
| QST-03-010-v1 | Status MUST be one of `Open`, `Resolved`, `Discarded` — the file a row lives in *is* its status, no separate column. A decision to defer ("not now, revisit later") is still `Resolved`, since the decision itself is settled; only a genuinely undecided, deprioritized item stays `Open` (noted in `Notes`). |
| QST-04-010-v1 | MUST check existing rows across all three files for the same underlying question by content and merge into the existing row instead of filing a duplicate, before adding a new entry (mirrors Legacy Discovery's `LD-04-020`). |
| QST-05-010-v1 | IDs MUST remain permanent even if the question is later merged, discarded, or resolved — record the disposition in `Notes` instead of deleting the row (same non-destructive precedent as `COR-01-080`). |
| QST-06-010-v1 | A Question is an unresolved fork with no proposed solution yet, including both explicit artifact-visible forks and latent forks that become clear after applying engineering judgment to the evidence. A candidate direction without an unresolved fork belongs in `IDEA.md` instead. A Question resolving toward "yes, pursue this" MUST spin off a new Idea citing the Question's ID, with its own `Status` moved to `Resolved`, not silently become an Idea in place (the mechanical trigger for this is `QST-07-020-v1`). |
| QST-06-020-v1 | MUST NOT create a Question for a merely conceivable improvement or speculative branch. A standalone Question is warranted only when the evidence leaves at least two plausible target directions whose difference would materially affect behavior, architecture, operator workflow, safety posture, or scoped delivery shape. |
| QST-07-010-v1 | Whenever anything resolves or discards a Question, MUST move the row out of `QUESTIONS-OPEN.md` into `QUESTIONS-RESOLVED.md` or `QUESTIONS-DISCARDED.md` in the same pass (see `QUESTIONS.md`'s `## Lifecycle` for common triggers): (1) keep the ID exactly; (2) the `Question` column's text becomes the `Decision` column; (3) `Notes` must record what settled it, citing the artifact; (4) delete the row from `QUESTIONS-OPEN.md` — no duplicate left behind. There is no `Status` field to set (`QST-03-010-v1`). A question that is still genuinely undecided stays in `QUESTIONS-OPEN.md`. |
| QST-07-020-v1 | A row moved per `QST-07-010-v1` MUST carry a `Follow-up: resolved\|idea` tag in `Notes`, set by whoever resolves the row, not inferred by the agent from the Decision text. When `idea`, create `IDEA-*.md` in the same pass, citing the question's ID in `source` and populating it from the full context: the question's text/Classification, the Decision, the originating `Source` artifact, and any other artifact citing this ID in its own Open Questions. |
| QST-08-010-v1 | MAY create a Question from any mode — no mode switch required. |
| QST-09-010-v1 | MUST record every Question in the Questions registry — there is no separate local-only Question store, regardless of how material the Question is to any given artifact. See `CORE.md`'s `COR-01-120` for how artifacts reference registry entries in their own Open Questions sections. |
| QST-09-020-v1 | Before the first `QST-04-010-v1` dedup scan or the first row insertion, if any of `QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, `QUESTIONS-DISCARDED.md` is absent, MUST create all three from `agent-harness/templates/QUESTIONS-template.md` in one bootstrap action, so the dedup scan and subsequent row moves span every status file. |
| QST-10-010-v1 | `Impact` MUST be `active` (currently degrading a running system — worth prioritizing now) or `none` (no current operational impact — a design fork, a someday improvement, or a decision with no live consequence yet). Defaults to `none` at creation. |
| QST-10-020-v1 | `Impact` is a distinct axis from `QST-01-010-v1`'s blast-radius `Classification` — MUST NOT be conflated with it. |
| QST-10-030-v1 | MUST be set to `active` explicitly, not left to default silently, whenever the raising context already establishes that a presently-broken, in-production capability is involved (mirrors `QST-06-020-v1`'s explicitness standard, applied to this axis). |
