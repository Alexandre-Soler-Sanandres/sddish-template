# CATALOG.md

## Purpose

`harness-data/CATALOG.md` is the generated project index. This file only explains its source and rendering
contract; it is not a writable project catalog.

## Contract

The renderer derives the Catalog exclusively from canonical artifact frontmatter and the Questions registry. It
sorts entries by ID and replaces the output atomically. A Catalog contains no project-authored notes, marker
regions, or canonical metadata. `active-plans`, `backlinks <ID>`, and `trace <ID>` are ephemeral queries over
canonical flat artifacts; Plan transitions never edit the Catalog.

An Extension's artifact locations (e.g. `harness-data/extensions/legacy-discovery/` for the Legacy Discovery Extension)
appear in the Catalog only when `harness-data/HARNESS-PROFILE.yaml` sets `extensions.<name>: enabled`; a
disabled Extension contributes nothing.

## Loading

Start from an explicitly named artifact. Use the generated project Catalog only when the artifact's stable type
root is unknown. Do not use a Catalog as authority for status, links, approval, or requirements.

## Commands

- `scripts/render-harness-views.sh harness-data catalog` atomically refreshes the convenience index.
- `scripts/render-harness-views.sh harness-data active-plans` derives active Plan coordination data.
- `scripts/render-harness-views.sh harness-data plan-conflicts` reports same-source and overlapping-path conflicts.
- `scripts/render-harness-views.sh harness-data backlinks ID` finds incoming canonical forward links.
- `scripts/render-harness-views.sh harness-data trace ID` traverses the connected canonical trace graph.
