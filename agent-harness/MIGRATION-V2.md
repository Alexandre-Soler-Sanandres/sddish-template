# Harness v2 Cutover

Version 2 is the only runtime model. Work is classified as Fast, Standard, or Assured by
`shared-procs/WORK-LANES.md`; lifecycle status is frontmatter on stable files; Questions are rows in the single
registry; and canonical relationships are forward ID links.

The former v1 lifecycle folders, status-split Questions files, paired rules, validation shim, and Legacy
Discovery bridge are retired. Historical migration evidence remains in
`harness-data/HARNESS-V1-TO-V2-MIGRATION.md`; it is not a runtime input.

Rollback is restoration of the pre-cutover commits recorded in that ledger. Do not partially restore retired
runtime surfaces.

The Legacy Discovery extension remains available when enabled in `harness-data/HARNESS-PROFILE.yaml`; its data
lives under `harness-data/extensions/legacy-discovery/`.
