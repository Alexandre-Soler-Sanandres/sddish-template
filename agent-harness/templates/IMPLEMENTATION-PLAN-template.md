---
id: PLAN-0001
type: implementation-plan
status: draft            # draft | ready | in-progress | blocked | done | archived | rejected
title: ""
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
entrypoint_type: ""      # task | spec | use-case | none
entrypoint: ""           # e.g. SPEC-0001
source_ids: []           # e.g. [SPEC-0001]
included_ids: []         # e.g. [TASK-0001, TASK-0002]
related_adrs: []         # e.g. [ADR-0001]
question_refs: []        # e.g. [Q-0001]
risk: low                # low | medium | high
approval:
  required: true
  approved_by: null
  approved_at: null      # YYYY-MM-DD
---

## Target

(what this plan implements)

## Risk-Tier Classification

(optional — filled in only when this Plan skipped any tier per `shared-procs/RISK-TIER.md`'s cascade, including
Plan-tier direct entry with `entrypoint_type: none`; see `IMPLEMENTATION-PLAN.md`'s `IPL-01-030`)

## Behavior Contract

(required only when no Spec participates; keep this compact and state the expected change, preserved behavior, and
observable proof. Otherwise write `Not applicable — covered by SPEC-NNNN`.)

- Expected change:
- Preserved behavior:
- Observable proof:

## Scoped Parent Readiness

(required when this Plan participates in a real UC/Spec/Task chain. Account for every Task in each participating
Spec: include this Plan's Tasks and record every sibling below. Otherwise write `Not applicable — no higher-tier
chain participates`.)

- Source-chain parents and paths:
- Included Tasks:
- Recorded sibling Tasks/Specs: (ID, current status, owning Plan when known, and why nonblocking)
- Parent items used by this slice: (requirement/acceptance IDs, constraints, dependencies, risks, and behavior to preserve)
- Open Question/Review/blocker assessment:
- Full parent fan-out currently satisfied: yes / no — why:

## Chain Preflight

(required when this Plan participates in a real UC/Spec/Task chain; Planning records Validation's durable
read-only report here. Otherwise write `Not applicable — no higher-tier chain participates`.)

- Profile:
- Run at:
- Outcome:
- Checked artifacts:
- Artifact provenance:
- Findings or Review reference:

## Readiness Checks

All items must be checked before this plan may advance to `ready`. Cite a one-line evidence pointer per
checked item beneath the checklist — see `rules/artifact-specs/IMPLEMENTATION-PLAN.md`'s `IPL-02-012`.

- [ ] Required Tasks exist
- [ ] `STT-01-030` preconditions verified: this Plan's readiness and parallel-work gates pass, included Tasks pass their local gates, scoped accounting and dependencies pass, and any parent promotion is conditional on satisfied child fan-out plus fresh parent gates
- [ ] If entered with no upstream artifact per `RISK-TIER.md`'s cascade, `## Risk-Tier Classification` section is present and complete
- [ ] If no Spec participates, `## Behavior Contract` is present and complete
- [ ] If a real UC/Spec/Task chain participates, `## Chain Preflight` is present, passing, and current
- [ ] If a real UC/Spec/Task chain participates, `## Scoped Parent Readiness` is complete and current
- [ ] No blockers or unresolved dependencies
- [ ] High-risk areas identified
- [ ] Each plan step defines expected files, validation, and a suggested commit
- [ ] Structural ADR scaffolding this plan's steps depend on was verified to exist, or a bootstrap step was added
- [ ] Tooling required by this plan's own validation commands is provisioned by an earlier step, not assumed

## Included Artifacts

(list Tasks or Specs included in this plan)

## Excluded Artifacts

(list what is deliberately excluded and why)

## Plan Steps

### Step 1 — (title)

- Tasks: (TASK-XXX, TASK-YYY — or "inline" if no Task artifacts exist)
- Expected files: (list paths)
- Validation: (commands or checks)
- Risk: low / medium / high
- Suggested commit: (message)

### Step 2 — (title)

(repeat as needed — every step must define expected files, validation, and a suggested commit regardless of whether Task artifacts exist)
