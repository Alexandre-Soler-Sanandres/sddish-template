---
id: TASK-0001
type: task
status: draft            # draft | ready | in-progress | done | blocked | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
area: ""                 # domain area, e.g. user-management | payments | reporting
source: []               # e.g. [SPEC-0001]
related: []              # e.g. [ADR-0005] — accepted ADRs this Task depends on; see TASKS.md's TSK-05-010
depends_on: []           # e.g. [TASK-0000]
blocks: []               # e.g. [TASK-0002]
risk: low                # low | medium | high
estimated_size: small    # small | medium | large
approval:
  required: true
  approved_by: null
  approved_at: null       # YYYY-MM-DD
allowed_paths: []        # paths the agent may modify
forbidden_paths: []      # paths the agent must not touch
validation:
  - ""                   # e.g. uv run pytest apps/myapp/tests/
tags: []
---

## Goal

(what this task achieves)

## Scope

(what files and areas are in scope)

## Non-Goals

(what this task explicitly does not do — permanent exclusion by default; for a deferred/not-now item, add a
forward pointer: `(deferred, see IDEA-NNNN)` for a candidate feature, or `(deferred, see Q-NNNN)` for a genuinely
unresolved direction question — see `agent-harness/artifact-specs/IDEA.md`'s `IDA-04-010`/
`agent-harness/artifact-specs/QUESTIONS.md`'s `QST-06-010` for which applies)

## Implementation Notes

(any relevant hints, patterns or constraints for implementation)

## Validation

(describe how to verify this task is complete, beyond the commands in frontmatter)

## Risk-Tier Classification

(optional — filled in only when this Task was entered via `shared-procs/RISK-TIER.md`'s Spec-skip path; see
`TASKS.md`'s `TSK-02-025`)

## Readiness Checklist

Before advancing to `ready`, verify all items are checked. Cite a one-line evidence pointer per checked item
beneath the checklist — see `rules/artifact-specs/TASKS.md`'s `TSK-02-012`.

- [ ] Source Spec is approved (or, if entered via the Spec-skip path, `## Risk-Tier Classification` section is present and complete)
- [ ] Goal is specific enough to implement
- [ ] allowed_paths are defined
- [ ] Validation commands are specified
- [ ] No unresolved blocking dependencies
- [ ] Accepted ADRs checked for scope-relevant area tags; matches cited or explicitly ruled out
- [ ] If this Task adds/changes a route or an external dependency, health/readiness-check accuracy verified against this project's accepted health-check convention ADR, if one exists (or explicitly not applicable)
- [ ] The user has explicitly confirmed this specific Task's readiness (not inferred from discussion or a general instruction to proceed) — per `TASKS.md`'s `TSK-02-015`
