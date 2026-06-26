**Spec Driven Agent Harness**  
Version: 4.1  
   
 Status: Updated  
   
 Language: English  
   
 Changes in v4.1:  
 - Modes are universal, references are project-specific (new section 7.2a and updated 23.4)  
 - Validation mode scoped to process/artifact/harness checks only; technical checks belong to Implementation  
 - QUALITY.md and TOOLING.md are project-specific reference files used by Implementation mode  
 - All CLI commands updated to /tw- prefix  
 - Partnering: added Input Channels, Mode Transition, and raw Transcript rules  
 - Use Case is always required as source for Specs (Legacy Findings do not bypass this)  
 - Specs, Tasks, Plans: explicit source maturity requirements and output paths added  
 - Implementation Planning: per-entry-point logic with explicit routing rules  
 - Implementation: added Entry point, status update rules, and commit boundary requirement  
 - CORE.md: clarified maturity statuses, destructive commands, CATALOG.md added to context loading  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAMUlEQVR4nO3WAQkAIBAEsBPMYs4PZhMDWMAA5njYUmxU1UqyAwBAF2cmeZE4AIBO7gentgXapSWpbgAAAABJRU5ErkJggg==)  
**1. Purpose**  
This document describes a file-based agent harness for Spec Driven Development.  
The harness is intended for repositories where humans and coding agents work together through explicit, traceable artifacts instead of relying on ad-hoc prompts. It supports the full path from discussion, voice input, legacy-code analysis and product thinking to implementation, validation, review and continuous improvement of the harness itself.  
The core idea is simple:  
*The agent should not improvise from a loose prompt. The agent should operate from explicit artifacts, clear modes, bounded context and approved implementation plans.*  
The harness is not a replacement for engineering judgment. It is a structured operating system for AI-assisted software development.  
It should make agentic work:  
- more predictable  
- more reviewable  
- safer  
- more traceable  
- easier to resume  
- less dependent on repeating long instructions  
- better suited for large repositories and long-lived products  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSNhwgJe0PYTKpnRgQU2QtIq6DIze3UGAMBf3Gu1VcfXEwAAXrseaIEEMYtKmi4AAAAASUVORK5CYII=)  
**2. Problem Statement**  
Modern coding agents can read files, change code, execute tests and propose implementations. However, they often fail in predictable ways when the process is not structured.  
Common problems include:  
- loose discussions turn into premature implementation  
- agents infer missing requirements  
- too much repository context is loaded and important rules are diluted  
- old code is copied blindly instead of being analyzed  
- specs, tasks and implementation steps are mixed together  
- large changes become hard to review  
- validation is missing or performed too late  
- lessons from failed agent runs are not fed back into the process  
- different tools use different instruction files and become inconsistent  
A file-based harness addresses these problems by defining:  
- how agents enter the repository  
- which files they must follow  
- which mode is active  
- which artifact is the current source of truth  
- when a next-stage artifact may be created  
- when implementation may start  
- how context is loaded  
- how results are reviewed  
- how the harness is improved  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANElEQVR4nO3OMQ0AIAwAwZIgBKn1gjJsdGLBABMhuZt+/JaZIyJmAADwi9VP1NMNAABu1AaU4gUeBSGW2wAAAABJRU5ErkJggg==)  
**3. Core Principle: Spec Driven Development**  
Spec Driven Development means that implementation is driven by explicit specifications, not by vague prompts, implicit assumptions or direct coding from conversation.  
The central rule is:  
*Specs define desired behavior. Implementation Plans define how work will be executed. Tasks are optional execution units when work needs smaller traceable slices. Code changes start only after an accepted implementation plan exists.*  
The default artifact flow is:  
Partnering Session  
 -> optional Transcript  
 -> Idea  
 -> Use Case  
 -> Spec  
 -> optional Tasks  
 -> Implementation Plan  
 -> Plan Approval  
 -> Implementation  
 -> Validation  
 -> Review  
 -> Harness Improvement  
   
For legacy projects, the flow is:  
Legacy Code + Legacy Docs  
 -> Legacy Discovery  
 -> Inventory / Findings / Source Maps  
 -> Use Cases  
 -> Specs  
 -> optional Tasks  
 -> Implementation Plan  
 -> Plan Approval  
 -> Implementation later  
   
The process is intentionally staged. Each stage has a different purpose and a different level of maturity.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSNBCUrfDqrYGVDAgAU2QtIq6DIzW7UHAMBfHGt1V+fXEwAAXrseHCQGBEuErVgAAAAASUVORK5CYII=)  
**4. Modes and Responsibilities**  
A mode defines what the agent is allowed to do.  
Voice, text, chat and transcript are input mechanisms. They are not modes by themselves.  
The important boundary is:  
*Which mode is active, and what is that mode allowed to produce?*  
**4.1 Partnering Mode**  
Partnering is the conversational mode.  
Voice, chat and text are input mechanisms — not modes. Partnering is the mode. The input channel does not change what the agent may do.  
It covers:  
- voice or text discussion  
- capturing raw thoughts  
- clarifying vague ideas  
- separating problems from solution ideas  
- identifying assumptions and open questions  
- structuring emerging concepts  
- creating Idea artifacts  
- optionally creating Use Case drafts when the discussion is mature enough  
- preserving original-language transcript snippets when needed  
- producing normalized artifacts in English  
Partnering must not:  
- create Specs  
- create Tasks  
- create Implementation Plans  
- change code  
- trigger implementation implicitly  
- infer approval from discussion  
- treat raw transcript as final requirement  
Mode transition: Partnering ends only when the user explicitly requests a mode change. If intent is ambiguous, the agent must clarify before changing mode. A vague statement like "we should maybe make a spec later" does not trigger Spec mode.  
Transcript responsibility: The agent creates transcripts — not the user. The transcript is raw data. The agent writes a TRANSCRIPT-*.md proactively, capturing the conversation as it unfolds, without being asked.  
A Partnering session may produce:  
agent-harness/transcripts/active/TRANSCRIPT-*.md  
 agent-harness/ideas/active/IDEA-*.md  
 agent-harness/use-cases/active/UC-*.md (draft only, if sufficiently mature)  
 open questions  
   
