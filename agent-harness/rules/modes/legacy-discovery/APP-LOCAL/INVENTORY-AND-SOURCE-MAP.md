# APP-LOCAL / Inventory-and-Source-Map Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LDA-01-010 | Inventory | App `INVENTORY.md` MUST use `agent-harness/templates/INVENTORY-template.md`: fixed `Scope`, `Identity`, `Major Runtime Areas`, `Operations, Tooling, and Quality`, and `Inventory Gaps` sections, plus as many app-specific structural sections as the app's own shape needs in between. |
| LDA-01-020 | Inventory | MUST name app-specific sections after what they actually cover in this app, not copy another app's section names. |
| LDA-01-030 | Inventory | MUST create `INVENTORY.md` and `SOURCE-MAP.md` together for a newly-selected app, before reading evidence into any `LF-<APP>-NNN.md` finding for that app. |
| LDA-02-010 | Source-Map | Each app `SOURCE-MAP.md` (the app restart point, per `SOURCE-MAP-template.md`) MUST stay app-local, containing only: source root, primary evidence files, code areas, and candidate discovery slices; block list/status when blockwise; slice status table, completed notes, open app notes, restart pointers, and reference enrichment routing; deferred/cross-system Question ID references (per `COR-01-120` — classification itself lives only in the Questions registry, never duplicated here) before `app-local-complete`; import hygiene when the snapshot has secret-like files, local artifacts, or nested repo metadata. |
| LDA-02-016 | Source-Map | At creation time (`LDA-01-030`), `SOURCE-MAP.md` MUST have `Source Root` filled in and a `Slice 0: Baseline inventory and import hygiene` row present in `Candidate Discovery Slices` (or `Current Status`, once slice work starts) with status `pending` or `next`. This is a minimum-at-creation floor, distinct from `LDA-02-010`'s ceiling on total allowed content once discovery is underway — `LDA-02-010` still governs what the file may contain as discovery proceeds; this rule only governs what must already be true at `t=0`. This fixed bootstrap slice name is a deliberate exception to `LDA-03-020`'s app-discretionary slice list, not a precedent for copying other slice names. |
| LDA-02-020 | Source-Map | MUST NOT copy generic slice rules, block rules, roundtrip steps, cross-system judgments, or reusable process policy into app source maps. |
