# PARTNERING Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| PTN-01-010 | Scope | Input channel (voice, chat, or text) MUST NOT change what the agent may do in Partnering mode — the input mechanism is not itself a mode. |
| PTN-02-010 | Responsibilities | MUST listen first and capture relevant statements. |
| PTN-02-030 | Responsibilities | MUST separate problem, goal, solution idea, and assumption. |
| PTN-02-040 | Responsibilities | MUST ask focused clarification questions. |
| PTN-02-050 | Responsibilities | MUST identify candidate ideas. Full rules (readiness gate, dedup, boundaries) live in `agent-harness/artifact-specs/IDEA.md`, not here. |
| PTN-02-060 | Responsibilities | MUST summarize intermediate understanding. |
| PTN-02-070 | Responsibilities | MUST mark uncertainty explicitly. |
| PTN-02-100 | Responsibilities | MUST identify a candidate ADR when the conversation reaches a settled structural or architectural decision. Full rules live in `agent-harness/artifact-specs/ADR.md`, not here. |
| PTN-02-110 | Responsibilities | MUST route to Refining or Planning-Implementation, per `PARTNERING.md`'s `## Routing`, when enough material exists to act on — not only when a Use Case is warranted. Partnering still does not draft the artifact itself (see `USE-CASES.md`, `REFINING.md`). |
| PTN-02-111 | Responsibilities | If the material being routed already carries a `## Risk-Tier Classification` (an Idea already classified per `IDA-05-020` in an earlier session, or a partial classification recorded from earlier in this same routing decision), MUST reuse that result per `shared-procs/RISK-TIER.md`'s `RSK-07-011`/`RSK-07-012` instead of recomputing it. |
| PTN-02-112 | Responsibilities | Otherwise MUST run `RISK-TIER.md`'s cascade in order — UC-Necessity (`RSK-02-010`), then, only if UC is not required, Spec-Necessity (`RSK-03-010`), then, only if Spec is not required, Task-Necessity (`RSK-04-010`) — per `RSK-07-020`'s full-cascade-completion rule. |
| PTN-02-113 | Responsibilities | MUST NOT stop after UC-Necessity or Spec-Necessity alone and default to `/create-spec` or `/create-tasks` on that basis. |
| PTN-03-010 | Transcript | The agent, not the user, MUST create transcripts — write a `TRANSCRIPT-*.md` proactively, capturing the conversation as it unfolds. Lifecycle rules (status transitions, Updating) live in `agent-harness/artifact-specs/TRANSCRIPT.md`, not here. |
| PTN-04-010 | Mode-Transition | Partnering MUST NOT end except when the user explicitly requests a mode change — a direct instruction to implement, fix, or make a specific described change also counts as an explicit mode-change request once `PTN-02-110`'s classification determines which entry point it maps to; it need not name a specific artifact type (Use Case, Spec, Task, or Plan) itself. A vague statement about maybe doing something later still does not qualify (`PTN-04-020` is unchanged). |
| PTN-04-020 | Mode-Transition | MUST clarify before changing mode when the intent is ambiguous — a vague statement like "we should maybe make a spec later" does not trigger Spec mode. |
| PTN-05-010 | Boundaries | MUST NOT create the following artifacts directly: Use Cases, Specs, Tasks, or Implementation Plans — route per `PTN-02-110`'s classification. |
| PTN-05-015 | Boundaries | MUST NOT modify code. |
| PTN-05-060 | Boundaries | MUST NOT treat raw transcript as final requirement. |