It must stop before Spec creation unless the user explicitly starts the Spec mode.  
**4.2 Use Case Mode**  
Use Case mode creates or refines Use Case artifacts.  
A Use Case is a behavioral anchor — it defines who does what, under what conditions, and with what observable outcome. It is not an implementation plan.  
Entry: /tw-create-use-case or explicit natural language instruction referencing a source artifact or actor goal.  
A Use Case may be created from: Idea, Transcript, Partnering discussion, Legacy Finding, or existing documentation.  
Create a Use Case when: a human actor or external system has a goal to pursue, a decision flow or business workflow needs to be defined, observable behavior needs to be captured, alternatives or failure paths are relevant, or a recurring operational scenario exists.  
It answers:  
- who is the actor?  
- what goal is being pursued?  
- what triggers the interaction?  
- what is the main success scenario?  
- what alternatives or failures matter?  
- what observable outcome should exist?  
A Use Case body should include: primary actor, supporting actors, goal, trigger, preconditions, main success scenario (step by step), alternatives and failure paths, non-goals, observable outcome, open questions.  
A Use Case is not an implementation plan. It is a behavioral anchor.  
A Use Case may be refined when new information changes the scope, open questions are resolved, or the scenario needs correction. Refining does not change the Use Case ID.  
Output: agent-harness/use-cases/active/UC-*.md — use agent-harness/templates/USE-CASE-template.md.  
Must not: contain low-level implementation detail (unless essential), trigger implementation, create Specs, Tasks, or Implementation Plans.  
**4.3 Spec Mode**  
Spec mode creates or updates Spec artifacts.  
Specs are the source of truth for desired behavior.  
Entry: /tw-create-spec <use-case-file> or explicit natural language instruction referencing the Use Case.  
A Spec must always be created from a Use Case. The Use Case must be at status ready-for-spec or approved. Legacy Findings, Ideas and Transcripts are upstream inputs — they produce Use Cases, not Specs directly.  
Spec creation should:  
1. Verify the Use Case is at an accepted status.  
2. Read the Use Case.  
3. Inspect source Ideas or Legacy Findings when additional context is needed.  
4. Identify problem and goal.  
5. Define scope and non-goals.  
6. Define functional and non-functional requirements.  
7. Define acceptance criteria.  
8. Identify risks and constraints.  
9. Identify whether Tasks are likely required.  
10. Stop before implementation.  
A Spec must be concrete enough to support implementation planning.  
Output: agent-harness/specs/active/SPEC-*.md — use agent-harness/templates/SPEC-template.md.  
Technical artifacts (OpenAPI, schemas, contracts) are referenced via `technical_refs` and live outside `agent-harness/`. Their location is project-defined — the harness does not enforce a specific folder.  
Spec mode must not: implement code, create Tasks or Implementation Plans, proceed if the source Use Case is not at an accepted status.  
**4.4 Task Mode**  
Task mode creates Task artifacts when they are required.  
Tasks are execution units, not the source of truth for behavior — Specs are.  
Entry: /tw-create-tasks <spec-file> or explicit natural language instruction referencing the Spec.  
Tasks must always be created from an approved Spec. The Spec must be at status approved before Tasks may be created.  
Tasks are not always mandatory. The decision criteria are defined in section 15.  
Output: agent-harness/tasks/active/TASK-*.md — use agent-harness/templates/TASK-template.md.  
Must not: implement or change code, create Implementation Plans, proceed if the source Spec is not at status approved.  
**4.5 Implementation Planning Mode**  
Implementation Planning is the mandatory gate before code changes.  
These commands do not mean "start coding now". They mean: inspect the referenced artifact, gather the required downstream artifacts, verify maturity, produce an Implementation Plan, and wait for acceptance.  
Entry points:  
/tw-implement-task <task-file>  
 /tw-implement-spec <spec-file>  
 /tw-implement-use-case <use-case-file>  
   
Entering via /tw-implement-task: verify Task is at status ready, create a focused plan, wait for approval.  
Entering via /tw-implement-spec: verify Spec is approved, find existing Tasks and check their status. If ready Tasks exist use them. If Tasks exist but are draft/blocked/stale stop and report. If no Tasks exist apply the task decision matrix. If Tasks are required but missing stop and route to /tw-create-tasks. If Tasks are not required create an inline plan.  
Entering via /tw-implement-use-case: verify Use Case status, find all derived Specs and verify they are approved (if not stop and route to /tw-create-spec), then for each Spec apply the same Task discovery logic as above. Create a coherent end-to-end plan.  
The agent must not generate duplicate Tasks or ignore existing ones.  
Implementation Planning must not change code.  
Output: agent-harness/implementation-plans/active/PLAN-*.md — use agent-harness/templates/IMPLEMENTATION-PLAN-template.md.  
**4.6 Implementation Mode**  
Implementation mode changes code.  
Entry: /tw-execute-plan <plan-file> or explicit natural language instruction referencing an approved plan.  
It may start only after:  
- an Implementation Plan exists with status approved  
- all included Tasks are at status ready or planned  
- safety and risk rules are satisfied  
Implementation should execute one accepted plan step at a time.  
The agent must:  
- follow the plan — do not deviate from approved scope  
- set Task status to in-progress when starting, done when complete  
- set Plan status to in-progress when execution begins, done when all steps are complete  
- keep the diff focused on the current step  
- respect allowed and forbidden paths from Task frontmatter  
- avoid unrelated refactoring  
- run technical checks from QUALITY.md and TOOLING.md after each step  
- follow the suggested commit boundaries defined in the plan  
- summarize results per Task or plan step  
- stop if validation fails outside the expected scope  
- stop if missing or contradictory requirements are discovered  
- stop if a high-risk area is encountered that was not covered by the plan  
Batch implementation is allowed only when explicitly planned and approved. High-risk tasks must remain separate unless explicitly approved.  
Must not: implement beyond the approved plan scope, skip planned validation steps, refactor unrelated code, modify files outside allowed paths, continue past a failing validation without explicit approval.  
**4.7 Validation Mode**  
Validation mode checks whether an artifact, plan or implementation satisfies its process and behavioral criteria.  
Validation is a universal mode — it does not contain stack-specific commands or tool names.  
Validation covers:  
- artifact completeness (required fields, frontmatter, traceability links)  
- process rule compliance (correct artifact statuses, no implementation before a plan)  
- acceptance criteria defined in the Spec  
- behavioral correctness of the implementation  
- readiness checks before moving to the next stage  
Technical checks (tests, linting, typing, migrations, configuration) are project-specific. They are defined in `agent-harness/reference/QUALITY.md` and invoked using commands from `agent-harness/reference/TOOLING.md`.  
**4.8 Review Mode**  
Review mode evaluates outputs and decisions.  
It may review:  
- Ideas  
- Use Cases  
- Specs  
- Tasks  
- Implementation Plans  
- Code changes  
- Validation results  
- Harness behavior  
Review is not only approval. It is also how process problems are discovered.  
Entry: /tw-review <artifact-file>  
Output: agent-harness/reviews/active/REVIEW-*.md  
**4.9 Harness Improvement Mode**  
Harness Improvement mode changes the harness itself.  
It should be used when reviews identify recurring or structural problems in the process.  
Harness changes should not happen opportunistically during normal feature implementation. They should be explicit, focused and reviewable.  
Entry: /tw-improve-harness <review-file>  
Output: agent-harness/improvements/active/IMPROVEMENT-*.md  
**4.10 Legacy Discovery Mode**  
Legacy Discovery is used when an existing project is imported as evidence for a new Spec Driven Development process.  
Entry: /tw-discover-legacy <path>  
Inputs may include:  
- old source code  
- old documentation  
- tests  
- Docker files  
- CI configuration  
- deployment scripts  
- README files  
- issue notes  
Outputs may include:  
- Legacy Inventory  
- Source Maps  
- Legacy Findings  
- candidate Use Cases  
- candidate Specs (only when evidence is strong enough)  
- open questions  
- harness improvement candidates  
Legacy Discovery must not implement code.  
The legacy project is evidence, not authority.  
The agent must distinguish:  
- observed behavior  
- documented behavior  
- inferred intent  
- accidental complexity  
- dead or uncertain code  
   
**5. Voice, Chat and Explicit Commands**  
Voice may be used in any mode.  
The key rule is not "voice vs text". The key rule is whether the mode transition is explicit.  
Examples:  
"We should maybe make a spec later."  
 -> still Partnering, no Spec creation  
   
 "Create the spec for UC-012."  
 -> Spec mode, if UC-012 is unambiguous  
   
 "Create tasks for SPEC-021."  
 -> Task mode  
   
 "Implement SPEC-021."  
 -> Implementation Planning mode, not immediate coding  
   
 "Implement TASK-071."  
 -> Implementation Planning mode for that single task  
   
CLI commands should exist for deterministic use:  
/tw-create-spec <use-case-file>  
 /tw-create-tasks <spec-file>  
 /tw-implement-task <task|spec|use-case>  
 /tw-implement-task <task-file>  
 /tw-implement-spec <spec-file>  
 /tw-implement-use-case <use-case-file>  
 /tw-execute-plan <plan-file> [--step N]  
   
