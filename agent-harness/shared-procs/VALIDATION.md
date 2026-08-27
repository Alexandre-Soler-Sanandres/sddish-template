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

Validation uses one of three explicit profiles. Choose the profile first, then run the checks that profile
requires (`VAL-00-010`/`VAL-00-020`/`VAL-00-030`):

- `artifact-readiness` — single-artifact gate checks before promotion or acceptance
- `chain-preflight` — read-only cross-artifact consistency analysis before Plan promotion
- `implementation-result` — post-implementation reconciliation of code, evidence, and approved scope

Wrappers may infer the profile only when the target and current phase make one choice unambiguous; otherwise they
must stop and request the missing target or phase (`VAL-00-040`/`VAL-00-050`).

### `artifact-readiness`

Use for one artifact's local gate. This profile checks artifact completeness and the evidence that is actually
available before implementation:

**Artifact validation** — required frontmatter fields present and filled; status appropriate for the current
stage; traceability links (`source`, `derived_*`, `related`) present and synchronized where required; ID stable
and following naming conventions; body sections complete, not left as placeholders (`VAL-01-010`–`050`).

**Process validation** — the artifact's creation was permitted by `shared-procs/RISK-TIER.md`'s Necessity cascade
for its tier, OR its own `## Risk-Tier Classification` section documents a valid skip (`VAL-02-010`) — a parent
artifact's own status is not itself a creation precondition (`IMPROVEMENT-0129`); an Implementation Plan is
`ready` before implementation starts, and implementation never happened before that (`VAL-02-020`/`VAL-02-030`);
Specs/Tasks were never created from Partnering mode (`VAL-02-040`); `CORE.md`'s `COR-09-010` high-risk handling
(scope and validation coverage, plus approval coverage for payments) was followed for any high-risk area touched
(`VAL-02-050`).

**Behavioral validation** — each acceptance criterion met and verifiable (`VAL-03-010`); `test_refs` in the Spec
frontmatter populated with a credible planned evidence mapping, not invented future test files (`VAL-03-020`);
each acceptance criterion traceable to that planned evidence or to a Task/Plan validation command
(`VAL-03-030`); non-goals not implemented, scope not drifted beyond what was planned (`VAL-03-040`/
`VAL-03-050`).

**Readiness checks** — before moving to the next stage, verify: no open `changes-requested` or `rejected` review
findings, all blockers resolved, dependent artifacts at an accepted status (`VAL-04-010`).

### `chain-preflight`

Use only before Plan promotion. This profile is read-only across the selected Use Case/Spec/Task/Plan chain and
produces findings for Planning to record in the Plan's `## Chain Preflight` section (`VAL-00-030`/`VAL-06-021`).

Check the selected chain for bidirectional ID consistency, requirement/acceptance coverage, Task and Plan-step
coverage, dependency order, allowed/expected-path consistency, ADR application, unresolved Questions,
non-goal conflicts, risk coverage, and validation-command coverage (`VAL-02-061`-`VAL-02-069`). Record the
profile used, run date/time, pass/fail outcome, checked artifact IDs and paths, each checked artifact's
`updated` value, and git blob/hash when available. If any participating artifact changes after that run, the
report is stale and must be rerun before promotion (`VAL-04-020`/`VAL-04-021`).

Validation itself does not write that section; Planning owns the durable report. If findings need an independent
durable record, create or update a Review and cite it from the Plan (`VAL-06-022`).

### `implementation-result`

Use after implementation work exists. This profile reconciles the actual implementation against the approved
scope and evidence:

**Process validation** — the actual code changes (via `git log`/`git diff`) reconcile against the `ready` Plan's
`allowed_paths` and steps, flagging any file changed outside `allowed_paths` or any change with no corresponding
step as a finding (`VAL-02-060`); the Implementation Plan was `ready` before implementation started and work did
not happen before that (`VAL-02-020`/`VAL-02-030`).

**Behavioral validation** — each acceptance criterion met and verifiable (`VAL-03-010`); when tests are the
chosen evidence, `test_refs` in the Spec frontmatter populated, containing only existing test file paths
(`VAL-03-021`); each acceptance criterion traceable to an existing `test_refs` entry, a named validation
command, or justified manual evidence (`VAL-03-031`); non-goals not implemented, scope not drifted beyond what
was planned (`VAL-03-040`/`VAL-03-050`); technical checks confirmed to have run during Implementation, not
re-run here (`VAL-03-060`).

Manual review is the primary verification mechanism by design, not a fallback for missing automation — document
what was checked and the outcome (`VAL-05-010`). Validation never implements or changes code, never modifies
artifacts beyond updating their status, never skips a step without explicit approval, and never executes or runs
technical checks/tests directly — it confirms via `VAL-03-060` that they ran during Implementation instead
(`VAL-06-010`–`040`). When a relevant playbook defines required checks or outputs for the work under validation,
verify those were followed; a playbook may refine what to verify for a task shape, but Validation retains
ownership of the validation decision and boundaries (`VAL-07-010`/`VAL-07-020`, `COR-04-070`).

## Output

Output depends on profile:

- `artifact-readiness` — report pass/fail and findings to the invoking mode or wrapper
- `chain-preflight` — return a read-only report for Planning to record in the Plan's `## Chain Preflight`
  section; cite a Review only when an independent durable record is needed
- `implementation-result` — report findings in the relevant closeout surface, such as a Review artifact or plan
  execution notes

Use `agent-harness/templates/REVIEW-template.md` when a formal review record is needed.

## Examples

Before promoting a Plan, Planning runs Validation with the `chain-preflight` profile: Validation checks the
selected chain for contradiction, coverage, path, ADR, Question, and validation-command issues, then returns a
read-only report for the Plan's `## Chain Preflight` section.

After an Implementing-mode plan step completes, the agent runs Validation with the `implementation-result`
profile: confirms the step's acceptance criteria are covered by existing `test_refs`, named validation commands,
or justified manual evidence, reconciles the actual diff against `allowed_paths`, and confirms no scope drift
without re-running the technical checks itself.

## Rules Map

This procedure's enforceable rules live in `agent-harness/rules/shared-procs/VALIDATION.md` (single paired
file — under the 25-rule grouping threshold). Load it alongside this file whenever running Validation.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when validating scope or structural boundaries
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
- `harness-data/reference/DOMAIN.md` — when validating domain-critical behavior
