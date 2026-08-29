# Work Lanes

## Purpose

Classify a material work scope before planning or execution so assurance is proportional to ambiguity,
reversibility, boundary impact, and risk. A lane is recorded once per unchanged material scope and is invalidated
when behavior, non-goals, owners, contracts, persistence, deployment, reversibility, paths, or risks change.

## Lanes

| Lane | Use when | Execution contract | Persistence |
| --- | --- | --- | --- |
| Fast | local, reversible, bounded, unambiguous work with evident verification and no hard floor | stated in-session micro-plan: target, delta, preserved behavior, check | none unless handoff requested |
| Standard | bounded multi-step or meaningful behavior work with reversible risk | approved Change Spec with scope, non-goals, acceptance/evidence mapping | one durable work package |
| Assured | ambiguity, cross-owner/service boundary, public contract, hard-to-reverse effect, or a hard floor | approved behavior contract plus resumable Execution Plan | full relevant traceability and evidence |

## Hard Floors

Database/schema or destructive-data work; deployment/infrastructure/CI-CD; public API/data contracts;
security/secrets/auth; payment or financial execution; domain-critical logic; and major architecture changes are
always Assured. Effort, urgency, agent convenience, or token budget cannot lower a lane.

## Approval and Reclassification

Fast begins only when the user's direct imperative covers the stated micro-plan exactly. Standard and Assured
require explicit approval tied to the current content hash/blob and recorded approver/time. A material input
change invalidates the classification and any Standard/Assured approval; stop, reclassify, and obtain fresh
approval before further planning or implementation. Cosmetic edits do not invalidate it.

## v1 Compatibility

New work uses these lanes. Existing active v1 UC/Spec/Task/Plan chains remain under their recorded v1 contract
until reopened or explicitly migrated; `harness-data/HARNESS-PROFILE.yaml` records that boundary.
