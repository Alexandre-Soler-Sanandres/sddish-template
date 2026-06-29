# LEGACY-DISCOVERY.md

## Purpose

Legacy Discovery analyzes an existing project as evidence for a new SDD-ish development process.
The legacy project is evidence, not authority.

## Entry

Via CLI: `/tw-discover-legacy <path>`
Via natural language: explicit instruction to analyze a legacy codebase or imported project directory.

## Inputs May Include

- Old source code
- Old documentation
- Tests, Docker files, CI configuration
- Deployment scripts, README files, issue notes

## Agent Must

- Not modify legacy source code
- Not implement new code
- Not treat legacy code as automatically correct
- Identify observed behavior
- Identify documented behavior
- Mark inferred intent clearly
- Mark uncertainty explicitly
- Identify accidental complexity
- Extract candidate Use Cases
- Extract candidate Specs only when evidence is strong enough
- Record evidence paths

## Agent Must Distinguish

- Observed behavior (code does X)
- Documented behavior (docs say X)
- Inferred intent (likely meant X)
- Accidental complexity (unclear why X exists)
- Dead or uncertain code

## Reference Files

Load these when relevant — do not load all of them by default:

- `agent-harness/reference/DOMAIN.md` — when extracting domain concepts, rules, or terminology from legacy code
- `agent-harness/reference/ARCHITECTURE.md` — when mapping legacy structure to the current system architecture

## Outputs May Include

- `agent-harness/legacy/apps/<legacy-app-slug>/INVENTORY.md`
- `agent-harness/legacy/apps/<legacy-app-slug>/SOURCE-MAP.md`
- `agent-harness/legacy/apps/<legacy-app-slug>/FINDINGS.md`
- `agent-harness/legacy/apps/<legacy-app-slug>/QUESTIONS.md`
- `agent-harness/legacy/cross-system/SUMMARY.md`
- `agent-harness/legacy/cross-system/CONTRACTS.md`
- `agent-harness/legacy/cross-system/FINDINGS.md`
- `agent-harness/legacy/cross-system/QUESTIONS.md`
- `agent-harness/legacy/cross-system/PARITY-MATRIX.md`
- `agent-harness/legacy/cross-system/REWRITE-READINESS.md`
- `agent-harness/legacy/active/LEGACY-FINDING-*.md`
- `agent-harness/use-cases/active/UC-*.md` (candidate, draft)
- `agent-harness/specs/active/SPEC-*.md` (candidate, only when evidence is strong)
- Harness Improvement candidates

## Legacy Artifact Structure

Use app-scoped legacy folders for app-specific discovery. A legacy app is any imported source root that can be
discovered independently, such as an engine, dashboard, inference service, worker, library, or old monolith.

```text
agent-harness/legacy/apps/<legacy-app-slug>/
  INVENTORY.md
  SOURCE-MAP.md
  FINDINGS.md
  QUESTIONS.md
```

Each app-scoped `SOURCE-MAP.md` is the restart point for that app. It must include:

- source root
- primary evidence files
- code areas
- candidate discovery slices
- working discovery plan
- current slice status
- completed slice notes
- open source-map notes
- reference enrichment routing

Use cross-system artifacts only after app-scoped evidence exists and a finding, question, or readiness judgment
requires more than one app:

```text
agent-harness/legacy/cross-system/
  SUMMARY.md
  CONTRACTS.md
  FINDINGS.md
  QUESTIONS.md
  PARITY-MATRIX.md
  REWRITE-READINESS.md
```

Do not put app-local evidence directly into cross-system artifacts. Cross-system artifacts should cite the
app-scoped artifact and source evidence they synthesize.

Older flat files directly under `agent-harness/legacy/` may exist in repositories that started discovery before
this structure was introduced. Treat them as legacy layout debt. Continue new discovery in the scoped structure
unless an explicit Improvement or cleanup task migrates the old files.

## Boundaries — Must Not

- Modify legacy source code
- Implement new code
- Treat legacy code as automatically correct
- Create Specs directly without a Use Case unless evidence is unambiguous and strong
- Mark inferred intent as observed behavior
- Commit findings only when the user explicitly requests it. See `CORE.md` Commits section.
