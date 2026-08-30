# IMPROVING-HARNESS.md

## Purpose

Improving-Harness mode changes the harness itself. Changes should be explicit, focused and reviewable — not
opportunistic. This is the only Mode allowed to modify `agent-harness/*`.

## Mode Story

A Review finding identifies a recurring harness problem; an explicit harness-improvement request may create that
Review and proposed Improvements in the same transaction. The request is intake, never approval. A misinterpreted
template, repeated mistake, weak acceptance criteria, or missing validation can motivate the Review. The agent drafts an
Improvement artifact describing the problem, root cause, and proposed change; waits for the user's explicit
approval of that specific Improvement; applies the approved target-file changes; and records what was validated
before marking it `done`.

## Operating Posture

Explicit and reviewable, never opportunistic — this mode exists to fix a documented, reviewed problem, not to
tidy up whatever the agent notices along the way. Approval is per-Improvement, never inferred from a general
instruction to "improve the harness."

## When To Use

Entered via CLI (`/improve-harness <review-file>`) or via an explicit natural-language instruction to improve a
harness file, template, or process rule. Direct intake creates the required Review first in the same transaction;
it never authorizes changes. The workflow is never entered from Partnering or
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

1. Draft the Improvement artifact from a harness/process-flavored Review finding; direct explicit intake may
   create that Review and proposed Improvements in the same transaction, never from Partnering
   (`IMPR-02-040`), recording target files in frontmatter (`IMPR-02-030`).
2. Wait for the user to explicitly transition it from `proposed` to `approved`, including `approval.approved_by`
   /`approved_at` (`IMPR-02-026`). A general instruction to improve the harness is not approval of any specific
   `IMPROVEMENT-NNNN` — approval is valid only after the user has had the chance to see that artifact's own
   proposed change (`IMPR-02-025`); never infer or self-approve it (`IMPR-02-020`).
3. After that specific approval exists, set the Improvement to `in-progress` before the first target-file change,
   then apply only its listed targets (`IMPR-02-027`).
4. When the Improvement touches rule IDs or Rules-table placement, run the `COR-10-060`–`COR-10-063` citation
   audit before setting the Improvement to `done` (`IMPR-05-010`) — see `## Rules` (`IMPR-05-020`/`IMPR-05-030`)
   for the audit's scan roots and reporting requirements.
5. Record the `## Validation Result`: scan roots used, duplicate-definition result, dangling-citation result, and
   whether before-and-after audit evidence was required (`IMPR-05-030`).

## Routing

Not applicable — Improving-Harness has one entry (a Review finding) and one exit (the Improvement reaching a
terminal status: `done`, `rejected`, or `archived`). It does not hand off to another mode mid-flow.

## Outputs

- `harness-data/artifacts/improvements/IMPROVEMENT-*.md`
- Use `agent-harness/artifact-specs/IMPROVEMENT.md` and `agent-harness/templates/IMPROVEMENT-template.md` for
  every new Improvement artifact.

## Examples

A Review finds that agents repeatedly forget to reload `CORE.md` after a context compaction. The agent drafts an
Improvement proposing a new Checkpoint rule, waits for explicit approval, adds the rule to `CORE.md`'s `## Rules`
`### Checkpoint` section, runs the citation audit, and records the validation result before marking the
Improvement `done`.

## Rules

| ID | Rule |
| --- | --- |
| IMPR-01-010 | MAY apply approved changes by default to: any file under `agent-harness/`; `.claude/skills/harness/`, `.agents/skills/harness/`, and `.github/agents/` (the per-agent CLI entry-point layers); and root-level `AGENTS.md`/`CLAUDE.md`/`.github/copilot-instructions.md` (the harness's loader files). |
| IMPR-01-011 | Other files MAY change too when the Improvement explicitly calls for it. |
| IMPR-01-020 | MUST mirror a change to one entry-point layer across the others unless it's agent-specific. |
| IMPR-02-020 | Harness changes MUST be explicit and approved. |
| IMPR-02-025 | The agent MUST NOT infer approval or approve an Improvement on its own (this is `COR-01-090` applied to Improvement artifacts specifically). A general instruction to improve the harness is not approval of any specific `IMPROVEMENT-NNNN`; approval is valid only after the user has had the chance to see that artifact's own proposed change. |
| IMPR-02-026 | The agent MUST perform the `proposed` -> `approved` transition, including `approval.approved_by`/`approved_at`, when the user explicitly instructs it to do so. |
| IMPR-02-027 | MUST require specific approval and an `in-progress` transition before the first target-file mutation. |
| IMPR-02-030 | Target files MUST be listed in frontmatter. |
| IMPR-02-040 | MUST NOT create Improvement artifacts from Partnering; MUST create them from a harness/process Review, which direct explicit harness-improvement intake MAY create in the same transaction. |
| IMPR-05-010 | An approved Improvement that touches rule IDs or Rules-table placement MUST satisfy `CORE.md`'s `COR-10-060`–`COR-10-063` before it can be set to `done`. |
| IMPR-05-020 | A `COR-10-060` citation audit MUST cover at minimum: `agent-harness/`, `harness-data/reference/`, root loader files (`AGENTS.md`, `CLAUDE.md`, and future equivalents), and entry-point wrapper layers (`.claude/skills/harness/`, `.agents/skills/harness/`, and future `.github/` Copilot wrapper paths when present). |
| IMPR-05-030 | The Improvement's `## Validation Result` MUST report the scan roots used, duplicate-definition result, dangling-citation result, and whether before-and-after audit evidence was required by `COR-10-061`. |
| IMPR-05-040 | Improving-Harness mode MUST NOT create `agent-harness/tools/`, generated rule indexes, or other repo-local validation artifacts to satisfy `COR-10-060`; future automation belongs in a separate template-repository Improvement. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when the improvement touches architectural boundaries or tooling structure
- `harness-data/artifacts/adrs/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`
