# Question Lifecycle

Questions are canonical registry rows. Any workflow may raise a Question when uncertainty blocks or materially
affects work; citing artifacts record its ID in `question_refs`. A resolution updates the same row to `resolved`
or `discarded`, fills its mandatory resolution fields, and updates affected work as necessary. A deferred
opportunity is an Idea, not a Question.

## Rules

| ID | Rule |
| --- | --- |
| QLC-01-010 | A Question resolution MUST update the canonical registry row rather than creating a duplicate record. |
| QLC-01-020 | Resolution basis MUST be durable IDs when available or a dated direct user decision otherwise. |