Natural-language voice or chat instructions may map to the same modes when the intent is clear.  
If intent is ambiguous, the agent must clarify before changing mode.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSNhwgJGkPcrHpnRgQU2QtIq6DIze3UGAMBf3Gu1VcfXEwAAXrseaJkELjbMzy0AAAAASUVORK5CYII=)  
**6. Artifact Language**  
Generated harness artifacts should be written in English by default.  
This applies to normalized artifacts such as:  
- Ideas  
- Use Cases  
- Specs  
- Tasks  
- Implementation Plans  
- Reviews  
- Improvements  
- Legacy Findings  
- Source Maps  
Input may be German, Spanish, English, mixed-language, voice, chat or transcript.  
Original-language content may be preserved in:  
- transcripts  
- raw notes  
- quoted source excerpts  
- evidence snippets  
But normalized artifacts should use English for:  
- consistency  
- interoperability with agents and tools  
- easier long-term maintenance  
- predictable search and indexing  
This rule should be documented in OUTPUTS.md and referenced from CORE.md or PARTNERING.md.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAM0lEQVR4nO3OUQmAABBAsaeI2MKqV8RyJrGCfyJsCbbMzFldAQDwF/dWrdXx9QQAgNf2B/NkAzRb7P0YAAAAAElFTkSuQmCC)  
**7. Repository Layout**  
The harness should be stored mostly under one directory, while root-level loader files remain in the repository root.  
**7.1 Root Files**  
repo/  
   AGENTS.md  
   CLAUDE.md  
   agent-harness/  
   apps/  
   packages/  
   services/  
   legacy/  
   
AGENTS.md and CLAUDE.md should remain in the root because tools such as Codex and Claude Code are most likely to discover root-level instruction files.  
They should be short loaders, not long concept documents.  
Example AGENTS.md:  
# AGENTS.md  
   
 This repository uses a Spec Driven Agent Harness under `agent-harness/`.  
   
 Always follow:  
   
 - `agent-harness/CORE.md`  
 - `agent-harness/OUTPUTS.md`  
 - the active mode file under `agent-harness/modes/`  
 - the explicitly referenced artifact  
   
 Do not scan entire artifact directories.  
 Use the smallest sufficient context.  
 Do not implement before an accepted Implementation Plan exists.  
   
Example CLAUDE.md:  
# CLAUDE.md  
   
 Use AGENTS.md as the source of truth.  
   
 This repository uses the agent harness under `agent-harness/`.  
 Follow the active mode and referenced artifact.  
 Do not duplicate rules here.  
   
**7.2 Harness Directory**  
The default structure is artifact-centric at the top level:  
agent-harness/  
   CORE.md  
   CATALOG.md  
   
   modes/  
     PARTNERING.md  
     LEGACY-DISCOVERY.md  
     USE-CASES.md  
     SPECS.md  
     TASKS.md  
     IMPLEMENTATION-PLANNING.md  
     IMPLEMENTATION.md  
     VALIDATION.md  
     REVIEW.md  
     IMPROVEMENT.md  
   
   reference/  
     ARCHITECTURE.md  
     DOMAIN.md  
     TOOLING.md  
     OUTPUTS.md  
     QUALITY.md              # optional, only when needed  
   
   templates/  
     TRANSCRIPT-template.md  
     IDEA-template.md  
     USE-CASE-template.md  
     SPEC-template.md  
     TASK-template.md  
     IMPLEMENTATION-PLAN-template.md  
     REVIEW-template.md  
     IMPROVEMENT-template.md  
     LEGACY-FINDING-template.md  
   
   transcripts/  
     active/  
     archive/  
     SUMMARY.md  
   
   ideas/  
     active/  
     archive/  
     SUMMARY.md  
   
   use-cases/  
     active/  
     archive/  
     SUMMARY.md  
   
   specs/  
     active/  
     archive/  
     SUMMARY.md  
   
   tasks/  
     active/  
     done/  
     archive/  
     SUMMARY.md  
   
   implementation-plans/  
     active/  
     approved/  
     done/  
     archive/  
     SUMMARY.md  
   
   reviews/  
     active/  
     archive/  
     SUMMARY.md  
   
   improvements/  
     active/  
     done/  
     archive/  
     SUMMARY.md  
   
   legacy/  
     INVENTORY.md  
     FINDINGS.md  
     QUESTIONS.md  
     source-map/  
       FRONTEND.md  
       BACKEND.md  
       DATABASE.md  
       API.md  
       INFRASTRUCTURE.md  
       TESTS.md  
       DEPENDENCIES.md  
   
**7.2a Reference Files — Universal vs Project-Specific**  
Mode files (`agent-harness/modes/`) are universal. They define process rules that apply to every project using this harness regardless of stack. They must not contain stack-specific commands, tool names, or technology choices.  
`agent-harness/OUTPUTS.md` is universal — it defines artifact formats, naming conventions, and folder structure. It is always loaded alongside CORE.md.  
Reference files (`agent-harness/reference/`) are project-specific. They define the concrete details that vary per project:  
- TOOLING.md — commands, tools, package manager, workspace setup  
- QUALITY.md — quality standards, definition of done, coverage expectations  
- ARCHITECTURE.md — system boundaries, layers, deployment structure  
- DOMAIN.md — domain concepts, rules, actors, invariants  
Each mode file should include a Reference Files section that tells agents which reference files to load and when — without loading all of them by default.  
`agent-harness/reference/ARCHITECTURE.md` should include a "Technical Artifacts" section declaring where project-specific technical specs live (OpenAPI specs, database schemas, contracts). This is the authoritative source for resolving `technical_refs` entries in Specs when the path is not self-evident.  
Stack-specific rules must never be placed in mode files. Mode files reference the relevant reference file instead.  
**7.3 Optional Domain Subdirectories**  
The top level should remain artifact-centric:  
use-cases/  
 specs/  
 tasks/  
 implementation-plans/  
   
Domain-specific organization may be used inside those directories when useful:  
use-cases/  
   trading/  
   news/  
   dashboard/  
   infrastructure/  
   
 specs/  
   trading/  
   news/  
   dashboard/  
   infrastructure/  
   
 tasks/  
   trading/  
   news/  
   dashboard/  
   infrastructure/  
   
These folders are organizational aids only. They must not replace frontmatter-based traceability.  
The workflow remains:  
Use Case -> Spec -> Task -> Implementation Plan  
   
regardless of folder placement.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSPBCUZfE2IYmVDBhAU2QtIq6DIzW7UHAMBfnGt1V8fXEwAAXrse/xcF7U7sx4wAAAAASUVORK5CYII=)  
**8. CORE.md and CATALOG.md**  
**8.1 CORE.md**  
CORE.md contains the minimal universal rules.  
It should be short, stable and operational.  
It may include:  
- universal safety rules  
- context loading rules (including CATALOG.md as navigation step)  
- artifact maturity rules (with explicit accepted statuses per artifact type)  
- implementation planning requirement  
- high-risk area rules  
- traceability requirements  
- language rules  
CORE.md is not a long explanation. It is the always-relevant rule set.  
Key improvements over a naive implementation:  
- "mature enough" must be defined as a concrete accepted status (e.g. Spec must be approved, Use Case must be ready-for-spec, Task must be ready)  
- "destructive commands" must be defined as irreversible or wide blast-radius operations (data loss, schema changes, production state changes, force operations)  
- CATALOG.md must be listed as step 2 in context loading so agents know to use it for artifact navigation  
**8.2 CATALOG.md**  
CATALOG.md is not a God-index.  
It should be a tiny navigation file that explains where artifact types live and which high-level initiatives are currently active.  
It must not list hundreds of Use Cases, Specs and Tasks.  
Example CATALOG.md:  
# CATALOG.md  
   
 ## Artifact Locations  
   
 - Transcripts: `agent-harness/transcripts/`  
 - Ideas: `agent-harness/ideas/`  
 - Use Cases: `agent-harness/use-cases/`  
 - Specs: `agent-harness/specs/`  
 - Tasks: `agent-harness/tasks/`  
 - Implementation Plans: `agent-harness/implementation-plans/`  
 - Reviews: `agent-harness/reviews/`  
 - Improvements: `agent-harness/improvements/`  
 - Legacy: `agent-harness/legacy/`  
   
 ## Current Active Initiatives  
   
 <!-- Add one line per active initiative. Example format: -->  
 <!-- UC-021 Review and reduce news storage growth — status: ready-for-spec -->  
 <!-- SPEC-021 News retention policy — status: approved -->  
   
 none yet  
   
 ## Loading Rule  
   
 Start from the explicitly referenced artifact.  
 Use frontmatter links to navigate to related artifacts.  
 Use a local SUMMARY.md only when the target artifact is unknown or ambiguous — created per-directory as needed.  

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANklEQVR4nO3OQQmAABRAsSfYxZo/jVEMYQLPJrCCNxG2BFtmZquOAAD4i3Ot7mr/egIAwGvXA4rLBc059ysnAAAAAElFTkSuQmCC)  
**9. Avoiding the God Index Problem**  
A single global INDEX.md that lists every Use Case, Spec, Task and Plan will eventually become too large.  
Professional products may have:  
- hundreds of Use Cases  
- hundreds of Specs  
- thousands of Tasks  
- many Plans and Reviews  
Loading a global index would waste tokens and dilute important context.  
The harness should therefore avoid a large global artifact index.  
Use:  
- a tiny root CATALOG.md  
- frontmatter links  
- local SUMMARY.md files  
- optional local manifests for large Use Cases or Specs  
- artifact-specific navigation  
**9.1 Use Case as High-Level Anchor**  
Use Cases should act as high-level behavioral anchors.  
A Use Case links to its derived Specs and Plans:  
derived_specs:  
   - SPEC-021  
   - SPEC-022  
 implementation_plans:  
   - PLAN-010  
   
