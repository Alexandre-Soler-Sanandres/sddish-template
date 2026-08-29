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

### Legacy (v1)

Retained verbatim from the pre-v2 paired rules for active v1 UC/Spec/Task/Plan chains during the v2 cutover
(`IMPROVEMENT-0148`–`0150`). The v2 rows above are authoritative for all new work; the v2 numbering reuses the
`STT-01-*` range for a different, smaller model, so these keep a `-v1` suffix. Cross-references to `IPL`/`TSK`/
`SPS`/`UCS` rules point at those contracts' current (unsuffixed) gate rules, which the Assured lane still uses.
Retired by `IMPROVEMENT-0150`.

| ID | Rule |
| --- | --- |
| STT-01-010-v1 | When a significant change lands on a Use Case or Spec already at `ready` or later, MUST reset that artifact to `draft`, recursively reset every child derived from it the same way, leave Implementation Plans unchanged, and stop for user instruction after the reset. |
| STT-01-020-v1 | Implementing MUST set a Task or Plan to `in-progress` when work starts and to `done` when work completes; a Spec or Use Case MAY become `done` only when it is already `ready` and every derived child is `done`; if all children are `done` while that parent is `draft` or `blocked`, leave it unchanged and report the missing readiness transition. |
| STT-01-030-v1 | An explicitly user-approved Plan promotion MAY set the Plan and only its declared included Tasks to `ready` when their local gates pass fresh (`IPL-02-010`-`019`, `IPL-05-010`/`011`; `TSK-02-010`-`012`, `TSK-06-010`-`040`) and a no-mutation scoped `chain-preflight` proves complete included/sibling accounting, no scope-affecting excluded dependency or blocker, and no Plan conflict; the same atomic transaction MUST populate approval provenance and the catalog, while any failure leaves that Plan scope unchanged. A `draft`, `blocked`, or absent sibling recorded outside the scope does not itself abort the promotion. Then evaluate each source Spec and ancestor Use Case bottom-up: promote a parent only when every direct child is `ready`, `done`, or being promoted in that transaction and its fresh local gates pass (`SPS-02-010`-`012`, `SPS-05-011`, `SPS-08-010`-`030`; `UCS-03-010`-`012`, `UCS-05-015`, `UCS-07-010`-`030`); otherwise leave that parent and higher ancestors unchanged and record why. The scoped Plan promotion remains valid when an optional parent promotion fails. The walk stops at Use Case, a risk-tier skip path truncates it at the chain's real end, and promotion by this rule does not itself count as a significant change for `STT-01-010-v1`. |
| STT-01-040-v1 | An explicit operator instruction naming a specific Task, Spec, or Use Case MAY set only that artifact to `ready` when its own artifact-local promotion gates pass fresh against current content (`TSK-02-010`-`012`, `TSK-06-010`-`040`; `SPS-02-010`-`012`, `SPS-05-011`, `SPS-08-010`-`030`; `UCS-03-010`-`012`, `UCS-05-015`, `UCS-07-010`-`030`); child fan-out is not required on this path, `STT-01-030-v1` and `STT-01-040-v1` are the only paths by which a Task, Spec, or Use Case reaches `ready`, and a Plan has no separate manual-instruction row because `STT-01-030-v1` is already that manual gate for the Plan itself. |
| STT-01-050-v1 | When an Idea is promoted into a next-tier artifact or incorporated as an in-place amendment to an existing Use Case or Spec, MUST close the Idea by setting `status` to `landed`, populating `next` with the citing artifact ID, and moving it to `archive/`; this does not wait for the citing artifact to reach `done`. |
| STT-02-010-v1 | Whenever an artifact in the Idea -> Use Case -> Spec -> Task -> Plan chain moves off a status that `STT-01-010-v1`, `STT-01-020-v1`, `STT-01-030-v1`, `STT-01-040-v1`, or `STT-01-050-v1` set, for a reason other than another `STT-01-*-v1` rule already having set it again, MUST reconsider every other artifact in the chain, in either direction, whose own status depended on that fact. |
| STT-02-011-v1 | MUST report the outcome of `STT-02-010-v1` explicitly, including when the result is `no change needed`. |
