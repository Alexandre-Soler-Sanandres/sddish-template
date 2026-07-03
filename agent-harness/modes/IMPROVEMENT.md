# IMPROVEMENT.md

## Purpose

Harness Improvement mode changes the harness itself.
Changes should be explicit, focused and reviewable — not opportunistic.

## Entry

Via CLI: `/tw-improve-harness <review-file>`
Via natural language: explicit instruction to improve a harness file, template, or process rule — triggered by a Review finding.

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
| IMPR-001 | Validation | Keep `## Validation` as the validation plan or checklist. |
| IMPR-002 | Validation | Add `## Validation Result` with the date, checks performed, and outcome before an Improvement artifact is set to `done` or moved to `done/`. |
| IMPR-003 | Validation | If a validation item is prospective and cannot be fully proven yet, state that explicitly instead of treating it as completed evidence. |
| IMPR-004 | Validation | Do not move an Improvement artifact to `done/` until the approved target changes are applied and the validation result is documented. |
| IMPR-005 | Scope | Approved changes are applied to: mode files, templates, reference files, `agent-harness/CATALOG.md`. |
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
- Use `agent-harness/templates/IMPROVEMENT-template.md` for every new Improvement artifact.