**9.2 Spec as Implementation Anchor**  
Specs link to derived Tasks and Plans:  
derived_tasks:  
   - TASK-071  
   - TASK-072  
 implementation_plans:  
   - PLAN-009  
   
**9.3 Task Indexes Are Usually Not Needed**  
Tasks normally do not need their own indexes.  
They are usually found through:  
- Spec frontmatter  
- task source metadata  
- tasks/SUMMARY.md  
- a local spec manifest if the Spec is large  
**9.4 Local Summaries**  
SUMMARY.md files should be local and short.  
They should summarize active or important artifacts, not every historical file.  
Examples:  
use-cases/SUMMARY.md  
 specs/SUMMARY.md  
 tasks/SUMMARY.md  
 implementation-plans/SUMMARY.md  
   
If a Use Case or Spec becomes very large, it may get its own local manifest:  
use-cases/trading/UC-007-manual-trade-confirmation/  
   UC.md  
   SUMMARY.md  
   specs.md  
   plans.md  
   
This should be optional, not the default for every artifact.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANklEQVR4nO3OMQ2AABAAsSNhRAF6EPYDLhGADSywEZJWQZeZ2aszAAD+4l6rrTq+ngAA8Nr1AIWsBDYDm5cLAAAAAElFTkSuQmCC)  
**10. YAML Frontmatter**  
All harness artifacts should use YAML frontmatter.  
The frontmatter stores machine-readable metadata and relationships. The Markdown body remains human-readable.  
Frontmatter enables:  
- traceability  
- context loading  
- status tracking  
- maturity checks  
- generated summaries  
- local catalogs  
- implementation planning  
- review links  
- automated graph generation  
**10.1 Minimum Fields**  
Every artifact should include at least:  
---  
 id: ""  
 type: ""  
 status: ""  
 title: ""  
 created: ""  
 updated: ""  
 source: []  
 related: []  
 ---  
   
**10.2 Common Recommended Fields**  
Depending on artifact type:  
area: ""  
 tags: []  
 requires: []  
 risk: ""  
 confidence: ""  
 approval: {}  
 derived_specs: []  
 derived_tasks: []  
 depends_on: []  
 blocks: []  
 allowed_paths: []  
 forbidden_paths: []  
 validation: []  
 entrypoint_type: ""  
 entrypoint: ""  
 included_tasks: []  
 excluded_tasks: []  
 target_type: ""  
 target: ""  
 outcome: ""  
 follow_up: []  
 target_files: []  
 legacy_source: []  
 evidence_type: ""  
 candidate_artifacts: []  
   
**10.3 ID Prefixes**  
Use stable ID prefixes:  
TRANSCRIPT-001  
 IDEA-001  
 UC-001  
 SPEC-001  
 TASK-001  
 PLAN-001  
 REVIEW-001  
 IMPROVEMENT-001  
 LEGACY-FINDING-001  
   
IDs should remain stable even if filenames change.  
**10.4 Relationship Chain**  
The desired traceability chain is:  
TRANSCRIPT  
 -> IDEA  
 -> UC  
 -> SPEC  
 -> TASK  
 -> PLAN  
 -> REVIEW  
 -> IMPROVEMENT  
   
Not every flow needs every artifact, but when artifacts exist, their relationships should be explicit.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQmAABRAsSd4NIGRTPXNaQBrWMGbCFuCLTOzV2cAAPzFvVZbdXw9AQDgtesBhZQEOYZGgUEAAAAASUVORK5CYII=)  
**11. Artifact Types**  
**11.1 Transcript**  
Transcripts are raw or lightly processed input.  
They may come from:  
- voice notes  
- meetings  
- chat  
- dictated thoughts  
- imported notes  
Transcripts are evidence. They are not approved requirements.  
Example frontmatter:  
---  
 id: TRANSCRIPT-001  
 type: transcript  
 status: raw  
 title: News storage discussion  
 created: 2026-06-25  
 updated: 2026-06-25  
 source_type: voice-note  
 source_ref: audio/raw/news-storage-2026-06-25.m4a  
 language: de  
 participants:  
   - user  
 transcription_engine: whisper  
 confidence: medium  
 processed_into:  
   - IDEA-018  
 tags:  
   - news  
   - storage  
 ---  
   
Recommended statuses:  
raw  
 reviewed  
 processed  
 archived  
   
**11.2 Idea**  
Ideas are early structured thoughts.  
They are not implementation requests.  
Example frontmatter:  
---  
 id: IDEA-018  
 type: idea  
 status: captured  
 title: Reduce news storage growth  
 created: 2026-06-25  
 updated: 2026-06-25  
 area: news-storage  
 source:  
   - TRANSCRIPT-001  
 tags:  
   - news  
   - database  
   - storage  
 maturity: low  
 confidence: medium  
 next:  
   - UC-011  
 ---  
   
Recommended statuses:  
captured  
 clarifying  
 ready-for-use-case  
 converted  
 archived  
 rejected  
   
**11.3 Use Case**  
Use Cases describe actor-driven behavior.  
Example frontmatter:  
---  
 id: UC-011  
 type: use-case  
 status: ready-for-spec  
 title: Review and reduce news storage growth  
 created: 2026-06-25  
 updated: 2026-06-25  
 area: news-storage  
 primary_actor: operator  
 supporting_actors:  
   - system  
 source:  
   - IDEA-018  
 derived_specs:  
   - SPEC-021  
 tags:  
   - database  
   - operations  
 confidence: high  
 risk: medium  
 ---  
   
Recommended statuses:  
draft  
 review  
 ready-for-spec  
 converted  
 implemented  
 archived  
 rejected  
   
A Use Case body should normally include:  
- primary actor  
- supporting actors  
- goal  
- trigger  
- preconditions  
- main success scenario  
- alternatives  
- non-goals  
- observable outcome  
- open questions  
**11.4 Spec**  
Specs are the central artifacts of Spec Driven Development.  
They define desired behavior and acceptance criteria.  
Example frontmatter:  
---  
 id: SPEC-021  
 type: spec  
 status: approved  
 title: News retention policy  
 created: 2026-06-25  
 updated: 2026-06-25  
 area: news-storage  
 source:  
   - UC-011  
 related:  
   - IDEA-018  
 derived_tasks:  
   - TASK-071  
   - TASK-072  
   - TASK-073  
 risk: medium  
 approval:  
   required: true  
   approved_by: alex  
   approved_at: 2026-06-25  
 requires:  
   - agent-harness/modes/SPECS.md  
   - agent-harness/reference/ARCHITECTURE.md#database  
   - agent-harness/reference/DOMAIN.md#news-and-sentiment  
 ---  
   
