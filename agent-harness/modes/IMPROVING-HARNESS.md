# IMPROVING-HARNESS.md

## Purpose

Improving-Harness mode changes the harness itself. Changes should be explicit, focused and reviewable — not
opportunistic. This is the only Mode allowed to modify `agent-harness/*`.

## Mode Story

A Review finding — never a direct request, never Partnering — identifies a recurring harness problem: a
misinterpreted template, a repeated mistake, weak acceptance criteria, missing validation. The agent drafts an
Improvement artifact describing the problem, root cause, and proposed change; waits for the user's explicit
approval of that specific Improvement; applies the approved target-file changes; and records what was validated
before marking it `done`.

## Operating Posture

Explicit and reviewable, never opportunistic — this mode exists to fix a documented, reviewed problem, not to
tidy up whatever the agent notices along the way. Approval is per-Improvement, never inferred from a general
instruction to "improve the harness."

## When To Use

Entered via CLI (`/improve-harness <review-file>`) or via an explicit natural-language instruction to improve a
harness file, template, or process rule — always triggered by a Review finding, never entered from Partnering or
any other unreviewed source. These are symptoms that motivate writing a Review finding, not direct entry
triggers — this mode is still only entered from that Review finding, never straight from noticing one of these:

- The same mistake appears more than once
- An agent misinterprets a template
- Acceptance criteria are consistently weak
- Tasks are too large
- Context loading is inefficient
- Validation rules are missing
- Review repeatedly finds the same issue
- Legacy extraction produces unreliable artifacts

## Workflow Paths

```text
Review -> Improvement artifact -> approved harness change -> validation -> updated files
```

An Improvement MAY apply approved changes by default to: any file under `agent-harness/`; `.claude/skills/harness/`,
`.agents/skills/harness/`, and `.github/agents/` (the per-agent CLI entry-point layers); and root-level
`AGENTS.md`/`CLAUDE.md`/`.github/copilot-instructions.md` (the harness's loader files) (`IMPR-01-010`). Other
files may change too when the Improvement explicitly calls for it (`IMPR-01-011`), and a change to one
entry-point layer must be mirrored across the others unless it's agent-specific (`IMPR-01-020`).

## Core Moves

1. Draft the Improvement artifact from a harness/process-flavored Review finding — never from Partnering
   (`IMPR-02-040`) — recording target files in frontmatter (`IMPR-02-030`).
2. Wait for the user to explicitly transition it from `proposed` to `approved`, including `approval.approved_by`
   /`approved_at` (`IMPR-02-026`). A general instruction to improve the harness is not approval of any specific
   `IMPROVEMENT-NNN` — approval is valid only after the user has had the chance to see that artifact's own
   proposed change (`IMPR-02-025`); never infer or self-approve it (`IMPR-02-020`).
3. Apply the target-file changes only after that specific approval exists (`IMPR-02-027`).
4. When the Improvement touches rule IDs or Rules-table placement, run the `COR-10-060`–`COR-10-063` citation
   audit before setting the Improvement to `done` (`IMPR-05-010`) — see `## Rules Map` for the paired rules that
   define the audit's scan roots and reporting requirements.
5. Record the `## Validation Result`: scan roots used, duplicate-definition result, dangling-citation result, and
   whether before-and-after audit evidence was required (`IMPR-05-030`).

## Routing

Not applicable — Improving-Harness has one entry (a Review finding) and one exit (the Improvement reaching a
terminal status: `done`, `rejected`, or `archived`). It does not hand off to another mode mid-flow.

## Outputs

- `harness-data/artifacts/improvements/active/IMPROVEMENT-*.md`
- Use `agent-harness/artifact-specs/IMPROVEMENT.md` and `agent-harness/templates/IMPROVEMENT-template.md` for
  every new Improvement artifact.

## Examples

A Review finds that agents repeatedly forget to reload `CORE.md` after a context compaction. The agent drafts an
Improvement proposing a new Checkpoint rule, waits for explicit approval, adds the rule to
`agent-harness/rules/CORE/CHECKPOINT.md`, runs the citation audit, and records the validation result before
marking the Improvement `done`.

## Rules Map

This mode's enforceable rules live in `agent-harness/rules/modes/IMPROVING-HARNESS.md` (single paired file —
under the 25-rule grouping threshold). Load it alongside this file whenever Improving-Harness is the active mode.

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when the improvement touches architectural boundaries or tooling structure
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
