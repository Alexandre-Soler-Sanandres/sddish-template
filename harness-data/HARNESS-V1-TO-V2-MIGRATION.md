# HARNESS-V1-TO-V2-MIGRATION.md — `sddish-template`

<!--
Not a lifecycle artifact. Historical migration evidence produced by IMPROVEMENT-0148.
It is never a compatibility reader and never a canonical runtime source: the v2
conversion (IMPROVEMENT-0149) and the v1 runtime retirement (IMPROVEMENT-0150) may
rely only on this ledger, Git history, and the canonical v2 definitions in
agent-harness/. Nothing here grants authority to any v1 record.
-->

## Purpose

The `IMPROVEMENT-0148` migration ledger for the canonical template repository. Its counterpart in
the `tw` repository (`tw` `harness-data/HARNESS-V1-TO-V2-MIGRATION.md`) carries the full per-record
inventory, the v1 → v2 path map, the conversion-rules-by-class section, and the validation results.
This file records the template's pre-conversion baseline and its (empty) v1 inventory.

## Pre-conversion snapshot

| Item | Value |
| --- | --- |
| `sddish-template` pre-conversion commit | `2d1d9adaa849bd4071db97b3e0a30f08f9be0c28` |
| `tw` pre-conversion commit (counterpart ledger) | `3909c6e88efa83314862b8074875767268d699c5` |
| `sddish-template` rule-migration pre-cutover commit (IMPROVEMENT-0146) | `980cda6` |
| `tw` rule-migration pre-cutover commit (IMPROVEMENT-0146) | `b844fa5` |
| `sddish-template` working tree at snapshot | clean |
| Hash function | `SHA-256` over raw file bytes (`sha256sum`) |
| Sequencing precondition | `IMPROVEMENT-0141`–`0147` all `done` (verified 2026-08-29) |

## Scope

Same in-scope definition as the `tw` ledger: every harness-governed v1 Markdown record under
`harness-data/artifacts/` (excluding `legacy/imported/**`), the three `QUESTIONS-{OPEN,RESOLVED,
DISCARDED}.md` registry files, and tracked lifecycle skeleton files.

## Per-record inventory

**Empty.** The template repository carries **no** v1 lifecycle records. Its `harness-data/artifacts/`
tree was already migrated to the v2 layout by `IMPROVEMENT-0141`–`0147`:

| Path | State |
| --- | --- |
| `harness-data/artifacts/questions/QUESTIONS.md` | Already the single v2 registry (`OUT-08-010`). `SHA-256 d76a4495e6740c93c9e7f9aa3ad63fa8a981d76931c779ba65e5a7bf9a749d6a`. No `QUESTIONS-OPEN/RESOLVED/DISCARDED.md` split exists. |
| `harness-data/artifacts/{adrs,changes,ideas,improvements,plans,reviews,specs,tasks,transcripts,use-cases}/` | Flat v2 type roots, each holding only a `.gitkeep` (`SHA-256 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b`). No lifecycle subfolders, no records. `plans/` (not `implementation-plans/`) and `changes/` already present. |
| `harness-data/artifacts/use-cases/**` … `harness-data/artifacts/adrs/**` | No `UC-*`, `SPEC-*`, `TASK-*`, `PLAN-*`, `REVIEW-*`, `IMPROVEMENT-*`, `IDEA-*`, `TRANSCRIPT-*`, `ADR-*`, or `LF-*` files. |
| `harness-data/artifacts/legacy/` | Absent — the Legacy Discovery Extension ships no data in the template. |

Git reconciliation: `git ls-files 'harness-data/artifacts/**'` returns exactly the single
`questions/QUESTIONS.md` plus ten `.gitkeep` type-root markers — zero v1 lifecycle records to
inventory or convert.

## Conversion actions for this repository

- **Records:** none.
- **Questions:** none to merge — the v2 registry already exists.
- **Skeleton:** the ten type-root `.gitkeep` files are already v2-correct (one per flat type root)
  and are retained as-is; no lifecycle-subfolder skeleton exists to retire.
- **Excluded, retained in place (not v1 records):** `harness-data/reference/{ARCHITECTURE,DOMAIN,
  QUALITY,TOOLING}.md`, `harness-data/playbooks/index.yaml`, `harness-data/guides/index.yaml`.

## Validation results (`IMPROVEMENT-0148`)

Run 2026-08-29 against `sddish-template` `2d1d9ad` (clean working tree).

- **In-scope file list resolved:** the inventory generator resolved 1 candidate
  (`harness-data/artifacts/questions/QUESTIONS.md`), which is already the v2 target, not a v1
  record — net v1 inventory is empty. No `adrs/ideas/specs/tasks/plans/reviews/improvements/
  transcripts/use-cases/legacy` record files exist.
- **Independent re-inventory:** re-run produced an identical (empty) v1 record set.
- **One disposition per source:** vacuously satisfied — no source records.
- **Unique valid `migrate` targets:** none required.
- **Sampling:** the one v2 file (`QUESTIONS.md`) was inspected and confirmed to already carry the
  v2 registry schema (single table, `open|resolved|discarded` status column).
- **Working-tree mutation check:** `git status --porcelain` shows only this new ledger file. No
  other file moved, rewritten, deleted, or re-statused.
- **`git diff --check`:** clean.
- **Ledger parity:** this ledger and the `tw` ledger share purpose, snapshot fields, scope
  definition, and (by reference) the conversion-rules-by-class text. The declared repository-specific
  difference is that `tw` carries 512 v1 records, 288 Question rows, and 30 lifecycle skeleton files
  while `sddish-template` carries none — the template was migrated to the v2 layout ahead of this
  ledger by `IMPROVEMENT-0141`–`0147`.
- **Rule-citation audit (`IMPR-05-010` / `COR-10-060`):** not triggered — `IMPROVEMENT-0148` adds
  historical-evidence Markdown only and changes no `*-` rule ID or Rules-table row.

### Result

**PASS.** The template repository has an empty, deterministic, reproduced v1 inventory. No
conversion work is pending here for `IMPROVEMENT-0149`; its work is entirely in `tw`.