Recommended statuses:  
draft  
 review  
 approved  
 taskified  
 implemented  
 archived  
 rejected  
   
A Spec body should include:  
- problem  
- goal  
- scope  
- non-goals  
- functional requirements  
- non-functional requirements  
- acceptance criteria  
- constraints  
- dependencies  
- risks  
- validation approach  
- task decision notes if relevant  
A Spec may reference external technical artifacts (OpenAPI specs, database schemas, contracts) via the `technical_refs` frontmatter field. These live outside `agent-harness/`. Their location is project-defined — the harness does not enforce a specific folder.  
**11.5 Task**  
Tasks are execution units.  
They are not the source of truth for behavior. Specs are.  
Tasks are required when the work needs smaller traceable slices.  
Example frontmatter:  
---  
 id: TASK-071  
 type: task  
 status: ready  
 title: Add news retention configuration  
 created: 2026-06-25  
 updated: 2026-06-25  
 area: news-storage  
 source:  
   - SPEC-021  
 depends_on: []  
 blocks:  
   - TASK-072  
 risk: low  
 estimated_size: small  
 allowed_paths:  
   - apps/trade-whisperer/src/config/  
   - apps/trade-whisperer/tests/config/  
 forbidden_paths:  
   - apps/trade-whisperer/src/broker/  
   - deploy/  
 validation:  
   - uv run pytest apps/trade-whisperer/tests/config/  
   - uv run ruff check apps/trade-whisperer/src/config/  
 ---  
   
Recommended statuses:  
draft  
 ready  
 planned  
 in-progress  
 done  
 blocked  
 archived  
 rejected  
   
**11.6 Implementation Plan**  
Implementation Plans define how implementation will proceed.  
They are required before code changes.  
Example frontmatter:  
---  
 id: PLAN-009  
 type: implementation-plan  
 status: proposed  
 title: Implement news retention policy  
 created: 2026-06-25  
 updated: 2026-06-25  
 entrypoint_type: spec  
 entrypoint: SPEC-021  
 source:  
   - SPEC-021  
 included_tasks:  
   - TASK-071  
   - TASK-072  
   - TASK-073  
 excluded_tasks:  
   - TASK-074  
 risk: medium  
 approval:  
   required: true  
   approved_by: null  
   approved_at: null  
 ---  
   
Recommended statuses:  
proposed  
 review  
 approved  
 in-progress  
 done  
 rejected  
 archived  
   
A Plan body should include:  
- target  
- readiness checks  
- included artifacts  
- excluded artifacts  
- plan steps  
- task grouping rationale  
- expected file areas  
- validation strategy per step  
- risk level per step  
- suggested commit boundaries  
- approval status  
**11.7 Review**  
Reviews evaluate artifacts, plans, implementations or process results.  
Example frontmatter:  
---  
 id: REVIEW-014  
 type: review  
 status: completed  
 title: Review implementation of TASK-071  
 created: 2026-06-25  
 updated: 2026-06-25  
 target_type: task  
 target: TASK-071  
 source:  
   - PLAN-009  
 outcome: accepted-with-notes  
 reviewer: alex  
 follow_up:  
   - IMPROVEMENT-003  
 ---  
   
Outcomes:  
accepted  
 accepted-with-notes  
 changes-requested  
 rejected  
 follow-up-required  
   
**11.8 Harness Improvement**  
Harness Improvements change the process itself.  
Example frontmatter:  
---  
 id: IMPROVEMENT-003  
 type: harness-improvement  
 status: proposed  
 title: Make task non-goals mandatory  
 created: 2026-06-25  
 updated: 2026-06-25  
 source:  
   - REVIEW-014  
 area: templates  
 target_files:  
   - agent-harness/templates/TASK-template.md  
   - agent-harness/modes/TASKS.md  
 risk: low  
 approval:  
   required: true  
   approved_by: null  
   approved_at: null  
 ---  
   
Recommended statuses:  
proposed  
 approved  
 in-progress  
 done  
 rejected  
 archived  
   
**11.9 Legacy Finding**  
Legacy Findings record evidence extracted from old projects.  
Example frontmatter:  
---  
 id: LEGACY-FINDING-012  
 type: legacy-finding  
 status: reviewed  
 title: Existing Telegram flow confirms manual trade decisions  
 created: 2026-06-25  
 updated: 2026-06-25  
 legacy_source:  
   - legacy/imported/old-project/bot/telegram.py  
   - legacy/imported/old-project/docs/notifications.md  
 evidence_type: observed  
 confidence: medium  
 area: telegram  
 candidate_artifacts:  
   - UC-007  
   - SPEC-014  
 risk: medium  
 ---  
   
Recommended statuses:  
draft  
 reviewed  
 converted  
 archived  
 rejected  
   
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQmAABRAsSdYxZ4/mJjEsxE8W8GbCFuCLTOzVXsAAPzFuVZ3dXw9AQDgtesBxPEF3bv7x0IAAAAASUVORK5CYII=)  
**12. Partnering Workflow**  
Partnering is the front door for unclear thinking.  
It should feel like a productive discussion, but the agent must behave as a structured sparring partner.  
**12.1 Input Channels**  
Voice, chat and text are input mechanisms — not modes.  
Partnering is the mode. The input channel does not change what the agent may do.  
**12.2 Partnering Responsibilities**  
The agent should:  
- listen first  
- capture relevant statements  
- avoid premature solutions  
- separate problem, goal, solution idea and assumption  
- ask focused clarification questions  
- identify candidate ideas  
- identify possible Use Case drafts when mature enough  
- summarize intermediate understanding  
- mark uncertainty explicitly  
- preserve original-language transcript snippets when needed  
- produce normalized artifacts in English  
**12.3 Partnering Boundaries**  
Partnering must not:  
- create Specs  
- create Tasks  
- create Implementation Plans  
- modify code  
- infer approval from discussion  
- treat raw transcript as final requirement  
**12.4 Partnering Output**  
Possible outputs:  
agent-harness/transcripts/active/TRANSCRIPT-*.md  
 agent-harness/ideas/active/IDEA-*.md  
 agent-harness/use-cases/active/UC-*.md   # draft only, if sufficiently mature  
 open questions  
   
The transcript is raw data. The agent writes it proactively, capturing the conversation as it unfolds, without being asked.  
**12.5 Mode Transition**  
Partnering ends only when the user explicitly requests a mode change.  
If the intent is ambiguous, the agent must clarify before changing mode.  
A vague statement like “we should maybe make a spec later” does not trigger Spec mode.  
   
**13. Use Case Creation**  
Use Cases should be created when the idea involves:  
- a human actor  
- an external system  
- a decision flow  
- a business workflow  
- observable behavior  
- alternatives or failure paths  
- a recurring operational scenario  
A Use Case may be created from:  
- Idea  
- Transcript  
- Partnering discussion  
- Legacy Finding  
- existing documentation  
A Use Case should not contain low-level implementation detail unless it is essential to the scenario.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AUBBAsUfyVTCg9UygEBVsWGAjJK2CbjNzVGcAAPzFtapV7V9PAAB47X4AEWIEM8iQs0EAAAAASUVORK5CYII=)  
**14. Spec Creation**  
A Spec must always be created from a Use Case.  
The Use Case must be at status ready-for-spec or approved before a Spec may be created.  
Legacy Findings, Ideas and Transcripts are upstream inputs — they produce Use Cases, not Specs directly.  
Spec creation may be triggered by:  
/tw-create-spec <use-case-file>  
   
