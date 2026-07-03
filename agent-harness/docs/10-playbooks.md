# Playbooks

Project playbooks are optional support files under `harness-data/playbooks/`.
They are project-owned, not lifecycle artifacts, and they capture recurring project-specific procedures.

## What Playbooks Are For

Use playbooks for repeatable work patterns that are specific to one repository, subsystem, or local delivery process.

Examples:

- backend API change flow in this project
- release or hotfix flow in this repo
- local rollout checks for one subsystem
- recurring workflow steps for a legacy import area

Playbooks explain how to perform recurring work here.

## What Playbooks Are Not

Playbooks are not:

- harness lifecycle artifacts
- universal harness procedures
- setup/bootstrap notes
- the canonical source of domain or architecture truth
- a place for fake template content

Setup and operating help belongs in `harness-data/guides/`.

## When To Create A Playbook

Create a project playbook when:

- the same repo-specific procedure appears more than once
- one area has extra local checks that should not be rediscovered every time
- the work pattern is stable enough to document
- a generic procedure needs a repo-local version

Do not create a playbook for one-off work.

## Who Creates And Maintains Playbooks

Project playbooks are project-owned support files.
They may be written or updated by humans or AI, but they are not required harness outputs and are not lifecycle-managed.

Create or refine them only when they make future work safer, faster, or more consistent.

## How Agents Should Use Playbooks

Load a playbook only when the task matches a recurring project-specific procedure or subsystem workflow.

Typical examples:

- an API behavior change has repo-specific schema and documentation steps
- a release hotfix needs a known local checklist
- one subsystem has extra verification beyond the normal plan validation

Do not load playbooks by default for every task.

## Suggested Shape

Use [PROJECT-PLAYBOOK-template.md](../templates/PROJECT-PLAYBOOK-template.md) as a neutral structure when helpful.

Recommended sections:

- `## Purpose`
- `## Use When`
- `## Relevant Paths`
- `## Procedure`
- `## Required Validation`
- `## Common Pitfalls`
- `## Related Files`

Keep playbooks procedural.
If a file mostly explains environment setup or operating context, it is probably a guide instead.

## Example

```md
# Backend API Changes

## Purpose
Describe the repo-specific steps required when an API request or response shape changes.

## Use When
- changing endpoint schemas
- changing validation or error responses
- changing API examples or docs

## Relevant Paths
- `backend/api/`
- `backend/schemas/`
- `tests/api/`

## Procedure
1. Update schema or contract files first if they are authoritative.
2. Update handlers and validation.
3. Adjust positive and negative-path tests.
4. Update docs or examples if the public shape changed.

## Required Validation
- run API tests
- run schema validation if present

## Common Pitfalls
- changing response shape without updating tests
- missing negative-path coverage
```

## Template Discipline

Keep `harness-data/playbooks/` empty in the template repository until a real adopted project adds real local content.
Do not fill playbooks with placeholder or imaginary project details.
