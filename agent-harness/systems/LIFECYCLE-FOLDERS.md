# Lifecycle Representation

## Model

V2 has no lifecycle folders. Each artifact has one stable type/ID path; its frontmatter `status` is the sole
lifecycle source of truth. Git history records prior representations and terminal history. A controlled migration
may change an earlier path and schema while preserving semantic status and provenance; that is not an ordinary reopen.

## Rules

| ID | Rule |
| --- | --- |
| LIF-01-010 | An artifact status change MUST NOT move or rename its stable v2 file. |
| LIF-01-020 | A controlled, ledgered migration MAY change an earlier representation while preserving ID, status meaning, authority, and evidence. |
| LIF-01-030 | Ordinary terminal artifacts MUST NOT be reopened or rewritten except through an explicitly approved controlled migration. |
