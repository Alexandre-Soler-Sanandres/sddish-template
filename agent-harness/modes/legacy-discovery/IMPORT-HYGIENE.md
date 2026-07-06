# IMPORT-HYGIENE.md

## Purpose

Handling secret-like and noisy files when a legacy codebase snapshot is imported for discovery.

Load this file before inventorying or reading files in a freshly imported legacy snapshot — not after noticing
something suspicious. `LD-07-010`'s by-path-only scanning discipline only works if it's followed from the first
file touched; deferring this file until content looks secret-like defeats the point, since spotting that already
requires opening it. Not needed for discovery work that doesn't touch a fresh import.

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-07-010 | Import-Hygiene | During normal discovery, inventory `.env`, `.env.*`, `.env.local`, `secrets/`, `*.key`, `*.pem`, password files, token files, logs, caches, virtual environments, coverage output, test artifacts, generated metadata, egg-info, and build output by path only — do not open contents. |
| LD-07-020 | Import-Hygiene | Open log contents only in an explicit log or security discovery slice, after confirming they do not contain secrets. |
| LD-07-030 | Import-Hygiene | Do not remove or rewrite imported artifacts during normal discovery. |
| LD-07-040 | Import-Hygiene | Before committing an imported snapshot or import-hygiene change, verify nested Git metadata: `find harness-data/artifacts/legacy/apps/<legacy-app-slug> -path '*/.git' -type d` — expected result is no output. Surface any hit to the user before proceeding. |
| LD-07-050 | Import-Hygiene | When import noise needs a user decision, add a FINDINGS entry for the risk and a QUESTIONS entry asking whether to remove, quarantine, or leave it as-is. The user's response authorizes cleanup. |
