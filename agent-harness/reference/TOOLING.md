# TOOLING.md

> **Project-specific.** Fill this in for your project. Agents load this file during Implementation
> mode when running validation commands. All commands in Task frontmatter must match what is defined here.

## Package Manager

(e.g. uv | npm | poetry | cargo | gradle | maven)_

## Project Structure

(describe the monorepo or single-repo structure — workspaces, apps, packages)_

## Common Commands

### Run Tests

```text
_(e.g. uv run pytest apps/myapp/tests/)_
```

### Lint

```text
_(e.g. uv run ruff check .)_
```

### Type Check

```text
_(e.g. uv run mypy .)_
```

### Format

```text
_(e.g. uv run ruff format .)_
```

### Build

```text
_(e.g. uv build)_
```

### Local Development

```text
_(e.g. uv run uvicorn myapp:app --reload)_
```

## Notes

(any project-specific tooling quirks, environment requirements, or setup steps agents should know)
