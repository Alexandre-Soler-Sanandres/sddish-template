# Questions Registry

## Purpose

The Questions registry is the single durable backlog for unresolved decisions. It is a table at
`harness-data/artifacts/questions/QUESTIONS.md`, not a collection of lifecycle files.

## Row schema

| Field | Meaning |
| --- | --- |
| ID | Stable `Q-NNNN` ID. |
| Status | `open`, `resolved`, or `discarded`. |
| Question | The unresolved decision or uncertainty. |
| Classification | `local`, `cross-artifact`, or `systemic`. |
| Impact | `blocking`, `material`, or `none`. |
| Source IDs | Canonical IDs that raised it. |
| Resolution / Disposition | Required for terminal rows: chosen answer or reason it is no longer material. |
| Resolution basis | IDs that settled it, or dated direct user decision when no durable artifact exists. |
| Follow-up | `none` or successor artifact ID. |
| Resolved at | Required terminal date. |

## Rules

| ID | Rule |
| --- | --- |
| QST-06-010 | A Question MUST represent an uncertainty that blocks or materially affects current work; a deferred opportunity MUST be an Idea. |
| QST-06-020 | An artifact that depends on an unresolved Question MUST cite its ID in `question_refs`. |
| QST-07-010 | A terminal Question row MUST contain Resolution / Disposition, Resolution basis, Follow-up, and Resolved at. |
| QST-09-010 | Question IDs MUST be unique and MUST NOT be deleted or reused. |
| QST-10-010 | A resolved row MUST state the chosen answer; a discarded row MUST state why it is no longer material. |
