# Bug Investigation

## Use When

- reproducing a reported bug
- narrowing an unexpected behavior
- preparing a safe fix recommendation

## Do Not Use For

- flaky tests that already have strong evidence of instability
- performance-only issues without a functional bug
- code review without a concrete failure or symptom

## Required Inputs

- bug report, failing behavior, or user complaint
- affected area, command, path, or feature
- available evidence such as logs, screenshots, or failing tests

## Agent Procedure

1. Confirm the reported symptom, expected behavior, and current impact.
2. Reproduce the issue with the smallest reliable setup possible.
3. Narrow the scope: identify the component, input, state, or recent change involved.
4. Separate observed facts from hypotheses.
5. Trace the failure path until the likely cause is isolated or the search boundary is clear.
6. Check for nearby regressions, hidden side effects, and missing coverage.
7. Propose the smallest safe next step: fix, deeper investigation, or escalation.

## Required Checks

- reproduction is explicit or the reason it could not be reproduced is explicit
- likely cause is backed by evidence, not guesswork
- affected scope and risk are stated
- missing validation or missing evidence is stated

## Required Output

- summary of the bug and expected behavior
- reproduction steps or reproduction gap
- current evidence and likely cause
- affected paths or components
- recommended next action

## Escalate When

- the bug cannot be reproduced and evidence is too weak
- the likely cause crosses ownership or system boundaries
- the issue touches security, auth, data integrity, or migrations
- a fix would require broad structural change beyond the current scope
