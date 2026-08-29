# Glossary

## Harness File Taxonomy

These are the canonical terms for files under `agent-harness/` and their project-owned support counterparts.

**Mode Workflow**
A rich agent-facing guide under `agent-harness/modes/` that teaches how to operate in one true Mode: posture,
route choices, workflow paths, handoffs, examples, and common failure modes. A Mode Workflow guides; its
enforceable obligations live in its own `## Rules` section in the same file.

**Artifact Contract**
An agent-facing contract under `agent-harness/artifact-specs/` that defines what one artifact type means, when it
is created, what shape it takes, how its fields and lifecycle work, and what makes it valid. Artifact Contracts
define; they are not Mode Workflows.

**Procedure Guide**
A reusable harness-native procedure under `agent-harness/shared-procs/` that is invoked by name from mode or
artifact control flow. Procedure Guides run repeatable steps required by the harness model. They are not optional
support playbooks.

**System**
An agent-facing operating-model explanation under `agent-harness/systems/` for a mechanism that spans multiple
rules, artifacts, statuses, or procedures. Systems explain interactions; they are not human-only docs and not
Rules tables.

**Rules**
Enforceable constraints with stable rule IDs. Rules constrain gates, approvals, statuses, validation, loading,
traceability, safety boundaries, and other behavior that must be auditable by ID. Every rule lives in a `## Rules`
section inside the Workflow, Contract, Procedure Guide, or System it belongs to — `CORE.md` and `OUTPUTS.md` hold
the universal and output rules the same way. There is no separate rules tree.

**Rules section**
The `## Rules` section a source file carries directly, holding its ID'd enforceable rule rows. Larger files may
split it into `###` subsections by concern (see `CORE.md`). A superseded pre-v2 rule set retained for the
migration window sits in a `### Legacy (v1)` subsection with `-v1`-suffixed IDs.

**Template**
A lean scaffold under `agent-harness/templates/`: frontmatter keys, section headings, checklists, placeholders,
and short field prompts. Templates scaffold; they do not teach artifact theory or mode workflow.

**Guide**
An optional project-owned support file under `harness-data/guides/` that explains local setup, tooling usage,
operating context, or repository-specific practical knowledge. Guides are selected through
`harness-data/guides/index.yaml`.

**Playbook**
An optional support file for a recurring task shape. Universal playbooks live under `agent-harness/playbooks/`;
project playbooks live under `harness-data/playbooks/`. Playbooks are selected through their `index.yaml` files.

Short form: Rules constrain. Workflows guide. Contracts define. Procedures run. Systems explain interactions. Templates scaffold.

## Artifact And Process Terms

**Artifact**
A Markdown file representing a structured unit of work or knowledge, such as an Idea, ADR, Use Case, Spec, Task,
Plan, Review, Improvement, Transcript, or Question. Each artifact type's meaning, shape, creation trigger, and
lifecycle gate is defined by an Artifact Contract under `agent-harness/artifact-specs/`.

**Mode**
A true, distinct behavioral posture the agent adopts — defines what the agent may do, not what document it
produces. Only one mode is active at a time; switching happens only on explicit user request. The six modes are
Partnering, Refining, Planning-Implementation, Implementing, Discovering-Legacy, and Improving-Harness. Each Mode
is described by a Mode Workflow.

**Artifact Spec**
Legacy name for an Artifact Contract under `agent-harness/artifact-specs/`. Current docs should prefer Artifact
Contract when discussing the file role.

**Shared Procedure**
A legacy/general name for a Procedure Guide under `agent-harness/shared-procs/`: a reusable procedure invoked by
name from within a mode or artifact rule. No schema and no artifact of its own.

**Partnering**
Conversational mode for capture, clarification, and idea formation. The front door for unclear thinking.

**Refining**
Mode that derives the next artifact in the Use Case → Spec → Task funnel from its immediate source: a Spec from a Use Case, or Tasks from a Spec — neither gated on the source's own status — or directly from a lower-tier source when `RISK-TIER.md` classifies the layer above as unnecessary. Owns the mechanical derivation activity only — the resulting artifact's meaning, schema, and lifecycle rules live in its Artifact Contract.

**Work Lane**
A proportional assurance classification for new material work: Fast, Standard, or Assured. It determines the
execution contract, approval, and persistence required for the unchanged scope.

**Change Spec**
The Standard-lane durable execution contract. It combines behavior, scope, non-goals, paths, acceptance evidence,
approval, and executable steps in one artifact.

**Planning-Implementation**
The Assured/v1 planning mode that produces a separately resumable Implementation Plan where that contract is required.

**Implementing**
Mode that executes a ready lane-authorized execution contract: a Fast micro-plan, Standard Change Spec, or Assured/v1 Implementation Plan.

