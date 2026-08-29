# CHANGE-SPEC.md

## Purpose

A Change Spec is the single durable execution contract for Standard-lane work. It combines bounded intent,
non-goals, preserved behavior, paths, executable steps, approval, and acceptance-to-evidence mapping.

## Required Shape

Frontmatter: `id`, `type: change-spec`, `status`, `lane: standard`, `source`, `related`, `risk`,
`allowed_paths`, `forbidden_paths`, approval provenance with content hash, and `verification_result`. Body: Problem/Goal, Expected
Change, Behavior to Preserve, Scope, Non-Goals, Requirements, Acceptance Criteria, Evidence Map, Dependencies
and Risks, Plan Steps, Open Questions, Execution Progress, and Closeout.

## Lifecycle

Change Specs use the same lifecycle as Use Cases, Specs, and Tasks: `draft -> ready -> in-progress -> done`.
`blocked` remains in `active/`; `archived` and `rejected` move to `archive/`. One explicit current-content approval
moves it to `ready`; material input changes stale approval and require reclassification per Work Lanes.

## Relationships

Use Cases, Tasks, Plans, Transcripts, Ideas, and Reviews are optional: create one only when it supplies reused
behavioral authority, independent ownership/lifecycle, durable provenance/backlog, or findings/handoff value.

## Rules

| ID | Rule |
| --- | --- |
| CHG-01-010 | MUST use a Change Spec as the default durable execution contract for Standard work. |
| CHG-01-020 | MUST record expected and preserved behavior, scope, non-goals, paths, steps, approval provenance, and acceptance-to-evidence mapping. |
| CHG-01-030 | MUST NOT move a Change Spec to `ready` without explicit approval tied to current content hash/blob. |
| CHG-01-040 | MUST stale approval and return to `draft` when `LAN-01-050-v1` material inputs change. |
| CHG-01-041 | MUST use only `draft`, `ready`, `in-progress`, `blocked`, `done`, `archived`, and `rejected` for a Change Spec; `blocked` remains in `active/`, and `archived` or `rejected` moves to `archive/`. |
| CHG-01-050 | MUST identify requirements and acceptance criteria with stable local IDs and map every acceptance criterion to planned verification evidence before moving to `ready`. |
| CHG-01-060 | MUST record execution progress and closeout evidence in the Change Spec; a clean routine self-review MUST be recorded there rather than creating a Review. |
| CHG-01-070 | MUST reference a separately created Use Case, Task, Plan, Transcript, Idea, or Review only when that artifact satisfies its own conditional-creation rule. |
