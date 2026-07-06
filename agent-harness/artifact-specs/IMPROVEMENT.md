# IMPROVEMENT.md

## Purpose

An Improvement is the record of a harness change: the problem it fixes, why it happened, what changed, and how
that change was validated. It is produced only from within `agent-harness/modes/IMPROVING-HARNESS.md` — see that
file for the behavioral rules governing when and how a harness change may be made.

## Sources

An Improvement is created only from a harness/process-flavored Review finding
(`agent-harness/artifact-specs/REVIEW.md`) — never from Partnering.

## Body Should Include

- Problem
- Root Cause
- Proposed Change
- Expected Impact
- Validation
- Validation Result

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPR-03-010 | Validation | Keep `## Validation` as the validation plan or checklist. |
| IMPR-03-020 | Validation | Add `## Validation Result` with the date, checks performed, and outcome before an Improvement artifact is set to `done` or moved to `done/`. |
| IMPR-03-030 | Validation | If a validation item is prospective and cannot be fully proven yet, state that explicitly instead of treating it as completed evidence. |
| IMPR-03-040 | Validation | Do not move an Improvement artifact to `done/` until the approved target changes are applied and the validation result is documented. |

## Output

- `harness-data/artifacts/improvements/active/IMPROVEMENT-*.md` while drafting or in progress; `done/` once `IMPR-03-040`'s conditions are met (approved changes applied, validation result documented). See `agent-harness/OUTPUTS.md` for the full lifecycle-folder rules.
- Use `agent-harness/templates/IMPROVEMENT-template.md` as the starting point for every new Improvement artifact.
