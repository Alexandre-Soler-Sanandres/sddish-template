# CORE / Rule-Authoring Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-10-010 | Rule-Authoring | When a mode file, artifact spec, shared-proc, template, or paired source file's descriptive prose states an expectation of agent behavior, MUST back it with a corresponding ID'd rule in that file's own Rules table, the paired `agent-harness/rules/` table or grouped rules directory where one exists, or the template's own guidance line for templates. Prose may explain *why*. |
| COR-10-011 | Rule-Authoring | Prose MUST NOT be the only place an enforceable *must/should* lives — the backing rule required by `COR-10-010` is what makes it enforceable. |
| COR-10-020 | Rule-Authoring | When a Review finding traces back to prose-only intent in a file with paired rules, the resulting Improvement MUST add the missing rule to that paired rules file or group; otherwise it MUST add the missing rule to the specific file found. |
| COR-10-021 | Rule-Authoring | MUST NOT treat the `COR-10-020` instance as fully closed until the missing rule is added. |
| COR-10-030 | Rule-Authoring | State every rule's obligation strength using exactly one RFC 2119 keyword per rule (`MUST` / `MUST NOT` / `SHOULD` / `SHOULD NOT` / `MAY`, per RFC 2119/RFC 8174 (BCP 14)) — capitalized; lowercase modal words carry no special meaning. |
| COR-10-031 | Rule-Authoring | MUST NOT use an ad hoc substitute ("always," "never," "do not," "should probably") in place of a keyword where the keyword conveys the same obligation more precisely. |
| COR-10-040 | Rule-Authoring | MUST state rule text as concisely as possible while preserving every distinction, condition, exception, and cross-reference the rule currently enforces — the agent's ability to apply the rule correctly to every case it covers today must not shrink. |
| COR-10-041 | Rule-Authoring | MUST NOT cut content, nuance, or edge-case coverage to save length; only cut redundant wording, restated context available elsewhere, or filler that adds no decision-relevant information. |
| COR-10-050 | Rule-Authoring | Rule text MUST NOT rely on an inline example ("e.g.", "such as", "for instance") to convey scope; state the general condition precisely enough that no example is needed. When an example remains genuinely useful to the reader, place it in the file's surrounding prose (Purpose section or similar), not inside the Rule table row. |
| COR-10-060 | Rule-Authoring | When an Improvement creates, deletes, renames, or physically moves a Rules-table row or Rules table, MUST perform a rule-ID citation audit using the agent's available inspection/search capabilities rather than repo-local validation tooling. |
| COR-10-061 | Rule-Authoring | For deletes, renames, or physical moves covered by `COR-10-060`, MUST run the citation audit before and after the change and record both the baseline and post-change result. |
| COR-10-062 | Rule-Authoring | The `COR-10-060` citation audit MUST verify every cited rule ID resolves to exactly one defined Rules-table row, no rule ID is defined more than once, and required scan roots are covered and reported in the Improvement's validation result. |
| COR-10-063 | Rule-Authoring | Rule-ID citation audits MUST NOT add repo-local checker scripts, generated indexes, or copied validation artifacts to adopter repos; template-maintenance automation, if pursued, belongs in a separate template-repository Improvement. |
| COR-10-070 | Rule-Authoring | Harness source files MUST preserve the taxonomy defined in `agent-harness/docs/08-glossary.md`: Mode Workflows guide, Artifact Contracts define, Procedure Guides run, Systems explain interactions, Rules constrain, and Templates scaffold. |
| COR-10-071 | Rule-Authoring | Rules files under `agent-harness/rules/` MUST hold enforceable rule tables only: gates, approvals, statuses, validation, loading, traceability, safety boundaries, or other behavior that must be auditable by rule ID. |
| COR-10-072 | Rule-Authoring | Workflow, Contract, Procedure, and System files MUST keep explanatory prose out of Rules tables unless the statement is intended as an enforceable constraint backed by an ID'd rule. |
| COR-10-073 | Rule-Authoring | Templates MUST stay lean scaffolds: frontmatter keys, section headings, checklists, placeholders, and short field prompts; artifact theory, mode workflow, system explanations, and enforceable constraints belong in the appropriate source or paired rules file. |
