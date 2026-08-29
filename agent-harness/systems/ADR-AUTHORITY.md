# ADR Authority

An ADR becomes citable authority only at `status: accepted`. Consumers cite it in `related_adrs`; it never keeps
a handwritten consumer list. A changed accepted decision requires a new ADR linked through `related_adrs`, with
the older ADR becoming `superseded`.

## Rules

| ID | Rule |
| --- | --- |
| ADR-01-010 | Only an accepted ADR MUST be treated as settled authority. |
| ADR-01-020 | An artifact that depends on an ADR MUST cite it through `related_adrs`. |
| ADR-01-030 | A changed accepted decision MUST use a new ADR and MUST NOT rewrite the accepted decision in place. |