**Discovering-Legacy**
Mode for analyzing existing code and documentation to derive artifacts without implementing. The legacy project is evidence, not authority.

**Improving-Harness**
Mode that changes the harness itself. Only triggered by a harness/process-flavored Review finding, never from Partnering or a direct request. The only mode allowed to modify `agent-harness/*`.

**Use Case**
A behavioral anchor that describes who does what, under what conditions, and with what observable outcome. Created from Ideas, Transcripts, Partnering discussions, Legacy Findings, or existing documentation.

**ADR (Architecture Decision Record)**
A settled structural or architectural decision — durable and citable, unlike an Idea. May be drafted by any mode when the conversation or work reaches a settled structural or architectural decision, not only Partnering (`docs/01-core-principles.md`, `docs/05-workflows.md`'s "ADR Creation" section) — becomes citable authority only once `accepted`. Immutable once `accepted`; a change of direction produces a new ADR that supersedes it.

**Idea**
A candidate opportunity or problem worth remembering before it is mature enough to commit to a Use Case — deliberately lightweight and fuzzy. Distinguished from a Question by having at least a rough candidate solution/direction ("we might build/do X").

**Transcript**
The raw or lightly processed record of a Partnering conversation, written proactively. Evidence, not approved requirements.

**Question**
A durable, discoverable registry entry for an unresolved (or resolved) point that needs a decision before some artifact can be trusted as final. May be raised from any mode without switching mode. Classified by blast radius (`local` / `cross-artifact` / `systemic`), not by origin. Distinguished from an Idea by having no proposed solution shape yet ("we haven't decided whether/how to X"). IDs are permanent — a resolved or discarded question moves to a different file, never deleted.

**Spec**
The source of truth for desired behavior. Created from a Use Case — or directly from a lower-tier source when `RISK-TIER.md`'s UC-Necessity Matrix classifies a Use Case unnecessary. Defines problem, goal, scope, requirements, acceptance criteria, and risks.

**Task**
An optional executable work unit derived from a Spec (any status) when smaller, traceable slices are needed.

**Implementation Plan**
A required plan that defines how implementation will proceed before any code is changed. Must be `ready` before Implementing mode may start.

**Validation**
A Procedure Guide — not a mode, not an Artifact Contract — that checks artifacts, plans, and implementations against process and behavioral criteria. Does not run technical checks. Invoked by name from within Implementing and Improving-Harness.

**Review**
A structured assessment of an artifact, implementation, or process result. How process problems are discovered.

**Harness Improvement**
A controlled change to the harness itself, derived from Review findings. Produced only from within Improving-Harness.

**Frontmatter**
YAML metadata at the top of Markdown artifacts, used for IDs, status, traceability, and context loading.

**Input Channel**
Voice, chat, or text — the mechanism by which input is received. Not a mode. Partnering is the mode regardless of input channel.

**Mode Transition**
Switching from one mode to another. Only happens when the user explicitly requests it. Ambiguous intent must be clarified first.

**Inline Plan**
An Implementation Plan that contains steps without separate Task artifacts — valid for small, low-risk, single-area Specs.

**technical_refs**
A Spec frontmatter field for linking to external technical artifacts (OpenAPI specs, database schemas, contracts) that live outside `agent-harness/`.

**SUMMARY.md**
An optional lightweight navigation file created per artifact directory when the number of artifacts makes discovery difficult.

**CATALOG.md**
A tiny harness navigation file listing artifact locations. Not a god-index.

**God-Index Anti-Pattern**
The failure mode where an agent loads a massive index of every artifact instead of navigating from a specific referenced artifact. Causes context collapse and loss of precision.

**Legacy Finding**
An artifact recording a single piece of evidence extracted from a legacy project — observed behavior, documented behavior, inferred intent, accidental complexity, or dead/uncertain code. Scoped per app or cross-system; see `agent-harness/modes/DISCOVERING-LEGACY.md`.

**Readiness Checklist**
A section present in every artifact template. Every item must be checked before the agent advances the artifact to its gate status (e.g. Spec to `ready`, Task to `ready`). A single unchecked item blocks the status change.

**Task Decision Matrix**
The table in `agent-harness/modes/REFINING.md` used to decide whether a Spec needs separate Task artifacts or can proceed straight to an inline Implementation Plan.

**allowed_paths / forbidden_paths**
Task frontmatter fields that constrain implementation scope during Implementing mode. The agent must not modify files outside `allowed_paths` or inside `forbidden_paths`.

**RUN-LOG.md**
An optional, temporary operational trace at `harness-data/RUN-LOG.md` used for interrupted, approval-heavy, or high-risk work. Not a source-of-truth artifact; kept small and collapsed or cleared when work finishes. Writing to it is mandatory in one case: the Implementing-mode gate-check required by `IMPL-02-010`, recorded before the first file mutation of a plan step.
