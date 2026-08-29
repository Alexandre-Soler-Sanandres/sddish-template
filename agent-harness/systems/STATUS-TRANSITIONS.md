# Status Transitions

## Closed transition model

| Type | States | Permitted transitions |
| --- | --- | --- |
| Change Spec, Use Case, Spec, Task, Plan | `draft`, `ready`, `in-progress`, `blocked`, `done`, `rejected`, `archived` | `draft -> ready -> in-progress -> done`; `in-progress <-> blocked`; `ready`, `in-progress`, or `blocked` -> `draft` after a material change; a nonterminal state -> `rejected` or `archived` |
| Improvement | `proposed`, `approved`, `in-progress`, `done`, `rejected`, `archived` | `proposed -> approved -> in-progress -> done`; any nonterminal -> `rejected` or `archived` |
| Review | `draft`, `assessed`, `closed`, `archived` | `draft -> assessed -> closed -> archived` |
| ADR | `proposed`, `accepted`, `superseded`, `archived` | `proposed -> accepted | archived`; `accepted -> superseded` |
| Idea | `active`, `accepted`, `rejected`, `archived` | `active -> accepted | rejected | archived` |
| Question row | `open`, `resolved`, `discarded` | `open -> resolved | discarded` |
| Transcript | `recording`, `recorded`, `archived` | `recording -> recorded -> archived` |

`done`, `rejected`, and `archived` executable work are terminal. Follow-on work receives a new ID and a
`source_ids` link. A material return to `draft` invalidates prior approval. A transcript normally ends in
`recorded`; `processed_into` records its effect without changing that state.

## Rules

| ID | Rule |
| --- | --- |
| STT-01-010 | Artifacts MUST use only the states and transitions in this table. |
| STT-01-020 | A material scope or behavior change from a ready, in-progress, or blocked executable artifact MUST return it to draft and invalidate approval. |
| STT-01-030 | Terminal executable states MUST NOT reopen; follow-on work MUST use a new ID linked by `source_ids`. |
| STT-01-040 | A controlled migration MAY preserve semantic status while changing representation and MUST NOT be treated as an ordinary transition. |
