# Flaky Test Triage

## Use When

- a test passes and fails without intentional code changes
- CI instability points to nondeterministic behavior
- repeated reruns are masking the real problem

## Do Not Use For

- a consistently failing test with a stable reproduction
- a known product bug that the test is correctly exposing
- broad test-suite redesign

## Required Inputs

- failing test name and path
- recent failure output or CI evidence
- relevant environment, timing, or dependency context

## Agent Procedure

1. Confirm that the test is actually flaky rather than consistently broken.
2. Reproduce the instability with repeated focused runs when possible.
3. Classify the likely flake type: timing, shared state, ordering, environment, network, data, or async behavior.
4. Narrow the trigger: setup, teardown, fixture, concurrency, clock, randomness, or external dependency.
5. Check whether the test or the production code owns the instability.
6. Recommend the smallest safe next action: fix test, fix product code, isolate dependency, or quarantine with explicit reason.

## Required Checks

- the instability pattern is described
- the likely flake category is named
- evidence shows why the test is flaky or why that remains unproven
- any quarantine recommendation is justified and limited

## Required Output

- flaky test identifier
- reproduction pattern or reproduction gap
- likely flake category and evidence
- probable owner of the issue
- recommended next action

## Escalate When

- the flake depends on infrastructure outside the repo
- reproductions require long-running or expensive environments
- many tests show the same instability pattern
- quarantine would hide a high-risk product issue
