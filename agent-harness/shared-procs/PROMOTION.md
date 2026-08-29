# Promotion

## Purpose

Perform one atomic lifecycle transition after deterministic and semantic promotion gates pass.

## Procedure

1. Validate schema, required sections, links, lane, scope conflicts, Questions, ADRs, acceptance/evidence intent,
   and current approval/hash.
2. Reclassify when material inputs changed.
3. Enforce the closed transition matrix.
4. On a material return to `draft`, invalidate approval.
5. Write the status transition and its evidence atomically.

## Rules

| ID | Rule |
| --- | --- |
| PRM-01-010 | Promotion MUST run common schema, link, scope, approval, Question, ADR, evidence, and transition checks once, including no open `changes-requested` or `rejected` Review finding, resolved scope-affecting blockers, and every included or scope-affecting dependency at an accepted status. An unrelated draft or blocked sibling outside a scoped Plan does not block promotion. |
| PRM-01-020 | Promotion MUST invalidate stale approval when a material change returns executable work to draft. |
| PRM-01-030 | Promotion MUST perform one atomic status transition only after applicable gates pass. |
