# Harness v1 Behavioral Baseline

Recorded: 2026-08-29  
Harness version: pre-v2, template commit `6b058d5`  
Evaluator: Codex manual scenario review

## Deterministic Baseline

The existing conformance checker passed its structural checks at the recorded template commit. The citation audit
found no duplicate rule definitions or dangling cited IDs. These checks establish structure only; they do not
prove semantic routing.

## Observed Cost and Safety Profile

The baseline has strong explicit approval, high-risk, traceability, and resumability controls. Its known cost is
fixed ceremony: even a small Plan-tier request commonly creates a persistent Plan, readiness evidence, approval
metadata, lifecycle movement, catalog activity, and validation routing. The portable harness had approximately
8,471 Markdown lines, 595 rule IDs, 52 hand-maintained wrappers, and 42 empty lifecycle directories.

## Scenario Result Ledger

| Scenario | Minimum v1 route | Safety result | Ceremony/cost observation | Semantic review |
| --- | --- | --- | --- | --- |
| fast-documentation | Plan-tier persistent Plan | no premature code path | persistent lifecycle required | pass, costly |
| standard-bugfix | Spec/Task/Plan as classified | explicit approval and evidence gates | multiple artifacts may duplicate execution data | pass, costly |
| ambiguous-feature | Partnering → refinement chain | ambiguity is retained and routed | broad durable chain | pass |
| cross-service-contract | UC/Spec/Task/Plan | contract scope is traceable | high but appropriate ceremony | pass |
| database-migration | high-risk chain | high-risk coverage required | high ceremony appropriate | pass |
| security-sensitive-change | high-risk chain | approval/scope controls required | high ceremony appropriate | pass |
| interrupted-resume | active artifact + checkpoint | restart facts are durable | repeated context joins | pass |
| material-scope-change | reset/reconsideration path | stale descendants are reconsidered | classification freshness is weak | finding |
| overlapping-work | catalog/Plan conflict check | conflict is detected before promotion | manual catalog maintenance | pass |
| harness-improvement | Review → Improvement | exact approval is explicit | redundant intake hop | finding |

## Baseline Limits

This is a documented qualitative baseline, not fabricated token telemetry. Future evaluator runs record elapsed
time and client-provided context/token metrics when available; unavailable telemetry is marked `not exposed`.
The semantic judgments above are manual and remain distinct from deterministic script results.
