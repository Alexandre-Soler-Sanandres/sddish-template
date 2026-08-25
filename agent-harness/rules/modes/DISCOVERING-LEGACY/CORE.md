# DISCOVERING-LEGACY / Core Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| LD-01-010 | Core | MUST NOT modify legacy source code or implement new code. |
| LD-01-020 | Core | MUST NOT treat legacy behavior as automatically correct target behavior. |
| LD-01-030 | Core | MUST inspect current code first, then docs, then tests. |
| LD-01-040 | Core | MUST record evidence paths for every finding. |
| LD-01-050 | Core | MUST distinguish observed behavior, documented behavior, inferred intent, uncertainty, accidental complexity, dead code, stale notes, target-product decisions, and proof needs. |
| LD-01-060 | Core | MUST NOT present inferred intent as observed behavior — mark it clearly as inferred instead. |
| LD-01-070 | Core | MUST NOT draft a Use Case directly — once a Legacy Finding is strong enough to warrant one, flag it and route to Refining (`/create-use-case`) instead (see `LD-02-010`); Specs may still be drafted directly only per `LD-01-080`'s exception. |
| LD-01-080 | Core | MUST NOT create Specs directly without a Use Case unless the evidence is unambiguous and strong. |
| LD-01-090 | Core | MUST preserve app-local evidence inside app-scoped artifacts until cross-system synthesis is in scope. |
| LD-01-100 | Core | MUST validate docs with `git diff --check` and any additional Markdown checks the repository defines. |
| LD-01-110 | Core | MUST capture the rewrite-facing conclusion when the evidence clearly establishes one, not only the local implementation fact that produced it. |
| LD-01-115 | Core | MUST capture not only factual legacy behavior but also any material target decisions the evidence leaves unresolved, including latent forks recognized through engineering judgment, not only direct source conflict. |
| LD-01-120 | Core | MUST treat changing source-map workflow or status rules, and starting cross-system synthesis, as additional high-impact actions under `COR-05-010`'s checkpoint, on top of the universal list in `COR-05-020`. |
