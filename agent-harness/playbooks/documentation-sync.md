# Documentation Sync

## Use When

- code, commands, or structure changed and related docs may now be stale
- reconciling docs with actual current behavior after drift is suspected
- a review or task surfaces a doc that no longer matches reality

## Do Not Use For

- writing new documentation for genuinely new behavior with no prior doc
- structural moves or renames themselves (see repo-structure-change.md for the move itself)
- stylistic-only editing with no factual drift

## Required Inputs

- the change or area suspected of causing doc drift
- the docs believed to reference that area
- the current actual behavior, command, or structure to reconcile against

## Agent Procedure

1. Confirm the change or area that may have caused documentation drift.
2. Identify all docs that describe that behavior, command, or structure.
3. Compare each doc's claims against current actual behavior.
4. Classify each mismatch: stale fact, stale example, stale path/command, or missing update.
5. Update docs to match reality, keeping unrelated content untouched.
6. Check for duplicated or conflicting descriptions of the same behavior across docs.

## Required Checks

- every identified doc was actually compared against current behavior, not assumed correct
- each mismatch is classified, not just silently fixed
- updates do not introduce new drift or contradict other docs
- unrelated content was left unchanged

## Required Output

- area or change that triggered the sync
- docs checked and mismatches found
- updates made per mismatch
- any remaining drift that was out of scope

## Escalate When

- the authoritative source of truth for the behavior is itself unclear
- multiple docs disagree and resolving the conflict requires a product or design decision
- the drift is broad enough to suggest a documentation restructuring, not a sync
- the doc governs approval gates, lifecycle rules, or core harness semantics
