# IMPORT-HYGIENE.md

## Purpose

Handling secret-like and noisy files when a legacy codebase snapshot is imported for discovery.

Load this file before inventorying or reading files in a freshly imported legacy snapshot (`LD-07-060`).
`LD-07-010`'s by-path-only scanning discipline only works if followed from the first file touched — deferring
until content looks secret-like defeats the point, since spotting that already requires opening it.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-07-010 | Import-Hygiene | MUST NOT open the contents of `.env`, `.env.*`, `.env.local`, `secrets/`, `*.key`, `*.pem`, password files, token files, logs, caches, virtual environments, coverage output, test artifacts, generated metadata, egg-info, or build output during normal discovery — inventory them by path only. |
| LD-07-020 | Import-Hygiene | MUST NOT open log contents except in an explicit log or security discovery slice, after confirming they do not contain secrets. |
| LD-07-030 | Import-Hygiene | MUST NOT remove or rewrite imported artifacts during normal discovery. |
| LD-07-040 | Import-Hygiene | MUST verify nested Git metadata before committing an imported snapshot or import-hygiene change: `find harness-data/artifacts/legacy/apps/<legacy-app-slug> -path '*/.git' -type d` — expected result is no output; MUST surface any hit to the user before proceeding. |
| LD-07-050 | Import-Hygiene | MUST add a FINDINGS entry for the risk and a QUESTIONS entry asking whether to remove, quarantine, or leave it as-is, when import noise needs a user decision; the user's response authorizes cleanup. |
| LD-07-060 | Import-Hygiene | MUST load this file before inventorying or reading any file in a freshly imported legacy snapshot, never after noticing something suspicious. Not required for discovery work that doesn't touch a fresh import. |
