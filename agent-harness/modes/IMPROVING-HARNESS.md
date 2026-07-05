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
| IMPR-005 | Scope | Approved changes may be applied by default to: any file under `agent-harness/` (mode files, artifact specs, shared procedures, templates, playbooks, docs, `CATALOG.md`, `CORE.md`, `OUTPUTS.md`, `README.md` alike — the category is "the harness itself," not an enumerated subset); `.claude/skills/harness/` and `.agents/skills/harness/` (the harness's per-agent CLI entry-point layers, not a separate project concern, despite living outside `agent-harness/` on disk); and root-level `AGENTS.md`/`CLAUDE.md` (the harness's loader files). A change to one entry-point layer (e.g. adding/renaming a Claude skill) should be mirrored in the others unless the change is agent-specific. Changes to any other file are also allowed when the Improvement explicitly calls for it — most often because the harness change requires a matching update elsewhere for consistency (e.g. `harness-data/reference/*.md` or other `harness-data/` bookkeeping). |
| IMPR-006 | Boundaries | Do not change the harness during normal feature implementation. |
| IMPR-007 | Boundaries | Harness changes must be explicit and approved. |
| IMPR-008 | Boundaries | Target files must be listed in frontmatter. |
| IMPR-009 | Boundaries | Do not create Improvement artifacts from Partnering — only from Review findings. |

## Reference Files

Load these when relevant — do not load all of them by default:

- `harness-data/reference/ARCHITECTURE.md` — when the improvement touches architectural boundaries or tooling structure
- `harness-data/artifacts/adrs/accepted/` (accepted ADRs) — when a specific boundary is settled by an ADR rather than only described generally in `ARCHITECTURE.md`

## Output

- `harness-data/artifacts/improvements/active/IMPROVEMENT-*.md`
- Use `agent-harness/artifact-specs/IMPROVEMENT.md` and `agent-harness/templates/IMPROVEMENT-template.md` for every new Improvement artifact.
- Also produces the harness/process flavor of Review (`agent-harness/artifact-specs/REVIEW.md`'s Two Flavors) —
  this is what triggers Entry into this Mode in the first place, per `IMPR-009`.
