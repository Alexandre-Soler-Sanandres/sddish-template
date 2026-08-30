# IMPROVEMENT.md

## Purpose

An Improvement is the record of a harness change: the problem it fixes, why it happened, what changed, and how
that change was validated. It is produced only from within `agent-harness/modes/IMPROVING-HARNESS.md` — see that
file for the behavioral rules governing when and how a harness change may be made.

## Artifact Story

A harness/process-flavored Review finding identifies a recurring problem. The agent drafts an Improvement
describing the problem, root cause, and proposed change, and cites that Review in `source_ids`. The user reviews
the proposed change and explicitly approves it; only then does the agent apply the target-file changes and record
what was validated. Once every Improvement citing the originating Review reaches a terminal status, that Review
itself closes.

## Entry / Creation Paths

An explicit direct request to improve the harness may create the required process Review and proposed Improvement
artifacts in the same transaction. It does not approve any proposed Improvement or authorize target-file changes.

Created only from within Improving-Harness mode (`agent-harness/modes/IMPROVING-HARNESS.md`).

## Sources

An Improvement is created only from a harness/process-flavored Review finding
(`agent-harness/artifact-specs/REVIEW.md`) — never from Partnering.

## When To Create

Whenever a harness/process-flavored Review reaches `outcome: follow-up-required` — see
`agent-harness/modes/IMPROVING-HARNESS.md`'s `## When To Use` for the symptoms that motivate writing that Review
finding in the first place.

## When Not To Create

Never create an Improvement artifact from Partnering (`IMPROVING-HARNESS.md`'s `IMPR-02-040`), and never apply
its target-file changes before the user has explicitly approved that specific Improvement (`IMPR-02-025`/
`IMPR-02-027`).

## Artifact Shape

`target_files` in frontmatter lists every file the Improvement may change — required (`IMPROVING-HARNESS.md`'s
`IMPR-02-030`). `approval.approved_by`/`approved_at` record the explicit `proposed` → `approved` transition
(`IMPROVING-HARNESS.md`'s `IMPR-02-026`).

## Field Semantics

- `status` — `proposed | approved | in-progress | done | rejected | archived`; see `## Lifecycle`.
- `source_ids` — the originating Review ID(s); see `## Relationships`.

## Body Should Include

- Problem
- Root Cause
- Proposed Change
- Expected Impact
- Validation
- Validation Result

## Lifecycle

The file remains at its stable v2 path for every status. `## Validation` stays the validation plan or checklist;
`## Validation Result` is added with the date, checks performed, and outcome before the Improvement is set to
`done` (`IMPR-03-010`/`IMPR-03-020`). If a validation item is prospective and cannot be fully proven yet,
state that explicitly instead of treating it as completed evidence (`IMPR-03-030`).

## Readiness / Acceptance

`status: proposed -> approved` is a distinct, user-only gate. Set `in-progress` before the first approved target
mutation; set `done` only after validation. Meeting the validation conditions must never substitute for approval
(`IMPR-03-050`).

## Relationships

This Improvement MUST cite every originating Review in `source_ids` (`IMPR-04-010`). When its status transitions
to `done` or `rejected`, resolve each source Review per `REVIEW.md`'s `RVW-06-010` if every Improvement citing
that Review is terminal. Derive those backlinks by scanning `source_ids`; do not author reverse metadata on the
Review (`IMPR-04-020`/`IMPR-04-030`).

## Output / Location

`harness-data/artifacts/improvements/IMPROVEMENT-*.md`; status changes update this stable file in place.

## Template

Use `agent-harness/templates/IMPROVEMENT-template.md` as the starting point for every new Improvement artifact.

## Examples

`REVIEW-0052` finds that mode files mix workflow prose with enforceable rules. The agent drafts
`IMPROVEMENT-0117`, cites `REVIEW-0052` in `source_ids`, waits for explicit approval, applies the approved rewrite,
records the validation result, and — once every Improvement citing that Review is terminal — resolves the Review.

## Rules

| ID | Rule |
| --- | --- |
| IMPR-00-010 | MAY create a process Review and proposed Improvement artifacts in one transaction for an explicit harness-improvement request, but MUST NOT treat that request as approval or target-file authorization. |
| IMPR-03-010 | MUST keep `## Validation` as the validation plan or checklist. |
| IMPR-03-020 | MUST add `## Validation Result` with the date, checks performed, and outcome before an Improvement artifact is set to `done`. |
| IMPR-03-030 | If a validation item is prospective and cannot be fully proven yet, MUST state that explicitly instead of treating it as completed evidence. |
| IMPR-03-040 | MUST NOT set an Improvement to `done` until the approved target changes are applied and the validation result is documented. |
| IMPR-03-050 | MUST treat user-only `proposed -> approved`, pre-mutation `approved -> in-progress`, and validated `in-progress -> done` as distinct gates. |
| IMPR-04-010 | MUST cite every originating Review in this Improvement's `source_ids` at creation time. |
| IMPR-04-020 | When this Improvement transitions to `done` or `rejected`, MUST resolve each source Review per `REVIEW.md`'s `RVW-06-010` if every Improvement whose `source_ids` cites it is terminal. |
| IMPR-04-030 | MUST perform the `RVW-06-010` resolution in the same action as this Improvement's `done`/`rejected` transition — not a separately-scheduled sweep. |

## Reference Files

None beyond the template — see `agent-harness/modes/IMPROVING-HARNESS.md`'s Reference Files for the surrounding
mode's context needs.
