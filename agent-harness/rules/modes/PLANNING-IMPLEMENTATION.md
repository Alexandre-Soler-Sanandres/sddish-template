# PLANNING-IMPLEMENTATION Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IPL-03-010 | Boundaries | MUST NOT: change code; treat an upstream `draft` or Plan `draft` status as implementation authorization; or generate duplicate Tasks or skip existing ones. |
| IPL-03-020 | Boundaries | MUST consult `REFINING.md`'s Task Decision Matrix before creating an inline Implementation Plan for a Spec/Use Case with no existing Tasks and record existing Tasks' current status, dependencies, and implementation-readiness facts without treating them as Plan-creation blockers. |
| IPL-04-010 | Procedure | MUST load the relevant universal and project playbooks before finalizing the plan, when the planning task matches a reusable procedure. |
| IPL-04-020 | Procedure | MUST reflect required procedure-specific checks or validation from relevant playbooks in the Implementation Plan. |
| IPL-04-021 | Procedure | When a loaded playbook establishes preserved behavior, regression risk, or baseline evidence, the resulting Spec or Plan MUST carry that forward in its own contract sections rather than leaving it only in conversational output. |
| IPL-04-030 | Procedure | Before requesting a Plan's promotion to `ready`, Planning-Implementation MUST invoke Validation with the profile required by `VAL-00-020` and record the resulting durable report in the Plan when that profile is `chain-preflight`. |
| IPL-04-031 | Procedure | Planning-Implementation MUST NOT treat local artifact readiness alone as sufficient when `VAL-00-030` requires `chain-preflight` for the selected chain. |
| IPL-05-030 | Parallel-Work | MUST NOT allow more than one Implementation Plan at status `ready` or `in-progress` per Spec. For a Plan-tier Plan with `entrypoint_type: none` (no source Spec), this check does not apply — there is no Spec to key it on. |
| IPL-05-031 | Parallel-Work | For a Plan-tier Plan, `IPL-05-050`'s path-overlap check is the only dedup protection available, so it MUST still be run. |
| IPL-05-040 | Parallel-Work | Plans on non-overlapping Specs MAY run concurrently without restriction — the check in `IPL-05-010` only ever blocks on the same Spec or overlapping `allowed_paths`. |
| IPL-05-050 | Parallel-Work | MUST stop, surface the conflict, list both Plan IDs and overlapping paths, and wait for explicit user resolution, if two active Plans have overlapping `allowed_paths` across their Tasks. |
| IPL-05-051 | Parallel-Work | For a Plan-tier Plan with no Task artifacts, substitute the Plan's own Plan Steps' declared file paths (`## Plan Steps`, `Expected files:`) for "Tasks" `allowed_paths` in `IPL-05-050`'s comparison — the check MUST still run against every other active Plan's Task `allowed_paths` or, symmetrically, their own Plan Steps' file paths if they are also Plan-tier. |
| IPL-07-010 | Scaffold-Check | Before finalizing Implementation Plan steps that reference file paths implied by a structural/foundational accepted ADR (directory layout, workspace/build config, deployment topology), MUST verify those paths/structures actually exist in the repository via a direct filesystem check, not an assumption from the ADR text. |
| IPL-07-011 | Scaffold-Check | If `IPL-07-010`'s check finds a path/structure missing, MUST add an explicit bootstrap step covering only what the plan's own steps need, not a general build-out of everything the ADR describes. |
| IPL-07-020 | Scaffold-Check | Before finalizing an Implementation Plan, MUST verify that any tooling a step's own `## Validation` commands invoke (lint/type-check/test runners, etc.) is provisioned by an earlier step in the same Plan (config present, declared as a dependency) rather than assumed available. |
| IPL-07-021 | Scaffold-Check | If `IPL-07-020`'s check finds provisioning missing, MUST add it to the bootstrap step (or the earliest step that needs it), scoped to only what the plan's own steps actually invoke. |
| IPL-08-010 | Plan-Tier-Entry | When entered by a direct natural-language instruction with no Use Case/Spec/Task file named: if the request (or its cited source Idea/Transcript) already carries a `## Risk-Tier Classification` — whether complete or partial, since Partnering may already have resolved UC- and Spec-Necessity via `PTN-02-110` before routing here — MUST reuse that result and continue the cascade only from its next unrun matrix, per `shared-procs/RISK-TIER.md`'s `RSK-07-011`–`RSK-07-013`. |
| IPL-08-011 | Plan-Tier-Entry | Otherwise MUST run the full cascade (`RSK-02-010` → `RSK-03-010` → `RSK-04-010`) fresh to determine the minimum required tier. This entry point is not always the first opportunity for the request — it commonly is not, since `PARTNERING.md`'s `PTN-02-110` and `REFINING.md`'s `TSK-01-030` both hand off here after already running part or all of the cascade. |
| IPL-08-020 | Plan-Tier-Entry | If the cascade lands above Plan-tier, MUST stop, report which tier is actually required, and route to the matching Refining entry point (`/create-use-case`, `/create-spec`, or `/create-tasks`). |
| IPL-08-021 | Plan-Tier-Entry | MUST NOT proceed to planning when the cascade lands above Plan-tier. |
| IPL-08-022 | Plan-Tier-Entry | If the cascade lands at Plan-tier, MUST create the Implementation Plan, including a `## Risk-Tier Classification` section (`RSK-05-010`) and setting `entrypoint_type: none` since no Task/Spec/Use Case exists. |
| IPL-08-025 | Plan-Tier-Entry | A Plan created under `IPL-08-022` MUST include the compact `## Behavior Contract` required by `IPL-01-032`/`IPL-02-014` rather than escalating to a full Spec solely to capture preserved behavior or proof intent. |
| IPL-08-026 | Plan-Tier-Entry | A direct Plan-tier entry with no higher-tier artifact chain MUST NOT fabricate `chain-preflight`; it uses the single-artifact validation path until a real UC/Spec/Task chain exists. |
| IPL-08-023 | Plan-Tier-Entry | MUST wait for approval, exactly as every other entry point already requires. |
| IPL-08-024 | Plan-Tier-Entry | MUST NOT change code before that approval, exactly as every other entry point already requires. |
