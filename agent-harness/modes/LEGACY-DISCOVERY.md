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

- `agent-harness/legacy/INVENTORY.md`
- `agent-harness/legacy/source-map/*.md`
- `agent-harness/legacy/FINDINGS.md`
- `agent-harness/legacy/QUESTIONS.md`
- `agent-harness/legacy/active/LEGACY-FINDING-*.md`
- `agent-harness/use-cases/active/UC-*.md` (candidate, draft)
- `agent-harness/specs/active/SPEC-*.md` (candidate, only when evidence is strong)
- Harness Improvement candidates

## Boundaries — Must Not

- Modify legacy source code
- Implement new code
- Treat legacy code as automatically correct
- Create Specs directly without a Use Case unless evidence is unambiguous and strong
- Mark inferred intent as observed behavior
