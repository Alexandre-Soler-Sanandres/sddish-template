# Glossary

**Artifact**  
A Markdown file representing a structured unit of work or knowledge, such as an Idea, ADR, Use Case, Spec, Task, Plan, Review, Improvement, Transcript, or Question. Each artifact type's schema, creation trigger, and lifecycle gate is defined by an **artifact spec** under `agent-harness/artifact-specs/`.

**Mode**  
A true, distinct behavioral posture the agent adopts — defines what the agent may do, not what document it produces. Only one mode is active at a time; switching happens only on explicit user request. The six modes are Partnering, Refining, Planning-Implementation, Implementing, Discovering-Legacy, and Improving-Harness. Contrast with **artifact spec** (a document schema, not a behavior) and **shared procedure** (a checklist invoked from within a mode).

**Artifact Spec**  
The schema, creation trigger, and lifecycle gate for one document type, under `agent-harness/artifact-specs/`. Producing or updating one does not require switching mode — any mode's own rules may invoke one directly (as ADR and Questions have always worked). Contrast with **Mode**.

**Shared Procedure**  
A checklist invoked by name from within a mode's own rules, under `agent-harness/shared-procs/`. No schema and no artifact of its own — currently only Validation.

**Partnering**  
Conversational mode for capture, clarification, and idea formation. The front door for unclear thinking.

**Refining**  
Mode that derives the next artifact in the Use Case → Spec → Task funnel from its immediate source: a Spec from a Use Case at `ready-for-spec`, or Tasks from an approved Spec. Owns the mechanical derivation activity only — the resulting artifact's own schema and lifecycle rules live in its artifact spec.

**Planning-Implementation**  
The mandatory gate mode before any code change. Inspects the artifact, gathers downstream artifacts, verifies maturity, and produces an Implementation Plan.

**Implementing**  
Mode that executes an approved Implementation Plan. Invokes Validation as its own closing gate after each step.

**Discovering-Legacy**  
Mode for analyzing existing code and documentation to derive artifacts without implementing. The legacy project is evidence, not authority.

**Improving-Harness**  
Mode that changes the harness itself. Only triggered by a harness/process-flavored Review finding, never from Partnering or a direct request. The only mode allowed to modify `agent-harness/*`.

**Use Case**  
A behavioral anchor that describes who does what, under what conditions, and with what observable outcome. Created from Ideas, Transcripts, or Partnering discussions.

**ADR (Architecture Decision Record)**  
A settled structural or architectural decision — durable and citable, unlike an Idea. Produced from Partnering when the conversation reaches a decision rather than a scenario or a hunch. Immutable once `accepted`; a change of direction produces a new ADR that supersedes it.

**Idea**  
A candidate opportunity or problem worth remembering before it is mature enough to commit to a Use Case — deliberately lightweight and fuzzy. Distinguished from a Question by having at least a rough candidate solution/direction ("we might build/do X").

**Transcript**  
The raw or lightly processed record of a Partnering conversation, written proactively. Evidence, not approved requirements.

**Question**  
A durable, discoverable registry entry for an unresolved (or resolved) point that needs a decision before some artifact can be trusted as final. May be raised from any mode without switching mode. Classified by blast radius (`local` / `cross-artifact` / `systemic`), not by origin. Distinguished from an Idea by having no proposed solution shape yet ("we haven't decided whether/how to X"). IDs are permanent — a resolved or discarded question moves to a different file, never deleted.

**Spec**  
The source of truth for desired behavior. Always created from a Use Case. Defines problem, goal, scope, requirements, acceptance criteria, and risks.

**Task**  
An optional executable work unit derived from an approved Spec when smaller, traceable slices are needed.

**Implementation Plan**  
A required plan that defines how implementation will proceed before any code is changed. Must be approved before Implementing mode may start.

**Validation**  
A shared procedure — not a mode, not an artifact spec — that checks artifacts, plans, and implementations against process and behavioral criteria. Does not run technical checks. Invoked by name from within Implementing and Improving-Harness.

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
A section present in every artifact template. Every item must be checked before the agent advances the artifact to its gate status (e.g. Spec to `approved`, Task to `ready`). A single unchecked item blocks the status change.

**Task Decision Matrix**  
The table in `agent-harness/modes/REFINING.md` used to decide whether a Spec needs separate Task artifacts or can proceed straight to an inline Implementation Plan.

**Playbook**  
An optional support file describing a reusable procedure for a recurring task shape. Universal playbooks live under `agent-harness/playbooks/` and apply across projects; project playbooks live under `harness-data/playbooks/` and refine the generic procedure for one repository. See `agent-harness/docs/11-project-playbooks.md`.

**allowed_paths / forbidden_paths**  
Task frontmatter fields that constrain implementation scope during Implementing mode. The agent must not modify files outside `allowed_paths` or inside `forbidden_paths`.

**RUN-LOG.md**  
An optional, temporary operational trace at `harness-data/RUN-LOG.md` used for interrupted, approval-heavy, or high-risk work. Not a source-of-truth artifact; kept small and collapsed or cleared when work finishes. Writing to it is mandatory in one case: the Implementing-mode gate-check required by `IMPL-02-010`, recorded before the first file mutation of a plan step.
