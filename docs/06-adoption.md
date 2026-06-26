# Adoption

## Minimal Bootstrap Steps

A new project can adopt the harness through these stack-neutral steps:

1. Create or import the repository using the normal tooling for the chosen stack
2. Add root loader files: `AGENTS.md` and `CLAUDE.md`
3. Add the `agent-harness/` directory
4. Add `CORE.md`, `CATALOG.md`, and `OUTPUTS.md`
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

This repository is a ready-to-use template. To adopt it:

1. Copy the full `agent-harness/` directory into your project
2. Copy `AGENTS.md` and `CLAUDE.md` to your project root
3. Fill in the four project-specific reference files:
   - `agent-harness/reference/ARCHITECTURE.md`
   - `agent-harness/reference/DOMAIN.md`
   - `agent-harness/reference/TOOLING.md`
   - `agent-harness/reference/QUALITY.md`
4. Update `CATALOG.md` as work begins
5. Optionally add stack-specific bootstrap guides under `agent-harness/guides/`

The mode files, templates, `CORE.md`, `CATALOG.md`, and `OUTPUTS.md` should be used as-is. They are universal — do not add project-specific content to them.

## What Belongs Where

| File | Universal or Project-Specific |
|---|---|
| `agent-harness/CORE.md` | Universal — do not modify |
| `agent-harness/OUTPUTS.md` | Universal — do not modify |
| `agent-harness/CATALOG.md` | Universal structure, project fills Active Initiatives |
| `agent-harness/modes/*.md` | Universal — do not modify |
| `agent-harness/templates/*.md` | Universal — do not modify |
| `agent-harness/reference/ARCHITECTURE.md` | Project-specific — fill in |
| `agent-harness/reference/DOMAIN.md` | Project-specific — fill in |
| `agent-harness/reference/TOOLING.md` | Project-specific — fill in |
| `agent-harness/reference/QUALITY.md` | Project-specific — fill in |
| `agent-harness/guides/` | Optional — add stack-specific setup guides |

## Adopting for Existing Projects

If you are adopting the harness for an existing codebase:

1. Use **Legacy Discovery mode** to extract evidence from the existing code
2. Produce Legacy Findings → candidate Use Cases
3. Refine Use Cases → create Specs
4. Use Specs as the basis for all future work

The legacy codebase is evidence, not authority. Do not treat existing code as automatically correct.

## Minimal Adoption Path

You do not need to use all modes immediately. The minimal viable adoption is:

1. Write a Spec before any implementation
2. Create an Implementation Plan and get it approved
3. Implement against the plan

Add more structure (Use Cases, Tasks, Validation, Review) as the team and codebase grow.

## Stack-Specific Guides

Concrete setup instructions for specific tech stacks belong in optional guides:

```
agent-harness/guides/
  BOOTSTRAP-python-uv.md
  BOOTSTRAP-node.md
  BOOTSTRAP-java.md
  BOOTSTRAP-dotnet.md
```

These guides describe: package manager setup, workspace or monorepo setup, test framework, linting, type checking, local development, Docker, CI setup.

Stack-specific rules must never be placed in mode files. Mode files reference the relevant reference file instead.
