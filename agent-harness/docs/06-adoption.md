# Adoption

This guide is for turning the template into a usable project workspace without over-documenting on day one.

## Using This Template

This repository is marked as a GitHub template. There are two ways to create a new project from it.

### Option A: GitHub (recommended)

1. Click **Use this template** on the repository page and create a new repository
2. Clone your new repository locally
3. Fill in the four project-specific reference files:
   - `harness-data/reference/ARCHITECTURE.md`
   - `harness-data/reference/DOMAIN.md`
   - `harness-data/reference/TOOLING.md`
   - `harness-data/reference/QUALITY.md`
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

If you are adopting the harness into a repo that already exists, jump to [Adopting for Existing Projects](#adopting-for-existing-projects).

## Minimum Viable Adoption

Do not treat the four reference files as a large upfront documentation project. The harness becomes useful long
before those files are exhaustive.

The goal of the first pass is only this:

- give agents enough domain and architecture context to avoid obvious misunderstanding
- define the exact tooling and quality commands needed before implementation begins
- leave deeper project detail for later refinement

The harness should become useful quickly. A thin but accurate first pass is better than a polished but imaginary one.

Keep the template honest:

- the files under `harness-data/reference/` stay project-owned
- this template does not ship fake project content into them
- examples in this document are illustrative only

### Smallest Useful First Fill-In

#### `ARCHITECTURE.md`

Enough for a first pass:

- a 2-3 sentence system overview
- the main layers or major subsystems
- the important boundaries agents must not blur
- where technical artifacts such as API specs or schemas live

Illustrative shape:

```md
## System Overview
Customer-facing web app with one backend API and one relational database.

## Layers and Boundaries
- `frontend/` renders UI only
- `backend/` owns business logic and persistence
- `infra/` holds deployment configuration

## Technical Artifacts
- API specification: `docs/api/openapi.yaml`
```

What can wait:

- detailed deployment prose
- exhaustive component inventory
- every infrastructure nuance

#### `DOMAIN.md`

Enough for a first pass:

- a short domain overview
- the main actors
- the handful of concepts and rules agents must not misuse

Illustrative shape:

```md
## Domain Overview
Internal operations system for handling customer support workflows.

## Key Actors
- operator
- customer
- billing-service

## Business Rules
- A closed case cannot be edited without reopening it.
- Refund approval requires operator confirmation.
```

What can wait:

- full glossary coverage
- edge-case business rules that do not affect current work
- broad product history

#### `TOOLING.md`

Enough for a first pass:

- the package manager
- the real commands for tests, linting, type checking, formatting, build, and local development
- any one or two critical setup quirks

Illustrative shape:

```md
## Package Manager
uv

## Common Commands
### Run Tests
`uv run pytest`

### Lint
`uv run ruff check .`

### Type Check
`uv run mypy .`
```

What cannot wait once implementation begins:

- exact runnable commands
- any environment requirement that would make those commands fail

#### `QUALITY.md`

Enough for a first pass:

- a minimal definition of done
- test expectations
- lint/typecheck expectations
- the project's high-risk areas

Illustrative shape:

```md
## Definition of Done
- [ ] tests pass
- [ ] lint passes
- [ ] type check passes
- [ ] changed behavior is covered by tests

## High-Risk Areas
- authentication
- billing
- database migrations
```

What can wait:

- polished prose
- long policy explanations
- quality rules that are irrelevant to current work

The illustrative shapes above are day-one, greenfield content — informal `## Decisions`-equivalent prose with no
`## Discovered` section, since no Legacy Discovery has run yet. Once this project starts Legacy Discovery or
accepts its first ADR, split content per `docs/03-artifacts.md`'s Reference File Structure convention rather than
leaving discovered facts and target decisions interleaved.

### What May Stay Unknown Early

These are acceptable to leave incomplete during early adoption:

- detailed deployment model
- exhaustive terminology tables
- complete architecture narrative
- deep historical context
- optional project-specific setup and operating guides under `harness-data/guides/`
- optional project playbooks under `harness-data/playbooks/`
- the support-file `index.yaml` files can stay empty until real guides or project playbooks exist

### What Must Be Concrete Before Implementation

Before any real implementation work starts, these must be concrete enough for an agent to act safely:

- the main system boundaries in `ARCHITECTURE.md`
- the core domain actors/rules relevant to the task in `DOMAIN.md`
- the actual validation commands in `TOOLING.md`
- the definition of done and high-risk areas in `QUALITY.md`

That is the real pre-implementation threshold. Everything else can mature while the team uses the harness.

## First Successful Path

Use this as the smallest useful onboarding path for a new project:

1. Fill `ARCHITECTURE.md` with a short system overview, boundaries, and technical artifact locations.
2. Fill `DOMAIN.md` with the main actors, core concepts, and a few critical rules.
3. Fill `TOOLING.md` with the exact commands an agent must run.
4. Fill `QUALITY.md` with a minimal definition of done and high-risk areas.
5. Create one Use Case for a real task or workflow.
6. Create one Spec from that Use Case.
7. Decide whether Tasks are required.
8. Create one Implementation Plan.
9. Run one validation pass against the resulting artifacts or implementation step.

That is enough to prove the harness works in a real project. Everything beyond that is refinement.

### After setup (both options)

These are the details people most often need once the basic files exist:

- `agent-harness/CATALOG.md` ships ready to use — it is a navigation index of where artifact types live, not a log
  of individual artifacts; agents use it to locate artifacts, and it only changes if the harness structure itself
  changes. Live per-project state (e.g. active Implementation Plan pointers, per `CORE.md`'s Parallel Work rule)
  lives in the separate `harness-data/CATALOG.md` instead — same name, different root, on purpose: one is the
  universal index, the other is this project's own bookkeeping against it
- `harness-data/RUN-LOG.md` is not required by default, but the agent may use it for interrupted, approval-heavy,
  multi-step, or high-risk work; keep it temporary and collapse or clear it after completion. The one mandatory
  case is the `IMPL-028` gate-check line written before the first file mutation of a plan step.
- Optionally add `REPO-MAP.md` at repo root or a major subtree when the codebase is large enough that normal context
  loading becomes clumsy
- Optionally add project-specific setup and operating guides under `harness-data/guides/`
- Optionally add project-specific scoped procedures under `harness-data/playbooks/`
- Keep `harness-data/guides/index.yaml` and `harness-data/playbooks/index.yaml` accurate when those support files exist
- Keep `agent-harness/docs/` for harness guidance; project documentation can use the repository root or another
  project-owned docs location
- The mode files, templates, `CORE.md`, `CATALOG.md`, and `OUTPUTS.md` are universal — do not add project-specific content to them

## Two Root Directories

The repository has two top-level roots after setup: `agent-harness/` is the portable harness definition — the
same for every project using this harness, and the only thing that syncs to/from the template repo. `harness-data/`
is this project's own data. It contains:

- project-owned support files such as `reference/`, `guides/`, and `playbooks/`
- harness-managed lifecycle artifacts under `harness-data/artifacts/`

Nothing in `harness-data/` is ever copied into or out of the template.

When in doubt:

- change `agent-harness/` only if you are changing the harness for every future adopter
- change `harness-data/` when you are describing or tracking one specific project

## What Belongs Where

| File | Universal or Project-Specific |
| --- | --- |
| `agent-harness/CORE.md` | Universal — do not modify |
| `agent-harness/OUTPUTS.md` | Universal — do not modify |
| `agent-harness/CATALOG.md` | Universal — do not modify |
| `agent-harness/modes/**/*.md` | Universal — do not modify |
| `agent-harness/playbooks/` | Universal — reusable procedures owned by the harness |
| `agent-harness/templates/*.md` | Universal — do not modify |
| `harness-data/CATALOG.md` | Project-specific — live state, not part of the template |
| `harness-data/RUN-LOG.md` | Optional — temporary operational trace the agent may use for interrupted or higher-risk work |
| `REPO-MAP.md` | Optional — structural context for large repos or major subtrees |
| `harness-data/reference/ARCHITECTURE.md` | Project-specific — fill in |
| `harness-data/reference/DOMAIN.md` | Project-specific — fill in |
| `harness-data/reference/TOOLING.md` | Project-specific — fill in |
| `harness-data/reference/QUALITY.md` | Project-specific — fill in |
| `harness-data/guides/` | Optional — add project-specific setup and operating guidance |
| `harness-data/playbooks/` | Optional — add project-specific scoped procedures for recurring work in this repo |
| `harness-data/artifacts/{legacy,use-cases,specs,tasks,implementation-plans,reviews,improvements,transcripts,ideas,adrs}/` | Project-specific — lifecycle artifacts generated and managed by using the harness |

## Adopting for Existing Projects

This only applies to codebases that are actively being developed and will continue to receive changes. There is no value in adding the harness to a project that is not going to be updated.

If you are adopting the harness for an existing active codebase:

1. Use **Legacy Discovery mode** to extract evidence from the existing code
2. Produce Legacy Findings → candidate Use Cases
3. Refine Use Cases → create Specs
4. Use Specs as the basis for all future work

The legacy codebase is evidence, not authority. Do not treat existing code as automatically correct.

Keep the adoption target modest: get to trustworthy Use Cases and Specs first, then let normal planning and implementation flow from there.

## Project Guides And Playbooks

Concrete project-owned guidance belongs in optional support-file folders:

- `harness-data/guides/` for project-specific setup and operating guidance
- `harness-data/playbooks/` for project-specific scoped procedures

These are project-owned support files, not lifecycle artifacts and not required harness outputs.
They may be created by humans or AI when useful, but the harness does not require them on every project.

Use these docs for the detailed guidance:

- [09-guides.md](09-guides.md)
- [10-project-playbooks.md](10-project-playbooks.md)

`agent-harness/playbooks/` is a separate harness-owned layer for reusable procedures.
Each support-file layer uses an `index.yaml` file so agents can discover relevant support files without opening every file.

Project-specific rules must never be placed in mode files. Put them in the relevant project-owned support file instead.

## Optional Advanced Disciplines

Review and Improvement are part of the harness, but they do not need to dominate everyday usage.

For many teams, the default path is:

```text
Partnering → Use Case → Spec → [Task] → Implementation Plan → Implementation → Validation
```

Use Review and Improvement when you want a stronger formal loop around output evaluation or process correction.
