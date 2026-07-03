# Code Review

## Use When

- reviewing code changes before acceptance
- checking an implementation against its approved plan
- producing formal review findings

## Do Not Use For

- writing or implementing fixes
- reviewing non-code artifacts only
- broad architecture redesign without a concrete change set

## Required Inputs

- changed files or diff
- approved plan, task, or spec when applicable
- available tests, validation results, or reproduction evidence

## Agent Procedure

1. Confirm the review target and scope.
2. Check whether the change matches the approved plan and stated intent.
3. Review correctness first: logic, edge cases, failure paths, and regressions.
4. Review safety next: state changes, data handling, auth, config, migrations, and external effects.
5. Review quality next: tests, missing tests, docs, naming, and maintainability.
6. Record findings in severity order with file references.
7. If no findings remain, state that explicitly and note residual risks or test gaps.

## Required Checks

- changed behavior matches the intended scope
- failure and edge paths are covered or called out
- validation is adequate for the risk level
- docs, config, commands, or contracts are updated when needed

## Required Output

- findings first
- severity ordering
- file references
- explicit note when no findings were found
- residual risks or validation gaps

## Escalate When

- no approved plan exists for implementation work that required one
- the change scope is larger than the stated intent
- high-risk areas are changed without matching validation
- review cannot be completed because key context is missing
