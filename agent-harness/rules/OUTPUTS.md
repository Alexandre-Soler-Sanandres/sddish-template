# OUTPUTS Rules

## Rules

| ID | Type | Rule |
| --- | --- | --- |
| OUT-01-010 | Format | All lifecycle artifacts MUST use YAML frontmatter for metadata and Markdown for the body. |
| OUT-02-010 | Scope | `agent-harness/README.md` is the harness overview, not a lifecycle artifact. |
| OUT-02-020 | Scope | MUST NOT create directory-scoped README files as harness artifacts — use mode files, templates, `CATALOG.md`, and scoped restart artifacts (`SOURCE-MAP.md`, `SUMMARY.md`) for harness guidance instead. |
| OUT-03-010 | Naming | Artifact filenames MUST follow the canonical naming patterns in `OUTPUTS.md`'s `## File Naming Conventions`. |
| OUT-03-020 | Naming | IDs MUST remain stable even if filenames or folders change. |
| OUT-04-010 | Lifecycle | New artifacts MUST be created in `active/` unless a mode explicitly defines a different starting location. |
| OUT-04-020 | Lifecycle | MUST move artifacts between lifecycle subfolders as their status changes, without renaming the file ID. |
| OUT-05-010 | Improvement-Lifecycle | For Improvements, `done/` means the approved target changes are applied and the artifact records a `## Validation Result` confirming what was checked. |
| OUT-06-010 | Legacy-Discovery | Legacy Discovery artifacts MUST use the scoped folder structure defined in `OUTPUTS.md`'s `## Legacy Discovery Structure`. |
| OUT-07-010 | ADR-Lifecycle | ADRs use `proposed/` / `accepted/` / `archive/` instead of the generic `active/`/`archive/` pair — see `OUTPUTS.md`'s `## Folder Structure`. |
| OUT-08-010 | Questions-Lifecycle | The Questions registry does not use lifecycle subfolders. It is three flat files under `harness-data/artifacts/questions/`; a row's file *is* its status — see `agent-harness/artifact-specs/QUESTIONS.md`. |
