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
| PTN-02-110 | Responsibilities | MUST classify new material work through `WORK-LANES.md` and route it by lane when enough material exists to act on; active v1 chains MUST retain their recorded Risk-Tier route. Partnering still does not draft the downstream artifact itself. |
| PTN-02-111 | Responsibilities | If the material being routed already carries a `## Risk-Tier Classification` (an Idea already classified per `IDA-05-020` in an earlier session, or a partial classification recorded from earlier in this same routing decision), MUST reuse that result per `shared-procs/RISK-TIER.md`'s `RSK-07-011`/`RSK-07-012` instead of recomputing it. |
| PTN-02-112 | Responsibilities | Otherwise MUST run `RISK-TIER.md`'s cascade in order — UC-Necessity (`RSK-02-010`), then, only if UC is not required, Spec-Necessity (`RSK-03-010`), then, only if Spec is not required, Task-Necessity (`RSK-04-010`) — per `RSK-07-020`'s full-cascade-completion rule. |
| PTN-02-113 | Responsibilities | MUST NOT stop after UC-Necessity or Spec-Necessity alone and default to `/create-spec` or `/create-tasks` on that basis. |
| PTN-03-010 | Transcript | MUST create a Transcript only on user request or when durable provenance, audit, or long-running handoff value requires it; otherwise MUST retain only concise continuation context. |
| PTN-04-010 | Mode-Transition | Partnering MUST NOT end except when the user explicitly requests a mode change — a direct instruction to implement, fix, or make a specific described change also counts as an explicit mode-change request once `PTN-02-110`'s classification determines which entry point it maps to; it need not name a specific artifact type (Use Case, Spec, Task, or Plan) itself. A vague statement about maybe doing something later still does not qualify (`PTN-04-020` is unchanged). |
| PTN-04-020 | Mode-Transition | MUST clarify before changing mode when the intent is ambiguous — a vague statement like "we should maybe make a spec later" does not trigger Spec mode. |
| PTN-05-010 | Boundaries | MUST NOT create a downstream execution artifact directly from Partnering; MUST route Standard work to Change Spec and Assured work to the relevant behavior/execution artifact path per `PTN-02-110`. |
| PTN-05-015 | Boundaries | MUST NOT modify code. |
| PTN-05-060 | Boundaries | MUST NOT treat raw transcript as final requirement. |