or an unambiguous natural-language request.  
Spec creation should:  
1. Verify the Use Case is at an accepted status before proceeding.  
2. Read the Use Case.  
3. Inspect source Ideas or Legacy Findings when additional context is needed.  
4. Identify problem and goal.  
5. Define scope and non-goals.  
6. Define functional and non-functional requirements.  
7. Define acceptance criteria.  
8. Identify risks and constraints.  
9. Identify whether Tasks are likely required.  
10. Stop before implementation.  
A Spec must be concrete enough to support implementation planning.  
**15. Are Task Artifacts Required?**  
Tasks are not always mandatory.  
Specs are the source of truth for desired behavior. Tasks are execution units used when work needs smaller, traceable, reviewable slices.  
Implementation must always be planned.  
Task artifacts are required when the work is:  
- non-trivial  
- multi-step  
- cross-cutting  
- multi-area  
- risky  
- high-review  
- high-validation  
- resumable over multiple sessions  
- likely to need separate commits  
- likely to involve multiple implementation steps  
- likely to create large diffs  
- derived from a Use Case with multiple Specs  
- dependent on explicit ordering  
**15.1 Task Decision Matrix**  
| | | |  
|-|-|-|  
| **Situation** | **Task artifacts required?** | **Reason** |   
| Small documentation-only change | No | Inline plan is sufficient |   
| Small isolated config change | Optional | Use inline plan if validation is clear |   
| Small bugfix in one module | Optional | Use inline plan if scope is clear |   
| Multiple files or modules | Yes | Reviewability and traceability |   
| Multiple implementation steps | Yes | Ordering and validation boundaries |   
| Cross-cutting change | Yes | Scope control |   
| Unclear dependencies | Yes | Dependency management |   
| Use Case-level implementation with multiple Specs | Yes | Too broad for inline planning |   
| Spec with multiple features | Yes | Needs execution slices |   
| Database migration | Yes | High risk |   
| Destructive data job | Yes | High risk |   
| Deployment or Docker change | Yes | Operational risk |   
| Security, secrets or auth | Yes | Safety-critical |   
| Broker/trading execution | Yes | Safety-critical |   
| Scoring semantics | Yes | Domain-critical |   
| Backtesting correctness | Yes | Validation-critical |   
| Major architecture change | Yes | Requires reviewable slices |   
   
**15.2 Inline Plan Without Task Artifacts**  
For small, low-risk, single-area Specs, an Implementation Plan may contain inline steps without separate Task artifacts if:  
- the Spec is approved  
- acceptance criteria are clear  
- validation is clear  
- expected changes are small  
- no high-risk area is involved  
- no separate review boundaries are needed  
Inline steps must still define: expected files, validation commands or checks, risk level, and a suggested commit boundary. The only difference from Task-based steps is the absence of a TASK-XXX reference.  
**15.3 Required Agent Behavior**  
When /tw-implement-spec SPEC-XYZ is requested, the agent must first check whether Tasks already exist.  
It must inspect:  
- Spec frontmatter  
- Spec body  
- derived_tasks  
- related artifacts  
- CATALOG/SUMMARY files if needed  
- existing Task artifacts that reference the Spec  
Then:  
- if ready Tasks exist, use them as the planning basis  
- if Tasks exist but are draft, blocked, stale or inconsistent, stop and report  
- if no Tasks exist, apply the task decision matrix  
- if Tasks are required, route to /tw-create-tasks  
- if Tasks are not required, create an inline Implementation Plan  
The agent must not ignore existing Tasks or generate duplicates.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANklEQVR4nO3OQQmAABRAsScYxpg/i2XMYARvRrCCNxG2BFtmZquOAAD4i3Ot7mr/egIAwGvXA22YBcnkstSpAAAAAElFTkSuQmCC)  
**16. Implementation Planning**  
Implementation Planning is mandatory before code changes.  
Implementation requests may target:  
Task  
 Spec  
 Use Case  
   
The broader the entrypoint, the more artifact discovery is required.  
**16.1 Implementing a Task**  
Request:  
/tw-implement-task TASK-071  
   
Meaning:  
Create a focused implementation plan for TASK-071.  
 Do not code until the plan is accepted.  
   
The plan should include:  
- target Task  
- readiness check  
- expected files  
- validation  
- risk  
- suggested commit  
- approval requirement  
**16.2 Implementing a Spec**  
Request:  
/tw-implement-spec SPEC-021  
   
Meaning:  
Inspect SPEC-021.  
 Find existing Tasks.  
 Check maturity.  
 Decide whether Tasks are required.  
 Create an implementation plan.  
 Wait for approval.  
   
If Tasks are missing but required, the agent must stop and route to Task mode.  
**16.3 Implementing a Use Case**  
Request:  
/tw-implement-use-case UC-007  
   
Meaning:  
Inspect UC-007.  
 Find all derived Specs.  
 Find all related Tasks.  
 Check readiness.  
 Create a coherent end-to-end implementation plan.  
 Wait for approval.  
   
If Specs are missing or immature, the agent must stop and route to Spec mode.  
If Tasks are required but missing, the agent must route to Task mode.  
**16.4 Plan Step Grouping**  
A plan may group multiple Tasks into one step when:  
- they belong to the same approved Spec  
- they are small  
- they are tightly related  
- they share a validation strategy  
- their scopes do not conflict  
- they produce a coherent reviewable diff  
- they do not include high-risk work  
The plan should keep Tasks separate when:  
- risk is high  
- validation differs  
- commits should be separate  
- review concerns differ  
- dependencies are unclear  
- the change affects database, deployment, security, broker execution, scoring semantics or backtesting correctness  
**16.5 Suggested Commit Boundaries**  
Implementation Plans should propose commit boundaries.  
A commit may correspond to:  
- one Task  
- one safe group of related Tasks  
- one plan step  
Traceability must remain explicit.  
Example commit message:  
feat(news): add retention configuration  
   
 Implements:  
 - TASK-071  
 - TASK-072  
   
 Source:  
 - SPEC-021  
   
**16.6 Plan Approval**  
Implementation must not begin until the plan is accepted.  
Possible statuses:  
proposed  
 review  
 approved  
 in-progress  
 done  
 rejected  
 archived  
   
Only approved plans may be executed.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSNhZscYahheJwqQgQU2QtIq6DIze3UGAMBf3Gu1VcfXEwAAXrseoqcEQXyAWBgAAAAASUVORK5CYII=)  
**17. Implementation Execution**  
Implementation should execute the approved plan.  
Default execution should be one plan step at a time.  
The agent must:  
- follow the plan  
- keep the diff focused  
- respect allowed and forbidden paths  
- avoid unrelated refactoring  
- run the planned validation  
- update task/plan status if appropriate  
- summarize results per Task or plan step  
- stop if validation fails outside the expected scope  
- stop if it discovers missing or contradictory requirements  
Batch implementation is allowed only when explicitly planned and approved.  
High-risk tasks should remain separate unless explicitly approved.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANElEQVR4nO3OUQmAABBAsSdYxKYXx1gmEBOIFfwTYUuwZWa2ag8AgL841uquzq8nAAC8dj05WgYLQTzjnAAAAABJRU5ErkJggg==)  
**18. Validation and Quality**  
Modes are universal. References are project-specific.  
This distinction applies directly to validation and quality.  
   
`agent-harness/modes/VALIDATION.md` is a universal mode file. It defines process and behavioral validation rules that apply to every project using this harness, regardless of stack.  
`agent-harness/reference/QUALITY.md` is a project-specific reference file. It defines the technical quality standards, definition of done, and stack-specific checks for this project.  
`agent-harness/reference/TOOLING.md` is a project-specific reference file. It defines the actual commands to run for tests, linting, formatting, type checking, and other technical validation.  
   
**18.1 Validation Mode Should Cover (universal)**  
- artifact completeness (required fields, frontmatter, traceability links present)  
- process rule compliance (correct artifact statuses, no implementation before an approved plan)  
- acceptance criteria from the Spec are met  
- behavioral correctness of the implementation  
- no scope drift beyond what was planned  
- readiness checks before moving to the next stage  
   
