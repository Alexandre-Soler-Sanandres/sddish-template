# QUESTIONS.md

## Purpose

A Question is an unresolved (or resolved) point that needs a decision before some artifact can be trusted as
final. Durable and discoverable, unlike a Non-Goal (permanent exclusion) or a captured Idea (candidate work, not
a question). Generalizes Legacy Discovery's own question-tracking machinery (`LD-04-010`–`030`,
`NORMALIZATION.md`'s `LDG-01-090`/`LDG-02-010`–`050`, `CLARIFICATION.md`'s `LDG-03-010`–`LDG-04-110`) to every
origin, not only legacy evidence.

## Artifact Story

Any mode can surface a genuine fork — two plausible directions whose difference would materially matter — and
raise it as a Question rather than guessing or silently picking one. The row lives in one of three flat files by
status; resolving it moves the row, never deletes it. A Question resolving toward "yes, pursue this" spins off a
new Idea rather than quietly becoming one in place.

## Entry / Creation Paths

Raised inline from whichever mode surfaces it — no dedicated CLI command or mode switch required (`QST-08-010`).

## Sources

Create a Question from whichever mode surfaces it. Valid origins: Transcript, Idea, Use Case, Spec, Task, ADR,
Legacy Finding, Review finding.

## When To Create

A standalone Question is warranted only when the evidence leaves at least two plausible target directions whose
difference would materially affect behavior, architecture, operator workflow, safety posture, or scoped delivery
shape (`QST-06-020`). See `QST-09-010` for registry mechanics and `CORE.md`'s `COR-01-120` for how artifact Open
Questions sections reference the registry.

## When Not To Create

Do not create a Question for a merely conceivable improvement or speculative branch (`QST-06-020`). An item with
a candidate direction but no unresolved fork belongs in `IDEA.md` instead (`QST-06-010`). Before adding a new
entry, check existing rows across all three files for the same underlying question by content and merge instead
of filing a duplicate (`QST-04-010`).

## Artifact Shape

Each row carries an ID, a `Classification` (blast radius), a `Source`, and — once resolved — a `Decision` and
`Notes` recording what settled it. `Impact` is a separate axis from `Classification`. There is no `Status`
column: the file a row lives in (`QUESTIONS-OPEN.md`, `QUESTIONS-RESOLVED.md`, `QUESTIONS-DISCARDED.md`) is its
status (`QST-03-010`).

## Field Semantics

- `Classification` (`QST-01-010`) — blast radius: `local` (one artifact), `cross-artifact` (multiple artifacts),
  or `systemic` (overall architecture/target-product shape). Judge legacy `target-product` tags by content, not
  mechanical mapping: legacy's `target-product` tag doesn't map 1:1 to `systemic` — it was legacy's catch-all for
  "a decision about the new product," not a claim of architectural breadth. Only whole-architecture decisions
  (core safety boundaries, service-topology) are `systemic`; most single-app feature/config/deployment decisions
  are `local`; anything crossing an app boundary via a shared contract, volume, or visible field is
  `cross-artifact`.
- ID scheme (`QST-02-010`) — migrated legacy entries keep their exact existing ID (`Q-<APP>-NNN`, `CSQ-NNN`,
  `CSP-*`), unchanged; brand-new, non-legacy entries get a plain `Q-NNN` ID — the next unused integer in one
  shared counter across all three files (not per-file, not per-classification).
- `Impact` (`QST-10-010`–`030`) — `active` (currently degrading a running system — worth prioritizing now) or
  `none` (no current operational impact — a design fork, a someday improvement, or a decision with no live
  consequence yet); defaults to `none` at creation, but must be set to `active` explicitly whenever the raising
  context already establishes that a presently-broken, in-production capability is involved. Distinct from
  `Classification` — never conflate the two axes.

## Body Should Include

- A table of question rows (schema per file — see `agent-harness/templates/QUESTIONS-template.md`)

## Lifecycle

Whenever anything resolves or discards a Question, move the row out of `QUESTIONS-OPEN.md` into
`QUESTIONS-RESOLVED.md` or `QUESTIONS-DISCARDED.md` in the same pass: keep the ID exactly; the `Question`
column's text becomes the `Decision` column; `Notes` must record what settled it, citing the artifact; delete the
row from `QUESTIONS-OPEN.md` — no duplicate left behind (`QST-07-010`). A decision to defer ("not now, revisit
later") is still `Resolved`, since the decision itself is settled; only a genuinely undecided, deprioritized item
stays `Open` (`QST-03-010`). IDs remain permanent even after merging, discarding, or resolving — record the
disposition in `Notes` instead of deleting the row (`QST-05-010`). See
`agent-harness/systems/QUESTION-LIFECYCLE.md` for how a Question spreads to citing artifacts before resolution
and what commonly triggers a move (an ADR settling it, a readiness-gate carry-forward check, Legacy Discovery's
Question Clarification gate, and others).

## Readiness / Acceptance

Not applicable in the artifact-status sense — a Question's "readiness" is whether it is still genuinely
undecided (`Open`) or has been settled (`Resolved`/`Discarded`), per `## Lifecycle`.

## Relationships

A row moved per `## Lifecycle`'s `QST-07-010` must carry a `Follow-up: resolved|idea` tag in `Notes`, set by
whoever resolves the row, not inferred by the agent from the Decision text. When `idea`, create `IDEA-*.md` in
the same pass, citing the question's ID in `source` and populating it from the full context: the question's
text/Classification, the Decision, the originating `Source` artifact, and any other artifact citing this ID in
its own Open Questions (`QST-07-020`). See `agent-harness/systems/QUESTION-LIFECYCLE.md`'s Examples for a worked
case of both the resolve-only and idea-spin-off paths.

## Output / Location

Three files, one per status, using `agent-harness/templates/QUESTIONS-template.md`:

- `harness-data/artifacts/questions/QUESTIONS-OPEN.md`
- `harness-data/artifacts/questions/QUESTIONS-RESOLVED.md`
- `harness-data/artifacts/questions/QUESTIONS-DISCARDED.md`

There is no separate local-only Question store — every Question must be recorded in this registry, regardless of
how material it is to any given artifact (`QST-09-010`).

## Template

Use `agent-harness/templates/QUESTIONS-template.md` for all three files.

## Examples

A Legacy Finding establishes current retry behavior but leaves the target policy unresolved. The agent checks
existing `QUESTIONS-OPEN.md` rows for an overlapping question, finds none, and adds a `Q-<APP>-NNN` row with
`Classification: local`, citing the finding in `Source`.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/QUESTIONS.md` (single paired
file — under the 25-rule grouping threshold). Load it whenever raising, deduping, resolving, or discarding a
Question.

## Reference Files

None beyond the template.
