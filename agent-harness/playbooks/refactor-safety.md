# Refactor Safety

## Use When

- restructuring code without an intended behavior change
- extracting, renaming, or reorganizing logic across files or modules
- consolidating duplication or simplifying structure

## Do Not Use For

- changes that intentionally alter behavior
- structural repo or file-layout changes without code-level restructuring
- new feature work mixed with restructuring

## Required Inputs

- the code being refactored and its current behavior
- existing tests covering that behavior
- the intended structural outcome

## Agent Procedure

1. Confirm the refactor is behavior-preserving in intent and scope.
2. Establish the pre-refactor behavior baseline: existing tests, observable outputs, or manual checks.
3. Apply the structural change in the smallest safe increments.
4. Re-run the baseline after each increment to confirm behavior is unchanged.
5. Check for subtle drift: changed defaults, altered ordering, dropped edge-case handling, or changed error behavior.
6. Confirm test coverage was preserved or improved, not incidentally weakened by the restructuring.

## Required Checks

- behavior baseline is established before changes begin
- baseline still holds after the refactor
- no incidental behavior drift is introduced
- test coverage is preserved or improved, not reduced

## Required Output

- summary of the structural change and its intended scope
- baseline used to confirm behavior preservation
- confirmation that behavior is unchanged, or exact points of drift found
- test coverage impact

## Escalate When

- behavior cannot be verified as unchanged with available tests or evidence
- the refactor touches high-risk areas such as auth, payments, or migrations
- the scope grows to include actual behavior changes
- preserving current behavior conflicts with the intended structural outcome