**18.2 QUALITY.md Should Cover (project-specific)**  
- definition of done for Tasks and plan steps  
- test quality standards  
- code quality standards (linting, formatting, typing requirements)  
- coverage expectations  
- security and safety standards  
- domain-critical correctness standards (trading, scoring, backtesting)  
- agent behavior expectations  
   
**18.3 TOOLING.md Should Cover (project-specific)**  
- the actual commands to run for tests, lint, format, type check  
- how to invoke project tools (package manager, workspace commands)  
- stack-specific validation commands  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQmAABRAsSfYxKK/kJXEkyE8WcGbCFuCLTOzVXsAAPzFsVZ3dX4cAQDgvesB/vEF9H9odtUAAAAASUVORK5CYII=)  
**19. Review and Harness Improvement**  
Review closes the loop.  
Every significant artifact generation or implementation should be reviewable.  
Reviews answer:  
- Was the output correct?  
- Was it complete?  
- Was it too broad?  
- Did the agent load the right context?  
- Was context too large or too small?  
- Were the rules clear enough?  
- Did validation catch the right risks?  
- Should the harness improve?  
**19.1 Review Types**  
- Idea Review  
- Use Case Review  
- Spec Review  
- Task Review  
- Implementation Plan Review  
- Implementation Review  
- Process Review  
- Harness Review  
**19.2 Harness Improvement Loop**  
If the review finds a process problem:  
Review  
 -> Improvement artifact  
 -> approved harness change  
 -> validation of harness change  
 -> updated templates/modes/reference files  
   
The harness should improve when:  
- the same mistake appears more than once  
- an agent misinterprets a template  
- acceptance criteria are consistently weak  
- tasks are too large  
- context loading is inefficient  
- validation rules are missing  
- review repeatedly finds the same issue  
- legacy extraction produces unreliable artifacts  
Harness changes should be explicit and traceable.  
Improvement artifacts must originate from Review findings — not from Partnering or direct requests.  
Output: agent-harness/reviews/active/REVIEW-*.md → agent-harness/improvements/active/IMPROVEMENT-*.md  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAALUlEQVR4nO3OQQ0AIAwEsAMlSJ0UrOFkGngRklZBR1WtJDsAAPzizNcDAADuNcKwAyU+nb+5AAAAAElFTkSuQmCC)  
**20. Legacy Discovery**  
Legacy Discovery turns an existing unstructured project into evidence for a new Spec Driven Development process.  
**20.1 Recommended Legacy Layout**  
repo/  
   legacy/  
     imported/  
       old-project-a/  
       old-project-b/  
   
   agent-harness/  
     legacy/  
       INVENTORY.md  
       FINDINGS.md  
       QUESTIONS.md  
       source-map/  
         FRONTEND.md  
         BACKEND.md  
         DATABASE.md  
         API.md  
         INFRASTRUCTURE.md  
         TESTS.md  
         DEPENDENCIES.md  
   
**20.2 Legacy Discovery Rules**  
The agent must:  
- not modify legacy source code  
- not implement new code  
- not treat legacy code as automatically correct  
- identify observed behavior  
- identify documented behavior  
- mark inferred intent  
- mark uncertainty  
- identify accidental complexity  
- extract candidate Use Cases  
- extract candidate Specs only when evidence is strong enough  
- never create a Spec directly without a Use Case unless evidence is unambiguous and strong  
- never mark inferred intent as observed behavior  
- propose harness improvements for architecture, tooling, validation and quality  
- record evidence paths  
**20.3 Legacy Outputs**  
Outputs may include:  
- Inventory  
- Source Map  
- Legacy Findings  
- Open Questions  
- Candidate Use Cases  
- Candidate Specs (only when evidence is strong enough)  
- Legacy Finding artifacts: agent-harness/legacy/active/LEGACY-FINDING-*.md  
- Harness Improvement candidates  
Legacy-to-Spec flow:  
legacy/imported/old-project  
 -> legacy inventory  
 -> source maps  
 -> findings  
 -> candidate use cases  
 -> specs  
 -> tasks if required  
 -> implementation plan later  
   
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANklEQVR4nO3OMQ2AABAAsSNBACPq8MH2NpGACyywEZJWQZeZ2aszAAD+4l6rrTq+ngAA8Nr1AL/KBEe6dElaAAAAAElFTkSuQmCC)  
**21. Context and Token Management**  
The harness must protect the model context.  
The agent should never load everything.  
Default context strategy:  
1. User request  
 2. Root loader file  
 3. CORE.md  
 4. Active mode file  
 5. Explicitly referenced artifact  
 6. Frontmatter links  
 7. Local SUMMARY.md if needed  
 8. Full related artifact only if required  
 9. Reference files only when affected  
 10. Archived artifacts only when explicitly needed  
   
**21.1 Context Rules**  
The agent should:  
- use the smallest sufficient context  
- start from the referenced artifact  
- avoid scanning whole directories  
- prefer frontmatter before full body when only metadata is needed  
- use local summaries before full historical artifacts  
- avoid loading archived artifacts unless needed  
- summarize findings when context becomes large  
- ask for clarification when artifact identity is ambiguous  
**21.2 Why Summaries Exist**  
SUMMARY.md files help when the target artifact is not known.  
They should not become large global indexes.  
They should be scoped by artifact type and focus on active or important items.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQmAABRAsSd4NIGJjPWxpgGsYQVvImwJtszMXp0BAPAX91pt1fH1BACA164HhZwEOFrXVOsAAAAASUVORK5CYII=)  
**22. Example End-to-End Flow**  
**22.1 From Voice Discussion to Implementation**  
1. User speaks with the agent in Partnering mode.  
2. Agent captures and clarifies the idea.  
3. Agent creates IDEA-018.  
4. Agent creates draft UC-011 if mature enough.  
5. User explicitly requests Spec creation:  
/tw-create-spec agent-harness/use-cases/active/UC-011.md  
   
1. Agent creates SPEC-021.  
2. User reviews and approves SPEC-021.  
3. User requests Tasks if required:  
/tw-create-tasks agent-harness/specs/active/SPEC-021.md  
   
1. Agent creates TASK-071, TASK-072, TASK-073.  
2. User requests implementation at Spec level:  
/tw-implement-spec agent-harness/specs/active/SPEC-021.md  
   
1. Agent checks existing Tasks and creates PLAN-009.  
2. User approves PLAN-009.  
3. Agent executes the approved plan step.  
4. Agent validates.  
5. User reviews.  
6. Review may create an Improvement artifact.  
**22.2 From Legacy Code to Spec Driven Development**  
1. Old project is copied to legacy/imported/old-project/.  
2. User starts Legacy Discovery.  
3. Agent creates inventory and source maps.  
4. Agent extracts Legacy Findings.  
5. Agent creates candidate Use Cases.  
6. Agent creates Specs where evidence is strong enough.  
7. Agent proposes harness improvements for architecture/tooling/validation.  
8. No implementation happens.  
9. Implementation later follows normal Spec Driven flow.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQ2AQBAAsSHhiQI0IWp9ngBsYIEfIWkVdJuZs5oAAPiLe6+O6vp6AgDAa+sBhYwEOqBD7p8AAAAASUVORK5CYII=)  
**23. Project Bootstrap and Adoption**  
The harness should include guidance for starting or adopting a project, but the core concept must remain stack-neutral.  
The harness does not prescribe:  
- a programming language  
- a package manager  
- a web framework  
- a test framework  
- a deployment platform  
- a monorepo tool  
- a database technology  
A new project should first be initialized using the normal tooling for its stack. After that, the Spec Driven Agent Harness is added as a process, artifact and agent-control layer.  
This keeps the core harness reusable for Python, TypeScript, Java, .NET, Rust, Go or any other technology stack.  
**23.1 What Belongs in the Core Concept**  
The core documentation should describe how to make a repository agent-ready and spec-driven.  
It should explain:  
- where root loader files live  
- where the harness directory lives  
- which mode files are required  
- which templates are useful  
- how Specs, Use Cases, Tasks and Plans are represented  
- how implementation planning works  
- where validation rules are documented  
- how stack-specific rules are connected to the harness  
- how review and harness improvement work  
It should not contain detailed instructions for initializing every possible language or framework.  
**23.2 Minimal Bootstrap Steps for a New Project**  
A new project can adopt the harness through these stack-neutral steps:  
1. Create or import the repository using the normal tooling for the chosen stack.  
2. Add root loader files:  
  - AGENTS.md  
  - CLAUDE.md  
