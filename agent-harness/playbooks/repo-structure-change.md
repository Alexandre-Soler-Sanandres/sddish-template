# Repo Structure Change

## Use When

- moving, renaming, or reorganizing files or folders
- changing command surfaces, path conventions, or artifact locations
- realigning docs and references after structural repo changes

## Do Not Use For

- small local edits inside one file
- content-only documentation updates without path changes
- lifecycle status moves already defined by harness rules

## Required Inputs

- intended structural change
- affected paths, commands, links, or references
- scope boundary for what must remain unchanged

## Agent Procedure

1. Confirm the structural intent and exact scope.
2. Identify all directly affected paths, references, commands, templates, and docs.
3. Apply the structural change consistently across source, docs, and harness references.
4. Check for stale paths, stale command names, and naming drift.
5. Verify that the new structure still matches harness semantics and project intent.
6. Record any deferred follow-up separately instead of mixing it into the structural pass.

## Required Checks

- all moved or renamed targets are updated consistently
- internal links and command references still resolve
- no old path wording remains in active documentation
- the change did not silently alter lifecycle meaning or ownership boundaries

## Required Output

- summary of the structural change
- affected paths and references
- explicit note on link/reference alignment
- follow-up items if any remain

## Escalate When

- the change affects lifecycle semantics, approval flow, or artifact meaning
- multiple possible structures exist with non-obvious tradeoffs
- the move would invalidate existing active work without a migration path
- path ownership between harness and project data becomes unclear
