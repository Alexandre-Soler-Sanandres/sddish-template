# VALIDATION.md

## Purpose

Validation checks artifacts, plans, and implementations against process and behavioral criteria — did we follow
the process, and is the behavior verifiable? Technical checks are Implementing's responsibility instead — did we
run the actual project checks? — guided by `harness-data/reference/QUALITY.md` and
`harness-data/reference/TOOLING.md` (`VAL-03-060`/`VAL-06-040`).

## Invoked By

- Implementing (`agent-harness/modes/IMPLEMENTING.md`) — as its own closing gate, after each plan step.
- Improving-Harness (`agent-harness/modes/IMPROVING-HARNESS.md`) — as part of its own change process.

Also entered directly:

- Via CLI: `/validate`
- Via natural language: explicit instruction to validate a specific artifact, plan step, or implementation.

## Procedure

Validation covers four areas, in no fixed order — use whichever the target artifact or change actually needs:

**Artifact validation** — required frontmatter fields present and filled; status appropriate for the current
stage; traceability links (`source`, `derived_*`, `related`) present and synchronized where required; ID stable
and following naming conventions; body sections complete, not left as placeholders (`VAL-01-010`–`050`).

**Process validation** — the artifact's creation was permitted by `shared-procs/RISK-TIER.md`'s Necessity cascade
for its tier, OR its own `## Risk-Tier Classification` section documents a valid skip (`VAL-02-010`) — a parent
artifact's own status is not itself a creation precondition (`IMPROVEMENT-0129`); an Implementation Plan is
`ready` before implementation starts, and implementation never happened before that (`VAL-02-020`/`VAL-02-030`);
Specs/Tasks were never created from Partnering mode (`VAL-02-040`); `CORE.md`'s `COR-09-010` high-risk handling
(scope and validation coverage, plus approval coverage for payments) was followed for any high-risk area touched
(`VAL-02-050`); the actual code changes (via `git log`/`git diff`) reconcile against the `ready` Plan's
`allowed_paths` and steps, flagging any file changed outside `allowed_paths` or any change with no corresponding
step as a finding (`VAL-02-060`).

**Behavioral validation** — each acceptance criterion met and verifiable (`VAL-03-010`); `test_refs` in the Spec
frontmatter populated, containing only existing test file paths (`VAL-03-020`); each acceptance criterion
traceable to a `test_refs` entry or a Task validation command (`VAL-03-030`); non-goals not implemented, scope
not drifted beyond what was planned (`VAL-03-040`/`VAL-03-050`); technical checks confirmed to have run during
Implementation, not re-run here (`VAL-03-060`).

**Readiness checks** — before moving to the next stage, verify: no open `changes-requested` or `rejected` review
findings, all blockers resolved, dependent artifacts at an accepted status (`VAL-04-010`).

Manual review is the primary verification mechanism by design, not a fallback for missing automation — document
what was checked and the outcome (`VAL-05-010`). Validation never implements or changes code, never modifies
artifacts beyond updating their status, never skips a step without explicit approval, and never executes or runs
technical checks/tests directly — it confirms via `VAL-03-060` that they ran during Implementation instead
(`VAL-06-010`–`040`). When a relevant playbook defines required checks or outputs for the work under validation,
verify those were followed; a playbook may refine what to verify for a task shape, but Validation retains
ownership of the validation decision and boundaries (`VAL-07-010`/`VAL-07-020`, `COR-04-070`).

## Output

Validation findings should be documented as part of a Review artifact or inline in the plan step summary. Use
`agent-harness/templates/REVIEW-template.md` when a formal review record is needed.

## Examples

After an Implementing-mode plan step completes, the agent runs Validation: confirms the step's acceptance
criteria are covered by `test_refs` or a Task validation command, reconciles the actual diff against
`allowed_paths`, and confirms no scope drift — then reports findings inline in the plan step summary rather than
re-running the technical checks itself.

## Rules Map

This procedure's enforceable rules live in `agent-harness/rules/shared-procs/VALIDATION.md` (single paired
file — under the 25-rule grouping threshold). Load it alongside this file whenever running Validation.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when validating scope or structural boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/DOMAIN.md` — when validating domain-critical behavior
