# REVIEW Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| RVW-01-010 | Escalation | The agent MUST NOT autonomously re-enter a producing mode after `changes-requested`, `rejected`, or `follow-up-required` — the user must explicitly request the next action. |
| RVW-02-010 | Boundaries | MUST NOT change the substantive content of the artifact under review as part of the review itself (status transitions and explicitly prescribed follow-up metadata updates are allowed). |
| RVW-02-011 | Boundaries | MUST NOT implement fixes as part of a review. |
| RVW-02-012 | Boundaries | MUST NOT create Tasks or Specs as a side effect of a review. |
| RVW-02-013 | Boundaries | MUST NOT modify harness files as part of a review, without an Improvement artifact. |
| RVW-03-010 | Procedure | MUST load the relevant playbook before reviewing, when the review target matches a specialized review procedure. |
| RVW-03-020 | Procedure | Playbooks MAY refine how the review is performed; they do not change Review outcomes, follow-up actions, or mode boundaries (`COR-04-070`). |
| RVW-04-010 | Flavor | `target_type` determines the flavor (see `REVIEW.md`'s Two Flavors) — MUST use the matching Criteria Checklist and After-Review action table for that flavor, not a mix of both. |
| RVW-05-010 | Required-Actions | MUST take exactly the action listed in the matching After-Review table for the recorded Outcome before stopping. |
| RVW-05-020 | Required-Actions | MUST NOT improvise or skip the required status change, archive move, or artifact creation named by `RVW-05-010`. |
| RVW-06-010 | Closure | A harness/process-flavored Review with `outcome: follow-up-required` MUST move `active/` → `archive/` and set `status: resolved` once every `follow_up` Improvement ID reaches `done` or `rejected`. |
| RVW-06-020 | Closure | A harness/process-flavored Review stays `status: assessed` in `active/` while `follow_up` is empty or contains a non-terminal Improvement. |
| RVW-06-030 | Closure | MUST add a `## Closure` section (date, terminal Improvement ID(s), `done`/`rejected` for each) as part of the `RVW-06-010` move. |
| RVW-06-040 | Closure | A product/requirements-flavored Review with `outcome: changes-requested` or `accepted-with-notes` MUST move `active/` → `archive/` and set `status: resolved` only once the user confirms every finding is addressed or explicitly waived — never on the agent's own initiative. |
| RVW-06-041 | Closure | Before that confirmation such a Review stays `status: assessed` in `active/`. |
| RVW-06-042 | Closure | MUST add a `## Closure` section (date; per finding: disposition `addressed` / `waived` / `open-by-design`, and the resolving artifact and mode or user instruction; `open-by-design` only where the user chose to leave the finding open), matching the `## Finding Disposition` rows, as part of the `RVW-06-040` move. |
| RVW-06-043 | Closure | A product/requirements-flavored Review SHOULD maintain a `## Finding Disposition` table (columns Finding, Status, Updated, Evidence; `Status` one of `open` / `addressed` / `waived` / `open-by-design`) as findings are resolved; the harness/process flavor omits it and uses `follow_up` instead. |
| RVW-07-010 | Discard | A Review MAY move to `status: discarded` (→ `archive/`) only on the user's explicit instruction that no further work will happen for it. |
| RVW-07-011 | Discard | That instruction MUST NOT be inferred from a stalled draft or an unresolved `follow_up` alone (`COR-01-090` governs inferred approval generally). |
| RVW-07-020 | Discard | Reachable from `draft` (`outcome` MAY stay unset) or `assessed` (`outcome`/`follow_up` stay as recorded). |
| RVW-07-030 | Discard | MUST add a `## Discard Note` (date, reason) as part of the `RVW-07-010` move. |
| RVW-07-040 | Discard | MUST NOT use `discarded` in place of `RVW-06-010` or `RVW-06-040` once a `follow_up` Improvement has gone terminal, or once the user has confirmed a product/requirements Review's findings are all addressed or waived. |
| RVW-07-050 | Discard | When the user explicitly declines further follow-up for a Review's finding, MUST apply `RVW-07-010` that same turn, not merely acknowledge it in conversation. |
