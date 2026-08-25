# CORE / Context-Loading Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-03-010 | Context-Loading | MUST start context loading from the user request. |
| COR-03-020 | Context-Loading | MUST use `agent-harness/CATALOG.md` when the artifact identity is unknown or ambiguous. |
| COR-03-030 | Context-Loading | MUST load the explicitly referenced artifact before exploring related artifacts. |
| COR-03-040 | Context-Loading | MUST load the active true-Mode file (`agent-harness/modes/`) before taking mode-specific action. A true Mode is one of: Partnering, Implementing, Discovering-Legacy, Improving-Harness, Planning-Implementation, Refining. |
| COR-03-045 | Context-Loading | When loading a harness source file that has paired rules, MUST load the paired `agent-harness/rules/<same-relative-path>.md` file or consult the source file's Rules Map and load the relevant files under `agent-harness/rules/<same-relative-path-without-.md>/`; if the needed group is unclear or the agent is editing/auditing rules, load every group; files with no paired rules are unaffected, and files under `agent-harness/rules/` do not recursively pair. |
| COR-03-046 | Context-Loading | The initial harness load block MUST include `AGENTS.md`, `agent-harness/CORE.md` plus required CORE rule groups, `agent-harness/OUTPUTS.md` plus paired rules when present, the active Mode Workflow plus paired mode rules when present, the explicitly referenced artifact, and the relevant Artifact Contract plus paired artifact rules when creating, updating, or reviewing an artifact. |
| COR-03-047 | Context-Loading | On a true Mode transition, MUST reload the initial harness load block for the newly active Mode Workflow and current restart or referenced artifact. |
| COR-03-048 | Context-Loading | After initial loading, MUST expand context to additional cited or referenced harness files, rule groups, Systems, Artifact Contracts, Procedure Guides, support-file index matches, validation or approval gates, and linked artifacts when they become relevant to the current action; stop expanding once the needed rule, procedure, system, or context is understood. |
| COR-03-050 | Context-Loading | MUST NOT load linked parent or child artifacts unless they are required for the current task. |
| COR-03-055 | Context-Loading | MUST NOT exclude an in-scope file or evidence source based only on assumed triviality, filename convention, or boilerplate appearance. |
| COR-03-056 | Context-Loading | `smallest sufficient context` MUST limit reading depth within in-scope material, not whether that material is read. |
| COR-03-060 | Context-Loading | SHOULD prefer summaries before full historical artifacts when both are available. |
| COR-03-070 | Context-Loading | MUST NOT load reference files unless the current task is directly affected by them. |
| COR-03-080 | Context-Loading | MUST NOT load archived artifacts unless they are explicitly needed. |
| COR-03-090 | Context-Loading | MUST also load that artifact type's spec under `agent-harness/artifact-specs/` before creating or updating an artifact, in addition to the active Mode file (`COR-03-040`). |
| COR-03-100 | Context-Loading | MUST NOT load `agent-harness/shared-procs/` by default — load only when a shared procedure is actually invoked by name from the active mode file's own rules. |
| COR-03-110 | Context-Loading | A delegation prompt to a sub-agent doing mode-scoped work MUST name, as required reading for that sub-agent: `CORE.md` plus its relevant grouped rules, the active mode file plus paired rules where present, and the relevant artifact spec plus paired rules where present — the same set `COR-03-040`/`COR-03-045`/`COR-03-090` require the primary agent to load. This does not require the sub-agent to read every reference file (`COR-03-070` still applies); it only stops the mode/spec/core layer being left to the orchestrator's own prompt wording. |
