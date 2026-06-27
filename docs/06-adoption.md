# Adoption

## Minimal Bootstrap Steps

A new project can adopt the harness through these stack-neutral steps:

1. Create or import the repository using the normal tooling for the chosen stack
2. Add root loader files: `AGENTS.md` and `CLAUDE.md`
3. Add the `agent-harness/` directory
4. Add `agent-harness/CORE.md`, `agent-harness/CATALOG.md`, and `agent-harness/OUTPUTS.md`
5. Add all mode files under `agent-harness/modes/`
6. Add all artifact templates under `agent-harness/templates/`
7. Add reference files under `agent-harness/reference/`
8. Document stack-specific commands in `agent-harness/reference/TOOLING.md` and quality standards in `agent-harness/reference/QUALITY.md`
9. Document architecture boundaries in `ARCHITECTURE.md` — including a "Technical Artifacts" section declaring where project-specific technical specs live (OpenAPI, schemas, contracts)
10. Document domain rules in `DOMAIN.md`
11. Create the first Use Case, Spec, or Legacy Discovery artifact
12. Create or approve an Implementation Plan before coding starts

The harness should be introduced as early as possible, but it can also be added to an existing repository.

## Using This Template

This repository is marked as a GitHub template. There are two ways to create a new project from it.

### Option A: GitHub (recommended)

1. Click **Use this template** on the repository page and create a new repository
2. Clone your new repository locally
3. Fill in the four project-specific reference files:
   - `agent-harness/reference/ARCHITECTURE.md`
   - `agent-harness/reference/DOMAIN.md`
   - `agent-harness/reference/TOOLING.md`
   - `agent-harness/reference/QUALITY.md`
4. Start with a Partnering or Use Case session

You get the full structure — mode files, templates, artifact folders, and Claude Code commands — with a clean git history.

### Option B: Local clone

If you do not use GitHub or prefer to work locally:

```bash
git clone <template-url> your-project
cd your-project
rm -rf .git && git init
```

Then fill in the four project-specific reference files as above.

### After setup (both options)

- `CATALOG.md` ships ready to use — it is a navigation index of where artifact types live, not a log of individual artifacts; agents use it to locate artifacts and it only changes if the harness structure itself changes
- Optionally add stack-specific bootstrap guides under `agent-harness/guides/`
- Optionally keep the `docs/` directory for local reference — the most current version is always in the original template repository
- The mode files, templates, `CORE.md`, `CATALOG.md`, and `OUTPUTS.md` are universal — do not add project-specific content to them

## What Belongs Where

| File | Universal or Project-Specific |
| --- | --- |
| `agent-harness/CORE.md` | Universal — do not modify |
| `agent-harness/OUTPUTS.md` | Universal — do not modify |
| `agent-harness/CATALOG.md` | Universal navigation structure |
| `agent-harness/modes/*.md` | Universal — do not modify |
| `agent-harness/templates/*.md` | Universal — do not modify |
| `agent-harness/reference/ARCHITECTURE.md` | Project-specific — fill in |
| `agent-harness/reference/DOMAIN.md` | Project-specific — fill in |
| `agent-harness/reference/TOOLING.md` | Project-specific — fill in |
| `agent-harness/reference/QUALITY.md` | Project-specific — fill in |
| `agent-harness/guides/` | Optional — add stack-specific setup guides |

## Adopting for Existing Projects

This only applies to codebases that are actively being developed and will continue to receive changes. There is no value in adding the harness to a project that is not going to be updated.

If you are adopting the harness for an existing active codebase:

1. Use **Legacy Discovery mode** to extract evidence from the existing code
2. Produce Legacy Findings → candidate Use Cases
3. Refine Use Cases → create Specs
4. Use Specs as the basis for all future work

The legacy codebase is evidence, not authority. Do not treat existing code as automatically correct.

## Minimal Adoption Path

The harness can be introduced gradually across six phases:

**Phase 1: Minimal Agent-Ready Repo**

- `AGENTS.md`, `CLAUDE.md`
- `agent-harness/CORE.md`
- `agent-harness/modes/IMPLEMENTATION.md`
- `agent-harness/modes/VALIDATION.md`

**Phase 2: SDD-ish Artifacts**
Add: `use-cases/`, `specs/`, `implementation-plans/`

**Phase 3: Tasks When Needed**
Add: `tasks/`, `TASK-template.md`, task decision rules

**Phase 4: Partnering and Ideas**
Add: `PARTNERING.md`, `ideas/`, `transcripts/`

**Phase 5: Review and Improvement**
Add: `reviews/`, `improvements/`, `REVIEW.md`, `IMPROVEMENT.md`

**Phase 6: Legacy Discovery**
Add: `LEGACY-DISCOVERY.md`, `legacy/`, `source-map/`, legacy findings

You do not need to use all modes immediately. Even Phase 1 alone prevents the most common failure mode: implementing before requirements are clear.

## Stack-Specific Guides

Concrete setup instructions for specific tech stacks belong in optional guides:

```text
agent-harness/guides/
  BOOTSTRAP-python-uv.md
  BOOTSTRAP-node.md
  BOOTSTRAP-java.md
  BOOTSTRAP-dotnet.md
```

These guides describe: package manager setup, workspace or monorepo setup, test framework, linting, type checking, local development, Docker, CI setup.

Stack-specific rules must never be placed in mode files. Mode files reference the relevant reference file instead.
