# IMPROVING-HARNESS Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| IMPR-01-010 | Scope | MAY apply approved changes by default to: any file under `agent-harness/`; `.claude/skills/harness/`, `.agents/skills/harness/`, and `.github/agents/` (the per-agent CLI entry-point layers); and root-level `AGENTS.md`/`CLAUDE.md`/`.github/copilot-instructions.md` (the harness's loader files). |
| IMPR-01-011 | Scope | Other files MAY change too when the Improvement explicitly calls for it. |
| IMPR-01-020 | Scope | MUST mirror a change to one entry-point layer across the others unless it's agent-specific. |
| IMPR-02-020 | Boundaries | Harness changes MUST be explicit and approved. |
| IMPR-02-025 | Boundaries | The agent MUST NOT infer approval or approve an Improvement on its own (this is `COR-01-090` applied to Improvement artifacts specifically). A general instruction to improve the harness is not approval of any specific `IMPROVEMENT-NNN`; approval is valid only after the user has had the chance to see that artifact's own proposed change. |
| IMPR-02-026 | Boundaries | The agent MUST perform the `proposed` -> `approved` transition, including `approval.approved_by`/`approved_at`, when the user explicitly instructs it to do so. |
| IMPR-02-027 | Boundaries | MUST NOT apply an Improvement's target-file changes before that specific approval exists. |
| IMPR-02-030 | Boundaries | Target files MUST be listed in frontmatter. |
| IMPR-02-040 | Boundaries | MUST NOT create Improvement artifacts from Partnering — only from Review findings. |
| IMPR-05-010 | Rule-ID-Audit | An approved Improvement that touches rule IDs or Rules-table placement MUST satisfy `CORE.md`'s `COR-10-060`–`COR-10-063` before it can be set to `done`. |
| IMPR-05-020 | Rule-ID-Audit | A `COR-10-060` citation audit MUST cover at minimum: `agent-harness/`, `harness-data/reference/`, root loader files (`AGENTS.md`, `CLAUDE.md`, and future equivalents), and entry-point wrapper layers (`.claude/skills/harness/`, `.agents/skills/harness/`, and future `.github/` Copilot wrapper paths when present). |
| IMPR-05-030 | Rule-ID-Audit | The Improvement's `## Validation Result` MUST report the scan roots used, duplicate-definition result, dangling-citation result, and whether before-and-after audit evidence was required by `COR-10-061`. |
| IMPR-05-040 | Rule-ID-Audit | Improving-Harness mode MUST NOT create `agent-harness/tools/`, generated rule indexes, or other repo-local validation artifacts to satisfy `COR-10-060`; future automation belongs in a separate template-repository Improvement. |
