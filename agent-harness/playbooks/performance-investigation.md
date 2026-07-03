# Performance Investigation

## Use When

- reported latency, throughput, or resource-usage regression
- a change is suspected to have made something slower or heavier
- confirming whether a performance concern is real before optimizing

## Do Not Use For

- functional bugs without a performance symptom
- premature optimization without an observed or measured problem
- capacity planning or infrastructure sizing decisions

## Required Inputs

- the observed performance symptom and its impact
- available measurements: timings, profiles, resource metrics, or benchmarks
- the suspected area, change, or code path

## Agent Procedure

1. Confirm the performance symptom is measured, not just perceived, and establish a baseline if one exists.
2. Reproduce the symptom under conditions close to where it was observed.
3. Narrow the suspect area using profiling, timing, or resource evidence rather than guesswork.
4. Identify the likely bottleneck: algorithmic complexity, I/O, contention, memory, or external dependency.
5. Estimate the impact of a fix before recommending it, and check for correctness tradeoffs.
6. Recommend the smallest safe next action: targeted fix, deeper profiling, or escalation.

## Required Checks

- the symptom is backed by a measurement, not only a subjective impression
- the suspected bottleneck is supported by evidence
- any proposed fix's expected impact is stated
- correctness or safety tradeoffs of the fix are called out

## Required Output

- summary of the performance symptom and measured impact
- reproduction conditions or reproduction gap
- identified bottleneck and supporting evidence
- expected impact and tradeoffs of the recommended fix
- recommended next action

## Escalate When

- the bottleneck spans infrastructure or systems outside the repo
- reproduction requires production-scale data or load that is not available
- the fix would trade correctness, safety, or maintainability for speed
- the regression touches high-risk areas such as auth, payments, or migrations
