# Dependency Upgrade

## Use When

- upgrading a library, framework, tool, or runtime dependency
- checking upgrade impact before implementation
- validating a dependency change after implementation

## Do Not Use For

- one-off local tool installation notes
- project-specific bootstrap setup
- broad refactors not driven by a dependency change

## Required Inputs

- current and target versions
- dependency role and affected paths
- release notes, migration notes, or changelog when available

## Agent Procedure

1. Confirm the upgrade target, reason, and scope.
2. Identify affected code paths, configs, commands, and generated artifacts.
3. Check for breaking changes, removed APIs, behavior changes, and new defaults.
4. Plan the smallest safe change set needed to adapt the project.
5. Verify tests, build steps, and runtime checks that must pass after the upgrade.
6. Record follow-up work separately if the upgrade surfaces unrelated cleanup opportunities.

## Required Checks

- version change is explicit
- breaking-change risk is assessed
- impacted paths and checks are named
- post-upgrade validation matches the risk level

## Required Output

- upgrade target and reason
- affected areas
- breaking-change summary or explicit note that none was found
- required code or config changes
- required validation

## Escalate When

- the upgrade spans major versions or undocumented behavior changes
- the dependency touches security, auth, migrations, or deployment
- validation coverage is too weak for the upgrade risk
- the upgrade requires large unrelated refactors
