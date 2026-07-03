# Test Gap Analysis

## Use When

- assessing how much confidence current tests actually provide
- deciding what to test before or after a change, not just whether to add tests
- a review or incident reveals that tests passed despite a real defect

## Do Not Use For

- writing the tests themselves
- flaky test investigation without a coverage question
- one-off unit tests for a single obvious case

## Required Inputs

- the code, change, or area under evaluation
- existing tests covering that area, if any
- the failure mode or risk being reasoned about

## Agent Procedure

1. Confirm the area, change, or risk the test gap analysis is scoped to.
2. Identify what existing tests actually assert versus what they appear to cover.
3. Enumerate the realistic failure modes: edge cases, error paths, boundary conditions, and interactions.
4. Map each failure mode to an existing test, a missing test, or a test that would not actually catch it.
5. Distinguish between missing coverage and coverage that exists but is weak or misleading.
6. Recommend the smallest set of tests or changes that would close the highest-risk gaps.

## Required Checks

- claimed coverage is checked against what the tests actually assert
- high-risk failure modes are enumerated, not just happy-path cases
- gaps are distinguished from weak or misleading existing tests
- recommendations are prioritized by risk, not exhaustive by default

## Required Output

- scope of the analysis
- failure modes considered
- confirmed coverage, weak coverage, and missing coverage
- prioritized recommendations for closing gaps

## Escalate When

- closing the gap requires infrastructure or fixtures that do not exist
- the highest-risk gap touches security, auth, data integrity, or migrations
- the analysis reveals the tested behavior itself is unclear or contested
- coverage gaps are broad enough to require a dedicated test strategy decision
