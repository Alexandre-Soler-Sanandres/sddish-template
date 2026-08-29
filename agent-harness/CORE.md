# CORE.md

## Purpose

Universal harness contract and loader guidance that apply in every mode. Use the smallest sufficient context
throughout; the concrete enforceable rules live in the grouped CORE rules files below. Canonical harness file
taxonomy terms live in `agent-harness/docs/08-glossary.md`.

## Rules Map

Load the groups needed for the current action. When the relevant group is unclear, or when editing/auditing
rules or making a broad harness change, load every CORE rule group.

| Rule group | File | Load when |
| --- | --- | --- |
| Universal | `agent-harness/rules/CORE/UNIVERSAL.md` | Always with `CORE.md`; also for artifact traceability, approvals, secrets, implementation boundaries, Question/Idea routing, and status cascade effects. |
| Artifact-Language | `agent-harness/rules/CORE/ARTIFACT-LANGUAGE.md` | Creating or updating normalized artifacts, transcripts, raw input, or quoted source material. |
| Context-Loading | `agent-harness/rules/CORE/CONTEXT-LOADING.md` | Always with `CORE.md`; also for checkpoint setup, paired rules loading, mode transitions, delegation, and context expansion. |
| Support-Files | `agent-harness/rules/CORE/SUPPORT-FILES.md` | Considering guides, universal playbooks, or project playbooks. |
| Checkpoint | `agent-harness/rules/CORE/CHECKPOINT.md` | Before high-impact actions, before stopping, before committing, after resume/compaction, and on true Mode transitions. |
| Observability | `agent-harness/rules/CORE/OBSERVABILITY.md` | Recording run logs, continuation notes, validation trace, or implementation gate-check state. |
| Pause-Resume | `agent-harness/rules/CORE/PAUSE-RESUME.md` | Pausing interrupted work or resuming prior work. |
| Commits | `agent-harness/rules/CORE/COMMITS.md` | Whenever a commit is requested or considered. |
| High-Risk | `agent-harness/rules/CORE/HIGH-RISK.md` | Database, security/secrets/auth, deployment/infrastructure, payment/financial, or domain-critical logic work. |
| Rule-Authoring | `agent-harness/rules/CORE/RULE-AUTHORING.md` | Creating, editing, moving, deleting, citing, or auditing rules; also when reviewing prose-only enforceable intent. |

Files under `agent-harness/rules/` do not recursively pair to other rules files. For the full pairing convention,
see `COR-03-045` in `agent-harness/rules/CORE/CONTEXT-LOADING.md`.

## Related Systems

Some harness behavior emerges from several rules and artifacts interacting rather than living in one file. Load
the relevant System under `agent-harness/systems/` when the current action touches one of these cross-file
mechanisms — per `COR-03-048`, this is normal context expansion, not part of the initial load block:

| System | File | Load when |
| --- | --- | --- |
| Status Transitions | `agent-harness/systems/STATUS-TRANSITIONS.md` | A Use Case/Spec/Task/Plan/Idea promotes, completes, reopens, or its terminal status might now be stale. |
| Question Lifecycle | `agent-harness/systems/QUESTION-LIFECYCLE.md` | Raising, carrying forward, or resolving a Question that other artifacts cite. |
| ADR Authority | `agent-harness/systems/ADR-AUTHORITY.md` | Citing, re-checking, or superseding an ADR. |
| Lifecycle Folders | `agent-harness/systems/LIFECYCLE-FOLDERS.md` | Moving an artifact between lifecycle subfolders, or judging whether a folder move is actually due. |

## Work Lanes

Classify new material work through `agent-harness/shared-procs/WORK-LANES.md` before planning or execution.
Fast work uses an in-session micro-plan, Standard work uses an approved Change Spec, and Assured work uses the
full behavior-contract and execution-plan structure. Active v1 UC/Spec/Task/Plan chains remain under their
recorded v1 contract until reopened or explicitly migrated.
