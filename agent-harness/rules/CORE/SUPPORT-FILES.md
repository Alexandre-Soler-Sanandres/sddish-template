# CORE / Support-Files Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-04-010 | Support-Files | MUST consult `agent-harness/playbooks/index.yaml` before loading universal playbooks broadly. |
| COR-04-020 | Support-Files | MUST consult `harness-data/playbooks/index.yaml` before loading project playbooks broadly. |
| COR-04-030 | Support-Files | MUST consult `harness-data/guides/index.yaml` before loading guides broadly. |
| COR-04-040 | Support-Files | MUST NOT inspect an entire support-file folder when its index is sufficient — load only the matched support files needed for the current task. |
| COR-04-050 | Support-Files | MUST follow the universal playbook for the generic procedure and the project playbook for repo-local refinement when both apply. |
| COR-04-060 | Support-Files | Guides provide local operating context; MUST NOT be treated as replacing procedural instructions from playbooks. |
| COR-04-070 | Support-Files | Playbooks and guides MUST NOT override core rules, mode boundaries, or explicit approval gates. |
