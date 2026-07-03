# Regression Analysis

## Use When

- behavior that previously worked has stopped working
- a recent change is suspected to have introduced a defect
- confirming whether a bug or review finding is new or pre-existing

## Do Not Use For

- first-time bugs with no prior working state
- flaky tests without a confirmed behavior change
- broad exploratory investigation without a suspected trigger

## Required Inputs

- the behavior that regressed and when it last worked
- candidate change window (commits, releases, deploys, or dates)
- available evidence such as logs, diffs, or failing tests

## Agent Procedure

1. Confirm the regressed behavior and the last known-good state.
2. Narrow the candidate change window using history, releases, or deploy timing.
3. Identify the specific commit, change, or condition that introduced the regression.
4. Verify the suspected cause by reproducing with and without it when feasible.
5. Assess blast radius: what else the same change may have affected.
6. Recommend the smallest safe next action: revert, forward fix, or deeper investigation.

## Required Checks

- the last known-good state is explicit or the reason it is unknown is explicit
- the suspected introducing change is backed by evidence, not just timing correlation
- blast radius beyond the reported symptom is considered
- the recommended action matches the confirmed risk

## Required Output

- summary of the regression and last known-good state
- identified or suspected introducing change
- supporting evidence
- blast radius assessment
- recommended next action

## Escalate When

- the candidate change window is too wide to narrow with available evidence
- the introducing change crosses ownership or system boundaries
- a revert would affect unrelated in-flight work
- the regression touches security, auth, data integrity, or migrations