3. Add the agent-harness/ directory.  
4. Add CORE.md.  
5. Add the required mode files under agent-harness/modes/.  
6. Add artifact templates under agent-harness/templates/.  
7. Add reference files under agent-harness/reference/.  
8. Document stack-specific commands in `agent-harness/reference/TOOLING.md` and quality standards in `agent-harness/reference/QUALITY.md`.  
9. Document architecture boundaries in ARCHITECTURE.md — including a "Technical Artifacts" section that declares where project-specific technical specs live (OpenAPI, schemas, contracts). Agents use this when resolving `technical_refs` without a Spec in hand.  
10. Document domain rules in DOMAIN.md.  
11. Create the first Use Case, Spec or Legacy Discovery artifact.  
12. Create or approve an Implementation Plan before coding starts.  
The harness should be introduced as early as possible, but it can also be added to an existing repository later.  
**23.3 What Belongs in Stack-Specific Guides**  
Concrete technical setup instructions should live in optional stack-specific guides.  
Examples:  
agent-harness/guides/  
   BOOTSTRAP-python-uv.md  
   BOOTSTRAP-node.md  
   BOOTSTRAP-java.md  
   BOOTSTRAP-dotnet.md  
   BOOTSTRAP-rust.md  
   
These guides may describe:  
- how to initialize the language project  
- package manager setup  
- workspace or monorepo setup  
- test framework setup  
- linting and formatting  
- type checking  
- local development commands  
- Docker or deployment conventions  
- CI setup  
- stack-specific validation commands  
For example, a Python/uv guide may describe:  
- uv init  
- uv workspace  
- .python-version  
- pyproject.toml  
- ruff  
- pytest  
- mypy  
- package-specific validation commands  
A Node guide may describe:  
- pnpm or npm  
- workspace layout  
- TypeScript configuration  
- ESLint  
- Vitest/Jest  
- build scripts  
These guides are optional. They are not required for the harness concept itself.  
**23.4 Modes Are Universal. References Are Project-Specific.**  
This is the central structural principle of the harness.  
  
Mode files (`agent-harness/modes/`) define universal process rules. They must not contain stack-specific commands, tool names, or technology choices. The same mode files work for Python, TypeScript, Java, Rust, or any other stack without modification.  
  
Reference files (`agent-harness/reference/`) are project-specific. They define the concrete details that vary per project.  
  
- `agent-harness/reference/TOOLING.md` — commands, tools, package manager, workspace setup  
- `agent-harness/reference/QUALITY.md` — quality standards, definition of done, coverage expectations  
- `agent-harness/reference/ARCHITECTURE.md` — system boundaries, layers, deployment structure  
- `agent-harness/reference/DOMAIN.md` — domain concepts, rules, actors, invariants  
- `agent-harness/guides/` — optional bootstrap and setup guides per stack  
  
Stack-specific rules must never be placed in mode files. Mode files may reference the relevant reference file instead.  
For example: VALIDATION.md (mode) says "run the checks defined in QUALITY.md and TOOLING.md" — it does not list the commands itself.  
**23.5 Bootstrap for Existing Projects**  
When the project already exists, do not force an immediate rewrite.  
Use the adoption path:  
existing project  
 -> add root loader files  
 -> add minimal harness  
 -> document current tooling and validation  
 -> create or import initial Specs  
 -> optionally run Legacy Discovery  
 -> move toward Spec Driven Development incrementally  
   
For existing projects that were not built with this process, use Legacy Discovery mode rather than directly rewriting code.  
The existing codebase should be treated as evidence. It may help derive:  
- Use Cases  
- Specs  
- architecture rules  
- tooling rules  
- validation expectations  
- quality expectations  
- migration risks  
**23.6 Bootstrap Principle**  
The harness should define the development process, not the technology stack.  
Stack-specific setup belongs in optional guides.  
The core concept should remain stable across stacks.  
**24. Minimal Adoption Path**  
The harness can be introduced gradually.  
**Phase 1: Minimal Agent-Ready Repo**  
AGENTS.md  
 CLAUDE.md  
 agent-harness/CORE.md  
 agent-harness/modes/IMPLEMENTATION.md  
 agent-harness/modes/VALIDATION.md  
   
**Phase 2: Spec Driven Artifacts**  
Add:  
use-cases/  
 specs/  
 implementation-plans/  
   
**Phase 3: Tasks When Needed**  
Add:  
tasks/  
 TASK-template.md  
 task decision rules  
   
**Phase 4: Partnering and Ideas**  
Add:  
PARTNERING.md  
 ideas/  
 transcripts/  
   
**Phase 5: Review and Improvement**  
Add:  
reviews/  
 improvements/  
 REVIEW.md  
 IMPROVEMENT.md  
   
**Phase 6: Legacy Discovery**  
Add:  
LEGACY-DISCOVERY.md  
 legacy/  
 source-map/  
 legacy findings  
   
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQ2AQBAAsSE5CbzRujLwhwQMYIEfIWkVdJuZozoDAOAvrlWtav96AgDAa/cDEXQEKquakOYAAAAASUVORK5CYII=)  
**25. Final Design Principles**  
The harness should remain:  
- file-based  
- explicit  
- traceable  
- mode-aware  
- artifact-centric  
- context-efficient  
- safe by default  
- reviewable  
- suitable for both greenfield and legacy-driven development  
The most important rules are:  
1. Partnering may create Ideas and Use Case drafts, but not Specs, Tasks or Code.  
2. Specs define desired behavior.  
3. Tasks are optional execution units, required when complexity or risk demands them.  
4. Implementation always requires a plan.  
5. Implementation Plans may target a Task, Spec or Use Case.  
6. Plans must be accepted before code changes.  
7. Voice is an input channel, not a workflow mode.  
8. Natural-language commands may trigger modes when intent is explicit.  
9. Artifacts use YAML frontmatter for metadata and traceability.  
10. Normalized artifacts are written in English.  
11. Avoid global God-indexes.  
12. Use local summaries and frontmatter links for navigation.  
13. Legacy projects are evidence, not authority.  
14. Reviews feed Harness Improvements.  
15. The harness itself evolves through explicit, reviewed changes.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQmAABRAsSfYxKK/kJXEkyE8WcGbCFuCLTOzVXsAAPzFsVZ3dX4cAQDgvesB/vEF9H9odtUAAAAASUVORK5CYII=)  
**26. Glossary**  
**Artifact**  
A Markdown file representing a structured unit of work or knowledge, such as an Idea, Use Case, Spec, Task, Plan, Review or Improvement.  
**Mode**  
A bounded agent behavior profile that defines what the agent may do.  
**Partnering**  
Conversational mode for capture, clarification and idea formation.  
**Spec**  
The source of truth for desired behavior.  
**Task**  
An optional executable work unit derived from a Spec when smaller traceable slices are needed.  
**Implementation Plan**  
A required plan that defines how implementation will proceed before code is changed.  
**Review**  
A structured assessment of an artifact, implementation or process result.  
**Harness Improvement**  
A controlled change to the harness itself, usually derived from Review findings.  
**Legacy Discovery**  
A mode for analyzing existing code and documentation to derive artifacts without implementing.  
**Frontmatter**  
YAML metadata at the top of Markdown artifacts used for IDs, status, traceability and context loading.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSPBCUZfE2IYmVDBhAU2QtIq6DIzW7UHAMBfnGt1V8fXEwAAXrse/xcF7U7sx4wAAAAASUVORK5CYII=)  
End of document.  
