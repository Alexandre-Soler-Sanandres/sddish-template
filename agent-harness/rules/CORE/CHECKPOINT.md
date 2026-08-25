# CORE / Checkpoint Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| COR-05-010 | Checkpoint | MUST verify the active mode, restart artifact, explicit user authorization, in-scope files, and required validation before any high-impact action, before stopping or committing. |
| COR-05-020 | Checkpoint | MUST treat these as high-impact actions: committing; changing harness mode files, templates, or reference process rules; creating Review or Improvement artifacts; moving artifacts between lifecycle folders (see `agent-harness/systems/LIFECYCLE-FOLDERS.md` for why that move is never a bare housekeeping step). Discovering-Legacy mode adds its own high-impact actions on top of this list — see `agent-harness/modes/DISCOVERING-LEGACY.md`. |
| COR-05-030 | Checkpoint | MUST repeat the checkpoint (`COR-05-010`) and re-read `CORE.md` and the active true-Mode file in full before the next high-impact action, after a resume or context compaction — the checkpoint verifies state, not rule text, so confirming mode identity alone is not enough. |
| COR-05-040 | Checkpoint | MUST re-read the newly-active mode file in full before taking any mode-specific action, on a true Mode transition (per `COR-03-040`'s list — not every artifact-producing action). |
