# Project Playbooks

Project playbooks are optional support files under `harness-data/playbooks/`.
They are project-owned, not lifecycle artifacts, and they capture recurring project-specific procedures.

Universal playbooks may also exist under `agent-harness/playbooks/`.
Those are harness-owned reusable procedures for task shapes that recur across projects.
They are not project playbooks and should not be maintained through this project-owned layer.

## What Project Playbooks Are For

Project playbooks are useful for repeatable work patterns that are specific to one repository, subsystem, or local delivery process.

Examples:

- backend API change flow in this project
- release or hotfix flow in this repo
- local rollout checks for one subsystem
- recurring workflow steps for a legacy import area

Project playbooks explain how to perform recurring work here.

## What Project Playbooks Are Not

Project playbooks are not:

- harness lifecycle artifacts
- harness-owned universal playbooks
- setup/bootstrap notes
- the canonical source of domain or architecture truth
- a place for fake template content

Setup and operating help belongs in `harness-data/guides/`.
Harness-owned universal reusable procedures belong in `agent-harness/playbooks/`.

## When To Create A Project Playbook

A project playbook is worth creating when:

- the same repo-specific procedure appears more than once
- one area has extra local checks that should not be rediscovered every time
- the work pattern is stable enough to document
- a generic procedure needs a repo-local version

A project playbook is not needed for one-off work.
A project playbook is also not needed if the procedure is generic enough to live in `agent-harness/playbooks/`.

## Who Creates And Maintains Project Playbooks

Project playbooks are project-owned support files.
They may be written or updated by humans or AI, but they are not required harness outputs and are not lifecycle-managed.

They are worth creating or refining only when they make future work safer, faster, or more consistent.

Universal playbooks are different:

- they live under `agent-harness/playbooks/`
- they are owned by the harness
- they should be changed only as harness work, not as normal project-specific maintenance

## How Agents Should Use Project Playbooks

Agents should load a playbook only when the task matches a recurring project-specific procedure or subsystem workflow.

Typical examples:

- an API behavior change has repo-specific schema and documentation steps
- a release hotfix needs a known local checklist
- one subsystem has extra verification beyond the normal plan validation

Agents should not load project playbooks by default for every task.

When both a universal playbook and a project playbook are relevant, agents should:

1. load the universal playbook for the generic procedure
2. load the project playbook for repo-local rules or overrides
3. follow the project-specific constraint when they differ

When both apply, the universal playbook provides the generic procedure and the project playbook refines it for this repository.

## Suggested Shape

The [PROJECT-PLAYBOOK-template.md](../templates/PROJECT-PLAYBOOK-template.md) template can be used as a neutral structure when helpful.

Recommended sections:

- `## Use When`
- `## Do Not Use For`
- `## Required Inputs`
- `## Relevant Paths`
- `## Agent Procedure`
- `## Required Checks`
- `## Required Output`
- `## Escalate When`
- `## Related Files`

Keep project playbooks short, procedural, and agent-facing.
If a file mostly explains environment setup or operating context, it is probably a guide instead.

## Example

```md
# Backend API Changes

## Use When
- changing endpoint schemas
- changing validation or error responses
- changing API examples or docs

## Do Not Use For
- one-off local debugging
- environment setup notes

## Required Inputs
- affected endpoint or schema
- authoritative contract files if they exist

## Relevant Paths
- `backend/api/`
- `backend/schemas/`
- `tests/api/`

## Agent Procedure
1. Update schema or contract files first if they are authoritative.
2. Update handlers and validation.
3. Adjust positive and negative-path tests.
4. Update docs or examples if the public shape changed.

## Required Checks
- response and request shapes stay aligned
- negative-path coverage is present

## Required Output
- summary of the changed API surface
- affected paths
- required validation outcomes

## Escalate When
- the change affects shared external consumers
- the authoritative contract is unclear
```

## Template Discipline

The template repository should keep `harness-data/playbooks/` empty until a real adopted project adds real local content.
Project playbooks should not be filled with placeholder or imaginary project details.
