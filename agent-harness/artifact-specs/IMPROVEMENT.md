# IMPROVEMENT.md

## Purpose

An Improvement is the record of a harness change: the problem it fixes, why it happened, what changed, and how
that change was validated. It is produced only from within `agent-harness/modes/IMPROVING-HARNESS.md` — see that
file for the behavioral rules governing when and how a harness change may be made.

## Artifact Story

A harness/process-flavored Review finding identifies a recurring problem. The agent drafts an Improvement
describing the problem, root cause, and proposed change, and links it back into that Review's `follow_up` field
immediately — not deferred until approval. The user reviews the proposed change and explicitly approves it;
only then does the agent apply the target-file changes and record what was validated. Once every `follow_up`
Improvement on the originating Review reaches a terminal status, that Review itself closes.

## Entry / Creation Paths

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
- `source` — the originating Review ID(s); see `## Relationships`.
- `follow_up` (on the source Review, not this artifact) — this Improvement's own ID is added there at creation
  time (`IMPR-04-010`).

## Body Should Include

- Problem
- Root Cause
- Proposed Change
- Expected Impact
- Validation
- Validation Result

## Lifecycle

`active/` while drafting or in progress; `done/` once the approved target changes are applied and the validation
result is documented (`IMPR-03-040`). `## Validation` stays the validation plan or checklist; `## Validation
Result` is added with the date, checks performed, and outcome before the Improvement is set to `done` or moved
to `done/` (`IMPR-03-010`/`IMPR-03-020`). If a validation item is prospective and cannot be fully proven yet,
state that explicitly instead of treating it as completed evidence (`IMPR-03-030`).

## Readiness / Acceptance

`status: proposed -> approved` is a distinct, user-only gate from the `approved -> done` validation gate — see
`IMPROVING-HARNESS.md`'s `IMPR-02-025`. Meeting the validation conditions for `done` must never be treated as
substituting for that separate approval (`IMPR-03-050`).

## Relationships

This Improvement's own ID MUST be added to the `follow_up` field of every Review in `source`, at creation time —
not deferred until approval or `done` (`IMPR-04-010`). When this Improvement's `status` transitions to `done` or
`rejected`, resolve each `source` Review per `REVIEW.md`'s `RVW-06-010` if every `follow_up` Improvement is now
terminal — performed in the same action as this Improvement's `done`/`rejected` transition, not a separately
scheduled sweep (`IMPR-04-020`/`IMPR-04-030`).

## Output / Location

`harness-data/artifacts/improvements/active/IMPROVEMENT-*.md` while drafting or in progress; `done/` once the
`IMPR-03-040` conditions are met (approved changes applied, validation result documented). See
`agent-harness/OUTPUTS.md` for the full lifecycle-folder rules.

## Template

Use `agent-harness/templates/IMPROVEMENT-template.md` as the starting point for every new Improvement artifact.

## Examples

`REVIEW-0052` finds that mode files mix workflow prose with enforceable rules. The agent drafts
`IMPROVEMENT-0117`, adds its ID to `REVIEW-0052`'s `follow_up` immediately, waits for explicit approval, applies
the approved rewrite, records the validation result, and — once every other `follow_up` Improvement on that
Review also reaches a terminal status — resolves the Review itself.

## Rules Map

This contract's enforceable rules live in `agent-harness/rules/artifact-specs/IMPROVEMENT.md` (single paired
file — under the 25-rule grouping threshold). Load it whenever drafting, approving, applying, or validating an
Improvement. See also `agent-harness/modes/IMPROVING-HARNESS.md`'s own Rules Map for the behavioral (Scope/
Boundaries/Rule-ID-Audit) rules governing the surrounding mode activity.

## Reference Files

None beyond the template — see `agent-harness/modes/IMPROVING-HARNESS.md`'s Reference Files for the surrounding
mode's context needs.
