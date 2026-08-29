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
