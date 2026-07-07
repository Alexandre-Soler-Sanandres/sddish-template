# IMPROVING-HARNESS.md

## Purpose

Improving-Harness mode changes the harness itself.
Changes should be explicit, focused and reviewable — not opportunistic.
This is the only Mode allowed to modify `agent-harness/*`.

## Entry

Via CLI: `/improve-harness <review-file>`
Via natural language: explicit instruction to improve a harness file, template, or process rule — triggered by a Review finding.

## Consumes

A harness/process-flavored Review finding (see `agent-harness/artifact-specs/REVIEW.md`) — never entered from Partnering or any other unreviewed source.

## When to Use

These are symptoms that motivate writing a Review finding, not direct entry triggers — this mode is still only
entered from that Review finding (see `Consumes` above), never straight from noticing one of these:

- The same mistake appears more than once
- An agent misinterprets a template
- Acceptance criteria are consistently weak
- Tasks are too large
- Context loading is inefficient
- Validation rules are missing
- Review repeatedly finds the same issue
- Legacy extraction produces unreliable artifacts

## Improvement Process

```text
Review -> Improvement artifact -> approved harness change -> validation -> updated files
```

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPR-01-010 | Scope | MAY apply approved changes by default to: any file under `agent-harness/`; `.claude/skills/harness/` and `.agents/skills/harness/` (the per-agent CLI entry-point layers); and root-level `AGENTS.md`/`CLAUDE.md` (the harness's loader files). Other files MAY change too when the Improvement explicitly calls for it (e.g. a matching `harness-data/reference/*.md` update). |
| IMPR-01-020 | Scope | MUST mirror a change to one entry-point layer across the others unless it's agent-specific. |
| IMPR-02-020 | Boundaries | Harness changes MUST be explicit and approved. |
| IMPR-02-025 | Boundaries | The agent MUST NOT set `approval.approved_by`/`approved_at` or move an Improvement's `status` from `proposed` to `approved` — only the user may (this is `COR-01-090` applied to Improvement artifacts specifically). A general instruction to improve the harness is not approval of any specific `IMPROVEMENT-NNN`; approval is only valid once the user has had the chance to see that artifact's own proposed change. The agent MUST NOT apply an Improvement's target-file changes before that specific approval exists. |
| IMPR-02-030 | Boundaries | Target files MUST be listed in frontmatter. |
| IMPR-02-040 | Boundaries | MUST NOT create Improvement artifacts from Partnering — only from Review findings. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when the improvement touches architectural boundaries or tooling structure
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`

## Output

- `harness-data/artifacts/improvements/active/IMPROVEMENT-*.md`
- Use `agent-harness/artifact-specs/IMPROVEMENT.md` and `agent-harness/templates/IMPROVEMENT-template.md` for every new Improvement artifact.
