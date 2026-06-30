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

Before an Improvement artifact is set to `done` or moved to `done/`, record validation in the artifact itself:

- Keep `## Validation` as the validation plan or checklist.
- Add `## Validation Result` with the date, checks performed, and outcome.
- If a validation item is prospective and cannot be fully proven yet, state that explicitly instead of treating it
  as completed evidence.
- Do not move an Improvement artifact to `done/` until the approved target changes are applied and the validation
  result is documented.

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/ARCHITECTURE.md` — when the improvement touches architectural boundaries or tooling structure

## Output

- `agent-harness/improvements/active/IMPROVEMENT-*.md`
- Use `agent-harness/templates/IMPROVEMENT-template.md` for every new Improvement artifact.
- Approved changes are applied to: mode files, templates, reference files, CATALOG.md.

## Boundaries

- Do not change the harness during normal feature implementation
- Harness changes must be explicit and approved
- Target files must be listed in frontmatter
- Do not create Improvement artifacts from Partnering — only from Review findings
