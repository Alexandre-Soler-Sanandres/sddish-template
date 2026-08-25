# IMPORT-HYGIENE.md

## Purpose

Handling secret-like and noisy files when a legacy codebase snapshot is imported for discovery.

## Mode Story

Before touching a freshly imported legacy snapshot, the agent inventories secret-like and noisy paths by path
only, never opening their contents. Anything that needs a user decision — remove, quarantine, or leave as-is —
gets a Finding and a Questions entry instead of being handled unilaterally.

## Operating Posture

By-path-only scanning discipline only works if followed from the first file touched — deferring until content
looks secret-like defeats the point, since spotting that already requires opening it.

## When To Use

Load this file before inventorying or reading files in a freshly imported legacy snapshot (`LD-07-060`). Not
required for discovery work that doesn't touch a fresh import.

## Workflow Paths

Not applicable — this file is a standing precondition loaded before App-Local Discovery's normal workflow
begins on a fresh import, not a separate entry point of its own.

## Core Moves

1. Inventory `.env`, `.env.*`, `.env.local`, `secrets/`, `*.key`, `*.pem`, password files, token files, logs,
   caches, virtual environments, coverage output, test artifacts, generated metadata, egg-info, and build output
   by path only during normal discovery — never open their contents (`LD-07-010`).
2. Never open log contents except in an explicit log or security discovery slice, after confirming they do not
   contain secrets (`LD-07-020`).
3. Never remove or rewrite imported artifacts during normal discovery (`LD-07-030`).
4. Before committing an imported snapshot or import-hygiene change, verify nested Git metadata:
   `find harness-data/artifacts/legacy/apps/<legacy-app-slug> -path '*/.git' -type d` — expected result is no
   output (`LD-07-040`). Surface any hit to the user before proceeding (`LD-07-041`).
5. When import noise needs a user decision, add a Findings entry for the risk and a Questions entry asking
   whether to remove, quarantine, or leave it as-is; the user's response authorizes cleanup (`LD-07-050`).

## Routing

Not applicable — findings and questions raised here follow the same routing as any other App-Local Discovery
finding or question.

## Outputs

- A path-only inventory of secret-like/noisy files (no new artifact type of its own).
- A Findings entry and Questions entry when a decision is needed (`LD-07-050`).

## Examples

A freshly imported snapshot contains a `secrets/` directory. The agent records its path in the inventory without
opening any file inside it, and if its presence needs a decision, adds a Finding and a Question asking whether to
quarantine it.

## Rules Map

This submode's enforceable rules live in `agent-harness/rules/modes/legacy-discovery/IMPORT-HYGIENE.md` (single
paired file — under the 25-rule grouping threshold). Load it before inventorying or reading any file in a
freshly imported legacy snapshot.

## Reference Files

Load per `agent-harness/modes/DISCOVERING-LEGACY.md`'s `## Reference Files` table — this file adds no reference
files of its own.
